Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F162719AA3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjFALIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjFALI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57B123;
        Thu,  1 Jun 2023 04:08:25 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B1D156606ECB;
        Thu,  1 Jun 2023 12:08:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617704;
        bh=x0Qr5LahDfyZYZmRkn9rv/gKpzoGdsqrT9tCKkLWPyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jkQIaAMQWxdMtJ2Y2UqHFh9nVHlXD+9iuuCazccKhNJRxHaM69XgsHkg5W+8ECBOr
         utYhND6GBl/pA+BOzweDtrDNt0I5cBj4mRUIBgezE8viQLkKY7I/+952tcuPh6IPEH
         Fp2T/8eJrte8iJ3m/cJmZ4DYp4DGK6g0x5W+ECg/Y9qmsIf4HziJZ2HfGuiwii8yDL
         1d2ssJvYZLlHmhOz2fwr/2p1ExYKQ/gAHBZGWT4b1HhrX7pBbPYYDiNWgQIcUm2AO1
         EnbJr0vl0LYZW1NK5qOY0fs1nXzGFlULA/ht0TvCjZIjLt5S2CtNM/XKnFVzp0uHID
         0IleZnRS1Y8EQ==
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
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 6/8] leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
Date:   Thu,  1 Jun 2023 13:08:11 +0200
Message-Id: <20230601110813.2373764-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/leds/leds-mt6323.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index dae782de09c4..f8bd9f17e89c 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -57,8 +57,6 @@
 #define ISINK_CH_EN(i)		BIT(i)
 
 #define MAX_SUPPORTED_LEDS		8
-#define MT6323_CAL_HW_DUTY(o, p, u)	DIV_ROUND_CLOSEST((o) * 100000ul,\
-					(p) * (u))
 
 struct mt6323_leds;
 
@@ -316,7 +314,7 @@ static int mt6323_led_set_blink(struct led_classdev *cdev,
 	 * Calculate duty_hw based on the percentage of period during
 	 * which the led is ON.
 	 */
-	duty_hw = MT6323_CAL_HW_DUTY(*delay_on, period, spec->unit_duty);
+	duty_hw = DIV_ROUND_CLOSEST(*delay_on * 100000ul, period * spec->unit_duty);
 
 	/* hardware doesn't support zero duty cycle. */
 	if (!duty_hw)
-- 
2.40.1

