Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1E648315
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 14:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLINzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 08:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiLINzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 08:55:11 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C676809;
        Fri,  9 Dec 2022 05:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNTWXI0Ii7brfYn1Zq8paOpLIDvBWyp+rUxpiSZcgSBWOi5ZbhvnmW8JheECE37l+kZ6tMIO6BXLuVI9FN0XVSkMhHiSGm9IysG9807aUhVwT1uzU/NdlzQVFrvONKNBEGVK6DSbi0GaPwv/13Tv/QOFM2vR3NJo0gZfHJLDzhwVYLzT0CD//y42+ybr6YLGulHevDm6sDE+ua3ZNTTax2Qc31L8Z82v3vz/80dihpY4AWFP7z8F0UHX37OhDpZBQjmxgq7MR0pYSILZt753NIzd3NmX/vbpjQwB2d30DyKnXUT5wvN0PeQfka4Uytvz+BrWxtIix3kIYiHeiNVKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NRxSv6aHPMQb7qgVXHJcQQKDvsev6LNbDK7k1/eRn8=;
 b=BcMmcEJE3cVsbusmhwT0cXLnmbH2F8CfC0Ggw3hI/2g00sMnfDSiy8PLn/ifO/MtcEiXeQzzoCUHyiwjfOpQHmoBwtSSv6eIJJSX0vgVlbkguc6Qhd52orrDk9AAQ4bQNCSNEkuYkN+zsWYLSJf/HEAu/carDs6wmiKNkacizTLs35lVzWL7wuSN8ppxGRDKsliIrHdWhQCap8qC17fgQBfdW+cMRni1vDfW2GJRoZ795Ukgx4imh31jwKVmIqfJZKchNHezjL7sUHNklkCJWzJK7ks7D7gDYvNsCLFClDyWtfJcHk5YIV/kvC1lmf6CV10TUOD2vSP/9HK+o3T7LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NRxSv6aHPMQb7qgVXHJcQQKDvsev6LNbDK7k1/eRn8=;
 b=lRnMW76jyCxTxGbcv3p5ncVZNq9wsIN05QWfowVOYq9DZRiIRRzDRuL6vP+jUZ5wJjaryJnMXAJAt1YEHgvTWMsL2e0NUNBvX0nuT81B5u/UIzf4wqMaTbNmQSSOPfBT9PMBGFFAyC/ihYp91q6EMgJOwLuyr1SqGZjondUkxYw=
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Fri, 9 Dec 2022 13:54:52 +0000
Received: from DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::6c) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 13:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT100.mail.protection.outlook.com (10.13.172.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 13:54:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 07:54:50 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Piyush Mehta <piyush.mehta@xilinx.com>,
        David Heidelberg <david@ixit.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: zynqmp: Add mode-pin GPIO controller DT node
Date:   Fri, 9 Dec 2022 14:54:47 +0100
Message-ID: <69924a8e2c01e5a1d25d098adc53224ddb841f46.1670594085.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT100:EE_|SA1PR12MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 01468f1d-b2bb-4621-8351-08dad9ecf1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m09LUeWabY0ppKXoy/Kbd5Zs6b6PoX1aUr7NyMNozl5VFMjvJDJY+KcVunMmdFcI9g41BFMW7T9B5tBt8GH4+xpYeXihVh0jqv92swhtn6Zxo+Co7O6hR0on4T3uNLwqBUodtXvip91A4Xg+ErtZ9wXN2KoyW3P3Fk+nGH+o8byb/WTHrQr8VbaFz02/WG83+esHeX4S+9Gzv8yZJtngL6AFDSIIFq+rvis9ONA3BNFjhlmKKjFgqp/y3sJTcM4tjHFG8rldBxjyYbGdHZ+49zfw5cxnFHbwOc9UiW4XiSGPZyJ6KXiR+gBsY4R+unqudiG1iqd/LcjgYczsVPbdECULbItlM0rkzxnIt6MP+msnuk2uINbRopm23dlFYN6821yhWOaSRh+jMqUikRyWU/Ok4I/B7cqT5ssDk48GhOmotRWHZfbQFUmsNtCXMmhJlIpn+FzGF6IQy4cCg83mSADkG5eMlg+7JGfxgBSkHgMJNDX0Uqp0eGFwTMk5oEXup0CI67hIwTc+VMF/UAW9EbZJDYEMY16N0INURlar3mxu6P86nIMf0Ij80Q8Y9DueFtytTNMbD95PJko169UzbR6zQ9oun42xmvnjJ113kxHq7/QGbc2LjEzPwG4ZX7iW5NblnE4xDzjWSYVy7Dx7W478S2o/oEtfJPvyC809qQIRhqKnBIgnPyjvJrsmJxGTuBubAlAmQv5tpZHpLYeGuiLA34Nik6Eyod6lsY8W8xv1697Ja8IG1nmOhe46KaRi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(6666004)(4326008)(8676002)(2616005)(36860700001)(36756003)(316002)(356005)(82310400005)(54906003)(26005)(186003)(40460700003)(82740400003)(110136005)(70206006)(70586007)(86362001)(81166007)(83380400001)(40480700001)(2906002)(336012)(44832011)(8936002)(16526019)(5660300002)(426003)(47076005)(7416002)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 13:54:51.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01468f1d-b2bb-4621-8351-08dad9ecf1ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Piyush Mehta <piyush.mehta@xilinx.com>

Add mode-pin GPIO controller DT node in zynqmp.dtsi and wire it to usb0
controller. All Xilinx evaluation boards are using modepin gpio for ULPI
reset that's why wire it directly in zynqmp instead of c&p the same line to
every board specific file.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 99273cbbc75f..8553299f12eb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -13,6 +13,7 @@
  */
 
 #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/xlnx-zynqmp-power.h>
 #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 
@@ -183,6 +184,12 @@ pinctrl0: pinctrl {
 				compatible = "xlnx,zynqmp-pinctrl";
 				status = "disabled";
 			};
+
+			modepin_gpio: gpio {
+				compatible = "xlnx,zynqmp-gpio-modepin";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
 		};
 	};
 
@@ -814,6 +821,7 @@ usb0: usb@ff9d0000 {
 				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
 				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
 			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
+			reset-gpios = <&modepin_gpio 1 GPIO_ACTIVE_LOW>;
 			ranges;
 
 			dwc3_0: usb@fe200000 {
-- 
2.36.1

