Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220B35BCE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiISOPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiISOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:15:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2725EA3;
        Mon, 19 Sep 2022 07:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byF6iBCHhYE5ljZdYrfKlAhoJLSvEDYFpF+ws4SmCSClFzo3N+ZVEtOnhBiSGYO2rzqj7C0KsIqim1elwN5Jmx0WuS/CRKlf+Y2LP8NZyEzqXM3of0jE4piVPQKHRKfH+2T58EnPTq9AUEC9Vj71rUGXb4FBdq3AxVn9sHqqtVPIjAZYQEgmCkNHJVOl5iSmPGJG/SXPVo/eUSSQCenje39QhugB7duUL1YXYwuunV6JOkrq897daVMT6L7r4/qGfWgd4bEaXgNI4kb+UpOzdbh/EKex14N2DXt7A3v/QOcFP6PLmbU321qWKwqrOpy8J1J+NhSSz2fTeXCDEAefSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgLissHxZvEl0maubZsDbWvVrgQCwKs0JjboD4ckEF8=;
 b=l3X+n3AWdI/mWqTHLXlopuKnxeM3NQ1Bv+m+s14jxycACu/o9AbP+S3CQp6l+aB6qtXVsF2ZS/dPw330ga3pzPkYwRKHf07Lo7GNk0cwQOJTgJ4M0MHIbUY30e1XQRbQXyfgQxW3Eho3NnY2NRV1tqkvIAKmlT4HwOvUzTrjU8yt45gZRM/MdXKTMY9dSMAdQNjjToZqETQiu2JDbuKF0paRjRQHJmNUW77A0cbg9hMKnm3/CnAkx9DZjnAPSTc/eYQN0eSSJaE+pT8mBjPsLh8C8CNFSrueNCkPjc2fP6kp1aEPUZJH40L51XVUfrLr6HdyYfLr6d3sXV5a4vW9vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgLissHxZvEl0maubZsDbWvVrgQCwKs0JjboD4ckEF8=;
 b=KIiNg6QQFbnV6PKYyIjF5G6R0BfzeqFq/BmkisnY9+whih4qYsaoD/ksQG6ly54mIMlex2mRJWc0dw72AjfK3iLBn6vle5NQMwrLAMPYSrqk4X1wnzYFF0b2RxVzVOqzVUGquKtalwCJNrPmzLSOu5nbVfFszUVLeE1qmTs99KcwOArswhRVZMp/bxuq9YHVBqFf55DZBfssUI5P/mAOoh1APlGSLPlOQnSXMcPikLAQ/0IvzIAs0uDHipbTzwNH0uVMviUuIM6COx9oo09fZgF6OHYLGrnaezpCl/EX3gCOMVsTXBe7azv1Age9MA4z6g8HJfdrMYcP45E6mDRfJA==
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by BL1PR12MB5333.namprd12.prod.outlook.com (2603:10b6:208:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 14:15:18 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::a0) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:15:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:15:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:15:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:15:05 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:15:02 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH v5 2/3] arm64: tegra: Add PWM controllers on Tegra234
Date:   Mon, 19 Sep 2022 19:44:54 +0530
Message-ID: <20220919141455.31084-2-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220919141455.31084-1-spatra@nvidia.com>
References: <20220919141455.31084-1-spatra@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT055:EE_|BL1PR12MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: e106abf9-ea59-4992-0b11-08da9a496159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Bj+dFvWlJ8ZmfvfWRtTAsqtKCLIs7VxVs++HmTw8hHMg90DajOR1Bwnk+wWb+00uCz+xxKjWXmesDaKFiJ7bz07EM58Pza2OzeKs7HIc7RTOfQKqVxbQRj6INXXeI+nHgo2fCQ2lohzEuJBav6Y6Kt1IFQ7T7KwY9E4bYSXG/sftfwEZivtofvLIdh7KFjBBLCpTrY4EZeBULqsudEB5N5zSpwC8EVlAXie79N59pEEX6Nipiv9FDF7j0/s/uWl+mOQ7ElHLdygMpF62le+juw0y5wmAXeHrti4dJEGah8y1c+k0yoVi1lFbc+RkheIlFvPHA32r9NQUdmNRRpFpH+vVIY3lMVX05SBsl5MTdwt31SCF/cfFBlAA1T9q1dyXm7HbBnYEYWiuokus59GN+rMxaMyIRvgsKhV3qtbcySjc4iGiUIt+3IomwsxGHOBRuNg82vSOoyR2bwoUygLHs+OL1dz70bm8sAXV+ZwiCKX2bH/DYM+nlTHHF/cuzXlewM7r6X1ODnVS30uXmvwSPmcpVEDM56607GqNkx7CkVDaudd+HTor4FeT06AusC73O7D6t7rPYRdSB5M4qdXklCRsuV8fYyxgiiVPErybkAybq+XXF6V4LVFRxt1unY5BkM0ouNMQN2a/gO5nV6wInrtZJpEAbKMYFNWgTDnvh8Ky5mIz/X7qUKUAhcJEDrfBuFnHsOAI4NNgT6/hGSxMG/vhHLvDF/dyYHTgLCBDlLrxfRiIQNCtblExhdHBeOcRCuFNplEc6rzz/a1ERjdvmiVreN+sj2159inryk/oIeA+xq6yeM7WtIZw0OvvDiC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(36756003)(86362001)(82740400003)(7636003)(40480700001)(356005)(40460700003)(316002)(8676002)(110136005)(54906003)(2906002)(70586007)(4326008)(5660300002)(41300700001)(8936002)(70206006)(83380400001)(2616005)(426003)(336012)(82310400005)(186003)(1076003)(47076005)(6666004)(107886003)(478600001)(26005)(7696005)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:15:18.0830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e106abf9-ea59-4992-0b11-08da9a496159
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5333
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 has eight single-channel PWM controllers, one of them in the
AON block.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
V4->V5: Update compatable with Tegra234 and fallback

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 88 +++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 0170bfa8a467..b1b29e3c207c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -870,8 +870,8 @@
 		};
 
 		pwm1: pwm@3280000 {
-			compatible = "nvidia,tegra194-pwm",
-				     "nvidia,tegra186-pwm";
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
 			reg = <0x3280000 0x10000>;
 			clocks = <&bpmp TEGRA234_CLK_PWM1>;
 			clock-names = "pwm";
@@ -881,6 +881,90 @@
 			#pwm-cells = <2>;
 		};
 
+		pwm2: pwm@3290000 {
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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
+			compatible = "nvidia,tegra234-pwm",
+				     "nvidia,tegra194-pwm";
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

