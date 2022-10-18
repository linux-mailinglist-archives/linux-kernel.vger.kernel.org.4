Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3B6034B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiJRVP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJRVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD349187D;
        Tue, 18 Oct 2022 14:15:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFbSm108211;
        Tue, 18 Oct 2022 16:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127737;
        bh=0hUB0nOzolNzgGjxTg0wUcFoLZfW21uga6DGB8i0hco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UpA2dpESHGg+ts44ZgEHA39pHYlkWLcOT2Po1rm1sJkjTJRmKwVjZAXCexfwUC9KA
         qtR1cJOxKhgxwfFBI5k91smqPt1EM/hlNiHLHUrXI5Oiu2L3f9J8bbpCtr0wdMvgBA
         bKpC6dgSJfdfHOU6MLXiAwWuezKz9ffyvwrzG56M=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFbnC005831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:37 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:37 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoF014456;
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
Subject: [PATCH 05/10] arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
Date:   Tue, 18 Oct 2022 16:15:28 -0500
Message-ID: <20221018211533.21335-6-afd@ti.com>
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

ECAP nodes defined in the top-level AM62x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information. (These and the EPWM nodes could be used to trigger internal
actions but they are not used like that currently)

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the ECAP nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi |  3 +++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 12 ------------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index a0d24faa6833..a580867e68b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -571,6 +571,7 @@ ecap0: pwm@23100000 {
 		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 51 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	ecap1: pwm@23110000 {
@@ -580,6 +581,7 @@ ecap1: pwm@23110000 {
 		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 52 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	ecap2: pwm@23120000 {
@@ -589,6 +591,7 @@ ecap2: pwm@23120000 {
 		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 53 0>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_mcan0: can@20701000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 4086d61807ab..197d329a6082 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -450,18 +450,6 @@ partition@3fc0000 {
 	};
 };
 
-&ecap0 {
-	status = "disabled";
-};
-
-&ecap1 {
-	status = "disabled";
-};
-
-&ecap2 {
-	status = "disabled";
-};
-
 &main_mcan0 {
 	status = "disabled";
 };
-- 
2.37.3

