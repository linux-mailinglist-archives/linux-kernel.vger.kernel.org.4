Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89986A571D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjB1Ksf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjB1KsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:48:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432084C1F;
        Tue, 28 Feb 2023 02:47:59 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5FCA46602FDD;
        Tue, 28 Feb 2023 10:47:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677581277;
        bh=KQl+1992t3fzHAo6w7W+uAYOQeZPx/82oAPGoJNpTLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xe9WLaq3kXmjLFR7IiT8Hn40k3Ol8L118xWU7hVeSVN4exhL0sc2fOj2Jp4nMj2+a
         NX74A23spu82s1ciJMsH/zpJy+KeUCWZJaNEibn0Y8gdPy7ZsKDkfWxrk63Qe+LsL1
         UCXX1LqpptivTIk7XN9P0RUhRcEDuAiK33ym1fySxKNHSluWMw4NSA3VUUtXqUafci
         dmpxL9UOO2n0Qhso3myRCSrNAwYeiVxp60pw7fX+HOaQVEWhvRfNyroSHPT/bz4P26
         ruvXorklpLrqC0QTI4JA0F3kdU1gcfMePKiwW/rzpnR3vlf+r2cKIS0ETdjdapwWMd
         rYEZIXaySzjJg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v3 13/18] arm64: dts: mediatek: mt8195: Add mfg_core_tmp clock to MFG1 domain
Date:   Tue, 28 Feb 2023 11:47:36 +0100
Message-Id: <20230228104741.717819-14-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.39.2

