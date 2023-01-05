Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A466F65EDFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjAEN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjAENz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:26 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868324FCF1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qk9so90027496ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2+QEDBh605/YOw8UIx/peFMX1PrmbZbNImTnYA7xrk=;
        b=Pa8qDTnmM4CCZR9hDOxE4L6eQlUqS3whJeBbol8B3ZfCp0ImrDG85CGnDNMkWLUpEI
         cyeAmbrjGIVDCHgCFDebWET990dzSJ0Od2LAi4tuJ9R4syhOMLeUq2Hzrvwppn1SpMeU
         qII00JtWfSY/QW9qCfuwpoznDMM8arRdvSC7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2+QEDBh605/YOw8UIx/peFMX1PrmbZbNImTnYA7xrk=;
        b=X+BcAStglXKxK2xOGe2W2UGzKSSBCQYzCBbxW4F+99UYQlZwcPru6P32k1vnu8iJ2v
         VRS+DGaVAfyrYsN0mZrfi7VEX1edN1TiHJZ2K5KQDFkiKxq/lq/A5mgsPCLqM9OEMBYV
         tNoPtgmVexN+KAcW5LF178NkHZs9gPCAghPpkUU5rqfFpk0z/HBylepWEfan2A7Wp808
         scophMkFhQbLDZIr0Vzh/W5CWH1GqB8ffWy4FWGLWEmqi3Saa93BXryO4q9OVmQOu27H
         N4ijaq65/T2iEY1X9THD4YaevQMKUiCeKRPuknh3yv0+WdCBgxKd7sfMaodygGlq12/5
         WivQ==
X-Gm-Message-State: AFqh2kpUJWskv0vr3AIDJJcws7IQtd0nX58plu6yvkDcAWbqyKz7dDtD
        B9Pv40sFySspBtIUm3PJhg3gaCUJ7MEmsK/VGEw=
X-Google-Smtp-Source: AMrXdXvOiPS9P0xlJpzRLQUHDkrNOud+i33QounGhFT/MCDIptlPUnBbebmAaNpQtfdDXf1sHCQ4bw==
X-Received: by 2002:a17:906:309a:b0:819:7d8f:9684 with SMTP id 26-20020a170906309a00b008197d8f9684mr48271943ejv.72.1672926798078;
        Thu, 05 Jan 2023 05:53:18 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:17 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:55 +0100
Subject: [PATCH v2 4/7] media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-4-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=cN0QwI5lzK55LyNPAeknpt5DPiDQGV+bwKxrSvbPPOE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttZBNkD4q+2Q7aefxS41plv3QM7InsrCrV9PyINO
 S37kWQ6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWQQAKCRDRN9E+zzrEiKLED/
 wP0Bkdbhq0lYQCguiYJa2kj8DafZ76fY4GvBAhUIgt0QafUiP5D83pWTopu5h4w5kn4ihLpPnEhS5C
 HSzWN7+4sYdKqQED7wzOnmqF3H+LJrXKWBFwGk1ovLtWzf/0jz6L7dQPCi8QKdr1jjIKgFSk5/29gH
 lHLn5pnvAyvNvIl2iLg84a7kr6RaC9leFxadw3WJOG1Q6lweQTkBJxzquoJ2ikabUVlMqy11TY6GIe
 HYWM0ybYUmo9RkwdzdyGyq7HIk7d0oUpJ942htp55+ShGuTozFuZvuPZWGZgVs1UzyzKdAPYzDXTb+
 bSroRm0nigqHUznxLrTJJffQB0jNnHA/T5YZ0OuBJl7ibSjXwCMeId8ChV7K1/NuxMYcrd6AMqSFmS
 qXRAIpGq/bnwZfLfNy8BsutnL+vlbEKPNb5ibpSkbdhll5MTktixKn7VqATc607KpSHA5JBbf35eag
 KE6GSv2hfvJt7aBvFY3177OfFi9w8i2qT8s3CvRsgjgy2hsnb6E8q0SWEl2CncPyRjZqSJK8Zk6sua
 RyxU6u1WxaJvdOVzCvlxfBuiwsUCJNubBJmkGm9tRNuKHU+6hdBYfaE29NHvtB2//aGbHUVqEHLLFG
 NJ8anavt6VS7i3oI2IzhHWQaRYuuFOwWCCi6oRFRmdmVmQm6CNGISuWdXyYA==
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
