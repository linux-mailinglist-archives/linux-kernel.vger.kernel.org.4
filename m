Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA815BF0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiITW5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiITW5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:57:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD93C726BF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:57:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sd10so1330713ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=Hbd6kzjNacbB4SzKkil9gSiEv9GIia7WA44UxbYbMDY=;
        b=ffwY1tHHSTsp02oRSxIsOR1u1laYKS0EAS2AZLm8sqnSIn+Nnq09ZStyKuTNqCsOdM
         fHlElzXQw3/G4f0YUzdNYW7wzw5Rysx2+yzFZlCEHXqc1WPDQ2Celxg+Y0HMqn6+zgUO
         vYQzdSTJZDLZSPX8IAulNHrb/DD4/WPy0U0Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hbd6kzjNacbB4SzKkil9gSiEv9GIia7WA44UxbYbMDY=;
        b=C5s04YcQSDp5mNVZ1BN95vuwl+RlLzqWNFmnPac3cBci+gAyHLwq1ydy1+/Zi4ksve
         hA18SZR+GwrczY3A+3/VOKBC9s0U7zOXrP5k1imwi/n6iJ36nR+7D7Ouc408X2Wiw3Z8
         xwx63NvbwwJhRxyd6n59bFBGt1Js1kKFqFCK6gzRSAOjVEQYgovbKOZaJnFJnA+oEun6
         TX4xn3/FsiJ+l782LXcu5yeygUqzeO8/T6OX7R/hiVzAwSn7P6XfmlAIQUTD4pUH94j4
         K1jDr+BGXxPbafbzUBpFab78ik4Per9LXvO99m9+PH6dwIT6SDCp9TXMGMXiX2jsVJ9Q
         lQmQ==
X-Gm-Message-State: ACrzQf1YP9I+JH8d/5WzBBgSewEUpLVZza2IkdFyyYJsqC1BrIJqAN8k
        SyGSncV1ndhy9LfEZB58ruj94dp0PnSr60WPjJ8=
X-Google-Smtp-Source: AMsMyM7SGJsn0/oA4Yg2GJXL6CsNL8fgMiCIx+1CM7z/qjv0DfZ4PlsY2Ghx8mNX3GWbYqO2Suh2iQ==
X-Received: by 2002:a17:907:847:b0:77f:f489:cc25 with SMTP id ww7-20020a170907084700b0077ff489cc25mr18426167ejb.80.1663714662303;
        Tue, 20 Sep 2022 15:57:42 -0700 (PDT)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b0073100dfa7b0sm531832ejo.8.2022.09.20.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:57:42 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 00:57:29 +0200
Subject: [PATCH v2 1/2] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-standard-menues-v2-1-a35af3243c2f@chromium.org>
References: <20220920-standard-menues-v2-0-a35af3243c2f@chromium.org>
In-Reply-To: <20220920-standard-menues-v2-0-a35af3243c2f@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=X2E+J6cS54HeJ20WA4jpZVzbo0rHgKMmPW1S9iv4Ftw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKkVf9Sgn9d26x4Tmlp9w9s/PVO4B5tzUMV8DQ7nq
 qs9mIT+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYypFXwAKCRDRN9E+zzrEiASED/
 9c2RjqjVW3VW9XA4ZaLtIQ1W5D8YTxYDGO4Hm2xJSyD89BNTKWxuJbE2EveObsdsYcHR68WDsIBtbk
 2HNzPVUB9KzsrOBaNRmi6bhCqUGlZ0PY8B4X4lKo+SE9xewndQICFWyGx14UgbPkVjZkcpA0dru3ws
 eUMo4PPgAb2JjD9JC+rJgsxxQzPr90+smkH3+RlBXcATqpOtek8J6x2KYXrSn59NkWWOwcbkM1ne3J
 a9eSTT0PQTzdW63qLAx7psTTgdLAD2r1LaoELlb2VXtmhvb5PvJSLhTXOpSi62VbeL1uJInc0PGlfo
 eOZhx2wh2epL48sScHGHbfPOB4B47XZigejp7pcKeUoGcjE5QZpKpqpF6VK50LxPCQI6khIVp9FV48
 bnFi4ZYBXRdG7XRkI7pxnA5C1WRbYH2bbhz1/M6+hbdTEGkjObdFT7R7IFHUH3AOfm0H0EG2jUDgOm
 s8HqS10OrCJl2vlUc3EmQ1dwo5fmaFBw7tQXvHqL6/gALkDAbo+xMF0c/F0RHKzxyh4rIR79wd0lcT
 FDyo9D0TyzbkeDhgGbQXdq3hq5/KtEM5AdmXaGSw3fDAB1gnUIbHEk2W1RsR6wmj6eNGaZhTSrchg6
 QRg3PShplj/2qd8mt2yEmyA/r8uUC6pWId63IpJozjLIovMz969BSqlmta8A==
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
b4 0.11.0-dev-d93f8
