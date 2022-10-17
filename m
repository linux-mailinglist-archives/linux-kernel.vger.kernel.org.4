Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F6660179F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiJQT1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJQT0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:23 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2702D7694B;
        Mon, 17 Oct 2022 12:26:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPbsZ017209;
        Mon, 17 Oct 2022 14:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034737;
        bh=7vbT7euG7sHbzeQT/divmM/JGZRD4V4WSC4+kSyUDEs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nAf/IxiwfSgV3eHUe9Czh/4mWXvsUPvqA6PuG4VieoctjEsij++PFsz8ID6lwwJ9y
         PFu4tTge1qNacdPOzFZmczoAlv9+bJ2y2es8B4g/dt71C97FrJKDQ3DZeqEYFmvElt
         hyx9FsGKaIfzXOx/0lZF5CSr46zIYqNKI1LASd5Q=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPb7M083460
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:37 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:36 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXO026106;
        Mon, 17 Oct 2022 14:25:36 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 07/10] arm64: dts: ti: k3-am64: MDIO pinmux should belong to the MDIO node
Date:   Mon, 17 Oct 2022 14:25:29 -0500
Message-ID: <20221017192532.23825-8-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although usually integrated as a child of an Ethernet controller, MDIO
IP has an independent pinout. This pinout should be controlled by
the MDIO node (so if it was to be disabled for instance, the pinmux
state would reflect that).

Move the MDIO pins pinmux to the MIDO nodes.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts | 6 ++++--
 arch/arm64/boot/dts/ti/k3-am642-sk.dts  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 2dec25d90240..2319ba4f5ae3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -425,8 +425,7 @@ &usb0 {
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mdio1_pins_default
-		     &rgmii1_pins_default
+	pinctrl-0 = <&rgmii1_pins_default
 		     &rgmii2_pins_default>;
 };
 
@@ -441,6 +440,9 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio1_pins_default>;
+
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 58c71608d925..c1d634647027 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -439,8 +439,7 @@ &usb0 {
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mdio1_pins_default
-		     &rgmii1_pins_default
+	pinctrl-0 = <&rgmii1_pins_default
 		     &rgmii2_pins_default>;
 };
 
@@ -455,6 +454,9 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mdio1_pins_default>;
+
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-- 
2.37.3

