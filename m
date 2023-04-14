Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2666E1D13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjDNHYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNHYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:24:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32526BA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:24:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso17847362pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681457080; x=1684049080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBzwHgbHlbkIX1+1jya4URQRPxVtcK4lCnopWlW3FNE=;
        b=H09QuGYm1tKdhGDCIN8IAZaG/qotPFaB5znLvQx5E18Gge6fIEmvc/CCpfZRz/H/7z
         Hp4fdzKba244ZW3xI6Tgs+mqB9CjepEIG+bf8QSSvbqJFkjb90B8LKc1jcTfPQtF2QzW
         nEjpTdiB2yojKPTaddtOP2rgkmAvdy6sG6iqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681457080; x=1684049080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBzwHgbHlbkIX1+1jya4URQRPxVtcK4lCnopWlW3FNE=;
        b=CchQXPg7p5tEFG7H3htHLE9yvAOdWAm09FTH17L1Fntv3CBIpt0+OU1QvUTjNCCFHN
         meRcEOlTkvsHh8pI7/zm2a7ShJUkKESu08iGBXF1ac+uQ8sdySrinVNF16WoGHCKMOAt
         Q9MYnj+I2CvRTAgmEx7e24CNLA4jYrwSAe+gAMdoJ/hc3n8DpMq3MEYOiEasYG1ee45X
         mqU75zFJ/LNJM8JHYiv5SIk8YdHF3fHGvmD5UPU2dNcjg5cF+yiCw9bx4gsFBp6+R2DU
         BOoNCr4j4NzclL1RxexnmeFqT/P63aEIVE6kv3l0aMCGtQnp/LgtjjAsMCQcsdBM7vZv
         Anvg==
X-Gm-Message-State: AAQBX9eCXogd1fXTBaWrVkMTuhOQtYmix848J7CevRq+DNnyhs7vVqVY
        c5fuw9FUu/p+roEPg50a6MNtJA==
X-Google-Smtp-Source: AKy350Zf3dfzrNQyhn46sG0eax7pBVqiiJxRTT1y4L05b0LLqLTpGqbPwsciq0UKrtli2I4vAUXFeQ==
X-Received: by 2002:a17:903:11d0:b0:1a6:9671:253e with SMTP id q16-20020a17090311d000b001a69671253emr2335023plh.47.1681457080169;
        Fri, 14 Apr 2023 00:24:40 -0700 (PDT)
Received: from mstaudt.tok.corp.google.com ([2401:fa00:8f:203:7ca3:7f7b:7f34:5fb9])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902684500b0019f9fd5c24asm2490433pln.207.2023.04.14.00.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 00:24:39 -0700 (PDT)
From:   Max Staudt <mstaudt@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Max Staudt <mstaudt@chromium.org>
Subject: [PATCH v1] media: vivid: Extend FPS rates offered by simulated webcam
Date:   Fri, 14 Apr 2023 16:24:19 +0900
Message-ID: <20230414072419.1397808-1-mstaudt@chromium.org>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option for higher frame rates from a simulated webcam.

Currently, vivid emulates (amongst other things) a webcam with somewhat
limited bandwidth - higher resolutions deliver fewer frames per second.

$ yavta --enum-formats -c /dev/video0
Device /dev/video0 opened.
Device `vivid' on `platform:vivid-000' (driver 'vivid') supports video, capture, without mplanes.
- Available formats:
	Format 0: YUYV (56595559)
	Type: Video capture (1)
	Name: YUYV 4:2:2
	Frame size: 320x180 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 640x360 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40)
	Frame size: 640x480 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25)
	Frame size: 1280x720 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25)
	Frame size: 1920x1080 (1/1, 1/2, 1/4, 1/5)
	Frame size: 3840x2160 (1/1, 1/2)

In some test cases, it is useful to allow for higher frame rates, as
configurations such as 720p@30 FPS have become commonplace now.

This patch allows:
   0- 719p - 120fps
 720-1079p - 60fps
1080-2159p - 30fps
     2160p - 15fps

$ yavta --enum-formats -c /dev/video0
Device /dev/video0 opened.
Device `vivid' on `platform:vivid-000' (driver 'vivid') supports video, capture, without mplanes.
- Available formats:
	Format 0: YUYV (56595559)
	Type: Video capture (1)
	Name: YUYV 4:2:2
	Frame size: 320x180 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60, 1/120)
	Frame size: 640x360 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60, 1/120)
	Frame size: 640x480 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60, 1/120)
	Frame size: 1280x720 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 1920x1080 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30)
	Frame size: 3840x2160 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15)

Passes: v4l2-compliance 1.25.0-5039 from v4l-utils git ccc08732823f

Signed-off-by: Max Staudt <mstaudt@chromium.org>
---
 .../media/test-drivers/vivid/vivid-vid-cap.c  | 49 +++++++++++++------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index c0999581c599..27214f5f0811 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -45,13 +45,8 @@ static const struct vivid_fmt formats_ovl[] = {
 	},
 };
 
-/* The number of discrete webcam framesizes */
-#define VIVID_WEBCAM_SIZES 6
-/* The number of discrete webcam frameintervals */
-#define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
-
 /* Sizes must be in increasing order */
-static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
+static const struct v4l2_frmsize_discrete webcam_sizes[] = {
 	{  320, 180 },
 	{  640, 360 },
 	{  640, 480 },
@@ -64,21 +59,43 @@ static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
  * Intervals must be in increasing order and there must be twice as many
  * elements in this array as there are in webcam_sizes.
  */
-static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
+static const struct v4l2_fract webcam_intervals[] = {
 	{  1, 1 },
 	{  1, 2 },
 	{  1, 4 },
 	{  1, 5 },
 	{  1, 10 },
 	{  2, 25 },
-	{  1, 15 },
+	{  1, 15 }, /* 7 - maximum for 2160p */
 	{  1, 25 },
-	{  1, 30 },
+	{  1, 30 }, /* 9 - maximum for 1080p */
 	{  1, 40 },
 	{  1, 50 },
-	{  1, 60 },
+	{  1, 60 }, /* 12 - maximum for 720p */
+	{  1, 120 },
 };
 
+/* Limit maximum FPS rates for high resolutions */
+#define IVAL_COUNT_720P 12 /* 720p and up is limited to 60 fps */
+#define IVAL_COUNT_1080P 9 /* 1080p and up is limited to 30 fps */
+#define IVAL_COUNT_2160P 7 /* 2160p and up is limited to 15 fps */
+
+static inline unsigned webcam_ival_count(const struct vivid_dev *dev,
+					 unsigned frmsize_idx)
+{
+	if (webcam_sizes[frmsize_idx].height >= 2160)
+		return IVAL_COUNT_2160P;
+
+	if (webcam_sizes[frmsize_idx].height >= 1080)
+		return IVAL_COUNT_1080P;
+
+	if (webcam_sizes[frmsize_idx].height >= 720)
+		return IVAL_COUNT_720P;
+
+	/* For low resolutions, allow all FPS rates */
+	return ARRAY_SIZE(webcam_intervals);
+}
+
 static int vid_cap_queue_setup(struct vb2_queue *vq,
 		       unsigned *nbuffers, unsigned *nplanes,
 		       unsigned sizes[], struct device *alloc_devs[])
@@ -592,7 +609,7 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
 	if (vivid_is_webcam(dev)) {
 		const struct v4l2_frmsize_discrete *sz =
 			v4l2_find_nearest_size(webcam_sizes,
-					       VIVID_WEBCAM_SIZES, width,
+					       ARRAY_SIZE(webcam_sizes), width,
 					       height, mp->width, mp->height);
 
 		w = sz->width;
@@ -773,14 +790,16 @@ int vivid_s_fmt_vid_cap(struct file *file, void *priv,
 			compose->height /= factor;
 		}
 	} else if (vivid_is_webcam(dev)) {
+		unsigned ival_sz = webcam_ival_count(dev, dev->webcam_size_idx);
+
 		/* Guaranteed to be a match */
 		for (i = 0; i < ARRAY_SIZE(webcam_sizes); i++)
 			if (webcam_sizes[i].width == mp->width &&
 					webcam_sizes[i].height == mp->height)
 				break;
 		dev->webcam_size_idx = i;
-		if (dev->webcam_ival_idx >= 2 * (VIVID_WEBCAM_SIZES - i))
-			dev->webcam_ival_idx = 2 * (VIVID_WEBCAM_SIZES - i) - 1;
+		if (dev->webcam_ival_idx >= ival_sz)
+			dev->webcam_ival_idx = ival_sz - 1;
 		vivid_update_format_cap(dev, false);
 	} else {
 		struct v4l2_rect r = { 0, 0, mp->width, mp->height };
@@ -1908,7 +1927,7 @@ int vidioc_enum_frameintervals(struct file *file, void *priv,
 			break;
 	if (i == ARRAY_SIZE(webcam_sizes))
 		return -EINVAL;
-	if (fival->index >= 2 * (VIVID_WEBCAM_SIZES - i))
+	if (fival->index >= webcam_ival_count(dev, i))
 		return -EINVAL;
 	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
 	fival->discrete = webcam_intervals[fival->index];
@@ -1935,7 +1954,7 @@ int vivid_vid_cap_s_parm(struct file *file, void *priv,
 			  struct v4l2_streamparm *parm)
 {
 	struct vivid_dev *dev = video_drvdata(file);
-	unsigned ival_sz = 2 * (VIVID_WEBCAM_SIZES - dev->webcam_size_idx);
+	unsigned ival_sz = webcam_ival_count(dev, dev->webcam_size_idx);
 	struct v4l2_fract tpf;
 	unsigned i;
 
-- 
2.40.0.634.g4ca3ef3211-goog

