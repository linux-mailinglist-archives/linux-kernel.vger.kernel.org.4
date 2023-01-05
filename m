Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95E65EAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjAEMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjAEMdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:36 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873A4E402
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so36801952ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RMA+soBb7ISYDgZGukscenX9Gq6ESDTcYuOQgtCRPU=;
        b=BmcRlqdBjxR4r+Jx6xp+/nvK9jMCX2Nt24dLwkBldJgMoXmhStUgW7WhpnZrcwIN3O
         mfgV/R7ZrwCbzBDvj8rQReJsv+jGA3J8PCp7rM6SHLzGFnUNcrjFaFpu5hB8h76O40w2
         n4zdLs/NUwg356wKAxjTYQA2RK8YFmwd7ObbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RMA+soBb7ISYDgZGukscenX9Gq6ESDTcYuOQgtCRPU=;
        b=vzeVgBSW1u31kxuDtUiyZsPMjRDQuN/j+DMwoa+EmpDsUwKjQ7m4gNbOwgU9OIh859
         fQbYviCG7dp38j4V097HqjTCPSBTDzJLn3zuMgpOznZ79NzzM0PSlE0XxF0zhGv8lNBx
         jSbbBVRun7AjsTJm9s9cg8cyKfqrgHrxYn0r3X7n1zM0IgiVZ9Pj4DdWR+xrfMfPrv7g
         ZU8kUlW+c6Q/JVhywyH1kkH0gAG6+K4Ac2QcEYbRTwE4B8EaspVmXU8NkF5TaTkJJel2
         80OM3dOD1ZMEXlhC2Lwk49WtdrEq4O9Ia1dcSsrWtYtlgrxekiBXNR1MGEZwxicG9Vzw
         4vtA==
X-Gm-Message-State: AFqh2kqK0weM0h+iVrNVfvg7KUD+FuZBekwQE81fsrbBFKmX1R59O2QP
        1dBmt1H5wiFf2YUsfGMMyPPAJQ==
X-Google-Smtp-Source: AMrXdXt9PL7j5VffNSgDjkCrb/AVQNmabH7lnN488TdM9yDuH4aycyjM8UB+FxZgQkMNTkKMGvbuww==
X-Received: by 2002:a50:a401:0:b0:46d:53d7:d21e with SMTP id u1-20020a50a401000000b0046d53d7d21emr47345364edb.27.1672922011147;
        Thu, 05 Jan 2023 04:33:31 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:16 +0100
Subject: [PATCH 5/6] media: uvcvideo: Refactor power_line_frequency_controls_limited
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-5-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=DwtzhBtzoWhod5MLtGXm+KQO/xP0T/ezlf1lPZGLRkA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOR2N06IYE/A83vfL7O598nnP3a4ihc6he/ANmB
 SMntxzKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDkQAKCRDRN9E+zzrEiO19D/
 9tTLGXWPKuxiC2qXJI+Rl0DfvN3WGtNGtkcaPY05H/XTItqwL+G1umO9KW4/H47xCpW6/+TjX/4SzZ
 4g5GmtRVvnUBAyoElrdLZ8hWddkY0AetGV8ssxSKEAz1UxqN0EXkvC3x3spEGZVU25w0Ms9X08NQI+
 +uh3m3B+QOMl5ektVt7qga58I1zC6uBA4dAcwb0WrCVtfGjr5nwT0AMok+Vtoe+GHw/AdDsApz5691
 QCRO9HJn1F60pTjIKPlK86veZcjLg4G2cQysdCZNW58kX2aJP5PZAA53IftSvEQfjDZXX+Dkb5hXVk
 Zj9KaWOlLkAj3G+TbBlAs2TZmdTk3aManxWynnuVL92tDIYVruL0O6SFsFdLaTMxefmN9LETbs8ild
 aePeMHWhlhNC4nt0uu3Z+95lWyIbhFCPc3MdydEw8nqFA8Vu34b7suci8oHxvcrWRyiOByGIuZhylM
 v73q58TJhQnpLP07KMc0OJXa8pmlVhtsQFNTru6DjTunYWuBjn0zIrNqQuVpsmmcUUWG/EHapdbjLW
 AfeBzfmSEKGVH36hJTO0DUQrLgeWPSyx/GxzyYv5xCth8GQ0Prr6/Tnkf9T1/7iU0HwLwHwwLN3xKv
 SGGV1oTnpXGjWzQtPEbF0qn1WtOO6QAVRbllZTyV0zBeElja+AjsGLLDodGg==
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

Move the control mapping to uvc_ctrl.c. This way we do not have
references to UVC controls or V4L2 controls in uvc_driver.c

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 13 +++++++++++++
 drivers/media/usb/uvc/uvc_driver.c | 18 ------------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9af64f7a23d3..f559a1ac6e3c 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -723,6 +723,19 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
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
+	.menu_info	= power_line_frequency_controls,
+	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
+				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
+};
+
 static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e659670ea2d8..37d2b08bc8b2 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2378,24 +2378,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
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
-	.menu_mask	=
-		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),
-};
-
 static const struct uvc_device_info uvc_ctrl_power_line_limited = {
 	.mappings = (const struct uvc_control_mapping *[]) {
 		&uvc_ctrl_power_line_mapping_limited,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index a8eec43cd860..1b2d9f327583 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -747,6 +747,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
