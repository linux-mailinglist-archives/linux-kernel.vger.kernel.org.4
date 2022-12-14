Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B1B64C967
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbiLNM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiLNM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:59:13 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7AE2AD4;
        Wed, 14 Dec 2022 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022718; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjEqO4+e5a85zoFujWIdC4NDhCTvt3vZK7qMG1zFzpw=;
        b=cQ7sM/duB1Ux5RyiSMSRezimCjOFlDjgcHqu/LkB5qaauPqMY+kcSY77YiRqS0AG8ETxcA
        BjsEBiB4N5UcW9AWZxSlL2MPpBh9Z6sR6et5U2F5j/ynZ3lJZejoAvRXj3YFfb/5JxHaaJ
        g2cNzoksDdMX6uTjGK3w5RApjGizKd8=
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
Subject: [PATCH 05/10] drm: bridge: it66121: Fix wait for DDC ready
Date:   Wed, 14 Dec 2022 13:58:16 +0100
Message-Id: <20221214125821.12489-6-paul@crapouillou.net>
In-Reply-To: <20221214125821.12489-1-paul@crapouillou.net>
References: <20221214125821.12489-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function it66121_wait_ddc_ready() would previously read the status
register until "true", which means it never actually polled anything and
would just read the register once.

Now, it will properly wait until the DDC hardware is ready or until it
reported an error.

The 'busy' variable was also renamed to 'error' since these bits are set
on error and not when the DDC hardware is busy.

Since the DDC ready function is now working properly, the msleep(20) can
be removed.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 0a4fdfd7af44..bfb9c87a7019 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -440,15 +440,17 @@ static int it66121_configure_afe(struct it66121_ctx *ctx,
 static inline int it66121_wait_ddc_ready(struct it66121_ctx *ctx)
 {
 	int ret, val;
-	u32 busy = IT66121_DDC_STATUS_NOACK | IT66121_DDC_STATUS_WAIT_BUS |
-		   IT66121_DDC_STATUS_ARBI_LOSE;
+	u32 error = IT66121_DDC_STATUS_NOACK | IT66121_DDC_STATUS_WAIT_BUS |
+		    IT66121_DDC_STATUS_ARBI_LOSE;
+	u32 done = IT66121_DDC_STATUS_TX_DONE;
 
-	ret = regmap_read_poll_timeout(ctx->regmap, IT66121_DDC_STATUS_REG, val, true,
-				       IT66121_EDID_SLEEP_US, IT66121_EDID_TIMEOUT_US);
+	ret = regmap_read_poll_timeout(ctx->regmap, IT66121_DDC_STATUS_REG, val,
+				       val & (error | done), IT66121_EDID_SLEEP_US,
+				       IT66121_EDID_TIMEOUT_US);
 	if (ret)
 		return ret;
 
-	if (val & busy)
+	if (val & error)
 		return -EAGAIN;
 
 	return 0;
@@ -582,9 +584,6 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 		offset += cnt;
 		remain -= cnt;
 
-		/* Per programming manual, sleep here before emptying the FIFO */
-		msleep(20);
-
 		ret = it66121_wait_ddc_ready(ctx);
 		if (ret)
 			return ret;
-- 
2.35.1

