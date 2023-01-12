Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C96672BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjALM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjALM4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:56:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7421050E41;
        Thu, 12 Jan 2023 04:56:52 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CAEF6602DB9;
        Thu, 12 Jan 2023 12:56:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528211;
        bh=L7yUo+Zy/WcujWFgTjyCDy8xs7O/0zxdTxZIPyBpgSk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=P22F8isb/92Gjf4AENjAKMgGWDmFwC0qIFR7iMIgoD9bBf9rFm664WPACZSLAr8E2
         qfajrA7qgYi5RoMLhupOs4cAP6zWL05znXgyChFWLKpziSUCzxy+2hrjfXNN7dXHWa
         0zHFrQsP6FZvz+0ew0u+No52ksa3xqB8VjYR74M0OaS8qN0CRB7YojDQSo6ZoAJGtr
         EjQL9xHzvjcnsFjrFiMR93+H8rstCGkRnMCshoJu05db/zuBOPM9wqLLatm//9x0TE
         jcl1H3/M/lAi6hMVNz6qQI+rELbEZeur5dMwA2IIuaY/+ydg2CE91YAxI1jb1XVVY/
         wI3oUA0Z1tQ7A==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:22 +0100
Subject: [PATCH v2 07/12] staging: media: rkvdec: Add a routine to fetch SPS
 attributes as a callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-7-fa1897efac14@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=2158;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=L7yUo+Zy/WcujWFgTjyCDy8xs7O/0zxdTxZIPyBpgSk=;
 b=BQBpXVr9E3Fn2xXJWy5utkd9tAkwvp5ZmvKorxmvoteBpq2FSBbzIP1smBJqXM3OVtIox4UT7+qw
 qNzHyG+6AZYM2KNQS3zMp/Hpk0VCVIgsydDjavwdm+2IKSiWNpT1
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

Add a callback for each codec variant, that fetches basic information
like resolution, bit-depth and sub-sampling from a SPS structure. This
data is used to verify whether a new SPS structure is valid.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec.c | 10 ++++++++++
 drivers/staging/media/rkvdec/rkvdec.h | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index a46f918926a2..e8c750a7343a 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -52,6 +52,16 @@ static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx)
 	return ctx->coded_fmt_desc->decoded_fmts[0];
 }
 
+static int rkvdec_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
+				     struct sps_attributes *attributes)
+{
+	const struct rkvdec_coded_fmt_desc *coded_desc = ctx->coded_fmt_desc;
+
+	if (coded_desc->ops->get_sps_attributes)
+		return coded_desc->ops->get_sps_attributes(ctx, sps, attributes);
+	return 0;
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index e353a4403e5b..7b6702c360fd 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -63,10 +63,20 @@ vb2_to_rkvdec_decoded_buf(struct vb2_buffer *buf)
 			    base.vb.vb2_buf);
 }
 
+struct sps_attributes {
+	unsigned int width;
+	unsigned int height;
+	unsigned int luma_bitdepth;
+	unsigned int chroma_bitdepth;
+	unsigned int subsampling;
+};
+
 struct rkvdec_coded_fmt_ops {
 	int (*adjust_fmt)(struct rkvdec_ctx *ctx,
 			  struct v4l2_format *f);
 	u32 (*valid_fmt)(struct rkvdec_ctx *ctx);
+	int (*get_sps_attributes)(struct rkvdec_ctx *ctx, void *sps,
+				  struct sps_attributes *attributes);
 	int (*start)(struct rkvdec_ctx *ctx);
 	void (*stop)(struct rkvdec_ctx *ctx);
 	int (*run)(struct rkvdec_ctx *ctx);

-- 
2.25.1
