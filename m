Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685EB64DB1A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiLOMSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiLOMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA18A2EF3F;
        Thu, 15 Dec 2022 04:17:30 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2032A18A1;
        Thu, 15 Dec 2022 13:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106639;
        bh=j2qqZoCun1mFH77JCITu1bl3scrb+3uAwr9E2HTgCGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8mtHlkAVPWpfcw56z3aFk9FmvhTAVA3rYYeqRQnaf1Hmmr3CY5gvpbqqjSdLBm41
         SnxVpJeaj2nw3jZzxgJWG6MgXMN4QPLxhfE2R6ZncP9jgIDpOTP6pUdpeER06FZ/CT
         FQDR2pFX9x6JVxDQd0QEAGIhmJNaJ4lc7LMFwRSQ=
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
Subject: [PATCH v16 16/20] media: subdev: add v4l2_subdev_routing_validate() helper
Date:   Thu, 15 Dec 2022 14:16:30 +0200
Message-Id: <20221215121634.287100-17-tomi.valkeinen@ideasonboard.com>
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

Add a v4l2_subdev_routing_validate() helper for verifying routing for
common cases like only allowing non-overlapping 1-to-1 streams.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 102 ++++++++++++++++++++++++++
 include/media/v4l2-subdev.h           |  39 ++++++++++
 2 files changed, 141 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 9e154f419df8..f775b7980de1 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1598,6 +1598,108 @@ v4l2_subdev_state_get_opposite_stream_format(struct v4l2_subdev_state *state,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_state_get_opposite_stream_format);
 
+int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
+				 const struct v4l2_subdev_krouting *routing,
+				 enum v4l2_subdev_routing_restriction disallow)
+{
+	u32 *remote_pads = NULL;
+	unsigned int i, j;
+	int ret = -EINVAL;
+
+	if (disallow & V4L2_SUBDEV_ROUTING_NO_STREAM_MIX) {
+		remote_pads = kcalloc(sd->entity.num_pads, sizeof(*remote_pads),
+				      GFP_KERNEL);
+		if (!remote_pads)
+			return -ENOMEM;
+
+		for (i = 0; i < sd->entity.num_pads; ++i)
+			remote_pads[i] = U32_MAX;
+	}
+
+	for (i = 0; i < routing->num_routes; ++i) {
+		const struct v4l2_subdev_route *route = &routing->routes[i];
+
+		/* Validate the sink and source pad numbers. */
+		if (route->sink_pad >= sd->entity.num_pads ||
+		    !(sd->entity.pads[route->sink_pad].flags & MEDIA_PAD_FL_SINK)) {
+			dev_dbg(sd->dev, "route %u sink (%u) is not a sink pad\n",
+				i, route->sink_pad);
+			goto out;
+		}
+
+		if (route->source_pad >= sd->entity.num_pads ||
+		    !(sd->entity.pads[route->source_pad].flags & MEDIA_PAD_FL_SOURCE)) {
+			dev_dbg(sd->dev, "route %u source (%u) is not a source pad\n",
+				i, route->source_pad);
+			goto out;
+		}
+
+		/*
+		 * V4L2_SUBDEV_ROUTING_NO_STREAM_MIX: Streams on the same pad
+		 * may not be routed to streams on different pads.
+		 */
+		if (disallow & V4L2_SUBDEV_ROUTING_NO_STREAM_MIX) {
+			if (remote_pads[route->sink_pad] != U32_MAX &&
+			    remote_pads[route->sink_pad] != route->source_pad) {
+				dev_dbg(sd->dev,
+					"route %u attempts to mix %s streams\n",
+					i, "sink");
+				goto out;
+			}
+
+			if (remote_pads[route->source_pad] != U32_MAX &&
+			    remote_pads[route->source_pad] != route->sink_pad) {
+				dev_dbg(sd->dev,
+					"route %u attempts to mix %s streams\n",
+					i, "source");
+				goto out;
+			}
+
+			remote_pads[route->sink_pad] = route->source_pad;
+			remote_pads[route->source_pad] = route->sink_pad;
+		}
+
+		for (j = i + 1; j < routing->num_routes; ++j) {
+			const struct v4l2_subdev_route *r = &routing->routes[j];
+
+			/*
+			 * V4L2_SUBDEV_ROUTING_NO_1_TO_N: No two routes can
+			 * originate from the same (sink) stream.
+			 */
+			if ((disallow & V4L2_SUBDEV_ROUTING_NO_1_TO_N) &&
+			    route->sink_pad == r->sink_pad &&
+			    route->sink_stream == r->sink_stream) {
+				dev_dbg(sd->dev,
+					"routes %u and %u originate from same sink (%u/%u)\n",
+					i, j, route->sink_pad,
+					route->sink_stream);
+				goto out;
+			}
+
+			/*
+			 * V4L2_SUBDEV_ROUTING_NO_N_TO_1: No two routes can end
+			 * at the same (source) stream.
+			 */
+			if ((disallow & V4L2_SUBDEV_ROUTING_NO_N_TO_1) &&
+			    route->source_pad == r->source_pad &&
+			    route->source_stream == r->source_stream) {
+				dev_dbg(sd->dev,
+					"routes %u and %u end at same source (%u/%u)\n",
+					i, j, route->source_pad,
+					route->source_stream);
+				goto out;
+			}
+		}
+	}
+
+	ret = 0;
+
+out:
+	kfree(remote_pads);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
+
 #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
 
 #endif /* CONFIG_MEDIA_CONTROLLER */
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 020ad79182cc..6661887536bf 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1579,6 +1579,45 @@ struct v4l2_mbus_framefmt *
 v4l2_subdev_state_get_opposite_stream_format(struct v4l2_subdev_state *state,
 					     u32 pad, u32 stream);
 
+/**
+ * enum v4l2_subdev_routing_restriction - Subdevice internal routing restrictions
+ *
+ * @V4L2_SUBDEV_ROUTING_NO_1_TO_N:
+ *	an input stream may not be routed to multiple output streams (stream
+ *	duplication)
+ * @V4L2_SUBDEV_ROUTING_NO_N_TO_1:
+ *	multiple input streams may not be routed to the same output stream
+ *	(stream merging)
+ * @V4L2_SUBDEV_ROUTING_NO_STREAM_MIX:
+ *	streams on the same pad may not be routed to streams on different pads
+ * @V4L2_SUBDEV_ROUTING_ONLY_1_TO_1:
+ *	only non-overlapping 1-to-1 stream routing is allowed (a combination of
+ *	@V4L2_SUBDEV_ROUTING_NO_1_TO_N and @V4L2_SUBDEV_ROUTING_NO_N_TO_1)
+ */
+enum v4l2_subdev_routing_restriction {
+	V4L2_SUBDEV_ROUTING_NO_1_TO_N = BIT(0),
+	V4L2_SUBDEV_ROUTING_NO_N_TO_1 = BIT(1),
+	V4L2_SUBDEV_ROUTING_NO_STREAM_MIX = BIT(2),
+	V4L2_SUBDEV_ROUTING_ONLY_1_TO_1 =
+		V4L2_SUBDEV_ROUTING_NO_1_TO_N |
+		V4L2_SUBDEV_ROUTING_NO_N_TO_1,
+};
+
+/**
+ * v4l2_subdev_routing_validate() - Verify that routes comply with driver
+ *				    constraints
+ * @sd: The subdevice
+ * @routing: Routing to verify
+ * @disallow: Restrictions on routes
+ *
+ * This verifies that the given routing complies with the @disallow constraints.
+ *
+ * Returns 0 on success, error value otherwise.
+ */
+int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
+				 const struct v4l2_subdev_krouting *routing,
+				 enum v4l2_subdev_routing_restriction disallow);
+
 #endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
 
 #endif /* CONFIG_MEDIA_CONTROLLER */
-- 
2.34.1

