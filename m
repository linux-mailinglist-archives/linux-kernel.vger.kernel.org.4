Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8789360BE40
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJXXLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiJXXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:03:57 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5002932BB0F;
        Mon, 24 Oct 2022 14:24:29 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id f37so18721147lfv.8;
        Mon, 24 Oct 2022 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aG8/ur0Br/iI3XrRIjCBua/JFahdxthZWhXGPmYrCVY=;
        b=b1VtBkfnMQzd5t4IFtX29bRFR2tFeeqSiyK+DgVMGnDMFkwI6Fdv3tQXaLqUfYRmBX
         LABuRSOpX3tq1jb12FjHU6AONUrmAIm6UtCJVjMth3JbjWKSa8lEGJFMsqhoLucJRxJ7
         1EQRVkRLurSwogDmO+oiR+aT3lFzKn3a4DnRIwKUet1oBYG6Fz4SbxU9i3VHYcZ06Uv1
         mJuSDGEYeBY+obEFffp+jSUTOioH8ymB9/SYto+FH+LiZl2eYtJHI9+gtE1oFz6Gg+Hc
         VX48riOkEnLyY1xyp2P1a+OZnxDJ+wZq8e6B6a3SiUZkzPuG8LBMUtruHPzNciDAdX1P
         Lt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aG8/ur0Br/iI3XrRIjCBua/JFahdxthZWhXGPmYrCVY=;
        b=mixOW+fGieneYVbvhiWw574OufwzgS45i3+qjqC+FqgSbtN75XM+2PQ8hJZcCyRHz3
         KlhLf+zkO++66fRqrYDD8XUUvsqMCiqs+PNzJy92nwQCcFKI4NNb/ms+PCpnmPWf9lIk
         ks/IzzJXP7dVGQMn844AtF68ubXijNS2VOrsmTpf0HEcSmiRIMOzP0pfl5BRSO+KIvhg
         vsEwASbeT8+jy+YTgGVnDoRihhN4DMTFeIZt2sAGKEcSalvVPy91MVeO5el/p1nMPdq5
         kZ6Z6ajm2gXdLDyn2qGkY18TZ2iFDYeBN8xsEy9jnVKIXZAvMcxnz85X8IjbH2XQyMlK
         GxKg==
X-Gm-Message-State: ACrzQf0HhwBdWUrImV/WvMmIFAwCwk410nDuno7NeIaUtVEBVs5voG/m
        4zMVtV6Hot1jRLok/4t2W1t0q2eTae1EtQ==
X-Google-Smtp-Source: AMsMyM65bNrzmT64/XilaVG1H03z+PxYZa+GqmEWO472GD+ya7NEER3wo36+wnZrO7ByhQJFAsbxyQ==
X-Received: by 2002:a17:907:7244:b0:78d:cedc:7a9e with SMTP id ds4-20020a170907724400b0078dcedc7a9emr28646077ejc.600.1666642540370;
        Mon, 24 Oct 2022 13:15:40 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id op7-20020a170906bce700b0073d638a7a89sm332023ejb.99.2022.10.24.13.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:15:40 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 10/11] media: cedrus: Adjust buffer size based on control values
Date:   Mon, 24 Oct 2022 22:15:14 +0200
Message-Id: <20221024201515.34129-11-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024201515.34129-1-jernej.skrabec@gmail.com>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases decoding engine needs extra space in capture buffers. This
is the case for decoding 10-bit HEVC frames into 8-bit capture format.
This commit only adds infrastructure for such cases.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c       | 14 ++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.h       |  2 ++
 drivers/staging/media/sunxi/cedrus/cedrus_video.c |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 70b07d8bad2b..fbe3b2e7c1d4 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -68,8 +68,22 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int cedrus_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct cedrus_ctx *ctx = container_of(ctrl->handler,
+					      struct cedrus_ctx, hdl);
+	struct vb2_queue *vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+					       V4L2_BUF_TYPE_VIDEO_CAPTURE);
+
+	if (!vb2_is_busy(vq) && !vb2_is_streaming(vq))
+		cedrus_reset_cap_format(ctx);
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops cedrus_ctrl_ops = {
 	.try_ctrl = cedrus_try_ctrl,
+	.s_ctrl = cedrus_s_ctrl,
 };
 
 static const struct cedrus_control cedrus_controls[] = {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 5904294f3108..774fe8048ce3 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -162,6 +162,8 @@ struct cedrus_dec_ops {
 	int (*start)(struct cedrus_ctx *ctx);
 	void (*stop)(struct cedrus_ctx *ctx);
 	void (*trigger)(struct cedrus_ctx *ctx);
+	unsigned int (*extra_cap_size)(struct cedrus_ctx *ctx,
+				       struct v4l2_pix_format *pix_fmt);
 };
 
 struct cedrus_variant {
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
index f9f723ea3f79..53e65f74046b 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
@@ -251,6 +251,10 @@ static int cedrus_try_fmt_vid_cap_p(struct cedrus_ctx *ctx,
 	pix_fmt->height = ctx->src_fmt.height;
 	cedrus_prepare_format(pix_fmt);
 
+	if (ctx->current_codec->extra_cap_size)
+		pix_fmt->sizeimage +=
+			ctx->current_codec->extra_cap_size(ctx, pix_fmt);
+
 	return 0;
 }
 
-- 
2.38.1

