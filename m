Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8A719AA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjFALIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjFALIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C70133;
        Thu,  1 Jun 2023 04:08:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A75DE66003B1;
        Thu,  1 Jun 2023 12:08:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617705;
        bh=rtkU/LXfohClR1Fp46CLmRkHJo8bXflFgsmdF+fF9IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3IqwhnCOUQ5YmTsSOqw9XdFRg+83XHDCkTO62ylLR0xe/WV4OpHY9agl0/YzJadB
         qf6XaEV3z5M9Z4NWgfqathD5tfvjH5WTv6bsw2v4lCLEugFVGJdrac28A013ig+XFX
         APMTSf8Dg/3JjFno1S+ERcfKzsd7J92Uu3GPyFpvNx0XnfXoQfoZwBN9mOtPRRshK6
         NTStgOTinKjaOHfXYfgbN2b9X7jC3Nli9fUPrIvRetgGeeVtT845LmW6LYBZBaW6tr
         3SwlBd5WLThvFN4qJ3ClTA4pjBgjktrFvJxCypl9xSXCWzLAfzMeS4f3A4EgIrVYvh
         Os795yIVjI1jA==
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
Subject: [PATCH v3 7/8] leds: leds-mt6323: Add support for MT6331 leds
Date:   Thu,  1 Jun 2023 13:08:12 +0200
Message-Id: <20230601110813.2373764-8-angelogioacchino.delregno@collabora.com>
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

Add the register offsets for MT6331. The hwspec is the same as MT6323.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/leds/leds-mt6323.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/leds/leds-mt6323.c b/drivers/leds/leds-mt6323.c
index f8bd9f17e89c..85b056fcd94e 100644
--- a/drivers/leds/leds-mt6323.c
+++ b/drivers/leds/leds-mt6323.c
@@ -529,6 +529,17 @@ static const struct mt6323_regs mt6323_registers = {
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
@@ -541,8 +552,14 @@ static const struct mt6323_data mt6323_pdata = {
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
2.40.1

