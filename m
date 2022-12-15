Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7414B64DB17
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLOMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLOMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEBB2EF35;
        Thu, 15 Dec 2022 04:17:29 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F4B7211D;
        Thu, 15 Dec 2022 13:17:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106638;
        bh=DyXV7qGSaobPbyvyLrqyLGXFh+Ld4BfW7tqXJBD6c5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lVI1YP8yiqsQxvJD0RQ0GWHhxYSrjj7Qt7mk1qQ4nKst4MRGpoVgNCLncR1AYpSVZ
         eJQfheERStDPRplSykP8LXROtv416Z01CpP3MTbJ/9f/rvAhSRD3deElb07UvTFgjf
         zTV4kntc6alNxqp4d6WIHkkSuZhaXW7HlHhsxS3w=
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
Subject: [PATCH v16 15/20] media: subdev: add v4l2_subdev_set_routing_with_fmt() helper
Date:   Thu, 15 Dec 2022 14:16:29 +0200
Message-Id: <20221215121634.287100-16-tomi.valkeinen@ideasonboard.com>
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

v4l2_subdev_set_routing_with_fmt() is the same as
v4l2_subdev_set_routing(), but additionally initializes all the streams
with the given format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 22 ++++++++++++++++++++++
 include/media/v4l2-subdev.h           | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index c02048e388d1..9e154f419df8 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1464,6 +1464,28 @@ __v4l2_subdev_next_active_route(const struct v4l2_subdev_krouting *routing,
 }
 EXPORT_SYMBOL_GPL(__v4l2_subdev_next_active_route);
 
+int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     struct v4l2_subdev_krouting *routing,
+				     const struct v4l2_mbus_framefmt *fmt)
+{
+	struct v4l2_subdev_stream_configs *stream_configs;
+	unsigned int i;
+	int ret;
+
+	ret = v4l2_subdev_set_routing(sd, state, routing);
+	if (ret)
+		return ret;
+
+	stream_configs = &state->stream_configs;
+
+	for (i = 0; i < stream_configs->num_configs; ++i)
+		stream_configs->configs[i].fmt = *fmt;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_subdev_set_routing_with_fmt);
+
 struct v4l2_mbus_framefmt *
 v4l2_subdev_state_get_stream_format(struct v4l2_subdev_state *state,
 				    unsigned int pad, u32 stream)
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 6f4719e28ad1..020ad79182cc 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1481,6 +1481,22 @@ __v4l2_subdev_next_active_route(const struct v4l2_subdev_krouting *routing,
 	for ((route) = NULL;                  \
 	     ((route) = __v4l2_subdev_next_active_route((routing), (route)));)
 
+/**
+ * v4l2_subdev_set_routing_with_fmt() - Set given routing and format to subdev
+ *					state
+ * @sd: The subdevice
+ * @state: The subdevice state
+ * @routing: Routing that will be copied to subdev state
+ * @fmt: Format used to initialize all the streams
+ *
+ * This is the same as v4l2_subdev_set_routing, but additionally initializes
+ * all the streams using the given format.
+ */
+int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
+				     struct v4l2_subdev_state *state,
+				     struct v4l2_subdev_krouting *routing,
+				     const struct v4l2_mbus_framefmt *fmt);
+
 /**
  * v4l2_subdev_state_get_stream_format() - Get pointer to a stream format
  * @state: subdevice state
-- 
2.34.1

