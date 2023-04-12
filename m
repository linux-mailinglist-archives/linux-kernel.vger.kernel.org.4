Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950D56DFA44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDLPdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDLPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93C46590;
        Wed, 12 Apr 2023 08:33:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD8056603219;
        Wed, 12 Apr 2023 16:33:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681313600;
        bh=+DBOozEV6zvFq6sDBHu5yAuL64S2LBrToRv6x5AB1z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhXRdUVZPffRyg7uD1DEgcLRjFL6IxRvV3oEFJuAiz3BaEoLSFIghKCJYD0lc0XZT
         /ycIY0UWHL+U+OuRW1xxGjW713R7e32O/VxUPbQ64imudADIDSedOvhopFvvAH9+fI
         53dSVZUcPn8WAECnzdaUzEAAYdoSkzleHEY+tWBjsTwsdQJd+J2+CScdjo2ci8JMnE
         MoAV1iRcq2ZgqouJHgfU9rjBojjA5bSvCYDQga0+ymZQeVulbvBHtCBxtZI5YDzCfp
         pdvB/ya2RqKugj5fqP6dVJ5HqZ3RC04khDqWSC/gmRWcoEZoMrEr7eJCYZ+5Sg3XM5
         O9RQCGkVfjK3w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 4/7] leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
Date:   Wed, 12 Apr 2023 17:33:07 +0200
Message-Id: <20230412153310.241046-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one instance of using this macro and it's anyway not
simplifying the flow, or increasing the readability of this driver.

Drop this macro by open coding it in mt6323_led_set_blink().

No functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/leds/leds-mt6323.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index a5b2d06e9d63..dc604c187cb2 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -62,8 +62,6 @@
 #define MT6323_ISINK_CH_EN(i)		BIT(i)
 
 #define MAX_SUPPORTED_LEDS		8
-#define MT6323_CAL_HW_DUTY(o, p, u)	DIV_ROUND_CLOSEST((o) * 100000ul,\
-					(p) * (u))
 
 struct mt6323_leds;
 
@@ -321,7 +319,7 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 	 * Calculate duty_hw based on the percentage of period during
 	 * which the led is ON.
 	 */
-	duty_hw = MT6323_CAL_HW_DUTY(*delay_on, period, spec->unit_duty);
+	duty_hw = DIV_ROUND_CLOSEST(*delay_on * 100000ul, period * spec->unit_duty);
 
 	/* hardware doesn't support zero duty cycle. */
 	if (!duty_hw)
-- 
2.40.0

