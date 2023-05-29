Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408E8715180
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE2WKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2WJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:09:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE44CCD;
        Mon, 29 May 2023 15:09:56 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9gsk003201;
        Mon, 29 May 2023 17:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685398182;
        bh=Run12w0sl7uLPkhoC8xjqaVEeCThtmawJaTZRM6Qils=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vCTER+ywSTC3+le2dJOHDE16wtbg25iarJRErJ+gp3YcyyizhtA90g6Q5+VRR8deL
         MMaOwckNWSwlc9/d0zWTW43RBmiLUVQ7W/BjI86tOQaqOn1IlHcTEypybNXpzPtro/
         AjClVmywbyJwUK53qvkdt3zV6vNGk0wkMtgaInsk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34TM9gjD011322
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 May 2023 17:09:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 May 2023 17:09:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 May 2023 17:09:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34TM9gmE026454;
        Mon, 29 May 2023 17:09:42 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: dts: ti: k3-j721s2-mcu: Add R5F cluster nodes
Date:   Mon, 29 May 2023 17:09:40 -0500
Message-ID: <20230529220941.10801-3-hnagalla@ti.com>
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

The J721S2 SoCs have a dual-core Arm Cortex-R5F processor (R5FSS)
subsystems/cluster in MCU voltage domain. It can be configured at boot
time to be either run in a LockStep mode or in an Asymmetric Multi
Processing (AMP) fashion in Split-mode. These subsystems have 64 KB
each Tightly-Coupled Memory (TCM) internal memories for each core
split between two banks - ATCM and BTCM (further interleaved into
two banks). The TCMs of both Cores are combined in LockStep-mode to
provide a larger 128 KB of memory, but otherwise are functionally
similar to those on J721E SoCs.

Add the DT nodes for the MCU domain R5F cluster/subsystem, the two R5F
cores are added as child nodes to each of the R5F cluster nodes. The
clusters are configured to run in LockStep mode by default, with the
ATCMs enabled to allow the R5 cores to execute code from DDR with
boot-strapping code from ATCM. The inter-processor communication between
the main A72 cores and these processors is achieved through shared memory
and Mailboxes.

The following firmware names are used by default for these cores, and
can be overridden in a board dts file if desired:
        MCU R5FSS0 Core0: j721s2-mcu-r5f0_0-fw (both in LockStep and Split modes)
        MCU R5FSS0 Core1: j721s2-mcu-r5f0_1-fw (needed only in Split mode)

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index a353705a7463..601570f12812 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -379,4 +379,44 @@ adc {
 			compatible = "ti,am3359-adc";
 		};
 	};
+
+	mcu_r5fss0: r5fss@41000000 {
+		compatible = "ti,j721s2-r5fss";
+		ti,cluster-mode = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x41000000 0x00 0x41000000 0x20000>,
+			 <0x41400000 0x00 0x41400000 0x20000>;
+		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
+
+		mcu_r5fss0_core0: r5f@41000000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41000000 0x00010000>,
+			      <0x41010000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <284>;
+			ti,sci-proc-ids = <0x01 0xff>;
+			resets = <&k3_reset 284 1>;
+			firmware-name = "j721s2-mcu-r5f0_0-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+
+		mcu_r5fss0_core1: r5f@41400000 {
+			compatible = "ti,j721s2-r5f";
+			reg = <0x41400000 0x00010000>,
+			      <0x41410000 0x00010000>;
+			reg-names = "atcm", "btcm";
+			ti,sci = <&sms>;
+			ti,sci-dev-id = <285>;
+			ti,sci-proc-ids = <0x02 0xff>;
+			resets = <&k3_reset 285 1>;
+			firmware-name = "j721s2-mcu-r5f0_1-fw";
+			ti,atcm-enable = <1>;
+			ti,btcm-enable = <1>;
+			ti,loczrama = <1>;
+		};
+	};
 };
-- 
2.34.1

