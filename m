Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0340472247A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjFELYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFELYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:24:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306CCD;
        Mon,  5 Jun 2023 04:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmxGpPEp7XQkfv1W9WDt6nfXb+G3X8/sf3oxEBsJBc9Gkfu9VncpdeWzU3UmRH5Am3cMrJ3zCcgtAzlza3xzeB5u7nTqYfSGD/nVIhLGA3AgS+SYAibn4pOE8IC3RYBNKFVJtfghxQCP0yeBjYbSwK4Gm55e0O4wUlqExHB5chlqHV7+b04p/QtnyZanBCWvsteNCtPOtXP4DzPrgrSPymHAMtcN42YZCcyR33MNDsOHc/VyC+jv9M6yrSuhkjm02Q7NlFW0MP7fQNSrD9cbIP9RuA/nEsu2dAdvvR+pFAGNM48wvteuIaKpgRH9sCivp91qa9kIZwvTKQuKRiQzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhEjj2HiKl08QYLRV6HoHyG594YA/egeTP+J3XGpq0U=;
 b=XNLb4CYLyKAEoeYDUFuQ2UgPigsN4HpJ7DzOKOywbDKGY0aSfdw5ym+cYHfiZkOGQhVAet6UJjG7N+YWMbyWCetZcQH9QpGOHIZibYyinVtUoNdcMDoe13QMm4x8eVJjDjBjZ2RcxqNZqze4/WE3Kqvuq8ae8hEd/DkBO8Ms3pHW4AH97iKR36oeEWOCbLK5ckOcOibMDrr/WvzyO/1Fr0ry5OnF0jLyQmYwAWcTo0lfPFxJdPasRajWeSVmIwArUyd5PywvcjXIKdx2MQlKMUluAu6QSgAFWm4R4mN+klC/t0IDVCG7TIuDP4CeTZNMDPchnZysgBs8GaMLLKqKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhEjj2HiKl08QYLRV6HoHyG594YA/egeTP+J3XGpq0U=;
 b=ZUb3OpvrJWR7cSu3RSECYyPxtZbuPExkT8sMajIVAczoS+wYsO8U/QL6E9w0rt4tQBWDmRvNdAEgn0AIJF1iZivSLmCXG5WHP/B56JZCxeiDyzorRM2jC9QYj7/eF/0hSdyE43mKFd58cLxtkOzzBTwi51AXpJLnAvadc/ID5T4=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 11:24:38 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::ef) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 11:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 11:24:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 06:24:31 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/1] arm64: zynqmp: Add L2 cache nodes
Date:   Mon, 5 Jun 2023 13:23:58 +0200
Message-ID: <130e5a6acbee94809b63a61cde5450fbff88cc9c.1685964230.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1685964230.git.michal.simek@amd.com>
References: <cover.1685964230.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=michal.simek@amd.com; h=from:subject:message-id; bh=YwbTCh+jeWKcH+pAt99JaRdQzbQqXK1Kh/r/P9hHPtQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTao6cFJW8dfDvVt3nttZl/F61gjXl1a+kClU/2U0ONP s5a9fFGZUcsC4MgE4OsmCKLtM2VM3srZ0wRvnhYDmYOKxPIEAYuTgGYyINohllMq5asXBvkduLo N31Lc301BV2HFwsY5nBU3mj99TokteHivW/Nfa++H7y22A0A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT006:EE_|DM4PR12MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d6da96-3667-4922-a49a-08db65b772b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47do6mTWtPAfCNW0e519TEJ9aEffd4CVDYvKgGwMSLxn8dnHJLXESQttD0zroWCEmKUEhX/s+wPavzp5CgETJM6AeXB6gOHHO6UR0UHJtxmzueJ5DFSjrfmRcNec3UMgGCTEurTai6h8fVhI8lzLuGfrARhzui/yaXQnV0jvC25eimWoQS5XA03gqGl0rzI07JfOgBYc4xNnSLK16w9Yqy10Exa45IX8NoDEvT6F1PcxClPcwKihSteaVPB5XSbsDBON7kZ3GS8GXZuI/6T2OLBCiv6n0OU8qWnAXdU3UipKrpOdqX+oU4QxIeAYx2Lm2LxlY21yBMCtcvcAD4S/v86W6W3ElMv79MecV/dzvUptWd1esPtj/FapqzVLRv84NZ8Z9SkTLuDvv+MLOSm74zyYO71t2zWf8/+NCl+6P/qvDDjdbyRB6++rMqOPinfQVGzaFsUxIfygHEkygIHGpjqVVgXuioCQtQXkn1Eo3Oa7yVpldhLm/uVBgOk2MQkbMiWJo0kvokfRbrtS3J/UeqV6QAFlLUg3b7SgyClUFrWyPh3QOZfrdJIR8N2E4pfBVbXdm8sgur6Vqf35Pg5kB1q5eQUIzjVRCh3TQrDHfBbmMUp3eIEZdF+DZ2+8C6awgf2NSHjkTr8KlGEgkjxEGAUEvYo4166LYfZ3dnNjUyyFlB5czezmpTWmiTRbbz030a1QysRYcURgftSyDPqW+qegSoxac9QsZs1EfIASt+1Rt9JuONPuEYiQrnssEVTrg5a7QfENNhlf7A12qgZgnIZy7BYCq/s+V49usLCzuDI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(6666004)(82740400003)(2906002)(356005)(81166007)(70586007)(70206006)(36756003)(110136005)(54906003)(8936002)(5660300002)(44832011)(7416002)(86362001)(8676002)(41300700001)(4326008)(40480700001)(316002)(478600001)(40460700003)(336012)(426003)(2616005)(26005)(16526019)(186003)(36860700001)(82310400005)(47076005)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:24:38.0344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d6da96-3667-4922-a49a-08db65b772b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6063
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

Changes in v3:
- Add missing cache-unified

Changes in v2:
- Update commit message to remove Linux part - reported by Laurent

Linux kernel throws "cacheinfo: Unable to detect cache hierarchy for
CPU 0" warning when booting on zu+ Soc. To fix it add the L2 cache
node and let each CPU point to it.

---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 02cfcc716936..394db49ac6cb 100644
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
@@ -60,6 +63,13 @@ cpu3: cpu@3 {
 			reg = <0x3>;
 			operating-points-v2 = <&cpu_opp_table>;
 			cpu-idle-states = <&CPU_SLEEP_0>;
+			next-level-cache = <&L2>;
+		};
+
+		L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-unified;
 		};
 
 		idle-states {
-- 
2.36.1

