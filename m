Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52595BE854
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiITOOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiITONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:33 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28FE60523
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id r18so6421264eja.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=Hbd6kzjNacbB4SzKkil9gSiEv9GIia7WA44UxbYbMDY=;
        b=MrECpMbnW8V1rDFlHI6/iqm2mTOAKrzZWyM0C9XnwPmjfPNkwsz3TzLfgx361FPQPi
         QGy/qjLR1teBYfT+JGOCse/SFHlnWz1p6+1EMwjVqIPFMu/jjTSsfIJRA/I7eaUy/tbl
         Jrp9EPy0AfT0X0nVYQ725r9n0XGPULWiK79Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hbd6kzjNacbB4SzKkil9gSiEv9GIia7WA44UxbYbMDY=;
        b=Yes3a8LhVTLumHi2AYYED74/W7uhndKzBygWE2UOIBRTyY/nzYY01vrawieFdChWhj
         5Y1VYEoF82jZvLUI7YkhB6+Tu17F5GIaJT9vzwfF7VkPqBkSQmCXOuzpRTdQJB61Ys5H
         XsyqWEUHH83G9Umo8bNPJQO4nOedr7Ssi93MotYsHXdJwfupQfqo87TwdwLzc8+2DRA9
         FUj0ffHURUwldQEd4YG4iTSdlCmGAeHEmC2ZNLRsaenrGZkLy6kSQ7IdfoScIIdFgJfR
         2OTjKx5gS0Bjzbr/WqsDxF7XRn0OGQuSpsOqI0qzoCITgy+WKcLCDJZeXGO+fRJK8l4c
         UwMA==
X-Gm-Message-State: ACrzQf1onZyEe0jN2IroBsAUgMOoHl27lMKxeLub4NkUv8YEH6QQp9q4
        wjPDzWrx+jND0YdDOfWuyesATw==
X-Google-Smtp-Source: AMsMyM6LXx5hXhwM0It1YjDa7//KPj1cv4AB4Tcy2WbBopRZg0nMsQrO3uygOdxtLE9hQlIde5Yy+A==
X-Received: by 2002:a17:907:25c1:b0:77b:9966:ccf1 with SMTP id ae1-20020a17090725c100b0077b9966ccf1mr17537118ejc.763.1663683122937;
        Tue, 20 Sep 2022 07:12:02 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id v13-20020a50c40d000000b0044e8ecb9d25sm86535edf.52.2022.09.20.07.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:12:02 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:54 +0200
Subject: [PATCH v1 1/2] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-standard-menues-v1-1-839799192e9d@chromium.org>
References: <20220920-standard-menues-v1-0-839799192e9d@chromium.org>
In-Reply-To: <20220920-standard-menues-v1-0-839799192e9d@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=X2E+J6cS54HeJ20WA4jpZVzbo0rHgKMmPW1S9iv4Ftw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcousESrsQPUNLn7lV40/tCJr2cZbi775C+rqStf
 Pbzz0QSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynKLgAKCRDRN9E+zzrEiDz3D/
 9YhN1kCJmKDsd7DI41f6JuNyfs6wS6nggbA6RQLaqXzF+10cptWomyAYP+IoRrm+hfZpmGODLFfWCi
 C4s9MJKCuUkUrbT5xdZRCAUvYf0DlvAK7ze4akRjj1S8di0xva/ZfvzR2DneWD/LS3LA1A4s5KTVGn
 nY5BgJ8Yg5jWZUb6McXW0+5hoFMrMu28+JnmbKNAC15MR0DRn/yQUWSgUUlKIlu5yyW8CgFEWcAWFC
 Vy60jE3j1lHCzpZN7WZJQUdRjmfuroeJOQ6rs7TR41j3zPtUQ2gbMC1h8Sp/3Qknpmq6QI3gkl7Ft2
 6YAwxZ6gGDjv5C6zaie0F4T/EmXtepB17d41fUmggVMCffNR8+iguGpp+6zCCIcqfXYpUlCsi3UUyw
 PX0M5+0lnXCRPqgduKujlntr5F3sufZmOFY3T88bQBmUjIQAhbBhs8a97j0Bn2/+UZzzHHxU7XdC4v
 KLCO8jDuYf46iD5PI7fOpLdS5b7wNE6BntbHvS5kH+QdFPmrmxWqoYzpzWh1/NWC2BtzEY2OE7cHZI
 IJuaOOInpt0oUagDDPDVtUQIK5tB2T3GzCMg2Cl2poDDCgjAn28pR5LrghRLXSQ0l+oHyX3h2LGawI
 VtKGq581213IErWCXVymJ+GaGEDtamH59/EYb7kSJ3g/gJZs9Faod9URXboQ==
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
