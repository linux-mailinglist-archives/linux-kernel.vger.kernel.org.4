Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87B65C21B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbjACOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbjACOgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:36:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E624411819
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:36:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i15so44100509edf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMv0+FOAOO/esYuQ37yIKwt94y4B+tlVWaU4vykTkck=;
        b=axciJGXp+L8SXhJfkIq9Twg+BjWIAaVmjUFo2VgPpnEDwjUXfLMGXS+Mm7t0ShH3BO
         h4UPoPC/6hc16VgOnFLif51jIwHd336iVnaOD34CDwuWOAwkQqGaSL/03/n4Vs4FpVmt
         3yoyEl5AnMmKov4OR1JYDVFdC6NsNS60KwEqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMv0+FOAOO/esYuQ37yIKwt94y4B+tlVWaU4vykTkck=;
        b=MOkvcOFPf9SEMhJa8vdUcWrZUPyC3cJE3GS5SnvBzPywXN63Vnza5r5KnNArRGTReT
         6zPGfusJn7nyZnlrS4+dKUrlNUUAPlXurDNu5Eo7lyf2E812F/Ltv5Gm9ujecIcvE4xM
         NYdBd1uckmOCruyD8xwgvSY355wbT6fP7oU7vPJGCNbGrjzBiTcQx1SNdTcPk0TCXWgL
         lfDXMn1igtKSs1ztiLba6HYjUVr0B2ozzlKpI611xmLRFntFTE+CJtojfUPXDfXTl9HP
         9s6bkZ4vdBUWB9xPDMHU6j9y0K2EGpFPtIbB6QvWOFWqmpMWx0jkQRgGELjbB0Ut6W6U
         ixhQ==
X-Gm-Message-State: AFqh2kri+Dt7ryGqQxVbITLfNY9b8Cvb2nn+DHWKdysYHIyHqr26vUHy
        BS9FarIxNHX/XkSw32zJp3FdJw==
X-Google-Smtp-Source: AMrXdXtb0KbBmffKCMQE10rF9mg7ZpQ9x6DkWuo9IcT6QWXkYzDnWbNV6Y5bNLVqhUd+d/048F/V8w==
X-Received: by 2002:a05:6402:7d4:b0:467:f630:7927 with SMTP id u20-20020a05640207d400b00467f6307927mr39620050edy.15.1672756608540;
        Tue, 03 Jan 2023 06:36:48 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:9789:8e2b:74ac:a9a0])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640243ce00b0048ebf8a5736sm877245edc.21.2023.01.03.06.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 06:36:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 15:36:24 +0100
Subject: [PATCH v3 6/8] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v3-6-598d33a15815@chromium.org>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6230; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=CzvIh2I8OYn6qQYfnpDNhfSCuom8YJfz/8UwnMOFDWQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtD111zYzZRZMddOczAz+5+Us8BZbk9PPe9y/ph22
 e+LQ58KJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7Q9dQAKCRDRN9E+zzrEiC77D/
 4+HY54d/4XeFnOJgGXJeNlSST+xxOaDQD+xupk1M0qW7jpH9VScQpPdGRwB15LzKmpAg+JsbsAB8f5
 Iu/6OaST5qg6G/sKDs9HgPsh7/qdHgAsYC6zLH2U8ockN+jUEf71l2ZDptX5AejO/FIUpD4CaSvVAk
 FYqt5XcGI9zh9CiDniEL6++RYTd11uwRo92D0DJBFhaLnU4PhIAV9/+9Tffxm1Sfyakyx8zo0jQfpF
 Z4AvY97/8jdySxykYoDPa9Cgi4zX6zL8UpL1eNfWek8Ba7R1H4zN+FPTHKiCr/sLo0v8zT9dP/b8P+
 G4P+a76atGzNDHt1EQRdabLLFPmVQgKubltY/z/KfBsB/95Itqs+45IKU9XdlJSj8u/NHjGAvcjY1x
 UnDpA5rTjMVhYhB3/QzASWAmU128FQeQ3QnO2dcOc3rjfemLhoBfN0DRQLzlkfLQyfHHf13DrdqzoC
 QZv2h6cdlnjFFuO9rBjyGVlOEc3zijXZ+SrRYmo+PSINCMDwTAGKpoa/i5FofUirP7WKAtn8n9Z9ft
 qX7yliMQhi1ybSaa9iq8pSD3B4qRz08G4lB2z3WUpAacMer/sNrlFL6CitGWpypZTPpVNHSjanPFuQ
 BFF+XcMN1NVipnG+et7krJ7AE/hBqZuzXcHO1+CXBn6BVPBD1TDhCE9R+UVA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the count with a mask field that lets us choose not only the max
value, but also the minimum value and what values are valid in between.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 30 ++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_driver.c |  3 ++-
 drivers/media/usb/uvc/uvc_v4l2.c   |  3 ++-
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 7622c5b54b35..aa7a668f60a7 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -6,6 +6,7 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -525,7 +526,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -731,7 +732,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
 	},
 };
 
@@ -745,7 +746,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
 	},
 };
 
@@ -975,7 +976,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1228,12 +1231,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
-		v4l2_ctrl->minimum = 0;
-		v4l2_ctrl->maximum = mapping->menu_count - 1;
+		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
+		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
 		menu = mapping->menu_info;
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
@@ -1354,7 +1359,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (query_menu->index >= mapping->menu_count) {
+	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1868,8 +1873,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 		break;
 
 	case V4L2_CTRL_TYPE_MENU:
-		if (xctrl->value < 0 || xctrl->value >= mapping->menu_count)
+		if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
+		    xctrl->value > (fls(mapping->menu_mask) - 1))
 			return -ERANGE;
+
+		if (!test_bit(xctrl->value, &mapping->menu_mask))
+			return -EINVAL;
+
 		value = mapping->menu_info[xctrl->value].value;
 
 		/*
@@ -2305,7 +2315,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * mapping->menu_count;
+	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (map->menu_info == NULL) {
 		kfree(map->name);
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e4bcb5011360..f9e6208c4636 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -2384,7 +2385,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 	.menu_info	= power_line_frequency_controls_limited,
-	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 3edb54c086b2..ed2525e7e2a5 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -6,6 +6,7 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/bits.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -80,7 +81,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 			goto free_map;
 		}
 
-		map->menu_count = xmap->menu_count;
+		map->menu_mask = BIT_MASK(xmap->menu_count);
 		break;
 
 	default:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a151f583cd15..f75e5864bbf7 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -117,7 +117,7 @@ struct uvc_control_mapping {
 	u32 data_type;
 
 	const struct uvc_menu_info *menu_info;
-	u32 menu_count;
+	unsigned long menu_mask;
 
 	u32 master_id;
 	s32 master_manual;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
