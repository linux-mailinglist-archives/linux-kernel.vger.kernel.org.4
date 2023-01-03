Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C67B65BE8D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237466AbjACLCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbjACLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:01:58 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9110D9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:01:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy8so8771344ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00bD41CpohMBMgWN2aRl98+MG1NWyw9aXdRxmbyLX7k=;
        b=lkh5HCyhJ0VSthqIJhVg7LcOAC5++DcCafGeW+njz7gDkKybj2yDo9MQKVo5UXRT6G
         MILYofG4/Z6AMJSCIsZToHVaDBomPh1H6siahu7wUBPJpaihWnRtYYNnsM20RVRiDtUW
         n2CZfMi+KUMjSk8bwX2x5599R1zGl7KIARf58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00bD41CpohMBMgWN2aRl98+MG1NWyw9aXdRxmbyLX7k=;
        b=NbLm5U2VH1E+4C/4yUnxXmr7bPBQtsOgKyYqGsAtP5/8ylvkV0IUOjQT5Qj0RDRpVW
         hQl2z//lnrnEziWeiOohiXuT4lecXIdL/qwT1smYvOhqg7oOPvOv0mbBowBQJrK/L5Bk
         KVzbejllbh+L3nkiXChccXERTW7LraJk2Hd5GyPRLrIgNPROhMX/rqsWi7x96PG/RMzH
         nqEzr8ezE1v2wFquUSFlfhy20TnnOifMVxLvgU20ApssnJQs1uul8A9bm3pGXsHKN3y0
         ZcXjIcpq2s7MxBxbf8ROHRCmxRtbve0WsAOACe5OkiNRAteJOn789Lw4nKwJ1jNPSwRY
         ORug==
X-Gm-Message-State: AFqh2kpTxWdtBZ4FlTiHoMSNxfHIReCK2DZdnnexVKpSg2ue5RxdYy5N
        D7B/cuEt2VT3onS+YinqsMJ4pNalgf8j8LBP9Vk=
X-Google-Smtp-Source: AMrXdXulMSINEtzbSpMB3sr1ndMTGYRfhkV9njBGjb65OWUwvaklRjeHlms0gQxxrbKdq99S/2IKSQ==
X-Received: by 2002:a17:907:8e93:b0:7ae:bfec:74c7 with SMTP id tx19-20020a1709078e9300b007aebfec74c7mr39110590ejc.72.1672743715986;
        Tue, 03 Jan 2023 03:01:55 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef23:1430:9acc:b68])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090615cc00b007c0cd272a06sm13944331ejd.225.2023.01.03.03.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 03:01:55 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 12:01:23 +0100
Subject: [PATCH v3 3/3] media: uvcvideo: Refactor
 power_line_frequency_controls_limited
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221101-easycam-v3-3-2c9881a7a4f7@chromium.org>
References: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
In-Reply-To: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3328; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=U6+fv6Oz+oBYLUlCti95XpzN5zRXjjLpaYFVN2dc0HI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtAsep6BRBKmLrGo7Jh0JjciKXjPQr18hFu57TlyO
 Go95FN+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7QLHgAKCRDRN9E+zzrEiDfTD/
 sED2E32h08CttZhf7ECpbeysdAs4/o8+xOE0p0bCSKi5Tjk2X2z7qHE6CGs1mKFD6sXh4bArM/yatP
 2eBzUH3JooZyZI0ZKYqrm8ZPsvYEDrLYYeErHU1D1McJsSoOUeKFLrLU+/VjfRthUB5Jd2mERmJkmv
 FONN68J9MWdIJO5P9rZk6qYWpxBBG+FULClMaf6xc3PkpM9CXMeBeInUC1uCveQ39M/rjjaA9zSrud
 gkhBFDxf8qBPZZ0v6u3l652X8k+++DLdW2Hu4J+i9iod7zaTHMesogtkzYXktqNEXE1oLM2Eb8aVxx
 n3KohB6dLJO4hVHryA/Ls3ML9zmQjBi/snepflN5/LTFbH0afItxxc4mEqMzGrr6C63Jfc9A7R9TAQ
 QJY5nSUiq/58UfWCbB6qdR9D2SKhxUAxK0ix4AUpvZgQw1BImKLtV/g4ix+O7i71hd0oJXVGa2dmXo
 OHGaHnTqnllCnUAT5FHVVeTB+KeF2UtdCUdlECRn7sqGTInQxqD785P17/IE3uquCIg4w1FWRxXmLO
 63Ofnn8KevPELj3tOXP3H/a5gYXVR+Q9W91eIIh7P1GHnhHO9y9DcoSDgqVjDG06iINKWHARnY7+iw
 v8eoVUMyQ3sf4YqcAHBAW0xD0Rtldqn91Jm1pv3C6NLexP2bckaidYSwAXWQ==
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

Move the control mapping to uvc_ctrl.c. This way we do not have
references to uvc controls or v4l2 controls in uvc_driver.c

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 17 +++++++++++++++++
 drivers/media/usb/uvc/uvc_driver.c | 17 -----------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d8283d71bc96..4ff0415d8bf4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -370,6 +370,11 @@ static const struct uvc_menu_info power_line_frequency_controls[] = {
 	{ 3, "Auto" },
 };
 
+static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
+	{ 1, "50 Hz" },
+	{ 2, "60 Hz" },
+};
+
 static const struct uvc_menu_info exposure_auto_controls[] = {
 	{ 2, "Auto Mode" },
 	{ 1, "Manual Mode" },
@@ -751,6 +756,18 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
 	},
 };
 
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_limited,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
+};
+
 /* ------------------------------------------------------------------------
  * Utility functions
  */
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c09bc988278..6531aed5d642 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2377,23 +2377,6 @@ static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
 	},
 };
 
-static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
-	{ 1, "50 Hz" },
-	{ 2, "60 Hz" },
-};
-
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls_limited,
-	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
-};
-
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
 	.mappings = (const struct uvc_control_mapping *[]) {
 		&uvc_ctrl_power_line_mapping_limited,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index bcb0b0c101c8..818ae7a6f9b9 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -728,6 +728,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
