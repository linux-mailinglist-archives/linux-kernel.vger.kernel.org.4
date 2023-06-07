Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690CA725A43
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbjFGJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbjFGJZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:25:23 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A2192
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1686129922;
  x=1717665922;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=+hz7OrzMbUMcAoXtMSvTQCl5KtJyw3Bih09dQpX7TTs=;
  b=kBw2lts1MPZT5iHlYoi6VtiCTdTs171UZCzHz2EZcDnlS+cLvShZHGw8
   Zu9CpXf6g9/b6te123HTAlIQduFZZZEB9VivtK5cZRG+5CPr3zPp8KIWK
   vxqrQdzejY9MD2xGBkZX59MMdcCjehI1YhX/Q3ItevgB5rvfm53qXuftp
   1enAHQi+GPaAjRZbs0Wc/kwpqTtnrLTgah5TRZx59ui21QcWuXbJsLRkS
   nrDB2RBIdmbwly1+TB+dxbJyS7p7xNZp9vC2z5ub7OiEbMtvXsEILUUrQ
   3nk/n/2WV9udl4StVewACc877oVaVWtQx91Pz0FZY610jZGLEryN/oGdh
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Wed, 7 Jun 2023 11:25:06 +0200
Subject: [PATCH v2] ubi: block: Fix cleanup handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230523-ubiblock-remove-v2-1-7671fc60ba49@axis.com>
X-B4-Tracking: v=1; b=H4sIAPFMgGQC/3WNyw6CMBBFf4V0bU0pD9GV/2FYdMpUJkrHtNpgC
 P9uYe/y3JuTs4iIgTCKS7GIgIkisc+gD4Wwo/F3lDRkFlrpSjW6kh8geLJ9yIATJ5RooC2ta7v
 KKZEtMBElBOPtuHmOGUzQ2/MK6GjeW7c+80jxzeG7p1O5rf8rqZRK6loBDqemq89wNTPFo+VJ9
 Ou6/gBYruakxwAAAA==
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <hch@infradead.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
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

ubiblock's remove handling has a couple of problems:

 - It uses the gendisk after put_disk(), resulting in a use-after-free.

 - There is a circular locking dependency between disk->open_mutex (used
   from del_gendisk() and blkdev_open()) and dev->dev_mutex (used from
   ubiblock_open() and ubiblock_remove()).

Fix these by implementing ->free_disk() and moving the final cleanup
there.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Combine and rework patches to implement and use ->free_disk().
- Link to v1: https://lore.kernel.org/r/20230523-ubiblock-remove-v1-0-240bed75849b@axis.com
---
 drivers/mtd/ubi/block.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3711d7f74600..570e660673ad 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -293,11 +293,23 @@ static int ubiblock_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
+static void ubiblock_free_disk(struct gendisk *disk)
+{
+	struct ubiblock *dev = disk->private_data;
+
+	mutex_lock(&devices_mutex);
+	idr_remove(&ubiblock_minor_idr, disk->first_minor);
+	mutex_unlock(&devices_mutex);
+
+	kfree(dev);
+}
+
 static const struct block_device_operations ubiblock_ops = {
 	.owner = THIS_MODULE,
 	.open = ubiblock_open,
 	.release = ubiblock_release,
 	.getgeo	= ubiblock_getgeo,
+	.free_disk = ubiblock_free_disk,
 };
 
 static blk_status_t ubiblock_queue_rq(struct blk_mq_hw_ctx *hctx,
@@ -452,9 +464,8 @@ static void ubiblock_cleanup(struct ubiblock *dev)
 	del_gendisk(dev->gd);
 	/* Finally destroy the blk queue */
 	dev_info(disk_to_dev(dev->gd), "released");
-	put_disk(dev->gd);
 	blk_mq_free_tag_set(&dev->tag_set);
-	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
+	put_disk(dev->gd);
 }
 
 int ubiblock_remove(struct ubi_volume_info *vi)
@@ -478,11 +489,11 @@ int ubiblock_remove(struct ubi_volume_info *vi)
 
 	/* Remove from device list */
 	list_del(&dev->list);
-	ubiblock_cleanup(dev);
 	mutex_unlock(&dev->dev_mutex);
 	mutex_unlock(&devices_mutex);
 
-	kfree(dev);
+	ubiblock_cleanup(dev);
+
 	return 0;
 
 out_unlock_dev:
@@ -623,17 +634,19 @@ static void ubiblock_remove_all(void)
 {
 	struct ubiblock *next;
 	struct ubiblock *dev;
+	LIST_HEAD(list);
 
 	mutex_lock(&devices_mutex);
-	list_for_each_entry_safe(dev, next, &ubiblock_devices, list) {
+	list_splice_init(&ubiblock_devices, &list);
+	mutex_unlock(&devices_mutex);
+
+	list_for_each_entry_safe(dev, next, &list, list) {
 		/* The module is being forcefully removed */
 		WARN_ON(dev->desc);
 		/* Remove from device list */
 		list_del(&dev->list);
 		ubiblock_cleanup(dev);
-		kfree(dev);
 	}
-	mutex_unlock(&devices_mutex);
 }
 
 int __init ubiblock_init(void)

---
base-commit: 44c026a73be8038f03dbdeef028b642880cf1511
change-id: 20230523-ubiblock-remove-eab61cf683f0

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

