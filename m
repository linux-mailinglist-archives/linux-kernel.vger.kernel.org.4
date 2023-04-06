Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602CB6D9E73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjDFRUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbjDFRTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:19:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94668A5B;
        Thu,  6 Apr 2023 10:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nl0XvPc0W9zF9lyYGymdfXU4RyF2OfEgFqAiOUGxrIU6H3vHEF+ktRgogDlMauh2WdrtcHSR3qNPhnZGJUDxMvFEsdo7dTaDfwvB/E4CVDDnhg+TUql1RSB1v4nK3Iwrll5CR5R0TlCMkwSMPMabO76TVd27KsqeCh6yJjWJJnmfVU5BNUCLEDh+J2jcDnn12dg1WU9E6lSs1Z2VzzhkxxPoFU+t3tLNTmRP0grtEJ8M21ZXI5CbjpZrXzXM4dqEy/BtUHMqAa6TsxQy516mtrvEK+MH1iUyI/mtmTW8EZpDSxYifqejsfpb7rgYLLjyM6ul011i45R5rLdsAeN+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=m5SS12XwyhVDsefflG6AyRP4SpAstwW4yM4LhdgXD+fepI7AXZumjHyzmtP/q3XtBAd+67o6eUdeegd8hqfx8hmvLliL+voa7cXDRf2yHXyKSsJM9SIP2g0cVspdi96efg3//Zxx3iuhs1BJqR41JoycH7UX+iuiwUO03x0Vwp94nsTU0UO4fX4Etnft78a7kxJKQOo25US9FZDHvSWG3+WkoKl/jCK95aA9RKLK5j+4zGfmCdGw0KwXjicQ3WJ+VAjQjKKr2FNkeyR0em7SWbgzJQUnmGShSHnw0pR3Q4GPCagg87yK+KLzCWzXxHV9Pl+B8hbmm/6ZEmnXHM8/Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx/kpYZ7ir9/y4hkhUOBaWiXie83l6Pngi0Gj/5GgOI=;
 b=CVOl2nRqb6hjNoYL2c2FKclpeckBKvs93psfeBr6TbdgGQJMl7sCKZKW1y3MocQNnHbGZAH936Ed1XDJlsxcrMSDmXiLmdBugrVqNBDiabCujyrKj0unEQBU5XhDlqFt0vRusLls0bTGO+2CQmIHLGLk/Gw9VdGjRspXVONMrfLKl1BhoMwprP8arVR0KF8GLuZp7Br0mYZx8dBwtfmMU135xF4Jlu8v/EJa4rGADk0bibvA48bmV16uRz73pVWEc3pHCfwFwEQbc//m6QxrKlgIh8w4YjVT+z/2VxFr/epcL3A9s9QmiysJXCisrCxdE6KHCLX7HmA6S6cqAGUjEw==
Received: from DM6PR06CA0007.namprd06.prod.outlook.com (2603:10b6:5:120::20)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 17:18:56 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::38) by DM6PR06CA0007.outlook.office365.com
 (2603:10b6:5:120::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 6 Apr 2023 17:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.33 via Frontend Transport; Thu, 6 Apr 2023 17:18:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:41 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:41 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 05/10] arm64: tegra: Add Tegra234 GTE nodes
Date:   Thu, 6 Apr 2023 10:18:32 -0700
Message-ID: <20230406171837.11206-6-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c6f4f4-99bf-40d0-646b-08db36c300ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kO5x7wabExNnkAYJ1yvbYM4FNWRmaMm6SpAACKfUbKCOlexTRzgX8FE/BFGDdc23ot6DJrH43v5L/f489bZWrYAYhrB42N/Zc3RDpkXm8s+5LysZ0TPFDPrj+6qlWjkqD6lGOVKYxKhqXhI5EiHDFViEJdT0UrJsLimIdyRqbMWwL71ew5h4Mfi8wQx2KQI9e/VWlBdUtwqBMmoawcLq/k1DMgIggku7KAsvuUEQrEyquQHCQ6BrBFn8F20Ab7JlUeA/wGZOiecJfcd4PpBR130/fuyXErAjaEX+agk0d9vSMSCY/EU1qVqk/M947JjFoD896cPGWOruzbeiFCLa/UQkCAD3xW4eDLb5TgtIJkHvLFsSIe5R7Wmh124CxmUeEH2Jop/R4wdy5w82sBI1NMiYQ6j2c78o7XLtjQrWKBx/ioTkQkKlYnCrOIHrZFcOSr+SuTZ6SIArLFT4iy5aBSOHHuoUsjYyLyRd51x42VBgF72h+LPvbI/MuRyOOx5HfUvwyynfaKmSpH3gf8MWF3VP5ICx5wKuq/pLGYPVWiVM/UTqbdXaGhDq5CTa6VEyUAaWo6ajdtoTmeXCWVuNAZVHazYfKRkCNsAU5EXs9trzJD27TN/xw0qfhR7sQcZP9kVd1368k3O6wnh0b110UndAuiWqdzL8e25gX8pej9eP2sDPVg2hg2Jpf12vxgSqsjpBGE9lL+oKTQm7wv9dZqHok6mvHlML1s2R0FDXEfPTkwaHqEU5r8KDwLm71diorSv88C1NmhdBo0GK1Zq0Y3CuNekJKjQEnDor1hrfjGZr90FtD+hgCfY5ViDFL3pz
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40460700003)(7416002)(336012)(426003)(2906002)(83380400001)(5660300002)(47076005)(8676002)(8936002)(36860700001)(36756003)(86362001)(82310400005)(356005)(7636003)(82740400003)(921005)(40480700001)(6666004)(70586007)(70206006)(7696005)(478600001)(26005)(1076003)(107886003)(186003)(110136005)(316002)(2616005)(41300700001)(4326008)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:18:55.9249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c6f4f4-99bf-40d0-646b-08db36c300ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GTE LIC and AON GPIO nodes for the tegra234 SoC.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8fe8eda7654d..54790c6b6a2c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1156,6 +1156,14 @@
 			clock-names = "fuse";
 		};
 
+		hte_lic: hardware-timestamp@3aa0000 {
+			compatible = "nvidia,tegra234-gte-lic";
+			reg = <0x0 0x3aa0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			#timestamp-cells = <1>;
+		};
+
 		hsp_top0: hsp@3c00000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0 0x03c00000 0x0 0xa0000>;
@@ -1673,6 +1681,15 @@
 			#mbox-cells = <2>;
 		};
 
+		hte_aon: hardware-timestamp@c1e0000 {
+			compatible = "nvidia,tegra234-gte-aon";
+			reg = <0x0 0xc1e0000 0x0 0x10000>;
+			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+			nvidia,int-threshold = <1>;
+			nvidia,gpio-controller = <&gpio_aon>;
+			#timestamp-cells = <1>;
+		};
+
 		gen2_i2c: i2c@c240000 {
 			compatible = "nvidia,tegra194-i2c";
 			reg = <0x0 0xc240000 0x0 0x100>;
-- 
2.17.1

