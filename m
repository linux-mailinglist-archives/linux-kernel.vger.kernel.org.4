Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2D61514E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKASJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiKASJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:09:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22211D0E4;
        Tue,  1 Nov 2022 11:09:43 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1I9ZVJ066875;
        Tue, 1 Nov 2022 13:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667326175;
        bh=sYCY33KPfAH2okxd/wuioVGmv9vi3bO3eoM0E9eu7Qw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hrC56V3f3JOjBbj3VectN8+wdF7LeGXO91v6A88Kj0UJ/7nFhl1tJmSnwrxwcRpsL
         HlFIjkuZ3P4YJqJr1ZKfPe+KV2GhkmfqB8XGjaaYhI7k9xuvRxzQvnHCV5T7lGnRxa
         CUvVDRQG9DgEa2RVJO8hIulUBblnUHNl4uXTZ5NI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1I9ZjT104244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 13:09:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 13:09:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 13:09:35 -0500
Received: from maitri.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1I9ZVo008602;
        Tue, 1 Nov 2022 13:09:35 -0500
From:   Vibhore Vardhan <vibhore@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH RESEND 3/5] arm64: dts: ti: k3-am625: Introduce operating-points table
Date:   Tue, 1 Nov 2022 13:09:33 -0500
Message-ID: <20221101180935.139268-4-vibhore@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101180935.139268-1-vibhore@ti.com>
References: <20221101180935.139268-1-vibhore@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Introduce an operating-points table for the A53 cores, containing only
frequency values as this platform operates on a fixed voltage for the
CPUs. Also provide opp-supported-hw values to ensure appropriate OPPs
are enabled based on which type of silicon is in use.

The latency between pre and post frequency transition was measured in
CPUFreq driver for all combinations of OPP changes. The average value
was selected as overall clock-latency-ns.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625.dtsi | 51 ++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index 887f31c23fef..cea2cc7de5dd 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -48,6 +48,8 @@ cpu0: cpu@0 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 135 0>;
 		};
 
 		cpu1: cpu@1 {
@@ -62,6 +64,8 @@ cpu1: cpu@1 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 136 0>;
 		};
 
 		cpu2: cpu@2 {
@@ -76,6 +80,8 @@ cpu2: cpu@2 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 137 0>;
 		};
 
 		cpu3: cpu@3 {
@@ -90,6 +96,51 @@ cpu3: cpu@3 {
 			d-cache-line-size = <64>;
 			d-cache-sets = <128>;
 			next-level-cache = <&L2_0>;
+			operating-points-v2 = <&a53_opp_table>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
+	a53_opp_table: opp-table {
+		compatible = "operating-points-v2-ti-cpu";
+		opp-shared;
+		syscon = <&wkup_conf>;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-supported-hw = <0x01 0x0007>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-supported-hw = <0x01 0x0006>;
+			clock-latency-ns = <6000000>;
+		};
+
+		opp-1250000000 {
+			opp-hz = /bits/ 64 <1250000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+			opp-suspend;
 		};
 	};
 
-- 
2.34.1

