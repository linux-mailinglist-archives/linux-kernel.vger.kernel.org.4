Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631396A5718
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjB1KsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjB1KsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:48:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57406E9B;
        Tue, 28 Feb 2023 02:47:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 297D56602FD6;
        Tue, 28 Feb 2023 10:47:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677581274;
        bh=2d8a1s6Yhde89pXYtEnq08v+ES25mvl579PIaEXQyEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ima4zDZiIey6aYeTZgcLCNjPNHGjugB/Df1/IfaoIYBEivRgbURpY7DngWKPpL4IN
         bTPc+7QzSiOv44327eM+ZQGsEs0ewW2kgtQta4Uyp13ddd9/dcA5U/earYcBMoqJf0
         OE9DgpcdUav5OgHsjnYuA+8LefTbmI3bwb4pNptqhYDU5Ui574U9YpEC0iVCaNQI8P
         jidOEyEuUASIf5J+FmOL36A74vQj0OFbFX74LCWavpC8cPg498ZUx7daM1/JdlISJy
         R184Qb853erFpVWQNLbFLeyjghIh/YcJhLQ/M/7gTOaN7tL2Dk4wJ2NcdbJTr7b9/8
         aSFqUCItI9ftQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v3 08/18] arm64: dts: mediatek: mt8192: Add mfg_ref_sel clock to MFG0 domain
Date:   Tue, 28 Feb 2023 11:47:31 +0100
Message-Id: <20230228104741.717819-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
References: <20230228104741.717819-1-angelogioacchino.delregno@collabora.com>
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

