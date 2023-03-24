Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED836C80E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjCXPNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjCXPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:13:10 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5380BB476;
        Fri, 24 Mar 2023 08:12:51 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 87CD6E000F;
        Fri, 24 Mar 2023 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679670769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibm3tSrzHRilK0eBOck6yRC9NMDYkOhhKkBru4BHJTA=;
        b=maCXEZC95D2g/i9VZ5tpBHfFcnTLOUQJ1MypJvDDCf74A0M9WoHL5bs+RIwRk8bgrDLnXN
        ua+6SzvTtX7A4/h0T2boXWqL1VIW6zkPeSCNR52PjXpryFVOjA6Oz6PBLrvsX1wfsnaL1E
        qclE37AWysUEkygHd3MtLrv4KLfIs5Y8gjsghOpL6KtjSRx17KThxcbBbvCcOHnABoymVD
        c1MHQi4omFqhwewKM1z0AAYQXC9qoHtqm42V6XMfGgF0u/oAxzDYdcEsSvqLAg+8usLb53
        MyqNJceNgYZwmqZsRjerh54qvZj3tWEhcGtvZL5gXJVE11aNVvUDVHvoouwQ7A==
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
Subject: [PATCH 6/9] media: sun6i-csi: capture: Implement MC I/O with extended enum_fmt
Date:   Fri, 24 Mar 2023 16:12:25 +0100
Message-Id: <20230324151228.2778112-7-paul.kocialkowski@bootlin.com>
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
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
index 6ce7f1d3ed57..9627030ff060 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
@@ -777,13 +777,40 @@ static int sun6i_csi_capture_enum_fmt(struct file *file, void *private,
 				      struct v4l2_fmtdesc *fmtdesc)
 {
 	u32 index = fmtdesc->index;
+	u32 mbus_code = fmtdesc->mbus_code;
+	unsigned int index_valid = 0;
+	unsigned int i;
+
+	if (!mbus_code) {
+		if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
+			return -EINVAL;
+
+		fmtdesc->pixelformat =
+			sun6i_csi_capture_formats[index].pixelformat;
+
+		return 0;
+	}
+
+	/* Check capture pixel format matching with mbus code. */
 
-	if (index >= ARRAY_SIZE(sun6i_csi_capture_formats))
+	if (!sun6i_csi_bridge_format_find(mbus_code))
 		return -EINVAL;
 
-	fmtdesc->pixelformat = sun6i_csi_capture_formats[index].pixelformat;
+	for (i = 0; i < ARRAY_SIZE(sun6i_csi_capture_formats); i++) {
+		u32 pixelformat = sun6i_csi_capture_formats[i].pixelformat;
 
-	return 0;
+		if (!sun6i_csi_capture_format_check(pixelformat, mbus_code))
+			continue;
+
+		if (index == index_valid) {
+			fmtdesc->pixelformat = pixelformat;
+			return 0;
+		}
+
+		index_valid++;
+	}
+
+	return -EINVAL;
 }
 
 static int sun6i_csi_capture_g_fmt(struct file *file, void *private,
@@ -1039,7 +1066,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev)
 
 	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
 		sizeof(video_dev->name));
-	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
+	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING |
+				 V4L2_CAP_IO_MC;
 	video_dev->vfl_dir = VFL_DIR_RX;
 	video_dev->release = video_device_release_empty;
 	video_dev->fops = &sun6i_csi_capture_fops;
-- 
2.39.2

