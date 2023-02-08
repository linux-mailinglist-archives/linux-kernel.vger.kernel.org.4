Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BC168ED52
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjBHKqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBHKqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:46:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C3147EF4;
        Wed,  8 Feb 2023 02:45:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6A7C566020A4;
        Wed,  8 Feb 2023 10:45:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675853144;
        bh=jfBlI6E0bJoeexQtOH/Sz6zM280GKkmPVg2i18O6Y/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fULRBv9/4obvasWi26fgO8uKYQcq8euIPm6ZgnVEgBfSnxFrsJDAtKDa1qNcuwZ6j
         BS8C9VC8KNitWVUtzwFl8ZsTJLgbIWOamvrJ3Oxs8uKJiyXQ1igDTkz9q4AkJQfI0G
         gUZZCnMrmjs896g/zslMGMOFU5Ub9BHn4FZSyRPREh/tnUMGWCHNN+Uovw1y4qjxs9
         SwKjhuN4U0NrhLSXyp8JdCV18UmIYKrT17E3rnsju9RYV5g8Ld+mjqBiWR1XrW+QmA
         zmDmzx42xGRb9RYA6Hs6eHABSgYP453JTzW29FYOOnnxe+c5JOVQiEe322LeTCT6ny
         VEHCBJ6j5itmA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 13/16] arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
Date:   Wed,  8 Feb 2023 11:45:24 +0100
Message-Id: <20230208104527.118929-14-angelogioacchino.delregno@collabora.com>
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

Similarly to what can be seen in MT8192, on MT8195 the mfg_core_tmp
clock is a mux used to switch between different "safe" (and slower)
clock sources for the GPU: this is used during MFGPLL reconfiguration
and eventually during idling at very low frequencies.

This clock getting turned off means that the GPU will occasionally be
unclocked, producing obvious consequences such as system crash or
unpredictable behavior: assigning it to the top level MFG power domain
will make sure that this stays on at all times during any operation on
the MFG domain (only GPU-related transactions).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 8f1264d5290b..d116830d6af3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -446,8 +446,9 @@ mfg0: power-domain@MT8195_POWER_DOMAIN_MFG0 {
 
 					power-domain@MT8195_POWER_DOMAIN_MFG1 {
 						reg = <MT8195_POWER_DOMAIN_MFG1>;
-						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>;
-						clock-names = "mfg";
+						clocks = <&apmixedsys CLK_APMIXED_MFGPLL>,
+							 <&topckgen CLK_TOP_MFG_CORE_TMP>;
+						clock-names = "mfg", "alt";
 						mediatek,infracfg = <&infracfg_ao>;
 						#address-cells = <1>;
 						#size-cells = <0>;
-- 
2.39.1

