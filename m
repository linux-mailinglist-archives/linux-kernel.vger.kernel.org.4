Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3264DB1E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiLOMTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLOMRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C02EF39;
        Thu, 15 Dec 2022 04:17:32 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C8A872129;
        Thu, 15 Dec 2022 13:17:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106641;
        bh=OzX7bydzR0INetwvgf+/wcv83lJ/SqcSqwoQK0Tmo7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hg33MtuZYAptOwqpFhC6clnAKA+qaacwx4bsb26MVeC2wt5ba8oqikCHy7FA2kpg6
         OKx9virKoJtHyV8IwkPpRUd3d9uf1Epcdbi7pppyYHQ2FAj4jeMCKjqFCGcNDO6+8g
         GqqqGlS3JfwOMG48mZ8HjjIJiqYd75D5yaz96nBU=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: [PATCH v16 18/20] media: v4l2-subdev: Add subdev .(enable|disable)_streams() operations
Date:   Thu, 15 Dec 2022 14:16:32 +0200
Message-Id: <20221215121634.287100-19-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
References: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add two new subdev pad operations, .enable_streams() and
.disable_streams(), to allow control of individual streams per pad. This
is a superset of what the video .s_stream() operation implements.

To help with handling of backward compatibility, add two wrapper
functions around those operations, and require their usage in drivers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 224 ++++++++++++++++++++++++++
 include/media/v4l2-subdev.h           |  85 ++++++++++
 2 files changed, 309 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index d9ece0fd1b75..9c5e1ac65f4f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1726,6 +1726,230 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
 
+static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
+					       u64 streams_mask)
+{
+	struct device *dev = sd->entity.graph_obj.mdev->dev;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * The subdev doesn't implement pad-based stream enable, fall back
+	 * on the .s_stream() operation. This can only be done for subdevs that
+	 * have a single source pad, as sd->enabled_streams is global to the
+	 * subdev.
+	 */
+	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < sd->entity.num_pads; ++i) {
+		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
+			return -EOPNOTSUPP;
+	}
+
+	if (sd->enabled_streams & streams_mask) {
+		dev_dbg(dev, "set of streams %#llx already enabled on %s:%u\n",
+			streams_mask, sd->entity.name, pad);
+		return -EALREADY;
+	}
+
+	/* Start streaming when the first streams are enabled. */
+	if (!sd->enabled_streams) {
+		ret = v4l2_subdev_call(sd, video, s_stream, 1);
+		if (ret)
+			return ret;
+	}
+
+	sd->enabled_streams |= streams_mask;
+
+	return 0;
+}
+
+int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
+			       u64 streams_mask)
+{
+	struct device *dev = sd->entity.graph_obj.mdev->dev;
+	struct v4l2_subdev_state *state;
+	u64 found_streams = 0;
+	unsigned int i;
+	int ret;
+
+	/* A few basic sanity checks first. */
+	if (pad >= sd->entity.num_pads)
+		return -EINVAL;
+
+	if (!streams_mask)
+		return 0;
+
+	/* Fallback on .s_stream() if .enable_streams() isn't available. */
+	if (!sd->ops->pad || !sd->ops->pad->enable_streams)
+		return v4l2_subdev_enable_streams_fallback(sd, pad,
+							   streams_mask);
+
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+
+	/*
+	 * Verify that the requested streams exist and that they are not
+	 * already enabled.
+	 */
+	for (i = 0; i < state->stream_configs.num_configs; ++i) {
+		struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+			continue;
+
+		found_streams |= BIT_ULL(cfg->stream);
+
+		if (cfg->enabled) {
+			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
+				cfg->stream, sd->entity.name, pad);
+			ret = -EALREADY;
+			goto done;
+		}
+	}
+
+	if (found_streams != streams_mask) {
+		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
+			streams_mask & ~found_streams, sd->entity.name, pad);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* Call the .enable_streams() operation. */
+	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
+			       streams_mask);
+	if (ret)
+		goto done;
+
+	/* Mark the streams as enabled. */
+	for (i = 0; i < state->stream_configs.num_configs; ++i) {
+		struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+			cfg->enabled = true;
+	}
+
+done:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
+
+static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
+						u64 streams_mask)
+{
+	struct device *dev = sd->entity.graph_obj.mdev->dev;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * If the subdev doesn't implement pad-based stream enable, fall  back
+	 * on the .s_stream() operation. This can only be done for subdevs that
+	 * have a single source pad, as sd->enabled_streams is global to the
+	 * subdev.
+	 */
+	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < sd->entity.num_pads; ++i) {
+		if (i != pad && sd->entity.pads[i].flags & MEDIA_PAD_FL_SOURCE)
+			return -EOPNOTSUPP;
+	}
+
+	if ((sd->enabled_streams & streams_mask) != streams_mask) {
+		dev_dbg(dev, "set of streams %#llx already disabled on %s:%u\n",
+			streams_mask, sd->entity.name, pad);
+		return -EALREADY;
+	}
+
+	/* Stop streaming when the last streams are disabled. */
+	if (!(sd->enabled_streams & ~streams_mask)) {
+		ret = v4l2_subdev_call(sd, video, s_stream, 0);
+		if (ret)
+			return ret;
+	}
+
+	sd->enabled_streams &= ~streams_mask;
+
+	return 0;
+}
+
+int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
+				u64 streams_mask)
+{
+	struct device *dev = sd->entity.graph_obj.mdev->dev;
+	struct v4l2_subdev_state *state;
+	u64 found_streams = 0;
+	unsigned int i;
+	int ret;
+
+	/* A few basic sanity checks first. */
+	if (pad >= sd->entity.num_pads)
+		return -EINVAL;
+
+	if (!streams_mask)
+		return 0;
+
+	/* Fallback on .s_stream() if .disable_streams() isn't available. */
+	if (!sd->ops->pad || !sd->ops->pad->disable_streams)
+		return v4l2_subdev_disable_streams_fallback(sd, pad,
+							    streams_mask);
+
+	state = v4l2_subdev_lock_and_get_active_state(sd);
+
+	/*
+	 * Verify that the requested streams exist and that they are not
+	 * already disabled.
+	 */
+	for (i = 0; i < state->stream_configs.num_configs; ++i) {
+		struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
+			continue;
+
+		found_streams |= BIT_ULL(cfg->stream);
+
+		if (!cfg->enabled) {
+			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
+				cfg->stream, sd->entity.name, pad);
+			ret = -EALREADY;
+			goto done;
+		}
+	}
+
+	if (found_streams != streams_mask) {
+		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
+			streams_mask & ~found_streams, sd->entity.name, pad);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* Call the .disable_streams() operation. */
+	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
+			       streams_mask);
+	if (ret)
+		goto done;
+
+	/* Mark the streams as disabled. */
+	for (i = 0; i < state->stream_configs.num_configs; ++i) {
+		struct v4l2_subdev_stream_config *cfg =
+			&state->stream_configs.configs[i];
+
+		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
+			cfg->enabled = false;
+	}
+
+done:
+	v4l2_subdev_unlock_state(state);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_disable_streams);
+
 #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
 
 #endif /* CONFIG_MEDIA_CONTROLLER */
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 8c002d65e08e..bff824367e0b 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -700,6 +700,7 @@ struct v4l2_subdev_pad_config {
  *
  * @pad: pad number
  * @stream: stream number
+ * @enabled: has the stream been enabled with v4l2_subdev_enable_stream()
  * @fmt: &struct v4l2_mbus_framefmt
  * @crop: &struct v4l2_rect to be used for crop
  * @compose: &struct v4l2_rect to be used for compose
@@ -709,6 +710,7 @@ struct v4l2_subdev_pad_config {
 struct v4l2_subdev_stream_config {
 	u32 pad;
 	u32 stream;
+	bool enabled;
 
 	struct v4l2_mbus_framefmt fmt;
 	struct v4l2_rect crop;
@@ -814,6 +816,18 @@ struct v4l2_subdev_state {
  *
  * @set_routing: enable or disable data connection routes described in the
  *		 subdevice routing table.
+ *
+ * @enable_streams: Enable the streams defined in streams_mask on the given
+ *	source pad. Subdevs that implement this operation must use the active
+ *	state management provided by the subdev core (enabled through a call to
+ *	v4l2_subdev_init_finalize() at initialization time). Do not call
+ *	directly, use v4l2_subdev_enable_streams() instead.
+ *
+ * @disable_streams: Disable the streams defined in streams_mask on the given
+ *	source pad. Subdevs that implement this operation must use the active
+ *	state management provided by the subdev core (enabled through a call to
+ *	v4l2_subdev_init_finalize() at initialization time). Do not call
+ *	directly, use v4l2_subdev_disable_streams() instead.
  */
 struct v4l2_subdev_pad_ops {
 	int (*init_cfg)(struct v4l2_subdev *sd,
@@ -860,6 +874,12 @@ struct v4l2_subdev_pad_ops {
 			   struct v4l2_subdev_state *state,
 			   enum v4l2_subdev_format_whence which,
 			   struct v4l2_subdev_krouting *route);
+	int (*enable_streams)(struct v4l2_subdev *sd,
+			      struct v4l2_subdev_state *state, u32 pad,
+			      u64 streams_mask);
+	int (*disable_streams)(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state, u32 pad,
+			       u64 streams_mask);
 };
 
 /**
@@ -1005,6 +1025,10 @@ struct v4l2_subdev_platform_data {
  * @active_state: Active state for the subdev (NULL for subdevs tracking the
  *		  state internally). Initialized by calling
  *		  v4l2_subdev_init_finalize().
+ * @enabled_streams: Bitmask of enabled streams used by
+ *		     v4l2_subdev_enable_streams() and
+ *		     v4l2_subdev_disable_streams() helper functions for fallback
+ *		     cases.
  *
  * Each instance of a subdev driver should create this struct, either
  * stand-alone or embedded in a larger struct.
@@ -1050,6 +1074,7 @@ struct v4l2_subdev {
 	 * doesn't support it.
 	 */
 	struct v4l2_subdev_state *active_state;
+	u64 enabled_streams;
 };
 
 
@@ -1641,6 +1666,66 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
 				 const struct v4l2_subdev_krouting *routing,
 				 enum v4l2_subdev_routing_restriction disallow);
 
+/**
+ * v4l2_subdev_enable_streams() - Enable streams on a pad
+ * @sd: The subdevice
+ * @pad: The pad
+ * @streams_mask: Bitmask of streams to enable
+ *
+ * This function enables streams on a source @pad of a subdevice. The pad is
+ * identified by its index, while the streams are identified by the
+ * @streams_mask bitmask. This allows enabling multiple streams on a pad at
+ * once.
+ *
+ * Enabling a stream that is already enabled isn't allowed. If @streams_mask
+ * contains an already enabled stream, this function returns -EALREADY without
+ * performing any operation.
+ *
+ * Per-stream enable is only available for subdevs that implement the
+ * .enable_streams() and .disable_streams() operations. For other subdevs, this
+ * function implements a best-effort compatibility by calling the .s_stream()
+ * operation, limited to subdevs that have a single source pad.
+ *
+ * Return:
+ * * 0: Success
+ * * -EALREADY: One of the streams in streams_mask is already enabled
+ * * -EINVAL: The pad index is invalid, or doesn't correspond to a source pad
+ * * -EOPNOTSUPP: Falling back to the legacy .s_stream() operation is
+ *   impossible because the subdev has multiple source pads
+ */
+int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
+			       u64 streams_mask);
+
+/**
+ * v4l2_subdev_disable_streams() - Disable streams on a pad
+ * @sd: The subdevice
+ * @pad: The pad
+ * @streams_mask: Bitmask of streams to disable
+ *
+ * This function disables streams on a source @pad of a subdevice. The pad is
+ * identified by its index, while the streams are identified by the
+ * @streams_mask bitmask. This allows disabling multiple streams on a pad at
+ * once.
+ *
+ * Disabling a streams that is not enabled isn't allowed. If @streams_mask
+ * contains a disabled stream, this function returns -EALREADY without
+ * performing any operation.
+ *
+ * Per-stream disable is only available for subdevs that implement the
+ * .enable_streams() and .disable_streams() operations. For other subdevs, this
+ * function implements a best-effort compatibility by calling the .s_stream()
+ * operation, limited to subdevs that have a single source pad.
+ *
+ * Return:
+ * * 0: Success
+ * * -EALREADY: One of the streams in streams_mask is not enabled
+ * * -EINVAL: The pad index is invalid, or doesn't correspond to a source pad
+ * * -EOPNOTSUPP: Falling back to the legacy .s_stream() operation is
+ *   impossible because the subdev has multiple source pads
+ */
+int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
+				u64 streams_mask);
+
 #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
 
 #endif /* CONFIG_MEDIA_CONTROLLER */
-- 
2.34.1

