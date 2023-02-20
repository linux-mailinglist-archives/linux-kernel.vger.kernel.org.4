Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A603F69C8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjBTKtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjBTKtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:49:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1F1B77E;
        Mon, 20 Feb 2023 02:48:59 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d30c:b155:96fb:dcc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 362366602149;
        Mon, 20 Feb 2023 10:48:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676890138;
        bh=nAuFKvKMZ2YBTXOWwp+TuprTbhS3UMLPUmAFqn4ND1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHnsD/NNj+DyMumjt9VtCfdS16dVMvfR3ArcmpJYFx/Jz0vIJYEWJzw8uxZoSTHXU
         l9Aw7fyj34YpCyfsKPVsAWnK7DyBfWDrEcsxFLMG1SN+cmPb91FhILwC4lA+sKwoVm
         KaatgDdQUjx7HjZw7iUY7nleWSw8vNZiB1+hohhq7gjPuhFrCmj9iGPzvOl3Hw4vVz
         /9mkuooij25y5/TAGjlIB4OM5RPxqMouecSXpetfUwMrkIqW/NuS1kL039IfoUJORo
         ThLaJ29gaVwZ49vMEU8E7p93XSe6noqvgODtt4S88ZauIK59Q41mmBL3oPZBq2p5Uy
         kg2/RzwBo06ww==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk,
        robert.mader@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v9 2/6] media: verisilicon: Do not use ctx fields as format storage when resetting
Date:   Mon, 20 Feb 2023 11:48:45 +0100
Message-Id: <20230220104849.398203-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
References: <20230220104849.398203-1-benjamin.gaignard@collabora.com>
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

Source and destination pixel formats fields of context structure should
not be used as storage when resetting the format.
Use local variables instead and let hantro_set_fmt_out() and
hantro_set_fmt_cap() set them correctly later.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/platform/verisilicon/hantro_v4l2.c  | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index d8aa42bd4cd4..d94c99f875c8 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -378,47 +378,43 @@ static void
 hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 {
 	const struct hantro_fmt *vpu_fmt;
-	struct v4l2_pix_format_mplane *fmt;
+	struct v4l2_pix_format_mplane fmt;
 
 	vpu_fmt = hantro_get_default_fmt(ctx, true);
+	if (!vpu_fmt)
+		return;
 
+	hantro_reset_fmt(&fmt, vpu_fmt);
+	fmt.width = vpu_fmt->frmsize.min_width;
+	fmt.height = vpu_fmt->frmsize.min_height;
 	if (ctx->is_encoder)
-		fmt = &ctx->dst_fmt;
-	else
-		fmt = &ctx->src_fmt;
-
-	hantro_reset_fmt(fmt, vpu_fmt);
-	fmt->width = vpu_fmt->frmsize.min_width;
-	fmt->height = vpu_fmt->frmsize.min_height;
-	if (ctx->is_encoder)
-		hantro_set_fmt_cap(ctx, fmt);
+		hantro_set_fmt_cap(ctx, &fmt);
 	else
-		hantro_set_fmt_out(ctx, fmt);
+		hantro_set_fmt_out(ctx, &fmt);
 }
 
 static void
 hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 {
 	const struct hantro_fmt *raw_vpu_fmt;
-	struct v4l2_pix_format_mplane *raw_fmt, *encoded_fmt;
+	struct v4l2_pix_format_mplane raw_fmt, *encoded_fmt;
 
 	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
+	if (!raw_vpu_fmt)
+		return;
 
-	if (ctx->is_encoder) {
-		raw_fmt = &ctx->src_fmt;
+	if (ctx->is_encoder)
 		encoded_fmt = &ctx->dst_fmt;
-	} else {
-		raw_fmt = &ctx->dst_fmt;
+	else
 		encoded_fmt = &ctx->src_fmt;
-	}
 
-	hantro_reset_fmt(raw_fmt, raw_vpu_fmt);
-	raw_fmt->width = encoded_fmt->width;
-	raw_fmt->height = encoded_fmt->height;
+	hantro_reset_fmt(&raw_fmt, raw_vpu_fmt);
+	raw_fmt.width = encoded_fmt->width;
+	raw_fmt.height = encoded_fmt->height;
 	if (ctx->is_encoder)
-		hantro_set_fmt_out(ctx, raw_fmt);
+		hantro_set_fmt_out(ctx, &raw_fmt);
 	else
-		hantro_set_fmt_cap(ctx, raw_fmt);
+		hantro_set_fmt_cap(ctx, &raw_fmt);
 }
 
 void hantro_reset_fmts(struct hantro_ctx *ctx)
-- 
2.34.1

