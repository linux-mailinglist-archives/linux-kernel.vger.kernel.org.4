Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E5E7355B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFSL12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjFSL11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:27:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B4113;
        Mon, 19 Jun 2023 04:27:25 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 19B36547;
        Mon, 19 Jun 2023 13:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174010;
        bh=vKoVEh8/BVZ6bIy/hlGDIh7J4gLuFZr4qI4O6tce2iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjZjo4QG3nRjoqquQPe5bfdbkA0Xmvxu7yuKfqGthGc3bq6IA8xHcAzqdb9rOWX+e
         AhmLPyGjc1Tu/c/1dRXsXfp8LzsA7T377g5X2dANXTsCondZTP0Z7g4XK7kQ+WxYjd
         RZ8vcIA1cloPOrcC34vqnWeB0bWj0YXnNsZAWPrQ=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 2/3] media: subdev: Constify v4l2_subdev_set_routing_with_fmt() param
Date:   Mon, 19 Jun 2023 14:27:06 +0300
Message-Id: <20230619112707.239565-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
References: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routing parameter of v4l2_subdev_set_routing_with_fmt() is missing
'const'. Add it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 2 +-
 include/media/v4l2-subdev.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index c1ac6d7a63d2..73f716a42569 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1590,7 +1590,7 @@ EXPORT_SYMBOL_GPL(__v4l2_subdev_next_active_route);
 
 int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
 				     struct v4l2_subdev_state *state,
-				     struct v4l2_subdev_krouting *routing,
+				     const struct v4l2_subdev_krouting *routing,
 				     const struct v4l2_mbus_framefmt *fmt)
 {
 	struct v4l2_subdev_stream_configs *stream_configs;
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index b325df0d54d6..ca0bacb88537 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1532,7 +1532,7 @@ __v4l2_subdev_next_active_route(const struct v4l2_subdev_krouting *routing,
  */
 int v4l2_subdev_set_routing_with_fmt(struct v4l2_subdev *sd,
 				     struct v4l2_subdev_state *state,
-				     struct v4l2_subdev_krouting *routing,
+				     const struct v4l2_subdev_krouting *routing,
 				     const struct v4l2_mbus_framefmt *fmt);
 
 /**
-- 
2.34.1

