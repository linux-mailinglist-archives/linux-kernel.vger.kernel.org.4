Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3FB690C06
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjBIOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBIOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:38:24 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224CA6033D;
        Thu,  9 Feb 2023 06:37:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NapcCZADFb8j+vx/N1Vc5L17AJ/K4suDQQls/kbYQEJSnESbaf4xPd53MHof5w+5UPhVIXLQdj5CB9T4ir01qQG13MvrOSxWoLZPrabsPINpgNjGkF8MblgPGkoGgZCo0DbK9/3pHD06OOOWPzv3BTp7k4SaZxczUNqU/M+XxcVyeoeyiwMDz7n8DxlnsyWjtWkqD5MHaSa7ssjTkp52uk4mXsNsItD1PULRKg59FZIBOCBqQDTSqqTDmyLFPQ+6EvflE2rZw9pDoKpUYMgk5o6N8ote97vu7wyQ7n68OSpU3vuMREpv+2+EPurJO2AKWkcWrlDhys/nkJLktIQP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ckuwIPY2NfACh0tyapv5v43z8gJvjALcrkaX0Cfrac=;
 b=fOv01aekiFJo+n3cIOPc+vbEf3EoRPplDPb4XqVMt23F1rF+Rd1a5WSJ/5e32YMZ+jn8lWuYVhSbbe5LVHqHlwFg1W5jzFWFfiTBPHkVtjiNoTOJviTtRupvGqJ5FsFy5O1rBhKifu9n+EJ2duuraUUSosbPQq3lXf1+3uvt9xaFr70O8cE1Wn54GAbE4kfBcPx2Ou9DUfsmqsqvNPd2q8zfjT1C2nqwR3P3hbEgcE56USb63jD+qNlrqAu8GY+OG83464fRjz/M6Ycmlc+8SClQuftDETjxKvwgS6ldTXe7NLfnG5sbUTeye/qkIJbgoBLm4xSrGLZBt21REa0nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ckuwIPY2NfACh0tyapv5v43z8gJvjALcrkaX0Cfrac=;
 b=cafumfHvAZ1aiLJfZQOk0CC9CtAag1R4mOs1lz3HnkhI11Uj3lOs2VaBGRw7TLPzcRs8gicBPtDBp51J3xI/j+ZKWoMXCcCd0Cj4PuN3KyswEQ307ofexSxSE4AO7+6Hs9Oe4s/qjXfEjKqjIXBaVDmN2ioPQ5evJoo8LqsiWiI9haiU6luNqT12SG9WxanUdO/X/ufNgvvPV/78feAr4C2IodCeEO9Bu0fyedvoOFsTbO4kPOx65rjlDVPHSK2KtvdyFkHYKw6mJaduTMGhSrcxWT4jfAFlbzLjof617Hkt537XBHlcfgzNaIenjLrX/aypYeSE3xqoKIMKmiGehQ==
Received: from MW4PR04CA0270.namprd04.prod.outlook.com (2603:10b6:303:88::35)
 by DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:37:41 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::30) by MW4PR04CA0270.outlook.office365.com
 (2603:10b6:303:88::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 14:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 14:37:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 06:37:34 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 06:37:33 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 9 Feb 2023 06:37:29 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <oder_chiou@realtek.com>, <broonie@kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Audio codec support on Jetson AGX Orin
Date:   Thu, 9 Feb 2023 20:06:57 +0530
Message-ID: <1675953417-8686-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
References: <1675953417-8686-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DS7PR12MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e75efd-8b3e-4c34-3bba-08db0aab32da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XMrLu864+HTJWalmmPGn9xtClq3B6ZzhlaCp1MCYpTxAlWXk/ZsHsW4+x9dgC2sYK0Z20ri5byveA2XzyqP8ah52xDWcT7A0WXgsQp2WL/Iq2r8aNSDpiYQkLggxVCLD9JOYGnfmx2bIJCfNLTTLdKMUR7Boxnudy5objZt8N1DDVbvrTCBpoiD+/99SPjl2R9yx3pdj0+0HcUwiBa94TIFRGfjA6bd6K/odaxeCfAjmwTkqH5HcNqzmoHzwdH/hQUpUXvluBtGSvpmbRcj5rq1dfvpO/pA3HgkhO4UkHrvRpsuIyUGRSIQjfGYGvX+16SSeddPNnHLwb+sXChN7Rsd2GLL/ZFsegr3ogO/wsgBcBxlVCMx5esaulLOuYMERlHSa3w1mOOu4t4E9075tKwNDSU8eCFaie2qG24QDfK3L7tWWElDRW7LxO3gMN2NEWGggB37xwLAbhWlNceXq9w9rF2iKyXJWYCndT9O65SRupwHOWOqtXoHb3GJu8b9NeTW4TNkuAq485i9uMEyoo/uijiyAGEX3YUeeQRtoFZL245wO/DtmP9TthP+kdtUJroHe7MbDNqTa1zpIu8wnzLopBAKrpmCeokUM7LY8vpGXyP3rjd4N1EJ47+uQaSy6Yhry6Ba23bBtt0+q5+oQjLBZwiHSoGw++8CJtfHyf0VcXRT1RBxUZgBEDI5t9jFm3cZ/gR9z+iVDp2tFB9l7KQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(6666004)(26005)(107886003)(186003)(82740400003)(86362001)(36860700001)(82310400005)(356005)(36756003)(70206006)(70586007)(316002)(8676002)(7416002)(7696005)(54906003)(110136005)(426003)(336012)(83380400001)(47076005)(478600001)(40480700001)(40460700003)(4326008)(41300700001)(2906002)(2616005)(7636003)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:37:41.0968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e75efd-8b3e-4c34-3bba-08db0aab32da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6095
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jetson AGX Orin has onboard RT5640 audio codec. This patch adds the
codec device node and the bindings to I2S1 interface.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts  | 47 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 8a97478..5881fbf 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -3,6 +3,7 @@
 
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/sound/rt5640.h>
 
 #include "tegra234-p3701-0000.dtsi"
 #include "tegra234-p3737-0000.dtsi"
@@ -49,7 +50,7 @@
 
 							i2s1_dap: endpoint {
 								dai-format = "i2s";
-								/* placeholder for external codec */
+								remote-endpoint = <&rt5640_ep>;
 							};
 						};
 					};
@@ -2017,6 +2018,32 @@
 			status = "okay";
 		};
 
+		i2c@31e0000 {
+			status = "okay";
+
+			audio-codec@1c {
+				status = "okay";
+
+				compatible = "realtek,rt5640";
+				reg = <0x1c>;
+				interrupt-parent = <&gpio>;
+				interrupts = <TEGRA234_MAIN_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
+				clocks = <&bpmp TEGRA234_CLK_AUD_MCLK>;
+				clock-names = "mclk";
+				realtek,dmic1-data-pin = <RT5640_DMIC1_DATA_PIN_NONE>;
+				realtek,dmic2-data-pin = <RT5640_DMIC2_DATA_PIN_NONE>;
+				realtek,jack-detect-source = <RT5640_JD_SRC_HDA_HEADER>;
+				sound-name-prefix = "CVB-RT";
+
+				port {
+					rt5640_ep: endpoint {
+						remote-endpoint = <&i2s1_dap>;
+						mclk-fs = <256>;
+					};
+				};
+			};
+		};
+
 		pwm@32a0000 {
 			assigned-clocks = <&bpmp TEGRA234_CLK_PWM3>;
 			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLP_OUT0>;
@@ -2293,5 +2320,23 @@
 		       <&dmic3_port>;
 
 		label = "NVIDIA Jetson AGX Orin APE";
+
+		widgets = "Microphone",	"CVB-RT MIC Jack",
+			  "Microphone",	"CVB-RT MIC",
+			  "Headphone",	"CVB-RT HP Jack",
+			  "Speaker",	"CVB-RT SPK";
+
+		routing = /* I2S1 <-> RT5640 */
+			  "CVB-RT AIF1 Playback",	"I2S1 DAP-Playback",
+			  "I2S1 DAP-Capture",		"CVB-RT AIF1 Capture",
+			  /* RT5640 codec controls */
+			  "CVB-RT HP Jack",		"CVB-RT HPOL",
+			  "CVB-RT HP Jack",		"CVB-RT HPOR",
+			  "CVB-RT IN1P",		"CVB-RT MIC Jack",
+			  "CVB-RT IN2P",		"CVB-RT MIC Jack",
+			  "CVB-RT SPK",			"CVB-RT SPOLP",
+			  "CVB-RT SPK",			"CVB-RT SPORP",
+			  "CVB-RT DMIC1",		"CVB-RT MIC",
+			  "CVB-RT DMIC2",		"CVB-RT MIC";
 	};
 };
-- 
2.7.4

