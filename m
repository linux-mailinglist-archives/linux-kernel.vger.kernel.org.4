Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EC56B157A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 23:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCHWp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 17:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCHWps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 17:45:48 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586596C3F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 14:45:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u9so72029954edd.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 14:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678315544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTSyQnL+DX5vQdXg5c4PiHio+TOgApxxG8f6MJvLPiI=;
        b=aHKYUKLuXlMzrYdGCOz61J90qL9YTceNNG5eun+9B2avxyk3WhtGZMGsj9MFWclpNj
         hU14Nm2eiSl6L7UVCQGDNPps89tyH2VO4TLrCn/i8HcOEneL9+xBTe8/UdLiXErvNWni
         5J9UmjHjSU4wwcqkiH66SVdyTi8cYpRmFMfmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678315544;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTSyQnL+DX5vQdXg5c4PiHio+TOgApxxG8f6MJvLPiI=;
        b=2ZdXjAuaGIjxfVxZpojAOMyuhGAY+iwRfNX0quCuQSG4Sj8P2EvGQTNC/UY+1WFP7R
         SMHmgeAslx4+j4A42CESEjF1n9HXthzOPu7wVVC4mIDazYeGCfx5Yu++2JwDpe2IWo43
         9gzi7vvKsWAFOKAe6DRbOrnthfF7A0x/x8lidjQZKAay7TswWSltgMSHHfWxGHMxyEb3
         O3ugXvZYqTklPQcwjh0OYuuKIegCeCj1mv315u6qX1BYeGHSPS7kMTdXFtajFpZxOpFv
         jA2dEDoagnWjZuYoNSgmAXa0oZpfrVgr+WtxwzMSA6l7U1GyeZzOH78L0ZrIfWndHhio
         BLhw==
X-Gm-Message-State: AO0yUKV2DWgVGad8HLKxEXxUSh4OVn08jFmzIJSYdREWiiZKJJcsPLuZ
        R9so3TswpKDFcVk+z+XPBO70Co7YK+EfEX+OPMufuQ==
X-Google-Smtp-Source: AK7set/5DCQLXpCqWi9nM1RnUXs+ebrrKmv86AfWgw0b7DumRkDE/L6/CBt0LLXUdsERFLD8XRYKRA==
X-Received: by 2002:aa7:d615:0:b0:4ef:4c08:ee9c with SMTP id c21-20020aa7d615000000b004ef4c08ee9cmr6894197edr.16.1678315544539;
        Wed, 08 Mar 2023 14:45:44 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id ot18-20020a170906ccd200b008e40853a712sm8040167ejb.97.2023.03.08.14.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 14:45:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 08 Mar 2023 23:45:32 +0100
Subject: [PATCH RESEND v5 1/5] media: uvc: Ignore empty TS packets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v5-1-139d1a144614@chromium.org>
References: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v5-0-139d1a144614@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=G1+fubIW/BdICDCrRg9jYl6ay0jxDPYdKiwuTQ04Efg=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkCRAPK9i7+2Di2bgdLI2+yNG/beqTk3HJgXqu4Ktw
 sJhiwg6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZAkQDwAKCRDRN9E+zzrEiPheD/
 0WvCdIkF9ILtv8vYaPC/KqHsiBh9KBOxyPVKicUUrKgjf06qw6+UqlX/Nlhhrb/GV2i8S0m9wy7wrF
 QKlC1PpzryKM5jTpfgLde3JXgYO6zOSVOpzJdAC2BbKxzGTAtzKRTVk/ZMhqV44KUXdcsDwZf/gdC8
 tdvrB6nAha0DCxsZwoe8UAqnlTa0h19wj0Fi13avfvL89CLnANxxD0xLdzCGGejRrFvtCd7MJZ5xQD
 7qRzuw3C3QU+5vmNMy4cynl8sWXHeDIUh+1ZdOViocu86a0uCNh0Qqh9VzsKJzH1lbxJkRNsCq5l2w
 Rd90s2fXtoAsKfvigL5YuzTEEy53mY0tgS+oYr0xTKqvs9O/bs3kKoOIBEs2N+ptDyYWo7UgMkjqeL
 rQqGhojFw4B17MmieJkCAquSCbxl9PIUtNBlMvAHWLYrUINJReqg66Ert4MTq+qp1VNBA0fFYYHmlz
 fgTl6ibUGuqLX9cXwBgOCZ6cKl3xKmcbd/tMYxo9QfhpQJ2B27oNed1LP+5io8o/mbsOCcuTq5kKko
 scq5UgiUsXPivemvkLGWZ/VVwsyAdXstXNc5tx+PkUOuuX+HIjxEwCPpIJ9DTAXvUtK47F9+mEht92
 cIZqm7/soaiuXreg4ZG3TBuNSsp4jfaJNV2fuccxwBWSKlg9jm5JhgWt879A==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
2.40.0.rc0.216.gc4246ad0f0-goog-b4-0.11.0-dev-696ae
