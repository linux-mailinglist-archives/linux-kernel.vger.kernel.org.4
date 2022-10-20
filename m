Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D76060C7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJTM7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJTM64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:58:56 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253521CCCC2;
        Thu, 20 Oct 2022 05:58:53 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtSMl4CnJzHv5y;
        Thu, 20 Oct 2022 20:58:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:58:49 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:58:48 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <axboe@kernel.dk>, <hch@lst.de>, <willy@infradead.org>,
        <kch@nvidia.com>, <martin.petersen@oracle.com>,
        <johannes.thumshirn@wdc.com>, <yukuai3@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>
Subject: [PATCH -nect RFC v2 1/2] block: add helpers for bd_holder_dir refcount management
Date:   Thu, 20 Oct 2022 21:20:48 +0800
Message-ID: <20221020132049.3947415-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221020132049.3947415-1-yukuai3@huawei.com>
References: <20221020132049.3947415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the lifecycle of bd_holder_dir is problematic, it can be freed
in del_gendisk() while it can still be accessed before disk_release().
And there in no way to know if the kobject if freed by kobject_put() for
now, thus add a new field in bloce_device to manage refcount of
bd_holder_dir seperately.

Prepare to fix the problem in following patch.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk.h               |  3 +++
 block/genhd.c             | 27 +++++++++++++++++++++++++++
 include/linux/blk_types.h |  1 +
 3 files changed, 31 insertions(+)

diff --git a/block/blk.h b/block/blk.h
index d6ea0d1a6db0..fef868b4169c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -458,6 +458,9 @@ extern const struct address_space_operations def_blk_aops;
 int disk_register_independent_access_ranges(struct gendisk *disk);
 void disk_unregister_independent_access_ranges(struct gendisk *disk);
 
+bool bd_try_get_holder_dir(struct block_device *bdev);
+void bd_put_holder_dir(struct block_device *bdev);
+
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 bool should_fail_request(struct block_device *part, unsigned int bytes);
 #else /* CONFIG_FAIL_MAKE_REQUEST */
diff --git a/block/genhd.c b/block/genhd.c
index 17b33c62423d..53f9c8b2690a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -375,6 +375,33 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
 	return 0;
 }
 
+bool bd_try_get_holder_dir(struct block_device *bdev)
+{
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (!bdev->holder_dir_ref) {
+		mutex_unlock(&bdev->bd_disk->open_mutex);
+		return false;
+	}
+
+	bdev->holder_dir_ref++;
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+	return true;
+}
+
+void bd_put_holder_dir(struct block_device *bdev)
+{
+	mutex_lock(&bdev->bd_disk->open_mutex);
+	if (WARN_ON(bdev->holder_dir_ref <= 0))
+		goto out;
+
+	if (!(--bdev->holder_dir_ref)) {
+		kobject_put(bdev->bd_holder_dir);
+		bdev->bd_holder_dir = NULL;
+	}
+out:
+	mutex_unlock(&bdev->bd_disk->open_mutex);
+}
+
 /**
  * device_add_disk - add disk information to kernel list
  * @parent: parent device for the disk
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index e0b098089ef2..550c8e15af49 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -53,6 +53,7 @@ struct block_device {
 	int			bd_holders;
 	bool			bd_write_holder;
 	struct kobject		*bd_holder_dir;
+	int			holder_dir_ref;
 	u8			bd_partno;
 	spinlock_t		bd_size_lock; /* for bd_inode->i_size updates */
 	struct gendisk *	bd_disk;
-- 
2.31.1

