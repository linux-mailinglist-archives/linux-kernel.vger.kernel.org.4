Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C323A6F4524
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjEBNiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjEBNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:37:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364456A76;
        Tue,  2 May 2023 06:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXwIf53hLzedu2Wk2wghQlMUKKhgkI+6q+4C5tmYH4kvY9OeGpWxL/mWOMkSdEE0hYT/Vd+RQaAsVVbqoY4DPGAJAAHpHYk2BW5+dyK0cKR5Tv5hhXwrRVbeYxpDlW/ehqnGwIS3TRooWmpZvQhYEWNnzmxd1doluuUQcLJRQpx3KtqGlhUTKZDK+0idO1iAV/HKkSW3GJQwDiz0BesawlvOfOdNxe3k0zldiwCbg6DRqAVSM/HGYUopVp1kIXqrh7d5TQgfI+aQ64aeL9L8yVhXlSR9RbhHBt93pqRB+zkZyJZfrBwDRD454Ohp7lnim+w8SM6J/YXcybn9WSE9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRtMoRxiGch82YUC2TqCrzUaN6TEm8h/IxLWNZUXE8g=;
 b=nZS+8G7jCF/mnr+++n+4qjUx2uJSJpXIkYnBL4OgJPuvSLOVsEmDtgw4CVekAVDlmZpsmEaTNhuo/mirN8ivn6UawBTn3rYGLFvWT1EsBxjkuNFRGN3UFHZ+NtAWlb3M8kUqLbklgSuZWsfD3HOHwWUaE+ga8TsjP7Hx/m5KBKVTZMlcdOp6jvpQLPTCB2jU2zUH39l/qdXUzk9gMNGVmqDa3/C7B1Tt2FItlU193CkP1e0FZkprhnUOebeNJHpzE1j9evZYeDaQE50j0t4xytJk84zSeXhLBh1UXaPPY49kpPREZ0PDMWVTunTi72J3VkdOPtL98APNpABZbaTKFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRtMoRxiGch82YUC2TqCrzUaN6TEm8h/IxLWNZUXE8g=;
 b=m4MHHJNqVtNVaMWz+n5qIBRdiV/hmqdZnKQRxCRCU2VgJWYtftIW84jHKZT1ZIHcYzH+E7EauGZU2huJzroFQJKp1oDyR0FrQ2nNyMU9KcNZHdv+60T9N4VwLXbF0J7bQTF77EhiSwutjtjbRAzxbGo+fwRt82fsOUJmFIk/rgk=
Received: from DM6PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:40::34) by
 MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:36:48 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::38) by DM6PR03CA0021.outlook.office365.com
 (2603:10b6:5:40::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20 via Frontend
 Transport; Tue, 2 May 2023 13:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:36:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:46 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/23] arm64: zynqmp: Add dmas, dp, rtc, watchdogs and opp nodes for SOM
Date:   Tue, 2 May 2023 15:35:37 +0200
Message-ID: <5d3777fdf91d114effe1921255a7ad71ef30d277.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f82ebf-6ab9-4f26-ac2e-08db4b1247ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZBqqUg1gdr0hTsm+fj6IhkqJw/mHt6LEFHtRhEuxAcxm9DR1mPXQN4JTuKzkqvj6y9n8DNwpeF0SyI+JjrqqcSqC5kPzwy9q6RJjXKrgk1djKGLfSb71wZd+UpqFc6Bd9CiczIWMJBZastswC3hGWR22JNCbo8lWONCyR70x7lPFfxnldjU4G2yrPVYGKUYOhQDuZoTsv0PTUi+NrFShNgcoS5WzM2DHMj4/IFzA9qPgu/bxlDYnbLS0sEDtb0FX7uuo9Htj/FloObFIe16Qzr/rgpcrB9rPTBFEyGvfsHmT3w4SaUeSgRWSq+RYtqrDXZ6hZ2BazWs4RfH6ixBERbAlsAlQrK6uGFQGxKOz20bSPgVmaMvFzz9PBP7XoelyKW4XR0ywcMbbiw8s8XUzXVR6sT8MmBJfG+tZYWOxb2QrhKGrUcHdh++q02H/6UdvSsAgxJa6K02hfqitvxYThzyJ1nvt0ITSMIBCQb6hDTgByBfuCnBqldsBHQk5eDt6CKxWme5ZZbJ3MrRzdxQ1GQYicP79Lpg7QDzq/TAuy2aa+oS1RV6vyyiZyYQ0HAfTCWT016IfvS1xmEdZDlm/SYbwYvIMYy6kFKUv5p2gd9QktN6iS0rOOixXov5yVCZUvZNhxr/xMWDXRlxJWWdUgFSFZizaGhSb6a8eRea3Mp9iufJ8lc9A4ZftlqI6kV7MGVisL3b+8hHR3gV0bdiyDOCYxs6qYsKscdYG17M5XVCZxju/fnA8LRZGiBOz5D4B
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(316002)(2616005)(4326008)(82310400005)(40460700003)(40480700001)(8936002)(44832011)(8676002)(86362001)(16526019)(5660300002)(478600001)(54906003)(70206006)(110136005)(426003)(336012)(36860700001)(26005)(70586007)(47076005)(41300700001)(356005)(36756003)(81166007)(2906002)(82740400003)(186003)(6666004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:48.6269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f82ebf-6ab9-4f26-ac2e-08db4b1247ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are couple of IPs which are enabled in origin HW design which are
missing in SOM dt. Add them to match default setup.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index dcc17e3ea961..3862168fa026 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -288,6 +288,101 @@ &gpio {
 			  "", "", "", ""; /* 170 - 173 */
 };
 
+&zynqmp_dpsub {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
+};
+
+&lpd_dma_chan1 {
+	status = "okay";
+};
+
+&lpd_dma_chan2 {
+	status = "okay";
+};
+
+&lpd_dma_chan3 {
+	status = "okay";
+};
+
+&lpd_dma_chan4 {
+	status = "okay";
+};
+
+&lpd_dma_chan5 {
+	status = "okay";
+};
+
+&lpd_dma_chan6 {
+	status = "okay";
+};
+
+&lpd_dma_chan7 {
+	status = "okay";
+};
+
+&lpd_dma_chan8 {
+	status = "okay";
+};
+
+&fpd_dma_chan1 {
+	status = "okay";
+};
+
+&fpd_dma_chan2 {
+	status = "okay";
+};
+
+&fpd_dma_chan3 {
+	status = "okay";
+};
+
+&fpd_dma_chan4 {
+	status = "okay";
+};
+
+&fpd_dma_chan5 {
+	status = "okay";
+};
+
+&fpd_dma_chan6 {
+	status = "okay";
+};
+
+&fpd_dma_chan7 {
+	status = "okay";
+};
+
+&fpd_dma_chan8 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 };
+
+&lpd_watchdog {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&cpu_opp_table {
+	opp00 {
+		opp-hz = /bits/ 64 <1333333333>;
+	};
+	opp01 {
+		opp-hz = /bits/ 64 <666666666>;
+	};
+	opp02 {
+		opp-hz = /bits/ 64 <444444444>;
+	};
+	opp03 {
+		opp-hz = /bits/ 64 <333333333>;
+	};
+};
-- 
2.36.1

