Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF3E617E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKCNlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKCNlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:41:13 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB34C2DD5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 06:41:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i21so3020356edj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb1TxXDYCX0UbT1M38Hz0enEs7BzEgUeFcPg+yYlJ6w=;
        b=kLhZUsoSFfKQYvK52/kjuDEMQB1JDq4BWYE0o42OoJPvIQMiu5ZPysXw6Wq07eV341
         u7mDgIs4wk3nCKhrANUjEe+H8stg+MKmF2ugx8FrRr0em5UOu1L+2VS8W9/luhktWi6e
         4jMPqBOLm19n1IXPkANB0k6/HLQaw+MPe37YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hb1TxXDYCX0UbT1M38Hz0enEs7BzEgUeFcPg+yYlJ6w=;
        b=ndilHV65jvdc/LVprH3LeLF+SOimVjwS+9RQXK4NcE64uMl1tkGGMy4yK4kzjJcvcJ
         M5Ac8gLKvEtG8IxfJusfxiCaFK7iJQ8a5M04Z4ZPhp3L3FmoGVWj4aA61lGkAK/v+wA2
         sYxHwGExdgUs6fF4Y+juTD+t6is8mNNkC0y6R7p0sEKHQIh8i68U9v0c3pBi5LPJY3vd
         aAvxiGcpoONb4PQSoweEpu3t8pgYfDBOE/VSGpWjPdaIdORDWYPvnAxCxONPmtw1Japa
         xTriCHRpPBLTR+9bNN6WBvUNHOyAmLB0aSqQiAB4YZBy5fWxWpI1ZWXx/B2v4LGPlLMA
         vpFQ==
X-Gm-Message-State: ACrzQf2Rs/em49s+CsNJBKMAosGRG8eYWxvg9Tq1NMXig07vVusPz1k1
        d42IVy9/ZaCR47V23sA9BXzqjGomciMendiP
X-Google-Smtp-Source: AMsMyM46lEDmOCuHxzVHiBkB5D2oOeAcPe8lQsci7orObZ7gwUMppg70ybTt2+X+JUvcplv0xRZQ5w==
X-Received: by 2002:a05:6402:43cb:b0:461:912d:90f with SMTP id p11-20020a05640243cb00b00461912d090fmr30596229edc.375.1667482870369;
        Thu, 03 Nov 2022 06:41:10 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:c1a3:5bc:2068:8f2c])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090623e100b0078d46aa3b82sm521948ejg.21.2022.11.03.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:41:10 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 03 Nov 2022 14:40:46 +0100
Subject: [PATCH v2 5/8] media: uvcvideo: Quirk for autosuspend in Logi C910
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v2-5-d8d0616bb612@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-d8d0616bb612@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     HungNien Chen <hn.chen@sunplusit.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5042; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=p5RvX3qCD6ce/qxL1IUoFKUNaigRS5GrgVXMbIb+exc=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjY8Trzytar6o1bQWtJTgzygKQJY3iYq25SFyNEg7F
 7AXerJCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY2PE6wAKCRDRN9E+zzrEiL1uD/
 9INbxsQfAugyW/dDD7Arryz5CdtC+aFrFkYLj0W30dZmXTV5zfLvkN8Yk/mL+JxegV7mYLUOqbYKWc
 DxYG5JdoeZGzqBATRkw4xsjDNhYi0o6TAU0tSnkE8fTRfphsSn5IblfYiouBlJIdhJ+qJIo7y+FDLH
 7eT5ryczjyDjCAELfR2Jw4rIy1FaAp8AquNaO82L1wGfEG2/jwKTKydiFvl12oK+caP0wqIr6hhnFH
 Qu/jmR1M5ghtctI3ttpfd8PET9RM/8hzc6Hc5i8kgMDY82mjzcZ6hVYu61rhpaICuNPYn1zkvNgOws
 aDZUvVE2epBHvUcfE2Zbrcdi4eUw/GAHi4vxMd6opK6y6ztSH2o5E9NfHov3U/J7SSLmmuzib4Qg4d
 9kmQSOOi4bCHe1DX+TMtMZ63bTOL9qAMqMn6wTw9pvxHhlDZ0QzMS4moZdcFte67h9Dt3j48/jUB99
 4TftHw7OAnT2cPmj45lRtSBxU4cD4tGA5xC3kxn4yMAXDelBcv5p6H90UBnE2GCxMtcBwV2k4V7mcM
 2s/WWdTCQgQOLwxXuQsyvGWsRr1wS0V/LUjMuQnetyqWnJkq9XOF+1DeQ/2Krr6xnTo5H7Om7+3wYY
 jauExlXK6iqsGl+TkpSOh0sJhQ4fp10c4/2GcSHP+rHqXAgJ1rdTa+dyYO7w==
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
b4 0.11.0-dev-d93f8
