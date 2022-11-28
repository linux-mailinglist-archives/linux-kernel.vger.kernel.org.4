Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156663A4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiK1JWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiK1JW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:22:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44C15800;
        Mon, 28 Nov 2022 01:22:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B950C6602ACE;
        Mon, 28 Nov 2022 09:22:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669627345;
        bh=l7ZG9TkqTdWaBRyskK4GczkMCb93J8ROfY3OVmuNmtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oInpZUHXB7zOPYbBezlIZaWdf4PJgphAs20BHl/Gd0PfZj6uUQ/Xa3Zozwx68YaEV
         ny2z2PDfEjPaPXJkTuFd8/sVLlKe2qp+URst9xrhokjCaCEVGzAAAGt+erk8Ec1/R/
         AuINwOOSWAZPl9KXcI/K7C+029TB3hyAmf2blEZhiqmnsZcap23pG8rCg38UKi7vOR
         uyzdZl1Lah7K5fb+f3WK8/kB5QBkoKAPO3IKfL4JZBGrsbUpvvB4Fia0/G/ghi1nWg
         ijPdoxi227Ax/6l2osmpAXJeLP92bmqHNuqgU8v9uWD0knIB7D2etLp6sRvisWqqu9
         BhG1zWyDniF1g==
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
Subject: [PATCH v3 4/4] irqchip: irq-mtk-cirq: Add support for System CIRQ on MT8192
Date:   Mon, 28 Nov 2022 10:22:17 +0100
Message-Id: <20221128092217.36552-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221128092217.36552-1-angelogioacchino.delregno@collabora.com>
References: <20221128092217.36552-1-angelogioacchino.delregno@collabora.com>
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
index 4776ed6492fb..76bc0283e3b9 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -39,6 +39,18 @@ static const u32 mtk_cirq_regoffs_v1[] = {
 	[CIRQ_CONTROL]	= 0x300,
 };
 
+static const u32 mtk_cirq_regoffs_v2[] = {
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
@@ -277,6 +289,7 @@ static const struct of_device_id mtk_cirq_of_match[] = {
 	{ .compatible = "mediatek,mt2701-cirq", .data = &mtk_cirq_regoffs_v1 },
 	{ .compatible = "mediatek,mt8135-cirq", .data = &mtk_cirq_regoffs_v1 },
 	{ .compatible = "mediatek,mt8173-cirq", .data = &mtk_cirq_regoffs_v1 },
+	{ .compatible = "mediatek,mt8192-cirq", .data = &mtk_cirq_regoffs_v2 },
 	{ /* sentinel */ }
 };
 
-- 
2.38.1

