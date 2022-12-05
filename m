Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74871642453
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiLEIRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiLEIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:16:59 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A3DBC06;
        Mon,  5 Dec 2022 00:16:56 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NQbxM1jhJz8RV7G;
        Mon,  5 Dec 2022 16:16:55 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B58Gf6p028925;
        Mon, 5 Dec 2022 16:16:41 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 16:16:43 +0800 (CST)
Date:   Mon, 5 Dec 2022 16:16:43 +0800 (CST)
X-Zmail-TransId: 2af9638da8eb41c9fedb
X-Mailer: Zmail v1.0
Message-ID: <202212051616434207425@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <deller@gmx.de>
Cc:     <javierm@redhat.com>, <tzimmermann@suse.de>,
        <geert+renesas@glider.be>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIGZiZGV2OiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B58Gf6p028925
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638DA8F7.000 by FangMail milter!
X-FangMail-Envelope: 1670228215/4NQbxM1jhJz8RV7G/638DA8F7.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DA8F7.000/4NQbxM1jhJz8RV7G
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
v1 -> v2
Add another patch about this in ./video/fbdev/
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  8 ++++----
 drivers/video/fbdev/uvesafb.c          | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 6d00893d41f4..ad9323ed8e2e 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1188,7 +1188,7 @@ overlay_alpha_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct sh_mobile_lcdc_overlay *ovl = info->par;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", ovl->alpha);
+	return sysfs_emit(buf, "%u\n", ovl->alpha);
 }

 static ssize_t
@@ -1226,7 +1226,7 @@ overlay_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct sh_mobile_lcdc_overlay *ovl = info->par;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", ovl->mode);
+	return sysfs_emit(buf, "%u\n", ovl->mode);
 }

 static ssize_t
@@ -1265,7 +1265,7 @@ overlay_position_show(struct device *dev, struct device_attribute *attr,
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct sh_mobile_lcdc_overlay *ovl = info->par;

-	return scnprintf(buf, PAGE_SIZE, "%d,%d\n", ovl->pos_x, ovl->pos_y);
+	return sysfs_emit(buf, "%d,%d\n", ovl->pos_x, ovl->pos_y);
 }

 static ssize_t
@@ -1306,7 +1306,7 @@ overlay_rop3_show(struct device *dev, struct device_attribute *attr, char *buf)
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct sh_mobile_lcdc_overlay *ovl = info->par;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", ovl->rop3);
+	return sysfs_emit(buf, "%u\n", ovl->rop3);
 }

 static ssize_t
diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 00d789b6c0fa..ba8028a0cc7a 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1580,7 +1580,7 @@ static ssize_t uvesafb_show_vendor(struct device *dev,
 	struct uvesafb_par *par = info->par;

 	if (par->vbe_ib.oem_vendor_name_ptr)
-		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return sysfs_emit(buf, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_vendor_name_ptr);
 	else
 		return 0;
@@ -1595,7 +1595,7 @@ static ssize_t uvesafb_show_product_name(struct device *dev,
 	struct uvesafb_par *par = info->par;

 	if (par->vbe_ib.oem_product_name_ptr)
-		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return sysfs_emit(buf, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_product_name_ptr);
 	else
 		return 0;
@@ -1610,7 +1610,7 @@ static ssize_t uvesafb_show_product_rev(struct device *dev,
 	struct uvesafb_par *par = info->par;

 	if (par->vbe_ib.oem_product_rev_ptr)
-		return scnprintf(buf, PAGE_SIZE, "%s\n", (char *)
+		return sysfs_emit(buf, "%s\n", (char *)
 			(&par->vbe_ib) + par->vbe_ib.oem_product_rev_ptr);
 	else
 		return 0;
@@ -1625,7 +1625,7 @@ static ssize_t uvesafb_show_oem_string(struct device *dev,
 	struct uvesafb_par *par = info->par;

 	if (par->vbe_ib.oem_string_ptr)
-		return scnprintf(buf, PAGE_SIZE, "%s\n",
+		return sysfs_emit(buf, "%s\n",
 			(char *)(&par->vbe_ib) + par->vbe_ib.oem_string_ptr);
 	else
 		return 0;
@@ -1639,7 +1639,7 @@ static ssize_t uvesafb_show_nocrtc(struct device *dev,
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct uvesafb_par *par = info->par;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", par->nocrtc);
+	return sysfs_emit(buf, "%d\n", par->nocrtc);
 }

 static ssize_t uvesafb_store_nocrtc(struct device *dev,
-- 
2.25.1
