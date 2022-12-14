Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB5664C96B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237760AbiLNM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiLNM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:59:27 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B557960F1;
        Wed, 14 Dec 2022 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022719; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K/tzTFKNZMMV1rVb1b3n0tYGGd7bT77iWuW0eM5CPb0=;
        b=CCR3JzkcrQ+B4tyoWwJL3L2TVfweylPk+HzdU2AjikcAi/uYXMI4ARgOFTeN/x+/dWqY9k
        izDSAMZnqNqvIKvlNoV5fEhv2aaKZqS7j4Xm79sZel9uJcrZjgvHi9U4O1jCEnOUs8DcGA
        JSqpM1oCWcQyajDG1YG+2XJMmAHRi+M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 07/10] drm: bridge: it66121: Don't clear DDC FIFO twice
Date:   Wed, 14 Dec 2022 13:58:18 +0100
Message-Id: <20221214125821.12489-8-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-1-paul@crapouillou.net>
References: <20221214125821.12489-1-paul@crapouillou.net>
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

The DDC FIFO was cleared before the loop in it66121_get_edid_block(),
and at the beginning of each iteration; which means that it did not have
to be cleared before the loop.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 06fa59ae5ffc..5335d4abd7c5 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -456,18 +456,6 @@ static inline int it66121_wait_ddc_ready(struct it66121_ctx *ctx)
 	return 0;
 }
 
-static int it66121_clear_ddc_fifo(struct it66121_ctx *ctx)
-{
-	int ret;
-
-	ret = it66121_preamble_ddc(ctx);
-	if (ret)
-		return ret;
-
-	return regmap_write(ctx->regmap, IT66121_DDC_COMMAND_REG,
-			    IT66121_DDC_COMMAND_FIFO_CLR);
-}
-
 static int it66121_abort_ddc_ops(struct it66121_ctx *ctx)
 {
 	int ret;
@@ -515,10 +503,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 	offset = (block % 2) * len;
 	block = block / 2;
 
-	ret = it66121_clear_ddc_fifo(ctx);
-	if (ret)
-		return ret;
-
 	while (remain > 0) {
 		cnt = (remain > IT66121_EDID_FIFO_SIZE) ?
 				IT66121_EDID_FIFO_SIZE : remain;
-- 
2.35.1

