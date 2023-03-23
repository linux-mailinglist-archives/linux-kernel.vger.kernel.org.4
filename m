Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199286C5B10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCWAJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCWAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:09:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF0630B08;
        Wed, 22 Mar 2023 17:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1q2VkgNNuKDfQfWpvr32qLoUiKGR5WgN5hiwEDzjMAbxKtWWxdDUDrEdeceXlS0gaCyqjyBNukzYmYUGs4EsKHERZic9Rjid7BcdipOwQeON5ct+KnDOnGSNJ10XEfw0HNazxqr+cXRbqltrWf5cTWM1aREoefP/oqlfn7YyNl/RG+PWXRgcfIQwEoBYmYVGj8P1l+ObPm7c3gg998xZTQbEnseFGRpmOAveaINFRH/e6zFLNZ9Cs/IrDRqJvefg4Rwc6qSEs+PAT34op5kE0MjQlmpLlELkskjDsonLHIyY7C86+qna7aWA2XReWnuFA5R6VFjhanvX+O+fEvyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=I5oMc5PYqHdWfWirAxVfqOyT/5n4Qecv768rihwnayu8KlUro2tjg3pqO7c71RVaJH2779oCrgL4krMgcW+wdKMABZPT1t/femJUXSQvOoKwJUAAkDbbyHgTqtLyJKVPQ9i/ZYH3DLclGyIFvayji2DF2G8oAcmsH1xses887S1TaPVeGCAFF5dSw7y94+21UDC7cvbYEWc/RzfU2WGwMRvsMS7o2Rbx5+SwQqdJ1YkDeUAvILkVYllAiX4bKnnJuZwD77/1SPaDjsqIFL+NGKc46q0lN12PjzpgYjiBYhpv4NWYpx2RRLSRppeB8p/dXZbeuCUwqnWPf+Qo/Zqz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=v8KKUFlORb1Cw79W4IaljjAbxSl4Mkf+4pqfNS5hKukATBU/s2nXZAQYg6Sl7Bq4mYgV+U2LmD+l+feE8uroEMJSNgucf3wXIBGZGCUXQu7/fmVxxnqkBYHRg8jzPDLMmPXrOQTtzSuHjioUMtlt9xiS93UKlfAYlH0YAsSTQYA=
Received: from BN9PR03CA0331.namprd03.prod.outlook.com (2603:10b6:408:f6::6)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 00:08:54 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::5a) by BN9PR03CA0331.outlook.office365.com
 (2603:10b6:408:f6::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 00:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 00:08:53 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 22 Mar 2023 19:08:51 -0500
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
Subject: [PATCH v12 07/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Wed, 22 Mar 2023 17:06:49 -0700
Message-ID: <20230323000657.28664-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323000657.28664-1-blarson@amd.com>
References: <20230323000657.28664-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dafed1-e840-4978-c45b-08db2b32c9fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CGch5cME/lsQ3mkNSlxTGCgLpXcUR5rI7ETkpC4Prb+C09lFPJ07MBVAx2EIHx7DRRzNEYyTcwKCPMVTB3dOS7P5m/ebnIWaAlgN40FvfDdtF5GtDqWWO1rNj0fobX9rAevGBPpyJkQn3lg4WNHtaFLWKvcIuZKLWsgY4XQy5lhGsW3dVqfPh21KoYrcy58bRfkXsi1hW9GoYlTq+tqF8K6Rw10wPoAVcF7802CmKv86uy9U00Z16lZ8X8eTRKs908nyNxS+r7HUGdNLmk+6YaYJeI2Pb7G98Ziq50/tG5+f51zufV6H/K7PcbVW5l0Oj4wYxrKbc0E1MPXl2zAJyPq2wztDTzEoygc26oiqj8F0UQt7TCC4pDphve1joym8OTfJAUGeC08hqN1UGV2bRv+Gin0C1C47dAYQICU+tt3uEuY3QzNpm72robSsYMf6LPXLu+eCGZBOkRFx+IFGhZsjdXRORerR9Toxtv1RYDrRwkXUq8nW89g767O45ccb98Y9Fjjs5IgbKGlWdFwsYOSi5V7zw4SZZg7WgKvXMBnJJewPmQV9muslB8A5tmBq0sGEI1ttle0NxSI+WG2ldf4vDhlRMh/4Geojv09PEH6eiyoXG8hfuD1cp/KTgA+H5nFEyDw+0o7w4+EufRIDEYJI+HGqxPlAg51/4l7WHBuYBSUCSTx+ek33yAnDhVPhiq6I8OEkT0qXE00ouJz5mf9BPEoU1/xsXSyKUdmZzBE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(316002)(336012)(47076005)(426003)(356005)(8936002)(36860700001)(36756003)(5660300002)(2906002)(478600001)(40460700003)(70206006)(7416002)(54906003)(6916009)(81166007)(1076003)(82740400003)(186003)(70586007)(26005)(16526019)(7406005)(2616005)(4326008)(41300700001)(4744005)(8676002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 00:08:53.8664
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dafed1-e840-4978-c45b-08db2b32c9fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

