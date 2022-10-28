Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A98B61147B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiJ1OYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C5E78;
        Fri, 28 Oct 2022 07:24:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOL3k026556;
        Fri, 28 Oct 2022 09:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967061;
        bh=wR7WtVfUk3Wy5tBENQDtrurWBf3f7bKdDuZQXhqJOp0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OVTyWNjBDQGQuW+udEoKf6PDm+gcmwnwgEZzK3TZwihGDRAIm5gkuBsmeAtp8JcDT
         7uZ8MxB4vS71pEvtRaEP3/7SyuFsA+sJ2E0Lf0p7JJWg8iw7qu8GvV4mvnAeI1LEFV
         Qpt4usodYVA1tFzM3xVjPu4wNbijPix/7SIwXniU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOLw8062530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:21 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:21 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfT039275;
        Fri, 28 Oct 2022 09:24:20 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 04/11] arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:10 -0500
Message-ID: <20221028142417.10642-5-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EPWM nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the EPWM nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 74fd807d47396..49287f8493aea 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -886,6 +886,7 @@ ehrpwm0: pwm@3000000 {
 		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 40 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm1: pwm@3010000 {
@@ -895,6 +896,7 @@ ehrpwm1: pwm@3010000 {
 		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 41 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm2: pwm@3020000 {
@@ -904,6 +906,7 @@ ehrpwm2: pwm@3020000 {
 		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 42 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm3: pwm@3030000 {
@@ -913,6 +916,7 @@ ehrpwm3: pwm@3030000 {
 		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 43 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm4: pwm@3040000 {
@@ -922,6 +926,7 @@ ehrpwm4: pwm@3040000 {
 		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 44 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ehrpwm5: pwm@3050000 {
@@ -931,6 +936,7 @@ ehrpwm5: pwm@3050000 {
 		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 45 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	icssg0: icssg@b000000 {
-- 
2.37.3

