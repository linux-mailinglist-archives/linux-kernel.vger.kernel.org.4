Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9099C6DC396
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 08:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDJGfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 02:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjDJGfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 02:35:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9664234
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 23:35:20 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 90-20020a17090a0fe300b0023b4bcf0727so3653704pjz.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 23:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681108520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pE8Xixo+TICdPiGFAuNSIk6ig9wvTIQUamx/6iLwBic=;
        b=UiR9ijr24uUbwDKEPpWzHwgXtJ6jitLNom9Elkf8tTrw+wbGgDliQ1/yMnx9xUnm7S
         MgigofOUl4uR78975dlHVogMpuifE6pz49gq6POOMatwaVGmSXu3KK5WbeRQ5Kc450yg
         0s+H3hsJ5RN59961UO+p2BpbOozuzhOYuKjo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681108520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pE8Xixo+TICdPiGFAuNSIk6ig9wvTIQUamx/6iLwBic=;
        b=VQ3FKKfn18wlTRkenXUHV8WoJOpefkN/y7LceU/ebD7D1l9efkAo9se2/m9ABSuWRF
         yZXwJBzMu7muyGRGu26/qZ9Wa/irLR1BRw6ncHKOzB8TZJFHGuBbMDi2Qf8caZNWCZDP
         9xITx7MwsBnZIAy27Z1z0NJxvozmlVJBM8Nl45cyOLA4UUY4Y+IsoJui5M96OiaJAjzM
         9Op5vEx9W0XMOkLDkTgulkcnZBSDjjA55VfETbjDLhCaaMlVAD9VWoL5DpOmXv8Y5LcR
         axBd2nQGW5jM7FU/grc7mIqmYic6hmH3EoLZpcOqFkcsg68Mh/prr8t8xjpkCyn18ptp
         XFEQ==
X-Gm-Message-State: AAQBX9ecraqbjpLgxLuGpq1NU0a1zX4jnXBrg660gKE2nkP8slhvS9He
        lqUxV21tv1k2LXhr5kRc1W9c4Q==
X-Google-Smtp-Source: AKy350afPKTwGxGfJaH+LV5BlpGrnHlb8vpkh8oaPc8WryPb6mHCeW8eCOi6aaeFJmOoU5FukP1lcw==
X-Received: by 2002:a17:903:1112:b0:1a3:d4c7:365b with SMTP id n18-20020a170903111200b001a3d4c7365bmr14426768plh.3.1681108519958;
        Sun, 09 Apr 2023 23:35:19 -0700 (PDT)
Received: from mstaudt.tok.corp.google.com ([2401:fa00:8f:203:cf15:93f:d468:3104])
        by smtp.gmail.com with ESMTPSA id jg14-20020a17090326ce00b001a1fe42a141sm6963372plb.115.2023.04.09.23.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 23:35:19 -0700 (PDT)
From:   Max Staudt <mstaudt@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Max Staudt <mstaudt@chromium.org>
Subject: [PATCH v1] media: vivid: Add webcam parameter for (un)limited bandwidth
Date:   Mon, 10 Apr 2023 15:33:56 +0900
Message-Id: <20230410063356.3894767-1-mstaudt@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option for higher frame rates from a simulated webcam.

Currently, vivid emulates (amongst other things) a webcam with somewhat
limited bandwidth - higher resolutions deliver fewer frames per second:

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

With `webcam_bandwidth_limit=0` we get more options:

$ yavta --enum-formats -c /dev/video0
Device /dev/video0 opened.
Device `vivid' on `platform:vivid-000' (driver 'vivid') supports video, capture, without mplanes.
- Available formats:
	Format 0: YUYV (56595559)
	Type: Video capture (1)
	Name: YUYV 4:2:2
	Frame size: 320x180 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 640x360 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 640x480 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 1280x720 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 1920x1080 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)
	Frame size: 3840x2160 (1/1, 1/2, 1/4, 1/5, 1/10, 2/25, 1/15, 1/25, 1/30, 1/40, 1/50, 1/60)

Passes v4l2-compliance 1.25.0-5039 from v4l-utils git ccc08732823f

Signed-off-by: Max Staudt <mstaudt@chromium.org>
---
 Documentation/admin-guide/media/vivid.rst     | 25 +++++++++++++++++++
 drivers/media/test-drivers/vivid/vivid-core.c |  8 ++++++
 drivers/media/test-drivers/vivid/vivid-core.h |  1 +
 .../media/test-drivers/vivid/vivid-vid-cap.c  | 18 ++++++++++---
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/media/vivid.rst b/Documentation/admin-guide/media/vivid.rst
index 58ac25b2c385..e65067550efc 100644
--- a/Documentation/admin-guide/media/vivid.rst
+++ b/Documentation/admin-guide/media/vivid.rst
@@ -110,6 +110,28 @@ all configurable using the following module options:
 
 		num_inputs=8 input_types=0xffa9
 
+- webcam_bandwidth_limit:
+
+	whether a simulated webcam offers fewer frames per second for higher
+	resolutions. This only affects webcam inputs as selected in input_types
+	and is ignored for all other inputs. It affects all webcam inputs of
+	a vivid instance.
+
+		- 0: All predefined frame intervals available for all
+		     predefined resolutions
+		- 1: Simulate limited bandwidth by removing two FPS rates
+		     for each step up in resolution
+
+	The default is for all webcams to cap their FPS at high resolutions.
+	This maintains the behaviour known from earlier versions of vivid.
+
+	To enable all frame rates across all resolutions on webcam inputs, load
+	vivid with this option set to 0:
+
+	.. code-block:: none
+
+		webcam_bandwidth_limit=0
+
 - num_outputs:
 
 	the number of outputs, one for each instance. By default 2 outputs
@@ -336,6 +358,9 @@ supports frames per second settings of 10, 15, 25, 30, 50 and 60 fps. Which ones
 are available depends on the chosen framesize: the larger the framesize, the
 lower the maximum frames per second.
 
+The FPS limit for higher resolutions can be disabled by passing the
+`webcam_bandwidth_limit=0` parameter.
+
 The initially selected colorspace when you switch to the webcam input will be
 sRGB.
 
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index f28440e6c9f8..720ffe470709 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -143,6 +143,11 @@ MODULE_PARM_DESC(input_types, " input types, default is 0xe4. Two bits per input
 			      "\t\t    bits 0-1 == input 0, bits 31-30 == input 15.\n"
 			      "\t\t    Type 0 == webcam, 1 == TV, 2 == S-Video, 3 == HDMI");
 
+/* Default: limited webcam bandwidth */
+static bool webcam_bandwidth_limit[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = true };
+module_param_array(webcam_bandwidth_limit, bool, NULL, 0444);
+MODULE_PARM_DESC(webcam_bandwidth_limit, " for webcam inputs, cap FPS at higher frame sizes (default: true).");
+
 /* Default: 2 outputs */
 static unsigned num_outputs[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = 2 };
 module_param_array(num_outputs, uint, NULL, 0444);
@@ -940,6 +945,9 @@ static int vivid_detect_feature_set(struct vivid_dev *dev, int inst,
 	v4l2_info(&dev->v4l2_dev, "using %splanar format API\n",
 			dev->multiplanar ? "multi" : "single ");
 
+	/* Are "webcam" type inputs of this instance rate limited? */
+	dev->webcam_bandwidth_limit = webcam_bandwidth_limit[inst];
+
 	/* how many inputs do we have and of what type? */
 	dev->num_inputs = num_inputs[inst];
 	if (node_type & 0x20007) {
diff --git a/drivers/media/test-drivers/vivid/vivid-core.h b/drivers/media/test-drivers/vivid/vivid-core.h
index 473f3598db5a..aa38988384e4 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.h
+++ b/drivers/media/test-drivers/vivid/vivid-core.h
@@ -186,6 +186,7 @@ struct vivid_dev {
 	unsigned int			num_hdmi_outputs;
 	u8				output_type[MAX_OUTPUTS];
 	u8				output_name_counter[MAX_OUTPUTS];
+	bool				webcam_bandwidth_limit;
 	bool				has_audio_inputs;
 	bool				has_audio_outputs;
 	bool				has_vid_cap;
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index c0999581c599..347c51f36386 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -79,6 +79,14 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
 	{  1, 60 },
 };
 
+static inline unsigned webcam_ival_count(const struct vivid_dev *dev,
+					 unsigned frmsize_idx)
+{
+	return dev->webcam_bandwidth_limit ?
+		2 * (VIVID_WEBCAM_SIZES - frmsize_idx) :
+		2 * (VIVID_WEBCAM_SIZES);
+}
+
 static int vid_cap_queue_setup(struct vb2_queue *vq,
 		       unsigned *nbuffers, unsigned *nplanes,
 		       unsigned sizes[], struct device *alloc_devs[])
@@ -773,14 +781,16 @@ int vivid_s_fmt_vid_cap(struct file *file, void *priv,
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
@@ -1908,7 +1918,7 @@ int vidioc_enum_frameintervals(struct file *file, void *priv,
 			break;
 	if (i == ARRAY_SIZE(webcam_sizes))
 		return -EINVAL;
-	if (fival->index >= 2 * (VIVID_WEBCAM_SIZES - i))
+	if (fival->index >= webcam_ival_count(dev, i))
 		return -EINVAL;
 	fival->type = V4L2_FRMIVAL_TYPE_DISCRETE;
 	fival->discrete = webcam_intervals[fival->index];
@@ -1935,7 +1945,7 @@ int vivid_vid_cap_s_parm(struct file *file, void *priv,
 			  struct v4l2_streamparm *parm)
 {
 	struct vivid_dev *dev = video_drvdata(file);
-	unsigned ival_sz = 2 * (VIVID_WEBCAM_SIZES - dev->webcam_size_idx);
+	unsigned ival_sz = webcam_ival_count(dev, dev->webcam_size_idx);
 	struct v4l2_fract tpf;
 	unsigned i;
 
-- 
2.40.0.577.gac1e443424-goog

