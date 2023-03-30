Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34EC6D0A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjC3Pla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjC3PlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:41:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7326335A1;
        Thu, 30 Mar 2023 08:40:59 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:792c:96d5:14:366a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87DA06603193;
        Thu, 30 Mar 2023 16:40:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680190854;
        bh=bQOfFeqoqCXSqQ11dHdmp90ArqJFyswk/HJjMlkGbwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYX4FGLNEj9mOxBw9O84U0WQuaMrzwWt3vk12jOZ951mRcwsqMre/kHi+c11xJEyu
         wnbvIOOSIEdq5H+Evs5rfu0en5OsAITllxEAXGpgxbRsxPCRdbCw1+JucV1ATr9tuv
         5+Z+hiexA/gBPhl4uFfdjL3cZUuFOUuq29FUH3Cdwc8TNFqylozPk+UrAbbIZJ7Nxy
         MGr4iZjFlBxFn6gEuhbtBfJWt5onvvl83pt8jnsosdwIaHzTkSQj1Jkj5EYeKKcdYh
         GMUtWsh5ck2cNzbJMXvXnteLio0ivGoT+4cj4vhNTscUftuahv24YzJlH+f7v5tz6O
         rsTT4TAc3w9tQ==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 07/13] media: verisilicon: Compute motion vectors size for AV1 frames
Date:   Thu, 30 Mar 2023 17:40:37 +0200
Message-Id: <20230330154043.1250736-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute the additional space required to store motion vectors at
the end of the frames buffers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_hw.h      | 13 +++++++++++++
 .../media/platform/verisilicon/hantro_postproc.c    |  3 +++
 drivers/media/platform/verisilicon/hantro_v4l2.c    |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index e83f0c523a30..bc61d4e051c7 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -417,6 +417,19 @@ hantro_hevc_mv_size(unsigned int width, unsigned int height)
 	return width * height / 16;
 }
 
+static inline unsigned short hantro_av1_num_sbs(unsigned short dimension)
+{
+	return DIV_ROUND_UP(dimension, 64);
+}
+
+static inline size_t
+hantro_av1_mv_size(unsigned int width, unsigned int height)
+{
+	size_t num_sbs = hantro_av1_num_sbs(width) * hantro_av1_num_sbs(height);
+
+	return ALIGN(num_sbs * 384, 16) * 2 + 512;
+}
+
 int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
 int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 6437423ccf3a..bb16af50719d 100644
--- a/drivers/media/platform/verisilicon/hantro_postproc.c
+++ b/drivers/media/platform/verisilicon/hantro_postproc.c
@@ -213,6 +213,9 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
 		buf_size += hantro_hevc_mv_size(pix_mp.width,
 						pix_mp.height);
+	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_AV1_FRAME)
+		buf_size += hantro_av1_mv_size(pix_mp.width,
+					       pix_mp.height);
 
 	for (i = 0; i < num_buffers; ++i) {
 		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index e2a8838f75f0..c218c9781e73 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -337,6 +337,11 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 			pix_mp->plane_fmt[0].sizeimage +=
 				hantro_hevc_mv_size(pix_mp->width,
 						    pix_mp->height);
+		else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_AV1_FRAME &&
+			 !hantro_needs_postproc(ctx, fmt))
+			pix_mp->plane_fmt[0].sizeimage +=
+				hantro_av1_mv_size(pix_mp->width,
+						   pix_mp->height);
 	} else if (!pix_mp->plane_fmt[0].sizeimage) {
 		/*
 		 * For coded formats the application can specify
-- 
2.34.1

