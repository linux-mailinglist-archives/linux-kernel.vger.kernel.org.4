Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C088466225F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjAIKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjAIKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:22 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B53D10FDF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:01:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so18633846ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX1dxoa9iuYVNRE72fLmQcr9R1KY5ieZzlTHXMPxmGU=;
        b=Ti4ccvK3N7Xm22NUnU7Dj9Attzqf0Q+t5UgDYkdVtjVSM8frwdgoMmQZtvqPLbUsOx
         StW6tFL6QwyBnFQg7E40gvhHb3OcJK0xQZt5rXSMvWk7x59FRe/Rr9HLwDifkwyv8pmf
         Oq+QmzbeAOAoJO4Nd2tsBLi0DBRk7wrpVI3PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX1dxoa9iuYVNRE72fLmQcr9R1KY5ieZzlTHXMPxmGU=;
        b=DyJ5ErECgVNfXNq4P9bc9+a9wv6f08wRNeRY0mA4CD9I8mF/BpfOJx/Yt0y77qvCcJ
         Whxg13ZEo7F6WPqe0HrbwtYWPBB2XrE4Hnew8w3m8qeqhUvJaGJI8CzCoMhcnPdUkkkT
         g9W+582TObBdrOGZZcRaQqVlIhb4DeRt8v+yQB4xOCmgIKYfMHyPQQ2pWZRkvNOyK7VU
         c3FZyhoAv5UtGM0jUB6kfFvXTTer1lCX+AijXYbwrxg5CxULVVzlnhkkk8BOAgUoqxYE
         fnz1nA1RG1KV5E6wSp9unXNOa8BB0EMzNc8tQT4OYR6WW/3kv/b513jEhnqV+e40AGI/
         Lw4Q==
X-Gm-Message-State: AFqh2kp6HNNg+YZjve/SRmXfaPyWaxJv+pv0YVlAwo5N3FX7YDma0pQU
        gNxwxY7i0SA1vQt9ceWsDJwt4A==
X-Google-Smtp-Source: AMrXdXsF9brvXFDnyscg0lEaba7Pr/vbZ99f8sg18MQQrfOL3Yl/9Km13aZMw56VmvomnMkBTbTwUQ==
X-Received: by 2002:a17:906:d18f:b0:7c1:80d7:55f2 with SMTP id c15-20020a170906d18f00b007c180d755f2mr63974330ejz.48.1673258473691;
        Mon, 09 Jan 2023 02:01:13 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:cd22:9dd:6d54:8488])
        by smtp.gmail.com with ESMTPSA id bg14-20020a170906a04e00b007c094d31f35sm3557548ejb.76.2023.01.09.02.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:01:13 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 09 Jan 2023 11:00:48 +0100
Subject: [PATCH v4 1/5] media: uvc: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v4-1-a8ddc1358a29@chromium.org>
References: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v4-0-a8ddc1358a29@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3550; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=/aomtSJPanXG7kRlpjiU1jzPOL/grSL16QkCbPouDCQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBju+XghMh2GfOrpQ6sHWLkQ2wcMZP1nMeOhm7hvyt1
 1DbNAOiJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7vl4AAKCRDRN9E+zzrEiIR2EA
 CL3oS0zc9eDP+MZo3ZBNw0MPVAkbbgpjkWGBh/lb8zKA3AZpiXCQWgjbHAQkACS7IbU23pdKmbjB3O
 Co+k195+xwrXzTmIP8z0ly35cV9gGco/U6Yor3b5hxeWXZtRrQAkH4v1xSUXr5uG68p8/txrLlnI6z
 lG2cVlO+c9FCuwAZejAjzTjpANKtpl4024qeuNlkoBdqyOMUNC+UDcFamlA0epd1pcE3pNgFT1P58L
 LwfmX6vf+zQ8ridaNxj6NB5kakQkX2+5FUSFErc6HRlf6x/iXEEZGMtHUmmb2o60gorlCXFQcD3UO+
 u4QpKPfEYmaU0t+nnmmXVQKpubuL45F9u5rKxzP7v/CI2Y7VZgHxjyk2M3o8oEJvJ4pUc+a1rh+iH9
 huuG/Z62ISUUojosyOJQ6gXwyD8ltAtK+n+qtgoziaZdy2FWvRm6eJJ2itwufq5yCSldLK/Tq0MUhb
 lrg/12VpPmNlqc4n+gmlpXYb7eDyzceYkx7yu5+13YIH9few85COLCsdfCQpTFlBXQ7fjd0JOZhV8z
 Fl6pTWkB1HHJFxJSXfUrzCswrTWkGJE5mH23ySSFvMpIpqs1r0FKeO69kaMC0qDByw31Vjb2lnwOMN
 ty786YmiutDigG/EEv3JPsZvvQtdZpY4VD0imPcEUYFrhx15pqR9Xn0COrcg==
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
index d4b023d4de7c..710165502b5b 100644
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
+	if (buf->bytesused == 0 && len == header_size &&
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
