Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4162A6F4592
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjEBNww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjEBNwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:52:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39BB8;
        Tue,  2 May 2023 06:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBLFh6eRlR4lfEVsAz7ez5uLr05Qmg0dGUIVPXL5jFI3uRNjGPqKAT/mqgevaaur7NwhiJMEWufPDpbji1pZcc/SUlztkzOLTwtT/Cezs90D5jjW2PsUb5ygDvTGOtMDPJvu6HtACku8XFwJjSsskTL61y/7YDFVFynBpHTr4SFt0POYQxTqQ8Y1c6aRgP4fnjSqsESAf5+IBlWRVnDYquOe/UmByjjao6eB9djQnV3gnzhzpw3baJaJDLzFo2P3piQAqAbo1WHUO1OjQT+tFsqzuexhjN8fXq0y0MO/Dq7+PONrmNWJOiinanPZ65PZZPd9J0TYgkICxLu1tpmkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZYfKF/bLqPPWFSASPihaLogtZ7rzP4dC8IM66lyJwI=;
 b=GgCD669gB5JL93PMO6xnD2737DI/xtrmXkjwaJt095M/2Cfxujw1dwy8gmASQ7L9vDwPyNtB+k6W0nW/HEqPbzEmbBPujm5J3yHR63U1Gbj/+/EuwvrxvbNu1QCJrzXAZoZURBokNeljEwTVWnnf9Ab80ZQ265187OUmu3Qu8os38Qyb+gRLrUt1wMs8DKd+RmPydX87uxeMsi/IxXkCDkAzJfYAbDNRyiDDpG++x9x9oIDWXkLKnysxBlwiQDGGizqecjRuneZ0nw94BCAc+UMQQ26Lb3ntZRynPyyPIwMD2eom4i8ewaES+Grf0wc9/WY5ArB15XWqjEGC1XnhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZYfKF/bLqPPWFSASPihaLogtZ7rzP4dC8IM66lyJwI=;
 b=YKZ7ZR5faz/QOI9fpmc3rTSwvTxz1L9UJwiGsZSCkt2FOowpGb7b1BlaBxM91KbT9Fs8OB+p/WZo9nQED/mJWntHI0qvmR5u7PBkNp/4MEwgE1fHOyfwq4mMNP2rdTDEPH/hePrW1NlgsUFpuXJtUmaaYy19LILJH6pbrQGutbY=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:52:46 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::56) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:52:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:52:44 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Chirag Parekh <chiragp@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: zynq: dts: Add SCL & SDA GPIO entries for recovery
Date:   Tue, 2 May 2023 15:52:41 +0200
Message-ID: <5eb73d1150648e782795e35c30fccb983b3e0db7.1683035557.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: 73783811-c6d5-47a5-35da-08db4b14822d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1Lb3oPP+u0cyFQx+7kp5Whxpo48GUx9h7xb9o16D0QjgGRMHglpSLv+XdBon+be0g9oVPxjAajXzNt5Cays39CxuVZR31Yv45X8gE4uTUUVKFR5imO4H8a237NC8tF4nhiAE2P+xQmD2cXYMkVYDohjrqAcfdAG8ihEyKwjKGk9HcAj3J38NKm7+HQM2bn9MlxB2nJFmjrjemabLzFtyVElPXtnvz3OdhOJUPv2k5RVQKGhMkRwAommzEiHP3qXX1ScBstj8nfK27Gsld2esg58HMy1QNay6lhUO4v79XJ4cN8rN51LWNJXXbnNWsJ2zTgnPiHWDWxdDIBYvvXXSmY1Q2jjuM+dLCrI/nAFZC2tRMhgeWD29fgArUbqDLKN1DPDlw1G33Q/mYqiznTwLjaGZDzbqMlNfxUH5HFBIh1P+clZRWh5Kyr69ZnXJsgTsZDUw9bBTaq/eRrwT8at6D+abWjiOJetomw+6Twh66P224YyoqAfW/Fqsieec5F4VtJpkp0K45IcXtEq6Hrb9ASdN1mL/AbrPVri+7HH3AydUHA2NPKy0OPuDhKm5Dj65YZKekKs19J0pyOs461CeJDFMGWWyUf9vOzkqVlbhMn/DnVhlWRuRl19RJruiCl2Akbd6yV7M7i7AAj0X9Wn/0socgncNQRRsWzZNxZkSvWGkJZWNOmF4QH5o5YAAFCJiqCYYyG/I08h/mtsyTSLJKFT8PlUviqnLwri7hdjmMsrzXLs+nkq+Py0cEQbUocs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(16526019)(40460700003)(26005)(186003)(47076005)(336012)(36860700001)(2616005)(426003)(316002)(83380400001)(41300700001)(70206006)(70586007)(4326008)(5660300002)(8936002)(8676002)(478600001)(44832011)(6666004)(2906002)(54906003)(110136005)(36756003)(40480700001)(356005)(86362001)(82310400005)(81166007)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:52:45.7706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73783811-c6d5-47a5-35da-08db4b14822d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chirag Parekh <chiragp@xilinx.com>

Wire i2c pinmuxing gpio recovery for zc702.

Signed-off-by: Chirag Parekh <chiragp@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/boot/dts/zynq-zc702.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index d23201ba8cd7..6efdbca9d3ef 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -5,6 +5,7 @@
  */
 /dts-v1/;
 #include "zynq-7000.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Xilinx ZC702 board";
@@ -106,8 +107,11 @@ &gpio0 {
 &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0_default>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	scl-gpios = <&gpio0 50 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio0 51 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 
 	i2c-mux@74 {
 		compatible = "nxp,pca9548";
@@ -298,6 +302,19 @@ conf {
 		};
 	};
 
+	pinctrl_i2c0_gpio: i2c0-gpio {
+		mux {
+			groups = "gpio0_50_grp", "gpio0_51_grp";
+			function = "gpio0";
+		};
+
+		conf {
+			groups = "gpio0_50_grp", "gpio0_51_grp";
+			slew-rate = <0>;
+			io-standard = <1>;
+		};
+	};
+
 	pinctrl_sdhci0_default: sdhci0-default {
 		mux {
 			groups = "sdio0_2_grp";
-- 
2.36.1

