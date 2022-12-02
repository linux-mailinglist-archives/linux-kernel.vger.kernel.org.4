Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDC640B07
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbiLBQpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiLBQpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:45:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB54C7267
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:45:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l11so7231478edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWhyuOgAR3tJq3LBvDj1lg7AzkgIK7zVd0B6OOAMYrY=;
        b=AL1rW8hDe+2RKMwRiTR/ZNF/A2WEZBPkWHi+/CSPJfeph6tMJsbJnA1lfzQqk1P8eM
         hOqPlGXy+U8VAUnbjqrWymUMrFyVF+SgPeHO/eFaj7pZcFqKCcuA2K19KNx/W2m0m4yf
         kjSmhsRtyrOl5eFNywQAllUboagtfP92WQYTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWhyuOgAR3tJq3LBvDj1lg7AzkgIK7zVd0B6OOAMYrY=;
        b=yWBTp728+4N9lweXDGiAmX3O1Rr6WhCHCZXDoox8ukgYKfPYpDVF38QL7EoTk3u1CW
         KUPa6kqiOBEGjhcBWuZhDM4Ml/V34IGUEd4ZXjdBWvWGnuG5rhOTZLKCzeACaUJwxFCY
         83416H/ykD5xvNcmtQP4J7xuQdMdXQWb3qhbHQ0GVVE2Etcjt7c6yfMdwVunAyR0Jsiw
         3ofR/oxdFv6yBcGPSmJjdFKYWpJuUYZm7aXdAxxvQ0wBmsr3Vr9wHm3vBnr2M4i1FaAS
         u9aDBARLun54+pnigLdaLbEX2+2sFvnEc3RM5tXJxGutzPcafqd003OwI/7ViF+vS7gK
         syBg==
X-Gm-Message-State: ANoB5pkuY0U/KHxoAwPShToQToYA0JvwUxgJzjtVng/ne2r3ym5wX1mm
        s5L0HpnIEyk1O5a9CRJyFhcQShKHlYPA2bEGInE=
X-Google-Smtp-Source: AA0mqf7lNjEvvs8jGNFvAsLuQXF6RZVHwpRRANujMCTbcveNhpdvovCHVLkVPx3jYI+5uqlQ7IFPTg==
X-Received: by 2002:aa7:d7d4:0:b0:46b:7f11:10a4 with SMTP id e20-20020aa7d7d4000000b0046b7f1110a4mr15910247eds.59.1669999516951;
        Fri, 02 Dec 2022 08:45:16 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t15-20020aa7d4cf000000b0046c53c3b2dfsm111981edr.38.2022.12.02.08.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:45:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 17:45:07 +0100
Subject: [PATCH RESEND v2 2/2] media: uvcvideo: Limit power line control for
 Lenovo Integrated Camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221101-easycam-v2-2-ffe3e3a152df@chromium.org>
References: <20221101-easycam-v2-0-ffe3e3a152df@chromium.org>
In-Reply-To: <20221101-easycam-v2-0-ffe3e3a152df@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=C/uBBpj4LsicA+QlhxpKIRS8BFwjHReaadkNXEaD+Nc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjiiuZJWESF3BxOdqAjgp0C3Jsv6F0jNqcC1ZU4CdH
 UUdkhGWJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ormQAKCRDRN9E+zzrEiPK9D/
 9QeMT7lYBXRdBOQ812IZfZQ0GVB0/83V8HrFXZf+B2xf9CAfZXwv59wrGhz9FhIqCKD9ki3N+JLUEq
 rSbqtGSRrrg1OJPdbx/l+zSVK0sOTXr71SV8Ep4OkXLDcWWocJZoBF2Q6KOOOxgIyK4A6/z5ElGh3s
 sm/WldlblGSZUceINf6J1PA5WODq6E+5MVzwtdltP+MjfPQreQkt9DQyZIXfklKtTCVOg8W+TdELvE
 2AFVe/8qb2PBGLCEuo6XVk1rdDzxKdaXt6nxBxCgbOIu49//z69Br89jdwVEbCkMvHrx38Fzt7/l2v
 V08DvYdIUYLuMQh2271aZSGSfdGSMXctQrxvRw4zvCTwDxXmeJzMBJgJSzXZmD8QagIFsK8yocGNK4
 MOKiJa6KYuOfXox6mBD/Utiq1x3GChBAJingbKnAlZuuVr2+rZcbkWASI0ZCdWZ53VUKBDKX64qevX
 mTgIW9CkcLaLLtVmlaXJ6C9ecP6tafkjNTYydi7uqTSIAXWog2JWomusA9H0MN6epYW2QlS0PJZHWG
 Vau9N5BJqi05wdyjBtNoTMt5z61HJoTs9mouqat7tyIhDQXaeNAYt+zziV/3TyG0T6uSv7iDNTpoin
 bloE9k7OCFhyFWjLJ8gd9f43oQLxgKcQrNEkYWOaqlAV25xp8utKGU36xFLw==
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

The device does not implement the power line control correctly. Add a
corresponding control mapping override.

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
 drivers/media/usb/uvc/uvc_driver.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index cca3012c8912..e0bb21f2e133 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2373,6 +2373,30 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
+static const struct uvc_menu_info power_line_frequency_controls_uvc11[] = {
+	{ 0, "Disabled" },
+	{ 1, "50 Hz" },
+	{ 2, "60 Hz" },
+};
+
+static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
+	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+	.entity		= UVC_GUID_UVC_PROCESSING,
+	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+	.size		= 2,
+	.offset		= 0,
+	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+	.menu_info	= power_line_frequency_controls_uvc11,
+	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_uvc11),
+};
+
+static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
+	.mappings = (const struct uvc_control_mapping *[]) {
+		&uvc_ctrl_power_line_mapping_uvc11,
+		NULL, /* Sentinel */
+	},
+};
 static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
@@ -2976,6 +3000,15 @@ static const struct usb_device_id uvc_ids[] = {
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

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
