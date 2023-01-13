Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A4D669918
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbjAMNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjAMNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:19 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA9565AF7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ss4so45194816ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7Gw/Wt0kH+cB2xtvU6KPFDByh+yOvFcci+3eI5EXXQ=;
        b=mhHk1EqH9xVIqkhKsNdXdmh+OuuxL+KEI0D3zaPzlYzcIRSGiOdglM9YSA1sntKCDV
         TdcndgS11/KSuipZ9sM0JS35hiZwO3gTXYpyNET0v1E/paQcf6dUjJV93fnsiqPHCtgb
         AXIzQQKVb3P5RjADuj0UsumKUrSQeC3MXftN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7Gw/Wt0kH+cB2xtvU6KPFDByh+yOvFcci+3eI5EXXQ=;
        b=5VUp+ZB70uVoHP1bJl1yK+dvIb3Ya/GKfVGk03kFjaxLIKZm805xG129Hkxv0+2a8z
         jMD9djw7HPLNTRIyycNwFbcbTh+GYsB9AlRQ34uOejWMqr+rDeYIZCOZTFlFThfH7kJT
         4Q82OEZcm8rGrdmTTRvsz9aJ5HyDIablSQ2Yo6npmnOBJSPRdyrseRBHhq6kEv51YqIe
         yrCSAS5THgxabWvDgMltn54v+Zs/71ratb5RmTYrG3mtbHpriAQ+SwoipQBEBsIS3Fg3
         CGs9M5F2aLwvs79qbftUYu4iFosuCp8LG0fFYOaEFMYl4H565Iz8DV/6uoAV79zjtTeN
         p5dg==
X-Gm-Message-State: AFqh2kpNKNbgwpSzZ/7gcSSXjXMtVq9d4o+m9ZskiH2w3qYGWD1XP4JK
        kjRyuuVuebCeferfXgAx9EI2VdW0iisbiDUPItw=
X-Google-Smtp-Source: AMrXdXv1qSKuQwl1dZhC4gndWE4r/T9aYIOPX5ZP0aW9IQHkUeNfgR91Xeojx4UdzY7Y2O4PfIhRog==
X-Received: by 2002:a17:907:c208:b0:84c:e73c:d224 with SMTP id ti8-20020a170907c20800b0084ce73cd224mr30979496ejc.10.1673617743591;
        Fri, 13 Jan 2023 05:49:03 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:b023:4272:bddc:acf2])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709062f9700b0084d3bf44996sm7072888eji.142.2023.01.13.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 05:49:03 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 13 Jan 2023 14:48:47 +0100
Subject: [PATCH v5 1/5] media: uvc: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-1-660679c6e148@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-660679c6e148@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3557; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=2f5YmRNpaCruZQpy69ufXYbW1rPh5r91J7dE4mEBR5A=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjwWFFfFL5GkVzMO4ITDR9HY0Ml5keCj9kLRkwObQR
 aIM9lUuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8FhRQAKCRDRN9E+zzrEiIrQD/
 9rs93+/3QWU+vZSQemr3EkZfXx0Gqyr0rMzn/AVumh4gCMbq9wILo/9I9oJ60p/uE8cst5TNrmkeB1
 HF+8Sx3XzFRryL0enPuJprCuliI6UkW4gSI1KYWI36yUpQx9OgY1oo8915eEpukvsWGahHG+JUiWzT
 dKoMu4PsUpusBKTAMOOvszl+R7SmCe00+CSjoO75R2RVtFT8I3UgEjj0uXOvq4MHbLKmRdGlqXZkvG
 KCmgGRqJc8+5/oIbwKdbmIAtpsNZF/YDXkoZxVCUAj9w44cyESeyRMZ2KX1cxRsVOqZWV1Bd+VeUGy
 /tsocLM3YVH7sKfgGWLvuKe9y8LA5gSp5y74thXPl47sfhQtdr2Psb4JPEaej0Sa0HzxZm+jmu9D4d
 BzQYtYuM0LIDKV/1Idj9ApRdRXkyXR/PoBWxkMXtf0eOvow4HKFO0NLhoX/3kfX1S6qxe83saKZF2k
 g7Xge2kfkuRByU+ERzYUJqtqI4+2Ddvo309CrfEGbyBPwRNjnjLr2LONPxKeSkiwCI+TNfWV+I1PMk
 GPby9Awa6R0mMNduKKjDj+dmDYyDFWvVMEVkrhJy+MOR2t4yDmevCD1Pz2MhI3a594kfCgkuCRZR2p
 yOFf3HwGdJvKgbGPfhgGASWuiFzINWuSXedjFfuvCgcBYiL6lRQHTHjtnX2w==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d4b023d4de7c..488c58bc9919 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -478,6 +478,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
+	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -526,6 +527,18 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
+	dev_stc = get_unaligned_le32(&data[header_size - 6]);
+
+	/*
+	 * Some devices make a borderline interpretation of the UVC 1.5 standard
+	 * and sends packets with no data contain undefined timestamps. Ignore
+	 * such packages to avoid interfering with the clock interpolation
+	 * algorithm.
+	 */
+	if (buf && buf->bytesused == 0 && len == header_size &&
+	    dev_stc == 0 && dev_sof == 0)
+		return;
+
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
@@ -564,7 +577,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = dev_stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
