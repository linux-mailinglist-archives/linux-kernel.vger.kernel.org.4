Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F016BB29C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjCOMha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjCOMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:37:07 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFF224BF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so15660543edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678883760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=jNDOTpVguRqmPsNwZMHd8LjaCyFGqB0h/vgUFZNsVbc4vJM5fkjfVSXBLB5tuMQGc9
         AibuVUnU3RCV0RHGJwrd0V6/7frhHnpG0bb+ycHjnnJZhR+dRqn4Igxn1LhJZdpU/5VD
         4LqGKTW1xyuwuq3F+MH8bNjeZBHxbem17nF60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678883760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=2LN0ds2G1mAB7SXtX/or5ldGlY/mfhWydsS7ToH/y+L6Y3jkx5h6pYUkF6sorpA3du
         YfmzG6UC2Pk1OTbuRAWwYPuVE5nAXlSbEnvbTwIrhOST1K6qqP5Sq73FE7MFRPWJSejj
         lqeKvTMhZoEaEMa/fhbkF0dzzJm9mPy8SOQD9lyDy6gK2DeA6PnQNm95HG8AiGnRkHmz
         nW7w2LV4X2TG42gr7xPlcV0rsH704ekMoVIEvrEIZFetHJ2RA92nIMmx+x5JKXNtjLk/
         KTvM/gss1gMxPLBGOfgzyJX+cfPdl4eiw90ctuRfoEc2nTCx4R7PIgkO1nkOy5GDHYjL
         L47g==
X-Gm-Message-State: AO0yUKW1A8Ak0QVoJ8GW1FgeW+Mmyoy1p7MC4JehXUqlidRoiVRWxF0T
        8Y10neHWKESY3uScs5FXe7XIfw==
X-Google-Smtp-Source: AK7set+6iMJqwTCKxbtSpa/DEZpAg+l9W6d0SLzFYfPsd3q00iUx64y4/CiIhyx5TsTvO7Flmon4+A==
X-Received: by 2002:a05:6402:404:b0:4fc:b1f2:42eb with SMTP id q4-20020a056402040400b004fcb1f242ebmr2219182edv.20.1678883759997;
        Wed, 15 Mar 2023 05:35:59 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:491c:f627:27f0:1c4])
        by smtp.gmail.com with ESMTPSA id w3-20020a50c443000000b004c30e2fc6e5sm2363256edf.65.2023.03.15.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:35:59 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 15 Mar 2023 13:35:38 +0100
Subject: [PATCH v8 2/6] media: uvcvideo: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v8-2-0edaca2e2ab3@chromium.org>
References: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v8-0-0edaca2e2ab3@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3922; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=+e1rJhTRZYFtyKcR4/N8/nQKunH8/Dqv1jSdJGbbaL4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkEbujR7E2zx9xw86qmRztrnP4mXdUpFSOlP0hN7K3
 xBV763+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZBG7owAKCRDRN9E+zzrEiC5rD/
 9mI8NjUQ/dqMqieVdH8Zk2i68yUANex7arMlWP0u2OXtFOEHQ7eXRkzeo7w4fED2RBgpacUy//ZktZ
 YL5rIdili429BjEKDVLOXKTdVpmoX7B1JC6a95aNGxGZiPmhoc/P89+5VWBDdrkPtj/fBC617rdkxN
 hzyoI1Vcvb019dJpAJcFWsyC6UCz1ujkjy6sSAusz5jOsn9jWphBxtFX39NZxZpQ/a2f6h7Lf4ReGo
 KBUyJgLEDUg4F4IIRUL7omOfxh0uRALD0BDFiM5TU0TG22DP1327g9n7c85c/51J8Y9oI91iSVvs0Q
 ztD44jnNYI/re0K8wMBJ+H0zkywdpFuSh7BedIJB1I2yCnx6AvWzNdOH4kT6suz5CIRAcqRcUtiPbB
 nnRI3LqMYccQx0k6mCifj/BNnx7pdpuBquU3Sx+26NRrjzOgLlUsuqcP/M3nJMsO2W/ZOIkD4ShWc6
 Q8ZS073PF7uPr0qnszaZUoUiQcA5iLSFy1d6zuHGY0hMBDDdZ1UewdHUq2Tuts9mJDeNjoPUYeCW0F
 C9havLCEWEeP2JHDAPqIbfJA4srKlBTJA6F6Wv9UcNbyBMQ2tL1gqsLb0flPJyBldRpSu0A0i1I/Tc
 y5juGqG781g0qU9eCGcE0qPydxI6JXyN+Ec/zQkQIfeqqxanzodtayRQX1cA==
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
