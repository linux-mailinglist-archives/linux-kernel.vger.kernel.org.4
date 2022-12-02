Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAA3640C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiLBRWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiLBRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:21:57 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031F36F0F6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:21:56 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy37so13028749ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFcyBpj+roptImEjPj9piLF8BA0R7w/IlAfi2K8P7bY=;
        b=GJGQWn6xnoSY7Etym9vgtQmRI7e2aKzTXyoq8ceLg89ytjx8ExTNQ/K3mgnmQxKtcM
         hV1qZaRprsc75L8mzCcjtuWDDX0QUncg3zNHukS6UtvicoqqzZzmEFsPMGLmZLcl4ddi
         +W+iDxLGFAOL9kjjX+260929kQNvNuKcnyfvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFcyBpj+roptImEjPj9piLF8BA0R7w/IlAfi2K8P7bY=;
        b=zOCpEILkT7cOlfVJyrGY1HhPE/hdg3Yl/esyEimqTVsrn9ftXdMEYV5U5cC01g1U1+
         8k7GWsdihDEuArMBd6UNb5UiuUmDHLAv8WTmXgBdXI+g6KjO27BeHBlc1KK91kQoMMTQ
         O/I7wpFDdSyHmngY4Oqh9K59JdZGyXow3ldfrpFxBD6I4dVbZCgliqhJKuj6k8GML49Q
         OWC7+1y8GhxwjbpeBIjH42yRAy/7aY81XmNgyPnt9STt1hCyfnFDPOjl6UaPfVR26uct
         d29S8pYhNP1YPmkv5MbuT6/YsNFnDFE3l+f7k2Zhqa3kUU0o/zo03FVPe2+na7F37t2R
         rKIA==
X-Gm-Message-State: ANoB5pkjuGCNMCXl//Xuc7U4uj1+9iM2sbrsf0obVZ2SYzgpOHaAaaru
        r/5Qym3CAY3tEefQowR2MZKE+A==
X-Google-Smtp-Source: AA0mqf5/3EwwkFDNDpt4/RX5co4CpiVNv6SPq1gFyPHwyy3dZwynpKBaFQPb68/oRUU3CmpSgDkXlA==
X-Received: by 2002:a17:906:5792:b0:7c0:9e1d:c83b with SMTP id k18-20020a170906579200b007c09e1dc83bmr11992942ejq.68.1670001714555;
        Fri, 02 Dec 2022 09:21:54 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b007be301a1d51sm3206685ejc.211.2022.12.02.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:21:54 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:21:40 +0100
Subject: [PATCH RESEND v2 6/7] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-v4l2-compliance-v2-6-b0ceb15353ac@chromium.org>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
In-Reply-To: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5794; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=u0yMi5/b9HeKgqPvAbyKu4QWjgjZ09vQlVYM51vM0MI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijQrqdm7x9AeEez0Rs5z96/uVtOCtyrQXMM4olmo
 9fU5NWeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4o0KwAKCRDRN9E+zzrEiFiMD/
 wIK6XzjhijxUt99b5c1npLY+opxvbJa7ZuQpbCKzCAytyeXZd/lkx1P4vRq//8LVYj5gI3nBbbQMl+
 DBCXnM2x/kcUEOFfPv0XM3KbzvNr8aS56CvNEbF9BIqeAyBYxrjHth2EjXhhZdqY8Md3FfiN9YL0Rs
 JMVjuNsBYziJXZSwg8sm0Yb3ZbqabHwTZqUzivRHf5TcOVS9Sskd/gJsh7uVAI9i3fGQ1ilZFSVA9v
 PCe77hdQT5gZCm1UXPLWffMH3Rl5FFbLSESokwnuELflSggl73hc+ShGHv2gKJLbLriSvlUnH2XB6h
 4d+/hWENuAtgp7hDqbFDSNZFDBGPdBFJOkOIMrZIL/qP+oIlt32JPENS8JFRulB5flYlCUoYgLDzZH
 kJO1eDIO+AQv9TYKWjg2ie+2foaalLXA976Vm1iE0lcirnzkILGoAhCZOYH2dwh/0pQaLtvwdeR40E
 tzuSKxr6wyxtpeKMq0szztkA4rXpestkiE1DGnwR9vSWGSGxWtiJn4uf3093Hk9ahgCQWimIBoIgmD
 xXx7nl+afITvGrEhERBwHbDyWC9bLy7f1V70j94fwlKZVLc7IaNLoTfPvI+O9i1GGWLuQSDm8DCGbD
 E5eZWh3mnFARiiHwaXW/6SRIw3v2pCcbQo7J9Gi+gO21EA1F7mVqJLDqJhsQ==
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

Replace the count with a mask field that lets us choose not only the max
value, but also the minimum value and what values are valid in between.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 30 ++++++++++++++++++++----------
 drivers/media/usb/uvc/uvc_driver.c |  2 +-
 drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
 drivers/media/usb/uvc/uvcvideo.h   |  2 +-
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 526572044e82..df273b829961 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -6,6 +6,7 @@
  *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -524,7 +525,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
 		.menu_info	= exposure_auto_controls,
-		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
 		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
 	},
 	{
@@ -730,7 +731,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
 	},
 };
 
@@ -744,7 +745,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
 	},
 };
 
@@ -974,7 +975,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 		const struct uvc_menu_info *menu = mapping->menu_info;
 		unsigned int i;
 
-		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
+		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
+			if (!test_bit(i, &mapping->menu_mask))
+				continue;
 			if (menu->value == value) {
 				value = i;
 				break;
@@ -1212,12 +1215,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 
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
@@ -1338,7 +1343,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
 		goto done;
 	}
 
-	if (query_menu->index >= mapping->menu_count) {
+	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
 		ret = -EINVAL;
 		goto done;
 	}
@@ -1853,8 +1858,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
@@ -2301,7 +2311,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
 
 	INIT_LIST_HEAD(&map->ev_subs);
 
-	size = sizeof(*mapping->menu_info) * mapping->menu_count;
+	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
 	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
 	if (map->menu_info == NULL) {
 		kfree(map->name);
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..abdb9ca7eed6 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2675,7 +2675,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
 	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
 	.menu_info	= power_line_frequency_controls_limited,
-	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
 };
 
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index d95168cdc2d1..e6792fd46bf5 100644
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
index 644d5fcf2eef..7e2339fc256e 100644
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
