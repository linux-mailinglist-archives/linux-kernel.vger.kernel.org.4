Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3064C962
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiLNM7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbiLNM67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:58:59 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4731FBC05;
        Wed, 14 Dec 2022 04:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1671022717; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKGHG3bC4nshhLO5ifNxW0xWVxriUgCc83bAuctfHfM=;
        b=1UNKVvlPTCVro1zT9tLnprJM4KzWBmPcIfZ+/YwAJTfExGEKe8L4wFBgt/tWhbgfq4nnM8
        6x49DhWmiF5wrRlZOKZKPB8wl329iYZMowaJU3UrytIIjrxs1FwFmaudP95pflspjXO0Ar
        K99cRfcUZdugJ7YX26IV83++N9LZMzU=
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
Subject: [PATCH 03/10] drm: bridge: it66121: Use regmap_noinc_read()
Date:   Wed, 14 Dec 2022 13:58:14 +0100
Message-Id: <20221214125821.12489-4-paul@crapouillou.net>
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

Use regmap_noinc_read() instead of reading the data from the DDC FIFO one
byte at a time.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index a698eec8f250..12222840df30 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -589,13 +589,12 @@ static int it66121_get_edid_block(void *context, u8 *buf,
 		if (ret)
 			return ret;
 
-		do {
-			ret = regmap_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG, &val);
-			if (ret)
-				return ret;
-			*(buf++) = val;
-			cnt--;
-		} while (cnt > 0);
+		ret = regmap_noinc_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG,
+					buf, cnt);
+		if (ret)
+			return ret;
+
+		buf += cnt;
 	}
 
 	return 0;
-- 
2.35.1

