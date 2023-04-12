Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCD6DFA46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjDLPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjDLPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451DD7ABF;
        Wed, 12 Apr 2023 08:33:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67DA66603227;
        Wed, 12 Apr 2023 16:33:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681313602;
        bh=vi2RDu/bGYlPP6E/3zXtPAMtZWGHd8Hd3r1hdyJKQnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NFDDLE+MHTl29/l2YZg5/bsUqieAzLVk1lBO/MVsq1QtEURZ22Xrw5PnHoDcIP01l
         1CNzKzXr19cI+PDE+vBjXWe9S6xalqbsDZcM+FqgIBYkxQKpF+idwOUI2OsfE3hzER
         rHA6gYe7ifFftu6K1FWgd1zHBmGoZWL4FNEYNC73qo7d3tx94NOhdZzf6wPK3KTxlv
         vgMev/uBDNvTnfZHrpmayg0ZoCdAGkM3I0K8pOhClDxE7upIA97g1MgrRh66StGhkD
         b4LPWDNQw5XsftlYV09Yz+49+fNcG5eVkPwQaMWUqhB3zhmDHSNghmXaMN9ifY4BME
         BZli95nAZx3eQ==
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
Subject: [PATCH v2 6/7] leds: leds-mt6323: Add support for MT6331 leds
Date:   Wed, 12 Apr 2023 17:33:09 +0200
Message-Id: <20230412153310.241046-7-angelogioacchino.delregno@collabora.com>
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

Add the register offsets for MT6331. The hwspec is the same as MT6323.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/leds/leds-mt6323.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index 182256ec1924..5d95dbd9a761 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -531,6 +531,17 @@ static const struct mt6323_regs mt6323_registers = {
 	.isink_en_ctrl = 0x356,
 };
 
+static const struct mt6323_regs mt6331_registers = {
+	.top_ckpdn = (const u16[]){ 0x138, 0x13e, 0x144 },
+	.num_top_ckpdn = 3,
+	.top_ckcon = (const u16[]){ 0x14c, 0x14a },
+	.num_top_ckcon = 2,
+	.isink_con = (const u16[]){ 0x40c, 0x40e, 0x410, 0x412, 0x414 },
+	.num_isink_con = 5,
+	.isink_max_regs = 4, /* ISINK[0..3] */
+	.isink_en_ctrl = 0x43a,
+};
+
 static const struct mt6323_hwspec mt6323_spec = {
 	.max_period = 10000,
 	.max_leds = 4,
@@ -543,8 +554,14 @@ static const struct mt6323_data mt6323_pdata = {
 	.spec = &mt6323_spec,
 };
 
+static const struct mt6323_data mt6331_pdata = {
+	.regs = &mt6331_registers,
+	.spec = &mt6323_spec,
+};
+
 static const struct of_device_id mt6323_led_dt_match[] = {
 	{ .compatible = "mediatek,mt6323-led", .data = &mt6323_pdata},
+	{ .compatible = "mediatek,mt6331-led", .data = &mt6331_pdata },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mt6323_led_dt_match);
-- 
2.40.0

