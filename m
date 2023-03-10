Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD39A6B39A1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjCJJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjCJJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:06:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE9710822B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j11so17665143edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678438932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=UpQqQOkT1NsmAXYZfYiPuqaLhTysktOoQDcEi4v3ki6rszPwB7IOUMArrRQnua/XVs
         ABo1zDYVHqt4o/GGxMUj/GrtYrdGgYG/HA+ET6vNHiXF6UNuVyGoO0En6h1CaZvMs8Ln
         Ed8LbCjkL1OkI5PSh8mIO52PUAo9wFWDYkw2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678438932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ks+I0iL9S/eJzdcQJQgtcbFNoYKHK8Hr97Z4+vCos3E=;
        b=tcfvduu7BJ/LGxqy4QE29jzqHGKrZJ2nACB2ZIznYfjrSnx8taumloIIh0G/zGMi1Q
         37Ng3r0oQifxpUxzaKUoRya3DF330pP5/vKMOpH76Vzt60auHCVSXbZZBiL9ryztvlCf
         I0Jc+VkW0kgoiEKrojTsoEw980bFg0iY99ddL01/TJ/XsZKTiy/tebqWlEEiGrQlEWP7
         WuKf51roLVTjwtnR9zgamu4DZbZPa5WzmR8GUVCWlTMkMw4knr9xAb2eqkrntlcOQp4t
         5gSUyW1bfxPWPoChacezstH4EphX/R4OSteI1tLw1sIoTtwz4MpvL4iAlwvMOUgUEkEs
         lawQ==
X-Gm-Message-State: AO0yUKW0e6KXSBhna+nlpDoYvT8l1MtFX1zuRZlY+JvmeVzXx7G/EcSJ
        tFIAdjQRhM2a/CpRq0hYlyeKWQ==
X-Google-Smtp-Source: AK7set9nmoPqTFfsxxNAx30lnjNZRP2fucdhekwAya9B+lfjNa4UHo4HZM18m6FsGof56Rxctx5fyQ==
X-Received: by 2002:a17:907:9d17:b0:888:5d34:dc79 with SMTP id kt23-20020a1709079d1700b008885d34dc79mr28576821ejc.40.1678438932476;
        Fri, 10 Mar 2023 01:02:12 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:ef69:7ab6:87ac:99f])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906454500b008b23b22b062sm692931ejq.114.2023.03.10.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 01:02:12 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 10 Mar 2023 10:01:29 +0100
Subject: [PATCH v7 2/6] media: uvcvideo: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v7-2-cf1d78bb8821@chromium.org>
References: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v7-0-cf1d78bb8821@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3922; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=+e1rJhTRZYFtyKcR4/N8/nQKunH8/Dqv1jSdJGbbaL4=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCvIJyM5E8SM1e6cOc0A6OINFuwFO6Mmq+lkzoSNt
 bNYna4WJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAryCQAKCRDRN9E+zzrEiAEuD/
 9H0447j0gDhLx/5bRMVTMgJhFKnQ/L1rvPm37RR9ps7x9qgCO29kQj9kWsX56YMhVDnhkNkMTOhH5e
 8uFtimI7mIw7XcFXvnRr4tvq0awvT8yACmY83rr9wdUVRhXPJSbxHDEJAG++weCFNfG0J4svFjLzC2
 Uq84n9YMPtgP+Ht8BgASNe/2iFzHbn3p55EIsinmpGU+qfbbr+n3lL5pwAh2X0IYsw6jwZlGoKCWnN
 okJWFw+t77X0O3dvC/AQDkkN0Gcx13tuzssOiq031+IewyXMls5VBdiVjqXZ1iWqNzQD4Mu+3wNb6C
 ETqNy1ZRnmUzhjnA49QvCnP4CM5y9Hw5IEjvQQUP4M18+lnpJ1zFo9e69Z1wf/v4kZx1JPRW5BBpfv
 uh2b0lowHnSJzUGspUnf9noxAl0PghWhq6EU/MrJBEe4lcD1GnwrbjKsKpRVr6wRKwK4gJVpXLuCK1
 Uvv6FErORhehJJNGYlWGWYPemfCRHsiF9AWr/AEGiWa9xbKeWzAlbGjr8/Er+IU/Cb8YMiFVYnPkeM
 syTM0zAeeagjMrUYRlGgQzChcUxRi2KnHFq2KM8dfhE2gD5S2YZGvEQkEz4jc2QefCdN0N93LKi30g
 z4yTE8B6SeabUihtJoyxVRUHM4QYj/rAin7/ZVDaXyKfNIy3ufvGGUT2lUJw==
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
