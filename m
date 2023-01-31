Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7D682D38
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjAaNDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjAaNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:03:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7171210A92;
        Tue, 31 Jan 2023 05:03:44 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d507:461a:a036:bf89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EBE026602EBE;
        Tue, 31 Jan 2023 13:03:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675170223;
        bh=9xkh7Mz6B7KCpRaWkFO7AHPjQWKFgdQpvDXYN313zu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oipKafPzVPw8hqVNYxENXzkcnaBChLBb9p5uLxcXowHc83se6TvPnTtuXiqOY6Pui
         PnCMBNyqLqSlduR19Hlh5SkhQskD+q8sby5zGWibidnDtFAPWxZZlfYc0e7FwMxs0y
         FQlK8CHH+Ag/FPnMNBuqJCGL5U5NybJ6uBkPRSGJcfqZ12JdR5Dzi+xMJ8axkxBnWW
         jJAkxMkp2Kc/IoZh3jAFYP3NEflBhGRM9k2SdQL1KcyNktMyXrMTJLWCBV+6/3vd2D
         77KKDoBQtctUqfq2sM69aOl1uZCcKLT+dcof7L0pLjv1dGUSNGjbjLEBQNI7sMu+hf
         Phc63SR015EsA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 2/5] media: verisilicon: Do not use ctx fields as format storage when resetting
Date:   Tue, 31 Jan 2023 14:03:24 +0100
Message-Id: <20230131130327.776899-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
References: <20230131130327.776899-1-benjamin.gaignard@collabora.com>
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

Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/platform/verisilicon/hantro_v4l2.c  | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 33cb865238de..e60151a8a401 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -377,47 +377,43 @@ static void
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

