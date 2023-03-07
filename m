Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628376ADE85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjCGMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCGMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:17:57 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F104C39;
        Tue,  7 Mar 2023 04:17:54 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 323F8FD70E;
        Tue,  7 Mar 2023 04:17:54 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kmKDXsAWeIhi; Tue,  7 Mar 2023 04:17:53 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678191473; bh=dUedRV4fSMe1xwSmq3u1x260PLI/0nWsLJYXAoGxVic=;
        h=From:To:Cc:Subject:Date:From;
        b=DbSLxUJfF1Oui8t1l0lxpj0PGd9v6NzHaZW81DNI73NzQ+PLGzaoeow9tJvuiunN7
         D9VwZS13ill/EvmIg7L4ZHxscb2a5kWUtxXVGoA+7Pm1bsUb/R5m7bp8pPGMmP16o+
         1L2tolB2BrN/Txliq5p47Ebz2M7KJceciFwYhbPz9USqMwfQ4yEL0vpZwYwWlNmmIy
         PhvVbOvJmzdl7C5sL9Lva//buUHMu5dsUfvxa0ZKKZD8ShSlG1i0YQ16v2nEUVDpSp
         deFy07KNmqbvHFj2f64e81iVafM/aEv98iKSlXYXBgcJjAC9WLcLepJdUam2PA/h0k
         DoPjPvwH8OFwQ==
To:     laurent.pinchart@ideasonboard.com, slongerbeam@gmail.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        gregkh@linuxfoundation.org, shawnguo@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@puri.sm, Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] media: imx: imx8mq-mipi-csi2: Use V4L2 subdev active state
Date:   Tue,  7 Mar 2023 13:17:29 +0100
Message-Id: <20230307121729.1419120-1-martin.kepplinger@puri.sm>
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

Simplify the driver by using the V4L2 subdev active state API to store
the active format.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/staging/media/imx/imx8mq-mipi-csi2.c | 108 +++++++------------
 1 file changed, 37 insertions(+), 71 deletions(-)

diff --git a/drivers/staging/media/imx/imx8mq-mipi-csi2.c b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
index c0d0bf770096..066409782058 100644
--- a/drivers/staging/media/imx/imx8mq-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx8mq-mipi-csi2.c
@@ -119,9 +119,7 @@ struct csi_state {
 
 	struct v4l2_mbus_config_mipi_csi2 bus;
 
-	struct mutex lock; /* Protect csi2_fmt, format_mbus, state, hs_settle */
-	const struct csi2_pix_format *csi2_fmt;
-	struct v4l2_mbus_framefmt format_mbus[MIPI_CSI2_PADS_NUM];
+	struct mutex lock; /* Protect state and hs_settle */
 	u32 state;
 	u32 hs_settle;
 
@@ -328,10 +326,18 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state)
 	u32 lane_rate;
 	unsigned long esc_clk_rate;
 	u32 min_ths_settle, max_ths_settle, ths_settle_ns, esc_clk_period_ns;
+	const struct v4l2_mbus_framefmt *fmt;
+	const struct csi2_pix_format *csi2_fmt;
+	struct v4l2_subdev_state *sd_state;
 
 	/* Calculate the line rate from the pixel rate. */
+
+	sd_state = v4l2_subdev_lock_and_get_active_state(&state->sd);
+	fmt = v4l2_subdev_get_pad_format(&state->sd, sd_state, MIPI_CSI2_PAD_SINK);
+	csi2_fmt = find_csi2_format(fmt->code);
+
 	link_freq = v4l2_get_link_freq(state->src_sd->ctrl_handler,
-				       state->csi2_fmt->width,
+				       csi2_fmt->width,
 				       state->bus.num_data_lanes * 2);
 	if (link_freq < 0) {
 		dev_err(state->dev, "Unable to obtain link frequency: %d\n",
@@ -455,29 +461,14 @@ static int imx8mq_mipi_csi_s_stream(struct v4l2_subdev *sd, int enable)
 	return ret;
 }
 
-static struct v4l2_mbus_framefmt *
-imx8mq_mipi_csi_get_format(struct csi_state *state,
-			   struct v4l2_subdev_state *sd_state,
-			   enum v4l2_subdev_format_whence which,
-			   unsigned int pad)
-{
-	if (which == V4L2_SUBDEV_FORMAT_TRY)
-		return v4l2_subdev_get_try_format(&state->sd, sd_state, pad);
-
-	return &state->format_mbus[pad];
-}
-
 static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
 				    struct v4l2_subdev_state *sd_state)
 {
-	struct csi_state *state = mipi_sd_to_csi2_state(sd);
 	struct v4l2_mbus_framefmt *fmt_sink;
 	struct v4l2_mbus_framefmt *fmt_source;
-	enum v4l2_subdev_format_whence which;
 
-	which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
-	fmt_sink = imx8mq_mipi_csi_get_format(state, sd_state, which,
-					      MIPI_CSI2_PAD_SINK);
+	fmt_sink = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SINK);
+	fmt_source = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
 
 	fmt_sink->code = MEDIA_BUS_FMT_SGBRG10_1X10;
 	fmt_sink->width = MIPI_CSI2_DEF_PIX_WIDTH;
@@ -491,38 +482,15 @@ static int imx8mq_mipi_csi_init_cfg(struct v4l2_subdev *sd,
 		V4L2_MAP_QUANTIZATION_DEFAULT(false, fmt_sink->colorspace,
 					      fmt_sink->ycbcr_enc);
 
-	fmt_source = imx8mq_mipi_csi_get_format(state, sd_state, which,
-						MIPI_CSI2_PAD_SOURCE);
 	*fmt_source = *fmt_sink;
 
 	return 0;
 }
 
-static int imx8mq_mipi_csi_get_fmt(struct v4l2_subdev *sd,
-				   struct v4l2_subdev_state *sd_state,
-				   struct v4l2_subdev_format *sdformat)
-{
-	struct csi_state *state = mipi_sd_to_csi2_state(sd);
-	struct v4l2_mbus_framefmt *fmt;
-
-	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
-					 sdformat->pad);
-
-	mutex_lock(&state->lock);
-
-	sdformat->format = *fmt;
-
-	mutex_unlock(&state->lock);
-
-	return 0;
-}
-
 static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
 					  struct v4l2_subdev_state *sd_state,
 					  struct v4l2_subdev_mbus_code_enum *code)
 {
-	struct csi_state *state = mipi_sd_to_csi2_state(sd);
-
 	/*
 	 * We can't transcode in any way, the source format is identical
 	 * to the sink format.
@@ -533,8 +501,7 @@ static int imx8mq_mipi_csi_enum_mbus_code(struct v4l2_subdev *sd,
 		if (code->index > 0)
 			return -EINVAL;
 
-		fmt = imx8mq_mipi_csi_get_format(state, sd_state, code->which,
-						 code->pad);
+		fmt = v4l2_subdev_get_pad_format(sd, sd_state, code->pad);
 		code->code = fmt->code;
 		return 0;
 	}
@@ -554,8 +521,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
 				   struct v4l2_subdev_state *sd_state,
 				   struct v4l2_subdev_format *sdformat)
 {
-	struct csi_state *state = mipi_sd_to_csi2_state(sd);
-	struct csi2_pix_format const *csi2_fmt;
+	const struct csi2_pix_format *csi2_fmt;
 	struct v4l2_mbus_framefmt *fmt;
 
 	/*
@@ -563,7 +529,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
 	 * modified.
 	 */
 	if (sdformat->pad == MIPI_CSI2_PAD_SOURCE)
-		return imx8mq_mipi_csi_get_fmt(sd, sd_state, sdformat);
+		return v4l2_subdev_get_fmt(sd, sd_state, sdformat);
 
 	if (sdformat->pad != MIPI_CSI2_PAD_SINK)
 		return -EINVAL;
@@ -572,10 +538,7 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
 	if (!csi2_fmt)
 		csi2_fmt = &imx8mq_mipi_csi_formats[0];
 
-	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
-					 sdformat->pad);
-
-	mutex_lock(&state->lock);
+	fmt = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
 
 	fmt->code = csi2_fmt->code;
 	fmt->width = sdformat->format.width;
@@ -584,16 +547,9 @@ static int imx8mq_mipi_csi_set_fmt(struct v4l2_subdev *sd,
 	sdformat->format = *fmt;
 
 	/* Propagate the format from sink to source. */
-	fmt = imx8mq_mipi_csi_get_format(state, sd_state, sdformat->which,
-					 MIPI_CSI2_PAD_SOURCE);
+	fmt = v4l2_subdev_get_pad_format(sd, sd_state, MIPI_CSI2_PAD_SOURCE);
 	*fmt = sdformat->format;
 
-	/* Store the CSI2 format descriptor for active formats. */
-	if (sdformat->which == V4L2_SUBDEV_FORMAT_ACTIVE)
-		state->csi2_fmt = csi2_fmt;
-
-	mutex_unlock(&state->lock);
-
 	return 0;
 }
 
@@ -604,7 +560,7 @@ static const struct v4l2_subdev_video_ops imx8mq_mipi_csi_video_ops = {
 static const struct v4l2_subdev_pad_ops imx8mq_mipi_csi_pad_ops = {
 	.init_cfg		= imx8mq_mipi_csi_init_cfg,
 	.enum_mbus_code		= imx8mq_mipi_csi_enum_mbus_code,
-	.get_fmt		= imx8mq_mipi_csi_get_fmt,
+	.get_fmt		= v4l2_subdev_get_fmt,
 	.set_fmt		= imx8mq_mipi_csi_set_fmt,
 };
 
@@ -821,6 +777,7 @@ static const struct dev_pm_ops imx8mq_mipi_csi_pm_ops = {
 static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
 {
 	struct v4l2_subdev *sd = &state->sd;
+	int ret;
 
 	v4l2_subdev_init(sd, &imx8mq_mipi_csi_subdev_ops);
 	sd->owner = THIS_MODULE;
@@ -834,15 +791,22 @@ static int imx8mq_mipi_csi_subdev_init(struct csi_state *state)
 
 	sd->dev = state->dev;
 
-	state->csi2_fmt = &imx8mq_mipi_csi_formats[0];
-	imx8mq_mipi_csi_init_cfg(sd, NULL);
-
 	state->pads[MIPI_CSI2_PAD_SINK].flags = MEDIA_PAD_FL_SINK
 					 | MEDIA_PAD_FL_MUST_CONNECT;
 	state->pads[MIPI_CSI2_PAD_SOURCE].flags = MEDIA_PAD_FL_SOURCE
 					   | MEDIA_PAD_FL_MUST_CONNECT;
-	return media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
-				      state->pads);
+	ret = media_entity_pads_init(&sd->entity, MIPI_CSI2_PADS_NUM,
+				     state->pads);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret) {
+		media_entity_cleanup(&sd->entity);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void imx8mq_mipi_csi_release_icc(struct platform_device *pdev)
@@ -949,6 +913,10 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
 	if (ret)
 		goto mutex;
 
+	ret = imx8mq_mipi_csi_async_register(state);
+	if (ret < 0)
+		goto cleanup;
+
 	/* Enable runtime PM. */
 	pm_runtime_enable(dev);
 	if (!pm_runtime_enabled(dev)) {
@@ -957,10 +925,6 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
 			goto icc;
 	}
 
-	ret = imx8mq_mipi_csi_async_register(state);
-	if (ret < 0)
-		goto cleanup;
-
 	return 0;
 
 cleanup:
@@ -968,6 +932,7 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
 	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
 
 	media_entity_cleanup(&state->sd.entity);
+	v4l2_subdev_cleanup(&state->sd);
 	v4l2_async_nf_unregister(&state->notifier);
 	v4l2_async_nf_cleanup(&state->notifier);
 	v4l2_async_unregister_subdev(&state->sd);
@@ -991,6 +956,7 @@ static int imx8mq_mipi_csi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	imx8mq_mipi_csi_runtime_suspend(&pdev->dev);
 	media_entity_cleanup(&state->sd.entity);
+	v4l2_subdev_cleanup(&state->sd);
 	mutex_destroy(&state->lock);
 	pm_runtime_set_suspended(&pdev->dev);
 	imx8mq_mipi_csi_release_icc(pdev);
-- 
2.30.2

