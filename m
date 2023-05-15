Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECC703C61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbjEOSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbjEOSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:20 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2178D1A3AD;
        Mon, 15 May 2023 11:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbeX9/S0sbM7nuEF+CIf8csg8evNslt2hO/rHIcv9YrvEQ4sQ6GLZmhKQk9pkiiaXoMA6UPm6N/YjlSqMHBwMD/z7XjwX4Au1D33dVMrFZoYS0d0gM5bHMzT4rYs5HvlAXPvXb0yUA2Z9oDZv/MXPTHgsdgP0lFoMHy0ODNjBES95AHyjT+deAtDEpkaDdHHijieODVwLY+QjSFAFM8F0bFwPPx59Za2TktzbfeeKUOcUrLZrnx81vFadbd6P+FrCGe0D7uyoqxyN3er65m673p/2cgvkks7U2A91X/M8J6EfYEoedkavAylKWQaVB5VUkN4orHgjmuKLmxtdvElAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=l4PrTGrb4wfgiPAlPM3iWLxORhq+zQcmxHP3/NfHqUNxVtRtN0Tirqe3kLg6D3xDZbTRT4GgDAU9nvT472vnjc0PQ/aGpdg/sxvpqkMDV3xAJnAtwpDObeUbcSjzMBU08f2h2XbKlEB3WYGcIg7+U8DX7ZiwQ7zQ4+esXDMuXxYdq/+EiXneTjqLfHHjCepxg0/mRxrwOKC/MrhZ7pz0XSqonamjQ7CndWd+MENrU14lR0PRJaT/4jAVqbMc+TcLb34T/U1qg9kZaPe9rWA8tMMP8DWQMnil0ReFZZYbrQ3AEge6KN3OtvBZXEY730I8S4Bli5k8My67I/m9OBwBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=sarxVaqbcxUsV1z36aPlpi9O7yo+peg9o3LEWoSHjAAwbwK2oK1P+oXSk+xSyXWIaMEpY2Q/szy90AfXdFqkl4guEPKaWzmAfqHo7ZVyg4rT/SY93N2iPfzm+TVIlBg1+xTgn4Zn7zbxiXX7YAynNxI0YQ56noQ81T61iHwRPU8=
Received: from BN9P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::21)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 18:17:23 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::3a) by BN9P222CA0016.outlook.office365.com
 (2603:10b6:408:10c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 18:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Mon, 15 May 2023 18:17:22 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 15 May 2023 13:17:19 -0500
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <blarson@amd.com>, <brendan.higgins@linux.dev>,
        <briannorris@chromium.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <davidgow@google.com>, <gsomlo@gmail.com>,
        <gerg@linux-m68k.org>, <hal.feng@starfivetech.com>,
        <hasegawa-hitomi@fujitsu.com>, <j.neuschaefer@gmx.net>,
        <joel@jms.id.au>, <kernel@esmil.dk>, <krzk@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <lee.jones@linaro.org>, <broonie@kernel.org>,
        <p.zabel@pengutronix.de>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <walker.chen@starfivetech.com>,
        <will@kernel.org>, <zhuyinbo@loongson.cn>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v14 5/8] arm64: Add config for AMD Pensando SoC platforms
Date:   Mon, 15 May 2023 11:16:03 -0700
Message-ID: <20230515181606.65953-6-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
References: <20230515181606.65953-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: a5491378-15b0-4b84-0692-08db5570a0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZKRIwYeIJxBU4BemMfiP6f3FFB+nvTBp8AJTZCwF0984HBKxmrZ3QMk8znVvNBUMmCcJjOjHIFgXqn1ltlCsfZPmnKTMXdovGTdOPyPZ3GV5nSe5uZZ+h1yGP7o0yZMsr96lJ7VqiwhyUONx2rYC5FZWYg0pU8bT6YKCCIhXNL6USuLQ3bz3tDDiG+ilDmzDMGolS/iHp93Opw6a+/+IMFVH/PMgTKA4v2BXjRMVcaWOgSLN6f4eeebdZkcghKxxT2LaEmA6ViMZe/e+5FjVO0QubSWHTHhD/nDzT7eikOv+QIvMNePWhDn7/pHfzWbjSB/nbN84h7ihPmrLrKpsPfdxq+cCF+MQQ5PHserYrmZglpktKQW5eQWVRkLR0X7yu2sIq5tNoZzBbv4jG+df4ElHZJP4HhINlgSWQrPNXMpBinbMmi4qEpqbptddBWZ2XPI6Lj7LjLp7JSXQ+pnfXpspz783DpT7hp/JNE5m2fIqVDMaI+ISwN1rwv5jGBpyeahaAJCof+ROeWmlDG1oZZixyQ+pG6BMDwyq4tRJXxF5h0YRjE/O1n5/2VniD2lAlK0AZ5dTSnPPtCmm4So4owh1Mm1j5lt3sRGQ40pQkwku60LHu/0+LmLwAJgw3ydMEvyUMB+UOw3B24SyMx0cFRlhNKgVrhZEc00Jb3yG4NDvUgEgJTkbNQnZeIFqyq7ULC2GRy6O+TFO6ZUEV4xsFOyvOpQNIWSsG4cVIyqbsl3J2mmacb4N4EGGVM1wdUZlHPrC88rX3LP/lLoqQlhTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(336012)(47076005)(36860700001)(426003)(70586007)(70206006)(2616005)(1076003)(26005)(40480700001)(478600001)(54906003)(16526019)(40460700003)(6666004)(7406005)(7416002)(186003)(8676002)(8936002)(5660300002)(4744005)(2906002)(36756003)(41300700001)(4326008)(6916009)(316002)(82740400003)(81166007)(356005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 18:17:22.7739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5491378-15b0-4b84-0692-08db5570a0f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

