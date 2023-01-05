Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5F65EABF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAEMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjAEMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:37 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E532EA0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vm8so82788193ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2+QEDBh605/YOw8UIx/peFMX1PrmbZbNImTnYA7xrk=;
        b=cNpxdmmypyDiQSrE9C9OKdhB0yaPnURMEJUdX04q27l/cwa+Ay5KqEZL1GR2uqObwR
         laGHm1XoaahdfyDfWa3/L9bS1O28elavG156hsB5YJgExcczsOdko1WhXpsAoIFBEBNw
         7ujPie3uMUWqwZVeESTkkVyllz6vPrQ/rQvHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2+QEDBh605/YOw8UIx/peFMX1PrmbZbNImTnYA7xrk=;
        b=SZkeGdnovJr3Sa6qCMCFTy3BwTmNck9keDAxMA3wivsy7eWCKX5WVEZ8rf32dIhpYG
         PpW5qF+CWv6QGJoKGqh0sd4mu4kRG62LOTsJOBmG/eScL+5q6wZ0jyRXqeftXiTyTZd+
         uwBQmPfr79iLTe3ocpkH5vBm/+vmKoLp7WduVPUvTYbrr56dxI2tFGfkrQ8V+kJspzfC
         v57TW4g9XRr2MXQRI8rEELjhgTXLs7ViKlHJyro9xeW3k0au7lYTVHacuv13f1uzgUEO
         CKOvDJQWDiSaO68rgFd8FtwdG6Fv74VxmWHvRiFwjSXm+zVPX2fmTl3dBgWxJIGUas83
         JwuQ==
X-Gm-Message-State: AFqh2kr4dfdpkCbLRAc0OLRUaZ5CBeyJJx3DuQfsBnUH3W9FwdazpXFY
        0En0sEx5aOQC8+90HLcAtekA8g==
X-Google-Smtp-Source: AMrXdXvV6hjg0KE+sDjvmJpaBOXBh8wh7dTYlDulsPRKGUNY5B8cSW1eYex+dJjfDZyh12fZ31JeDg==
X-Received: by 2002:a17:906:1dcd:b0:84c:c121:dc53 with SMTP id v13-20020a1709061dcd00b0084cc121dc53mr13045287ejh.34.1672922010412;
        Thu, 05 Jan 2023 04:33:30 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:15 +0100
Subject: [PATCH 4/6] media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-4-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cN0QwI5lzK55LyNPAeknpt5DPiDQGV+bwKxrSvbPPOE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOPXayDHzuGg11H2cDJ7V6FhwEQiGPMiMZnD7Dm
 F/Wv9RKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDjwAKCRDRN9E+zzrEiHEWD/
 9QsgQIbF407r81pcqrt3v84B7q/E9Zw2vZstqZpu88tvFsSqqs/Bhr67ZC4E76XA4bOVT38/5Es3Up
 Prjgq0W5IzATE5sAGpz46/edKiuD11YuRmYwNwSFoP63FAiQv6QZe95TNtk5mFZz4ASOebqToRzBPP
 T74mUSvcKo+S3T6Glu4d+Dg76jZyDtWNFq1rtuMCbjK5p5bQgy5UUpB/bYfQbgXoZmRvlC4NeKO870
 FDdQyy6I/L1BTFWqIy0Pnf66Gqa+1NXHrYAG6GiyYeHJoPXaW0ZsNTgiqAGRwgWWBES6j4YdKppohU
 tPsN/JgSUjVGWUuNYNB+XXpTtC66J7aaODLve+6A9pjDw9cS73AI/g5X+M1Ginja9+hmCMmHDNBEIu
 ohm5PKGytdjOFRd6l9k0DRkMBRUKnF94S+7KaXrP1PXcLAqk/US4ErFtEdCTOrjnswsqKRd5gLB++C
 Da5b7K1gmsVAwJYoC+dUz1bKIAZ54mrVkX5dYabXbSEiYFP1wFZksn74DGvnhPdTby9TMtzTkguo0S
 E6WaCT+lglgLk6ga5BgHG8eMcXvX4nrOdz6uPRxfhYxYGyw5CHoDnSqvXgjYkjyfoeAoR8rziLzQKb
 +X5njXwhuTBfcnFGuFRbOaovJsKqrp7uU39Vzq8umUc9VSqDI0PRjHoFVkqg==
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

Convert the array of structs into an array of pointers, that way the
mappings can be reused.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 81 +++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 2ebe5cc18ad9..9af64f7a23d3 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -723,34 +723,40 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
-static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
-	{
-		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-		.entity		= UVC_GUID_UVC_PROCESSING,
-		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-		.size		= 2,
-		.offset		= 0,
-		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
-					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
-	},
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
 };
 
-static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
-	{
-		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-		.entity		= UVC_GUID_UVC_PROCESSING,
-		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-		.size		= 2,
-		.offset		= 0,
-		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
-					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
-	},
+static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc11[] = {
+	&uvc_ctrl_power_line_mapping_uvc11,
+	NULL, /* Sentinel */
+};
+
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc15 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
+				  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
+};
+
+static const struct uvc_control_mapping *uvc_ctrl_mappings_uvc15[] = {
+	&uvc_ctrl_power_line_mapping_uvc15,
+	NULL, /* Sentinel */
 };
 
 /* ------------------------------------------------------------------------
@@ -2506,8 +2512,7 @@ static void uvc_ctrl_prune_entity(struct uvc_device *dev,
 static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 			       struct uvc_control *ctrl)
 {
-	const struct uvc_control_mapping *mappings;
-	unsigned int num_mappings;
+	const struct uvc_control_mapping **mappings;
 	unsigned int i;
 
 	/*
@@ -2574,21 +2579,13 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
 	}
 
 	/* Finally process version-specific mappings. */
-	if (chain->dev->uvc_version < 0x0150) {
-		mappings = uvc_ctrl_mappings_uvc11;
-		num_mappings = ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
-	} else {
-		mappings = uvc_ctrl_mappings_uvc15;
-		num_mappings = ARRAY_SIZE(uvc_ctrl_mappings_uvc15);
-	}
-
-	for (i = 0; i < num_mappings; ++i) {
-		const struct uvc_control_mapping *mapping = &mappings[i];
+	mappings = (chain->dev->uvc_version < 0x0150) ? uvc_ctrl_mappings_uvc11
+						      : uvc_ctrl_mappings_uvc15;
 
-		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
-		    ctrl->info.selector == mapping->selector)
-			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
-	}
+	for (i = 0; mappings[i]; ++i)
+		if (uvc_entity_match_guid(ctrl->entity, mappings[i]->entity) &&
+		    ctrl->info.selector == mappings[i]->selector)
+			__uvc_ctrl_add_mapping(chain, ctrl, mappings[i]);
 }
 
 /*

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
