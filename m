Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8446A0AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjBWNoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbjBWNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE379567A5;
        Thu, 23 Feb 2023 05:44:05 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E060C660220D;
        Thu, 23 Feb 2023 13:44:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159844;
        bh=Uz234EuBCjuBx6OoxFSEzYWl3aQoeDidRKVMhd2S+v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dhg5oGo7fLla1KJ2apO4B0vr6swmSsokjeSQkHgo/2J0BAx+oMHI2o0rTcM6wKzAS
         3jbxOgJh999yU2lwKpvGjuFaaqCLc4UwzeACIvWkSfkSbcon6gGzVjdZ7Nj8DORfcI
         fLy/fSSDZokIDolBoVCDnj/qUU7f1m2wnzduo0qu1srKvzKqwr3fOtwSLNHfxpNTh5
         BJhCQr1AqP7cVpu9YsLJ863YrYRKd0bO90MaJWc5zmD2jmAleW904w0beBRQnO3rkp
         Zm/DjUtBk7cmHZGXhFhDTBZPHv3OEJCShJqsZOwMnaAlY5ZWSMH38S2SUXM5sd4zoI
         VEb0KC1ugA0rw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 13/16] arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
Date:   Thu, 23 Feb 2023 14:43:42 +0100
Message-Id: <20230223134345.82625-14-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
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
index 8fc527570791..6767bac3f69e 100644
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
2.39.2

