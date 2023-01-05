Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AF965EDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbjAEN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjAENzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37004F112
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:17 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id u19so90160949ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBGZezEaxNT5mYG63q3/p+giIEe5CEbFfULH3PLbvPA=;
        b=ha7nB7dh6AnVB76mhxbhh8HsobWs10km0yuGl0mjt61iw/Jhi8PZMlYOCu/9JSMmX9
         POoBzUiMatfNKMspA9cO4CK5YVWziEvrWVf116/aoxoFEMD/eRNA3QXqvJN8iYYh9RX9
         JOvqsmVAsPri4qiAQlfYUBfivizvECC7J2qtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBGZezEaxNT5mYG63q3/p+giIEe5CEbFfULH3PLbvPA=;
        b=5pitkCk1BbqhkbEpCWA62howj0bmOtUVannaJV1t9plfwK3gtVouwRYWIDZ0sYKsE3
         kweQTS7rcO/9G2BuuEnmmpxz2WsQNPsPZkr8YjZLigYGIkrXZPRT0bYfitjjHu5dNUcz
         YD5V1kahHjszTmT+fwZHREG3l4oYW1DsnnaZ6zSB6AJLCtRDrCT5D7UKRV+uNks4lXEf
         /4T5Ryevv/yyxk+xU0WQDoWD6Pzei+JkDntcf8xGtHgaGOn9WOjlwL3m+41II7SMz3y6
         +RL1n0Sz4lTlkfEOOUoOtHWV0mdgVVJ4u1s6V9fc4m08iZ4V7j8gOfNhMLJBmYVi6SkD
         xyBg==
X-Gm-Message-State: AFqh2kq8jbPFoUVvyxS8UrWYMgkc2mLsjqB+a+jeKnDLbcC3On87Egte
        mxiWDfoDND9ICLEURIc6CfJ48D19wl0K/0UsI/A=
X-Google-Smtp-Source: AMrXdXvWL+hEKIbcpR394kWiSMIV995umfL4HC7P+6mK2BlYFx5R06LT9dSkoE4e4R3p5NJTjFJK3Q==
X-Received: by 2002:a17:907:d50e:b0:7b1:316c:38f5 with SMTP id wb14-20020a170907d50e00b007b1316c38f5mr45507481ejc.30.1672926796528;
        Thu, 05 Jan 2023 05:53:16 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:53 +0100
Subject: [PATCH v2 2/7] Revert "media: uvcvideo: Implement mask for
 V4L2_CTRL_TYPE_MENU"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-2-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6121; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Bll6tbezraJ/a0Cf4Y3tLo27i37SeM2dqnIYPB0QUok=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttY/b7bCcBop5GwSyb/1YFamleXQAd6qIqP2JHx1
 qY7UH0qJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWPwAKCRDRN9E+zzrEiHayEA
 Cfi85jtOUubPwcJiNUckr9rdVK9KWxh04irky5T/yMtCiLB4GCzJnrrCg1ZFv9Y2c5avnu05kOJvy0
 fR2Bq3EQ3i9lZs1ZLq2OD2DLCDD+9KQwHWY/kwY8ixEfYflFKk6mm/VO27RtbDwPHT/1kQuuCmRPUU
 MXI91USBrnGJBsbvDxOLN4OFwkXAK6Bfarfw+/N5b6rOwf0K+BJzHfl9TS0cmUAQDOaQXp6Zp6OJuG
 pt3Az/NbbSKFL8TEF/dSOHg4RuREm4i/qZvy0KtT/OzJzbI1mrCVXW4/DvyarOPUqox4MRq5cjvmXY
 GeesdEKfDgQOSiBXOzjfGu8k8E7bAvv0gYD+Vbv0diRj/UPvqWGAas5pVe1jrS6MkbXlZQ6GfgkeWi
 z9F4Ev5liP+aVJSj20jqhCFgQFkFkCGp182BQ9sN4hTyXzox9zWCjkXkDj7PQ6RoV2SdhFX30IMXq1
 GZ+Rw6bhbCLQ+b52X/o+s6Nsp4ELUKksGvk6VGxxEIOtA9v9szJab6LbLXgEWIUfQ5j8dkPdWFlmZZ
 maQkb9c97wVmA76INBqtdu0UyUBzWcT7J7O88XTBZErcVGbSzz0JfbHDv9TqxRHY6AidbwF3aZcyCz
 gvnySmUumXriNVIXQ8CoTa/49uFa+kqPwMdaYGIkrAURho74BesR+G5E39vQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2ada36ecf16dcd32b56554f01ce38f273bc16efc.

BIT_MASK is nothing more than BIT().

Fixes: 2ada36ecf16d ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 30 ++++++++++--------------------
 drivers/media/usb/uvc/uvc_driver.c |  3 +--
 drivers/media/usb/uvc/uvc_v4l2.c   |  3 +--
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 06bb3822c05d..ffa0e2654264 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -6,7 +6,6 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
-#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -526,7 +525,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
+		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -732,7 +731,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
+		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
 	},
 };
 
@@ -746,7 +745,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
+		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
 	},
 };
 
@@ -976,9 +975,7 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
-			if (!test_bit(i, &mapping->menu_mask))
-				continue;
+		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1231,14 +1228,12 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
-		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
-		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
+		v4l2_ctrl->minimum = 0;
+		v4l2_ctrl->maximum = mapping->menu_count - 1;
 		v4l2_ctrl->step = 1;
 
 		menu = mapping->menu_info;
-		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
-			if (!test_bit(i, &mapping->menu_mask))
-				continue;
+		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
 			if (menu->value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
@@ -1359,7 +1354,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
+	if (query_menu->index >= mapping->menu_count) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1873,13 +1868,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		break;
 
 	case V4L2_CTRL_TYPE_MENU:
-		if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
-		    xctrl->value > (fls(mapping->menu_mask) - 1))
+		if (xctrl->value < 0 || xctrl->value >= mapping->menu_count)
 			return -ERANGE;
-
-		if (!test_bit(xctrl->value, &mapping->menu_mask))
-			return -EINVAL;
-
 		value = mapping->menu_info[xctrl->value].value;
 
 		/*
@@ -2316,7 +2306,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
+	size = sizeof(*mapping->menu_info) * mapping->menu_count;
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (!map->menu_info)
 		goto err_nomem;
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 2f59ee80a0af..6d08457ecb9c 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -7,7 +7,6 @@
  */
 
 #include <linux/atomic.h>
-#include <linux/bits.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -2392,7 +2391,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 	.menu_info	= power_line_frequency_controls_limited,
-	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index ed2525e7e2a5..3edb54c086b2 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -6,7 +6,6 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
-#include <linux/bits.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -81,7 +80,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 			goto free_map;
 		}
 
-		map->menu_mask = BIT_MASK(xmap->menu_count);
+		map->menu_count = xmap->menu_count;
 		break;
 
 	default:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a8eec43cd860..41ba0bbd8171 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -115,7 +115,7 @@ struct uvc_control_mapping {
 	u32 data_type;
 
 	const struct uvc_menu_info *menu_info;
-	unsigned long menu_mask;
+	u32 menu_count;
 
 	u32 master_id;
 	s32 master_manual;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
