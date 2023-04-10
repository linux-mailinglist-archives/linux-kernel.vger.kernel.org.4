Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E76DCB06
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjDJSrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDJSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:47:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786B1BF1;
        Mon, 10 Apr 2023 11:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf7MOgLG070IrEvUvo3qdZytzRnNtSQrL98ffGJBRzfNwJ0Swue7GBz+zMBSRCS3XEKb/jmMGcukct71/yycfVqIjMuTcW12lKMAjgQ50VaeXU2MtVF1VONzxhSP3ksFjzRaG7YTGXg3C+UapBkf421KsjQi6OkeYhVGWi+AYedGavoqKP7pcf00+TmL1TkPYVrBY2DuRwb1aOBT8hDNILkrq4mhcMYtu2z1gCcCu6nu0vFVgZO5BXKE/E7lKBEKZ2QMT9XWhSwU8w0I3hwiLxYmWdKSdojyaIdYsZH+iY49esbcnuZn2SveInnNnlbjH+mm6/826XQLo/quBgkGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=NVakYvC7UmgtF/qM0E0RjqV2Wpcpz/YU5nTYclczUE6GH2UxSpnSkoHqCFAQOmWA42Rdn7BVL+bYzucpW7BAhYvCxCu0zvoq9mCiPveZ0Lg8RrpGXblItjkvV/ThjCy9VcBh562IC+djJ7crxOi6Kg2xIL2gT47u1vlDgUbxhFFJcEwidVEMJHSwoy6cfhdFUnwuPpLk8X2ebzH+BFKCinxRjZNKW+RWzECgqiMacW/L2IxoiliQLUBOu8zWdq7GORPIe+78S/Trdl/E0Rs1JWxEffplcdn8LxK90bEx5tGwooTmD6HSIIhVnpTH83CK2L8EJAikfFTPhUr7KW49oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=1/TibCQ0yM0dXjNuZDOjSHS81CAh59+TZZmMTYRtraoR6jP8M1YwQTnKRU9uaaZCBmzMhUrmIBcpi+DeTrAYdMDA0NUiaIjxQju/d4gi0v2+PCh5oTKBGzbY5pHKG0Ows9r3PzStIOW3e4rYfX34wlXmdpTGOQbrSCUsO8hKBTI=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Mon, 10 Apr 2023 18:46:52 +0000
Received: from DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e5) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Mon, 10 Apr 2023 18:46:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT105.mail.protection.outlook.com (10.13.173.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.20 via Frontend Transport; Mon, 10 Apr 2023 18:46:52 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 10 Apr 2023 13:46:48 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <brijeshkumar.singh@amd.com>,
        <catalin.marinas@arm.com>, <davidgow@google.com>,
        <gsomlo@gmail.com>, <gerg@linux-m68k.org>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v13 07/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Mon, 10 Apr 2023 11:45:18 -0700
Message-ID: <20230410184526.15990-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410184526.15990-1-blarson@amd.com>
References: <20230410184526.15990-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT105:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 733c75f8-1ec3-423b-334c-08db39f3f311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK3w+raXIpPYEWi845cU3L43kpA01de+5+BqN2W4OtjwUXFHtsqhmj1bB8AHGx8Sz/hGAXPAJaNXMm4PVqCm2jinszvohOOjokpyzsE4AvUxaXPBqM4kXKtGTdeATXWDuvc9nrhc80pscqgxFlGIOEg+fCpqZNfAgrrTtA535pUauRFEGouQJHSdM/+Cs0vG/GdE3vKAerlIJf/eyIwXYt5GcVDWr12copqggdGjXm6oowLKpUyeBoomu97sztvYAaQ7nm8cFElqZRJ5cKxvRjHheE6x+RNzXpA+o5p9zt8CXppE6pBRm2pc4ctnPe2xBMSZR9p85gUZ+MtfJc1FbngdnFCtgQrE+a8mcC3VgCl2cpfwcbJVactCScyctNnVCsThwwIrB5zGwznQCr8Z8OEqQQ8SJ/raHGdzv0A7r6bGWN/hO/YxqayyHhSyXkxcleEzVVpWS3M+tUOn0fOBDXFazDtDXNgpxmcbdJUpfPGSpnDQIMaRx4HbjdBhNc5O4ouf9jCfr4PQXMcyiU3a3lpAuLWJDlQyGXHiSJKT3FFvHsAPYNsYIbOButR2o016QkbDUx16/UEnueoZ9qkpk4SbpXVVGPvbe0ai9T/7lHtRfkqPVvVOLBPbQPvErJOXJE0Xpq44SHLk8xiF5lD2hxwz21fOCCD2TukcAGVYUWWGN6965JxUxt4gA92JQuvGuHQDM9o0sQtmT8CJ7y1Hj4q1lcHauO/6IAL+wYBgzyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(478600001)(40480700001)(47076005)(40460700003)(36756003)(82740400003)(356005)(81166007)(2616005)(36860700001)(336012)(426003)(6666004)(4744005)(2906002)(54906003)(316002)(186003)(16526019)(26005)(1076003)(5660300002)(7416002)(8936002)(6916009)(41300700001)(82310400005)(8676002)(70586007)(70206006)(7406005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:46:52.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 733c75f8-1ec3-423b-334c-08db39f3f311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_PENSANDO configuration option for AMD Pensando SoC
based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 89a0b13b058d..3510daaabe27 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -236,6 +236,18 @@ config ARCH_NPCM
 	  General support for NPCM8xx BMC (Arbel).
 	  Nuvoton NPCM8xx BMC based on the Cortex A35.
 
+config ARCH_PENSANDO
+	bool "AMD Pensando Platforms"
+	help
+	  This enables support for the ARMv8 based AMD Pensando SoC
+	  family to include the Elba SoC.
+
+	  AMD Pensando SoCs support a range of Distributed Services
+	  Cards in PCIe format installed into servers.  The Elba
+	  SoC includes 16 A-72 CPU cores, 144 programmable P4
+	  cores for a minimal latency/jitter datapath, and network
+	  interfaces up to 200 Gb/s.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
-- 
2.17.1

