Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94515F53C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiJELkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJELjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:39:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801A785AA;
        Wed,  5 Oct 2022 04:36:23 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE1ED66022F1;
        Wed,  5 Oct 2022 12:35:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664969736;
        bh=Q22qlsylohLOvHhECyt/assrAuDmWPjWk2cOuhRGCXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc6dPw450MLDFyHObUnLsbqsQrO4dPvVuEqNpPlk51PTc5TDJoSjKz06ZTyqc1v92
         ksat8+Bsks9UdmG0UHrQNC6BGTlYFkrUC5FCmyNm+2JIfwiVVH3OBZy2rGC8qxm0wq
         XO6OxPpVcc8x8RWU402+C7UlSV+4y5ozUp8MgSywBKyNa713PVivvOOUXViayN66oV
         X/DMSQNrTZKnzR4DnEq8tH/Ex3dmh1s/jm7sUeOMWy8vD+WTAJqnSUdzBTgctCyP+A
         hQk3RKKdQuA6vB6R+3uzg35DxhfmwGwfKdyYrpgso4LYmkktQwXs+TZzznn0BZTXOI
         k0waW+yM8ecOw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com, tinghan.shen@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] arm64: dts: mediatek: mt8186: Fix watchdog compatible
Date:   Wed,  5 Oct 2022 13:35:13 +0200
Message-Id: <20221005113517.70628-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
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

MT8186's watchdog embeds a reset controller and needs only the
mediatek,mt8186-wdt compatible string as the MT6589 one is there
for watchdogs that don't have any reset controller capability.

Fixes: 2e78620b1350 ("arm64: dts: Add MediaTek MT8186 dts and evaluation board and Makefile")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index 64693c17af9e..e4366144cca5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -330,8 +330,7 @@ pio: pinctrl@10005000 {
 		};
 
 		watchdog: watchdog@10007000 {
-			compatible = "mediatek,mt8186-wdt",
-				     "mediatek,mt6589-wdt";
+			compatible = "mediatek,mt8186-wdt";
 			mediatek,disable-extrst;
 			reg = <0 0x10007000 0 0x1000>;
 			#reset-cells = <1>;
-- 
2.37.2

