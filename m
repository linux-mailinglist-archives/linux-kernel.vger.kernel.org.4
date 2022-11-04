Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A06193C4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiKDJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKDJnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:43:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7601A2A941
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:43:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 21so6805084edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbBORJC/QmgbxjRF25o4c3oE3vegMXT7XiOqsa/2p68=;
        b=d8NwF73cq9OrTXtvWBqjXMUJ+pCc6djNWNosDnjKINdA1it3r0UloyR+bPgBbceod0
         6rkwJoYqRiIrnfgWBU+jSpiBSMCRltxwI/fWDcVF9xpFp1t5a46ESuSdwNRkKhA4CX8E
         RNSIy9PQMp/DiR3nUH1AyyhhLC6leC4u/MwYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbBORJC/QmgbxjRF25o4c3oE3vegMXT7XiOqsa/2p68=;
        b=X2d2SHaDJXA9nGDBk3TRKL4f0GYOPHNSIXjHzA2jJjnmyC+QqJfHBGdTIuLSfzIskr
         HPk3/2QN5oM4YT1BacZbgWbcHxQ+uuNKDM7M8Os0u0sRtZo8Gm1ymgLwgSc3GMtax+jW
         aINgWQZKx2T/DLuzHD21dhOsxK2akIZ5Ndw1Po30M7hryze0hbarmy9FNTiemcU+eDJl
         jizMgsW8ZSPVO0zslwTbyLlTTsHZGpyWkvSUfX8LdAW38ZucUAhROBN2qnbqsk4Pxznn
         svInEZf8uIikeccLEtUS6P3dJPUbvVSZNfJHQIHJj3jYRMYGdBGfHwpuzxXI8lzbPXQq
         b1Qg==
X-Gm-Message-State: ACrzQf35hnt2pqdH7GJnpo4hxi3/lGKaPdQ0yHkBiatqq/jvzYzPg0qv
        B+O4+dvt2lTEyUIenkHncNKwFg==
X-Google-Smtp-Source: AMsMyM4m0LZEwm1C7vBNwy00IzC1yqMr/NYB8Ckci64mGFfdTMQsibc97hSMhS5MGfOJFpKttVzjHw==
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id o4-20020aa7c504000000b00461122b882bmr35524938edq.14.1667554991051;
        Fri, 04 Nov 2022 02:43:11 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:943d:d0b8:228:b5e0])
        by smtp.gmail.com with ESMTPSA id y14-20020a17090668ce00b0078b03d57fa7sm1561653ejr.34.2022.11.04.02.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:43:10 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 04 Nov 2022 10:42:50 +0100
Subject: [PATCH v2 2/2] media: uvcvideo: Limit power line control for Lenovo
 Integrated Camera
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221101-easycam-v2-2-5956414a608c@chromium.org>
References: <20221101-easycam-v2-0-5956414a608c@chromium.org>
In-Reply-To: <20221101-easycam-v2-0-5956414a608c@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ENmfc6jAlhgXvRiJulSIDkbijiA6A6+oFRVAvaXy2YQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjZN6oqnAn+oJ0JgZTMLmDhSl7uGi90MI3cMVSxTqC
 BqyC6fKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2TeqAAKCRDRN9E+zzrEiOQrD/
 9looNaSwrLKepZCEVbLZamnX+Xf83gJvQvVHf7IOsXs+zi10VEl3pFqZYC4sf0jJz2xUxiQtjLwjFK
 VIci6Ztaet8qZcToLsHwNUM0cauB6aF2skIYHaERxhYX0SvE3NbkncEh4JcK/NY68ikvwwwSTzyn/O
 phYXwGe47SZNbUioN7rRIBzidScZ3FNI/X0/mCLVPMJJ4xt/zKuZxWfaYWwdPF2nyVL779dTcmAfFt
 7rz/ggZmuH9n6Y2JwW+CkszUaGm2ewFX6MkKfG6JNVWwOlLjmQl69DcqWPC8F7DXiYP2tg7dYoc+i8
 24Zq4tKh0qjq+/JcsRzZk7Xwe89FIqnSfHch205+qdrwY0Y8gU8Sm8Mizi+EIJrCAs1y0jKpHn2cgn
 ErBC+K1ZGTHsEwyUOaL6LcQQwDw58YNSyJFWX6ABvuGN5qwOUWJvtfE7mPvRIHOgrYNXMdZiI++tzE
 RsU7htBM4Kyl+g2p8iZWB5KkrIfvcKIkREm/1hk/BWI6BcpJhw8L0kUQ0AWUUuA7lQ1Vm8OXsV7dRF
 i1hxv9eCY/GnrWhwkee55NnRI5iB0pEWAwaJsMFdfcqGn87scee0snKmsvQ0K8PfG52hCfwE+mNtaP
 mC05jeJreBwqSTtpuFtGIhB1IJ9CEAjr6+V0KgqzP3x3G1dgLY3VSovX10WA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
b4 0.11.0-dev-d93f8
