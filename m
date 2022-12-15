Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28864DB16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLOMRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiLOMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:22 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17E2ED44;
        Thu, 15 Dec 2022 04:17:21 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 09B3F327;
        Thu, 15 Dec 2022 13:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106634;
        bh=LPSGajGYn9e+8tithrFLE5dadW0PKkSnyNXoWijjQTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGZPD16cK0pb/gE+TsNhTEy0tHNaZMReWkzAXKxIUoe/6N1Al52bkhvVb+N1cW6vq
         8TVeZaS4tS9Pvw1qlmSVxvqXdi/JqmlkeSJpVVcAtH2Ve+r3Y/rQuL3tjhHDfZzmTo
         CK1001JgCGOwDCPnCV5PGNVnnFETKykcVH8/qdM0=
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
Subject: [PATCH v16 10/20] media: Documentation: add multiplexed streams documentation
Date:   Thu, 15 Dec 2022 14:16:24 +0200
Message-Id: <20221215121634.287100-11-tomi.valkeinen@ideasonboard.com>
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

Add documentation related to multiplexed streams.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../driver-api/media/v4l2-subdev.rst          |   8 +
 .../userspace-api/media/v4l/dev-subdev.rst    | 138 ++++++++++++++++++
 2 files changed, 146 insertions(+)

diff --git a/Documentation/driver-api/media/v4l2-subdev.rst b/Documentation/driver-api/media/v4l2-subdev.rst
index 6f8d79926aa5..260cfa8c3f3d 100644
--- a/Documentation/driver-api/media/v4l2-subdev.rst
+++ b/Documentation/driver-api/media/v4l2-subdev.rst
@@ -593,6 +593,14 @@ before calling v4l2_subdev_init_finalize():
 
 This shares the driver's private mutex between the controls and the states.
 
+Streams, multiplexed media pads and internal routing
+----------------------------------------------------
+
+A subdevice driver can implement support for multiplexed streams by setting
+the V4L2_SUBDEV_FL_STREAMS subdev flag and implementing support for
+centrally managed subdev active state, routing and stream based
+configuration.
+
 V4L2 sub-device functions and data structures
 ---------------------------------------------
 
diff --git a/Documentation/userspace-api/media/v4l/dev-subdev.rst b/Documentation/userspace-api/media/v4l/dev-subdev.rst
index a67c2749089a..7d1b8ebd4e17 100644
--- a/Documentation/userspace-api/media/v4l/dev-subdev.rst
+++ b/Documentation/userspace-api/media/v4l/dev-subdev.rst
@@ -503,3 +503,141 @@ source pads.
     :maxdepth: 1
 
     subdev-formats
+
+Streams, multiplexed media pads and internal routing
+----------------------------------------------------
+
+Commonly V4L2 subdevices support only separate video streams, that is, only a
+single stream can pass through a media link and a media pad. Thus each pad
+contains a format configuration for that single stream. In some cases a subdev
+can do stream processing and split a stream into two or compose two streams
+into one, but the inputs and outputs for the subdev are still a single stream
+per pad.
+
+Some hardware, e.g. MIPI CSI-2, support multiplexed streams, that is, multiple
+data streams are transmitted on the same bus, which is represented by a media
+link connecting a transmitter source pad with a sink pad on the receiver. For
+example, a camera sensor can produce two distinct streams, a pixel stream and a
+metadata stream, which are transmitted on the multiplexed data bus, represented
+by a media link which connects the single sensor's source pad with the receiver
+sink pad. The stream-aware receiver will de-multiplex the streams received on
+the its sink pad and allows to route them individually to one of its source
+pads.
+
+Subdevice drivers that support multiplexed streams are compatible with
+non-multiplexed subdev drivers, but, of course, require a routing configuration
+where the link between those two types of drivers contains only a single
+stream.
+
+Understanding streams
+^^^^^^^^^^^^^^^^^^^^^
+
+A stream is a stream of content (e.g. pixel data or metadata) flowing through
+the media pipeline from a source (e.g. a sensor) towards the final sink (e.g. a
+receiver and demultiplexer in a SoC). Each media link carries all the enabled
+streams from one end of the link to the other, and subdevices have routing
+tables which describe how the incoming streams from sink pads are routed to the
+source pads.
+
+A stream ID (often just "stream") is a media link-local identifier for a stream.
+In other words, a particular stream ID must exist on both sides of a media
+link, but another stream ID can be used for the same stream at the other side
+of the subdevice.
+
+A stream at a specific point in the media pipeline is identified with the
+subdev and a (pad, stream) pair. For subdevices that do not support
+multiplexed streams the 'stream' is always 0.
+
+Configuring streams
+^^^^^^^^^^^^^^^^^^^
+
+The configuration of the streams is done individually for each subdevice and
+the validity of the streams between subdevices is validated when the pipeline
+is started.
+
+There are three steps in configuring the streams:
+
+1) Set up links. Connect the pads between subdevices using the :ref:`Media
+Controller API <media_controller>`
+
+2) Routing. The routing table for the subdevice must be set with
+:ref:`VIDIOC_SUBDEV_S_ROUTING <VIDIOC_SUBDEV_G_ROUTING>` ioctl. Note that
+setting the routing table will reset all the stream configurations in a media
+entity.
+
+3) Configure streams. Each route endpoint must be configured
+with :ref:`VIDIOC_SUBDEV_S_FMT <VIDIOC_SUBDEV_G_FMT>`.
+
+Multiplexed streams setup example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A simple example of a multiplexed stream setup might be as follows:
+
+- Two identical sensors (Sensor A and Sensor B). Each sensor has a single source
+  pad (pad 0) which carries a pixel data stream.
+
+- Multiplexer bridge (Bridge). The bridge has two sink pads, connected to the
+  sensors (pads 0, 1), and one source pad (pad 2), which outputs two streams.
+
+- Receiver in the SoC (Receiver). The receiver has a single sink pad (pad 0),
+  connected to the bridge, and two source pads (pads 1-2), going to the DMA
+  engine. The receiver demultiplexes the incoming streams to the source pads.
+
+- DMA Engines in the SoC (DMA Engine), one for each stream. Each DMA engine is
+  connected to a single source pad in the receiver.
+
+The sensors, the bridge and the receiver are modeled as V4L2 subdevices,
+exposed to userspace via /dev/v4l-subdevX device nodes. The DMA engines are
+modeled as V4L2 devices, exposed to userspace via /dev/videoX nodes.
+
+To configure this pipeline, the userspace must take the following steps:
+
+1) Set up media links between entities: connect the sensors to the bridge,
+bridge to the receiver, and the receiver to the DMA engines. This step does
+not differ from normal non-multiplexed media controller setup.
+
+2) Configure routing.
+
+.. flat-table:: Bridge routing table
+    :header-rows:  1
+
+    * - Sink Pad/Stream
+      - Source Pad/Stream
+      - Routing Flags
+      - Comments
+    * - 0/0
+      - 2/0
+      - V4L2_SUBDEV_ROUTE_FL_ACTIVE
+      - Pixel data stream from Sensor A
+    * - 1/0
+      - 2/1
+      - V4L2_SUBDEV_ROUTE_FL_ACTIVE
+      - Pixel data stream from Sensor B
+
+.. flat-table:: Receiver routing table
+    :header-rows:  1
+
+    * - Sink Pad/Stream
+      - Source Pad/Stream
+      - Routing Flags
+      - Comments
+    * - 0/0
+      - 1/0
+      - V4L2_SUBDEV_ROUTE_FL_ACTIVE
+      - Pixel data stream from Sensor A
+    * - 0/1
+      - 2/0
+      - V4L2_SUBDEV_ROUTE_FL_ACTIVE
+      - Pixel data stream from Sensor B
+
+3) Configure streams
+
+After configuring the routing table, the next step is configuring the streams.
+This step is similar to configuring the pads in a non-multiplexed streams
+setup, with the difference that we need to configure each (pad, stream) pair
+(i.e. route endpoint) instead of just a pad.
+
+A common way to accomplish this is to start from the sensors and propagate the
+configurations along the stream towards the receiver,
+using :ref:`VIDIOC_SUBDEV_S_FMT <VIDIOC_SUBDEV_G_FMT>` ioctls to configure each
+stream endpoint in each subdev.
-- 
2.34.1

