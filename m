Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F370C1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjEVPBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjEVPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:01:01 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09902FF;
        Mon, 22 May 2023 08:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd+NcGYhp2qkrx0f6H0aM4ZT91dMmOysNC0HqPclFWxprQ8tZs5ev3QzP3r7JQaIM3gc84L7OmK/0urExG92K0/Iuh+/ihqHV00In1Y9E2BVhtnLpWJ5h3DsNbXobOkZF2oRaJoKBknfVxE1AtltJ+ca7e53QKXWKDqAfMDroG2OwHnlMM/d7BRbq1BW5ejoUJa+Wv4tPF2PcH8/qyI/7Sm8BZmsE4sfe+DSYsku+/hoiJioRC69++9VKpcwK23kibD5a8qcUfhRvV7C5g2c7vY++Op/Yr/75jSLfdr57uUUJUuhOIXhIkBQNeuDa8PKkLnAPerIPYZffKY6tAdPCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVNuQUM1uYFgBjPmCO/OTEjRstWFNXfcrZIEj34aSiI=;
 b=fvX2EyTfldBJUifOZTzEwiCK5+iTkkLxC6mdhOW+hP3QLBECi09n+9u1PrgbgkqCErFSDtnIz0yOYMx4ik/Y8APJ15NtZbfN/+h9V/uJD2j9EUoFlDjESjMbwKFzt3oCbxUT7zem8DIuCz7bByUoFf+xuDrs4sCz7nQ5mYeifp1bhifH0xFHUYX+sqT0bb+XoIIDYesZ3/36u71PRJ90ytk+v7mXqIy4wGtw3ibULEVUmm7+cm9l2Ri77ZoTHD4i6D4vr0FeFH7yiooIbS1rdeQq7RRUdVT3Pe41w/iiehXnITSWpDVqj1SGAKfnZIdRAQH9dnH6V0DtBxV51MKaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVNuQUM1uYFgBjPmCO/OTEjRstWFNXfcrZIEj34aSiI=;
 b=YCYBeVif5qvqE4UOoF+v1ZE7nMWHvixdawajH+m4hWD72Y4zXQRlNbVJ8x27LtiPBvRP9MgBFgYKwPUY+8xSB6AYH4fnnFcOG45VjX8zJJJImY7WSJquYtHIeBKfPEchFm3j8DjOU0tYIvWebGVFN5wn79JngIRw2vvT20U9aes=
Received: from DM6PR03CA0008.namprd03.prod.outlook.com (2603:10b6:5:40::21) by
 PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 15:00:40 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::97) by DM6PR03CA0008.outlook.office365.com
 (2603:10b6:5:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 15:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 15:00:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 10:00:33 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 4/6] arm64: zynqmp: Add L2 cache nodes
Date:   Mon, 22 May 2023 16:59:51 +0200
Message-ID: <d962547cd72286821714b45f52b0126f9c438919.1684767562.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1684767562.git.michal.simek@amd.com>
References: <cover.1684767562.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1616; i=michal.simek@amd.com; h=from:subject:message-id; bh=aRFjcOFIfT3sjxmmYR0+S2JqA8kTwZQdZ9ysjky5aFM=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTs5rhjqXtu/2U4vdo9fN+E+h9rDe6vUo389Gv37sSJ2 TZd2oXGHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiVSEM8/N8rO6HdF4LMn+l 5MOx7aDsTLa30gzzfZ5F19Z/O5N+h4dDU3PWfP2fpje2AQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c2c5ee-cdf1-4cc3-31f5-08db5ad54def
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhKPIgnuqHeRTVzWdiTQ/bEYwo6++EIEuhpa2dRfnZL8evQfXNgNe33NyvfLeJOg9e9l/e6hDBcbeFoDkJrv5MsicGlQxutqtd3EX1hwzLRWF24K9Fs2rm2Ngcbr6GZb6uRIbvC0AePPcvYcb4sfSq6a5ldoOjGrLVRphjPhY+6QvQrsxpftAYkfO0dXtxbIWetnYIheY0+0im2IFsDcbOsKDKpYZAYD9LI5iaMQC/u+oghqlcXMzrsCu5YBhoHW5B7tE2Bv7TznRg2Prl1VWq8bw3FJlBcYAmOfG3js+p0MzM5tp/sKrSjgJ0fNbYzr+YUebiuTkmeTw1SIbAQvmHFpf62XNyimMnSHR0o/O9Qv/EhepPARip9h2/P3gzai/YjGzfN/Dv/GYW1SVD+PTyhvuIjwtLKHrug+UNx1eWBxBcD3sOgtuUAcwim6xC07kYsX1yhAGkJgnYj2AwxbkQlES4dR5i1Nz9m5lksdbEaJyE3E33/sIEM53XeIlinBTX0+SkLb9RXCuxYZP1JEMx0SS04o9NkY2hiFAgRnn2JXYbn/2lgDs3a1CXVVqQULFHxFlm5P7KdXUAM2MAG6oczpztIYjZCoboNr6/q6E0ZitXnI1K+hplLghZZEeVd7VwIiayk5uMppU2tkig37Uv5GH1hXdIi8PlWT2He0AEq0w7x1WVTl8CjOEEBNNRIwBmioSPkrYg5O5Fu2/nkXgm8td7XUWzTv02xaK5EKiCjXz2P2V1iDzgJuQL4FOCt07c75OutiSpUF40VWfbVdeFxs1J0s4rHbryPWfnLMkU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(4326008)(86362001)(2906002)(7416002)(40460700003)(36756003)(44832011)(5660300002)(8936002)(8676002)(41300700001)(316002)(40480700001)(478600001)(54906003)(110136005)(82740400003)(83380400001)(81166007)(356005)(6666004)(26005)(186003)(16526019)(426003)(2616005)(336012)(36860700001)(82310400005)(47076005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:00:38.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c2c5ee-cdf1-4cc3-31f5-08db5ad54def
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Describe SoC L2 cache hierarchy.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Update commit message to remove Linux part - reported by Laurent

Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
node and let each CPU point to it.

---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a961bb6f31ff..02bd75900238 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -33,6 +33,7 @@ cpu0: cpu@0 {
 			operating-points-v2 = <&cpu_opp_table>;
 			reg = <0x0>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2>;
 		};
 
 		cpu1: cpu@1 {
@@ -42,6 +43,7 @@ cpu1: cpu@1 {
 			reg = <0x1>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2>;
 		};
 
 		cpu2: cpu@2 {
@@ -51,6 +53,7 @@ cpu2: cpu@2 {
 			reg = <0x2>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2>;
 		};
 
 		cpu3: cpu@3 {
@@ -60,6 +63,12 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
 		};
 
 		idle-states {
-- 
2.36.1

