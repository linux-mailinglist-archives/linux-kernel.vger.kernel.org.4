Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404776C80E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjCXPNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjCXPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E573E144B0;
        Fri, 24 Mar 2023 08:12:53 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A7AFE0018;
        Fri, 24 Mar 2023 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enDGYKXiM7Q8LTC31mohdS3fckSaBNzhC8rrVAHdczM=;
        b=CuXi9HpMMawNmx1FJsELZhOeL/RZrZQ7VftiVYaBPSB3jaNIGNsCOclXvviJBNFCJrlDLi
        x0+54NA2avOS52wW3z+MpNrDKmc2O0aM+rGv3quwOyAQSw33LWwZAIvCjgVJYKnIURIHy3
        3rp7hfBKh6ikj4t+KCTQSoQl+pFVarQzbqn8c3fxTkPa7SD09aQsjmW4/3RhvhfCqMTAIL
        N6Yka5CE4pckxRyIRUwDT+JEg9BKCV9XfLp0zwK2YFab18Zg0YuqMmP28u+QRqx0+1w362
        iQeUuB9QqG75evhP/bKkPdp0TMZbUv7tH87DXMowSeDCCFHjN59MaxJgAugTzg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 8/9] media: sun6i-isp: capture: Implement MC I/O with extended enum_fmt
Date:   Fri, 24 Mar 2023 16:12:27 +0100
Message-Id: <20230324151228.2778112-9-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver needs the media-controller API to operate and should not be
considered as a video-device-centric implementation.

Properly report the IO_MC device cap and extend the enum_fmt
implementation to support enumeration with an explicit mbus_code.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c    | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
index 1595a9607775..5160b93b69ff 100644
--- a/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
+++ b/drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture.c
@@ -439,6 +439,12 @@ static int sun6i_isp_capture_enum_fmt(struct file *file, void *private,
 				      struct v4l2_fmtdesc *fmtdesc)
 {
 	u32 index = fmtdesc->index;
+	u32 mbus_code = fmtdesc->mbus_code;
+
+	if (mbus_code && !sun6i_isp_proc_format_find(mbus_code))
+		return -EINVAL;
+
+	/* Capture format is independent from proc format. */
 
 	if (index >= ARRAY_SIZE(sun6i_isp_capture_formats))
 		return -EINVAL;
@@ -685,7 +691,8 @@ int sun6i_isp_capture_setup(struct sun6i_isp_device *isp_dev)
 
 	strscpy(video_dev->name, SUN6I_ISP_CAPTURE_NAME,
 		sizeof(video_dev->name));
-	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
+				 V4L2_CAP_IO_MC;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
 	video_dev->fops = &sun6i_isp_capture_fops;
-- 
2.39.2

