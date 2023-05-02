Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B06F4894
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjEBQsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjEBQsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:48:15 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132442118
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:48:14 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pttAi-0000UW-1L;
        Tue, 02 May 2023 18:48:12 +0200
Date:   Tue, 2 May 2023 17:48:07 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH 1/4] mtd: ubi: block: don't return on error when removing
Message-ID: <4bca8ffa66fa094da37625e66f3a2681058531d6.1683043928.git.daniel@makrotopia.org>
References: <cover.1683043928.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683043928.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point on returning the error from ubiblock_remove in case
it is being called due to a volume removal event -- the volume is gone,
we should destroy and remove the ubiblock device no matter what.

Introduce a new boolean parameter 'force' to tell ubiblock_remove to go
on even in case the ubiblock device is still busy. Use that new option
when calling ubiblock_remove due to a UBI_VOLUME_REMOVED event.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 6 +++---
 drivers/mtd/ubi/cdev.c  | 2 +-
 drivers/mtd/ubi/ubi.h   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 3711d7f746003..6f5804f4b8f55 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -457,7 +457,7 @@ static void ubiblock_cleanup(struct ubiblock *dev)
 	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
 }
 
-int ubiblock_remove(struct ubi_volume_info *vi)
+int ubiblock_remove(struct ubi_volume_info *vi, bool force)
 {
 	struct ubiblock *dev;
 	int ret;
@@ -471,7 +471,7 @@ int ubiblock_remove(struct ubi_volume_info *vi)
 
 	/* Found a device, let's lock it so we can check if it's busy */
 	mutex_lock(&dev->dev_mutex);
-	if (dev->refcnt > 0) {
+	if (dev->refcnt > 0 && !force) {
 		ret = -EBUSY;
 		goto out_unlock_dev;
 	}
@@ -546,7 +546,7 @@ static int ubiblock_notify(struct notifier_block *nb,
 		 */
 		break;
 	case UBI_VOLUME_REMOVED:
-		ubiblock_remove(&nt->vi);
+		ubiblock_remove(&nt->vi, true);
 		break;
 	case UBI_VOLUME_RESIZED:
 		ubiblock_resize(&nt->vi);
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index f43430b9c1e65..bb55e863dd296 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -572,7 +572,7 @@ static long vol_cdev_ioctl(struct file *file, unsigned int cmd,
 		struct ubi_volume_info vi;
 
 		ubi_get_volume_info(desc, &vi);
-		err = ubiblock_remove(&vi);
+		err = ubiblock_remove(&vi, false);
 		break;
 	}
 
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index c8f1bd4fa1008..44c0eeaf1e1b0 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -979,7 +979,7 @@ static inline void ubi_fastmap_destroy_checkmap(struct ubi_volume *vol) {}
 int ubiblock_init(void);
 void ubiblock_exit(void);
 int ubiblock_create(struct ubi_volume_info *vi);
-int ubiblock_remove(struct ubi_volume_info *vi);
+int ubiblock_remove(struct ubi_volume_info *vi, bool force);
 #else
 static inline int ubiblock_init(void) { return 0; }
 static inline void ubiblock_exit(void) {}
@@ -987,7 +987,7 @@ static inline int ubiblock_create(struct ubi_volume_info *vi)
 {
 	return -ENOSYS;
 }
-static inline int ubiblock_remove(struct ubi_volume_info *vi)
+static inline int ubiblock_remove(struct ubi_volume_info *vi, bool force)
 {
 	return -ENOSYS;
 }
-- 
2.40.1

