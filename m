Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFA6034C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiJRVQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJRVQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:16:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5846A2A93;
        Tue, 18 Oct 2022 14:15:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFecf082469;
        Tue, 18 Oct 2022 16:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127740;
        bh=3IsH6Uh5nGZSI6pn3ILDYTpsGnWct90hMlObYyhQ/DU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WFS4qzFDCQjrLPoQRQ0tWb4ikTAmIE6qYdksgUV6tUSMYXJPZrPG44eY9+lSdye9s
         do9KKxHuGi5YObbDb5NCwAicGcil7xABjzY0A4KPvI3TXkphjwwwLD/H0Mkro6+MzU
         hGmcl4QHOKw+hMVpI5B1uvTff4cmsuyUf3tTcUlw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFeph014162
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:39 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoK014456;
        Tue, 18 Oct 2022 16:15:39 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 10/10] arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level
Date:   Tue, 18 Oct 2022 16:15:33 -0500
Message-ID: <20221018211533.21335-11-afd@ti.com>
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

OSPI nodes defined in the top-level AM62x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the OSPI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 5a2cd474a761..0d04176498fa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -479,6 +479,7 @@ ospi0: spi@fc40000 {
 			power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 3c98b639b0b2..18ca56cedc63 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -397,6 +397,7 @@ mbox_m4_0: mbox-m4-0 {
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ospi0_pins_default>;
 
-- 
2.37.3

