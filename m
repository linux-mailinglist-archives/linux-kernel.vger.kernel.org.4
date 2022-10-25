Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109760CF24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiJYOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiJYOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:35:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE50789AF1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id 13so13047803ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EPUsq9ry6a/B8ysE7p/Gp0RizcV4HTBL3tocv0bMA9I=;
        b=fTdB2oj5zXnht0oEeX2xmQrEskfYbWhGUNlF3H6haxGBao5IRjdLyR3preVA3LQeVZ
         29aYtsL68obHnIarkE0OWrORdyGhwVRhNoNqhC3YnSq3HWVaiWq9VPMoEzowIiRd0n4n
         LY+xBjK2zsEa8RhE2TcTNt5FSnP8AxhJMYqnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EPUsq9ry6a/B8ysE7p/Gp0RizcV4HTBL3tocv0bMA9I=;
        b=CxFQ+y/OXLrLx+VvJv/Ow22pilZ8FMplxPOMjwDvXqDvnzKoHkCe6UJ7VshZ1jkYe3
         UnmSENY6XiDzNTl2mnUrfP9m93G35Gfq432R93VzUgLQ5jFV0TDp2mxeyuVSIaur2N+Z
         +mBxzDEUrt5+hlYKm8rvRL7QZkPvVcrld0qNAQrI/kucL10PvSAiIJUHPen84WR3QGm8
         sq9HQzG1Y3z1KbUrr7o08u+Eu05ZqD1NXA1u8oGjt7Y59NfMhAMJfg6mHjLbWn4n0eOf
         Qgs5fnrnzDsea4+fyyuZ3f3BoS6lKjA8RE/xK8ZnBI/FxynVrcknn89LJnrLK/L0kcjY
         c9Eg==
X-Gm-Message-State: ACrzQf1FWUCUFrxHRnBfnpxuZCNLbOIE9F0U4x0iV/xrkEMhwjRcTm5p
        mEuGkbBgmibUJwG4A0njuktNxg==
X-Google-Smtp-Source: AMsMyM71hWCBlcJ9ysbiTMgKrX6H+JQgkTH7FjPE7GyhEjGcNmC0UZDMmqJQd4vHudJwmXXeBi4xPw==
X-Received: by 2002:a17:907:7203:b0:7a5:b062:2338 with SMTP id dr3-20020a170907720300b007a5b0622338mr11741623ejc.8.1666708512271;
        Tue, 25 Oct 2022 07:35:12 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:e6ae:c7ac:c234:953c])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906314900b007acd04fcedcsm631021eje.46.2022.10.25.07.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:35:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 25 Oct 2022 16:34:22 +0200
Subject: [PATCH v2 1/8] media: uvcvideo: Only create input devs if hw supports it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-powersave-v2-1-5135d1bb1c38@chromium.org>
References: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
In-Reply-To: <20220920-resend-powersave-v2-0-5135d1bb1c38@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=3NadNTBF4BvX9SA2sRowXe1SUqwds9fIYTSwvXBWhlY=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjV/QPx9RjCOkK3+R3LAQ5GMY4FjigtbgykVx6lPrt
 swaMdAeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY1f0DwAKCRDRN9E+zzrEiJyPD/
 9f5qy1Bc9FRGR0NTl0gc9YOOsfmXgD5GOrksxDkgvooTyJLJwQbGlAy4UbzlXv7hGoE13ZpwVt7knm
 zSeQzm+to8p0nlRIBvQEyj5LGn6DXxBseUS9XoIUl9Ii/gMt9dnraRVsvjitYSNd2PHgNWmQc3gFV0
 5dRMO5JZJ6DOiCdqYzoH3PiiIpZzuAwa+wQIc5uRPAV8Z9RAknxVkqD/bbpmNE7447clD6iGFkpnzT
 G66Q0s7Si1wtvus0CE7aGgS/WMkwQo7roJT2jQ6FdWc/41eFyYNx8byRLTcP9nD8IuC/mWIZgBLazZ
 pI2KG7XiJhP/6douXCtcuYKtSxfsHw11K4DtOQyRjw/PsgSLolAovRMA3/0/GuASTMD81MVJPeqtxG
 O2Cpde/SXeiEYYk0ySF1awU8tivB7lUl/EzQ2lCbtvQr5h7/rEgEfKeDpVJgvKMsIO+WC8dd238WAF
 QiLYsPHvZgrIBoIV8Gh3BOLN6zRA/W+wNXdlryR4NMcOZpQmoz0xVCoxsgXimdw1imHKop5Up0DidC
 1uGuDn+jb9GsrIDaDmykie6PeZn311GDOaY/hb0SGu/ozfm2eTuGPF3bMqDeKGlqmThaKwZpQ+oOT4
 gtlSk08fAtJqgGxkvqDdee5WzXnF5pExtS7xlW+xSzrH3tZt0ChSY4lXw3DA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Examine the stream headers to figure out if the device has a button and
can be used as an input.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 7518ffce22ed..cb90aff344bc 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -18,11 +18,34 @@
  * Input device
  */
 #ifdef CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV
+
+static bool uvc_input_has_button(struct uvc_device *dev)
+{
+	struct uvc_streaming *stream;
+
+	/*
+	 * The device has button events if both bTriggerSupport and
+	 * bTriggerUsage are one. Otherwise the camera button does not
+	 * exist or is handled automatically by the camera without host
+	 * driver or client application intervention.
+	 */
+	list_for_each_entry(stream, &dev->streams, list) {
+		if (stream->header.bTriggerSupport == 1 &&
+		    stream->header.bTriggerUsage == 1)
+			return true;
+	}
+
+	return false;
+}
+
 static int uvc_input_init(struct uvc_device *dev)
 {
 	struct input_dev *input;
 	int ret;
 
+	if (!uvc_input_has_button(dev))
+		return 0;
+
 	input = input_allocate_device();
 	if (input == NULL)
 		return -ENOMEM;

-- 
b4 0.11.0-dev-d93f8
