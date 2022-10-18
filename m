Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6206034C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiJRVQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiJRVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED616A0337;
        Tue, 18 Oct 2022 14:15:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFbrG079158;
        Tue, 18 Oct 2022 16:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127737;
        bh=oUAiC9a0tPyW9tCWEGQM0nDGXxOWwM6AJ3+9c/hbOgg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Una7/K+048+NKLpv+tng4rantg5it+7D33ikW/7jLr/0fFPGS/7cubefG7rZ/G8dz
         ULjHVPEG9dvwE2JXeHBTCq0ImqjRP5OV3+YyTKwrVCWmitPs40gPpa04Cn7TEmoj62
         CGaH1e1x7nojcsfGjmjTrY267cr8B7D10BN+yoFI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFaCx014767
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:36 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:36 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoE014456;
        Tue, 18 Oct 2022 16:15:36 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 04/10] arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
Date:   Tue, 18 Oct 2022 16:15:27 -0500
Message-ID: <20221018211533.21335-5-afd@ti.com>
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

EPWM nodes defined in the top-level AM62x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the EPWM nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi |  3 +++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 12 ------------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 83ac2e45998d..a0d24faa6833 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -612,6 +612,7 @@ epwm0: pwm@23000000 {
 		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 0>, <&k3_clks 86 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm1: pwm@23010000 {
@@ -621,6 +622,7 @@ epwm1: pwm@23010000 {
 		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 1>, <&k3_clks 87 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm2: pwm@23020000 {
@@ -630,5 +632,6 @@ epwm2: pwm@23020000 {
 		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 2>, <&k3_clks 88 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index c280d6c00412..4086d61807ab 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -465,15 +465,3 @@ &ecap2 {
 &main_mcan0 {
 	status = "disabled";
 };
-
-&epwm0 {
-	status = "disabled";
-};
-
-&epwm1 {
-	status = "disabled";
-};
-
-&epwm2 {
-	status = "disabled";
-};
-- 
2.37.3

