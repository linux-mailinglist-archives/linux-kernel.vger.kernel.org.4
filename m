Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86765BE9B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjACLCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjACLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:01:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD82B84
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:01:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so72750612ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLHiG2/HZCrES/DrgZpQvyLSgThQWWZsxAbqNPZVrVE=;
        b=CEEm3P2LtIOATwjZmOZkyiYIqCJW9YqXW6w03C8/UCOaxmvQi/pQj33Xnh+N4hlrqn
         /CmqjsTp0Bz5yU1v6t18xkZ4YbJJCY1+RBZZQViBmzylM0PoqLhvJo+MZM23Qf3jtMpW
         1EJyg1fvu6xoRcm5SOXaQUTfbti0KNnIgh108=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLHiG2/HZCrES/DrgZpQvyLSgThQWWZsxAbqNPZVrVE=;
        b=G1xL0Y4xqtkXtWtbOEThDxSx7HSo5dvdGe7OMX5/vVftWUrFlSQobnWs6nTFi/ZuhY
         p8GksL8pf1lFA/GLQkKlEWgX+9kd7x8L6eAb54hMSdLxzdTYuhvL5xSP2uUg32IY+YYD
         JhI4Ctkmo2Dlx+jr4SU7/S7YYJ41rAfwVEX4tSyNwSDskHZyegAIvZs2h/CGNgA3w8pc
         ozqohHTEM16kx3ursyOPrMhvYZlEzVksOoLAvAv2AeYwvNEH0hPjz3kBOaL0fN/LCL7W
         RqjvBuAjandrIUXfbf3619Xrbz8eTfmbrXIk1LNHG5YQh9iJZvvbj6cciOa4Sw4NpauS
         jrvA==
X-Gm-Message-State: AFqh2kr2gMShXcRbz5A4Fgffo7myJfuniYW2ZvDm6Owcc+w70yXHwGQ5
        48NLywUhITIMwo+wZ34mbG8+qXVM/pOp652Ixdw=
X-Google-Smtp-Source: AMrXdXuQ0J3Zyl6G6NA6CivX+WLL2ToUZ3Xio5SZmEMjhznXpQIHay2XYS6hZdSgwdm4NdSwq/9wWg==
X-Received: by 2002:a17:906:8a58:b0:7c1:6981:d062 with SMTP id gx24-20020a1709068a5800b007c16981d062mr38343338ejc.72.1672743715095;
        Tue, 03 Jan 2023 03:01:55 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef23:1430:9acc:b68])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090615cc00b007c0cd272a06sm13944331ejd.225.2023.01.03.03.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 03:01:54 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 03 Jan 2023 12:01:22 +0100
Subject: [PATCH v3 2/3] media: uvcvideo: Fix power line control for Lenovo
 Integrated Camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221101-easycam-v3-2-2c9881a7a4f7@chromium.org>
References: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
In-Reply-To: <20221101-easycam-v3-0-2c9881a7a4f7@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=aVaHYg3fgCdhxZASYM8cTLyzA416I2c/ZaUb71RRnqw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtAsbudZAvvY0e2cnZ4mS9Nw0UE7sLMQulDaoLqtH
 vwNuXSaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7QLGwAKCRDRN9E+zzrEiOQ5D/
 9/QtPLeDQ/64Xi0sCu9rrTnf0fQz4ST0OwuHblALX37OG1S8cbn4M44DyhmCDYgch5jEl9oqkWJ7cF
 cbiAK/M5P563+slzAcfWocrg20GAffefszR4AimaUOy5EEox1vElV4KkzGB62VZPBSUOsc5fSuQaMI
 6HcUHGe86v0tQ1eVmGxA0o3XfjY0pddw/bbOYRAdf4301R3ORXQRY/s9Pd1fCcPYtsIF6BPEOPQt93
 2vTxot/iAgTL5YxZZmjX9gI+6YZxpD1zmtnOuae89goXd60YZVDqJFwQ2gLtzxLqFskCZCJGYkvywj
 mDu+c6tcud6Ur+1A1I+YUZYrQ5TdXJa6SBR6HRNYIKgCIKXV9Q9uvGu4qWSPSRVwJ5lOaSMF9+qKna
 XDyaYvgZzWE1CXlg7AMK8eFCUxV2UsAVfa+CbLgo29pgg8xwABcF52LZJ8ncnE6v5IFMpPFlTR7fJY
 7XmrANynp0a7j6t2X4hbrnNT76ioQE9XsPDUzY2fpSJnfjGNaL90cecSBO8lGu5l5SNWtnnpeh3/Ff
 /baD6GcGXSN8WCNPDbkkOG6JS9H0W8v7eK7YHnjmos3PpNxMP7bniFdPiQIg2Az7xknBjkksMlKfCL
 /fJB81iOUUEisXmnBELWgkFAY+qkQ3ZotKczH+yN5qMWV5Rh5Ma4lBKJKJ5A==
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
 drivers/media/usb/uvc/uvc_ctrl.c   | 24 +++++++++++++-----------
 drivers/media/usb/uvc/uvc_driver.c | 16 ++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c95a2229f4fa..d8283d71bc96 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -721,18 +721,20 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
+const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
+};
+
 static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
-	{
-		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-		.entity		= UVC_GUID_UVC_PROCESSING,
-		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-		.size		= 2,
-		.offset		= 0,
-		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-		.menu_info	= power_line_frequency_controls,
-		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
-	},
+	uvc_ctrl_power_line_mapping_uvc11,
 };
 
 static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index f2abd9d0c717..9c09bc988278 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2370,6 +2370,13 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
+static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
+	.mappings = (const struct uvc_control_mapping *[]) {
+		&uvc_ctrl_power_line_mapping_uvc11,
+		NULL, /* Sentinel */
+	},
+};
+
 static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
@@ -2973,6 +2980,15 @@ static const struct usb_device_id uvc_ids[] = {
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
index df93db259312..bcb0b0c101c8 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -728,6 +728,7 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
+extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
