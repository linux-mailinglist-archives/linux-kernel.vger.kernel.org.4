Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800FA65C4A5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbjACRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbjACRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:04:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81E13EA7;
        Tue,  3 Jan 2023 09:01:26 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:abfa:cf23:1e4e:2b14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3062F6602D10;
        Tue,  3 Jan 2023 17:01:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672765273;
        bh=YS7gfWx6wCz6Fr2gUdSfU3md7IhyQMW76MxxJmwbkng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QA9vMU10WAGPKM2qiwGWu7FUXTINSt/X5ReTR+ITl/PuBCcV654f7lp2td/xqz10j
         eSTDBXdqO/VDQgowTHixP0Nv8qnbKjLhTCvX1OG1Tpwlzf7npbM8X+PK4VZrx9qgTE
         c1dV8hrngOGfVjvHzSv5PJQIaye3oYcA1pjLf8pjU1eLH8SKbRC0iXIVMYjXyNWY4Y
         DaG9IGjAWtbB7e7cfB9NcmrwY9Xj5+TioEJfmSaHwMK2CdsOYCCk9zhAPucWR14AJ2
         V1OEwWKz/A2xaR00aMiJWbY3rq8xrPH1l7azZ81zvj6b7dTHYtKistWnFDOmqlJxJX
         hXHS9Y4aPe3Ww==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 08/13] media: verisilicon: Compute motion vectors size for AV1 frames
Date:   Tue,  3 Jan 2023 18:00:53 +0100
Message-Id: <20230103170058.810597-9-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
References: <20230103170058.810597-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute the additional space required to store motion vectors at
the end of the frames buffers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
v2:
- Remove useless +1 in sbs computation

 drivers/media/platform/verisilicon/hantro_hw.h      | 13 +++++++++++++
 .../media/platform/verisilicon/hantro_postproc.c    |  3 +++
 drivers/media/platform/verisilicon/hantro_v4l2.c    |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index e83f0c523a30..8b3bc7e31395 100644
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
+	return ALIGN(num_sbs * 384, 16) + 512;
+}
+
 int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
 int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
 void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
index 09d8cf942689..7dc39519a2ee 100644
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
index 162110ac118d..bbe79dbd2cd9 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -335,6 +335,11 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
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

