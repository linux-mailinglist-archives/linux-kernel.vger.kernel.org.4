Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBEA6F4556
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjEBNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjEBNkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:40:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77407685;
        Tue,  2 May 2023 06:40:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSsrdPlsGWIl/+W6fk20Tt5LYUCOl7frHqyakK459oJmjdZRfimMkCUc2I+l2HFjJgfgVGqyDtp652AtKkkOmgSV+Xjjq9ihmgHNsDAsAtUbSPQHvEsQwOd+3tP9WdJV1dECiYgLb0UbnXpj0y3m4z9pWvn3K2/t3EXcA29jf2BByhca8eSFMQ2cxPxygs6Wk49U4iy79wAfmWqVOpNabGGUa4Ok0aVDYvRnhpWFEpqnitarIgKldhKpUiq3ybD6sfbM6OTohK6g5iOWdSfmCGhP0/SfDAFgz8Ku0YOo2rAqDGRp7P57BQ5v1gLSsbc2/AePTNTgaaW9pTJ/uVswUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6d7SN8DlIxoIw8h6ZkSGJGoGFY1TvwO1W0w0thzW8eE=;
 b=Z0q3IPtIlMN6Gn4gkS9qGnShhCI7VQ1Ea4Hot+X5HM5jZ1OoND3E7qeRkvikYI7YBKaf0kFs2C4x7G2jYlxrHtTDuWAE3RCtcDT2fF4lNO4tHNSMtVetDspLGBeDelykCx6vkqvHGhrz2f8TNnPlBQWn/C8t7+CZc/70EK02Un8/QwJLOcaRdCpN44qre5yfKG1KGVOaTJfExvI//V6z0NFLoBLVKGeQljdSvkKHmQbXMIStiCFGUn5kRJpAHmPvw0zzUkG+yC88HCAj6uwWgBzrJeXsgNT+XzqKmkdQT5NLiTKZ0ZPnxE0FaH0N0uGoG3/orebAJiAlp7iwRoWw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6d7SN8DlIxoIw8h6ZkSGJGoGFY1TvwO1W0w0thzW8eE=;
 b=XQlXcFYOUHY08QUHKku/rQ6yuzKoD38pAhp5tXB1fX0rJpLVS6rFv7LQcpQ/Fgx/KviVBNwAgDjmb3m3/5QXx+M4Kca8EDsh2TBkSsyFcFSUc+GMqKF//fo/zHm/Q9XJqG4dHJR3ohVoT7iApcK8/6mCc6B6yuCjZYOJrz4tluE=
Received: from DS7PR03CA0228.namprd03.prod.outlook.com (2603:10b6:5:3ba::23)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 13:38:54 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::95) by DS7PR03CA0228.outlook.office365.com
 (2603:10b6:5:3ba::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31 via Frontend
 Transport; Tue, 2 May 2023 13:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.20 via Frontend Transport; Tue, 2 May 2023 13:38:54 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 2 May
 2023 08:38:48 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 19/23] arm64: zynqmp: Enable DP driver for SOMs
Date:   Tue, 2 May 2023 15:35:47 +0200
Message-ID: <15d16b4de933bfae108df6ca368eb2cdf916aa02.1683034376.git.michal.simek@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fb8484-1436-41f7-b12c-08db4b129267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzMCtRhsCBp+u00CSekKkb9CcLfLerU2ApoFRNv8h0burdWBT/tbODWj5jDoy71qPLJ5c00Ntt5cCEIl2Ai5o90HIxGnkVOjsqjZCeX7zI1fKK+BpQ8OPtF0aQZEalcuTriM7jmU64IQomAO+N2Mcki4rBMFTeUY8vKy8BT/jqlKJL6PFYEjwd6Y5nGclWKDjwggWLfV3vI88RarueKVPbHHT58SNynsObzCvrtVP6dEIRpK3G7Ayyh0WYADhFgCHOOLJ+drp7Tuoszv67u1AryD4OZ7pIPkYw0Nml71IU8sofL4i6jXXBxgSOwLfxqv7c5/3t1j0daNsRAYVVO4g1wLnKWoDjrShd1KB6UrbeiDjQY0uR0TY/XeQ2uNOE4WuNh/0s+KazziOKg6cKMC3mWd9Alkttut0te1sBvhIVkV+KnQssIr3OHl6WrBsvfkyrj+zr5YLhsM16PDQNdbInwvyzu5Uigi/No4u7tnBl/BjK9dG8Qg/6zJo89+MUcIUvQBQwnVXuDyMVTHneOB957C0FH187yIjAb+W3vHSPaFgDHS3Jz4/MuNfKkFJSNcCQUSxxFg73pNgqH3i4mKw1zLR3LHf1vJK8H0DdnxGovyXYIOCiIanyIwlKpafElBa1rhnewkCPfvNhGIVPXQ2JR3ZDu4yoas1rYSIrhaJQxcrbGf4nnvH+tj5N3fiQWpuXMJKQyYQ/TR2HYbz52xwNcG8wGMFElRI2pFFcoySZwkbxPs7Uoh0/3rH2CUnXei
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(46966006)(36840700001)(426003)(336012)(2616005)(26005)(41300700001)(70206006)(70586007)(36860700001)(81166007)(83380400001)(47076005)(16526019)(186003)(40460700003)(478600001)(54906003)(110136005)(82310400005)(44832011)(40480700001)(4326008)(316002)(82740400003)(356005)(2906002)(5660300002)(8676002)(7416002)(36756003)(86362001)(8936002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 13:38:54.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fb8484-1436-41f7-b12c-08db4b129267
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DP DMA is already enabled that's why there is no reason to keep DP
disabled.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 4f18b3efcced..776444714fad 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -96,7 +96,7 @@ &sata {
 };
 
 &zynqmp_dpsub {
-	status = "disabled";
+	status = "okay";
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 77bc806b15a1..78d082a11492 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -77,7 +77,7 @@ &psgtr {
 };
 
 &zynqmp_dpsub {
-	status = "disabled";
+	status = "okay";
 	phy-names = "dp-phy0", "dp-phy1";
 	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
-- 
2.36.1

