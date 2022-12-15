Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB664DB03
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiLOMRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLOMRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE752E9EF;
        Thu, 15 Dec 2022 04:17:14 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9EAB118DE;
        Thu, 15 Dec 2022 13:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106631;
        bh=ymG6MvHj6boQZtL1hwOYJOSWgZFfnIzbVfrOp6foLTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEEBJekPcn80wGL5ub7Utbig9IRrAx8Y51HF0glm9tpfjoUUIrxULyJPFXHJFRxm3
         xShEykbpw6v1XJdBONlsjwXVGX46BEbZRDb/EZqpd92CAUwTodp3b3awv0knyDHPb2
         MuLf06AaSN/TExct9vxYMizB9jPaB1kXlXPdtBVw=
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
Subject: [PATCH v16 06/20] media: subdev: Require code change to enable [GS]_ROUTING
Date:   Thu, 15 Dec 2022 14:16:20 +0200
Message-Id: <20221215121634.287100-7-tomi.valkeinen@ideasonboard.com>
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

Streams API is an experimental feature. To use Streams API, the user
needs to change a variable in v4l2-subdev.c and recompile the kernel.

This commit should be reverted when the Streams API is deemed ready for
production use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 61b429016a2f..c31b44800e39 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -23,6 +23,13 @@
 #include <media/v4l2-fh.h>
 #include <media/v4l2-ioctl.h>
 
+/*
+ * Streams API is an experimental feature. To use Streams API, set
+ * 'v4l2_subdev_enable_streams_api' to 1 below.
+ */
+
+static bool v4l2_subdev_enable_streams_api = 0;
+
 /*
  * Maximum stream ID is 63 for now, as we use u64 bitmask to represent a set
  * of streams.
@@ -751,6 +758,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		struct v4l2_subdev_routing *routing = arg;
 		struct v4l2_subdev_krouting *krouting;
 
+		if (!v4l2_subdev_enable_streams_api)
+			return -ENOIOCTLCMD;
+
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
@@ -778,6 +788,9 @@ static long subdev_do_ioctl(struct file *file, unsigned int cmd, void *arg,
 		struct v4l2_subdev_krouting krouting = {};
 		unsigned int i;
 
+		if (!v4l2_subdev_enable_streams_api)
+			return -ENOIOCTLCMD;
+
 		if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
 			return -ENOIOCTLCMD;
 
-- 
2.34.1

