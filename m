Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928E0640BAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiLBRDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiLBRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:04 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91002E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z20so7212743edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1b0nTFpIaI5p5ZE8W0YvdyyzRVBuMuYrq9RTuFJCfc=;
        b=OUpjWGMvZnDcLn43zLuHuWVOV3ISdEtKowFcHWm0+5fGSDDSl/v63vR/WAh0TSM7eS
         Qeusd0VExamLNokTueTAxfUiw2NKAtZUKgbHuVONqUIyh1fx5iNlQaSVwoWbddgN/+mW
         6ejuJt/TpHkPeV9fc5sGn6ZRggfSgT700uAvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1b0nTFpIaI5p5ZE8W0YvdyyzRVBuMuYrq9RTuFJCfc=;
        b=vAiJ5m/82yuu97N2+vRGW1EM4XjnPPn9EjLufQeNpCpKzOVRCUCAkr5vpvXd6OkHPZ
         zUP0egPNfe4K65uxvleNQWjn5i42o6AXUgkzXbPa/dVN8kocfDpy6Xw6euPWpFGGtEEi
         uygEEcIwy2z5qbDcS+zYjWqt9l462gzrmgrBGeNQz96OcQ47KhBs0Z1TBWjRr/WwH2d+
         UjQffUxtKfnhIOuAQMO3I5fnxRUt8dEoqOKbO7SvORr7lapHJfRdyZ1MTCErOzkNOGGR
         xl0ZtdwTid2m6OSx8GxQsM9y1ktW9+XfK4gQuAe4IQ9/Zy2ypzZRJCy7AMMSXeBB9kKs
         St3A==
X-Gm-Message-State: ANoB5pnIxdoL17o9GQhl6KujnYyg4nTRZzEeetHNHrsdLJ0PrCtN5BTS
        QAsiPZ6VbTC3lIIdPhCaXeE4IQ==
X-Google-Smtp-Source: AA0mqf7lJ0bmDBBfoxuODgT+6hbcd49FQ/OyGeJeACmcHg5fS+P5Q64M6A2dxzvd5byboR2dKKAkhQ==
X-Received: by 2002:aa7:c78b:0:b0:467:97e4:6339 with SMTP id n11-20020aa7c78b000000b0046797e46339mr64809687eds.381.1670000582204;
        Fri, 02 Dec 2022 09:03:02 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:01 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:43 +0100
Subject: [PATCH RESEND v2 3/8] media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-3-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3835; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ThukGURKifBgx985aH8p0USOirI+IB7ilvRGG3W5Mrw=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+5H1M58hm5+Na5JGlt2ZCvH5eHmrmhoH7sSZGE
 ZrQBkNyJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovuQAKCRDRN9E+zzrEiNx8D/
 9EncS+zAdR3hdqeACRDHKENTwfJGH6NYLWeUbbnK+NyO0eNPxeX7yBx0x1KM4Ytj3mAI3Ie83n0SjU
 mQdL01nH1MVySAJ7UQ1Kqf8xFW32/0aaV0pRJdG4X2ehFAbtypKorgCbTd5+jht2oMZPXWF1QIU62q
 79UHEHPYu0s5RSQHWGyoxQhAAFJRgX1/dCwRGHkgWspTIHnTkiy1gn21lAST2dhAchbmOBHtXTu0jM
 kQwbeQTBGKIQ238AkqAB+EVwqsTsj1K9IMK1o4Lnncxl+asbwHQR8dAuJVS93VkV6CLGAb2pjwUHO6
 jMMzTz8knQDV57+TBY6CO8uElX7NoMXl8aKDR6fyBcRpO8FOwIQd6pQ6haBNzT4ubVGRtqeSGt3rJq
 36z0wkNDQfpc3MDhnrNPkpC6D+/WO2wvCaa2DNo6v1AEHSvR9+H4gMLfjlIvMCx0amMC5ijK54cbpS
 1KDy6Dpyx43o7JR+FIs5s50T8hYD6BOHsz/MVRK0KIs3gVzEWg8ZPsVCnl3phLPWHIb5R73VZ79YqY
 cTHXWzmnqv/n0UhiqFB2MXrgGahp1yveVgWeRE1dOUphjh9z6ygw6FOk85ImeL167C2EAN/BzL6mPk
 12eAnO2y9xgOWUlzq1p9itZUg/oad21SP6Ov1SXVr0gh4iHgcvNmnBnYEOEQ==
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

Some Sunplus cameras took a borderline interpretation of the UVC 1.5
standard, and fill the PTS and SCR fields with invalid data if the
package does not contain data.

"STC must be captured when the first video data of a video frame is put
on the USB bus."

Eg:

buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a

This borderline/buggy interpretation has been implemented in a variety
of devices, from directly Sunplus and from other OEMs that rebrand
Sunplus products.

Luckily we can identify the affected modules by looking at the guid of
one of the extension units:

VideoControl Interface Descriptor:
  guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}

This patch adds a new quirk to take care of this.

Complete lsusb of one of the affected cameras:

Bus 001 Device 003: ID 1bcf:2a01 Sunplus Innovation Technology Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.01
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2 ?
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x1bcf Sunplus Innovation Technology Inc.
  idProduct          0x2a01
  bcdDevice            0.02
  iManufacturer           1 SunplusIT Inc
  iProduct                2 HanChen Wise Camera
  iSerial                 3 01.00.00
  bNumConfigurations      1

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
 drivers/media/usb/uvc/uvc_video.c  |  8 ++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 20 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index c63ecfd4617d..80ef0f0e04b0 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1497,6 +1497,17 @@ static const struct uvc_entity_quirk {
 	u8 guid[16];
 	u32 quirks;
 } uvc_entity_quirk[] = {
+	/*
+	 * Some SunPlus uvc 1.5 device firmware expects that packages with
+	 * no frame data are ignored by the host.
+	 * Therefore it does not clear the PTS/SCR bits in the header, and
+	 * breaks the timestamp decode algorithm.
+	 */
+	{
+		.guid = {0x82, 0x06, 0x61, 0x63, 0x70, 0x50, 0xab, 0x49,
+			 0xb8, 0xcc, 0xb3, 0x85, 0x5e, 0x8d, 0x22, 0x1d},
+		.quirks = UVC_QUIRK_IGNORE_EMPTY_TS,
+	},
 };
 
 static void uvc_entity_quirks(struct uvc_device *dev)
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index ab56e65ca324..a5b184e71ad7 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -500,6 +500,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (len < header_size)
 		return;
 
+	/*
+	 * Ignore the hardware timestamp on frames with no data on
+	 * miss-behaving devices.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_IGNORE_EMPTY_TS &&
+	    len == header_size)
+		return;
+
 	/*
 	 * Extract the timestamps:
 	 *
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 24c911aeebce..f395b67fe95a 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -212,6 +212,7 @@
 #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
+#define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
