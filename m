Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47970640BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiLBRDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiLBRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DF1CB2B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x2so7322917edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9GzaUgP2dUy5ipTj5VK+ngXMm66U7fmrSGtTqAoH/4=;
        b=GAX2TZTChMhZiFD67BGJI41r0AzDoMd9LC5vF2rPwKDFoNwZtXlfFEHYWeSEbE6eVM
         oF5Lz1Bb0EgXKkEaecppdgNypI5MnqXlF3L0dK8bCzyoHNe9zOWKozkiv8qdto8TU320
         PooQegpgKL9nwicmnN78WE56DL5DQvL/280aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9GzaUgP2dUy5ipTj5VK+ngXMm66U7fmrSGtTqAoH/4=;
        b=sIVTF1TeEsHhCT5f1dI0S0Ayn6CWtPXBW/1Qf7sgmf1sh0iWjS6iZ7MpY6OaqjsQ2g
         eFWNh1UAEqFcNyYPFqwO7aqlD1XHYF9lG80sCTGVTdtnBTI2vwLf8F/aCS+9hmE4ZPTx
         5Z6NFNhHTbXxfTI8tFyqoFeXIsJlN9mqrZBzLnkIE+uQORp10z+axmMVpE4We0u1WOgX
         LNfaz9LFLmdPJ0maWhvxLmyqurkI+OIzaIfAB+aMrY7q/fjsrpmA3mpWP/W+2GnWGa92
         RT0LYA+Wx2wbWUMsTtEx5URpJecHcyb61v4QC6LiJbHO0JMEXyIdYu5rxVdvHYNKfsbo
         B/Ag==
X-Gm-Message-State: ANoB5pmk+iUgngZ+3XmxZyMxdSTfUqw0AVhld6E125rxRrTax1Z3YHzE
        0TsrbfWURCN3RM1iBuL2E7TjuQ==
X-Google-Smtp-Source: AA0mqf7cuQ16oJ6iCMZcjNmjwO+oQ6d4SXqf/AobfnrYTMU1TDznCvuSURfIuDVefBcd2NnyU7nYNQ==
X-Received: by 2002:aa7:c94a:0:b0:46b:74e1:872c with SMTP id h10-20020aa7c94a000000b0046b74e1872cmr17010867edt.301.1670000584034;
        Fri, 02 Dec 2022 09:03:04 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:03:03 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:45 +0100
Subject: [PATCH RESEND v2 5/8] media: uvcvideo: Quirk for autosuspend in Logi C910
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-5-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=5268; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=vMpFMRWWnesB/JKaCX8FLzASNm4eeK6jiVYT2ygmW8I=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+8Yo31bNYjZttsorhUadWt28paNSHCekzMBfO9
 4MT7IFCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovvAAKCRDRN9E+zzrEiMhTD/
 9M1V3Q8NhJzc0K7i6zH28Aead4zTfGgJS6iPzaMJOZwixbybTKy0p1NDW78eREp4Z3BTLh34iSugpL
 DsbnWZtuRPx7zQisCQ8f3pWpZfIAFDn/9f2TIS9GkqqzM0maNn6tH/xpsrcXY36TcM+wDf2z5BfecN
 IwmG6NhmjPx/HzR+jYE5Gm6f++dvtzUKP4SkFDsEk3BviuR+ZNqYviJqW/3ghoWpPGLCCbN/YCHyUH
 vBxR+BOU0tqf/dPGmeBKrYtrY21PAUhoOOMNmlFfBtdDmX5on0MHzwfSQx0vSPNBFoGAJI0n9K/Y8N
 wCE/oZnMGYz+4Xsk/gtBpkehQmvmJ8devs1V1RtpUN2mpAK2dwyjCI+1chU9lEkMFC7t+KIuAmYHi1
 VyeMPzlZ1Ib3GmNkviwSQzs+EFNqHL7wPN0gqmfhrezON/Z0sE//13kGrZuLC5QM3fhNAUy3ppaEAr
 ZR4ExcwbQcs4mxVMGCfgpv6I674ZomWF2U7gfQaPhNusnUeAbkKz57hAKIw1JWazklIQbTkJdjLbSP
 YFi3tMBVSD65aR4U+QPjMjqTfcdA1bYCZIBOYCiFelXyh/QUF8cuNKVhOWeRquT3TiegfhnLfO431c
 ZyLp2XQsLjBMsGZYu+wDQzCpO6Rpw3xOm3XksqZceCKtUJKwyTJ6ED6Xov8w==
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

Logitech C910 firmware is unable to recover from a usb autosuspend. When
it resumes, the device is in a state where it only produces invalid
frames. Eg:

$ echo 0xFFFF > /sys/module/uvcvideo/parameters/trace # enable verbose log
$ yavta -c1 -n1 --file='frame#.jpg' --format MJPEG --size=1920x1080 /dev/video1
[350438.435219] uvcvideo: uvc_v4l2_open
[350438.529794] uvcvideo: Resuming interface 2
[350438.529801] uvcvideo: Resuming interface 3
[350438.529991] uvcvideo: Trying format 0x47504a4d (MJPG): 1920x1080.
[350438.529996] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
[350438.551496] uvcvideo: uvc_v4l2_mmap
[350438.555890] uvcvideo: Device requested 3060 B/frame bandwidth.
[350438.555896] uvcvideo: Selecting alternate setting 11 (3060 B/frame bandwidth).
[350438.556362] uvcvideo: Allocated 5 URB buffers of 32x3060 bytes each.
[350439.316468] uvcvideo: Marking buffer as bad (error bit set).
[350439.316475] uvcvideo: Frame complete (EOF found).
[350439.316477] uvcvideo: EOF in empty payload.
[350439.316484] uvcvideo: frame 1 stats: 149/261/417 packets, 1/149/417 pts (early initial), 416/417 scr, last pts/stc/sof 2976325734/2978107243/249
[350439.384510] uvcvideo: Marking buffer as bad (error bit set).
[350439.384516] uvcvideo: Frame complete (EOF found).
[350439.384518] uvcvideo: EOF in empty payload.
[350439.384525] uvcvideo: frame 2 stats: 265/379/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2979524454/2981305193/316
[350439.448472] uvcvideo: Marking buffer as bad (error bit set).
[350439.448478] uvcvideo: Frame complete (EOF found).
[350439.448480] uvcvideo: EOF in empty payload.
[350439.448487] uvcvideo: frame 3 stats: 265/377/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2982723174/2984503144/382
...(loop)...

The devices can leave this invalid state if its altstate is toggled.

This patch addes a quirk for this device so it can be autosuspended
properly.

lsusb -v:
Bus 001 Device 049: ID 046d:0821 Logitech, Inc. HD Webcam C910
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0x0821 HD Webcam C910
  bcdDevice            0.10
  iManufacturer           0
  iProduct                0
  iSerial                 1 390022B0
  bNumConfigurations      1

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
 drivers/media/usb/uvc/uvc_video.c  |  5 +++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 3 files changed, 24 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 4512316c8748..d2a158a1ce35 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2823,6 +2823,24 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Logitech, Webcam C910 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x0821,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
+	/* Logitech, Webcam B910 */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x046d,
+	  .idProduct		= 0x0823,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
 	/* Logitech Quickcam Fusion */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d387d6335344..75c32e232f5d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -1983,6 +1983,11 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
 			"Selecting alternate setting %u (%u B/frame bandwidth)\n",
 			altsetting, best_psize);
 
+		if (stream->dev->quirks & UVC_QUIRK_WAKE_AUTOSUSPEND) {
+			usb_set_interface(stream->dev->udev, intfnum,
+					  altsetting);
+			usb_set_interface(stream->dev->udev, intfnum, 0);
+		}
 		ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index e41289605d0e..14daa7111953 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -214,6 +214,7 @@
 #define UVC_QUIRK_FORCE_BPP		0x00001000
 #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
 #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
+#define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00008000
 
 /* Format flags */
 #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
