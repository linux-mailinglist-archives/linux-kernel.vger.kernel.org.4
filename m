Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE51617E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiKCNlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKCNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453D140B3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t25so5283520ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Wu8BcX+LtOapPOEw3vPoa18UbkrEIbxPoLO/ZmY1CQ=;
        b=Uv1wGYuYcuyLg8QWPSohzH4gS3DjtTEtvJovvUfDFPdy5YcU+0EncxqSIpr4WnrJ5h
         EsNidk14sUzNxMg/1nX/C5AuhteBqVDt6vpichldtuo6oG4+5HUy+LMyO9nyuYmXg9Pc
         2GD1lPQOFnSTm6U4LF8NHXUqR6NTLroG5/NUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wu8BcX+LtOapPOEw3vPoa18UbkrEIbxPoLO/ZmY1CQ=;
        b=zIhLhi54+P3nfIDhid5LXZZUrztq5aB4T1D+Y8r6OwOLcNBrrQvnU5FlPw8uV7Wfgj
         XY9w3F+gTz1HJ42OgNuMkZaR1hK4FC2JkIRPyVhIzKmI7J7oPUDULDH9M7VyH3BVggxX
         Izd6EbcHcIQk6XH4ZrEJsCwDZGB82Scgl/O56yuQsIiPr8R2fCLhWTAy4Y27h4HlvOD3
         EaUl5++zA9YWQ0mfBciE/bsTGwSnr8pkPoylJsQuIZ2+tLUpj9PJ1LqIDO37osVvuUZs
         Ur4pv9HEzwfcaZjvQi45GXC+hW+lTaGgQEzPThnKUper6+AftTYWuKgtAf+Oep0nBahc
         UZkw==
X-Gm-Message-State: ACrzQf2doLIqWEHE08qa/khorCFwgzzRVXiTlUTUC3LNGpWUTmdGDrex
        PXnC2MBdOf7OQ+iqqpvU6cuzrI8tABq4xyNi
X-Google-Smtp-Source: AMsMyM6nyKNfSwiQiBMdC4Anr+F4DHZnwkl0mKYoU5b7+7JToqqWOu8mY9uoHT6WMSTYygVdDRwNqQ==
X-Received: by 2002:a17:906:f854:b0:7ad:d196:9df with SMTP id ks20-20020a170906f85400b007add19609dfmr21666369ejb.295.1667482868838;
        Thu, 03 Nov 2022 06:41:08 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:08 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:44 +0100
Subject: [PATCH v2 3/8] media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-3-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3613; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=0bJquUAr1GQDJ5Ewl4+qXLbtcOxjrXI9YYkj/sI1K0g=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Tnt39PtqZ4zreEzOG9DHH7gYyJ7Arn3p5KYk0e
 wGJyNnKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE5wAKCRDRN9E+zzrEiBXdD/
 0TLnzkGCTgRzIO9SyYCS65akzC8irTwLBgRwKIutQlf85gbi1Ev9eeTL2AnA+kCjgTvfmjDrhgBKiJ
 hcuDXDEc4j2DMRDSWskXY6WbQPGKkEmvLs45/Dd+Gcgfexezr/ka87S1y3VFwpFStLMu4vY5Y3RSan
 xifI1I2vqAVBUgGSqfn5dObXWi/p8Mooe9lZkqOz1inZ9HUnywXcNGiOycw7GBWFLjWVEjthOiunAA
 QOld16GiDbB8eLC+SXn4yBNi+jWXaAtQW3k2xOhX2NzrRd/kDGRYCkazb1SduY2lVF9DMxReJaPkAt
 y+3n824wPhugjL34DrZdnFMeyxxWfMhr7H48vUykQ9W95+QOjA+w90gY8CadPZKvF4iQGQ5bwXW0Fv
 xH+K1fkPyrpWM0i52exJkGmzWa9phdGsR/yEOeeU08cWfhJtnvNjFy3kx8oyDZvaY7XKof9FYqie+j
 ULc7SbGZaAxX+YVCnCr6PCiQ2NfvqRzessOKaeuIWG9YRyn0HMqw9Djdm4yoliOCHr+tiGEyPf2WbI
 sATTrb7CPIlyKDP9cvmJk7dk4pVuZCJ5xcg/KwN+/9iYmnn/bvByBAPxZZ5+95gWlyPBRV8QoasHnf
 IJRqn3N4aVSPDTvU0+wP/0ZS04RZyFMDRXtNinjmkNgcgrvqORNB22ulM1CQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
b4 0.11.0-dev-d93f8
