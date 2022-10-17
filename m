Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5552600838
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJQH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJQH7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:59:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C145B525;
        Mon, 17 Oct 2022 00:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NNyhKS1LpdHKzGlhsSngZkfLfmvQiTMJTVobRoTSZr8=; b=ux+1aQMqtNdH6h0aSC/KxZ2E5O
        cRRvPau+voI+2jeHHXNSL9fcb0xU1JN8x1oFbPzyBRBBqVR2BKejLIED+mDhXoR+2K5Wh2WC11FM+
        UR4PNu7hZ9jsaB4FueNdRkgHxSGitQfNbROvuC+OKhPb3YBXz0Dml/4vwXx94w1iZ7k6ZGyg8oyxz
        SE4htmF/4joPg3bF7k40oEXNCsMEGYQOj3Q3F79i+IIG4ez37VtWLpV6eQabiZrLV7aETiOgbZCK4
        ZnqHBOgLLHpJuKnqOc+q6PSf1VNtBklnKXwuk+6/BsGfOdrRaWFpnnzpyAi9uzeYwUB88bVjsKTwu
        0Xv+qGVg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okL1g-008knX-Ld; Mon, 17 Oct 2022 07:59:08 +0000
Date:   Mon, 17 Oct 2022 00:59:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, gregkh@linuxfoundation.org, willy@infradead.org,
        kch@nvidia.com, martin.petersen@oracle.com,
        johannes.thumshirn@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH RFC] block: fix use after free for bd_holder_dir/slave_dir
Message-ID: <Y00LTH0yk3obS22m@infradead.org>
References: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012125838.1608619-1-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAICS the problem is the that pre-registered holders don't get
unregistered for a late add_disk failure.

Something like this should fix your error:

diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423df..6123005154b2a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -484,7 +484,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 	ret = blk_register_queue(disk);
 	if (ret)
-		goto out_put_slave_dir;
+		goto out_unregister_holders;
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		ret = bdi_register(disk->bdi, "%u:%u",
@@ -526,6 +526,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		bdi_unregister(disk->bdi);
 out_unregister_queue:
 	blk_unregister_queue(disk);
+out_unregister_holders:
+	bd_unregister_all_holders(disk);
 out_put_slave_dir:
 	kobject_put(disk->slave_dir);
 out_put_holder_dir:
diff --git a/block/holder.c b/block/holder.c
index 5283bc804cc14..12c09d5c21280 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -169,3 +169,13 @@ int bd_register_pending_holders(struct gendisk *disk)
 	mutex_unlock(&disk->open_mutex);
 	return ret;
 }
+
+void bd_unregister_all_holders(struct gendisk *disk)
+{
+	struct bd_holder_disk *holder;
+
+	mutex_lock(&disk->open_mutex);
+	list_for_each_entry(holder, &disk->slave_bdevs, list)
+		__unlink_disk_holder(holder->bdev, disk);
+	mutex_unlock(&disk->open_mutex);
+}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 50e358a19d986..ccab9a2dae4bd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -840,6 +840,7 @@ void set_capacity(struct gendisk *disk, sector_t size);
 int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk);
 void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk);
 int bd_register_pending_holders(struct gendisk *disk);
+void bd_unregister_all_holders(struct gendisk *disk);
 #else
 static inline int bd_link_disk_holder(struct block_device *bdev,
 				      struct gendisk *disk)
@@ -854,6 +855,9 @@ static inline int bd_register_pending_holders(struct gendisk *disk)
 {
 	return 0;
 }
+static inline void bd_unregister_all_holders(struct gendisk *disk)
+{
+}
 #endif /* CONFIG_BLOCK_HOLDER_DEPRECATED */
 
 dev_t part_devt(struct gendisk *disk, u8 partno);
