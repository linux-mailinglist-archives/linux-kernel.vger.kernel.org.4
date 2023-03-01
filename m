Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A583C6A6A35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCAJzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCAJzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:38 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6236366AD;
        Wed,  1 Mar 2023 01:55:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FCE36602124;
        Wed,  1 Mar 2023 09:55:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664534;
        bh=2d8a1s6Yhde89pXYtEnq08v+ES25mvl579PIaEXQyEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV1Y8hUMxFxnT8si4HLY2rJ3SBPrJOLXxbctFDlQHKUnmFzEFPmkKbp7jAiwUK8+P
         syje2iCgft1dTVDo2IoWm7MeaB8+NBw2FKNzO+RyD2rBL2+5h4BOm50Hom67nAwa87
         JiB5kCdpxCBpihHOT28dFjoYfebX5qSxw+j3sZ+z9M1Ef+h0LPF6oGGAVWW05THuPD
         gzGSp9hwuWBr5BOtsa/SATn2K6q58g/b/DRTu+aDetAab6soHlpjYcR8pygCKIKtEF
         Ifahfo7cy7/Ca1U9tmkULSlTSFqugDzdHECHaepiszG1ItUZtazmlkjVTbsbZlcB68
         o4990U0jX0nxQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 08/19] arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
Date:   Wed,  1 Mar 2023 10:55:12 +0100
Message-Id: <20230301095523.428461-9-angelogioacchino.delregno@collabora.com>
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

The mfg_ref_sel clock is a mux used to switch between different "safe"
(and slower) clock sources for the GPU: this is used during MFGPLL
reconfiguration and eventually during idling at very low frequencies.

This clock getting turned off means that the GPU will occasionally be
unclocked, producing obvious consequences such as system crash or
unpredictable behavior: assigning it to the top level MFG power domain
will make sure that this stays on at all times during any operation on
the MFG domain (only GPU-related transactions).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 34631adc52c6..a29cdff8a095 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -499,8 +499,9 @@ power-domain@MT8192_POWER_DOMAIN_CONN {
 
 				power-domain@MT8192_POWER_DOMAIN_MFG0 {
 					reg = <MT8192_POWER_DOMAIN_MFG0>;
-					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>;
-					clock-names = "mfg";
+					clocks = <&topckgen CLK_TOP_MFG_PLL_SEL>,
+						 <&topckgen CLK_TOP_MFG_REF_SEL>;
+					clock-names = "mfg", "alt";
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#power-domain-cells = <1>;
-- 
2.39.2

