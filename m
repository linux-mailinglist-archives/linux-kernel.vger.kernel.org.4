Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FE669BE04
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBRXxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBRXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:53:16 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07551E046;
        Sat, 18 Feb 2023 15:53:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id o9so124621ioh.6;
        Sat, 18 Feb 2023 15:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8dRFubllgPMQwFe+3w/omP5KqfxViMUIftdBQEg/jc=;
        b=Y/lJ2L539S2G9omIG1oQRq+05OVfNIYD7mZeRqcQOUUu7mOQb5uU4P9690Z/KZ5szP
         Y+Ut+JJcPrwx06fzYOa9rO3GOijaPnc6Nb2H43xMbr3w5vm3UwJCSXmcDAO/HV4qWKlr
         e1EGJNnqPP1bl5F+3qjf9S8zb34zrOn1XHgbxx8e1UQa6NyiQYwrCHQ55c+hYNaZE55P
         4peTkI3rxXrxEK8znr+sSYAiFi/0CXpkFoRoQ9f7e630FWyIIj21RtrE+ilAL4Hv5gsx
         y0aKOEjDKTp7grYWyAqeuM6O3oOZ3EprTfXHdS9RKaskq8xHCZsqcl2CZ0Gvxgs5B+XD
         4AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8dRFubllgPMQwFe+3w/omP5KqfxViMUIftdBQEg/jc=;
        b=Q6PamrNleJdHNtjdBP8CvOUB+ScdccQbblPbcz3sQRmPEurHv9R8k7jUq/UWNrRchI
         FjlOLrQwowCTubbZXWHN9gdybQcIKoJ9CsI1w1k24xfW4M7sreQdV/9Dh8hXpUH970we
         OALuWyLqS2+hPXwyUY7yfWl/+YSyg41GW5HVgrmWuvIF1eskOvdtYS3AJJd1X+OWfMOw
         0POzz27b75g/1JgyLd1xiY7MVx9I78VaiyYaSTtJf7vxk00cEUBame4ah6tEM5wI55l/
         v5sYWuK9QqVVkNvyTD+bKN3x2wPAjJu6zRH2DUaz0lcIfLXfiM5kwP9/nY9DoG4YpgCI
         KKfQ==
X-Gm-Message-State: AO0yUKV3F1IX2ABs0YmQ0OfSXi53o/s3CU4DnsprjtRsdUU/jaWQyc9i
        NOL7mBVfHvgw/a4SV3kZwbr84N9ZFs4=
X-Google-Smtp-Source: AK7set/99XvJpypmML5VylJZSI53XvQEHoDWOfUvuB1or/ut+4ADmEJtP7q7nJFtrlM5+cBz0Ym5zA==
X-Received: by 2002:a05:6602:26d6:b0:746:ca58:fcb0 with SMTP id g22-20020a05660226d600b00746ca58fcb0mr1043422ioo.10.1676764395198;
        Sat, 18 Feb 2023 15:53:15 -0800 (PST)
Received: from james-x399.localdomain (97-118-149-35.hlrn.qwest.net. [97.118.149.35])
        by smtp.gmail.com with ESMTPSA id p10-20020a0566022b0a00b006e2f2369d3csm2662844iov.50.2023.02.18.15.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 15:53:14 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Pawel Osciak <posciak@chromium.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] uvcvideo: Add support for UVC1.5 P&C control.
Date:   Sat, 18 Feb 2023 16:53:03 -0700
Message-Id: <20230218235304.1390500-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Osciak <posciak@chromium.org>

Add support for UVC 1.5 Probe & Commit control.

Signed-off-by: Pawel Osciak <posciak@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - rebase
---
 drivers/media/usb/uvc/uvc_video.c | 34 +++++++++++++++++++++++++++++++
 include/uapi/linux/usb/video.h    |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d2eb9066e4dc..127d6428b827 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -256,6 +256,7 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 	u16 size = uvc_video_ctrl_size(stream);
 	u8 *data;
 	int ret;
+	unsigned int i;
 
 	if ((stream->dev->quirks & UVC_QUIRK_PROBE_DEF) &&
 			query == UVC_GET_DEF)
@@ -327,6 +328,26 @@ static int uvc_get_video_ctrl(struct uvc_streaming *stream,
 		ctrl->bMaxVersion = 0;
 	}
 
+	if (size >= 48) {
+		ctrl->bUsage = data[34];
+		ctrl->bBitDepthLuma = data[35];
+		ctrl->bmSetting = data[36];
+		ctrl->bMaxNumberOfRefFramesPlus1 = data[37];
+		ctrl->bmRateControlModes = get_unaligned_le16(&data[38]);
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i) {
+			ctrl->bmLayoutPerStream[i] =
+				get_unaligned_le16(&data[40 + i * 2]);
+		}
+	} else {
+		ctrl->bUsage = 0;
+		ctrl->bBitDepthLuma = 0;
+		ctrl->bmSetting = 0;
+		ctrl->bMaxNumberOfRefFramesPlus1 = 0;
+		ctrl->bmRateControlModes = 0;
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i)
+			ctrl->bmLayoutPerStream[i] = 0;
+	}
+
 	/*
 	 * Some broken devices return null or wrong dwMaxVideoFrameSize and
 	 * dwMaxPayloadTransferSize fields. Try to get the value from the
@@ -346,6 +367,7 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 	u16 size = uvc_video_ctrl_size(stream);
 	u8 *data;
 	int ret;
+	unsigned int i;
 
 	data = kzalloc(size, GFP_KERNEL);
 	if (data == NULL)
@@ -371,6 +393,18 @@ static int uvc_set_video_ctrl(struct uvc_streaming *stream,
 		data[33] = ctrl->bMaxVersion;
 	}
 
+	if (size >= 48) {
+		data[34] = ctrl->bUsage;
+		data[35] = ctrl->bBitDepthLuma;
+		data[36] = ctrl->bmSetting;
+		data[37] = ctrl->bMaxNumberOfRefFramesPlus1;
+		*(__le16 *)&data[38] = cpu_to_le16(ctrl->bmRateControlModes);
+		for (i = 0; i < ARRAY_SIZE(ctrl->bmLayoutPerStream); ++i) {
+			*(__le16 *)&data[40 + i * 2] =
+				cpu_to_le16(ctrl->bmLayoutPerStream[i]);
+		}
+	}
+
 	ret = __uvc_query_ctrl(stream->dev, UVC_SET_CUR, 0, stream->intfnum,
 		probe ? UVC_VS_PROBE_CONTROL : UVC_VS_COMMIT_CONTROL, data,
 		size, uvc_timeout_param);
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index 6e8e572c2980..e037d28c29ac 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -435,6 +435,7 @@ struct uvc_color_matching_descriptor {
 #define UVC_DT_COLOR_MATCHING_SIZE			6
 
 /* 4.3.1.1. Video Probe and Commit Controls */
+#define UVC_NUM_SIMULCAST_STREAMS			4
 struct uvc_streaming_control {
 	__u16 bmHint;
 	__u8  bFormatIndex;
@@ -452,6 +453,12 @@ struct uvc_streaming_control {
 	__u8  bPreferedVersion;
 	__u8  bMinVersion;
 	__u8  bMaxVersion;
+	__u8  bUsage;
+	__u8  bBitDepthLuma;
+	__u8  bmSetting;
+	__u8  bMaxNumberOfRefFramesPlus1;
+	__u16 bmRateControlModes;
+	__u16 bmLayoutPerStream[UVC_NUM_SIMULCAST_STREAMS];
 } __attribute__((__packed__));
 
 /* Uncompressed Payload - 3.1.1. Uncompressed Video Format Descriptor */
-- 
2.34.1

