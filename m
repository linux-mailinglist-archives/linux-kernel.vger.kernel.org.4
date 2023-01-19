Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5380067305E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjASEal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjASE1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:27:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FF4FCEF;
        Wed, 18 Jan 2023 20:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUlTwp0oyOAzcjWDx064p6L36G/crm2YxlvVtKFChEkOG3kM4Vy3N414cbTMp+I4tnGeXC+j/kbJ0ZkQYCrLph/y7VLDpitPbI9Jk0tuu4AHkArtQhL0fN8CGNoPw+IVbP7T0S42MJraiIvXf5TxhCY5i+LHAt73BFBWByOtur51gGQpNAqu8KJoO4kzbC8w33T5PhF3vKbiAOtDJr3S6ksZ4es6dzjatPxU6WO6Y4JA7dK4kEqtPmtzglNdQT6EBFNioZ0I25NYitb8p75R0Wsyk+kv2NQ3iV/RXQwWFfXzkgfoUr/7DwNPC5pmZCxJQPDxb8/8tqSIcbrP/dxfPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+7zok1V1K4O5OkPHqePWWhsaVAgAl7DE+PB8/1U13I=;
 b=Agi3UpbdNj6WDB3y4DMHqhTM2H0V85Cw7DF5V8NF5PlxowRuWdFrVZp9fOUj1vF6fCON9ANASOxnJsxLVsOlpitpDxunNf2kTdyeryEM4g0H8MTnO6i1DCBlbvqyPOwRFc2J8ApTpfRrdtw1O9sp04/Op3CQHuPAYiWfl/ikKc0WC+A2y0RKs/i4wmcP8fmRk2AFFJP9PRBcRwLuZeswGiljhbL4vC8KGkXwyKsjg8U7DaG+nhRj4r/APWpLR3iKo4D7VPB2LuwB4D1PL+xmjuYcALfjiYXUjtPMfsJL+ynBzPnjDhoffHAlioK5xf/DMBPpXxb6KeKrKOB4pUCH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+7zok1V1K4O5OkPHqePWWhsaVAgAl7DE+PB8/1U13I=;
 b=n6llflVkMHvD+z2HcM+PzrRugUNJXc9VkrVQRDl/Re4Y0t0fH4y2ugUwYbcydZUc+21QUCZ8q5J5lbHYHaWuZ26QUpCxKjUhLFeJiYLAhcMxswbKU1sMwRyD/8AdZP+jYzFzInZf2Ngk1AO7RW7TbXPpLJ54LywFUTePFOBIopA=
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 03:52:41 +0000
Received: from CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::dc) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT099.mail.protection.outlook.com (10.13.175.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 03:52:41 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:52:37 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 08/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Wed, 18 Jan 2023 19:51:29 -0800
Message-ID: <20230119035136.21603-9-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT099:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7784123c-8144-48c0-9996-08daf9d09d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdUbyVhH+t1CsLwAS5NvS9atJKwqfvzdDcfP0SxAx0HRt0SO5td6yAC2sR/KGXnY8TTwtixHaxS5lrNo0KUtoGhM6hWRT4TeGnodkZiBcL7ttl2eNLeuWPskORj5iTCEee9D9yumJpjS4W7HtjP5ezHeM0ajS/m/vhnCzqwLXV+YsR7ffrodOYUuPiSeLntaWLiRLtRXhtJ62bTQW/P8KAQq5y+tFjWICUYz46FxNvu27ulDEFaOXQQ/byvRVigF8ZzGfFwy2bKGRV0XjH2HFmJp1azWMmUrbnRYg0/NuHvAnOwKBN8k48bYh7zvT33vGiysrAEeI7wL+PEzkyEOKMY57Tgusp8C2oFT9/7ygncXl3O+jdjYg41jxswkO8VSwK2u8QI/OTBtP1T3s9bTUJRZLOkQn5jDJcjJ31g5Rluv4RbSapxqauy7CFPsoUqVL71aD/i3DjtgvcN+G7/Iuq+LA5zppUYWULfJjZ5t0AiHSsPY58BK0oZ3dXg0M8Qu0EVU2YHRquDTM3FvdKQUw9nG0N9hiStG+eRvtRtDfNbw1lPACjZ7bHHS7pe4o0vLrHBtZXK+X1oAkce5SyBvg5LcUgDkVZNjAPKuVllvvjkkMqxj3XGgZOOvsUxM9BAII5nWvzFxOdqMV9aZ+EkTaiI3elEOpxq3jTW8H5mbdtNhIzTlVhOVOnTa4amDy3a4gcUgXJEeRJxIUITxeFoqaH5/lCXCMSnA2ZFdeUxzvxk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(81166007)(70586007)(36860700001)(356005)(5660300002)(8936002)(7416002)(2906002)(4744005)(7406005)(70206006)(4326008)(40480700001)(8676002)(6916009)(41300700001)(82310400005)(40460700003)(336012)(2616005)(1076003)(186003)(26005)(16526019)(47076005)(54906003)(316002)(426003)(6666004)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:52:41.3323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784123c-8144-48c0-9996-08daf9d09d5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ARCH_PENSANDO configuration option for AMD Pensando
SoC based platforms.

Signed-off-by: Brad Larson <blarson@amd.com>
---
 arch/arm64/Kconfig.platforms | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1970adf80ab..11d4f73cd341 100644
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

