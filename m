Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169FC716A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjE3Q7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjE3Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697501BC;
        Tue, 30 May 2023 09:59:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1J3078900;
        Tue, 30 May 2023 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465941;
        bh=8w532hrfkqht2GKxL4AJ0l/5hJ3C/GIlPX4a4Lh46jQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=F4QBxSes86zhD6e7wT249OtJLWg+Hr7dX0fPjNAVZ9xfZ/zSkn5RlYI9asZp/POg1
         JHUgnstUWkWJFbCHnzKvi1rtKAgxVsKwDT/jGkRyi/evawGa0fALFqpTAhQiLKYXWO
         VU2JNH+cRU336jla4FMFiw8kAf8L4bbLAd0TDut8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGx17K029840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:59:01 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:59:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:59:01 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1EO038987;
        Tue, 30 May 2023 11:59:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/7] arm64: dts: ti: k3-j721e-mcu: Add mcu_secproxy
Date:   Tue, 30 May 2023 11:58:58 -0500
Message-ID: <20230530165900.47502-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230530165900.47502-1-nm@ti.com>
References: <20230530165900.47502-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCU domain has it's own secure proxy for communicating with ROM and
for R5 micro controller firmware operations. This is in addition to
the one in the main domain NAVSS subsystem that is used for general
purpose communication.

Describe the node for use with bootloaders and firmware that require
this communication path which uses interrupts to corresponding micro
controller interrupt controller. Mark the node as disabled since this
instance does not have interrupts routed to the main processor by
default for a complete description of the node.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch

 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6237e1f3a477..4ea95ed5d12c 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -296,6 +296,21 @@ mcu_udmap: dma-controller@285c0000 {
 		};
 	};
 
+	secure_proxy_mcu: mailbox@2a480000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x2a480000 0x0 0x80000>,
+		      <0x0 0x2a380000 0x0 0x80000>,
+		      <0x0 0x2a400000 0x0 0x80000>;
+		/*
+		 * Marked Disabled:
+		 * Node is incomplete as it is meant for bootloaders and
+		 * firmware on non-MPU processors
+		 */
+		status = "disabled";
+	};
+
 	mcu_cpsw: ethernet@46000000 {
 		compatible = "ti,j721e-cpsw-nuss";
 		#address-cells = <2>;
-- 
2.40.0

