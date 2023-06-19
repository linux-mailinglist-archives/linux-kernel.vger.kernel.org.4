Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9B7355B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjFSL1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjFSL11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:27:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD810F;
        Mon, 19 Jun 2023 04:27:25 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D59AFB;
        Mon, 19 Jun 2023 13:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174009;
        bh=SKZE2foAuEiJpM0lv3kNXoNAKjM6FsyDumDBcf61Xvs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZF1xhfol2ETOAkBHuhR8/KeNPrD0+8aql8U32pZdWdmLtitmvbN4/Ts/ld3X49toj
         bsV/UKVz4R3t7OB11GHOwHoZYDQntwySGsdDPALi8WSBW0tjWr1OCMpePzXtZi/Kj2
         W1ddrcCS0M/mRKUHjd8D2tehqnxQneYVwKyOu+tY=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 1/3] media: subdev: Drop implicit zeroing of stream field
Date:   Mon, 19 Jun 2023 14:27:05 +0300
Message-Id: <20230619112707.239565-1-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
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

Now that the kernel drivers have been fixed to initialize the stream
field, and we have the client capability which the userspace uses to say
it has initialized the stream field, we can drop the implicit zeroing of
the stream field in the various check functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 2ec179cd1264..c1ac6d7a63d2 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -200,9 +200,6 @@ static inline int check_format(struct v4l2_subdev *sd,
 	if (!format)
 		return -EINVAL;
 
-	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
-		format->stream = 0;
-
 	return check_which(format->which) ? : check_pad(sd, format->pad) ? :
 	       check_state(sd, state, format->which, format->pad, format->stream);
 }
@@ -230,9 +227,6 @@ static int call_enum_mbus_code(struct v4l2_subdev *sd,
 	if (!code)
 		return -EINVAL;
 
-	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
-		code->stream = 0;
-
 	return check_which(code->which) ? : check_pad(sd, code->pad) ? :
 	       check_state(sd, state, code->which, code->pad, code->stream) ? :
 	       sd->ops->pad->enum_mbus_code(sd, state, code);
@@ -245,9 +239,6 @@ static int call_enum_frame_size(struct v4l2_subdev *sd,
 	if (!fse)
 		return -EINVAL;
 
-	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
-		fse->stream = 0;
-
 	return check_which(fse->which) ? : check_pad(sd, fse->pad) ? :
 	       check_state(sd, state, fse->which, fse->pad, fse->stream) ? :
 	       sd->ops->pad->enum_frame_size(sd, state, fse);
@@ -283,9 +274,6 @@ static int call_enum_frame_interval(struct v4l2_subdev *sd,
 	if (!fie)
 		return -EINVAL;
 
-	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
-		fie->stream = 0;
-
 	return check_which(fie->which) ? : check_pad(sd, fie->pad) ? :
 	       check_state(sd, state, fie->which, fie->pad, fie->stream) ? :
 	       sd->ops->pad->enum_frame_interval(sd, state, fie);
@@ -298,9 +286,6 @@ static inline int check_selection(struct v4l2_subdev *sd,
 	if (!sel)
 		return -EINVAL;
 
-	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS))
-		sel->stream = 0;
-
 	return check_which(sel->which) ? : check_pad(sd, sel->pad) ? :
 	       check_state(sd, state, sel->which, sel->pad, sel->stream);
 }
-- 
2.34.1

