Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF4766B106
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjAOMkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjAOMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:40:50 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A6EC57;
        Sun, 15 Jan 2023 04:40:49 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D717B308;
        Sun, 15 Jan 2023 13:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673786446;
        bh=Gk1qa6CCnI/c7OGD8JV4Gc+RUJW+6//3P/tTEV+Yl9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdTeF4BNzA50MWulZA8sEZCN9t5mKuXIK14ItS3+yfFYymWCgLAchWjF/WkhsolXi
         pzwQifnHSHzng3GRHUWlAKvULcCaW/yD6/pKpWTxG5A55DGm0wyEJ5dVboOMQBPc04
         ajPBWLGSOt0MFemHlZlUun3RlVsKRIVOfaJvBQSg=
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
Subject: [PATCH v16.1] media: subdev: Require code change to enable [GS]_ROUTING
Date:   Sun, 15 Jan 2023 14:40:08 +0200
Message-Id: <20230115124008.293634-1-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215121634.287100-7-tomi.valkeinen@ideasonboard.com>
References: <20221215121634.287100-7-tomi.valkeinen@ideasonboard.com>
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

Streams API is an experimental feature. To use Streams API, the user
needs to change a variable in v4l2-subdev.c and recompile the kernel.

This commit should be reverted when the Streams API is deemed ready for
production use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---

Here's a minor update to the patch:
- Fix unused var warning
- Don't initialize the static var to 0

 drivers/media/v4l2-core/v4l2-subdev.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 61b429016a2f..a576b22164b0 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -23,6 +23,15 @@
 #include <media/v4l2-fh.h>
 #include <media/v4l2-ioctl.h>
 
+#if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
+/*
+ * Streams API is an experimental feature. To use Streams API, set
+ * 'v4l2_subdev_enable_streams_api' to 1 below.
+ */
+
+static bool v4l2_subdev_enable_streams_api;
+#endif
+
 /*
  * Maximum stream ID is 63 for now, as we use u64 bitmask to represent a set
  * of streams.
@@ -751,6 +760,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		struct v4l2_subdev_routing *routing = arg;
 		struct v4l2_subdev_krouting *krouting;
 
+		if (!v4l2_subdev_enable_streams_api)
+			return -ENOIOCTLCMD;
+
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
@@ -778,6 +790,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		struct v4l2_subdev_krouting krouting = {};
 		unsigned int i;
 
+		if (!v4l2_subdev_enable_streams_api)
+			return -ENOIOCTLCMD;
+
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
-- 
2.34.1

