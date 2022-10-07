Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2165F782A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJGMoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJGMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:44:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2052.outbound.protection.outlook.com [40.107.96.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C18194;
        Fri,  7 Oct 2022 05:44:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmrJv4jOsYYaiqzbWlOEJjaI1kxUBaMvex7//p5hA8jhXJfDAtSXTIDVRy9iuNBIfHJJ6TEjWzAkfa3/aJQhwsJl0uY3nIQPaGLNb965iGk03KbZzLCgCA+U/+YOs60zN2N/dgGHO3CIp1dLnsriAInXBc9OrmCBtxPIfu/Fz6dE35BEMk+vxltiB7SunjE+MK9l8lYyqvlwT0T2iQPV2pVWA1I+RgocI0CO65XqCR8LrZRIgqR1dDY11kzMg9h5z7lpr8HfheSj6r5/G1TtdEHIkvgsFvDSCtmPZ7Ykxiu+i3c7TeGx9p2YRIj8p0h9pmm/lFJM23Wqxw5AllXhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBMfJQK5VYqzncsnWwrN2JKPV7RWnxZm0Nk1LSE8YVs=;
 b=EDYqetQ5w/JxLoMrqDhgk3DP7wgPrjwtBZyowq/eBlZlFH2FHWxNhcAH894rDFrUzscDQPP/6VdbjcznRoWeeiDMttNIeuA/DhYWbKSLo/ZakeyX1MUQ+1BS2kdEZCm8qTaGjsoAW5HPRlo+5yPliCNNYk89ACdUx5Te/JMzEKtW/UrH3BC2cZVqdaEL5prOna2BvnP/d2faS5EgPntOwXtGG9KSXX/1G5yaKWmLtLePi6oKCAWRG4nDKFMy+oa1g3lO8XaaMes0tvZtGEGRSS93Pe1LMaZrbf/PKvC3jlRj/P5DkIL5PN2RGdUtszk2kjMJOmGK0BqIJREM+N44CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBMfJQK5VYqzncsnWwrN2JKPV7RWnxZm0Nk1LSE8YVs=;
 b=bg8CTYpnoLnHZodTb89W2fdc3zsmJtqediHdqN14N/GN4WAsYAtWTWuTUU4aOOxyG7fkAy7m5JzGDyoKNrVBouZ9ObKpxosiZCiqfcnxMNab2lzgrwOAS36tLMeJ3tiQDNHEgJInzg1rfL3OnB5pq3vQ5br48RuGI6OHs61YAxs+NovtM6qCC/R5fab6/Mpfb/oClbVxj0nvSa8VoBGfmpbpLYjvNuL27Bgl9MmGRoGl1t0Ibh7D0Z7R8RjetFOsiwzhpi4OBS1Y2MDY+Jg6ta8b8QCfBXmZFCsOywN+Jog9fwmMv0jIMtWyVFN7L0fx8TwZwlV2jEmC4x2DP6LReQ==
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by BN9PR12MB5148.namprd12.prod.outlook.com (2603:10b6:408:119::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 12:44:31 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::71) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Fri, 7 Oct 2022 12:44:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 12:44:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 05:44:29 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 05:44:29 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 05:44:26 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, <anrao@nvidia.com>
Subject: [PATCH v2] arm64: tegra: Add Tegra234 SDMMC1 device tree node
Date:   Fri, 7 Oct 2022 18:14:24 +0530
Message-ID: <20221007124424.16037-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <80d046b9-ff8c-58dc-d149-e984d509fe5a@linaro.org>
References: <80d046b9-ff8c-58dc-d149-e984d509fe5a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|BN9PR12MB5148:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd8653a-a4ed-44c7-a77f-08daa861ae40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQ+XOxbPnazxTwarBgCSJVuHaxWZIDZXrB7HUjjDxFSpqZsXuCfszzuqCHw5uaySg3qSDxogLGb3W4t08bMX7Tw4a+4O7OfMCmyiaoahG3IXD++I48wDWH3FwE7J16nNNiYWErHULcAM+oR6oTB6smIo2fo8jh/8IuDDxlF/c2OOdwlAhMR0tVa4Mx5g2ib7TT9uSC1iHoWVV2c8891sJ5S0IpZXom9Zwe4tTWGwu2Dhfqn/oDqYih+H3m8i2dMtq6ydz3k7HouEwSlVLxEhM9uiyyghaCpv4KPZP33QN+kAv3HCraHLBbzECs12hAClVAU4ZjTLq8lGwCJn7aRDdM5f1ZhOyWdI1qTJmD5xNTEAHg0jKPS7oeH2uXGsvFRIesY8TTO+2Rw2Uh7t3YWmyaLTm3gOJA6lDxjTbsl/J2a4hhTGcOG7cqcArUbPtDjr0tVpHO1uIHm0GaSMrT8EpGVAPpqXgLXG4atbiGwrIfvLiFiI+VBQJd+wWyoY2CamJpXwKYgT8tQ4zMn2LY+9ApmKm/eT8a/l7CF9OJNsNikhAV0+eXUVGVmZ+Tx+1VeaiTh7vTmWWF2JglfOtmuG1xFGqqDFwN++3S1t9K1CRv1qH0Ev7Pc1lsRPZRW3/qR1h8H8YC+EtQwWjrt06sI5b9E/ZME1BeFK+g3qdr7WiAGy2tmBfZ6y+nDBYvLo1gxUoLtddd4EgQrz9QxRUPTeVt8D/yjfgCyTnHX3oTRdb/Ije2bjUBaDyBseJoL3Zc+Wyw+vK0NtK9JTf7TAePA1QA==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(8676002)(4326008)(110136005)(70206006)(70586007)(54906003)(1076003)(426003)(47076005)(40480700001)(82310400005)(186003)(336012)(86362001)(8936002)(316002)(40460700003)(478600001)(5660300002)(356005)(107886003)(41300700001)(2906002)(26005)(7636003)(83380400001)(36756003)(7696005)(2616005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 12:44:31.3082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd8653a-a4ed-44c7-a77f-08daa861ae40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5148
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for Tegra234 SDMMC1 instance.
Add and enable SD card instance in device tree.

Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  7 +++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 59 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index 9e4d72cfa69f..fe52810e5b9d 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -55,6 +55,13 @@
 			};
 		};
 
+		mmc@3400000 {
+			status = "okay";
+			bus-width = <4>;
+			cd-gpios = <&gpio TEGRA234_MAIN_GPIO(G, 7) GPIO_ACTIVE_LOW>;
+			disable-wp;
+		};
+
 		mmc@3460000 {
 			status = "okay";
 			bus-width = <8>;
diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..0468613e1dfb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/memory/tegra234-mc.h>
 #include <dt-bindings/power/tegra234-powergate.h>
 #include <dt-bindings/reset/tegra234-reset.h>
+#include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
 
 / {
 	compatible = "nvidia,tegra234";
@@ -895,6 +896,45 @@
 			status = "disabled";
 		};
 
+		mmc@3400000 {
+			compatible = "nvidia,tegra194-sdhci", "nvidia,tegra234-sdhci";
+			reg = <0x03400000 0x20000>;
+			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&bpmp TEGRA234_CLK_SDMMC1>,
+				 <&bpmp TEGRA234_CLK_SDMMC_LEGACY_TM>;
+			clock-names = "sdhci", "tmclk";
+			assigned-clocks = <&bpmp TEGRA234_CLK_SDMMC1>,
+					<&bpmp TEGRA234_CLK_PLLC4_MUXED>;
+			assigned-clock-parents =
+					  <&bpmp TEGRA234_CLK_PLLC4_MUXED>,
+					  <&bpmp TEGRA234_CLK_PLLC4_VCO_DIV2>;
+			resets = <&bpmp TEGRA234_RESET_SDMMC1>;
+			reset-names = "sdhci";
+			interconnects = <&mc TEGRA234_MEMORY_CLIENT_SDMMCRA &emc>,
+					<&mc TEGRA234_MEMORY_CLIENT_SDMMCWA &emc>;
+			interconnect-names = "dma-mem", "write";
+			iommus = <&smmu_niso1 TEGRA234_SID_SDMMC1A>;
+			pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
+			pinctrl-0 = <&sdmmc1_3v3>;
+			pinctrl-1 = <&sdmmc1_1v8>;
+			nvidia,pad-autocal-pull-up-offset-3v3-timeout =
+								      <0x07>;
+			nvidia,pad-autocal-pull-down-offset-3v3-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-1v8-timeout = <0x06>;
+			nvidia,pad-autocal-pull-down-offset-1v8-timeout =
+									<0x07>;
+			nvidia,pad-autocal-pull-up-offset-sdr104 = <0x00>;
+			nvidia,pad-autocal-pull-down-offset-sdr104 = <0x00>;
+			nvidia,default-tap = <14>;
+			nvidia,default-trim = <0x8>;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-ddr50;
+			sd-uhs-sdr104;
+			status = "disabled";
+		};
+
 		mmc@3460000 {
 			compatible = "nvidia,tegra234-sdhci", "nvidia,tegra186-sdhci";
 			reg = <0x03460000 0x20000>;
@@ -1541,6 +1581,25 @@
 
 			#interrupt-cells = <2>;
 			interrupt-controller;
+			sdmmc1_3v3: sdmmc1-3v3 {
+				pins = "sdmmc1-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+			};
+
+			sdmmc1_1v8: sdmmc1-1v8 {
+				pins = "sdmmc1-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+			};
+
+			sdmmc3_3v3: sdmmc3-3v3 {
+				pins = "sdmmc3-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+			};
+
+			sdmmc3_1v8: sdmmc3-1v8 {
+				pins = "sdmmc3-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+			};
 		};
 
 		aon-fabric@c600000 {
-- 
2.17.1

