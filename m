Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3D6E0BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjDMKtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDMKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:49:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C20D1BC1;
        Thu, 13 Apr 2023 03:48:45 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7890:9d79:409d:b354])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A6AC660320E;
        Thu, 13 Apr 2023 11:48:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681382884;
        bh=G8T37k5l0CO+3iJ6HX4YP7p8rPxzJMywp+4MNjZsams=;
        h=From:To:Cc:Subject:Date:From;
        b=LmV0vxncSegEwhyO8MRwkkNnP8VdC+M1/lR330p6ZAyiVGvaQ5jpI/KUA2CUud4Rs
         t1NFSc2UySaWM5vs/BiVyYBuZg+NOBJg13HiANdPHxtUVIj55/MSjwRn3NJMjBsqvD
         RbFJUP1CCV9AxbeypuTvb71elHTG7dbM71dZqeX6mc6JooN60QojrB0xP8RUy9nWuB
         FxcJZa/vofYh9SmMeEn8+GYXagWdpWXsWG7/Rb8BKb0fSXd9ehOH2BarM/NrrHrNMr
         eB5GgCwFE2PNsbbRU0kKQ18Pqrz/V6sUIBKxJMy0B5s4ap+eeTIRuWQG1cfGNq5xnu
         80hV+fLj/FIHA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Date:   Thu, 13 Apr 2023 12:47:56 +0200
Message-Id: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
so assigne it to vpu_fmt led to crash the kernel.
Like for decoder case use 'fmt' as format for encoder and clean up
the code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")
---
version 2:
- Remove useless vpu_fmt.

 drivers/media/platform/verisilicon/hantro_v4l2.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
index 8f1414085f47..d71f79471396 100644
--- a/drivers/media/platform/verisilicon/hantro_v4l2.c
+++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
@@ -275,7 +275,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 			  struct v4l2_pix_format_mplane *pix_mp,
 			  enum v4l2_buf_type type)
 {
-	const struct hantro_fmt *fmt, *vpu_fmt;
+	const struct hantro_fmt *fmt;
 	bool capture = V4L2_TYPE_IS_CAPTURE(type);
 	bool coded;
 
@@ -295,11 +295,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 
 	if (coded) {
 		pix_mp->num_planes = 1;
-		vpu_fmt = fmt;
-	} else if (ctx->is_encoder) {
-		vpu_fmt = ctx->vpu_dst_fmt;
-	} else {
-		vpu_fmt = fmt;
+	} else if (!ctx->is_encoder) {
 		/*
 		 * Width/height on the CAPTURE end of a decoder are ignored and
 		 * replaced by the OUTPUT ones.
@@ -311,7 +307,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 	pix_mp->field = V4L2_FIELD_NONE;
 
 	v4l2_apply_frmsize_constraints(&pix_mp->width, &pix_mp->height,
-				       &vpu_fmt->frmsize);
+				       &fmt->frmsize);
 
 	if (!coded) {
 		/* Fill remaining fields */
-- 
2.34.1

