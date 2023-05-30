Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFE716A51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjE3Q7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjE3Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF71BB;
        Tue, 30 May 2023 09:59:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1C0078896;
        Tue, 30 May 2023 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465941;
        bh=4gn1Y1axDwPcp4yCiCd3/DbPmXvRmM/JOIwTs6g1ZGI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cAAW5I49mpN3ZOSGQz8+tokukQQDv+9j7inSmPzgue64XjEDrx0PsMjwzYa17cyiQ
         THkJ18gfzLiNF6k4UTDP+stnt4HdC4uT38YQ02NeMuR6LAJY2cWvLEYGjSPnotp7TD
         v+dZ9yaOqiHLJGhEFM/KVLPqI5FO8r6hkhPdsNZc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGx1rr015713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:59:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:59:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:59:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx15J036764;
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
Subject: [PATCH 3/7] arm64: dts: ti: k3-am65-mcu: Add mcu_secproxy
Date:   Tue, 30 May 2023 11:58:56 -0500
Message-ID: <20230530165900.47502-4-nm@ti.com>
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

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index c5bf7a0d6279..badb1ee8f60d 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -227,6 +227,21 @@ mcu_udmap: dma-controller@285c0000 {
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
 	m_can0: can@40528000 {
 		compatible = "bosch,m_can";
 		reg = <0x0 0x40528000 0x0 0x400>,
-- 
2.40.0

