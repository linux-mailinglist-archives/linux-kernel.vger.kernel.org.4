Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF266982D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241852AbjAMNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbjAMNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:14:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474393DBEA;
        Fri, 13 Jan 2023 05:02:25 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78BC96602DCE;
        Fri, 13 Jan 2023 13:02:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673614943;
        bh=aUvLM57s+KTS0WmTxnw9kmbSx3nApfm7x7mEcHDukc4=;
        h=From:To:Cc:Subject:Date:From;
        b=XotrLTm9CYAR/t5hVtLKuAv5CZShy4EckmylSTvmqv/amMZo08lSKAiotiAt4Lwqu
         R6kTQA8Fwq+8ARRXaaKTSb5531dS1g/tTEA0JAvK/VDBIb6pLWls3i9SQCto2CcDLJ
         mDJhIb3P+7uGvx4u/5XYqTRMMCvlu9OTbiUwQ5mPzB3O1yQio2qLNmonPRi4EDnkwf
         pIvbDD7aWBhkG8is5iWIwiTzbc1hUUe5cqWqVq7oYLumVTnY5YfASAXRVx5krV4phW
         SmVM5tQC2R0DUxN8x3qu5GDi7AD9/aXroY+FMptnsHe/BPEO0pwb4T1KQYYUBJErFx
         1xgFhe15vJCng==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH] arm64: dts: rockchip: Fix RX delay for ethernet phy
Date:   Fri, 13 Jan 2023 13:02:20 +0000
Message-Id: <20230113130220.662194-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.0
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

Add network PHY rx delay and change type to rgmii, so
that it is applied. This fixes packet loss when more
than a few packets are exchanged.

Fixes: 55fa4c2a7a912 ("arm64: dts: rockchip: Add rock-5a board")
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index cc4c68936b3a..9e22ce01e1a3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -53,7 +53,7 @@ vcc_1v1_nldo_s3: vcc-1v1-nldo-s3 {
 &gmac1 {
 	clock_in_out = "output";
 	phy-handle = <&rgmii_phy1>;
-	phy-mode = "rgmii-rxid";
+	phy-mode = "rgmii";
 	pinctrl-0 = <&gmac1_miim
 		     &gmac1_tx_bus2
 		     &gmac1_rx_bus2
@@ -61,6 +61,7 @@ &gmac1_rgmii_clk
 		     &gmac1_rgmii_bus>;
 	pinctrl-names = "default";
 	tx_delay = <0x3a>;
+	rx_delay = <0x3e>;
 	status = "okay";
 };
 
-- 
2.39.0

