Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D9C5B3C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIIPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiIIPxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:53:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0A545F58;
        Fri,  9 Sep 2022 08:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/om0FZLOaK+pmDUmGycrkkfYDVBpPceEgpC4GPFQVYI4LMfaTjZuAiY7tP9ylXSek05q8Ost6iN8VQcRs648pUuzZFlqetTg5bA/XBW0fvBNSXlagk9s6GsxVrlRYoAccTxuB4KZAH0JvgkdE7O15D8nKmKSJgfWqq7wPyuHimHNN0IfDkN6DzXecZwM5qeDo9ssaJbzMCWM47wXABD+/JmMmxUmj79gACdLWU/oAqr0c+lt0MJdt2jRVrFQK0d/FdDlXOg7OBHBxlRPpu2uAJiYdSz6XQvuY3CS4plsWikqJeAT3X0KngxyvwcSHNUrrKVRYeaMGXZKR6hUSpd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZN8nHAe1WXaPsLpUWMGbfvat2fW9F7u6+zKcA5mSTw=;
 b=UJWpRDbdDnhlqmC/xjr3xV1JnuF2of9q71yuhaIw0fs5Bt3ptKsKEN5joPCr6XE9igTFgMQys9uGpRN3oMVMg2+wpok8QA8FBY/oYPx8/CsQY046XFuDERkse2mntoWgKU14qceFL0zM8RBzM1nZVk7wf0kMeKJoeuhqon+PZYpEffSnzxynA/dTzlmwJKFkVC6TUtvYYUudSDmvn2RnQ4nUiSK4LkmTBuyAiQXi+5tQD1fKFKT6dv1HQNq82RcXHo1Y32NDQaTZXpi5uGZK6xmGmUG0pt8w7gcXc6kgIGaUSLiwCU6CAZMmArrkhP2F6509HYNKq16bC+oYvwH9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZN8nHAe1WXaPsLpUWMGbfvat2fW9F7u6+zKcA5mSTw=;
 b=RkTVWoMV/tTso8YfwydJdkDjm0V8Gi+/T4kpFBd4Uyy9wZg/KKmAnGfotasCFS6K8Pk4x98jE6nVbcht2nSeX4N50749pYV+VOp0kw2SC9LyRTRgf6cMpQ++eNCKWnuI+pSEvqvtc0j08Ej7nL/OnfYm4UqtK3/WbFM7vCbMlA2UaOKsAKEylroEf/shwcfb51lows7PhBSGcqmg+YjKJBRa2xXFbICWpQZnkIDOBpwWVucG8my8+p51ejGGrGlm35ZeCk3fjzfxwKQBHAC8GCpMSVKoELnvlI8a43vz+QhH8eCCSREAst3SrCpWmpYZfOHqDfFSAEkHAq2bPw8xVQ==
Received: from BN9PR03CA0119.namprd03.prod.outlook.com (2603:10b6:408:fd::34)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 15:53:07 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::6a) by BN9PR03CA0119.outlook.office365.com
 (2603:10b6:408:fd::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 15:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 15:53:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Fri, 9 Sep 2022 15:53:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Fri, 9 Sep 2022 08:53:06 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Fri, 9 Sep 2022 08:53:03 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: Add PWM controllers on Tegra234
Date:   Fri, 9 Sep 2022 21:22:57 +0530
Message-ID: <20220909155258.17908-2-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909155258.17908-1-spatra@nvidia.com>
References: <20220909155258.17908-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|MN2PR12MB4127:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ba9dd9-263c-484d-7673-08da927b63a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rg7nstPSxHa7Ze56o9bSV9qBDhX5F3NA/2FzeBN4TnxBzr6rcapX+15t+e4T/vdrJZibsbDH1n5G9+fATY74n4+YEXRJkcH4MWw/ByPpQg/C/SApHz292iy6idOUJwxxphiNWkftUQjWsZHoZcDAXbqVhbzhymR/lEJGHZ7tGisDz91yAGmY8htJOpp6xp0fiCec1nFZyfYIBjnbX45aEiZfeXmZjeQIa1svWP+Uaq8P3S1oBFYxmWMihix45qZ0ZvN0doS9zxJCJ1+rUT0IoqEbImXkIPZWzclPuFM0TmzPwsrjsCd24Zysz+UUgU29fp94N86+vPxoE3KmSoFGSwLeFq06nELWOpqHvtHVLQ0OTxRTRkBPbL4LLSjX+LPa5vv1eNFcdd3zrdMTnF5AQx4sOXm5p7Re8HW4HzVtDnUDf5yXQpRjuYLbekF/YCjelN8uqXokxyD56Ch4QYVoDyIlzG6toZZVeWdeo4JhZuc49iSL2TfWN6ZKuAJMM35m16utWwYFWfLJJGn9qgk/glqVNiejoJbvHBQemcCmAx+j5HniMOEB7Ip9oxgZkFZQ3Ofuw7yALZdWPZCQdj5kedxJOHmetIlQnhd3n+J3nYZ/yrPEZn4/LITDcJl+HBiESxcPOyootaxzwDF8FMqykyveMhoNZjOjBI7zAOY0nYiVAB9XM2zNly4NTlCyB+5rjFYqLAUQxQPWBJS1fTyL7MLgQvP+feIEWAGQHYyasvqBQ86HZxhphhWvaHUsiVPPd399nmaPqfUgOBxvfgQMWZXgr3ZNO37kGRm8KvVE4sdLdpdgi2r13/AwdwCn+7X2d5XxBrfUJ7AdDSx7k2koYg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(7696005)(82310400005)(26005)(81166007)(41300700001)(356005)(107886003)(6666004)(40480700001)(478600001)(36756003)(82740400003)(40460700003)(1076003)(36860700001)(2616005)(186003)(47076005)(426003)(83380400001)(336012)(70586007)(70206006)(8676002)(4326008)(316002)(54906003)(110136005)(5660300002)(2906002)(8936002)(86362001)(16060500005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 15:53:07.4852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ba9dd9-263c-484d-7673-08da927b63a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 has eight single-channel PWM controllers, one of them in the
AON block.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V3: Update binding doc and fix compatible property.

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 80 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 81a0f599685f..d77ee9d81fb2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -829,8 +829,7 @@
 		};
 
 		pwm1: pwm@3280000 {
-			compatible = "nvidia,tegra194-pwm",
-				     "nvidia,tegra186-pwm";
+			compatible = "nvidia,tegra194-pwm";
 			reg = <0x3280000 0x10000>;
 			clocks = <&bpmp TEGRA234_CLK_PWM1>;
 			clock-names = "pwm";
@@ -840,6 +839,83 @@
 			#pwm-cells = <2>;
 		};
 
+		pwm2: pwm@3290000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x3290000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM2>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM2>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm@32a0000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x32a0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM3>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM3>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm4: pwm@c340000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0xc340000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM4>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM4>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm@32c0000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x32c0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM5>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM5>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm6: pwm@32d0000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x32d0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM6>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM6>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm7: pwm@32e0000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x32e0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM7>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM7>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
+		pwm8: pwm@32f0000 {
+			compatible = "nvidia,tegra194-pwm";
+			reg = <0x32f0000 0x10000>;
+			clocks = <&bpmp TEGRA234_CLK_PWM8>;
+			clock-names = "pwm";
+			resets = <&bpmp TEGRA234_RESET_PWM8>;
+			reset-names = "pwm";
+			status = "disabled";
+			#pwm-cells = <2>;
+		};
+
 		spi@3300000 {
 			compatible = "nvidia,tegra234-qspi";
 			reg = <0x3300000 0x1000>;
-- 
2.17.1

