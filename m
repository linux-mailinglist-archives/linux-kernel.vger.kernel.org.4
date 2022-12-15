Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD9464DB07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLOMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiLOMRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:14 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40AF2E9E3;
        Thu, 15 Dec 2022 04:17:12 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BAEF418A2;
        Thu, 15 Dec 2022 13:17:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106630;
        bh=jSfkOsm33uhIdEa+Y77ZV0TqonAbVdbrfD9b+M66coA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ir0XYVeV4Nf++cNj1HH9Tl/z5Nb/KeUCSJBg9YDqE5uPWQlujnvgclhoopsP8o+2U
         StHsbtP9WrQD+LKb77bxFJBwEvS6zNWrmEMA4E4GfaelJ0mv75bwVFIzhjPi24wD2Y
         fbosNclvuAgSMyFsF+6DiI6hLdW2l1R5F/l0n3Zs=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v16 05/20] media: subdev: Add [GS]_ROUTING subdev ioctls and operations
Date:   Thu, 15 Dec 2022 14:16:19 +0200
Message-Id: <20221215121634.287100-6-tomi.valkeinen@ideasonboard.com>
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

Add support for subdev internal routing. A route is defined as a single
stream from a sink pad to a source pad.

The userspace can configure the routing via two new ioctls,
VIDIOC_SUBDEV_G_ROUTING and VIDIOC_SUBDEV_S_ROUTING, and subdevs can
implement the functionality with v4l2_subdev_pad_ops.set_routing().

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>

- Add sink and source streams for multiplexed links
- Copy the argument back in case of an error. This is needed to let the
  caller know the number of routes.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

- Expand and refine documentation.
- Make the 'routes' pointer a __u64 __user pointer so that a compat32
  version of the ioctl is not required.
- Add struct v4l2_subdev_krouting to be used for subdevice operations.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

- Fix typecasing warnings
- Check sink & source pad types
- Add 'which' field
- Routing to subdev state
- Dropped get_routing subdev op

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c  | 25 +++++++-
 drivers/media/v4l2-core/v4l2-subdev.c | 84 +++++++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 22 +++++++
 include/uapi/linux/v4l2-subdev.h      | 43 ++++++++++++++
 4 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index fddba75d9074..26b9a9626c96 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/version.h>
 
+#include <linux/v4l2-subdev.h>
 #include <linux/videodev2.h>
 
 #include <media/media-device.h> /* for media_set_bus_info() */
@@ -3151,6 +3152,21 @@ static int check_array_args(unsigned int cmd, void *parg, size_t *array_size,
 		ret = 1;
 		break;
 	}
+
+	case VIDIOC_SUBDEV_G_ROUTING:
+	case VIDIOC_SUBDEV_S_ROUTING: {
+		struct v4l2_subdev_routing *routing = parg;
+
+		if (routing->num_routes > 256)
+			return -E2BIG;
+
+		*user_ptr = u64_to_user_ptr(routing->routes);
+		*kernel_ptr = (void **)&routing->routes;
+		*array_size = sizeof(struct v4l2_subdev_route)
+			    * routing->num_routes;
+		ret = 1;
+		break;
+	}
 	}
 
 	return ret;
@@ -3397,8 +3413,15 @@ video_usercopy(struct file *file, unsigned int orig_cmd, unsigned long arg,
 	/*
 	 * Some ioctls can return an error, but still have valid
 	 * results that must be returned.
+	 *
+	 * FIXME: subdev IOCTLS are partially handled here and partially in
+	 * v4l2-subdev.c and the 'always_copy' flag can only be set for IOCTLS
+	 * defined here as part of the 'v4l2_ioctls' array. As
+	 * VIDIOC_SUBDEV_G_ROUTING needs to return results to applications even
+	 * in case of failure, but it is not defined here as part of the
+	 * 'v4l2_ioctls' array, insert an ad-hoc check to address that.
 	 */
-	if (err < 0 && !always_copy)
+	if (err < 0 && !always_copy && cmd != VIDIOC_SUBDEV_G_ROUTING)
 		goto out;
 
 	if (has_array_args) {
diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 8983d33fdb4b..61b429016a2f 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -23,6 +23,16 @@
 #include <media/v4l2-fh.h>
 #include <media/v4l2-ioctl.h>
 
+/*
+ * Maximum stream ID is 63 for now, as we use u64 bitmask to represent a set
+ * of streams.
+ *
+ * Note that V4L2_FRAME_DESC_ENTRY_MAX is related: V4L2_FRAME_DESC_ENTRY_MAX
+ * restricts the total number of streams in a pad, although the stream ID is
+ * not restricted.
+ */
+#define V4L2_SUBDEV_MAX_STREAM_ID 63
+
 #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
 static int subdev_fh_init(struct v4l2_subdev_fh *fh, struct v4l2_subdev *sd)
 {
@@ -417,6 +427,10 @@ subdev_ioctl_get_state(struct v4l2_subdev *sd, struct v4l2_subdev_fh *subdev_fh,
 	case VIDIOC_SUBDEV_S_SELECTION:
 		which = ((struct v4l2_subdev_selection *)arg)->which;
 		break;
+	case VIDIOC_SUBDEV_G_ROUTING:
+	case VIDIOC_SUBDEV_S_ROUTING:
+		which = ((struct v4l2_subdev_routing *)arg)->which;
+		break;
 	}
 
 	return which == V4L2_SUBDEV_FORMAT_TRY ?
@@ -733,6 +747,75 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 	case VIDIOC_SUBDEV_QUERYSTD:
 		return v4l2_subdev_call(sd, video, querystd, arg);
 
+	case VIDIOC_SUBDEV_G_ROUTING: {
+		struct v4l2_subdev_routing *routing = arg;
+		struct v4l2_subdev_krouting *krouting;
+
+		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+			return -ENOIOCTLCMD;
+
+		memset(routing->reserved, 0, sizeof(routing->reserved));
+
+		krouting = &state->routing;
+
+		if (routing->num_routes < krouting->num_routes) {
+			routing->num_routes = krouting->num_routes;
+			return -ENOSPC;
+		}
+
+		memcpy((struct v4l2_subdev_route *)(uintptr_t)routing->routes,
+		       krouting->routes,
+		       krouting->num_routes * sizeof(*krouting->routes));
+		routing->num_routes = krouting->num_routes;
+
+		return 0;
+	}
+
+	case VIDIOC_SUBDEV_S_ROUTING: {
+		struct v4l2_subdev_routing *routing = arg;
+		struct v4l2_subdev_route *routes =
+			(struct v4l2_subdev_route *)(uintptr_t)routing->routes;
+		struct v4l2_subdev_krouting krouting = {};
+		unsigned int i;
+
+		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
+			return -ENOIOCTLCMD;
+
+		if (routing->which != V4L2_SUBDEV_FORMAT_TRY && ro_subdev)
+			return -EPERM;
+
+		memset(routing->reserved, 0, sizeof(routing->reserved));
+
+		for (i = 0; i < routing->num_routes; ++i) {
+			const struct v4l2_subdev_route *route = &routes[i];
+			const struct media_pad *pads = sd->entity.pads;
+
+			if (route->sink_stream > V4L2_SUBDEV_MAX_STREAM_ID ||
+			    route->source_stream > V4L2_SUBDEV_MAX_STREAM_ID)
+				return -EINVAL;
+
+			if (route->sink_pad >= sd->entity.num_pads)
+				return -EINVAL;
+
+			if (!(pads[route->sink_pad].flags &
+			      MEDIA_PAD_FL_SINK))
+				return -EINVAL;
+
+			if (route->source_pad >= sd->entity.num_pads)
+				return -EINVAL;
+
+			if (!(pads[route->source_pad].flags &
+			      MEDIA_PAD_FL_SOURCE))
+				return -EINVAL;
+		}
+
+		krouting.num_routes = routing->num_routes;
+		krouting.routes = routes;
+
+		return v4l2_subdev_call(sd, pad, set_routing, state,
+					routing->which, &krouting);
+	}
+
 	default:
 		return v4l2_subdev_call(sd, core, ioctl, cmd, arg);
 	}
@@ -1016,6 +1099,7 @@ void __v4l2_subdev_state_free(struct v4l2_subdev_state *state)
 
 	mutex_destroy(&state->_lock);
 
+	kfree(state->routing.routes);
 	kvfree(state->pads);
 	kfree(state);
 }
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 4be0a590c7c7..4934dc9468a8 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -695,12 +695,26 @@ struct v4l2_subdev_pad_config {
 	struct v4l2_rect try_compose;
 };
 
+/**
+ * struct v4l2_subdev_krouting - subdev routing table
+ *
+ * @num_routes: number of routes
+ * @routes: &struct v4l2_subdev_route
+ *
+ * This structure contains the routing table for a subdev.
+ */
+struct v4l2_subdev_krouting {
+	unsigned int num_routes;
+	struct v4l2_subdev_route *routes;
+};
+
 /**
  * struct v4l2_subdev_state - Used for storing subdev state information.
  *
  * @_lock: default for 'lock'
  * @lock: mutex for the state. May be replaced by the user.
  * @pads: &struct v4l2_subdev_pad_config array
+ * @routing: routing table for the subdev
  *
  * This structure only needs to be passed to the pad op if the 'which' field
  * of the main argument is set to %V4L2_SUBDEV_FORMAT_TRY. For
@@ -711,6 +725,7 @@ struct v4l2_subdev_state {
 	struct mutex _lock;
 	struct mutex *lock;
 	struct v4l2_subdev_pad_config *pads;
+	struct v4l2_subdev_krouting routing;
 };
 
 /**
@@ -763,6 +778,9 @@ struct v4l2_subdev_state {
  *		     this operation as close as possible to stream on time. The
  *		     operation shall fail if the pad index it has been called on
  *		     is not valid or in case of unrecoverable failures.
+ *
+ * @set_routing: enable or disable data connection routes described in the
+ *		 subdevice routing table.
  */
 struct v4l2_subdev_pad_ops {
 	int (*init_cfg)(struct v4l2_subdev *sd,
@@ -805,6 +823,10 @@ struct v4l2_subdev_pad_ops {
 			      struct v4l2_mbus_frame_desc *fd);
 	int (*get_mbus_config)(struct v4l2_subdev *sd, unsigned int pad,
 			       struct v4l2_mbus_config *config);
+	int (*set_routing)(struct v4l2_subdev *sd,
+			   struct v4l2_subdev_state *state,
+			   enum v4l2_subdev_format_whence which,
+			   struct v4l2_subdev_krouting *route);
 };
 
 /**
diff --git a/include/uapi/linux/v4l2-subdev.h b/include/uapi/linux/v4l2-subdev.h
index 89af27f50a41..61c338a7f0dd 100644
--- a/include/uapi/linux/v4l2-subdev.h
+++ b/include/uapi/linux/v4l2-subdev.h
@@ -24,6 +24,7 @@
 #ifndef __LINUX_V4L2_SUBDEV_H
 #define __LINUX_V4L2_SUBDEV_H
 
+#include <linux/const.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
 #include <linux/v4l2-common.h>
@@ -191,6 +192,46 @@ struct v4l2_subdev_capability {
 /* The v4l2 sub-device supports routing and multiplexed streams. */
 #define V4L2_SUBDEV_CAP_STREAMS			0x00000002
 
+/*
+ * Is the route active? An active route will start when streaming is enabled
+ * on a video node.
+ */
+#define V4L2_SUBDEV_ROUTE_FL_ACTIVE		(1U << 0)
+
+/**
+ * struct v4l2_subdev_route - A route inside a subdev
+ *
+ * @sink_pad: the sink pad index
+ * @sink_stream: the sink stream identifier
+ * @source_pad: the source pad index
+ * @source_stream: the source stream identifier
+ * @flags: route flags V4L2_SUBDEV_ROUTE_FL_*
+ * @reserved: drivers and applications must zero this array
+ */
+struct v4l2_subdev_route {
+	__u32 sink_pad;
+	__u32 sink_stream;
+	__u32 source_pad;
+	__u32 source_stream;
+	__u32 flags;
+	__u32 reserved[5];
+};
+
+/**
+ * struct v4l2_subdev_routing - Subdev routing information
+ *
+ * @which: configuration type (from enum v4l2_subdev_format_whence)
+ * @num_routes: the total number of routes in the routes array
+ * @routes: pointer to the routes array
+ * @reserved: drivers and applications must zero this array
+ */
+struct v4l2_subdev_routing {
+	__u32 which;
+	__u32 num_routes;
+	__u64 routes;
+	__u32 reserved[6];
+};
+
 /* Backwards compatibility define --- to be removed */
 #define v4l2_subdev_edid v4l2_edid
 
@@ -206,6 +247,8 @@ struct v4l2_subdev_capability {
 #define VIDIOC_SUBDEV_S_CROP			_IOWR('V', 60, struct v4l2_subdev_crop)
 #define VIDIOC_SUBDEV_G_SELECTION		_IOWR('V', 61, struct v4l2_subdev_selection)
 #define VIDIOC_SUBDEV_S_SELECTION		_IOWR('V', 62, struct v4l2_subdev_selection)
+#define VIDIOC_SUBDEV_G_ROUTING			_IOWR('V', 38, struct v4l2_subdev_routing)
+#define VIDIOC_SUBDEV_S_ROUTING			_IOWR('V', 39, struct v4l2_subdev_routing)
 /* The following ioctls are identical to the ioctls in videodev2.h */
 #define VIDIOC_SUBDEV_G_STD			_IOR('V', 23, v4l2_std_id)
 #define VIDIOC_SUBDEV_S_STD			_IOW('V', 24, v4l2_std_id)
-- 
2.34.1

