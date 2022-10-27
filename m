Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6415360EFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiJ0GCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiJ0GCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:02:07 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96C815626C;
        Wed, 26 Oct 2022 23:01:55 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout4.routing.net (Postfix) with ESMTP id 308E81009A7;
        Thu, 27 Oct 2022 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666850514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2ZE/qIsyIboT5rUi20tqGS1dAa2vfhMvGcGE1QuP94=;
        b=xu/80XHq712kMldqEFAn77AXFGc4ltrRt3kBabQFKFon+p76ogbIbTgv8EbYLwHF+CVWcc
        fVSlml6uTxMuLRcbotWh6YM1ASTrCza+naipI+WXjITDLdn6f6uY7/11J9X8WcqqeYdrTQ
        QIm1JxKe7hDef8RRtCUT4axQnDPq4HI=
Received: from frank-G5.. (fttx-pool-80.245.77.6.bambit.de [80.245.77.6])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 75228405D6;
        Thu, 27 Oct 2022 06:01:53 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: mt7986: add PCIe nodes to BananaPi-R3
Date:   Thu, 27 Oct 2022 08:01:42 +0200
Message-Id: <20221027060142.6354-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027060142.6354-1-linux@fw-web.de>
References: <20221027060142.6354-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f1260125-602d-462f-afe8-10e90a54aa61
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
index fc100c3a6415..8eb7079cf6d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtsi
@@ -181,6 +181,16 @@ &i2c0 {
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
@@ -247,6 +257,13 @@ conf-rst {
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

