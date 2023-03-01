Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83E6A6A43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjCAJ4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCAJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADCC34F62;
        Wed,  1 Mar 2023 01:55:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D050D660211B;
        Wed,  1 Mar 2023 09:55:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664537;
        bh=co4SeDmQzj4uU8aYQJsjemsonD8P7POUOi2D/TyJicQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LNy8CnbOZxIoaSG9lOwDELZPZvwSOFF6ZoXE3St0Hjhbs1dq9GP2Vr9Ux4rfjgDDA
         c98a5Ml4ioX3aLdmuVF37c/VCxRt+/7GDBFM/Dj21pdh6dxvtdl+kKPCbKpCuLg1R8
         3FQO3RGxwc3Zffx7q+wNLT8y7ajTGd6hHOXWGxCmDd2sYyxjkJ9GiNlt8jgdnJpbXM
         2MDpGwx2YrkdLz6w8ibZ1vkQ2Ttg4Nv5B+h0PkTIbdaMXMSLdNwhcrB1niGm5IRuo4
         5IbCQ8+tDH8EusEPQclRv9ytqM1Wt98Rnf/H0jlDjomO7qpGUyU3NQCGFYD7G+6Mzy
         zBPcCtltPv/SA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple VGPU and VSRAM_OTHER regulators
Date:   Wed,  1 Mar 2023 10:55:16 +0100
Message-Id: <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
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

Add coupling for these regulators, as VSRAM_OTHER is used to power the
GPU SRAM, and they have a strict voltage output relation to satisfy in
order to ensure GPU stable operation.
While at it, also add voltage constraint overrides for the GPU SRAM
regulator "mt6359_vsram_others" so that we stay in a safe range of
0.75-0.80V.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 8570b78c04a4..f858eca219d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
 	regulator-always-on;
 };
 
+&mt6359_vsram_others_ldo_reg {
+	regulator-min-microvolt = <750000>;
+	regulator-max-microvolt = <800000>;
+	regulator-coupled-with = <&mt6315_7_vbuck1>;
+	regulator-coupled-max-spread = <10000>;
+};
+
 &mt6359_vufs_ldo_reg {
 	regulator-always-on;
 };
@@ -1411,6 +1418,8 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
+				regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
+				regulator-coupled-max-spread = <10000>;
 			};
 		};
 	};
-- 
2.39.2

