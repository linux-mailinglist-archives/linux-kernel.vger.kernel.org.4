Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6B66672C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjALM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjALM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:57:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0501A5130D;
        Thu, 12 Jan 2023 04:57:05 -0800 (PST)
Received: from localhost (89-26-75-29.goll.dyn.salzburg-online.at [89.26.75.29])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B56856602DB1;
        Thu, 12 Jan 2023 12:57:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673528223;
        bh=KAJmQ51TusAs/OBMlUcE6FAB/zXgKsXdACD+yS0cJJs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=abuLMAtI+0Ssmb0Qet0J4hPnVAdraA31EB3fvZ/zDjZvc2UyLQpbuGpOiFbxXhOqc
         S9NUy9xnqLwAqNNtyQFTUiP7+lJpwbtRYRwTevw/9OIF62BM43kv9v/Y8O5Dan8zJD
         zy3+0jfREptqFrzuMIuITsGVocKGn8VB9qrbRTUXlbka8E6UkheBghOkMgwWlfjhJ6
         bvU2BcEkzGokpvaFOODMzAKJe3+Xa3+EXgkqaaYK3u3a9zVb6+KOCsN5F9v9WFMQIW
         dAqSQiVNpyzqaypDHC12Df8AFUhQ4HVKlMv25c6RbKfbpJOAj4W627U9Xoa2Xkd1Up
         n9oHDOyuMFo1Q==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Thu, 12 Jan 2023 13:56:26 +0100
Subject: [PATCH v2 11/12] staging: media: rkvdec: Enable S_CTRL IOCTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230101-patch-series-v2-6-2-rc1-v2-11-fa1897efac14@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673528186; l=3704;
 i=sebastian.fricke@collabora.com; s=linux-media; h=from:subject:message-id;
 bh=KAJmQ51TusAs/OBMlUcE6FAB/zXgKsXdACD+yS0cJJs=;
 b=3Q8dYQ7JJV91gBKcZI7SdzmsUpSj8tSF8FmAoOpA4+8doicKKzpHZXOKqfCS3w0RSMTTwbQ545S3
 /EmOOuLQCwWk/liG7p+9gfjw2YEBe+DwYIkP0cAdOuppKUob+jYn
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

Enable user-space to set the SPS of the current byte-stream on the
decoder. This action will enable the decoder to pick the optimal
pixel-format for the capture queue, whenever it is required.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec.c | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index b303c6e0286d..3d413c5ad1d2 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -93,6 +93,79 @@ static int rkvdec_get_sps_attributes(struct rkvdec_ctx *ctx, void *sps,
 	return 0;
 }
 
+static int rkvdec_set_sps(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_pix_format_mplane *pix_mp;
+	struct sps_attributes attributes = {0};
+	void *new_sps = NULL;
+
+	/*
+	 * SPS structures are not filled until the control handler is set up
+	 */
+	if (!ctx->fh.ctrl_handler)
+		return 0;
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_H264_SPS:
+		new_sps = (void *)ctrl->p_new.p_h264_sps;
+		break;
+	case V4L2_CID_STATELESS_HEVC_SPS:
+		new_sps = (void *)ctrl->p_new.p_hevc_sps;
+		break;
+	default:
+		dev_err(ctx->dev->dev, "Unsupported stateless control ID: %x\n", ctrl->id);
+		return -EINVAL;
+	};
+	rkvdec_get_sps_attributes(ctx, new_sps, &attributes);
+
+	/*
+	 * Providing an empty SPS is valid but we do not store it.
+	 */
+	if (attributes.width == 0 && attributes.height == 0)
+		return 0;
+
+	pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+
+	/*
+	 * SPS must match the provided format dimension, if it doesn't userspace has to
+	 * first reset the output format
+	 */
+	if ((attributes.width > pix_mp->width) || (attributes.height > pix_mp->height)) {
+		dev_err(ctx->dev->dev,
+			"Dimension mismatch. [%s SPS] W: %d, H: %d, [Format] W: %d, H: %d)\n",
+			ctrl->id == V4L2_CID_STATELESS_HEVC_SPS ? "HEVC" : "H264",
+			attributes.width, attributes.height, pix_mp->width, pix_mp->height);
+		return -EINVAL;
+	}
+
+	if (ctx->sps && pix_mp->pixelformat == rkvdec_get_valid_fmt(ctx)) {
+		/*
+		 * Userspace is allowed to change the SPS at any point, if the
+		 * pixel format doesn't differ from the format in the context,
+		 * just accept the change even if buffers are queued
+		 */
+		ctx->sps = new_sps;
+	} else {
+		/*
+		 * Do not accept changing the SPS, while buffers are queued,
+		 * when the new SPS would cause switching the CAPTURE pixel format
+		 */
+		if (pix_mp->pixelformat != rkvdec_get_valid_fmt(ctx)) {
+			if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
+				return -EBUSY;
+		}
+		ctx->sps = new_sps;
+		/*
+		 * For the initial SPS setting and when the pixel format is
+		 * changed adjust the pixel format stored in the context
+		 */
+		pix_mp->pixelformat = rkvdec_get_valid_fmt(ctx);
+		rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
+	}
+
+	return 0;
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -104,8 +177,16 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
+
+	return rkvdec_set_sps(ctx, ctrl);
+}
+
 static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
 	.try_ctrl = rkvdec_try_ctrl,
+	.s_ctrl = rkvdec_s_ctrl,
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {

-- 
2.25.1
