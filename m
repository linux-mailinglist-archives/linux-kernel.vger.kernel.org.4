Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00F6F4544
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjEBNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjEBNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF772A5;
        Tue,  2 May 2023 06:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC08Zj+/eFK7NN39l5hZYNgPPsjgX3CcykBekbygikm0poonok3+KDiC9gHIv+LagDxrkCyDi5mQ/B5cgzBUGy5t/erHbXfuaWGw3mkCypb8D/qBnt4uWobi1/0QK+CoHPBsCadQ8+Cs5k4PXhgnrI6Ax0vYZY+QIVpTvZjn9h5xmvFIgQlpfkS48HISW1svX4+prFz/dpb5y04Z0e9xyKj/XHl86zP1ud3XHThpE5gVW+6OAwq3KBStXPDuqgWD/2nEl+PhxjYpaPLz0Cc7eepVYtHiDhhYbIHWu52WchYZM94aASf/NmPBELLvkCQ3VFdEAp+73kVvFPgWc+PTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEBBgq9dQeroAE2NinHi+0ZW+/9vUF2WrcoHvOzm3Uc=;
 b=WgH+YSLiXIhLOwAaIhEPhktRTfgwDhEEA0rg5azJJWDHqXToBH96haMETtV9wHbN+XGIYtnUtmMFQYOp4GjIwsmXJUXtVV8XrmEHR8cbeJpBF86ivQZ+12WDmxcj4zPLkk//Ej+EXZoB7p11StPWF47aUBRwV5gutG4XmB1FEwMabEl+Re2rfmwsq7WnEfaPVPmf93yKZOthfdHdIQOXXbIu+BRrxKAizuAksgBW0KtoEDlAJTq5l9uCjMYltw0XoIGi+X9nGe8oUNhBhbJksVEZ5jCGKpfDIrgIBYZloofCfoo+GE5tRaxMToLu/cN9KezFkCjtDsrLiZ/W2FCc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEBBgq9dQeroAE2NinHi+0ZW+/9vUF2WrcoHvOzm3Uc=;
 b=eKnq+OFDwrV0jzxvm2+7AUcNJsl/XUPpgooQfVKbylCSFxx4dILGUIxI0b4nOdTMGdOSdcJ65xzmPZpdNVsxHjkUfgnEbccGHhLxgOitfVd7ydn+tsdNUvNCvUDNEqvep6naVgyrFoXhpWSEBOALI9zKP1KGmdH2HB2AzJFK87o=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:39:02 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::4a) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:39:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:39:00 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 22/23] arm64: zynqmp: Describe bus-width for SD card on KV260
Date:   Tue, 2 May 2023 15:35:50 +0200
Message-ID: <b4046d2f593047400c190e438fd9d05128c293d9.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT048:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: f31552f5-9c93-4aba-fec2-08db4b129738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Ev3/i0UwMCA4O0zhyJXV0S3CrPF7A3OikKzahV+qAM8jS29ATo2FdHXbp+TczxGxdkq9xDdLJWyq9fSoiOZpv2w8FhNHD83Lh2oCikJitQfYtFLcTfJGN4VnMbFNM+SDkkHuRqN9JD106cpZwBarSlXzXDxAX8+dS+bhr8ZamSgJcA9H4vMyVOLQ2mHIWms58grISLlt2TDHyFm9DpuUd3IEbJbBgghI7pijhfDUz3vBT8ZkUiPq41zEHnUnXoEZn7aKsyYIUvgp58V7QOriLjp0PjmxuN5WpxEVxlw8cs2bTlICX+J9i2v4E/yPQWwlAjlqdawIM+ASIr0YhVDNm1MK8XlLOjlo+t0QoyhcslVnSVoU5JAyw9kR+xScRMroe8v/nGe9XCFjBtgkVetAoFkqXeaVJhCgldC+7aEv342kU89I/ZVSjeKIXjH4uKfX6SgLhGKYXiF6xFohrQytlMNHisctum4W2Ucy6SuKcXua02kTmQnK8sjlbQJxza6aJIFsyldml6g9pqlvFkP524WUybzWkjQr0n9IZRldY+l6jeLmZU36CE4akFAEIBWnvTLVAjinWADrP4VhG5RPkyEjayENMlJLl39NZkcgW/WBQT8vUs0YVfvQVK7UStN8XUDIpBEZy5WU53Rf6SP/hcmh10uVAQdULOkV1T1pYM/cwSNRT79T203b9/chDre7JKhiLALU+2Y/jug6MOwmyhjQb1temIT7C7CTHXOz+ZDi6yrH+E1xsYGo+dCN95I
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(46966006)(36840700001)(2616005)(41300700001)(8676002)(81166007)(356005)(8936002)(36860700001)(478600001)(26005)(7416002)(83380400001)(44832011)(4326008)(2906002)(5660300002)(70206006)(426003)(70586007)(316002)(82740400003)(336012)(47076005)(110136005)(16526019)(40460700003)(54906003)(40480700001)(6666004)(86362001)(186003)(36756003)(82310400005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:39:02.0865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f31552f5-9c93-4aba-fec2-08db4b129738
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD card is connected with 4 data lines which should be described properly.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 776444714fad..dcc51b3adab0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -136,6 +136,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	disable-wp;
 	xlnx,mio-bank = <1>;
 	assigned-clock-rates = <187498123>;
+	bus-width = <4>;
 };
 
 &gem3 { /* required by spec */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 78d082a11492..3384df3d5920 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -119,6 +119,7 @@ &sdhci1 { /* on CC with tuned parameters */
 	clk-phase-uhs-sdr25 = <120>, <60>;
 	clk-phase-uhs-ddr50 = <126>, <48>;
 	assigned-clock-rates = <187498123>;
+	bus-width = <4>;
 };
 
 &gem3 { /* required by spec */
-- 
2.36.1

