Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4206F453C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbjEBNky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234408AbjEBNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:28 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961596E87;
        Tue,  2 May 2023 06:39:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1X0kT5wEPlv5mCgvYNdVzoTf8fEP+DdfIw09AZ6JYOLKgaGpoYTHJOAQHzCzyaE/Ab3c+WpCazOoqJRj9E39em4x/LsE2Wu67eikZqCJ6PQTBjGicRzaREVBp+k6bBxPXg0BMY0o7tnTfiLTAPdHAWkIF0q+8o1AFcFrIERYWpA3gseu/DL2u2uhOPdTrN0RwyORafL7ZlXKXd4OqzV9fLVBp4en6LhpBbPV5amHIBE7NMbG0XL2CvrMylL3mlMEO6oV/2LEleNu0c3OkOAu36sW7gkh67oTDWL2cIo1WN4dB8XUeXC9fbkwvD7mG4Bq38Y9AO3dHJZ+Y1S/d4kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I66oDhtjnBAbpFeLWcmzAVm3wHlrwZ9f/pG3f+xCC0o=;
 b=DBDYnL8cGfyutqjA+UyYFjTWOZT0DQ+WOjOy+SULIUpMX24MmSoxWL8nf43FAbsf8rZQKzqxkkwvIyTx2nDieFCyzfdAAIsYS8HcM80M/WqlIuPvcuACa/WXCtBxHh2Qx8gEqOkbqap4lanVrngRazcuyQZLzTtTrjlbLRfQCv7cFFAmXH/ezy3jM5CQ6da3uaVcYUa4OvW/Uz41In0lBpUcwWB0RWABwdyeG6f9XCM169JRA3hBv8kcFhSWcNoEiI8Te7lG7K2ysfa70QGhQMdw6jB1T87S38HQAxhPWu2bL9gq1DZ+oMSmU0U8nYuZOpsZwneuP5jvMGgze58A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I66oDhtjnBAbpFeLWcmzAVm3wHlrwZ9f/pG3f+xCC0o=;
 b=1nKDoTQWUU/zuXm1Z5HQHaIETNPcDm1RK+uw4uAlchhEtP0Ukg4+K9eagpN8QKhAGt/2YAQ9qr8RcxSKG32OvhHHrxXFnNutGSI6hKw4guZB3itImJhKBmD02yn2wjXp2txD6gxJZ3U9UkBAvBrjSQb3mGx+jXbaeEHItsN2Y/g=
Received: from DS7PR03CA0185.namprd03.prod.outlook.com (2603:10b6:5:3b6::10)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:38:59 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::c) by DS7PR03CA0185.outlook.office365.com
 (2603:10b6:5:3b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:56 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 21/23] arm64: zynqmp: Enable AMS on SOM and other zcu10x boards
Date:   Tue, 2 May 2023 15:35:49 +0200
Message-ID: <e1e1621ac1cee7f36ef20606bb3795e130de9609.1683034376.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1683034376.git.michal.simek@amd.com>
References: <cover.1683034376.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: badf0151-5cf8-4b1a-dca0-08db4b12954d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPfruRJVvruFMztUsJpP4KOBYZ+pzgM84+gyjTgFossI/jUXXNnVLHPQ+FhmKtehxwy1s2ux6fHnJvXwdDtHe5bOHYDwnUX3X5ShQsvga2P0JJjwXi7ujXwkNMKn7RvUAXIgBM05Sn7BNVFwtoW0ppR3wc6KAihISSdUFAxfc9FHrideGVJgFMdjyQAiyZ+L0NusxuAYmTL/WGj6+8uIezByEVlcTQ6LH9jnKvyOCyv+jG0A+5jdBeagKJbL3m+3JmgE3fRRFJV71Dw8SVLrA7ZATEzDpFeTW1VICc9cy0OjQyVEfI7bZwVxWhxpqqMv/hoR+Sl9jIX3chPQnweClvcV17+K3kOH3WmyQA0kYi3JfLU/vEaM2MmKT12Tx353+XuimNQMm+S5DDq96aWfajP8jKIdQF5BJluAKbEZhkhE9aIcdUsFQ43rUDujMmIv1nocgE539lWiHNRlqSzSlmmow4JLYn9UdiqywR5G3TE4kztgtOuCX7M3BKRhoa/dmTllKFLRYzmMD8ZvRMpBDcMiYCLOmTSPcwj9DfSolLuIfeZid8KM2Z6XCnmuYvsw9XXuLzlOK45JtwNOJpKsU4SWesFkQcOYaaEDBrXgOuSLNXBKS4cL+PZTy3kcvNdwkA7p2oMUMoKGA6HdbrbKfvy9ntUw6QEUeQpJnbGuL5IpSwMAlRCIQCOEQ9RQ/AvRc2Uc/GJanF9MWuyUAPrpCJUsHuWxl02PkWzfxPcxCIB/IRgIzkkZWg+356rLfg5M
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(110136005)(336012)(478600001)(40480700001)(70206006)(70586007)(54906003)(4326008)(6666004)(426003)(316002)(40460700003)(2616005)(26005)(186003)(16526019)(82310400005)(2906002)(8676002)(8936002)(44832011)(41300700001)(5660300002)(7416002)(81166007)(82740400003)(356005)(86362001)(36860700001)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:58.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: badf0151-5cf8-4b1a-dca0-08db4b12954d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMS is used for monitoring system. Used for measuring voltages and
especially temperatures. Origin interface is IIO but via iio-hwmon it can
be moved to hwmon framework too (done for SOM and zcu100).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 26 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 17 ++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 12 +++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 12 +++++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 12 +++++++++
 5 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index e284979fd7b1..78ff6a9b3144 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -76,6 +76,20 @@ ds36-led {
 			default-state = "on";
 		};
 	};
+
+	ams {
+		compatible = "iio-hwmon";
+		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
+			<&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
+			<&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
+			<&xilinx_ams 9>, <&xilinx_ams 10>, <&xilinx_ams 11>,
+			<&xilinx_ams 12>, <&xilinx_ams 13>, <&xilinx_ams 14>,
+			<&xilinx_ams 15>, <&xilinx_ams 16>, <&xilinx_ams 17>,
+			<&xilinx_ams 18>, <&xilinx_ams 19>, <&xilinx_ams 20>,
+			<&xilinx_ams 21>, <&xilinx_ams 22>, <&xilinx_ams 23>,
+			<&xilinx_ams 24>, <&xilinx_ams 25>, <&xilinx_ams 26>,
+			<&xilinx_ams 27>, <&xilinx_ams 28>, <&xilinx_ams 29>;
+	};
 };
 
 &modepin_gpio {
@@ -327,6 +341,18 @@ &gpio {
 			  "", "", "", ""; /* 170 - 173 */
 };
 
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
 &zynqmp_dpsub {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index c99abb99efcb..c8be41d77cb9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -59,6 +59,15 @@ switch-4 {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&xilinx_ams 0>, <&xilinx_ams 1>, <&xilinx_ams 2>,
+			      <&xilinx_ams 3>, <&xilinx_ams 4>, <&xilinx_ams 5>,
+			      <&xilinx_ams 6>, <&xilinx_ams 7>, <&xilinx_ams 8>,
+			      <&xilinx_ams 9>, <&xilinx_ams 10>,
+			      <&xilinx_ams 11>, <&xilinx_ams 12>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led-ds2 {
@@ -581,6 +590,14 @@ &watchdog0 {
 	status = "okay";
 };
 
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5b6403865541..b2e1f3581f6b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -1027,6 +1027,18 @@ &watchdog0 {
 	status = "okay";
 };
 
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index a74a2061431a..1f30c37c2e03 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -511,6 +511,18 @@ &watchdog0 {
 	status = "okay";
 };
 
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 73972d83ed4d..474744278b97 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -523,6 +523,18 @@ &watchdog0 {
 	status = "okay";
 };
 
+&xilinx_ams {
+	status = "okay";
+};
+
+&ams_ps {
+	status = "okay";
+};
+
+&ams_pl {
+	status = "okay";
+};
+
 &zynqmp_dpdma {
 	status = "okay";
 };
-- 
2.36.1

