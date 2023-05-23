Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE1970DD42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjEWNMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjEWNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:12:28 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14755FF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1684847547;
  x=1716383547;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=OfLmz9ckLWnjOPs/nZyBCIbifQUUmP+cRC2xReLIuEM=;
  b=HnvR3M2pwIN8lCbcEFO/Yo98u0GEbKYw6Lbl3SZ6gjnLDi998l/61eJ0
   SXicqnA20wlhMombtJ+gZDjrhRtBRVYDo9LandZktrxvYjOYLAY9KhfZ7
   OB1eV7s5WeRwa6pi+eiW6XKTgHenJnP2V8N8M/0u2UdIVrIhRkGtw7LbS
   VoD9ZR1XRW5y02vyldTuApKWPVp6koTHfwApym02DlWBr6TVyLBcQ9RwC
   E9anOjhhbib3oATRCBsQZuifF8b+RB6BpJb+fmwkq2FrMaeTSZjrHftRs
   fOqdXf3Wf04mU4ENIxcJBFS8RcU/9m24RZyI7LBhWH8rL1S5Mie576nXw
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Tue, 23 May 2023 15:12:17 +0200
Subject: [PATCH 2/2] ubi: block: Fix deadlock on remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230523-ubiblock-remove-v1-2-240bed75849b@axis.com>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
In-Reply-To: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep warns about possible circular locking when the following
commands are run:

 ubiblock --create /dev/ubi0_0
 head -c1 /dev/ubiblock0_0 > /dev/null
 ubiblock --remove /dev/ubi0_0

 ======================================================
 WARNING: possible circular locking dependency detected

 ubiblock/364 is trying to acquire lock:
 (&disk->open_mutex){+.+.}-{3:3}, at: del_gendisk (block/genhd.c:616)

 but task is already holding lock:
 (&dev->dev_mutex){+.+.}-{3:3}, at: ubiblock_remove (drivers/mtd/ubi/block.c:476)

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (&dev->dev_mutex){+.+.}-{3:3}:
   ubiblock_open (drivers/mtd/ubi/block.c:236)
   blkdev_get_whole (block/bdev.c:607)
   blkdev_get_by_dev (block/bdev.c:756)
   blkdev_open (block/fops.c:493)
   ...
   do_sys_openat2 (fs/open.c:1356)

 -> #0 (&disk->open_mutex){+.+.}-{3:3}:
   del_gendisk (block/genhd.c:616)
   ubiblock_remove (drivers/mtd/ubi/block.c:456 drivers/mtd/ubi/block.c:483)
   vol_cdev_ioctl
   ...

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dev->dev_mutex);
                                lock(&disk->open_mutex);
                                lock(&dev->dev_mutex);
   lock(&disk->open_mutex);

 *** DEADLOCK ***

 Call Trace:
 del_gendisk (block/genhd.c:616)
 ubiblock_remove (drivers/mtd/ubi/block.c:456 drivers/mtd/ubi/block.c:483)
 vol_cdev_ioctl
 ...

The actual deadlock is also easily reproducible by running the above
commands in parallel in a loop.

Fix this by marking the device as going away and releasing the dev mutex
before del_gendisk().  This is similar to other drivers such as
drivers/block/zram/zram_drv.c.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/mtd/ubi/block.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 70caec4606cd..fcfea7cfdb6b 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -83,6 +83,8 @@ struct ubiblock {
 	struct mutex dev_mutex;
 	struct list_head list;
 	struct blk_mq_tag_set tag_set;
+
+	bool removing;
 };
 
 /* Linked list of all ubiblock instances */
@@ -233,6 +235,11 @@ static int ubiblock_open(struct block_device *bdev, fmode_t mode)
 	int ret;
 
 	mutex_lock(&dev->dev_mutex);
+	if (dev->removing) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	if (dev->refcnt > 0) {
 		/*
 		 * The volume is already open, just increase the reference
@@ -480,8 +487,15 @@ int ubiblock_remove(struct ubi_volume_info *vi)
 
 	/* Remove from device list */
 	list_del(&dev->list);
-	ubiblock_cleanup(dev);
+
+	/*
+	 * Prevent further opens.  del_gendisk() will ensure that there are no
+	 * parallel openers.
+	 */
+	dev->removing = true;
 	mutex_unlock(&dev->dev_mutex);
+
+	ubiblock_cleanup(dev);
 	mutex_unlock(&devices_mutex);
 
 	kfree(dev);

-- 
2.34.1

