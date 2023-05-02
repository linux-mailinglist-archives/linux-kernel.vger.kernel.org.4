Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434666F453B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjEBNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjEBNjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:39:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE486EA9;
        Tue,  2 May 2023 06:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMApNyOdtSKOdiO1XyPE76j2/yN6IMMHaNvtGlq1+eP5IV0z+5tUDJu5ydSIAPQ4DLL2eXf+PYx97E+p5xah/tawpJtVAEbltO+RKjOeLEEpcgISEI/eOl8oXAKkazIwkUXTX7WgLg2dqYnTRkQ0OSHTYBZGXqBWL4ClXoknD4kXFjsTijx0y83E5ZoD6HmB2AKWblJwlEMpcuiK+uuQLrs30LW4rAifR0DvHxq+5/IoFLkN15kcGT27hqj4wvAZomdEywJ5Yvor8pSc6yFKo40ZTQ1oW05ZyGcXAblMJb7Mr6eOa7IFw8UPNEqybyyYgZ6Mqocg2mJ5RRmGmxP5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNLGlWrtSEfeDZzc0T9mpV3XrkBdor9YMe01kTZX3Kc=;
 b=ZtBrO42zZR3zkQIGXXtz3588bLeH0G5u4Cl69jfptG9k0ynx+aoIflXPek7ZZ+XuKPPMBE/F38eO14b5DSBQfJTBSasZSjWiG8jE5flQ8iMM4eR36Cw+vY7DVQGKr9cuV4vcG2chAgBXCnjlrnf1C5tRZuS0vjrbK7k0ohmrxMbl9kSgARR7ocgF1lOfXaqrZgcv7GQ6FJChXadwz8cRYDjNmyZ3ylEyWxhpY8tBgUHW26vFUdSabcMkJ8g0+g207Z/oqOojIcsJheQZ1RZKVZHGFMuwWbKWqgfaIpeu7x5dh8fYuGP3bM3HQZtNqXbLXbNa2bldxSevfQBUOc6aCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNLGlWrtSEfeDZzc0T9mpV3XrkBdor9YMe01kTZX3Kc=;
 b=RXS25biU+JQNxI43PghxG+ProLCKLVTcpBg4qUfJIY82hleijG4T7KiUj2uG/W4KuDShryNDPAPK/XwQOMjWUwVOKwwzgKcnHbGyPq9dsUTLgc/kCXn6ddbjcqRhanf8bkJjgZOJvtgA1EMdLAg6f1uiS8G+xXNeiEI57bDQtYo=
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Tue, 2 May
 2023 13:38:42 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::ab) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:42 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:40 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 17/23] arm64: zynqmp: Switch to ethernet-phy-id in kv260
Date:   Tue, 2 May 2023 15:35:45 +0200
Message-ID: <4b139e942c2a808eecbb30226b6ea5303348390a.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT011:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: c5128070-48d2-4402-d92f-08db4b128b7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQz2M3OVHGgPOHiXTOy+pQaY12UvhKYHGq49Wu5+bVg4nPPRStGyj/0RoxwZA1FXJGaljLIN9UVO9p6856pQm+2gcMFVGljMJBv/1wj521xiZld0AdPTJBD3xHrqDtkEeaaFshMi8xIeb6pIfVRNORUAQRQa/Aihdng+dWLdzOwQWstN3ZGdgA7dcxWnVtu0CDgtDvB2+fPnfAdmGOfS+P9l+y2MzKCjDnfV1bwiIj+hCrLKjk+YiyhRHYDQH1UrlqhC9JdtzbnafEbeYXpM4y+bDqOCgFtH73rz8EW4wXFGSiEobvP5qoUZOTbMON//WgpaJKGSmXumE+YSXqVeAIivQPR2FdIo1S91jxKhI+DdlYexF4N5TUVuW+NqWyw5NWsVZsYhzyT5i+spjrRf4K4R+fIQ0d3FkAjLJfr7OwCh4UdVUXdg0SpCsrTKFyrfUPAcG8ZlZ3briz/7wadOIQAHl5AelSPvggoq4Xzs5gV7BYVOWO64w4LQIY4nWfDsJ2m6sYhtJA6J7vVs3sZvTm8WNL/scfD83FECf8ZKAufCBv2/K47+iNXh6XBToi/XnO72tSIDp4ZDMthaBRmWlfgqZZJrD5Y6cRvIYm2ea9zKWOe7s3Zg7E66z0U27VYmyaEag2QLSw8DrPj4gDhdrY3wGhhBq37FtRJoKp67iRr4GHo6cDWuAnQlpoSmSx1XkTgD+LD80ZpzmDiMaqMU4+jTQiHT4rGLAxAkGjKP4EDGsn68myjLawIJFB7ldHaG
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(2906002)(44832011)(336012)(86362001)(2616005)(426003)(82310400005)(7416002)(5660300002)(8936002)(8676002)(40460700003)(36756003)(41300700001)(316002)(4326008)(54906003)(110136005)(478600001)(40480700001)(186003)(16526019)(82740400003)(356005)(81166007)(26005)(36860700001)(83380400001)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:42.3920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5128070-48d2-4402-d92f-08db4b128b7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ethernet-phy-id compatible string to properly describe phy reset on
kv260 boards. Previous description wasn't correct because reset was done
for mdio bus to operate and it was in this case used for different purpose
which was eth phy reset. With ethernet-phy-id phy reset happens only for
the phy via phy framework.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 6 ++++--
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index cb4a5126c4ec..817d756142ab 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -146,16 +146,18 @@ &gem3 { /* required by spec */
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
-		reset-delay-us = <2>;
 
 		phy0: ethernet-phy@1 {
 			#phy-cells = <1>;
 			reg = <1>;
+			compatible = "ethernet-phy-id2000.a231";
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <100>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 31bc120dee49..e07cec231ee0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -129,16 +129,18 @@ &gem3 { /* required by spec */
 	mdio: mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
-		reset-delay-us = <2>;
 
 		phy0: ethernet-phy@1 {
 			#phy-cells = <1>;
 			reg = <1>;
+			compatible = "ethernet-phy-id2000.a231";
 			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 			ti,dp83867-rxctrl-strap-quirk;
+			reset-assert-us = <100>;
+			reset-deassert-us = <280>;
+			reset-gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
-- 
2.36.1

