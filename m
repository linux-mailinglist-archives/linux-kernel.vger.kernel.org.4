Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F585F76D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJGK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJGK0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:26:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AA67B1C1;
        Fri,  7 Oct 2022 03:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmrW69TKwwI/c1EgkOIDzyN3afvjVazmMjFZHf6EDV3NyapybaWqJkneEkf4ayYBp8JHHg6ARwhb0DJqgiEFBPGMET+4dPEUzM3IJtVfoSe7EKfgQBUnEsy2g4zaYzV/Ab/BAN/K/z9dlCsP/bTBh6m3gWKoGxYKkUoBu7DzrGs2gDsZ3sRWbdrNGwgCMdLN5w6G+wjMoC8hi2TVuqZkrc3NaXiALjJZgMhGAMNxrDeNb6juQwr7CThSUwudqZSfI1je2Vh3gZQVD0kCihJ02KYbHf+kXM+e/yMbtRhfrzjTA2+PDs+aFg5wd01olcnFiKhrmE3QReFc17+ScJjtzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Af96STCZpeyijDbKk+Oa7i2Mhw7vlMlDSf6tLhfgXg=;
 b=dQ2DNdNIeOoTbYGAqpoRFpykuWvpGIDHU5FQ/eDX34u1MeQ514Q9UFGbXRVV1TSAI74q67AFaXTCDNqD2kvtNXhHueMNFkEaAfiO/S6XeTu+VSJutHIO03a3hC8gzwdntKSX7T8ntgDUKurf3Zvw5EQXoBvH+mH9gY+IcC/LBCzkkNtQhKZ7hweksrL+GMVh5jU4WQgyoIgYcCg2OjRJyc+xVTKn1aMLIpk8PKdhLPFB04bhOHWIWC34IjSGmLpNUMx3edW/W5tYUwZ2bWj6MZvq9h2PEwTMLWzKLOMCuQ8lXMnAHO3VfkQnsWw+U28i+rRLuaxW0pyVle0ORc1DXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Af96STCZpeyijDbKk+Oa7i2Mhw7vlMlDSf6tLhfgXg=;
 b=ST3cMh/dF/EG8C0IMRqzWOmR2Pu4rqOa9yVquFrb6k3bg8bqIXw8SC8sWOevxEMIOg5oFvUsm1xsCpFUnM7Zcb1qgJbpfwKSbBPLpXS6rjRo0ryyfWl8YJGBT80VwGb1yxmLWktLf8NW7RzeEkIGGXm+598h4Cg3eKlx19nCWZ8KO5Uwcq5Yj6QX7dEI8xlu7bDAnY+Z6MuRxEWm06C5MFY4fofkgx5DNiRMp7czw+h546s4M8PgisJghhoyNxwHZ6QxJsWDdPtGQrqbYqnkwjPgUv3MlYc2ukxg6e8sxar/ABLxjVrHWxKVLL4e3n3kKImju1eSU5ZsvgnhoScGGA==
Received: from DM6PR02CA0119.namprd02.prod.outlook.com (2603:10b6:5:1b4::21)
 by DS0PR12MB6630.namprd12.prod.outlook.com (2603:10b6:8:d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Fri, 7 Oct
 2022 10:26:18 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::a3) by DM6PR02CA0119.outlook.office365.com
 (2603:10b6:5:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28 via Frontend
 Transport; Fri, 7 Oct 2022 10:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 10:26:18 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 03:26:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 7 Oct 2022 03:26:10 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 03:26:07 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, <anrao@nvidia.com>
Subject: [PATCH] arm64: tegra: Add Tegra234 SDMMC1 device tree node
Date:   Fri, 7 Oct 2022 15:56:05 +0530
Message-ID: <20221007102605.15828-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DS0PR12MB6630:EE_
X-MS-Office365-Filtering-Correlation-Id: 523c60c6-aaeb-46ce-8195-08daa84e5f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPZzJZiWsKLJvFtxgv/VPT4iJjJg4brvbvRaun5gBCWMnz019BoN5jVngR7PfKOheCrsKr6lWBYTr86Ty6mX8HcuOjqhGXyenxpfvPfxaEQZFXMVRKREki0RWIqwEQCTAKHDcdEc4pjbjTvv1nTY27GXmMDUm4GJ69fUNcbGw14/NsaHxdOHsNQRrrNr27iEM41uWke06oSBfEnecDE3h9bSDe5NGavK+XWRY6SlVUd7n6HTjHZhai38JfiwAVvPcpFzLceGv1HOyPsD5B+V8QqgGZDq4b/wtdknZZyHhN8nepczrLJBpUnTilkkbYg4Dg1uXYy91I+MQ7RJrAfLxVgfXS3B3j4s6qa+OffNUuYCAcvZTAvTkzR5TJOGKCb0L5M7LPlPo2ZVOpm/oyUW9W11EqUKvSqMeadLUw2LL0myPKc8U9tK6Bu73aJOtETx9k+D88DflGb8HDd9BArUXlTOyCrES0UNihNt/So57oW04+PrBTIz1g6PT03n3kQhlxzRGbxF/uDCk+UCkkI+mnTpyU5XWxnQah9mj8BoJKW7/nwDbEKkI7EjhOa+CF4zYHXilop6+qDPQYom4gT6pUrRsGSluc8ZQIlQw9iNcXDpQPilPh3WHAvVm+AJJJYKwBjaxH+WFeQeYHPKGfl64YCP0vcUckx7t5xHAL0g8P7jDyS2cOMU2qs81uzvtmGhqttk2VV1mycHIH3A1XRKbyYqJtuXnEXJbmNFocRl0fl9WyjXdyoZynBWsTyles9Aa7c3UDHiOuAhY6fG/ZDwUA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(47076005)(36860700001)(83380400001)(36756003)(1076003)(2616005)(70586007)(336012)(186003)(82310400005)(7636003)(26005)(86362001)(7696005)(356005)(107886003)(478600001)(82740400003)(2906002)(5660300002)(4326008)(40460700003)(8676002)(8936002)(316002)(110136005)(54906003)(40480700001)(70206006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 10:26:18.2476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 523c60c6-aaeb-46ce-8195-08daa84e5f2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6630
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
index 0170bfa8a467..87f6b8be79a5 100644
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
+			sdmmc3_3v3: sdmmc3-3v3 {
+				pins = "sdmmc3-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_3V3>;
+			};
+
+			sdmmc3_1v8: sdmmc3-1v8 {
+				pins = "sdmmc3-hv";
+				power-source = <TEGRA_IO_PAD_VOLTAGE_1V8>;
+			};
+
 		};
 
 		aon-fabric@c600000 {
-- 
2.17.1

