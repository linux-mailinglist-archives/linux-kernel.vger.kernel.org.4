Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6C5F7BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiJGRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 13:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJGRAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:00:03 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE13303DB;
        Fri,  7 Oct 2022 10:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl0UH51MqDQrOM/AkvYM22j5BgesNt/RPuCBm5lqJse23ftfc/MtP+F+OhvRvHw4H1erik8LSXiuCFHKqVuHxwvDCsJrZtkdDH+Omwih4AVSAgRJWUI5UOPziuocJ/7OpIPgxRWkaWHqDxeFopLg1PrLG5XA8oJ3wCfmf0lHe3vs7d98jUhCIpUEau4rOs9wi5+Qv5Sfig2vV1iKt7spunQrJVEoGorFHKiv7250TyWDiuQuSdJA3w2BNy4onFyy4wkGWsVcoKTH4+0EZD75G31SPibJOhe/cL6kgcU15MkJw1rRejLA8O9JHhzICZ6Cgu2a+nIo9ogs9CZx3A9Mcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32hflWF8ScZ7h1doJRg6HofB1diwmI72CIvspbdSDHw=;
 b=GtwahfjtACQb3xUoVjmKc5NDCQ4BV0DomFfDLvdNcxgl+sPqBy5iR8/LLMeNQ2X2RSHWCnxSVSS91aUZuORpz/W7j5evjdemjCymtGOkqeVaLHdk1FkniZCU/dJUOFi5nrs5C056A3bR4uP1o5Zndh+9vgnSD2vhbPKOnqutlLgX29FXzMnVx+I3/c79/ODCCC9lbNS+hEx03eoAL5yNe56wmFi8aDKs0FTYihBNVlJyVEI7mLvF9QIkGuT/owb/vn+2M6gUj3tYMkDX5cl0+m5I/gntVZDRsAFWW2MgmDAFAZY0wxNhTdIA+8iWOEO01sqqU/nszZ+Fe/XpydlR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32hflWF8ScZ7h1doJRg6HofB1diwmI72CIvspbdSDHw=;
 b=fqtFpoenjTJu+v4/Nluttq1eODzO7CjnwnYvAVbpRY5vANG6yqd0vs3qFi7+qbDAZDv/W/HhgQlglnems24t5EYnFJnbs528yN76KF8jeCHcd2d1TaIDuszTOt7oTt2wJ2Iu0qDQOuo7OlOXialI80M/x0G8RvTnRavOYCrh5MBM2lGf2PoczAUVQb1q6Ea+edfGEGdaTi/BBccSg0S2FzTz0dYE1uV2E6wv9jwJbWKj0S03SAE0Ck7cqiT/YQmQa9sETxdFTWOHINVfBzH8faIOF5ZAkDgm5c+h9p5RK3zRAxmUOPswTAcJAv4fPIA4rH80hxHhKJb3n3sIV+cmuw==
Received: from BN0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:408:e4::26)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 16:59:57 +0000
Received: from BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::ee) by BN0PR02CA0021.outlook.office365.com
 (2603:10b6:408:e4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.29 via Frontend
 Transport; Fri, 7 Oct 2022 16:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT096.mail.protection.outlook.com (10.13.177.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 16:59:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 7 Oct 2022
 09:59:47 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 7 Oct 2022
 09:59:47 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 7 Oct 2022 09:59:43 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>, <anrao@nvidia.com>
Subject: [PATCH v3] arm64: tegra: Add Tegra234 SDMMC1 device tree node
Date:   Fri, 7 Oct 2022 22:29:41 +0530
Message-ID: <20221007165941.16539-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7bf3f70a-4af6-c62a-75fc-89591d5de04b@linaro.org>
References: <7bf3f70a-4af6-c62a-75fc-89591d5de04b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT096:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e06e706-a392-4462-6ca4-08daa8855cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVYkIX1WP7bXVnOOWQR7mmXBnXCUPgxB0ea1Ge6YeL7Td7/GkD/uS4J+ILHwdPNhdgQEjLkHDl6p5TaBx2Hn4LAiKgoOoYaOY+apxVeV9C8/haxjVX/ihgsqjV4TSmwhbpniaGXv4NdCnPHDkhKm1jXGcgnl8MCyuHxpgs33n9tGdignCY+JSIb8Tr5WLXM7lmFgnmpiFUYyHxbudv9i1sXtWuuHF212C7t22/NtMDYzGY1nyNQw8bgrPrWyZFVhpMAOoQ5qXCHoqZDmY+4y3IkVaji1cfH8ww1e/Yu3mmKdr+kiZnnmozE5rAIHJwhTdFjQEEmdLTpZKyVsLkc2sZCRuOA45j7OJKEeNFdISuJz5qn+TvfrGNKmkVQB+CiAvKP2cNH2psYhYFORgcF+fQg5ri1+kclsUKWmMt0GZY9+l/VETs3CKJeRCcg2qTEdycoeLcCp8KRQvWECQ3k07CIhFdaTofvNhlpbfXs3uZBCvusIj9QNZYtBoDRa/Tk+GVoZJwKSQaLxAw3tEEPzHInLRXg7pkAJ1KX6Rlnd7lJsmf4VhotIqCR+Lgrcswvb21pIt4FRCBMM6gwMxjrN96EU6zKsQJoYDoFpcG/c+3uZf73WJINSECtZsz9MaR3uEN+ncegAUj5N5UzUUv0X8h5qSBfBqlsCDSP09PPTFQZruuBXWED/B+lso8wF6DpZRZ7o3wToUo7+Nxy4mCF34EdQhF6WHadgwAi9Ku8tgtlsD8ATOcNItPd49Jpy+9OkD+flAk2PkGot6nDNR7QSkA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(7696005)(107886003)(36860700001)(7636003)(70206006)(8676002)(82740400003)(4326008)(54906003)(70586007)(356005)(478600001)(40480700001)(86362001)(36756003)(82310400005)(83380400001)(1076003)(2616005)(47076005)(186003)(26005)(336012)(110136005)(8936002)(40460700003)(2906002)(5660300002)(316002)(426003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 16:59:56.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06e706-a392-4462-6ca4-08daa8855cd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      | 60 +++++++++++++++++++
 2 files changed, 67 insertions(+)

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
index 0170bfa8a467..58f6165100a8 100644
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
@@ -1541,6 +1581,26 @@
 
 			#interrupt-cells = <2>;
 			interrupt-controller;
+
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

