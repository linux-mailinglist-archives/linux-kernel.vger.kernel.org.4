Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DE689367
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBCJRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbjBCJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:16:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4E991F3;
        Fri,  3 Feb 2023 01:16:37 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:d413:5f9c:fc3a:208d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 45E836602F0E;
        Fri,  3 Feb 2023 09:16:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675415796;
        bh=XkoUCITE8h1soeO51L0cqguHb/kDm/X/DMUUXHPEMvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFSvYdotWp7taqLyWxCkOcF2cgzFwo1c4wPNGGegBjxBOvXki5QvrFps6xL4yoMSF
         OJ80+PgWaRdG0Eaer3uja6uIFhv4xJV7DfQD/dwD2hKT+gMf15R0kIlCAhWGuctvCP
         xX7En04caQ9GRmosrgy9cT292T24zJ/6awv0tCs0m2zntbWqmpqFV5bwXLo92hz/tB
         vPHtlD0evqErzQS+CU+OMDR7eBeO2KUkoS2lxvm12sS5WmBkYOiT9YqMPEEuWgcQFK
         OqZqiR1tg0H3kcdgAgfYj6tddnk/NpIb7yLYxAc6UgmlDKL5gWDcKbKdWXS1K4IHwL
         nwdOu/Cfq5vAg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v8 3/6] media: verisilicon: Do not set ctx->bit_depth in hantro_try_ctrl()
Date:   Fri,  3 Feb 2023 10:16:19 +0100
Message-Id: <20230203091622.127279-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
References: <20230203091622.127279-1-benjamin.gaignard@collabora.com>
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

In hantro_try_ctrl() we should only check the values inside
control parameters and not set ctx->bit_depth. That must
be done in controls set function.
Create a set control function for hevc where ctx->bit_depth is
set at the right time.

Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/platform/verisilicon/hantro_drv.c   | 32 ++++++++++++++-----
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 8cb4a68c9119..6d8bc55ea627 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 
 static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct hantro_ctx *ctx;
-
-	ctx = container_of(ctrl->handler,
-			   struct hantro_ctx, ctrl_handler);
-
 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
 
@@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 		if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
 			/* Only 8-bit and 10-bit are supported */
 			return -EINVAL;
-
-		ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
 	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
 		const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
 
@@ -324,6 +317,24 @@ static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct hantro_ctx *ctx;
+
+	ctx = container_of(ctrl->handler,
+			   struct hantro_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_HEVC_SPS:
+		ctx->bit_depth = ctrl->p_new.p_hevc_sps->bit_depth_luma_minus8 + 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
@@ -336,6 +347,11 @@ static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
 	.s_ctrl = hantro_vp9_s_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
+	.try_ctrl = hantro_try_ctrl,
+	.s_ctrl = hantro_hevc_s_ctrl,
+};
+
 #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
 					 V4L2_JPEG_ACTIVE_MARKER_COM | \
 					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
@@ -470,7 +486,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_HEVC_SPS,
-			.ops = &hantro_ctrl_ops,
+			.ops = &hantro_hevc_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
-- 
2.34.1

