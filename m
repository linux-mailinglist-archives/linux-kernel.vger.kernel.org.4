Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8936F4542
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbjEBNkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjEBNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670376EA8;
        Tue,  2 May 2023 06:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBLGsxYqI/cXIk0hn8pRvGOWOxbZwvZOIxW0tYiPrVeVwbNuGn3rMKX6YhRCJwa4/vvfSUm/0oXzGL8fSL7xwld1oxD7snaUILQpzk57DCNsbpFJPHar5TzFhKSBa5LTuCEbb8vU7oQsgE2KXEU5g7GxDVO0vTdoxsfDwbR/iZ1C9Ew760UiPXLroGKxwKf9tCLl5zzOz9e/5EM8yo0xqmDiCc5bI4aQMO2wjB/jDw/RvVvtWC/Rq2HzMaNfmVRb3LAtbouFGDR+Rl7HUbmNum4ksoJ5UROBl2IVIE3ePsAzy9tg375bA27atmTC0bgSBto+BZ8HwDMDpyCfvyd5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9fxuTbh25Bu4TGMyD23EsbHaEiE9AJ9OnAOQ7gcDL0=;
 b=a4CqRRMLTGU1xCTTkPMRGZ00h/nr5QXdUg4beZKf6jdu5Ar4WPjWavEp1f226epX6sejxYCkCB9kN4m7TAVVm3HR7eZkGDyTLfPk144MH24QRSd8qGyWLfiVYBHhqkZjLRi2aq05mcJzeK6yefsCvf09+Q+g7o1bwnw+SmvSU5RN+T6xjreXDBHqCa7kFQTJGtk3BWDwLwJNNzIpFirUheldT9ass7QA5QU9ulPF5Tm5O2/a/MIQhmhIa0jxRcA6Io9wS0jI5nPj3YTNpQSgKivaVxHd8UoVoakfkRzWTvcaHpFjHjgpnF0Y320Am2yyg6EOMOj/SIQYJZIHBwE9mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9fxuTbh25Bu4TGMyD23EsbHaEiE9AJ9OnAOQ7gcDL0=;
 b=ZO6N7emjmDASMlNc8WXo6Zh0v5WeL82QqN9D2bjauGl+P/22hOYaI69b/fGTw08CPoC3A89AjRpZtgtZvgZZgwYeG52BTtmeMKGffXoqvf0pQOHGeRdVeurqjZUxPvJFf07jxOhMatRsz2S9kMOD1m36FYgKIA5pxmBJC9OKL+A=
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:38:34 +0000
Received: from DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::b) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT079.mail.protection.outlook.com (10.13.173.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:38:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:32 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 15/23] arm64: zynqmp: Add pinctrl emmc description to SM-K26
Date:   Tue, 2 May 2023 15:35:43 +0200
Message-ID: <f61c16e2fd7c91c2be6d6b67c902037580dbd364.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT079:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: 499de1c7-c06d-48e6-6962-08db4b1286c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpQUeyYLQ7m3YTvx9e0zh6PK3HUf9bXfJSHmLB5y9NJDToMjPKhBBaodvr2hXlYQ/qEQeyIR7KIcKtBGIR9RLYxbWFNu5xgCgZIrNoKSfDX3ucNagYS9WUYfBAz4mcJVJ4FHvGWOT193ATRMxz+jfnqq0KOefu6Vp+bU4+ZNc7dyhwhCLyGisb9iY1Tiy4BLsR8pCy4A2tXiUkUkAhvcBxFDWyOI6oEkA/7aj6SHVbcJ0YwB6rlIXq1Hm+Gl0/WsWx/YEWXc/ccfZxngGFfZn3Ugjsvc3qv/h1ypGMWG0M15SNMOdSVWqe6VTGwU3e/lWbaS2ljp0yLd88q79jXZs2pI86K3keaaAtrm8cuXZdeUlB6kH6691wM19ARCzcmYMpwuqB+iXLJewPSQ8L2dm0elcVxismyfvnbEZEwEG24WhfxDmdnDvH2hN7mG1kKfScVdw7dYNFBdBtZzU4ENBTyzS2xQScweDgtPBSn1lB09f6cTJLGfmXWUm0JkM37yNPHeRvX1f5ZS2adOD3NNoNFKi5sJKHaXY2vIac3bHj4fVKXNf3wrVoe0l93gtK6cWDDgtMGVoCiYihw558YAI+vOgGXKGWdCrslcmVKosM55Tt6NlPTJO+4vufx5wUrPvrOz4YlX4OB9CkBLsE3BWw0fMaSj3+9ZNVMbQvliMSJmDmFPACI+tEaIe/336Nadd6JuKt8wheMp4PN84b2++43EGuUUgheLeTMCUKQvDIoayrEf2fO05u1oxkZ7lc8O
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(4326008)(70206006)(82740400003)(82310400005)(41300700001)(2906002)(36756003)(8676002)(8936002)(5660300002)(6666004)(478600001)(44832011)(316002)(40480700001)(110136005)(40460700003)(86362001)(54906003)(186003)(356005)(26005)(81166007)(16526019)(426003)(36860700001)(47076005)(2616005)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:34.4789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499de1c7-c06d-48e6-6962-08db4b1286c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Production SOM has emmc on it and make sense to describe pin description to
be able use EMMC if it is not configured via psu_init.
(Still some regs are not handled but this is one step in that direction)

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index c206021cccf7..e284979fd7b1 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
 / {
 	model = "ZynqMP SM-K26 Rev1/B/A";
@@ -85,6 +86,23 @@ &uart1 { /* MIO36/MIO37 */
 	status = "okay";
 };
 
+&pinctrl0 {
+	status = "okay";
+	pinctrl_sdhci0_default: sdhci0-default {
+		conf {
+			groups = "sdio0_0_grp";
+			slew-rate = <SLEW_RATE_SLOW>;
+			power-source = <IO_STANDARD_LVCMOS18>;
+			bias-disable;
+		};
+
+		mux {
+			groups = "sdio0_0_grp";
+			function = "sdio0";
+		};
+	};
+};
+
 &qspi { /* MIO 0-5 - U143 */
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
@@ -189,6 +207,8 @@ partition@22A0000 {
 
 &sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A */
 	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	non-removable;
 	disable-wp;
 	bus-width = <8>;
-- 
2.36.1

