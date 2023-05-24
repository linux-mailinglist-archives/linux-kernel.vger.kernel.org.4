Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6370F79A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjEXN3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjEXN3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:29:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C0C13E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:29:32 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1q1oYU-0007Bo-Ry; Wed, 24 May 2023 15:29:30 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
Date:   Wed, 24 May 2023 15:29:25 +0200
Subject: [PATCH 2/2] media: video-mux: update driver to active state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230524-video-mux-active-state-v1-2-325c69937ac3@pengutronix.de>
References: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
In-Reply-To: <20230524-video-mux-active-state-v1-0-325c69937ac3@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.12-dev-aab37
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the open coded pad format array, use subdev active state instead.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/media/platform/video-mux.c | 78 ++++++++++++--------------------------
 1 file changed, 24 insertions(+), 54 deletions(-)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 4fe31386afc7..6d273abfe16c 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -24,7 +24,6 @@ struct video_mux {
 	struct v4l2_subdev subdev;
 	struct v4l2_async_notifier notifier;
 	struct media_pad *pads;
-	struct v4l2_mbus_framefmt *format_mbus;
 	struct mux_control *mux;
 	struct mutex lock;
 	int active;
@@ -71,6 +70,9 @@ static int video_mux_link_setup(struct media_entity *entity,
 	mutex_lock(&vmux->lock);
 
 	if (flags & MEDIA_LNK_FL_ENABLED) {
+		struct v4l2_subdev_state *sd_state;
+		struct v4l2_mbus_framefmt *source_mbusformat;
+
 		if (vmux->active == local->index)
 			goto out;
 
@@ -86,7 +88,12 @@ static int video_mux_link_setup(struct media_entity *entity,
 		vmux->active = local->index;
 
 		/* Propagate the active format to the source */
-		vmux->format_mbus[source_pad] = vmux->format_mbus[vmux->active];
+		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
+		source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state,
+							       source_pad);
+		*source_mbusformat = *v4l2_subdev_get_pad_format(sd, sd_state,
+								 vmux->active);
+		v4l2_subdev_unlock_state(sd_state);
 	} else {
 		if (vmux->active != local->index)
 			goto out;
@@ -138,40 +145,6 @@ static const struct v4l2_subdev_video_ops video_mux_subdev_video_ops = {
 	.s_stream = video_mux_s_stream,
 };
 
-static struct v4l2_mbus_framefmt *
-__video_mux_get_pad_format(struct v4l2_subdev *sd,
-			   struct v4l2_subdev_state *sd_state,
-			   unsigned int pad, u32 which)
-{
-	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
-
-	switch (which) {
-	case V4L2_SUBDEV_FORMAT_TRY:
-		return v4l2_subdev_get_try_format(sd, sd_state, pad);
-	case V4L2_SUBDEV_FORMAT_ACTIVE:
-		return &vmux->format_mbus[pad];
-	default:
-		return NULL;
-	}
-}
-
-static int video_mux_get_format(struct v4l2_subdev *sd,
-			    struct v4l2_subdev_state *sd_state,
-			    struct v4l2_subdev_format *sdformat)
-{
-	struct video_mux *vmux = v4l2_subdev_to_video_mux(sd);
-
-	mutex_lock(&vmux->lock);
-
-	sdformat->format = *__video_mux_get_pad_format(sd, sd_state,
-						       sdformat->pad,
-						       sdformat->which);
-
-	mutex_unlock(&vmux->lock);
-
-	return 0;
-}
-
 static int video_mux_set_format(struct v4l2_subdev *sd,
 			    struct v4l2_subdev_state *sd_state,
 			    struct v4l2_subdev_format *sdformat)
@@ -181,14 +154,11 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
 	struct media_pad *pad = &vmux->pads[sdformat->pad];
 	u16 source_pad = sd->entity.num_pads - 1;
 
-	mbusformat = __video_mux_get_pad_format(sd, sd_state, sdformat->pad,
-						sdformat->which);
+	mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, sdformat->pad);
 	if (!mbusformat)
 		return -EINVAL;
 
-	source_mbusformat = __video_mux_get_pad_format(sd, sd_state,
-						       source_pad,
-						       sdformat->which);
+	source_mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, source_pad);
 	if (!source_mbusformat)
 		return -EINVAL;
 
@@ -298,7 +268,8 @@ static int video_mux_set_format(struct v4l2_subdev *sd,
 
 	/* Source pad mirrors active sink pad, no limitations on sink pads */
 	if ((pad->flags & MEDIA_PAD_FL_SOURCE) && vmux->active >= 0)
-		sdformat->format = vmux->format_mbus[vmux->active];
+		sdformat->format = *v4l2_subdev_get_pad_format(sd, sd_state,
+							       vmux->active);
 
 	*mbusformat = sdformat->format;
 
@@ -321,7 +292,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
 	mutex_lock(&vmux->lock);
 
 	for (i = 0; i < sd->entity.num_pads; i++) {
-		mbusformat = v4l2_subdev_get_try_format(sd, sd_state, i);
+		mbusformat = v4l2_subdev_get_pad_format(sd, sd_state, i);
 		*mbusformat = video_mux_format_mbus_default;
 	}
 
@@ -332,7 +303,7 @@ static int video_mux_init_cfg(struct v4l2_subdev *sd,
 
 static const struct v4l2_subdev_pad_ops video_mux_pad_ops = {
 	.init_cfg = video_mux_init_cfg,
-	.get_fmt = video_mux_get_format,
+	.get_fmt = v4l2_subdev_get_fmt,
 	.set_fmt = video_mux_set_format,
 };
 
@@ -462,17 +433,9 @@ static int video_mux_probe(struct platform_device *pdev)
 	if (!vmux->pads)
 		return -ENOMEM;
 
-	vmux->format_mbus = devm_kcalloc(dev, num_pads,
-					 sizeof(*vmux->format_mbus),
-					 GFP_KERNEL);
-	if (!vmux->format_mbus)
-		return -ENOMEM;
-
-	for (i = 0; i < num_pads; i++) {
+	for (i = 0; i < num_pads; i++)
 		vmux->pads[i].flags = (i < num_pads - 1) ? MEDIA_PAD_FL_SINK
 							 : MEDIA_PAD_FL_SOURCE;
-		vmux->format_mbus[i] = video_mux_format_mbus_default;
-	}
 
 	vmux->subdev.entity.function = MEDIA_ENT_F_VID_MUX;
 	ret = media_entity_pads_init(&vmux->subdev.entity, num_pads,
@@ -482,12 +445,18 @@ static int video_mux_probe(struct platform_device *pdev)
 
 	vmux->subdev.entity.ops = &video_mux_ops;
 
+	ret = v4l2_subdev_init_finalize(&vmux->subdev);
+	if (ret < 0)
+		goto err_entity_cleanup;
+
 	ret = video_mux_async_register(vmux, num_pads - 1);
 	if (ret)
-		goto err_entity_cleanup;
+		goto err_subdev_cleanup;
 
 	return 0;
 
+err_subdev_cleanup:
+	v4l2_subdev_cleanup(&vmux->subdev);
 err_entity_cleanup:
 	media_entity_cleanup(&vmux->subdev.entity);
 	return ret;
@@ -501,6 +470,7 @@ static void video_mux_remove(struct platform_device *pdev)
 	v4l2_async_nf_unregister(&vmux->notifier);
 	v4l2_async_nf_cleanup(&vmux->notifier);
 	v4l2_async_unregister_subdev(sd);
+	v4l2_subdev_cleanup(sd);
 	media_entity_cleanup(&sd->entity);
 }
 

-- 
2.39.2
