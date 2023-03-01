Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798996A6A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCAJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjCAJzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4E3B667;
        Wed,  1 Mar 2023 01:55:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5676866020E6;
        Wed,  1 Mar 2023 09:55:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664540;
        bh=zNRcNap0DKbKus9H9hYNrxN03fzRsqShpCKFraZ9Guk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0mJRNYsI1EWGG60jwpP5XNylZ79iqYTvNxHVaQvBqOmgh4tyCnB9jzoigrQeL4/y
         YyWqIL5PD4EkiRFXi24I9wMkKwGspShqvOKzuHrjOIgEbokLHh2k8wPLFlJ1R8F+bR
         lw3b9RPQ7vp4d8cHepEKf2SQwtnPz0TK7uw392TUunQ7+iTozVM1tjeLWQzEkR28Bh
         gBhUM3PaBuZiSxGAlqNoRiVU0e5D0xdkwd6khL+MCS+jFfr1GYbYIbP2DcdeJ7rq0n
         8S2+QsMb3D9Rn9HGmxhzlxxOpp0PV2ky7lXaEri7Xi99HCN2YUo7WkCVpe3Mi0NvF9
         /n5QiMMTjOHCg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 17/19] arm64: dts: mediatek: mt8186: Add GPU node
Date:   Wed,  1 Mar 2023 10:55:21 +0100
Message-Id: <20230301095523.428461-18-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
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

Add a GPU node for MT8186 SoC but keep it disabled.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index a0d3e1f731bd..78ff8ba5718e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -1075,6 +1075,23 @@ mfgsys: clock-controller@13000000 {
 			#clock-cells = <1>;
 		};
 
+		gpu: gpu@13040000 {
+			compatible = "mediatek,mt8186-mali",
+				     "arm,mali-bifrost";
+			reg = <0 0x13040000 0 0x4000>;
+
+			clocks = <&mfgsys CLK_MFG_BG3D>;
+			interrupts = <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "job", "mmu", "gpu";
+			power-domains = <&spm MT8186_POWER_DOMAIN_MFG2>,
+					<&spm MT8186_POWER_DOMAIN_MFG3>;
+			power-domain-names = "core0", "core1";
+			#cooling-cells = <2>;
+			status = "disabled";
+		};
+
 		mmsys: syscon@14000000 {
 			compatible = "mediatek,mt8186-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.39.2

