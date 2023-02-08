Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45B68ED51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjBHKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjBHKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:46:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883D47EFC;
        Wed,  8 Feb 2023 02:45:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9A4566020A2;
        Wed,  8 Feb 2023 10:45:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675853143;
        bh=iOLDoRtCa+fRE160zIHQzs9EtumGO/iTit/r4VP3orI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUwMsMKeBnkAav17FUHf070DjbWbUvnbQK2zXeB0quAirxgyhrCXfNhnJA2+nlWou
         RCH1vRgz5w7TkmrXdvEURpgCpXVqYakGDBXNa5TtQ7J356A0xVBy7p4GQNhlbqBNTB
         MvlFmJmq9oOgD4t0z15WzEtLyv4WymzHHUH8nLgYFFmFbn7yp9d/Oi6y/RAEhtI3JC
         v4G+u3U++yCdDiUrFFe2q6p3HJ75dvK2rh76EoeEjxj61kSDplAAF89PdP24jVQ0b0
         O0cINeO2e8Oj8DGFAYcxgEQEK/2zo5utojprbwHQy3ThzJ57a/O0K1jxZRUgAz53K9
         hMb/Y+K7+uBxA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 11/16] arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER regulators
Date:   Wed,  8 Feb 2023 11:45:22 +0100
Message-Id: <20230208104527.118929-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
References: <20230208104527.118929-1-angelogioacchino.delregno@collabora.com>
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

Add coupling for these regulators, as VSRAM_OTHER is used to power the
GPU SRAM, and they have a strict voltage output relation to satisfy in
order to ensure GPU stable operation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index df477eb89f21..c8b6e1a9605b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
 
+&mt6359_vsram_others_ldo_reg {
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <850000>;
+	regulator-coupled-with = <&mt6315_7_vbuck1>;
+	regulator-coupled-max-spread = <10000>;
+};
+
 &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
@@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-max-microvolt = <1193750>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
+				regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
+				regulator-coupled-max-spread = <10000>;
 			};
 		};
 	};
-- 
2.39.1

