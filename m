Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC0165EAC1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbjAEMeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjAEMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B74E40A
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b88so45345650edf.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppI8aVxw1/6kIrnqudHixv/DEHg5kpLKy5SssbyDECs=;
        b=MSNFhYMUJD/0dMQ+7fEV+M3++4Q0TrAbZDRf0HeKCIZuEo8UbWK3wNTuv2Qa4EzTla
         OVAc2PFCR+nqt2cvcp1VLK1Qexr3WlwtLvEF7UeWq/r7fvWWueGr+1Rb2nInl5cdK/c3
         xejetG4i6DlouDmmsbY9flyXHGTUlIDFXNNq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppI8aVxw1/6kIrnqudHixv/DEHg5kpLKy5SssbyDECs=;
        b=h5CBxzAtAvm9cl0AR/kz3MmYFTs04nGLb2lO4w7F9jR2TKYgI22yOdYAhEmNK3wgmV
         YNN9TwixvD2Wf3JRawoxxmzH3TCXmHAIEd3ONmbHfC3BAFFpmVJulS3Qnbh5ge5z8OFd
         EgDX+1zgtpdV9KJf/PTSyvcnskpNIvxMdiak2sisRFsu+PDYiu7hT0T7IGcHOWLUP25M
         l4tlPg2Fp7fFCsF269H5+G044HZFWx2IzVbZvR9q18LN0X6UmfsCAKrIVfIWNHOCGYHi
         G2V2cbi7KPehPSWoLNtu7m6TRJFsxZpXSYBtrWi6UgdNzV25DfRHWH/MJOWl1RGpZywt
         6Axg==
X-Gm-Message-State: AFqh2krzjc5eaVSFBkxeBoSqmsWiaWjMQLBZEz5IuXhB2bcp4AcyP49q
        D5Y0WJX0hKqlVc4NrkW/TcZDUw==
X-Google-Smtp-Source: AMrXdXujeEatMY9FVfY04Un45E55vEQ/m96Zw2OqeSDX3E/WJZl6bCt/pad713+H/q5injXutfT2sw==
X-Received: by 2002:a05:6402:1757:b0:490:d8e1:aac4 with SMTP id v23-20020a056402175700b00490d8e1aac4mr3139524edx.15.1672922012132;
        Thu, 05 Jan 2023 04:33:32 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:31 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:17 +0100
Subject: [PATCH 6/6] media: uvcvideo: Fix power line control for Lenovo
 Integrated Camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-6-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3620; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=JBsJXIk7F9TaTHpPg9s+pdonJi4DxHELPycW3O1XV2A=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOTqxox+ir5TnHf9fIsoisbVBS0umYxbY75kx9T
 WuNmqFyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDkwAKCRDRN9E+zzrEiBffD/
 4tJwNJ75vU1WDBwssF1VhoCEZ1WEw3ONnLnakOk3XBgHQgjQuji3g6UHH0H8+NpPj3J9DkwhBPS5em
 b+eX1fGjgPP5FT8a22yqLEaxPmnSp2QTiUIKGftOi5v/HjhzNtdZqU+wxHLrJTjH5FkjH3kKh2SJO/
 6KvDzVJhZfpmE45lzlx8ImpIf7DU+sx210kdHcL7zfO/j2o6nBp8TjXqsMfjJK5psXP2eCKfSHoKvo
 cylDOuK9o3ypnkgrj7L7+Sq4JmKotr4ubpD+aUwlNJn87F9ybXuXmO4mOd/NIp8yb/T4NlGrmaiMw9
 o2wdE3Kb8jEVs/0Hvysc8G5EiMil8X4FixxIbcBr6x1egqTyeKJ19UB9Ep9qzqjbtTj4WN5UtYuXqF
 rHUYSI0Dxlm4Aki2OA+PZ5Rh1Q69lzXynY60ScdAyQOYkdCk4K2A/VdJYL9+00PQOA8WmDZAq+Uaha
 e4B07Km7ujsdiFsCZO//wK8vCNUzLkKMXCl06RRbYYEAJj/1jGgIuTV0aeWmFX5yE4FTrevUNKbYcz
 fZC571/wiVg4WjBnEKHVfzgyYCml6Wq9tKFwV9W+DuSBWhBhHNdykmehvfmKe2wWgV364uA4zISMEH
 OspcrDTpyPQcPEaKBcTbzN4RlyE+NRWwoijBhmL76t1OP/brAzyqnVON553A==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device does not implement the power line control correctly. It is
a UVC 1.5 device, but implements the PLC control as a UVC 1.1 device.

Add the corresponding control mapping override.

Bus 003 Device 002: ID 30c9:0093 Lenovo Integrated Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x30c9
  idProduct          0x0093
  bcdDevice            0.07
  iManufacturer           3 Lenovo
  iProduct                1 Integrated Camera
  iSerial                 2 8SSC21J75356V1SR2830069
  bNumConfigurations      1

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c   |  2 +-
 drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f559a1ac6e3c..28ef9b2024a1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -736,7 +736,7 @@ const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
 				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
 };
 
-static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
 	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
 	.entity		= UVC_GUID_UVC_PROCESSING,
 	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 37d2b08bc8b2..57c948d47bbf 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2385,6 +2385,13 @@ static const struct uvc_device_info uvc_ctrl_power_line_limited = {
 	},
 };
 
+static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
+	.mappings = (const struct uvc_control_mapping *[]) {
+		&uvc_ctrl_power_line_mapping_uvc11,
+		NULL, /* Sentinel */
+	},
+};
+
 static const struct uvc_device_info uvc_quirk_probe_minmax = {
 	.quirks = UVC_QUIRK_PROBE_MINMAX,
 };
@@ -2964,6 +2971,15 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
+	/* Lenovo Integrated Camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x30c9,
+	  .idProduct		= 0x0093,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
+	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Sonix Technology USB 2.0 Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 1b2d9f327583..31c33eb0edf5 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -748,6 +748,7 @@ void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
 extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited;
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
