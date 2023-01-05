Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EFE65EDF9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjAEN4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjAENzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39614F119
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so90017241eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i22sBtg5sgJPjmyCPs4YT31o+9MgBiTxsORfyqFHwvE=;
        b=TivNd1L3MetgrHzNbzrqF6gsxMkFN+oRpnymkK0S9KBqugBCT7Tx3zd4VLTYoj8VJS
         kb1DJ3+wEMtRymOQnMfKO2bh9xPMNKt+rsmrP9ipHYKnp5in1/euDOO/yNMGI4zln7aH
         KLoesQ4J+7t4AFidOICzHCQGyAP4MgThHrlz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i22sBtg5sgJPjmyCPs4YT31o+9MgBiTxsORfyqFHwvE=;
        b=AYgYqf20uga6m0OjZmj5TMLgVl3zP5uKAEM4uSzFYPG4+SVXparVEo02NhNumkiIG8
         +heK4J8ZQTKrGhH4GeJDvILpbM1qWTWuLZXnWl8vyutYZpNM3qLhvknajD5M6duuIoKn
         czgkmAsiVCK7vU9lBIODI9or0hbkPDRqfL/TOwfKPp4+YqktRYZpreA49xEK8XIciWVP
         r7jimxVd7B+H5vdn8gy/Ygv20hg1BcSLrnVq3UvkRqEeK9TG0v1ySLxMAtYYittAywFo
         0ZmNLJ5OXXti2dmNuHysAX7iH/P9s+lTo+0ReQl2/fbbO/ycL5abILHzU9XazTmAyizS
         +QaA==
X-Gm-Message-State: AFqh2kqexFUThFER8+O1yhW7m1+qeVG6+8Z7PsVTMkOGnyY410+PXuxG
        i/3vKP6hKjK4oSQ111s19kq3XA==
X-Google-Smtp-Source: AMrXdXv44elPCiEVRpl+fjdUJ8F8ssFDQdBYx0YXbryye3AWrGLkUKiyMdC6A3WqUWzxIGQRr70b3g==
X-Received: by 2002:a17:907:6d0c:b0:7c1:652:d109 with SMTP id sa12-20020a1709076d0c00b007c10652d109mr52072097ejc.35.1672926797359;
        Thu, 05 Jan 2023 05:53:17 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:17 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:54 +0100
Subject: [PATCH v2 3/7] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-3-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=c0qCW+bmUSyESwPogSJMQMg1NsP7nOLTyNEVHbIZYzQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttZAEklFRkFOGUsnQefFhlT5IB3ZM/mBPIRcA6kM
 rXJNK7aJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWQAAKCRDRN9E+zzrEiAfBEA
 CQNUUXxTzxVcBAMm8hAnHAajrQRxKGBvD7aTNdAAikwRG6xuy9/0e11wWC1kb0thvwsOcQDim4+hEy
 USQ0jCMMpObC1coBPBRw0CMLe9sfpia1yPvVqbjpSsCiO3bkAKnpnTTiX8THH0bOrUVL2z47SIOJHj
 Azvg4br79VefCqsK2u8XLEH6PiI7ltxjYnhJ6fXnvmLBZhroVd6Bcc5I3txQNaO3WmzP86Oceq8aP4
 vf06CVwUi8oSWQiI5Am9B7Z/V4Wc2odJW71ADi6L1GyX2NyEOMmYdGA20df996MUcpYQrUM3LEhoGA
 JTg21NYE4f6xNHCzOKzP0KShstF5eUHIU4lsdPOWBFWeuQDh7+GlFj1nDQxu8Y8pDXF0mtEcGeYy21
 PTwxe00XouzV3yTgN3CVSpU5ouNSo4I0XS4Oe1UAxc12KqYJEwiUMEPFsz/Y933DGbsgLzaIvkqI7H
 2BH0ycEd+1ffu8/9n4dxJ76qiUUh8GbJO8rK2U5Tp2vDZbmVBwmygEpj/UeNQaF8rM/maoDQmXhDRk
 cfzlniiHHpXuKweUWv7/bPRkRU9GdmQ6HLD1sQALiULmh1pvsNPot1m8HNswrvFg5mmW3dIcgnC6J9
 gyuQiPtZNH0veMEWueeaINv1+UXdZdq9rllEtGnCLVc83NrssSGlQQ7DISqg==
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
 drivers/media/usb/uvc/uvc_ctrl.c   | 33 +++++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_driver.c |  4 +++-
 drivers/media/usb/uvc/uvc_v4l2.c   |  3 ++-
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index ffa0e2654264..2ebe5cc18ad9 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -6,6 +6,7 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -525,7 +526,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
+		.menu_mask	=
+			GENMASK(ARRAY_SIZE(exposure_auto_controls) - 1, 0),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -731,7 +733,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 	},
 };
 
@@ -745,7 +748,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
+					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 	},
 };
 
@@ -975,7 +979,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1228,12 +1234,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
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
@@ -1354,7 +1362,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (query_menu->index >= mapping->menu_count) {
+	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1868,8 +1876,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
@@ -2306,7 +2319,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * mapping->menu_count;
+	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (!map->menu_info)
 		goto err_nomem;
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 6d08457ecb9c..e659670ea2d8 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -2391,7 +2392,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 	.menu_info	= power_line_frequency_controls_limited,
-	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+	.menu_mask	=
+		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 3edb54c086b2..0774a11360c0 100644
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
+		map->menu_mask = GENMASK(xmap->menu_count - 1, 0);
 		break;
 
 	default:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 41ba0bbd8171..a8eec43cd860 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -115,7 +115,7 @@ struct uvc_control_mapping {
 	u32 data_type;
 
 	const struct uvc_menu_info *menu_info;
-	u32 menu_count;
+	unsigned long menu_mask;
 
 	u32 master_id;
 	s32 master_manual;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
