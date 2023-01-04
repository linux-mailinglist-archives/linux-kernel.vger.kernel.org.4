Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4465D0EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjADKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbjADKpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:45:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFC813E0C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:45:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u28so43181898edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 02:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJWDrSRhEFhfGsFyYK0V6BHpJWAjFj2NsvQbNJQkprs=;
        b=gJi0oHoP2yFg0MctdLdpqE2ESdF2cHoQkqWB66CMsRRLkx7Q4QcBm7En77HJmkBgFL
         Izg676PvTW3XeZPahl4WF8CF/bP+GLi9KfSdZh+ABN6xGgZlawamckeOJk4ph6cCN5PG
         4i8B81JkqAThkZHqUJd26IiL1i4wbcNfWbzZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJWDrSRhEFhfGsFyYK0V6BHpJWAjFj2NsvQbNJQkprs=;
        b=3w7ZLe54fsxW2RQpBSSX9iEP53+VIso04bg32Sw/o0PsLM/fxMAgtVULVgEI/qe29A
         N5kLnlGjMhvC+MJkMIgvY+/k8IgovA7nxd9so4Fh3dQm2JAHC6GIDT562YSdmKHabr4t
         VdIlX1J8nIR/WWpAQVP1gt8svhLKSuAroUvirDU4f1k3cd+oPkQaMstgxfvdGkTWceZZ
         ejt5ClVQCu5oC7aurz1tdb3d/dwrCLZ4cntstrKRHCcjW5nI9HWH88Wz7EEVrOMG6aRO
         T3h8eIwh6y438Hd/s8ILXLv7Kbzh2nSM28+LvMXPfEpASx1rxZ0ecZmH9iaNf6oBjJwS
         SGEQ==
X-Gm-Message-State: AFqh2kq7Hc+q0inmrmJWxukW7p5UTMJQohYzbY2H7NY6xa77nIVQey1u
        odlLWQf8qwtPKMMeQSG0hsFMgA==
X-Google-Smtp-Source: AMrXdXuS4vfaZZii0jO+B5dF7EA8vQwvjlYTY9/UdmdXB68ZtW1E+NuTsFnjDJ9eUICjM5bPhRPVaQ==
X-Received: by 2002:a05:6402:3807:b0:47e:eb84:c598 with SMTP id es7-20020a056402380700b0047eeb84c598mr39079345edb.30.1672829152764;
        Wed, 04 Jan 2023 02:45:52 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:6531:9bb0:b3f7:86a8])
        by smtp.gmail.com with ESMTPSA id g32-20020a056402322000b0048c85c5ad30sm4754971eda.83.2023.01.04.02.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 02:45:52 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 04 Jan 2023 11:45:21 +0100
Subject: [PATCH v3 3/8] media: uvc: Create UVC_QUIRK_IGNORE_EMPTY_TS quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v3-3-db9faee7f47d@chromium.org>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3974; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=BJkG5vQwJjJAWQiYn2AnT8oOmSykPtFRv62ZOzP7kUA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtVjT3benz16nMI5QBuxLX89IhlFS3jj70mLziY7U
 2sKTeoKJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7VY0wAKCRDRN9E+zzrEiAA8D/
 49aOWCU5C/qlUPltX1KrAh75mVvc1R54PVqNns8jIVP6/vUO8mqFoeD0Ox3MdmyvrRQYoYp1Zh+tNV
 vHCmFS5HcDZd9IYDTQfQ6aFrstJS1pOhWO+vo5Ed9eksrydvvPYtjKfOj6KtW0SBL5MBzMe6iJIXrd
 TOotq9qlhu8B6n+L1C0fJbw3GOfjsW7KtdPV+HbpBEW9V5GUl0GeDY6tr+/b5mwq87gr4z++dpg7ig
 TbNOByRJXeI2An/RrUg+qhPlT3jhQszJcJYIvtR+4z0MZJqs+T1qo/10LybboyeL1GZGZoB8vFxQAa
 dwSPFPFmQTzckc99NivjZq+gwBQV/pex40z7Af7nwboemFTfWKhUMxI3inwV75qRsbADvBF8AZBq+o
 7ATjhHfL5WCaq3/fia1wROy3yBAEdDmh2Yv+RHKBoG8y5/TW/oz2VcITIiDgRmu7ZOg66YkLQakjTv
 EIM1Jj+EDE509i/sX1lSnj5oz9I4gKGnSRdnA3/4CtkJ1ZHceN8+OgxHGzxps8P68MmKKL2TFos7fO
 Mg+kdIoo65ANupzDpmMCf/Cj6jE/yJF3FMyJprKtHgSiup8PalkiySFmkPfhoIk55WPY9h8TvZ2QcZ
 ZRNN3FlDieDn8JIBD82/sJeRDsLeZIg2X9cbre8Ey7R2tv524Ii1i/fwWZeA==
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

Some SunplusIT cameras took a borderline interpretation of the UVC 1.5
standard, and fill the PTS and SCR fields with invalid data if the
package does not contain data.

"STC must be captured when the first video data of a video frame is put
on the USB bus."

Eg:

buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a

This borderline/buggy interpretation has been implemented in a variety
of devices, from directly SunplusIT and from other OEMs that rebrand
SunplusIT products.

Luckily we can identify the affected modules by looking at the guid of
one of the extension units:

VideoControl Interface Descriptor:
  guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}

This patch adds a new quirk to take care of this.

lsusb of one of the affected cameras:

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
 drivers/media/usb/uvc/uvc_video.c  | 10 ++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 5448576a8413..c5ab6e2d24c3 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1199,6 +1199,17 @@ static const struct uvc_entity_quirk {
 	u8 guid[16];
 	u32 quirks;
 } uvc_entity_quirk[] = {
+	/*
+	 * Some SunPlusIT uvc 1.5 device firmware expects that packages with
+	 * no frame data are ignored by the host. Therefore it does not clear
+	 * the PTS/SCR bits in the header, and breaks the timestamp decode
+	 * algorithm.
+	 */
+	{
+		.guid = {0x82, 0x06, 0x61, 0x63, 0x70, 0x50, 0xab, 0x49,
+			 0xb8, 0xcc, 0xb3, 0x85, 0x5e, 0x8d, 0x22, 0x1d},
+		.quirks = UVC_QUIRK_IGNORE_EMPTY_TS,
+	},
 };
 
 static void uvc_entity_quirks(struct uvc_device *dev)
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index def079c7a6fd..f469c62bedca 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -500,6 +500,16 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (len < header_size)
 		return;
 
+	/*
+	 * Some devices make a borderline interpreation of the UVC 1.5 standard
+	 * and the packets with no data contain undefined timestamps. Ignore
+	 * such packages to avoid interfering with the clock interpolation
+	 * algorithm.
+	 */
+	if (stream->dev->quirks & UVC_QUIRK_IGNORE_EMPTY_TS &&
+	    len == header_size)
+		return;
+
 	/*
 	 * Extract the timestamps:
 	 *
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..c3424ae29339 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -74,6 +74,7 @@
 #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
 #define UVC_QUIRK_FORCE_Y8		0x00000800
 #define UVC_QUIRK_FORCE_BPP		0x00001000
+#define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
