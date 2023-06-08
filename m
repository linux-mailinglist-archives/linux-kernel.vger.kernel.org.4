Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE9728079
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjFHMvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjFHMvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:51:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792426B0;
        Thu,  8 Jun 2023 05:51:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8DYqzADNP7HB3Bo6Sfg3zFCFs9yfmXpZ7xLMp/9cGd7NOuvNg3f3bBDBKEnSG1iHhh6oV5N1sTc4Ih3i0fJxzkp+sCEDs4lsVkPexREOW+3Dd808YUahlu1om8mzzPhnfyYgYxtlMH2bperKWmCR2PZ2OADADoejYyVUfiGHWOdKq5/C2z9Y96N63dZQRyx7/XkxemKrxfqexjdykBiJKf3tPusCd/dckBVD3leLc3HGvM7fVZ0Clar69w2MHLqLCPfNNU06OE3B1f2v687jsPRWeu+yzt3UjhEzMylgS0R5PPWjZQrX6w6vmO2bR9rlELHDYAQ+5XhrPm/R3xg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJTdZNykrtUn+8jVdGbzEZ+5xGigPr90BRHToUVS0Tc=;
 b=ezkgO0EzVuq8xeWVVG0Iy151k3jYmFI7Bt2yQtVBEkKN06/WqMzc4V6fRMROORX7VuQF766U3zA0g+518s+2TydZ7QzXHthYMZOvKCz728OLoxFlyr2Y5Q9mL4qpxMCoRoGWTiqlA1b2rhSJ8klmP/fALIS2D9iWxTWzYHBTU3jt3+FoXbO+qWA4eNJK5SXRCx+98mkPvOUzU3F2J5UXYMjntpHsoL5p3nPLW7wKEpDkkXaS66zWRDhDdwXHC5Khn9w9btAqtc7KvUlIq/Hpy37H2UEV8tltREoPwMXbrDKMs7/XEPbAK+4fsanOv3ikzZ/kFp+8jX0pF+1/mv3qqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJTdZNykrtUn+8jVdGbzEZ+5xGigPr90BRHToUVS0Tc=;
 b=GdL3s2wlADy0zopQ+CTuOpeUe7CsSUqtvGHcwaUubU+cjJDOeL6q+KFE8kUqJd3XtN4VOCGGfVOXrW1fktsXCDPGb0qINUu6aTOBVVAIDmnewlqLKkXaw4koYNgDlsost+aAJvLYKrv549SuXx5N2RKmTQYW6uMl1vKysd1IGp0=
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 12:51:29 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::a1) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Thu, 8 Jun 2023 12:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.24 via Frontend Transport; Thu, 8 Jun 2023 12:51:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 07:51:26 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>, Andrew Davis <afd@ti.com>,
        "Ashok Reddy Soma" <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Assign TSU clock frequency for GEMs
Date:   Thu, 8 Jun 2023 14:51:23 +0200
Message-ID: <3b9285b50a2a4abb136ecb0873343a4e84626581.1686228675.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=michal.simek@amd.com; h=from:subject:message-id; bh=VPoZYQy4Mc9DSpYKGN+9N/3RsiVEL4l3h5ZkhFXjlzk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTGc8f0bxZMaOyKX7stcElN+nn7o0eTLfYcF+++X7LuS lPswm9aHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiDHMY5vA8Oj2/IjiO10Lk xgNz9cX9Lo/E3BjmO0X/n+CwftbZqfxKV9ufzwj/vtbQCQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fde63f4-c543-4b72-f4d1-08db681f1391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /+aYwGhTqi54ZXj66OdVrOJck6lg8Cm8TyqAKcOgpEOYH4wjlOCXIriQb7JI81uyNc7TqPeuyGi9ZY/csBC0afhTm+HK9SlPj8hRm9R3N97xSvH6Nr6QtBe8nW6qYm9xS90j6XeZFElG5PjLzoxZVMRa55fJAGVCF+jIp5rKnpF+ozhh5HyBmyqnPrHngYOWDO4ja7jv7cQn+jWoSRzPtX0FEIaOpdZ/hUEGEoHpuGJVfnIqvSIsEHu8R7wTm77vOih/yHvJqr4bcJ3P97CoBUUyd7AqHaTEoyMgQX9vD/kzVlO60bgo5lNQu6pZ/pfOp8reuZjKEiKD4uITS3l4wIk4h7dQlULYMxNjpupS7cPaSkWeZsSZlcfePoL3Ku8Bd6vlOhfPq2t4OlyvAXqh7wlKZYiYjej7tXY3oFWOmO7njThKqLxAoPZ8c9vPBf/mdXQXdYTlfeNhNmdWYm9ybEdsjZTjLMuqtP8aSKuuHe4Q4VhqXj2Evdh6Uh38hG1v9t8rB46IQ0HB0fQ3xx4fOW6aUTciO4DVfz31AYupPH03AiOB7dJXCi2u9av2Ram5PZz7cibbljFZtFlSQbIJiKvqaQigVCa2oo46ZR9ypYj2XcceuVPIZ1z0kLErN10ngI3/vYhy1G8meGaDl1CRYGmq00aVx2qOXN2OvmA1PNoXtM33MVXkrw9oacKqn3ZpBrHwOM1Flm3ab3ToY3ne5u02E+JkADkaEG7gvV47IZ/177TXHxZ1mB+CONVzhPfK+UQCh97KE59J2j9EIz8HDO5YaZe1HeW5wicwz5sRQnM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(6666004)(36756003)(40480700001)(8936002)(8676002)(5660300002)(44832011)(54906003)(7416002)(70586007)(4326008)(70206006)(316002)(110136005)(478600001)(40460700003)(2906002)(26005)(426003)(186003)(83380400001)(336012)(47076005)(36860700001)(2616005)(81166007)(356005)(16526019)(86362001)(82310400005)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:51:28.4195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fde63f4-c543-4b72-f4d1-08db681f1391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@amd.com>

Allow changing TSU clock for all GEMs. Kria SOM is using this
functionality that's why set TSU clock frequency as 250MHz (minimum when
running at 1G) to allow PTP functionality.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi       | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index f04716841a0c..ccaca29200bb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -146,24 +146,28 @@ &gem0 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
 		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
 		 <&zynqmp_clk GEM_TSU>;
+	assigned-clocks = <&zynqmp_clk GEM_TSU>;
 };
 
 &gem1 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
 		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
 		 <&zynqmp_clk GEM_TSU>;
+	assigned-clocks = <&zynqmp_clk GEM_TSU>;
 };
 
 &gem2 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
 		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
 		 <&zynqmp_clk GEM_TSU>;
+	assigned-clocks = <&zynqmp_clk GEM_TSU>;
 };
 
 &gem3 {
 	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
 		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
 		 <&zynqmp_clk GEM_TSU>;
+	assigned-clocks = <&zynqmp_clk GEM_TSU>;
 };
 
 &gpio {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index e06c6824dea4..ae1b9b2bdbee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -145,6 +145,7 @@ &gem3 { /* required by spec */
 	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	assigned-clock-rates = <250000000>;
 
 	mdio: mdio {
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 030e2c93f0e6..b59e48be6465 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -128,6 +128,7 @@ &gem3 { /* required by spec */
 	pinctrl-0 = <&pinctrl_gem3_default>;
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
+	assigned-clock-rates = <250000000>;
 
 	mdio: mdio {
 		#address-cells = <1>;
-- 
2.36.1

