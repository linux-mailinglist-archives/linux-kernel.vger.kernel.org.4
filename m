Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD39728023
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbjFHMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFHMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:35:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43717E62;
        Thu,  8 Jun 2023 05:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyXBD5iEwC+tqx9OC5FrYB/E6/CUADhdI/wRV/wxlfsnZKiJcvRdc2hQIYrmnl3ku0tDMwfiaZHOp/xCfZGpdbRPyPqEDWZZnD6uViGaIcmYv7UnlwCd4312aWrRAomGE+CvXjVfDYUm51l2jG3wEc6DHr14OcVE4ICsLbrRt917SJILMji2V5QPLS8VMyDljb4hott2/vNYLPOlfoFbbnshDnGpY6PbGo2uUW1H8dGN2Be/fKf6mawiwb3Ji5c1ADpvF79XGk+Xb0RNL9CKsCGJ01qkSSkeDWTmSXunN8XInVhSdq1BDQCJuov1CQH51F9GQXovNLxtf7RB8BXm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW7/fqg4eJ76LlScDHMAEatXgtLbXWdMcHszn8agHRE=;
 b=lutwd5JmOA9DuXMQQvhRYEN2LuI2jPHNj3kk/HBaXD/xezPwxgm7Rs57zQHPR+CeO/fniu5Ww1gGFNW548iOYIukEQ+3zJVxYUMjBZqB9RziOHxYbVx7lhA1tWoPU8S8HalYa9z18JVDZvs78+YTtYG9u7yNMAjAOmm2y6mXMGgJaGZ6ET6981Q2xQFNccDQ4Y3LTphjnYabMvhBKZgLukBWg+/U3hbKOxNcbcjv2RSmpPFnH7qNekI1yCVbyfKSzPZtKGB1aAAFmuTtAi5lXP9QAXTYlvtnlQSQM4vUUCWs3X4tG++mEIVVQq5Pk7c4YloCljqsyrogqwV5YFkyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW7/fqg4eJ76LlScDHMAEatXgtLbXWdMcHszn8agHRE=;
 b=YNvdJTUdrYCSEJQ+iBLnBBiPIZougfqqXoVjpInOM4o8q7fqzgI1HqbavG1CxXR+9LnGwHAyJz5ip8zJw4fDMf0hx/g6/s73vvFxBBG5y4gnYpR/juT4k+wzKOwJzqsDr4IjMDgdek9OPtYuV6jHDrEXI0L2f9qXLS3uPYXBqAo=
Received: from DM6PR06CA0064.namprd06.prod.outlook.com (2603:10b6:5:54::41) by
 MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Thu, 8 Jun
 2023 12:35:31 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:5:54:cafe::40) by DM6PR06CA0064.outlook.office365.com
 (2603:10b6:5:54::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.25 via Frontend
 Transport; Thu, 8 Jun 2023 12:35:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Thu, 8 Jun 2023 12:35:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Jun
 2023 07:35:27 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>,
        "Ashok Reddy Soma" <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: zynqmp: Fix open drain warning on ZynqMP
Date:   Thu, 8 Jun 2023 14:35:24 +0200
Message-ID: <a0faf488dde310e1c1c1a676c371e223db6bdca6.1686227712.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11292; i=michal.simek@amd.com; h=from:subject:message-id; bh=hF0MYFQMyH+3kyjx4XsMmZAuAOBaYk2m8DVi/AM4kcc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTG05yle75+9w4TYzzQXSdtVioe5bXeTlds57a3Ngtc0 1n7itw6YlkYBJkYZMUUWaRtrpzZWzljivDFw3Iwc1iZQIYwcHEKwESU6xjme+TPj1izyjKp+GTM 9U2aS1m/bND1ZZjDp14n5CFf/Fzl3OObVRUzfnzWkHgKAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 977bc186-7e08-4959-5468-08db681cd895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i+8GFH3jNbFY5uI3GWddVdczXcbfYDQqF2f8L9UsMFBw1qzrcL3ttpCgUJJRIJdSyXs7kMCHZQoz1kM37UDMr+hfbMzKYb3+WA8v8viGje1aSD8/+/zps6y6b8hbWvakuZBFF0BQZRRDGft2tJF7Q8tj/5Xl+L34auEeIC0xAZnkC5cvWMVekYwj24rsilj5v30pcgvXYy7a+UfGkRpuyab3FTp6zDZrFslHDXjXhKAqQhL3//md0NXa6U3Fsj+vB/mtwjLclNw4xKf2bOBhml2a29HcbBTWvAfYg90NMmUdaOlpFc4PlFwptHdpvxJVRkXGxR57JbaFhEDQgTnraQDRwjfk9a/AHwx+7oTXopWadFV35czBt5G73eWhGTU+/VxZ/BKPGdJIayupxU+LYc3oYzW4+eqDdcnvbFGfDRmVsoRsJc4y3BW2apv41QfPQzEI8WHiP7c4uAA5eESA63yw1q5gQYzUiD8u5eJWgbhjNrt/PXyurZi1Kmw94hD5HaJ+KLqVPadjNn9NsrArgv8aJLDH5WiQWSushMNNkDJfLReeVwUqdCVCl+H9WW4o8WmGuodDOnnfPVcMBNKnn2iCiBtZo7KrRrQJfMLRgJsshb4lgvWhoZrzwsdNcPvBGdpkeJZT2j9xz4C3AHV/UqlZ8VldukshoSi6Qit9ymM3iGLp+vozFHboOnSJeokUQ7Qzimk4YPLoQ7R61WW8JzipZSc2+OGejFJIZT4glw5HXzaAq1pVm2tmmlk+FUyAbLxwj3sQG+guGT3eoFKNaxcNaGLKUkO75MtS9JjeZR4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(70206006)(70586007)(8676002)(8936002)(36756003)(5660300002)(4326008)(6666004)(54906003)(110136005)(478600001)(40460700003)(41300700001)(316002)(40480700001)(81166007)(82740400003)(356005)(186003)(44832011)(26005)(47076005)(7416002)(16526019)(83380400001)(2616005)(426003)(336012)(36860700001)(86362001)(82310400005)(30864003)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 12:35:30.3689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 977bc186-7e08-4959-5468-08db681cd895
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Mark both GPIO lines as GPIO_OPEN_DRAIN which is required by i2c-gpio DT
binding. Similar change was done by commit 8df80c1801c9 ("ARM: dts: exynos:
Convert to new i2c-gpio bindings").

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 8 ++++----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 8 ++++----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 8 ++++----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 8 ++++----
 12 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 603839c82599..e06c6824dea4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -27,8 +27,8 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	/* u14 - 0x40 - ina260 */
 	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index a91d09e7da4b..030e2c93f0e6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -22,8 +22,8 @@ &i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	/* u14 - 0x40 - ina260 */
 	/* u43 - 0x2d - usb5744 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index dfd1a18f5a10..c1f21b0e1760 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -245,8 +245,8 @@ &i2c1 {
 	status = "okay";
 	bootph-all;
 	clock-frequency = <400000>;
-	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	eeprom: eeprom@50 { /* u46 - also at address 0x58 */
 		bootph-all;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index d9d1de5f313c..e821d55d8d5a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -119,8 +119,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 36 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 37 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 36 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 37 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	eeprom: eeprom@55 {
 		compatible = "atmel,24c64"; /* 24AA64 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index 6503f4985f8d..b59e11316b4b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -110,8 +110,8 @@ &i2c0 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio 6 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	tca6416_u26: gpio@20 {
 		compatible = "ti,tca6416";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index b1e933b8a2cd..0d2ea9c09a0a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -91,8 +91,8 @@ &i2c0 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio 74 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 75 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 74 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 75 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
 &i2c1 {
@@ -100,8 +100,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 76 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 77 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 76 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 77 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 44d1f351bb75..d0091d3cb764 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -180,8 +180,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	clock-frequency = <100000>;
 	i2c-mux@75 { /* u11 */
 		compatible = "nxp,pca9548";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 8767f147cbe3..84952c14f021 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -233,8 +233,8 @@ &i2c0 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
@@ -497,8 +497,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	/* PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index e185709c0d84..5084ddcee00f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -140,8 +140,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	/* Another connection to this bus via PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index 7fceebd1815c..b273bd1d920a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -145,8 +145,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 27b2416cb6d8..50c384aa253e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -245,8 +245,8 @@ &i2c0 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	tca6416_u97: gpio@20 {
 		compatible = "ti,tca6416";
@@ -508,8 +508,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	/* PL i2c via PCA9306 - u45 */
 	i2c-mux@74 { /* u34 */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 6224365826d8..617cb0405a7d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -205,8 +205,8 @@ &i2c0 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	tca6416_u22: gpio@20 {
 		compatible = "ti,tca6416";
@@ -385,8 +385,8 @@ &i2c1 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	i2c-mux@74 { /* u26 */
 		compatible = "nxp,pca9548";
-- 
2.36.1

