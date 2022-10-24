Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7660BD09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiJXWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiJXWDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:03:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F345FFD;
        Mon, 24 Oct 2022 13:17:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m15so33305250edb.13;
        Mon, 24 Oct 2022 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jVp3CG27o9+HdXrqFxf0SW9oZkiMXAzJ2FPuuiQx3Y=;
        b=AtN2GbQYKT6lPoTuMCBqyujg/iuyMiylMdjB+nkJ73us1MGbIG6V5NCEdtNN48a3Je
         Z3QKpfNwo0N3X3fTZ8ijGu71yjluzrtZteqa+uIRMgxLCZ9n9+HhIPN5mE6sOdgAhuLk
         BxNBaxlN5ghjjysmLNPNH4+29o5Kfb/t2IyqglOHA0eu0Ybkp7gmAa4qWFtwiXb6+Zf4
         jVCCk50+1ermsEL3r1qkRWODvUsIySj0CDoiWmhm38Ov+El7TNFL9URXEShbQ3usuBYT
         8ItrcYb8/hOaZq1bJlJfSK7QQqDiGQizSwtncL3umvhsz5WoA/khIMoP3zmzwmbHcLIg
         bXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jVp3CG27o9+HdXrqFxf0SW9oZkiMXAzJ2FPuuiQx3Y=;
        b=MFRMLzSNlOrUwBXj6UE5eqrdiL083u/VZ1+2DD2juJf9G3GvLs3HsR96l4hNenVfbq
         z2EIsM1wNVCFDF4HKxJK2xZF9dCa9eRhC/OtLknuxagp9lp9qAom/8Vi1D6clRaQSs0z
         p+ohit2JgDyxYn9A8Nngfx0RBUSFSDArHv8X+gik4/wpr3F/W9MIUNrFKJNBPYBYZYgz
         XDt3iPhQKps804tFeKQ2cfWEF7QrmyhQOcq2qw3aIdwc6pMTlSRCa8pja1Q9YWClNOr+
         vPtvwqCaPc+zwHQ3+VaIZ9IDu9HJvaOB6b8X5ZXb0qgE39ukyBlmBQmVghyR7i23u/ae
         heQw==
X-Gm-Message-State: ACrzQf3920so5ztW5mxaX3JXaeGdOXpFCifUeT8PtLN1j6Qyf1W2Y905
        OYMe2CxEn5inJreNqTLhbU4=
X-Google-Smtp-Source: AMsMyM5TZlmeIOe3i3DfrLsflw3y8/P19jMGoXJVrhuDfy549fh1803BHPep9M2rsrPSNmpLQGVrXQ==
X-Received: by 2002:a05:6402:b99:b0:461:afc3:9a02 with SMTP id cf25-20020a0564020b9900b00461afc39a02mr8405459edb.175.1666642534924;
        Mon, 24 Oct 2022 13:15:34 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:34 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 05/11] media: cedrus: Filter controls based on capability
Date:   Mon, 24 Oct 2022 22:15:09 +0200
Message-Id: <20221024201515.34129-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because not all Cedrus variants supports all codecs, controls should be
registered only if codec related to individual control is supported by
Cedrus.

Replace codec enum, which is not used at all, with capabilities flags
and register control only if capabilities are met.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 45 +++++++++++----------
 drivers/staging/media/sunxi/cedrus/cedrus.h |  2 +-
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 2f284a58d787..023566b02dc5 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -77,56 +77,56 @@ static const struct cedrus_control cedrus_controls[] = {
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_SEQUENCE,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_PICTURE,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_MPEG2_QUANTISATION,
 		},
-		.codec		= CEDRUS_CODEC_MPEG2,
+		.capabilities	= CEDRUS_CAPABILITY_MPEG2_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_DECODE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SLICE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SPS,
 			.ops	= &cedrus_ctrl_ops,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_PPS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_SCALING_MATRIX,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_H264_PRED_WEIGHTS,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
@@ -134,7 +134,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 			.def	= V4L2_STATELESS_H264_DECODE_MODE_SLICE_BASED,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
@@ -142,7 +142,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_H264_START_CODE_NONE,
 			.def	= V4L2_STATELESS_H264_START_CODE_NONE,
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	/*
 	 * We only expose supported profiles information,
@@ -160,20 +160,20 @@ static const struct cedrus_control cedrus_controls[] = {
 			.menu_skip_mask =
 				BIT(V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED),
 		},
-		.codec		= CEDRUS_CODEC_H264,
+		.capabilities	= CEDRUS_CAPABILITY_H264_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_SPS,
 			.ops	= &cedrus_ctrl_ops,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_PPS,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -181,13 +181,13 @@ static const struct cedrus_control cedrus_controls[] = {
 			/* The driver can only handle 1 entry per slice for now */
 			.dims   = { 1 },
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -197,7 +197,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max = 0xffffffff,
 			.step = 1,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -205,7 +205,7 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 			.def	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
@@ -213,19 +213,19 @@ static const struct cedrus_control cedrus_controls[] = {
 			.max	= V4L2_STATELESS_HEVC_START_CODE_NONE,
 			.def	= V4L2_STATELESS_HEVC_START_CODE_NONE,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 	{
 		.cfg = {
 			.id	= V4L2_CID_STATELESS_VP8_FRAME,
 		},
-		.codec		= CEDRUS_CODEC_VP8,
+		.capabilities	= CEDRUS_CAPABILITY_VP8_DEC,
 	},
 	{
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
 		},
-		.codec		= CEDRUS_CODEC_H265,
+		.capabilities	= CEDRUS_CAPABILITY_H265_DEC,
 	},
 };
 
@@ -275,6 +275,9 @@ static int cedrus_init_ctrls(struct cedrus_dev *dev, struct cedrus_ctx *ctx)
 		return -ENOMEM;
 
 	for (i = 0; i < CEDRUS_CONTROLS_COUNT; i++) {
+		if (!cedrus_is_capable(ctx, cedrus_controls[i].capabilities))
+			continue;
+
 		ctrl = v4l2_ctrl_new_custom(hdl, &cedrus_controls[i].cfg,
 					    NULL);
 		if (hdl->error) {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 1a98790a99af..7a1619967513 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -57,7 +57,7 @@ enum cedrus_h264_pic_type {
 
 struct cedrus_control {
 	struct v4l2_ctrl_config cfg;
-	enum cedrus_codec	codec;
+	unsigned int		capabilities;
 };
 
 struct cedrus_h264_run {
-- 
2.38.1

