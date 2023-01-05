Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBC65EDFE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjAEN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAENz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCA15005F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id t17so90066455eju.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjquDUj+Pkh3sX3Nb739RCA0OIWzHWBMegfajevm7GM=;
        b=k93+/ngHoI/xdxPrMldx7VCfDuLVtw5GP1vHdLHCEYvd6l5FtQtVn1T9CteRiHSK5B
         7dQ1l8u3N1ykmcIzYE/vsr5DuELzWvo9oIqVpQdEO8eeWKFVZKoeKXDIzz3bwEl1yuVk
         zfZcBe5y4J7NffPPPFwr3BWiNNofQzKn/q/Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjquDUj+Pkh3sX3Nb739RCA0OIWzHWBMegfajevm7GM=;
        b=ZXTHfpTNhpwDXP4WPxihsmpsmBQPjPJLWxJtkAnYVtg4cILz2T/F/nVAj9um4UVThQ
         i/1nJ5Z1LdDhr7ZfdhG3jmU/z7JkMFIVdGoQstkBIC21/wog47whcVgpWb0GmL6Bm74/
         DardCEX7xWpaytV/lXClG24ZsZ2AH13xwKgFTfiMR2c7dD2HGLdn0mVzVzTTqlV7w85e
         DfNvwNYXqw/pBrK2BLtmFJUkXSIrc3JSl0Tz2QD7bCYgEUm4qIFL6syYEly+YofDZKR/
         RyTkcS+iCRzM6BXjfpIIAW3e3jPDQQ3XltsPR42bDDv03Ol/NKDwSHK5ZIN/a10jTsy/
         3/og==
X-Gm-Message-State: AFqh2kp2LBakjw0GqEFM0fpSuZ8Ag0hYov8vPYTVXZvxYikpgc0A9tcE
        /QLTsaS7cCHZBchZ9HelfDi8nA==
X-Google-Smtp-Source: AMrXdXvH2PelQyv965276xdO7FAFuyEmVm31ObXjdX8BSN6Wb/JLyfFcw8ffi7QS4ztds3s5jj7M3A==
X-Received: by 2002:a17:906:ce4d:b0:849:a231:e503 with SMTP id se13-20020a170906ce4d00b00849a231e503mr38443183ejb.49.1672926799745;
        Thu, 05 Jan 2023 05:53:19 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:57 +0100
Subject: [PATCH v2 6/7] media: uvcvideo: Fix power line control for Lenovo
 Integrated Camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-6-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=YcPdxuXc6e/MVQTKSpvQxEjmmIRWxl3uxbcqXKNQm+o=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttZGZ0Iq14zpMyjUhg2dn1eR/Vv5bx5PpNod+Vx4
 CxsIn36JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWRgAKCRDRN9E+zzrEiL8BD/
 97Mt7IwMd9kghnskq4VR56QmcQpNpbpWNvsTriv5ngN9WMHXvib/mKpInWWqth9td482tbC+WrAEzc
 mFsRUe3hg+6C4VlfV7ly3J46mO7edihuDnu9OPq+Y8wEW6Yr5Qp7pORQg9B2zow9r8ar8LW3I8eEBM
 ttXVJFHjbPVlinVlXSRZDi49yeqtaqeI9Ox3degAKgUB1MmYBYeYvSHneA2jcZFD72pRLeCPh05JQP
 5bvAOTH6nNq42DbY3Me2pPN9ncKJw2wG7xobBk//5PrgDQ5GOwjBBV101HXF88KUsdMYq7SubVwBXC
 RN5vz92w/Cx65/4mB8/V1K2nN4jh4w7NLKNh1ZmYSTLpo44gCbzE7CKKSOMf9TGAUwUIUfVXAgK2S9
 PVqTRpaxeO91nfgPaJ7BfNG5VQhdb86DaGXt4sIzd/5m2K8/Tz9ETPv0xQYC7mrBxzT8XaGw2IG0oz
 JASMYr5v4D5DQsaS2xQofd4jdQrzGzsGtOvCbQo/Jzbiib5TLXDVR9xscnkHUeiMBLlig46UJ0XQxf
 Gd1Pq05A5p0MVpVjkqMrMbecKT5BkBxK1nKh7FbTxEct5oOBzECYkBs9Mo58yJqQ8/jc77rQqDE9e8
 mQhLLLaB6/0G4YLICcf65HNdaJdbIQc4VHPoyUCzMOr64N9WkyhJ3ZnNetTw==
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

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
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
