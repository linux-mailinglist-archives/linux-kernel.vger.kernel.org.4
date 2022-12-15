Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C839B64DB18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLOMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiLOMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F12ED6F;
        Thu, 15 Dec 2022 04:17:23 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B3BC7205E;
        Thu, 15 Dec 2022 13:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106636;
        bh=DZDTPqOA2t1f9tK2MvrjHS6xATqpBJeGkGIUeUXINl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLVvYqw0//50r6pnrZ44bllaFtV/1pxobyYNB+JkvDzZyLgLyRIQ+i8s6UYwhwDyD
         UaeEuEhyjz2vAGoxYMK69FSsODmwK9ZW/3yb/8ty0EJIL9KB9Q2DJZc1xg9ts9E7vO
         3TWwFqmCoUmip8MdrPv8ybiNrNJfkhABF9smPRzk=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v16 12/20] media: subdev: use streams in v4l2_subdev_link_validate()
Date:   Thu, 15 Dec 2022 14:16:26 +0200
Message-Id: <20221215121634.287100-13-tomi.valkeinen@ideasonboard.com>
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

Update v4l2_subdev_link_validate() to use routing and streams for
validation.

Instead of just looking at the format on the pad on both ends of the
link, the routing tables are used to collect all the streams going from
the source to the sink over the link, and the streams' formats on both
ends of the link are verified.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 185 +++++++++++++++++++++++---
 1 file changed, 165 insertions(+), 20 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 755152d64341..2a80ea49c814 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1024,7 +1024,7 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_default);
 
 static int
-v4l2_subdev_link_validate_get_format(struct media_pad *pad,
+v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
 				     struct v4l2_subdev_format *fmt)
 {
 	if (is_media_entity_v4l2_subdev(pad->entity)) {
@@ -1033,7 +1033,11 @@ v4l2_subdev_link_validate_get_format(struct media_pad *pad,
 
 		fmt->which = V4L2_SUBDEV_FORMAT_ACTIVE;
 		fmt->pad = pad->index;
-		return v4l2_subdev_call_state_active(sd, pad, get_fmt, fmt);
+		fmt->stream = stream;
+
+		return v4l2_subdev_call(sd, pad, get_fmt,
+					v4l2_subdev_get_locked_active_state(sd),
+					fmt);
 	}
 
 	WARN(pad->entity->function != MEDIA_ENT_F_IO_V4L,
@@ -1043,31 +1047,172 @@ v4l2_subdev_link_validate_get_format(struct media_pad *pad,
 	return -EINVAL;
 }
 
+#if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
+
+static void __v4l2_link_validate_get_streams(struct media_pad *pad,
+					     u64 *streams_mask)
+{
+	struct v4l2_subdev_route *route;
+	struct v4l2_subdev_state *state;
+	struct v4l2_subdev *subdev;
+
+	subdev = media_entity_to_v4l2_subdev(pad->entity);
+
+	*streams_mask = 0;
+
+	state = v4l2_subdev_get_locked_active_state(subdev);
+	if (WARN_ON(!state))
+		return;
+
+	for_each_active_route(&state->routing, route) {
+		u32 route_pad;
+		u32 route_stream;
+
+		if (pad->flags & MEDIA_PAD_FL_SOURCE) {
+			route_pad = route->source_pad;
+			route_stream = route->source_stream;
+		} else {
+			route_pad = route->sink_pad;
+			route_stream = route->sink_stream;
+		}
+
+		if (route_pad != pad->index)
+			continue;
+
+		*streams_mask |= BIT_ULL(route_stream);
+	}
+}
+
+#endif /* CONFIG_VIDEO_V4L2_SUBDEV_API */
+
+static void v4l2_link_validate_get_streams(struct media_pad *pad,
+					   u64 *streams_mask)
+{
+	struct v4l2_subdev *subdev = media_entity_to_v4l2_subdev(pad->entity);
+
+	if (!(subdev->flags & V4L2_SUBDEV_FL_STREAMS)) {
+		/* Non-streams subdevs have an implicit stream 0 */
+		*streams_mask = BIT_ULL(0);
+		return;
+	}
+
+#if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
+	__v4l2_link_validate_get_streams(pad, streams_mask);
+#else
+	/* This shouldn't happen */
+	*streams_mask = 0;
+#endif
+}
+
+static int v4l2_subdev_link_validate_locked(struct media_link *link)
+{
+	struct v4l2_subdev *sink_subdev =
+		media_entity_to_v4l2_subdev(link->sink->entity);
+	struct device *dev = sink_subdev->entity.graph_obj.mdev->dev;
+	u64 source_streams_mask;
+	u64 sink_streams_mask;
+	u64 dangling_sink_streams;
+	u32 stream;
+	int ret;
+
+	dev_dbg(dev, "validating link \"%s\":%u -> \"%s\":%u\n",
+		link->source->entity->name, link->source->index,
+		link->sink->entity->name, link->sink->index);
+
+	v4l2_link_validate_get_streams(link->source, &source_streams_mask);
+	v4l2_link_validate_get_streams(link->sink, &sink_streams_mask);
+
+	/*
+	 * It is ok to have more source streams than sink streams as extra
+	 * source streams can just be ignored by the receiver, but having extra
+	 * sink streams is an error as streams must have a source.
+	 */
+	dangling_sink_streams = (source_streams_mask ^ sink_streams_mask) &
+				sink_streams_mask;
+	if (dangling_sink_streams) {
+		dev_err(dev, "Dangling sink streams: mask %#llx\n",
+			dangling_sink_streams);
+		return -EINVAL;
+	}
+
+	/* Validate source and sink stream formats */
+
+	for (stream = 0; stream < sizeof(sink_streams_mask) * 8; ++stream) {
+		struct v4l2_subdev_format sink_fmt, source_fmt;
+
+		if (!(sink_streams_mask & BIT_ULL(stream)))
+			continue;
+
+		dev_dbg(dev, "validating stream \"%s\":%u:%u -> \"%s\":%u:%u\n",
+			link->source->entity->name, link->source->index, stream,
+			link->sink->entity->name, link->sink->index, stream);
+
+		ret = v4l2_subdev_link_validate_get_format(link->source, stream,
+							   &source_fmt);
+		if (ret < 0) {
+			dev_dbg(dev,
+				"Failed to get format for \"%s\":%u:%u (but that's ok)\n",
+				link->source->entity->name, link->source->index,
+				stream);
+			continue;
+		}
+
+		ret = v4l2_subdev_link_validate_get_format(link->sink, stream,
+							   &sink_fmt);
+		if (ret < 0) {
+			dev_dbg(dev,
+				"Failed to get format for \"%s\":%u:%u (but that's ok)\n",
+				link->sink->entity->name, link->sink->index,
+				stream);
+			continue;
+		}
+
+		/* TODO: add stream number to link_validate() */
+		ret = v4l2_subdev_call(sink_subdev, pad, link_validate, link,
+				       &source_fmt, &sink_fmt);
+		if (!ret)
+			continue;
+
+		if (ret != -ENOIOCTLCMD)
+			return ret;
+
+		ret = v4l2_subdev_link_validate_default(sink_subdev, link,
+							&source_fmt, &sink_fmt);
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int v4l2_subdev_link_validate(struct media_link *link)
 {
-	struct v4l2_subdev *sink;
-	struct v4l2_subdev_format sink_fmt, source_fmt;
-	int rval;
+	struct v4l2_subdev *source_sd, *sink_sd;
+	struct v4l2_subdev_state *source_state, *sink_state;
+	int ret;
 
-	rval = v4l2_subdev_link_validate_get_format(
-		link->source, &source_fmt);
-	if (rval < 0)
-		return 0;
+	sink_sd = media_entity_to_v4l2_subdev(link->sink->entity);
+	source_sd = media_entity_to_v4l2_subdev(link->source->entity);
 
-	rval = v4l2_subdev_link_validate_get_format(
-		link->sink, &sink_fmt);
-	if (rval < 0)
-		return 0;
+	sink_state = v4l2_subdev_get_unlocked_active_state(sink_sd);
+	source_state = v4l2_subdev_get_unlocked_active_state(source_sd);
 
-	sink = media_entity_to_v4l2_subdev(link->sink->entity);
+	if (sink_state)
+		v4l2_subdev_lock_state(sink_state);
 
-	rval = v4l2_subdev_call(sink, pad, link_validate, link,
-				&source_fmt, &sink_fmt);
-	if (rval != -ENOIOCTLCMD)
-		return rval;
+	if (source_state)
+		v4l2_subdev_lock_state(source_state);
 
-	return v4l2_subdev_link_validate_default(
-		sink, link, &source_fmt, &sink_fmt);
+	ret = v4l2_subdev_link_validate_locked(link);
+
+	if (sink_state)
+		v4l2_subdev_unlock_state(sink_state);
+
+	if (source_state)
+		v4l2_subdev_unlock_state(source_state);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate);
 
-- 
2.34.1

