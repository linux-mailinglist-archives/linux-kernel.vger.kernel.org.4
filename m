Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54165EABA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjAEMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjAEMdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:33 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DAC4C71E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:31 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v30so1286983edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i22sBtg5sgJPjmyCPs4YT31o+9MgBiTxsORfyqFHwvE=;
        b=kUoF+3psXi6YYHua/fexy8hRbaVw/bjVwDGCyEwL1F8UoKtGOj3WKAWT7O/aeNYixd
         mME/0Lo2NjAWv2iJ9Wkx1zjw4A8QhN5RkHjYkPmLmAz5VEuehZkrSaiUyrGJrQrmDBQn
         KeSyPXp0jnu/vvJcgbB+gKHT1VM/dqCSGrHMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i22sBtg5sgJPjmyCPs4YT31o+9MgBiTxsORfyqFHwvE=;
        b=OVEhEWwnrBtJS1FV2U20LMTpzuUFcoT/ALx1J6ZHNOugkEKfg5j4O0UqJhN6/1/FZM
         DcWfX0NrW4bZrLCtdttKPVyIowa/rTz0D9K8EhGl4fGvaOJT812GbfcmIc8Yapm8xflq
         /tgxjoCld0esAhhjqdThgZq+shYVnZ0uOk0ePE3Bf745kRouH3A+4uDS2nJi5NkiEPvw
         OIPmi0GC+FnXQDrk9hsowIy3Pkm7pUvljQf0ldFsP0YeqMx3udwY/ZQrS+Mq1KUsg7GH
         VhODoTVtYEwcV9GLWXi/G5r9ChIPRowOyMCTTkkTob6zFOQ5UoUI8irUPfPso77HnwVB
         2uZg==
X-Gm-Message-State: AFqh2kpkqbQ9y+5Fr6OXc6fVuF5Qpr48C4QUA7jVqbXPNEW1JHvKcHzC
        CjmaMB37P8V0iPbujXdZkCE3XQ==
X-Google-Smtp-Source: AMrXdXvsDxiOXaTu/ZTzT6hCrZZjc8Qye/a5EyMhfIBPwtrRdlApvRhhk5e2mjxzHpE1IjhXBgiQiA==
X-Received: by 2002:aa7:d6ce:0:b0:491:6ea2:e883 with SMTP id x14-20020aa7d6ce000000b004916ea2e883mr2569742edr.27.1672922009623;
        Thu, 05 Jan 2023 04:33:29 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:29 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:14 +0100
Subject: [PATCH 3/6] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-3-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=c0qCW+bmUSyESwPogSJMQMg1NsP7nOLTyNEVHbIZYzQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOMo+1cjRYFlPFKA36T8b+YypA8tCALF83TCx0V
 agb4fo+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDjAAKCRDRN9E+zzrEiC9rEA
 CZarCBtHy/lR8iglZryXmINPspqIFF4SkE7qp2HF7YI0PbqLUF5vANSeytURo/5QN/tdLQ/q8/FKbC
 wx9R4ZoSqUYAtyn2HER9/Z5NYWuM2JTV3CJz6nbXnqHOLQq5yTcGxmXthyOH4hav0rb+XdfP4qAraH
 NOO6ClawjB9OZImv4OahccWlu0Olc5CX12CoqLfSdeL6J+1f6CxQFAhKPPOVfJj/Wt1D9vPUnLBjTk
 +rdTIsGsULelS61hXqaE78oBBpWYk3r0v4PPAL+OUzy37Dd/tTWwhtRRxrOUOcs5RAXYXVXtCjs9Xh
 A6sb71AsrO355PELeeAW/B96bIggfNYTFeoeGD/Ran5osthiYWkKQHV3f4nAjggLWS9d2St+49ADsa
 S/3mIj4eqe/W/K8hVG/5ggsUWvV7uVKbIIJyt5omkX56XDHA6arGsw2wWAIrpZCEVdN9ZP3FOz1lkC
 FHH3AfRWpm9dfpVl6dsC7Nig1IrqvnjK6fKw+oEK+WaICrcjMnCOO04MgIiQfXGj2qs/Ml5Fcdttwa
 aXm8nX3RA1qfO6tGLXW2lqJnExLCgKXmqliRBu4TowTd4bbmV+xrHrCniapicYd48Cd94cvk9tX3BP
 NM25oHE4neCGcThuRN1oFVg63Dw/xrgr0QaUdJCbWly1fdR9OUUkhvCyEhHQ==
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
