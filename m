Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10D06AB56B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCFEKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjCFEJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:09:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9AEC76;
        Sun,  5 Mar 2023 20:09:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIwWOTrU+BPIkkFSW8BgjfShllu8ztCW3x2Oe+QClPCgW9HFqh8wWLL5Ijc1zcIRtN7GrxGWcJc7s0SesNat/rtcgb/SRFF95rPCvHGsmobCzUXBk4yIjld+aGghIsiLg71TwL6TaT3CS7M2cdTsXXK2cK04hGOmNytw3fXSd//NsfKJl2D6UmDD1jCvWdHXq2LpQbj0JV5BWLgCY2geByhzJZ3DqkWW4mVWpYQiWoL2tXBK/VCgHY+RCTiUEO9hvh3cY8/SxnhhjG+RJfYNQNy77zm09494l8yE5ZzHHUpelmp16GC4pGi/IZZnr0v7F88DOecqIGeK6h4xR4JWrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdkyz9vYHEsTJOwgI2u5jC9yLHfSimzlPAp98JvbU+M=;
 b=bYgtw8p4olTxVbUHAi0tBo2arKEUKxz/FXq6xp+px0PUh1vw/HR3tXHlAJz9fvAP8d8XqMgYhJrQHBHDEUKEBSi35GDA2qiYyNO6FcV8r1jDvbpm0KFK437n5XLj/czyAiBfx/iXljviWvlnEukQV3t//w7kflpGju44l03cXwMZ0GyA4eN6Q7O0hj3v9DVl/8JzPFUkb4hUsxHNs0SahpmJUIrM236idjwmzoif4Vv4SGaVbF3mz3e5L94SpkTzuLcKRVlHYT7sV25/iKl6fcrqbeMdytLEuw7yAyEMwroE+XctL8mvW57q0KY0CmhXW8i+WDwNazx+pQO0Sy2+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdkyz9vYHEsTJOwgI2u5jC9yLHfSimzlPAp98JvbU+M=;
 b=V1Hb7fxWQs+0VtfOKyKahbHPf3C73USJudVS0oZHXHhet+f/NGJ8K+AKOQ9+ItrarmySijE3aWk3zyksop5Yykv6xncXL8kCb9Sg7CENJSWJFCzNQH/9/rP7kEcL8/jyP/wJ9jd2hyLcgFTaSQxlQkV7EuX5szQue7zG+s+2keY=
Received: from DS7PR03CA0116.namprd03.prod.outlook.com (2603:10b6:5:3b7::31)
 by SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Mon, 6 Mar
 2023 04:09:16 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::59) by DS7PR03CA0116.outlook.office365.com
 (2603:10b6:5:3b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 04:09:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 04:09:16 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 5 Mar 2023 22:09:12 -0600
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
Subject: [PATCH v10 07/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Sun, 5 Mar 2023 20:07:31 -0800
Message-ID: <20230306040739.51488-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306040739.51488-1-blarson@amd.com>
References: <20230306040739.51488-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|SJ0PR12MB7082:EE_
X-MS-Office365-Filtering-Correlation-Id: 177d4637-eebe-4d9f-f4b9-08db1df88d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j7bC8EA5P02kW2Ze5mns80ovnRlIGNefuKTGbg9YXHeLufbuemEHGuTLIsnIK3kbSXrsiGc5O4m+Xor0zjm2V8lMpDmykuQIXxxE2G+UhertJth/Xu4e2qUZmHrhQXZr/V5FQaD5UapdbDoy80w+kxAdRj58QNITtpUMfE2AGapTVd/XOQA01BKKbp58nqbthwSoNqVKgFbnLAefqCwNvVdKyPcQg5QWzn+WxZTJqvVr3Fig26xfjHimcYxok0CGU53fTHWwg5sZyMZpXGERe6zjVkEnsThzHM/legAaxsbwzI2cwkoX3ZTJUY5m4f2gTUUXfFbOujovmxDxyawMlq/3ycniSykfWyVCi47IRRTcSwgGKBbGO5k0KoLw5pQjdJXO59qDO/NS1DJVzfWzijti6IR82TmMOFbEc2gyUdBFg5yufpOXqB29VgJQexZ+Q4hMkVvP8JvcPPafbqm+nX6gcrKfjccskv/zj6X1zFOmlCLO0srLo7RhzfECXPSlRKVestnBnoFKICWo6moBIlhHZsxd/B5PNGfmCpWy+vS3RVpu27XWM755QeEI+7KsZAzndNSXLrnw1NeiLqCm5XYI70V6p3arlVSwJ22Tv4T224E7PP97/Ld03R8rYSjgRFWwI/6MxR7RRvUtkifRrCFkp1CL/1A+rbrO5l/7S42+tOhNW+cnFgcqtwoPm3XUXOXzNcpJglcOGuvx/VPbnaKP4Ju8/PkovYj+mvMqvxc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(82310400005)(478600001)(36860700001)(47076005)(426003)(36756003)(316002)(356005)(54906003)(82740400003)(81166007)(336012)(2616005)(26005)(186003)(16526019)(1076003)(40460700003)(6666004)(7406005)(7416002)(4744005)(5660300002)(6916009)(8676002)(40480700001)(4326008)(70206006)(70586007)(8936002)(2906002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 04:09:16.0010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177d4637-eebe-4d9f-f4b9-08db1df88d30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

