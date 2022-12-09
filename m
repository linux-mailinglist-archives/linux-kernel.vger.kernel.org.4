Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D726482F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLINva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLINv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:51:27 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E875082;
        Fri,  9 Dec 2022 05:51:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALPFOTGHbZEOoUWKQlIe/PTDnWm9+MayU9vBK7lUc8NSHQcvHpp1jjIJe1b+9CQ3e2DQQzX0dyEbYRwolwYxUuePEPsYee5PKSeyx6T0zvYfDJfTkjhW7CknDJnHMkEZOdhKsfG2EzpZt9eItyrsyWIhjKCJF7fjl6q6bxsfGBnDmxXWRFzneuOwQF8g6zZ/84bdsoY0CVJ6SZsGGtJ0H1noUA9FV+YzbriF4dqq9rwdNfZK0+EBnaSMcZ5xO5ekgeaA0nDh87tA7YDSfrirpiDy/lPSVFF5kx1M9YZ/e9tlhQ3CurltT/gVHobdRGgn+ToKbsuTVfVooaXwJP+oyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGCSzrBQRP2mnNTMvA9z1Qpnl8ShVtNMz+tmloboZNM=;
 b=TWy8squ9gsHl/pZQfYTW9UUKnVx7jr0RvAqQu/W2axyFGxSAq2ahtDUDSoHqV+nD+xrAKtvZHqvpOOa3inW48E6vpWgzTbteyi96WSYSzrcU1TU5J2SSfChP0r8+YuZRaf9375uCIxl8NrpvJ3MtiI6eh3VCSyIKRitduBARL8qkUoGCUd+cn3zOiOVk4GMVxUx7opS8YrEs4fWoDmUFy+JajW0livS8gWBf2k6ksR8ObXMsXKUzWwiCJWKpSXDLuqCY8A5AjjmDtCCx3PJkGu+SMNW/Z2Fa1OWeGCRm54tyqYHlU2BpWJ2uxiOCsYfepHOpHqDqEo809Cnm3g1V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGCSzrBQRP2mnNTMvA9z1Qpnl8ShVtNMz+tmloboZNM=;
 b=l96enpWL6owpBSla0wAQDO43794oI7VWsiDyGXwL3Ez42KV2TpTyHGkdH37+sOhnvettjgsZ33ST5Z640hnmpvTs2OfMCJ95Mp9+VwVb2QBb7J5ihgfhO5SmLtiY3wqKGdnW+mG5un5J5PMCKL35XtADJIJ8Q/VlrpoNDmGLNRI=
Received: from MW4PR04CA0287.namprd04.prod.outlook.com (2603:10b6:303:89::22)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 13:51:20 +0000
Received: from CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::12) by MW4PR04CA0287.outlook.office365.com
 (2603:10b6:303:89::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 13:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT072.mail.protection.outlook.com (10.13.174.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 13:51:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 07:51:18 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: dts: zynq: Add xlnx prefix to GEM compatible string
Date:   Fri, 9 Dec 2022 14:51:16 +0100
Message-ID: <5452508cf2bb4213e9cff9b957d663c30633e81b.1670593872.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT072:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fda7ab-299f-4b13-f5ec-08dad9ec73d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfeV20TKMWYICtO4qjDW0bMZ6cosOzUhH0xSF6WnkBs4X2TJtJkh/Y46iycr85Yo9ItIg+FNltEglAO4DB47eqmFJsHVNBfFLy/Ovr4oIrLIRHduEL+RNJkO3F86t0QQT/leW7izeyHUiZ6kT99WJPonrCrk2rYB1NdiUyP9WvKT9EgUasTy3cHrdNy4A0DZe1bYHEZe9y9/oXUuYMNjiPHwkleVXAPJSd70eHGye4Roq/Ltmen/QuUWWYMA4xRqeOLNM1wFLDZYZvmG8dOIxK+VR31borAkxh5I5lIb/HrPiTM69xIQtNItOQ/2DgfhMdRhHTjxKcoplC5/nM5B8JqN25G+BNo6rcEp4kij4V+JIxYHQXcvVphu6pcgCKiIAKO9AuHwLa8t59UnHCjq2xXtINTp733Ouj8F2pQ+RquXTuI3BuaAEPMJOxd3zrsQ2Glmgpf7+XkU5FHVez0MI1Jhuou56vKI2MYTofVwHu17n6HIhyRrap1J2kmC2g3FqktBm29t6RDW7/zKmGElndVeHFF6kKrVIXac1j+chtBx16RmE3mEgV9+3jUoWPIpC68ptSR2Z47j/QYTQ1pVOYFpaPe7O2VwPjzFU7HmtJoDmFdMwq85aTVTQGSvGlg6CFcAeqgWJq6bqxNk6rP7kFvfnGTyZAJQiq93UOY1SGHluHsI/lmE75J8FNzgk82nq74MF/hzShR9EjKAt4CpsW+9Ydk11mZgSCL1jaBCBMiHnCfiPR5ZxP/oV5UM6wcE
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(478600001)(8676002)(82310400005)(40460700003)(26005)(70586007)(110136005)(54906003)(70206006)(82740400003)(40480700001)(4326008)(81166007)(356005)(316002)(2906002)(83380400001)(16526019)(186003)(41300700001)(336012)(2616005)(5660300002)(36860700001)(36756003)(44832011)(47076005)(86362001)(426003)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 13:51:20.3564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fda7ab-299f-4b13-f5ec-08dad9ec73d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT072.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harini.katakam@amd.com>

cdns,zynq/zynqmp/versal-gem was recently deprecated in Linux in
favour of xlnx prefix. Add this new compatible string and retain
the existing string for compatibility with uboot drivers.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index f96f19a8a83f..25fbca70ac1f 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -243,7 +243,7 @@ qspi: spi@e000d000 {
 		};
 
 		gem0: ethernet@e000b000 {
-			compatible = "cdns,zynq-gem", "cdns,gem";
+			compatible = "xlnx,zynq-gem", "cdns,zynq-gem", "cdns,gem";
 			reg = <0xe000b000 0x1000>;
 			status = "disabled";
 			interrupts = <0 22 4>;
@@ -254,7 +254,7 @@ gem0: ethernet@e000b000 {
 		};
 
 		gem1: ethernet@e000c000 {
-			compatible = "cdns,zynq-gem", "cdns,gem";
+			compatible = "xlnx,zynq-gem", "cdns,zynq-gem", "cdns,gem";
 			reg = <0xe000c000 0x1000>;
 			status = "disabled";
 			interrupts = <0 45 4>;
-- 
2.36.1

