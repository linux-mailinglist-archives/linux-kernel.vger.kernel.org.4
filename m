Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A097A65E747
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjAEJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAEJED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:04:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6743F50E4A;
        Thu,  5 Jan 2023 01:04:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMsOGZvgY5OdF/mazvixK3VXX/xY6/qpZZDWvWfJ9a5nidBFNLc4fRU+bJz7RWE4FLpWZsGfEQdHOlJYPuFfH4Hq16B+hX9geRlMc+IIub9lkvaRFBuXd/io57dF03gF8o3mROJv2oCdYV4TYomHVY5K2YiyFyuotkCKUkNGxHcybEcFtWk04Ul1D84aufSbsbzHjUCk5tA6bDh+xezeTOuIxsv+9pwWwDgZERhyrrkW252L0E0MsqTS98g8diWbxQz9TX+lC52GpgOuV892XHqpgY0sVA+ygNzhNruXJxkqfepyqZHAWqGQxQVG7bTBUy8A2g7TwQ/DzFbOQNVSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqA30X8wI917W1fLaRiORt4diR3n90F/n7J60wNbqeY=;
 b=kfPAudcbx2pT+2Lf4Sa3BipdjPuWuIjQEBNfCaRD25+JgfeK5o/O0HM7uKu+TNmMleT7/qusQz253PiiL3ncqwkZOA1ZxE4Skl53uirz3zZTOsvH6EGnX71UgyajrJomVFVsCYuJ+8AzplkUOBCmIQJj4LXPONU3e+YR9fF8X+/hefa+E8cqJZFMisw9VPGUnFCbCZj40lLRYMfY9d5nd1EJR9ui4K4+GjyvytTeRN1h6gvN0cj5eC27If7/Nek2yPiSq4rLTZ+NUqTFV2gedX1BjrA0ujjcdoqBCYRSh+6qGNHyw3QpHjrGI/oKiC2dU0HK+ALrj2E1wNBezCrlwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqA30X8wI917W1fLaRiORt4diR3n90F/n7J60wNbqeY=;
 b=wWCiNh5hEtihnlVFZB/DsOIGoV6B1DN5HBfGYhOFB/w9ET3hnA4psLdHW8ugMv13vCmqtCU/tcqNbSwANFW7YTcAs5QZscsQItTXf8bqBPKUBQw/FKDuSud45SwSfeuIzIESpJwJFHwGzeupAXcCnhp+ou/fbJE7GJdS/EXmTVs=
Received: from BN8PR15CA0064.namprd15.prod.outlook.com (2603:10b6:408:80::41)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 09:03:56 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::cb) by BN8PR15CA0064.outlook.office365.com
 (2603:10b6:408:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 09:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 5 Jan 2023 09:03:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 03:03:54 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Harini Katakam <harini.katakam@amd.com>,
        David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2] arm64: dts: zynqmp: Add xlnx prefix to GEM compatible string
Date:   Thu, 5 Jan 2023 10:03:51 +0100
Message-ID: <578a4fcbb4143888af954996a45f5e1110e0ee50.1672909426.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3252a4fb-0e71-4ae2-b804-08daeefbc662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7eOr19cwswjJ7Lsse63ZAhk22S4OOZRxl/BF8D/62VmD91T2f7ndhVx6yVRHfHYtk8LseMqz/iVmAYTlVGGnsZYwFKi+URewUfb6NYAJQFHngWGwGMJ6rFASbwL2SkXOYXmSTGlSbBiJAP1GvUEv2lkqJ10jx7hvE+hbC5RBz5oYJ2uzGdjZzK9dRqai3RQPaJRxMuO7YNo8u+CfCtaUjeeIZ18Z0et9w7aHsJ1vuGf+16Hp83iCWy4ivpCiAvmfAFN6XBw7THvIbHXQjyPwNE8w6ehFfd4sDxTk2SlDhnYqaxidcjVPtSazmqDtgignq/m5a+cuE5RURQYl9PzhS04AxHAKqs9CifNTxVM9SuIF62Fj9lFXr8Nu1OBhrfn5lmImpkWeLq1DTcIgm2Q+F1CKRBt0rHRC0ls7SxwErzYwa0PpJWBAEIBItGMn13gfFrsrgMY8PorUgNvaq83z8M0kEH8hS6oJrfFFtEj9/aiKY82GkbFol7h5oRnlzs1fiRdzGEXhQps3o7MK5cAsGoV6jiL1TmINlRsljig50mwHxMHmLVQ02OgATr6iqoh7M8GA+HK4LzeqTZMxHcqGT8xr7+FRvVa+XcV/yqrml/ioAosE/uDYox7MJ1imnWeAYqLkDafjqasqeJVx4s6u39pOyoLphGt9VoUDQLJrjkF7LPe0DsdxfiHVWnsoHhvI5FF1oF9xGy7qVQ/9eJTnxjHdwGHlNupWpqWHhb2xcOzDKtiH5t4WFI5MO3UbbQHP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(356005)(82740400003)(47076005)(426003)(83380400001)(86362001)(2906002)(8936002)(44832011)(5660300002)(7416002)(41300700001)(40480700001)(82310400005)(336012)(6666004)(478600001)(186003)(8676002)(2616005)(16526019)(4326008)(26005)(316002)(70206006)(110136005)(54906003)(81166007)(40460700003)(70586007)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:03:55.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3252a4fb-0e71-4ae2-b804-08daeefbc662
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
favour of xlnx prefix. Add this new compatible string and remove
the existing cdns,zynqmp-gem compatible string.

Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Remove deprecated compatible string
- Update commit message

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 2ff4b788e094..153db59dc4b3 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -540,7 +540,7 @@ nand0: nand-controller@ff100000 {
 		};
 
 		gem0: ethernet@ff0b0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 57 4>, <0 57 4>;
@@ -555,7 +555,7 @@ gem0: ethernet@ff0b0000 {
 		};
 
 		gem1: ethernet@ff0c0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 59 4>, <0 59 4>;
@@ -570,7 +570,7 @@ gem1: ethernet@ff0c0000 {
 		};
 
 		gem2: ethernet@ff0d0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 61 4>, <0 61 4>;
@@ -585,7 +585,7 @@ gem2: ethernet@ff0d0000 {
 		};
 
 		gem3: ethernet@ff0e0000 {
-			compatible = "cdns,zynqmp-gem", "cdns,gem";
+			compatible = "xlnx,zynqmp-gem", "cdns,gem";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 63 4>, <0 63 4>;
-- 
2.36.1

