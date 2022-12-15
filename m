Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D561264DB08
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiLOMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLOMRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8574523178;
        Thu, 15 Dec 2022 04:17:10 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D0C112EF;
        Thu, 15 Dec 2022 13:17:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106627;
        bh=y/7z+exO+3f1Axqi62tJwCC4d2zlinCaszJ+iZVM2HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxQm40+dUXFZC+9IauWEXMecv+PvTb9oTjOAf/PzrQEVs5TFUnvhsVUaDIbSvpj/p
         dyHYr+say1Du6XHw3uoBtj3UCBOR/nv06HXA+ncZ6mBezaGDgtW9qGzwrp1W85b+fE
         rGSr9eo7InysXwRLCDVODgeojwGf8+Dv1f0Aa+KE=
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
Subject: [PATCH v16 02/20] media: add V4L2_SUBDEV_FL_STREAMS
Date:   Thu, 15 Dec 2022 14:16:16 +0200
Message-Id: <20221215121634.287100-3-tomi.valkeinen@ideasonboard.com>
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

Add subdev flag V4L2_SUBDEV_FL_STREAMS. It is used to indicate that the
subdev supports the new API with multiplexed streams (routing, stream
configs).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 include/media/v4l2-subdev.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index 2f80c9c818ed..4be0a590c7c7 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -879,6 +879,17 @@ struct v4l2_subdev_internal_ops {
  * should set this flag.
  */
 #define V4L2_SUBDEV_FL_HAS_EVENTS		(1U << 3)
+/*
+ * Set this flag if this subdev supports multiplexed streams. This means
+ * that the driver supports routing and handles the stream parameter in its
+ * v4l2_subdev_pad_ops handlers. More specifically, this means:
+ *
+ * - Centrally managed subdev active state is enabled
+ * - Legacy pad config is _not_ supported (state->pads is NULL)
+ * - Routing ioctls are available
+ * - Multiple streams per pad are supported
+ */
+#define V4L2_SUBDEV_FL_STREAMS			(1U << 4)
 
 struct regulator_bulk_data;
 
-- 
2.34.1

