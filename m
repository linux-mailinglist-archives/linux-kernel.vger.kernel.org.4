Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EDA6BB4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjCONam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjCONae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:30:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797BB91B47
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so31780277ede.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678887027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=gHfCVCL+KtwV3EGazhIeiRvmQifinDdtF04C+2pUjQdV1/8/ES84XLYEjUdkzB4QsU
         TSStCHlPV1aC8PvSJQYXYl/EScKnV2JYi3AISC6OUA392cGv0mylaw+FIcpg1OunvKbT
         RAC2B//QzWfaTxB8+Dc/EtX9u3Bg0yHMmvz/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678887027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=S0E0+U9I6TxiaXz2emqHyjCgoptbf6AV7cCm5QoOjCHDVVkkjzXKxJd7TYIfyR6MdZ
         wAwkSd1bP6lGWHYWJBvfmEEGBZ3duO6Azp3cf1pzjy1sjMBkgFJIglpSeQmx7DvUVU2F
         4aoyoDDNyaPK2c8OfYDdv9O1JjBDMzJuXuNqceQ8hDQ/6EZzl0EmTEnHJqtpdRTE6DiS
         3XhugM3uckI5v1ivbrU3adquPB4m5UzKhGPtaAVhTCY+9WXg94VuKtTG+sJFkoyzBZRH
         1MQRbaHNfHgCVWkRCfqmd2+LLIpwNHVPusr21lWIrguzgwCkgkEeQX1rmqpQumRCII1l
         lHzw==
X-Gm-Message-State: AO0yUKU9fmz2oQrk2lXMTf4wEFxm/dBR6uiWlbqljXuLohYVQsYSvCXP
        sjv1CW6Y0wl4aN2ZwwKv1PoWyA==
X-Google-Smtp-Source: AK7set8REglz9uHlenBcNYXEDNU7f8XywG6UdqAnZ4tGl829rZg4MXLJsMz1sNqBii07HK3EkEKmyw==
X-Received: by 2002:a17:906:c1d0:b0:879:ab3:93cd with SMTP id bw16-20020a170906c1d000b008790ab393cdmr7663387ejb.46.1678887026905;
        Wed, 15 Mar 2023 06:30:26 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id ha11-20020a170906a88b00b0092043ae1a8asm2534638ejb.92.2023.03.15.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:30:26 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 14:30:13 +0100
Subject: [PATCH v9 2/6] media: uvcvideo: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v9-2-55a89f46f6be@chromium.org>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3922; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=+e1rJhTRZYFtyKcR4/N8/nQKunH8/Dqv1jSdJGbbaL4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEchpR2vAg7sBI1dBwEaleUoYD6Drm9+mb10eFF4d
 hd04yCeJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBHIaQAKCRDRN9E+zzrEiKCRD/
 94LdXzVScvrVV29sQ8EK2AVywlk82cd6hn4nTtlVg4uXUKQYiHC5na7f44u2FI9CSFXKwiwghgAZwd
 5/dDjYFYPND+npCycYyq+jz4WVsrxsOoB2VyqkuOh6ydpq5d/wbKaI/FIXkx4LRexFe2/BcT7kdtN8
 QUFA8K6zLGDPpcFUspOX4Rn3kVY9V7IkklSZPOSy2z0UzR43xsNiVtAA61/D7Bw/H31K8x5PmrumE2
 z7eTr5YpcGunNBaTTFUm3jgDFSSxY4l8v6kIK7NqeJqxWtCOGqYdQLw4yt9lVlTBclitt1YQCWybjd
 s4MWoYXtL3xRZTTC7o3GbNPQr42+/E71beG2E9KpaCXvl0r2QVPMlnb4bUO6QDfE6tgJBSik4Rlm/o
 5XHtOUvsS6FfUPZ3RlQegjRSCjM5msSzhiStAwMPt1OquSz0QsfDQxmA+CLZpy6DWOJYTUkU5tzR01
 hVGOUhF7QRK/O0NRHZxJkGSnDzZS/TmMzayHKVBGNDqBDykRPXsHJramc5e5mHuZl/s3uIsFbm+BJZ
 lZC75yL/VkAdYCiuYo4AWNv4SjSKYkEaMHrNr6Iy2v7HAXVoc+RhCITlGX7ik52DvxRvQH5Q6j83Aa
 MGuJWJeZ6HvhDgr11Mo9RByVmOa4Ccq8oWpF6OYIDOlnK+ziPoSQ4G1IrV8g==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
SunplusIT products. So quirking based on VID:PID will be problematic.

All the affected modules have the following extension unit:
VideoControl Interface Descriptor:
  guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}

But the vendor plans to use that GUID in the future and fix the bug,
this means that we should use heuristic to figure out the broken
packets.

This patch takes care of this.

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
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 4ff4ab4471fe..1f416c494acc 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -478,6 +478,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
+	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -526,6 +527,23 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
+	dev_stc = get_unaligned_le32(&data[header_size - 6]);
+
+	/*
+	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
+	 * standard states that it "must be captured when the first video data
+	 * of a video frame is put on the USB bus".
+	 * Most of the vendors, clear the `UVC_STREAM_SCR` bit when the data is
+	 * not valid, other vendors always set the `UVC_STREAM_SCR` bit and
+	 * expect that the driver only samples the stc if there is data on the
+	 * packet.
+	 * Ignore all the hardware timestamp information if there is no data
+	 * and stc and sof are zero.
+	 */
+	if (buf && buf->bytesused == 0 && len == header_size &&
+	    dev_stc == 0 && dev_sof == 0)
+		return;
+
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
@@ -564,7 +582,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = dev_stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;

-- 
2.40.0.rc1.284.g88254d51c5-goog-b4-0.11.0-dev-696ae
