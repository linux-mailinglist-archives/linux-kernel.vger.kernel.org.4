Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB76034B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJRVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJRVPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:46 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B28E0FF;
        Tue, 18 Oct 2022 14:15:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFcuk079163;
        Tue, 18 Oct 2022 16:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127738;
        bh=SzSCIjFSyDevJ5u2FZeVzuQFI/im3txyQBcW8fq5/iM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m3f4mup663uL58iMdRIVGWe5hjK0NrbxzbrvvKLnb0TAnR/OWm5qi9MJQe9wP3Uae
         sit/3R+eSEQnWSO1YKadJnk9OaN5dXzCVPp3qxa+g57A+XzEXQ7AewBrSU13DEQuB5
         +S1XoEBdJ10CNCua5sqe+dC0JAs4TgbGdfXFLpyU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFbnu014783
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:37 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoG014456;
        Tue, 18 Oct 2022 16:15:37 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 06/10] arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
Date:   Tue, 18 Oct 2022 16:15:29 -0500
Message-ID: <20221018211533.21335-7-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
References: <20221018211533.21335-1-afd@ti.com>
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
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 197d329a6082..318ec805ff54 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -353,8 +353,7 @@ &sdhci1 {
 
 &cpsw3g {
 	pinctrl-names = "default";
-	pinctrl-0 = <&main_mdio1_pins_default
-		     &main_rgmii1_pins_default
+	pinctrl-0 = <&main_rgmii1_pins_default
 		     &main_rgmii2_pins_default>;
 };
 
@@ -369,6 +368,9 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mdio1_pins_default>;
+
 	cpsw3g_phy0: ethernet-phy@0 {
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
-- 
2.37.3

