Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA4F64241C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiLEIIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiLEIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:08:21 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFE1408F;
        Mon,  5 Dec 2022 00:08:16 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NQblM2R66z4y0vF;
        Mon,  5 Dec 2022 16:08:15 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B58825v016075;
        Mon, 5 Dec 2022 16:08:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 16:08:04 +0800 (CST)
Date:   Mon, 5 Dec 2022 16:08:04 +0800 (CST)
X-Zmail-TransId: 2af9638da6e4fffffffffc58ba99
X-Mailer: Zmail v1.0
Message-ID: <202212051608044377107@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <deller@gmx.de>
Cc:     <javierm@redhat.com>, <tzimmermann@suse.de>,
        <geert+renesas@glider.be>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIGZiZGV2OiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B58825v016075
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638DA6EF.000 by FangMail milter!
X-FangMail-Envelope: 1670227695/4NQblM2R66z4y0vF/638DA6EF.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638DA6EF.000/4NQblM2R66z4y0vF
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.25.1
