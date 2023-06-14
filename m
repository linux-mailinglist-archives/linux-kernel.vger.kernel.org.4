Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE66730114
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245317AbjFNOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245264AbjFNOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:01:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14219A;
        Wed, 14 Jun 2023 07:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cUPWTRyD6KgConRvc/LzTbU+jQN8JxfjvL3UpIyXkeM=; b=NodLVcgJ1NXwF37xa71v0LeCgL
        QwCltgPLEdPtIhwT7ovBuinlI+NjgDmuppsqrL5ZJwh4EknK7qM8znLme5kOfiJHpoji+aiYT9iDZ
        NdcrHcz0BNtrRJ679hKdInCKU7PuPxkrVRWrdIUFBLmyxf9+3CnyMTouyRP2493eMqUeiP410+G+2
        /uFLTDI/Re80AMP9x20SHyQSeCAG3vW9mBib778IK9QDFs2WVH1rAaIhflvWk6XMrbR6eIkY9Qkcd
        2IpaYW3w+oiKk7IBCM86K20Xo6Fj2kE0BX7RKUU73k2GjBI4Y6tYPm5mGDC/rLZ2lxLfz+V8VkOTG
        aqu6HM8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9R3p-00BqmJ-08;
        Wed, 14 Jun 2023 14:01:21 +0000
Date:   Wed, 14 Jun 2023 07:01:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Jain, Ayush" <Ayush.Jain3@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Karny, Wyes" <Wyes.Karny@amd.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "V, Narasimhan" <Narasimhan.V@amd.com>,
        "Shetty, Kalpana" <Kalpana.Shetty@amd.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>
Subject: Re: Kernel null pointer dereference on stopping raid device
Message-ID: <ZInIMLlMby2aNNr1@infradead.org>
References: <e78344ad-8d57-91d8-0bfb-724c740c7c72@amd.com>
 <3c4911c4-d3d7-a93e-5f14-e97384ae4f21@amd.com>
 <ZIlqvsZ6nMv2OT2u@infradead.org>
 <IA1PR12MB61375A452083D65B5FB815DBBA5AA@IA1PR12MB6137.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR12MB61375A452083D65B5FB815DBBA5AA@IA1PR12MB6137.namprd12.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 09:54:07AM +0000, Jain, Ayush wrote:
> Patch applied cleanly on next-20230614 and resolved the issue.
> 
> Reported-by: Ayush Jain <ayush.jain3@amd.com>
> Tested-by: Ayush Jain <ayush.jain3@amd.com>

That was just a quick hack to verify the problem.  I think this is
the proper fix, can you try it as well?

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ca0de7ddd9434d..da523e80a4e990 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2467,10 +2467,12 @@ static void export_rdev(struct md_rdev *rdev, struct mddev *mddev)
 
 static void md_kick_rdev_from_array(struct md_rdev *rdev)
 {
-	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
+	struct mddev *mddev = rdev->mddev;
+
+	bd_unlink_disk_holder(rdev->bdev, mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
-	mddev_destroy_serial_pool(rdev->mddev, rdev, false);
+	mddev_destroy_serial_pool(mddev, rdev, false);
 	rdev->mddev = NULL;
 	sysfs_remove_link(&rdev->kobj, "block");
 	sysfs_put(rdev->sysfs_state);
@@ -2488,7 +2490,7 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	INIT_WORK(&rdev->del_work, rdev_delayed_delete);
 	kobject_get(&rdev->kobj);
 	queue_work(md_rdev_misc_wq, &rdev->del_work);
-	export_rdev(rdev, rdev->mddev);
+	export_rdev(rdev, mddev);
 }
 
 static void export_array(struct mddev *mddev)
