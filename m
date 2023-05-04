Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DB6F4895
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjEBQsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjEBQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:48:34 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76597212E
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:48:30 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pttAy-0000Us-1h;
        Tue, 02 May 2023 18:48:28 +0200
Date:   Tue, 2 May 2023 17:48:23 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: [PATCH 2/4] mtd: ubi: block: use notifier to create ubiblock from
 parameter
Message-ID: <726b7629d0819092edeb193f3bfc13c99bd13339.1683043928.git.daniel@makrotopia.org>
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

Use UBI_VOLUME_ADDED notification to create ubiblock device specified
on kernel cmdline or module parameter.
This makes things more simple and has the advantage that ubiblock devices
on volumes which are not present at the time the ubi module is probed
will still be created.

Suggested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/block.c | 150 ++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 68 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 6f5804f4b8f55..7f3024bddf306 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/namei.h>
 #include <linux/slab.h>
 #include <linux/mtd/ubi.h>
 #include <linux/blkdev.h>
@@ -65,10 +66,10 @@ struct ubiblock_pdu {
 };
 
 /* Numbers of elements set in the @ubiblock_param array */
-static int ubiblock_devs __initdata;
+static int ubiblock_devs;
 
 /* MTD devices specification parameters */
-static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
+static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES];
 
 struct ubiblock {
 	struct ubi_volume_desc *desc;
@@ -533,6 +534,83 @@ static int ubiblock_resize(struct ubi_volume_info *vi)
 	return 0;
 }
 
+static bool
+match_volume_desc(struct ubi_volume_info *vi, const char *name, int ubi_num, int vol_id)
+{
+	int err, len;
+	struct path path;
+	struct kstat stat;
+
+	if (ubi_num == -1) {
+		/* No ubi num, name must be a vol device path */
+		err = kern_path(name, LOOKUP_FOLLOW, &path);
+		if (err)
+			return false;
+
+		err = vfs_getattr(&path, &stat, STATX_TYPE, AT_STATX_SYNC_AS_STAT);
+		path_put(&path);
+		if (err)
+			return false;
+
+		if (!S_ISCHR(stat.mode))
+			return false;
+
+		if (vi->ubi_num != ubi_major2num(MAJOR(stat.rdev)))
+			return false;
+
+		if (vi->vol_id != MINOR(stat.rdev) - 1)
+			return false;
+
+		return true;
+	} else if (vol_id == -1) {
+		if (vi->ubi_num != ubi_num)
+			return false;
+
+		len = strnlen(name, UBI_VOL_NAME_MAX + 1);
+		if (len < 1 || vi->name_len != len)
+			return false;
+
+		if (strcmp(name, vi->name))
+			return false;
+
+		return true;
+	} else {
+		if (vi->ubi_num != ubi_num)
+			return false;
+
+		if (vi->vol_id != vol_id)
+			return false;
+
+		return true;
+	}
+}
+
+static void
+ubiblock_create_from_param(struct ubi_volume_info *vi)
+{
+	int i, ret = 0;
+	struct ubiblock_param *p;
+
+	/*
+	 * Iterate over ubiblock cmdline parameters. If a parameter matches the
+	 * newly added volume create the ubiblock device for it.
+	 */
+	for (i = 0; i < ubiblock_devs; i++) {
+		p = &ubiblock_param[i];
+
+		if (!match_volume_desc(vi, p->name, p->ubi_num, p->vol_id))
+			continue;
+
+		ret = ubiblock_create(vi);
+		if (ret) {
+			pr_err(
+			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
+			       vi->name, p->ubi_num, p->vol_id, ret);
+		}
+		break;
+	}
+}
+
 static int ubiblock_notify(struct notifier_block *nb,
 			 unsigned long notification_type, void *ns_ptr)
 {
@@ -540,10 +618,7 @@ static int ubiblock_notify(struct notifier_block *nb,
 
 	switch (notification_type) {
 	case UBI_VOLUME_ADDED:
-		/*
-		 * We want to enforce explicit block device creation for
-		 * volumes, so when a volume is added we do nothing.
-		 */
+		ubiblock_create_from_param(&nt->vi);
 		break;
 	case UBI_VOLUME_REMOVED:
 		ubiblock_remove(&nt->vi, true);
@@ -569,56 +644,6 @@ static struct notifier_block ubiblock_notifier = {
 	.notifier_call = ubiblock_notify,
 };
 
-static struct ubi_volume_desc * __init
-open_volume_desc(const char *name, int ubi_num, int vol_id)
-{
-	if (ubi_num == -1)
-		/* No ubi num, name must be a vol device path */
-		return ubi_open_volume_path(name, UBI_READONLY);
-	else if (vol_id == -1)
-		/* No vol_id, must be vol_name */
-		return ubi_open_volume_nm(ubi_num, name, UBI_READONLY);
-	else
-		return ubi_open_volume(ubi_num, vol_id, UBI_READONLY);
-}
-
-static void __init ubiblock_create_from_param(void)
-{
-	int i, ret = 0;
-	struct ubiblock_param *p;
-	struct ubi_volume_desc *desc;
-	struct ubi_volume_info vi;
-
-	/*
-	 * If there is an error creating one of the ubiblocks, continue on to
-	 * create the following ubiblocks. This helps in a circumstance where
-	 * the kernel command-line specifies multiple block devices and some
-	 * may be broken, but we still want the working ones to come up.
-	 */
-	for (i = 0; i < ubiblock_devs; i++) {
-		p = &ubiblock_param[i];
-
-		desc = open_volume_desc(p->name, p->ubi_num, p->vol_id);
-		if (IS_ERR(desc)) {
-			pr_err(
-			       "UBI: block: can't open volume on ubi%d_%d, err=%ld\n",
-			       p->ubi_num, p->vol_id, PTR_ERR(desc));
-			continue;
-		}
-
-		ubi_get_volume_info(desc, &vi);
-		ubi_close_volume(desc);
-
-		ret = ubiblock_create(&vi);
-		if (ret) {
-			pr_err(
-			       "UBI: block: can't add '%s' volume on ubi%d_%d, err=%d\n",
-			       vi.name, p->ubi_num, p->vol_id, ret);
-			continue;
-		}
-	}
-}
-
 static void ubiblock_remove_all(void)
 {
 	struct ubiblock *next;
@@ -644,18 +669,7 @@ int __init ubiblock_init(void)
 	if (ubiblock_major < 0)
 		return ubiblock_major;
 
-	/*
-	 * Attach block devices from 'block=' module param.
-	 * Even if one block device in the param list fails to come up,
-	 * still allow the module to load and leave any others up.
-	 */
-	ubiblock_create_from_param();
-
-	/*
-	 * Block devices are only created upon user requests, so we ignore
-	 * existing volumes.
-	 */
-	ret = ubi_register_volume_notifier(&ubiblock_notifier, 1);
+	ret = ubi_register_volume_notifier(&ubiblock_notifier, 0);
 	if (ret)
 		goto err_unreg;
 	return 0;
-- 
2.40.1

