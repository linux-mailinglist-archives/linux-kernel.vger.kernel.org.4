Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C512C640C22
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbiLBR00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiLBR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:26:14 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF1715A27
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:26:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f7so7332885edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7MAAyi9Hz4wjta9+fdyCpLVjnZ+P9Y8G44ZTiiQqqo=;
        b=EFab8JlE9N+19+aeClgUWYaYD7x1aC5nXqaqth1OO+xX+3yh7ATPAjP45Eon4WH2EO
         PDnlyj0PKGzyNLx5zo+Pb7nN6ZogFgK8WoNOn+gdOg/kLTo2tQi60rSQXzJIrynCTFmL
         dM5T1XHQhfjnrWFHZI8/5Lt47wLpmeBhiHn+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7MAAyi9Hz4wjta9+fdyCpLVjnZ+P9Y8G44ZTiiQqqo=;
        b=7b0AUe35TFWmqVWP9kino46mH+cVvqLvv8sj/B3VcDGlebtMzryacJ2c3Sh7QsC5JI
         Nxfsgd5GMLme/p+qOiHp7KgvAtNIrYsswagkdj6zmxTKGAovXWUbDmBqD698cDzy9swN
         H6QKBRjdDmbC161xjtvaGgIKew3fbX1C/RVfYLf1FsyFsDChg0/HcIIC7gYYEIC9RpJs
         o5Tvxe/hR3/j69FhxfwEV/8yOAMkUk45/qR12R4x+GJIlLYx1zCpESkQP+Nx0ms0Lqbu
         DznccWxz5R1M5sZmf5zaS7mPeZppkuFuGA7efN0F4QwSH3vJFT3tO/rhsaPZxMvOdHtX
         nEDQ==
X-Gm-Message-State: ANoB5pm0dl/6tBbaX0JJx/HKbSCsUAMpbcYA0sQcQrmJ4VeaWvLbhw7+
        ikJ81La7eQZ0UPskjFUwk7QgbA==
X-Google-Smtp-Source: AA0mqf7LdfXN9fCLUsrVSew/7ounecfgNqxwB791B81Cw+buCNOUDU2yXnHSFW2dMxkAhZu1WjJbMg==
X-Received: by 2002:a05:6402:494:b0:46a:c9bc:ccd4 with SMTP id k20-20020a056402049400b0046ac9bcccd4mr31688412edv.200.1670001972052;
        Fri, 02 Dec 2022 09:26:12 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090653c900b00782e3cf7277sm3202546ejo.120.2022.12.02.09.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:26:11 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:26:02 +0100
Subject: [PATCH RESEND v2 1/2] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-standard-menues-v2-1-323be5539c22@chromium.org>
References: <20220920-standard-menues-v2-0-323be5539c22@chromium.org>
In-Reply-To: <20220920-standard-menues-v2-0-323be5539c22@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5612; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ShK865485w5SoZgXarE4ew0QL+re3ISrWPQi8TdPOys=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijUuIQBsAZHtfxeGnVfJVGwtC9xh/rM0M5FwH9Zh
 zkJHUUuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o1LgAKCRDRN9E+zzrEiLenD/
 91iPdk95a6MYP3THhC2JgPtn+yhk6RpFtAIYKXt/KnsrCcEvnm0GR3EOTs2fTG8Zg0hSBKEetKnOqk
 FD8QT4UxlOSww2Bc14i0VlprwmtEJtarjKeQp1Yd1OboSWl/BAVRugzrm906kt3g37E0Ovp8Kr5g+p
 V5e48X3EXQnnRmnNYf8ytodt3GYpW/RqMnKN0kz86NAPuAfRcaA1Bj2RMfkz+wNslp5v9zA88PwbOb
 l5XLzWq1gW2hL3fCC8/HkMaJYAteIK5Fbmf3PHPo9Q6F/lmI20j2c0OGLqzr6ZNnduKhEIl1/PSWXx
 8m+dtg2EQg+uUsOw+WD6SmsGDKE9ifks3fK3kIr8t5d8vGL0CzCO3wHyvD0pqu9Hy6GA0qYMEQfqTF
 7SFVAMbWhhNUAVwHC6jxQt23IFwjXJx3J6HyW3TpY8thEzJLJCzWUMF73oZ68dLrWvUsjZZyfBZozQ
 YFwKpV+/rC5ycVmWqTUdQ22xgzd/5uMjkx6QDaF3weEQt28Mq5iq3qFF3v6o+RC50XPSkstJKz7Ohx
 jt9NRHb5UkFIvd2GnW1wPuc9AWcwOWeLjFDZtaNKXAR8V/+vtfjXKa6dn+u1AuhWshtozajsEX3V2n
 uL9CRiKz6fbxBjxHZwK26anyHwxZc7U7SkZvVe+40hRL5xCrLQqdHaU/7ZOQ==
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

Replace the count with a mask field that let us choose not only the max
value, but also the minimum value and what values are valid in between.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 32 ++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_driver.c |  3 ++-
 drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 8c208db9600b..13bc57e2a08d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -524,7 +524,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,7 +731,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
 	},
 };
 
@@ -744,7 +746,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+		.menu_mask	=
+			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
 	},
 };
 
@@ -974,7 +977,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1148,12 +1153,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_MENU:
-		v4l2_ctrl->minimum = 0;
-		v4l2_ctrl->maximum = mapping->menu_count - 1;
+		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
+		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
 		v4l2_ctrl->step = 1;
 
 		menu = mapping->menu_info;
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == v4l2_ctrl->default_value) {
 				v4l2_ctrl->default_value = i;
 				break;
@@ -1268,7 +1275,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (query_menu->index >= mapping->menu_count) {
+	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1776,8 +1783,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
@@ -2227,7 +2239,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * mapping->menu_count;
+	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (map->menu_info == NULL) {
 		kfree(map->name);
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..09cc459c1253 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2675,7 +2675,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 	.menu_info	= power_line_frequency_controls_limited,
-	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+	.menu_mask	=
+		BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 4cc3fa6b8c98..07c7acce8025 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -80,7 +80,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
 			goto free_map;
 		}
 
-		map->menu_count = xmap->menu_count;
+		map->menu_mask = BIT_MASK(xmap->menu_count);
 		break;
 
 	default:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 24c911aeebce..fde4e975334f 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -255,7 +255,7 @@ struct uvc_control_mapping {
 	u32 data_type;
 
 	const struct uvc_menu_info *menu_info;
-	u32 menu_count;
+	unsigned long menu_mask;
 
 	u32 master_id;
 	s32 master_manual;

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
