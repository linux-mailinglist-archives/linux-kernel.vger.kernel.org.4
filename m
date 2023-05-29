Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C131715183
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjE2WKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjE2WJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:09:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF6D9;
        Mon, 29 May 2023 15:09:57 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9g9J083735;
        Mon, 29 May 2023 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685398182;
        bh=4GoX22drmO73L8E/GXzSJcPn8z0nW5KE05z3F6JvHOA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H6P4SID8SFe1P4qEuT7B6oBwWms+C4SrQHEWRwZ8iVGFtutRvWco0pUzhZqE3yWGX
         eVmkzWHWWJlFb6t9DATLVIN8w62gykXaRc057fuMBKrLhyJCEndo1TlXu+RezaHyfC
         8oVnOc43ccEwnoWda2TlvtZJK4PjderynTTyopgM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34TM9gYD000485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 May 2023 17:09:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 May 2023 17:09:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 May 2023 17:09:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9fep022028;
        Mon, 29 May 2023 17:09:42 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j721s2-main: Add R5F and C7x remote processsor nodes
Date:   Mon, 29 May 2023 17:09:39 -0500
Message-ID: <20230529220941.10801-2-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230529220941.10801-1-hnagalla@ti.com>
References: <20230529220941.10801-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The J721S2 SoCs have 2 dual-core Arm Cortex-R5F processor (R5FSS)
subsystems/clusters in MAIN voltage domain. Each of these can be
configured at boot time to be either run in a LockStep mode or in an
Asymmetric Multi Processing (AMP) fashion in Split-mode. These
subsystems have 64 KB each Tightly-Coupled Memory (TCM) internal
memories for each core split between two banks - ATCM and BTCM
(further interleaved into two banks). The TCMs of both Cores are
combined in LockStep-mode to provide a larger 128 KB of memory, but
otherwise are functionally similar to those on J721E SoCs.

Add the DT nodes for the MAIN domain R5F cluster/subsystems, the two
R5F cores are added as child nodes to each of the R5F cluster nodes.
The clusters are configured to run in LockStep mode by default, with
the ATCMs enabled to allow the R5 cores to execute code from DDR
with boot-strapping code from ATCM. The inter-processor communication
between the main A72 cores and these processors is achieved through
shared memory and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if desired:
        MAIN R5FSS0 Core0: j721s2-main-r5f0_0-fw (both in LockStep & Split modes)
        MAIN R5FSS0 Core1: j721s2-main-r5f0_1-fw (needed only in Split mode)
        MAIN R5FSS1 Core0: j721s2-main-r5f1_0-fw (both in LockStep & Split modes)
        MAIN R5FSS1 Core1: j721s2-main-r5f1_1-fw (needed only in Split mode)

The K3 J721S2 SoCs have two C71x DSP subsystems in MAIN voltage domain. The
C71x DSPs are 64 bit machine with fixed and floating point DSP operations.
Similar to the R5F remote cores, the inter-processor communication
between the main A72 cores and these DSP cores is achieved through
shared memory and Mailboxes.

The following firmware names are used by default for these DSP cores,
and can be overridden in a board dts file if desired:
        MAIN C71_0 : j721s2-c71_0-fw
        MAIN C71_1 : j721s2-c71_1-fw

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 128 +++++++++++++++++----
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 2dd7865f7654..361aa6b24b22 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -463,7 +463,6 @@ mailbox0_cluster0: mailbox@31f80000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -473,7 +472,6 @@ mailbox0_cluster1: mailbox@31f81000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -483,7 +481,6 @@ mailbox0_cluster2: mailbox@31f82000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -493,7 +490,6 @@ mailbox0_cluster3: mailbox@31f83000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -503,7 +499,6 @@ mailbox0_cluster4: mailbox@31f84000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -513,7 +508,6 @@ mailbox0_cluster5: mailbox@31f85000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -523,7 +517,6 @@ mailbox0_cluster6: mailbox@31f86000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -533,7 +526,6 @@ mailbox0_cluster7: mailbox@31f87000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -543,7 +535,6 @@ mailbox0_cluster8: mailbox@31f88000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -553,7 +544,6 @@ mailbox0_cluster9: mailbox@31f89000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -563,7 +553,6 @@ mailbox0_cluster10: mailbox@31f8a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -573,7 +562,6 @@ mailbox0_cluster11: mailbox@31f8b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster0: mailbox@31f90000 {
@@ -583,7 +571,6 @@ mailbox1_cluster0: mailbox@31f90000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster1: mailbox@31f91000 {
@@ -593,7 +580,6 @@ mailbox1_cluster1: mailbox@31f91000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster2: mailbox@31f92000 {
@@ -603,7 +589,6 @@ mailbox1_cluster2: mailbox@31f92000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster3: mailbox@31f93000 {
@@ -613,7 +598,6 @@ mailbox1_cluster3: mailbox@31f93000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster4: mailbox@31f94000 {
@@ -623,7 +607,6 @@ mailbox1_cluster4: mailbox@31f94000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster5: mailbox@31f95000 {
@@ -633,7 +616,6 @@ mailbox1_cluster5: mailbox@31f95000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster6: mailbox@31f96000 {
@@ -643,7 +625,6 @@ mailbox1_cluster6: mailbox@31f96000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster7: mailbox@31f97000 {
@@ -653,7 +634,6 @@ mailbox1_cluster7: mailbox@31f97000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster8: mailbox@31f98000 {
@@ -663,7 +643,6 @@ mailbox1_cluster8: mailbox@31f98000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster9: mailbox@31f99000 {
@@ -673,7 +652,6 @@ mailbox1_cluster9: mailbox@31f99000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster10: mailbox@31f9a000 {
@@ -683,7 +661,6 @@ mailbox1_cluster10: mailbox@31f9a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		mailbox1_cluster11: mailbox@31f9b000 {
@@ -693,7 +670,6 @@ mailbox1_cluster11: mailbox@31f9b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
-			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
@@ -1102,4 +1078,108 @@ main_spi7: spi@2170000 {
 		clocks = <&k3_clks 346 1>;
 		status = "disabled";
 	};
+
+	main_r5fss0: r5fss@5c00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5c00000 0x00 0x5c00000 0x20000>,
+			 <0x5d00000 0x00 0x5d00000 0x20000>;
+		power-domains = <&k3_pds 277 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss0_core0: r5f@5c00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5c00000 0x00010000>,
+			      <0x5c10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <279>;
+			ti,sci-proc-ids = <0x06 0xff>;
+			resets = <&k3_reset 279 1>;
+			firmware-name = "j721s2-main-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss0_core1: r5f@5d00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5d00000 0x00010000>,
+			      <0x5d10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <280>;
+			ti,sci-proc-ids = <0x07 0xff>;
+			resets = <&k3_reset 280 1>;
+			firmware-name = "j721s2-main-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	main_r5fss1: r5fss@5e00000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5e00000 0x00 0x5e00000 0x20000>,
+			 <0x5f00000 0x00 0x5f00000 0x20000>;
+		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
+
+		main_r5fss1_core0: r5f@5e00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5e00000 0x00010000>,
+			      <0x5e10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <281>;
+			ti,sci-proc-ids = <0x08 0xff>;
+			resets = <&k3_reset 281 1>;
+			firmware-name = "j721s2-main-r5f1_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		main_r5fss1_core1: r5f@5f00000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x5f00000 0x00010000>,
+			      <0x5f10000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <282>;
+			ti,sci-proc-ids = <0x09 0xff>;
+			resets = <&k3_reset 282 1>;
+			firmware-name = "j721s2-main-r5f1_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
+
+	c71_0: dsp@64800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x64800000 0x00 0x00080000>,
+		      <0x00 0x64e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <8>;
+		ti,sci-proc-ids = <0x30 0xff>;
+		resets = <&k3_reset 8 1>;
+		firmware-name = "j721s2-c71_0-fw";
+	};
+
+	c71_1: dsp@65800000 {
+		compatible = "ti,j721s2-c71-dsp";
+		reg = <0x00 0x65800000 0x00 0x00080000>,
+		      <0x00 0x65e00000 0x00 0x0000c000>;
+		reg-names = "l2sram", "l1dram";
+		ti,sci = <&sms>;
+		ti,sci-dev-id = <11>;
+		ti,sci-proc-ids = <0x31 0xff>;
+		resets = <&k3_reset 11 1>;
+		firmware-name = "j721s2-c71_1-fw";
+	};
 };
-- 
2.34.1

