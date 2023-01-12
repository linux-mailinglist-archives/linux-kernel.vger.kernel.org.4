Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC76672C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjALM56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjALM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:57:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F020DEC9;
        Thu, 12 Jan 2023 04:57:01 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3DE736602DBC;
        Thu, 12 Jan 2023 12:57:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528220;
        bh=s+EQFfhyAuhQn7YicE5XWPWi6yC+rHeMTsHsU87SIDc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Eyo/iGEhDGKhLVHuYynBUcGxCA0HxniOOj0YZEwal5LZ6soLeyCp4E7HfoRrLRjJE
         +7CPbCElblJWl5FLdwz5ki6VcLqRHunXVfOk/eeKydjm0nZd0xMDazQUYyNDBj6KxP
         pOezH+PpLuIjcqzHCmBymhOJ5i4eCyoG8Tdk8lhF2uVIwCX9ezQEfpfV95CsbSWAL6
         ho+dTUNgvObJF1HFAQd6jiIyZ+etRpjnfwynf0OCN1ddZHY6lqgq7fAPdhBJSa+TWf
         B9yaXLU7wS/F0pZHXWBbL4XLWNpAP/pUEEVBjcnVkSgjvhIFuzNkBDg4tft8sNJKIL
         2S8s260THKobA==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:25 +0100
Subject: [PATCH v2 10/12] staging: media: rkvdec: Wrapper for pixel format preparation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-10-fa1897efac14@collabora.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=2354;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=s+EQFfhyAuhQn7YicE5XWPWi6yC+rHeMTsHsU87SIDc=;
 b=oUnmXcIum/7DI0U2ej2rfr/P1PixLPwOAObjiKfMcquGxYFvoCILsKjwmY7ITmfCmaF2++etqDiM
 TEkWc0fzCCv3jOdJWB4kONL9IPeV96X/47kcNH//+CB+vl9DcchG
X-Developer-Key: i=sebastian.fricke@collabora.com; a=ed25519;
 pk=pYXedPwrTtErcj7ERYeo/IpTrpe4QbJuEzSB52fslBg=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication by creating a wrapper around the preparation of
the `v4l2_pix_format_mplane` structure and the calculation of the
image size.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 8d948bcc4e46..b303c6e0286d 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,17 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
+				       struct v4l2_pix_format_mplane *pix_mp)
+{
+	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
+			    pix_mp->width, pix_mp->height);
+	pix_mp->plane_fmt[0].sizeimage += 128 *
+		DIV_ROUND_UP(pix_mp->width, 16) *
+		DIV_ROUND_UP(pix_mp->height, 16);
+	pix_mp->field = V4L2_FIELD_NONE;
+}
+
 static int rkvdec_queue_busy(struct rkvdec_ctx *ctx, enum v4l2_buf_type buf_type)
 {
 	struct vb2_queue *vq;
@@ -248,13 +259,9 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
 
 	rkvdec_reset_fmt(ctx, f, valid_fmt);
 	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
-			    ctx->coded_fmt_desc->decoded_fmts[0],
-			    ctx->coded_fmt.fmt.pix_mp.width,
-			    ctx->coded_fmt.fmt.pix_mp.height);
-	f->fmt.pix_mp.plane_fmt[0].sizeimage += 128 *
-		DIV_ROUND_UP(f->fmt.pix_mp.width, 16) *
-		DIV_ROUND_UP(f->fmt.pix_mp.height, 16);
+	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
+	f->fmt.pix_mp.height = ctx->coded_fmt.fmt.pix_mp.height;
+	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
 }
 
 static int rkvdec_enum_framesizes(struct file *file, void *priv,
@@ -324,13 +331,7 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 				       &pix_mp->height,
 				       &coded_desc->frmsize);
 
-	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
-			    pix_mp->width, pix_mp->height);
-	pix_mp->plane_fmt[0].sizeimage +=
-		128 *
-		DIV_ROUND_UP(pix_mp->width, 16) *
-		DIV_ROUND_UP(pix_mp->height, 16);
-	pix_mp->field = V4L2_FIELD_NONE;
+	rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
 
 	return 0;
 }

-- 
2.25.1
