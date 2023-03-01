Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4606A6A3F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCAJ4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCAJzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BBC392AA;
        Wed,  1 Mar 2023 01:55:37 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 297D266020E6;
        Wed,  1 Mar 2023 09:55:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664536;
        bh=8ABzLk/e2rpCHLt16uUykksCJa8zFaozhbox7sQgQPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDpdAPcLUUkMKSd2i4Ita4lKN0g2OI5VS3BvB09Q+chWNGVMOPpOideIk7LMs2dOh
         t9S0/fbLiYZlvn/1nWgCxRtObYrN7joVanRPx3d3XfYQIIVldT1WR03TvG+rRQR4ov
         ORAyPsPsrNJ98qutjZrriNituD7SbYQ+wOFnFC/AVwuob4qxVfZu1UT2BmekH03S2i
         MUsUIMOi163XelGIj5nurZcdFZlyaS1KcTnuYtvl2RUyJhMvS7lzU7uG8O0lb4bSMn
         PNccE7tZhfPwTjE2wwlCkJrsMtU/CdzkUa4bDG8FOW5aolTbqOoqpsU80/mivtyeKD
         N9dmdIDoDnikA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 11/19] arm64: dts: mediatek: mt8192-asurada: Fix voltage constraint for Vgpu
Date:   Wed,  1 Mar 2023 10:55:15 +0100
Message-Id: <20230301095523.428461-12-angelogioacchino.delregno@collabora.com>
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

The MT8192 SoC specifies a maximum voltage for the GPU's digital supply
of 0.88V and the GPU OPPs are declaring a maximum voltage of 0.80V.

In order to keep the GPU voltage in the safe range, change the maximum
voltage for mt6315@7's vbuck1 to 0.80V as sending, for any mistake,
1.193V would be catastrophic.

Fixes: 3183cb62b033 ("arm64: dts: mediatek: asurada: Add SPMI regulators")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index df477eb89f21..8570b78c04a4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1408,7 +1408,7 @@ mt6315_7_vbuck1: vbuck1 {
 				regulator-compatible = "vbuck1";
 				regulator-name = "Vgpu";
 				regulator-min-microvolt = <606250>;
-				regulator-max-microvolt = <1193750>;
+				regulator-max-microvolt = <800000>;
 				regulator-enable-ramp-delay = <256>;
 				regulator-allowed-modes = <0 1 2>;
 			};
-- 
2.39.2

