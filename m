Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F8E682D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjAaNDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjAaNDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:03:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71127DBC3;
        Tue, 31 Jan 2023 05:03:44 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d507:461a:a036:bf89])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74C096602E64;
        Tue, 31 Jan 2023 13:03:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675170222;
        bh=WeghlRFY57k/XRhbZSebcHWkeNrEWgqxdzHNHRFL4B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPMZQW+6mPld5iY05XVu/jzKUp14nNRqILmG+2SeyHEsWilC7fJXkERMX1p6Sn0cp
         3PzweKxJo4Y258kOw6aKYw7NzlkuXMiYcCGJE8T3mzL/nh/ZuCDePHuT1CjOPyrQun
         AKuWoTwNyxRBf6Lu0mjVtbkSJqbSRnefKzUgCpsf9hQTw4Oxq12JzW7LVKfp531/Bl
         HQx8rmiJ1GNWtak7KSh8FQj0R/It5ZwEGx0cYhMouGa28rpkUYslr912DwZmeH2ZXx
         kt1f6p9C4dqmkKK86M/h6zyGx6PB+kkpARFbwnrA8t9bIn/CnD+cCD1VxLdFC7hkk7
         J6kvO3O6S7a0g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v7 1/5] media: verisilicon: Do not set context src/dst formats in reset functions
Date:   Tue, 31 Jan 2023 14:03:23 +0100
Message-Id: <20230131130327.776899-2-benjamin.gaignard@collabora.com>
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

Setting context source and destination formats should only be done
in hantro_set_fmt_out() and hantro_set_fmt_cap() after check that
the targeted queue is not busy.
Remove these calls from hantro_reset_encoded_fmt() and
hantro_reset_raw_fmt() to clean the driver.

Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/verisilicon/hantro_v4l2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 2c7a805289e7..33cb865238de 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -381,13 +381,10 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
 
 	vpu_fmt = hantro_get_default_fmt(ctx, true);
 
-	if (ctx->is_encoder) {
-		ctx->vpu_dst_fmt = vpu_fmt;
+	if (ctx->is_encoder)
 		fmt = &ctx->dst_fmt;
-	} else {
-		ctx->vpu_src_fmt = vpu_fmt;
+	else
 		fmt = &ctx->src_fmt;
-	}
 
 	hantro_reset_fmt(fmt, vpu_fmt);
 	fmt->width = vpu_fmt->frmsize.min_width;
@@ -407,11 +404,9 @@ hantro_reset_raw_fmt(struct hantro_ctx *ctx)
 	raw_vpu_fmt = hantro_get_default_fmt(ctx, false);
 
 	if (ctx->is_encoder) {
-		ctx->vpu_src_fmt = raw_vpu_fmt;
 		raw_fmt = &ctx->src_fmt;
 		encoded_fmt = &ctx->dst_fmt;
 	} else {
-		ctx->vpu_dst_fmt = raw_vpu_fmt;
 		raw_fmt = &ctx->dst_fmt;
 		encoded_fmt = &ctx->src_fmt;
 	}
-- 
2.34.1

