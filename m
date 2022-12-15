Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CBB64DB0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiLOMSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLOMRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:35 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6122EF23;
        Thu, 15 Dec 2022 04:17:28 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6B0DA1837;
        Thu, 15 Dec 2022 13:17:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106638;
        bh=G9pIXgNUK1BcwfyFO2N7rkhLQObklcBOTgegYd4bZns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmMpE3Xu+d7KsyNGF6Oq9kWqFkK1NBqLDGceEjn9hU+FlLpoVA2Qnpm7LetthxJqN
         GMU6k1bo2WbsTmr6H9fxNYv7KyZZLh5wdW59NHJk5pGMctYhOugT0fnn155Mefkird
         QBxalA9lGDtTJVEMn+4kYI635EZAjiJMtCiG/BSw=
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
Subject: [PATCH v16 14/20] media: subdev: add streams to v4l2_subdev_get_fmt() helper function
Date:   Thu, 15 Dec 2022 14:16:28 +0200
Message-Id: <20221215121634.287100-15-tomi.valkeinen@ideasonboard.com>
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

Add streams support to v4l2_subdev_get_fmt() helper function. Subdev
drivers that do not need to do anything special in their get_fmt op can
use this helper directly for v4l2_subdev_pad_ops.get_fmt.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 458124da9c5b..c02048e388d1 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1389,10 +1389,14 @@ int v4l2_subdev_get_fmt(struct v4l2_subdev *sd, struct v4l2_subdev_state *state,
 {
 	struct v4l2_mbus_framefmt *fmt;
 
-	if (format->pad >= sd->entity.num_pads)
-		return -EINVAL;
+	if (sd->flags & V4L2_SUBDEV_FL_STREAMS)
+		fmt = v4l2_subdev_state_get_stream_format(state, format->pad,
+							  format->stream);
+	else if (format->pad < sd->entity.num_pads && format->stream == 0)
+		fmt = v4l2_subdev_get_pad_format(sd, state, format->pad);
+	else
+		fmt = NULL;
 
-	fmt = v4l2_subdev_get_pad_format(sd, state, format->pad);
 	if (!fmt)
 		return -EINVAL;
 
-- 
2.34.1

