Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819E265EAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjAEMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjAEMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3152148CDB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:30 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id i9so52608012edj.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBGZezEaxNT5mYG63q3/p+giIEe5CEbFfULH3PLbvPA=;
        b=Df9cDEPnMrMjAc51R/8C1RBphrS1ZMgbwsQ/zhRmWfUDDsDg3bGg5u6jx6p5hwzFWC
         GsRGGfNMFgigqf7M77muxgzOUhQDiemPUB4Oo2tcRjkdcrrajkaTkmeG78fuOFPf9/vT
         KNh6McVPkjPQxadcyYbwu1+l5CBlp7JzbLwSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBGZezEaxNT5mYG63q3/p+giIEe5CEbFfULH3PLbvPA=;
        b=yAtU7HKBosMQBTjNWmKTBEN8VBwl9V+vMoTHTXGcMf+Pbpv4+091D0GQdTidqQMY6C
         Bt6Eed814zm6T+asEhqmWjUq/YSZmZcA9dqQcclLMvvAA5YXweGzv9kBwxmjunaAo2WY
         eilf7FlDlRDJzgpvgw9aRaDPu2K5l5+dYh076jRzZttjihALVQ8/KQ7yai1kLhmsJVul
         RpcDcdLHAf2/+EIdluyNcXmGrvcg6zt7m2H4Jk4YKwoO6VyN5755y0KGiGXkFsDtgLpL
         UYgPmv62FmdvZ8iwuGJ3BtS4i+EVQy8fGsiM2+I75E6DwOSpKRniUIGQkGYa769LbmU4
         LTjQ==
X-Gm-Message-State: AFqh2koCJgGpXjTCBmJ338u3vNipeCGtXwmpzLFc5zv7TMxkxw+CPa0P
        ZbCnTgp2lxQW5GuqHmKPUcArXg==
X-Google-Smtp-Source: AMrXdXumTh9LyaZsKjzwVgDvGs9H4SL7sEKDnq+oz/KGvIUf02UGbJS8tVBflJepyGFHLFDsd6k/ug==
X-Received: by 2002:a05:6402:2936:b0:48a:269c:9dc8 with SMTP id ee54-20020a056402293600b0048a269c9dc8mr20164724edb.10.1672922008704;
        Thu, 05 Jan 2023 04:33:28 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:28 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:13 +0100
Subject: [PATCH 2/6] Revert "media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-2-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6121; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=Bll6tbezraJ/a0Cf4Y3tLo27i37SeM2dqnIYPB0QUok=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOLaFre82MreSAJjzDj3FfC9VRnHyn8bhWiL1lA
 HFCkEkmJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDiwAKCRDRN9E+zzrEiMR4D/
 9YVpFxZSNP0ojhSnacp+OFzjlaqROm+uJyTn9XxVnxj3tnKiYI3La2Aj5BwYRqJaG0lEujMIr7yChf
 +/Wz65easwt9e5V5TVFj5I5BOlXE91nKMr5MSsxzKnrcT980J38dUWm64i92tb47cP9PpXd6xUvZit
 aE7OKee0BWJzzAzv5Mgfyz6RyWz0NE3b4FL+vGfiH9TxobQqNh+G+f9khgETQFoJvUKLDwffMNS4aR
 Orf+UZnsRPeQdltMkYBwqoG//kwtzIzSFZE/P8tUQEEXLfGvs811wRQGUzv7ptJE6O04L+bGRtLYty
 0L94obfvsvQsMdL5xvKk5/yT+s5t1WsZD/5HkEo29WpdnR1YABuHuLmiTheq0N6Wv1YJxdnAcQ54dI
 kmt9M1yWyXyUDfdpaH1uiQDQOMDB3RnBxUjiNghDjpqvLJqf461BbvSq79G4TlscqJeyIzN2Auc+9c
 aLodDtPTcF3wToXMpDpBK39rBPfmM+a5/vgb5P7QAcN5DggealX2BGOFLenf/4f+yy7W2wWiF4LqRf
 LpRAY2ukecVjk66Qz0VUMFnYCFesw1aFOdHqbFBrk9GG6Wtvw83/v8z6+nhlWEpVpljVZIsROxJFKw
 eOKcu1mMiHR9kCD8l2mERoa7gRIV+bs5Mv5W2ZS93l2BcxrTo383bTtO4Sew==
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
