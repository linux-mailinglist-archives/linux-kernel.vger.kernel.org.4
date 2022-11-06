Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5601761E10E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiKFIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiKFIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:50:50 -0500
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AADF60;
        Sun,  6 Nov 2022 01:50:47 -0700 (PDT)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout2.routing.net (Postfix) with ESMTP id 7C7365FF40;
        Sun,  6 Nov 2022 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1667724646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWv16uoFOb6bItdqVi9OeYNnzGyV0xjUXLKdhVz8KGs=;
        b=hpZ5+Tn7KBcpoPDAZ/XeZBAhLzcJUC8XYQOxJRCzxkLPH05hQlnAzQMPebnHEkI9sNrnLz
        OU+srMGfTWpM5w2qxBzQpaDuRpvDcadWiwV2sBfbvO5BO2XCWV2R9EzXruvmAOZ0BgkSDZ
        0g40hdrFnZxquINAlSmFtxwveMwnQV4=
Received: from frank-G5.. (fttx-pool-80.245.79.199.bambit.de [80.245.79.199])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id ED25936054A;
        Sun,  6 Nov 2022 08:50:45 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v3 10/11] arm64: dts: mt7986: add PCIe nodes to BananaPi-R3
Date:   Sun,  6 Nov 2022 09:50:33 +0100
Message-Id: <20221106085034.12582-11-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106085034.12582-1-linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 3b59d6be-ad3e-472f-8b86-c55df8f8e314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add PCIe nodes to Banana Pi R3 SBC which is used on M.2 slot.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
index 93ac67641351..01f92db3336a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
@@ -195,6 +195,16 @@ &i2c0 {
 	status = "okay";
 };
 
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie_pins>;
+	status = "okay";
+};
+
+&pcie_phy {
+	status = "okay";
+};
+
 &pio {
 	i2c_pins: i2c-pins {
 		mux {
@@ -261,6 +271,13 @@ conf-rst {
 		};
 	};
 
+	pcie_pins: pcie-pins {
+		mux {
+			function = "pcie";
+			groups = "pcie_clk", "pcie_pereset";
+		};
+	};
+
 	spi_flash_pins: spi-flash-pins {
 		mux {
 			function = "spi";
-- 
2.34.1

