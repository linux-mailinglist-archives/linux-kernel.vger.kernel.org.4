Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CC768ED3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBHKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjBHKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:45:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D40474F8;
        Wed,  8 Feb 2023 02:45:39 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EEA3660209A;
        Wed,  8 Feb 2023 10:45:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675853138;
        bh=q6sTRzzpp6l1Y7FFoNdLPC+xxTx63E74abBtY/8WPTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx8JW+uKpa4vJ4cTBiKbg9MOdA1JWYQtQ4xajYxH7ddT1fiVIpZwavll8AzKGxjSb
         ApatJ7ZzvrOWRaKal/1gJkIJTrxoIxQCDwsmWt9wvr2JpfVrK9s2nhof7GUbBbDae+
         3GeCn1eHCFvQe2mksa0/3dGZen4u+GIf5CXVRA0ul51VCJCAqLbqv55kYDhWeO+Puw
         L4/362ubdORsOjUsmWvH9ZSl0ZaRaBHmLUhe+oiRdoTktkWbVpi7Akrj4602x9Er7K
         sgtkJJerSWGYhpTnKoyaYE3z6wQtWEIeIQIoyu3B2SbMP8uzHj1XCPfiQUfrPSjDcn
         B6XbAOk4nabcQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 04/16] arm64: dts: mt8183-pumpkin: Couple VGPU and VSRAM_GPU regulators
Date:   Wed,  8 Feb 2023 11:45:15 +0100
Message-Id: <20230208104527.118929-5-angelogioacchino.delregno@collabora.com>
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

Add coupling for these regulators, as they have a strict voltage output
relation to satisfy in order to ensure GPU stable operation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index a1d01639df30..c228f04d086b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -71,7 +71,6 @@ &auxadc {
 
 &gpu {
 	mali-supply = <&mt6358_vgpu_reg>;
-	sram-supply = <&mt6358_vsram_gpu_reg>;
 };
 
 &i2c0 {
@@ -176,6 +175,16 @@ &mmc1 {
 	non-removable;
 };
 
+&mt6358_vgpu_reg {
+	regulator-coupled-with = <&mt6358_vsram_gpu_reg>;
+	regulator-coupled-max-spread = <100000>;
+};
+
+&mt6358_vsram_gpu_reg {
+	regulator-coupled-with = <&mt6358_vgpu_reg>;
+	regulator-coupled-max-spread = <100000>;
+};
+
 &pio {
 	i2c_pins_0: i2c0 {
 		pins_i2c{
-- 
2.39.1

