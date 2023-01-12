Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC26672C0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjALM5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjALM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:56 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C097661;
        Thu, 12 Jan 2023 04:56:55 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71D096602DB1;
        Thu, 12 Jan 2023 12:56:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528214;
        bh=NR4NgmAwqSKt432W3wHLkNsbDlb7Ku6yU6hoKm5PFhw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iFWWVGd0PM+MpyqfisZJ8ZATeRpN9ueRYPloz+zab6riogtw9/H/jMvGclFgaXL27
         Iecy/xV1AUO4NhXd2HknaBrbA0KNS+e4fS8zCri1Gh8xW2Nod13mZ+LxeV5n8F5yjc
         +cURbe6rY59CdaVeW9cYcNKzo9bRGgp7M0wXHO+aM/vRP9rOQbnS+mBCiM8vilslz/
         G93/nO79P39GLfJEMTbEWrRV42SsXRH753uhUx1YgS5OC67wi014XyGjHPU2+rin1H
         7X5xq9KghhFbMBukRC+/7069InJwB7ymRkR6URNI299eTDzRWoAjRSU5t8Ca41MoFF
         wfWWZlcj7oERg==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:23 +0100
Subject: [PATCH v2 08/12] staging: media: rkvdec: Add a valid SPS check as a callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-8-fa1897efac14@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=3157;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=NR4NgmAwqSKt432W3wHLkNsbDlb7Ku6yU6hoKm5PFhw=;
 b=IQDkaNXJm1EiGyDmWoVKY4f+RD7CQ6A9pSeRltErtvX0pqcjW0RWXs2BZkhZonGnlhJ66v4IbQHv
 T3KBCKDWAP+0YbahHXPuYtABeVBdfI70Rp3wIpLpoKQRRGG5TI/Z
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

Add a callback for each codec variant, that ensures that a given format
is compatible with the SPS that is stored in the context of the
instance.
This is used for two scenarios:
- New output queue format is set, which is incompatible with the
  currently stored SPS
- Start streaming is called but the SPS doesn't match the current format
  anymore

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index e8c750a7343a..8d948bcc4e46 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -52,6 +52,26 @@ static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx)
 	return ctx->coded_fmt_desc->decoded_fmts[0];
 }
 
+static int rkvdec_sps_check(struct rkvdec_ctx *ctx, struct v4l2_pix_format_mplane *pix_mp)
+{
+	const struct rkvdec_coded_fmt_desc *coded_desc = ctx->coded_fmt_desc;
+
+	/*
+	 * When a codec doesn't implement the SPS check, handle it as if no
+	 * SPS exists for the codec.
+	 */
+	if (coded_desc->ops->sps_check) {
+		if (!ctx->sps)
+			return -EINVAL;
+
+		if (!pix_mp)
+			pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+		return coded_desc->ops->sps_check(ctx, ctx->sps, pix_mp);
+	}
+
+	return 0;
+}
+
 static int rkvdec_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
 				     struct sps_attributes *attributes)
 {
@@ -375,6 +395,13 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
 	struct vb2_queue *vq;
 	int ret;
 
+	/*
+	 * When the new output format doesn't match the existing SPS stored in
+	 * the context, then the SPS needs to be reset by user-space.
+	 */
+	if (rkvdec_sps_check(ctx, &f->fmt.pix_mp) < 0)
+		ctx->sps = NULL;
+
 	/*
 	 * In order to support dynamic resolution change, the decoder admits
 	 * a resolution change, as long as the pixelformat remains. Can't be
@@ -603,6 +630,14 @@ static int rkvdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (V4L2_TYPE_IS_CAPTURE(q->type))
 		return 0;
 
+	/*
+	 * An incompatible SPS at this point is invalid, abort the process.
+	 */
+	if (rkvdec_sps_check(ctx, NULL) < 0) {
+		ctx->sps = NULL;
+		return -EINVAL;
+	}
+
 	/*
 	 * Make sure that both the output and the capture queue are running
 	 */
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 7b6702c360fd..d74821f9fd0b 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -75,6 +75,7 @@ struct rkvdec_coded_fmt_ops {
 	int (*adjust_fmt)(struct rkvdec_ctx *ctx,
 			  struct v4l2_format *f);
 	u32 (*valid_fmt)(struct rkvdec_ctx *ctx);
+	int (*sps_check)(struct rkvdec_ctx *ctx, void *sps, struct v4l2_pix_format_mplane *pix_mp);
 	int (*get_sps_attributes)(struct rkvdec_ctx *ctx, void *sps,
 				  struct sps_attributes *attributes);
 	int (*start)(struct rkvdec_ctx *ctx);

-- 
2.25.1
