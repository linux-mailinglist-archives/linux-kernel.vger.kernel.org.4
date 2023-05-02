Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6856F4523
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjEBNiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjEBNhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:37:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69746EA0;
        Tue,  2 May 2023 06:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I701QP3ZZMojhq5r5HRKy11QFBp91hJKv+DZ2QGAK3GYY1aGFQtq5TETauseORy/GaHPn/+CGdkzjrHQGVWrng2uRRyPOyg86sn+K/zgpA9FohVs/50tvLMeNwslNjArz8qlo40eQeaGZmIMl6zCJfMNxoDaUpWzCm/5KKRSveDNXqkxbd5zfEoe2tNlgSn3qgO+t+Z5qI3V22lhAWTWZm2ZR88kVjLYITqOsKgIHhpbzA0Wpg8aKwde/FnbWjiozPfU7pdINX0oSdPZRbpvbQzsmcjI+65LBqyovUILbkuycJ4u5Y1awoX5ehvwAU+vjhPT++WW+jNW0SuAJFCO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ylh8b5a2BN3/fjePm88uxNb9v1sqH+RyB+kr+738JDM=;
 b=YwStkNeASawPKgr3ma7Ho5Nz4lzOPkkeia0tbuWShvY0+rIdorbB3t521d1KsV+CtVGekTuM7mAHBjOt5XJUs4hJidDznuS1/JettP/XIf2QsI0SIceaNogu/Ay4ax+bOe1kxRCe5L0EZU3lxic+uVQToZPjItD7aaibZOgvDFYGUrpRedl/Yw/dgU6n8/ww681EhHkiOntPP3ZYpTlkevwvV993b3xhYuObRDIfmb2RC27Fx6gVFxW+QaRFZA8SpWKFdEVQpOgpEjAyC2XMqg5JFCfyksierTSs6dCnwz3eKT2JV3wwhKF4W9FNB2AnmbqxP+MNGndR2OxmPXFfiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ylh8b5a2BN3/fjePm88uxNb9v1sqH+RyB+kr+738JDM=;
 b=hjkhRyaKstfFg1JzfI+TFl1Y1MGLQgo+P3SIqcKZPkRhqmVpEPdhwX3wlUggyEhW9EBEFSEpnJHGSzcqV3Qr8JIVzWkYU9XEd3AEXH6SKa0x0Ww2pXrFrr/Qhq7Z5F7lMZ1XREMHvon0utGroyHd6gWaKfkxDcyTMW6fU0tgTzs=
Received: from DS7PR03CA0243.namprd03.prod.outlook.com (2603:10b6:5:3b3::8) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:36:52 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::f8) by DS7PR03CA0243.outlook.office365.com
 (2603:10b6:5:3b3::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:36:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:50 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 10/23] arm64: zynqmp: Add linux,code for gpio button
Date:   Tue, 2 May 2023 15:35:38 +0200
Message-ID: <4e20661f43b1fb8432fa5fcda5c1cb50d0a27475.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d654db8-68ae-454a-c0fd-08db4b1249ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMThYcRWdnSpgIhIXhOGcT8sdoRr/8PwnBK5AgJ3/3f/zpb8kwxJKSZPzGIPY1UV6ZlP13kgh6s+JJXR9cN3YWIxcM46t77HtLsHtDPcL9BJZ07ctgGlZmvuFQX5wwtypkIoU3LML/t7opXI1G15dOftxebs7IXW1R/ie5OiIwoLcgkxLj15Ae/abkaUG0UvkoofXQrgsUSSLy/FZosBomIhehM4cw9aXNQbkhIbDvBumPbLFm22DgCxdUNocu7bJSGFc1pC9X2vdcDTh3TSq3ojmpD4fpXno8+tgkP6p54ibYKSvTFmiYTerQ7Plb5csy8MmvstSZ6/xbtuKy1J1H991o6plbJ+XMWs+qiRnli98Z+oQUeavrujh7/oMam2slJkK0gRlwoquvhBVBME4QPFsONjND9eBpIeEs0Ev1grA2yrS8XURdEDlKb+8MbEH+PzqDpGKttwsXJXBsNJ6zqpvbOxjHQppVCLvcRDROB7jeuOZDzSJZwS27QHDgFtp96B62O+QE+nZDVOWss47dEYmV1CXlRacQ+7mjbKj/VYiC+cytOoWelATxOayTdtMKxZy37cl+d0hNj9tJ9Afn6wPJIxhexiX4zSbdr3aqux2X2lhw75kSRhMgvbsGa5Ym/lUZdzJEczntHVpkBkRkqB1Jsj+F7VO2S56kz1Xx9qDEenB61L80yr/bDYvoMz+2gvw/FgpspktbKL88OW+uncwrLb/scl/XQKFjkWTC4BfUsi3rBXPg6n5CIoF/pb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(426003)(336012)(2616005)(47076005)(186003)(26005)(82310400005)(70206006)(316002)(4326008)(70586007)(40460700003)(356005)(81166007)(2906002)(36756003)(478600001)(40480700001)(6666004)(8676002)(8936002)(41300700001)(110136005)(44832011)(5660300002)(16526019)(82740400003)(54906003)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:52.1900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d654db8-68ae-454a-c0fd-08db4b1249ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

BTN_MISC looks like the most reasonable option for this button.
Button is used by firmware to indicate (after reset, power up) that user
wants to do firmware upgrade via firmware update utility.
For bootloader or OS is this just user button which is worth to have it
mapped.
Also button can be used as a wakeup source and pressing it for more time
can generate more chars that's why also adding wakeup-source and autorepeat
properties.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 3862168fa026..340a5c43a8b6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -55,6 +55,9 @@ gpio-keys {
 		key-fwuen {
 			label = "fwuen";
 			gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+			linux,code = <BTN_MISC>;
+			wakeup-source;
+			autorepeat;
 		};
 	};
 
-- 
2.36.1

