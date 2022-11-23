Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5899635B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiKWLXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbiKWLXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:23:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6DD769FA;
        Wed, 23 Nov 2022 03:23:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C7426602AE2;
        Wed, 23 Nov 2022 11:23:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669202580;
        bh=SS5h0AcRIuCYZwAghSxIqcJiZsZkfQ+w6DNodr6pz3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V20LmNqEDP+RZ0vAsiU/DQZGF5/FzpEzVBLshk46yMDkXxGYO4LWXx9JEi0+gutz8
         7kkJmsbuS0HechadCgfeRB/dAcVA+ZGOHCZdkS6XOipqkEsbdkZ+W80o0YoLoZryIg
         E+rNNVZNt9nbw0qBMh3Axy7Y0Do+7bzWppxD8u7S4leSJnC7gqdZFLMOZAKAx7RWo3
         nzHCHgq83zmjzyDz+ettN+5uq7XAQBcTtioiPlt1XLAKPiDWkdLlfGEXmH1f2XU2m7
         oVFRA55Z8wDuOJOMAzg/E+QXMHFj31rhFH7LxhejhrrflUQsKd/Y7jneWSXQLWo7tz
         lvioMV7HT09qg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 4/4] irqchip: irq-mtk-cirq: Add support for System CIRQ on MT8192
Date:   Wed, 23 Nov 2022 12:22:49 +0100
Message-Id: <20221123112249.98281-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
References: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
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

On some SoCs the System CIRQ register layout is slightly different,
as there are more registers per function and in some cases other
differences later in the layout: this is seen on at least MT8192,
but it's also valid for some other "contemporary" SoCs both for
Chromebooks and for smartphones.

Add the new "v2" register layout and use it if the compatible
"mediatek,mt8192-cirq" is found.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/irqchip/irq-mtk-cirq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 4d873d2ba0fd..57452d389b47 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -39,6 +39,18 @@ static const u32 mtk_cirq_regs_v1[] = {
 	[CIRQ_CONTROL]	= 0x300,
 };
 
+static const u32 mtk_cirq_regs_v2[] = {
+	[CIRQ_STA]	= 0x0,
+	[CIRQ_ACK]	= 0x80,
+	[CIRQ_MASK_SET]	= 0x180,
+	[CIRQ_MASK_CLR]	= 0x200,
+	[CIRQ_SENS_SET]	= 0x300,
+	[CIRQ_SENS_CLR]	= 0x380,
+	[CIRQ_POL_SET]	= 0x480,
+	[CIRQ_POL_CLR]	= 0x500,
+	[CIRQ_CONTROL]	= 0x600,
+};
+
 #define CIRQ_EN	0x1
 #define CIRQ_EDGE	0x2
 #define CIRQ_FLUSH	0x4
@@ -273,6 +285,7 @@ static const struct of_device_id mtk_cirq_of_match[] = {
 	{ .compatible = "mediatek,mt2701-cirq", .data = &mtk_cirq_regs_v1 },
 	{ .compatible = "mediatek,mt8135-cirq", .data = &mtk_cirq_regs_v1 },
 	{ .compatible = "mediatek,mt8173-cirq", .data = &mtk_cirq_regs_v1 },
+	{ .compatible = "mediatek,mt8192-cirq", .data = &mtk_cirq_regs_v2 },
 	{ /* sentinel */ }
 };
 
-- 
2.38.1

