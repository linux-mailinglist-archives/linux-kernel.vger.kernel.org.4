Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927826B24AC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjCIM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCIM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:57:21 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3CF16A4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:56:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o12so6527928edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678366566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eniktNp5LyeH77bXTVN24xHTzfOMCc87vcXnyNAQqNE=;
        b=ig2UFTmhgKy5IkdvxdBJJdPqppgIeg87xUrwvJaM9qJE4Mba/3iZ0mse4/MuPGqOiY
         AnX8UhWDkUQVs2R6ADhuC5zfV4o/esaGfqjNwZX5Rgf5odzDaowpptM0M/NiikhmFWhj
         R8atwSCw3bqjgobxfnV7EdTp34ebcQXdBNKWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eniktNp5LyeH77bXTVN24xHTzfOMCc87vcXnyNAQqNE=;
        b=w2GL7ybq3T8+wHQvDkN6yUbTk+fEAcKHcXfDTouX329PSwAC/G2KM5ffHAKj8H4CqK
         UiHesyN5dT6XuXgcdkaRnMa8XV+UfyT5bZWr38x/JDBzITsjDEK9Pm3vHbblW+LtoIZ1
         NSRg9ERAB07FnhE8SLvt2AcB+mVIWdRyy1XypcxOLhblK3L6fqslIOYa3yB4uXUGIYp7
         Tg5ZCNe3nSFIAydWS4IobsJKmHaKwSVkRfZryPe93Kj/2CN8i56Sa5PQk/ykGzR1K7Je
         MlWy766fJxzqLr0yd780tXne4knA0UNcWdhpIBY2oHOX7a9s+FS65l24zhiRM3QGlHn6
         Nv2g==
X-Gm-Message-State: AO0yUKX433G8R98TRu5IBY7kN8wtKjqc7cpxZDjMX5UXQQmj6e9QbmJb
        WHMiKXueHbhCPDFY6+rnu2yiO6hAI27d/YHltJ2HPA==
X-Google-Smtp-Source: AK7set9R3ID7JD17R36zNx+TSz4NM3yDAihTEgrngYWz3Rg4bS3+8bBLW4eSdZpvjL8Vh5RZveEgGw==
X-Received: by 2002:a17:906:858c:b0:88c:3502:56d4 with SMTP id v12-20020a170906858c00b0088c350256d4mr21483985ejx.46.1678366566451;
        Thu, 09 Mar 2023 04:56:06 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1645:7aa4:a765:1966])
        by smtp.gmail.com with ESMTPSA id hy26-20020a1709068a7a00b008d92897cc29sm8799523ejc.37.2023.03.09.04.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 04:56:06 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 09 Mar 2023 13:55:15 +0100
Subject: [PATCH v6 1/5] media: uvcvideo: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v6-1-c7a99299ec35@chromium.org>
References: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v6-0-c7a99299ec35@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3862; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ndFlDl0AdhbyYkioWAtq/V2eWm/wcOyReOlolbI+09Y=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCddbVxx19Gt5zrBF61atbNz73Y5XtkY79IimR1tc
 5tbWG8+JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAnXWwAKCRDRN9E+zzrEiEL4D/
 9U9Nci+Hzs2osRy76LEiE/MqEDFa1evlsASjlukfYUkm421vFEMgo71FnBNoVwK157NJGUQuNiu8cp
 dR4SLDhLkpM8iQ/FMlYwZ2WNwLtCERbKgA3TSvCMubk/5bHH0vYmXJdIAprjNFqtcP7itZwUNvhDl6
 Xdy6RUNyY35b5FyaEfJoA8aJiI7fG0yPpqrdGxCE1WKT1z9MwfHxI9oqPOxyM+iqRKwIBSydERqPDM
 s7cRpBvwro3HWp3GoGsB016fegsNOsbQf0gx2EHq3uBrrB92VmNGpDOWgrG0SWVIteuLB3uVmhuVmn
 N8aeiHct4iaj5Rpo3bkkdI/OAKe4H4xbeIpWZjjZwwhVGKuPe3LzkKAaNOHvLtYB0aEmTLDgIzWn+7
 MOMIi6pCXYR2zGv+3OaL6phtmFQcJb+hmtg0sm8w6fdwnWF3rB7nzd/AJm6fw0sclcebsDWw3Q5sz7
 VfBnVPL7/d+PL70i3/ZterJ5HPt/uVoc0H70uTx92WfCbnFQq5+fCqzIPELJMdPqpkbbEY2lXcRT51
 kc1dgNu3k762fZyk39EIPac9glluIEBVkVHiSzKbSJs4axnsbB1ttfY2bnR4zQ+YZi+1v5Qo+Pi0bo
 5GuPOa6k52sIET4KjtfcRp8pJFQc/NohVmjGoqosA4mz1yLwrVpO/slrBa/g==
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
 drivers/media/usb/uvc/uvc_video.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index d4b023d4de7c..fc7f8b6fda85 100644
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
