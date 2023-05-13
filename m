Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF47017AD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 16:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbjEMOR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbjEMOR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 10:17:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7E2133;
        Sat, 13 May 2023 07:17:24 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHFLD005710;
        Sat, 13 May 2023 09:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683987435;
        bh=D/yrkRtaQG65/BSegW5ZEtJsd5ONLr9YlIcTdwDVxsg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ksxrYLJWNgsSndk1DG43ce1JB+HWv5gKqTe/FZlxp08VI/JYqGTA0Plq3n874btZ9
         GXgIv6UChvSCVNLVqMrPOb9ficN5G/J1wgeMhWmzQPAhEPIOdxS1tdgWuNPvA20vch
         olbXeg+3nIEH9VGGrCZQhSyQK6sENYuvakLoUZ1A=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DEHF0x128632
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 09:17:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 09:17:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 09:17:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DEHEBe056450;
        Sat, 13 May 2023 09:17:14 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 1/6] arm64: dts: ti: k3-j721e: Describe OSPI and QSPI flash partition info
Date:   Sat, 13 May 2023 19:47:07 +0530
Message-ID: <20230513141712.27346-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513141712.27346-1-vaishnav.a@ti.com>
References: <20230513141712.27346-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe OSPI and QSPI flash partition information through device tree,
this helps to remove passing partition information through the mtdparts
commandline parameter which requires maintaining the partition information
in a string format. J721E SoM has a MT35 64 MiB OSPI flash and  MT25 64 MiB
QSPI flash both with sector size of 128 KiB thus the size of the smallest
partition is chosen as 128KiB, the partition names and offsets are chosen
according to the corresponding name and offsets in bootloader.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 46 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   | 46 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index c11c092c1ce0..b6c8d2f1e460 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -512,6 +512,52 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "qspi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "qspi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "qspi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "qspi.env";
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "qspi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@6c0000 {
+				label = "qspi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "qspi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fe0000 {
+				label = "qspi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+			};
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e289d5b44356..1472c11d6660 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -182,6 +182,52 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x0 0x80000>;
+			};
+
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x80000 0x200000>;
+			};
+
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x20000>;
+			};
+
+			partition@6a0000 {
+				label = "ospi.env.backup";
+				reg = <0x6a0000 0x20000>;
+			};
+
+			partition@6c0000 {
+				label = "ospi.sysfw";
+				reg = <0x6c0000 0x100000>;
+			};
+
+			partition@800000 {
+				label = "ospi.rootfs";
+				reg = <0x800000 0x37c0000>;
+			};
+
+			partition@3fe0000 {
+				label = "ospi.phypattern";
+				reg = <0x3fe0000 0x20000>;
+			};
+		};
 	};
 };
 
-- 
2.17.1

