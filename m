Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8837355BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFSL1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFSL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:27:29 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9F100;
        Mon, 19 Jun 2023 04:27:28 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB887800;
        Mon, 19 Jun 2023 13:26:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174011;
        bh=Ua5NcitkYLYSqBnLZDqy7P/dMOR9PahCDNt3nwt7wFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZNHpJMwzDW3Z/m/Niqez8UbbEjXIXS1IOOiQTnROmHWVPt55Owh09Fnz6j/ytirh8
         ePGHkqMzS3byVpgXkvJF6NcpS3kxhtDEknarMnldYRYtA6LqlZuLwWOGB3sFlhaJcb
         WE0zJE+/WWHvQMbci4olFIHpTO3mrfKBxzj16AFM=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 3/3] media: subdev: Add debug prints to enable/disable_streams
Date:   Mon, 19 Jun 2023 14:27:07 +0300
Message-Id: <20230619112707.239565-3-tomi.valkeinen@ideasonboard.com>
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

It is often useful to see when streaming for a device is being enabled
or disabled. Add debug prints for this to v4l2_subdev_enable_streams()
and v4l2_subdev_disable_streams().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 73f716a42569..0f86a165b202 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1977,11 +1977,16 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
+
 	/* Call the .enable_streams() operation. */
 	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
 			       streams_mask);
-	if (ret)
+	if (ret) {
+		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
+			streams_mask, ret);
 		goto done;
+	}
 
 	/* Mark the streams as enabled. */
 	for (i = 0; i < state->stream_configs.num_configs; ++i) {
@@ -2089,11 +2094,16 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
 		goto done;
 	}
 
+	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
+
 	/* Call the .disable_streams() operation. */
 	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
 			       streams_mask);
-	if (ret)
+	if (ret) {
+		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
+			streams_mask, ret);
 		goto done;
+	}
 
 	/* Mark the streams as disabled. */
 	for (i = 0; i < state->stream_configs.num_configs; ++i) {
-- 
2.34.1

