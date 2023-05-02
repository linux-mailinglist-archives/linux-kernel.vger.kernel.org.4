Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0536F4515
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbjEBNgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjEBNgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:36:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4844C6E8E;
        Tue,  2 May 2023 06:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI4qFiV5M+/AbmOTb2ProtTUSIGC3J71+mu/tSRBom9iXCJHCAfuP4URS2ki5BCplWo9oQ1XVksvX7eVUDfQlbHyQtRV79ihkGOo29Vnjd9y6U4thGgOq7QaziqObc6LOxrAMbiV/EcBts8CLd0YOqB1TFDEUkBKB7Opupl/OAqPLhwIDqgjytUa4bNU9VOvuoS/tlVv3FA+lxxYcR4N/KSvs31EcpIebuKrZJw960MRka1Iy1Gg2r5DTwZ36W9keO5TOIE36pI+iy4K9AIkvb7hN42glofJQstznvw0YGNqoNmSOZ/wyNuhcl/R+pRr+88nhretdv+FxwOYI+MKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuLkITE3e3K/3zPWJ4BQyWtIhiqtVvKTzsxOR9XEff8=;
 b=mKLyX4wwovKmOSOOz95Qy3scGo/GAECNaYEPrH4ApYct2qu5vPw1nNWIEDYg+ox1II4wJWWkqLq3WP7t9Chj5AFhasaHA1oG6U2VZhGidw+0HRkDftsrv9IJgM29MDkycP0uCq1sd/xC0d8KUVcVQzLHzFIuRKmY9Er4Imyit2EL/mk0BjzwZO86f+ZdxQM51nTflxQCI7z0lr7U6AsE1VTlhrs0xFggCewyvZVglGBl8yI4Yn3L3kh6Q3u17U78Vba974ACzGRKsEaGU98cfcDq4HUERQTfjEemps7W9296HIWsKf+iaANdySOglxp1hu8S/wNT//i7IZUy4vVw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuLkITE3e3K/3zPWJ4BQyWtIhiqtVvKTzsxOR9XEff8=;
 b=LiIv8WNOK+lV0BV/W1OIfAafmxrg24EbjOnATUm334YCz/GTNqChrSqYt7vHCz0rv2yGdJRKR+GJndoK0UM/PpwNfviNC9uuB/CEETaYIaF56W8veHssES72qh/2T1ehPbigBK5mliWCX984cBAxRFx71BO3wGz/zjLSB6BeI50=
Received: from DM6PR10CA0013.namprd10.prod.outlook.com (2603:10b6:5:60::26) by
 SA0PR12MB7075.namprd12.prod.outlook.com (2603:10b6:806:2d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 13:36:16 +0000
Received: from DS1PEPF0000E636.namprd02.prod.outlook.com
 (2603:10b6:5:60:cafe::6) by DM6PR10CA0013.outlook.office365.com
 (2603:10b6:5:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E636.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.21 via Frontend Transport; Tue, 2 May 2023 13:36:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:36:13 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 05/23] arm64: zynqmp: Add L2 cache nodes
Date:   Tue, 2 May 2023 15:35:33 +0200
Message-ID: <cf4ced33cb7dc8d43b79bb9d4ad6acd3b8ecc09b.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E636:EE_|SA0PR12MB7075:EE_
X-MS-Office365-Filtering-Correlation-Id: 29505f44-0d7d-4a3e-3a2a-08db4b123433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o5FpvT1PT6gk38hELV2/cson+ItdbHeUMuLVvxMxOq+PBxlmqb7CV7LcylP5DIYU74gwNCL46/Pq1xA6+B9VJ5nAwsgpDvOSqHlEAETIavZJ3AYROSFUZ9HQ/jXJBR+KRhfThF4p37QLarP9QqyvefstqS/Qv8HeVwFhBcwoevN5jKl2eJYgdBstpwG47Op1L+5+ef0WBpXNU/UItvJ23o275YQMsFXrBijzZ9I8TV2nLSF4PF1KzqIhn6+4Im5H0UqhQBHsWYde5iT8qMkGgOZhNCJfGpebNfQ3fwIjjQLZByXT53si9a5eTEaP/ZDU04pzAiuBw+D275cw6Ma5wh5s7pCv/nPcIH4FzpHqscR+9yryLt09GcGAwT1Yfs+8svFttn93xb4qyXcUrAKlG6PSE/Fbv+/vrQa9/gEGNHvzURXVziEXOfl4aWdcMtfUfntd+5akejZiWpsYU+VxeaOUXGECaMAa0AO1oGvPICaNgMrVo4/+oKuek54szZCtUZ76wOa0vT8XgiO1mdU0za6caAUNJvJ32MRvFRGwxQA/CpGXLehyqSBz22RRih4fmDhruOYGMyY81/5VYbhyw6Cw2L9MD5RCA9aGMVlq/ww68awECJyStkMq8pKRxPUBAhN1FriV4ycRDklNMcIIn+DRk56SZu5D9QWREWwGG9o5sbDtCZ43JNiMuydA0FbsRz83hL5w3qjn+zMROhd15Q6A1V4NXr32q4wvOaxUnq6ZcreLzq8vGfQ+RXSsauW2
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(2616005)(16526019)(86362001)(356005)(4326008)(41300700001)(82740400003)(81166007)(40480700001)(316002)(83380400001)(6666004)(82310400005)(426003)(336012)(47076005)(26005)(186003)(36756003)(54906003)(40460700003)(36860700001)(110136005)(5660300002)(2906002)(70206006)(70586007)(8676002)(478600001)(44832011)(8936002)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:36:15.9542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29505f44-0d7d-4a3e-3a2a-08db4b123433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E636.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7075
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

Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
node and let each CPU point to it.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index bb0d0be30aa0..c2d80c7967e9 100644
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

