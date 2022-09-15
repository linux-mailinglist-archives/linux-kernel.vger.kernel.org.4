Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC59E5B972A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiIOJNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIOJM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:12:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9111998A44;
        Thu, 15 Sep 2022 02:12:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F6F56601FC3;
        Thu, 15 Sep 2022 10:12:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663233144;
        bh=8fx/KPlLmnPAbcJz0uLlLUOKmFnlLf43xmpaEp+yAcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q16pttDvcRQRFWuV4vPBcLX2poT3NPfuKpYd9y0U0aIuiP9vu6l4v8GAQmiJYfl8z
         gp3iAlSF1rNimwF0N/Go5jJ91DMfMykMlimY4C46WfM0urELFIBpTcC23CebyrOZHV
         JzMkTSQEc8C1EYWnoJTTe0QhfjD2QUyuvRlMbfoeFzIeMMT8411p8GQp5rQVLjnXcL
         HPKPwt2gswWCOgIHwjKTPaMZfzdDKwKUr3tf4FEQliiKNJpbHxLGibopowUQh147vJ
         xuzhp3ZaZ1PusfBLpJfEemg1GYWo0sFlY9B7ijk7r41zDuXRqORvRFH/rpxDggikft
         7nYs1/0lXlQow==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/7] leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
Date:   Thu, 15 Sep 2022 11:12:09 +0200
Message-Id: <20220915091214.59673-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
References: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index a7d1ed370969..fa9d251e9efa 100644
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
2.37.2

