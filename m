Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383B16B626F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 01:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCLAqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 19:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjCLAqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 19:46:46 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20A06B5C7;
        Sat, 11 Mar 2023 16:46:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaKe3XwEnPsMEKV6PS8hahErPDBlUSLn3jW230jWwvK35KM362XicHxAJxy8IXNcaFkXg6PTQuw3IlD3DxSqxUscELyDdCp61DLc+lu6DcXhDdMADM4sIISHabKjOSh2ZNT4rUz46vAxRBvNHZ/rBy9e9n3ZeKXttGnTHwb1vAL68J2TFVGg5sw7T+ngBn+k3qxTJzFCt5okO5G3pe/EI4+6q7/INuOx/jDJZ4lNrUi9IioRZq9RnvGDG1+gqiyQZpqOSrhxO7Vsh3u5euLdsVoyjQECW8RMxGOxVAhtKVd8ruRQPnSR3PltAZFo/1bgNiXwCSgkIXrCKg6giSWR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=A/vIIR+qVmlPV1rE4/KBQ9Pq4deT4DAdjhpoXlKXf1h6ci2sW3vFu4RJiGmCEY6Eo6/9qjYvUhdZExoilBONpwLfD/UAKla9/ngmDKXC/Fa51mPlW9roSM1aWzX+65YYrPpxi71svNuSJofveMQ4jCo7wEUSft2N/bgKRLoRsS4gwEF2a702epOqj9SwvmLG7IPgYelihbuHeYCOwtno4z9PwE93nSRh54rD8G+n8BXO/+iDs82nBcPwpe7dtREvJvQkzcVZlmxnWvJ2begOBsCcg/wEcJerI0RZZm6Or9CXuexd5lwZb8nYF+/Wty6bSTFJkWWnYGzTMbQxdjb/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYV1MbdPxIkeTt/bPBRd4G8qOex1cDpG402blQSNwO8=;
 b=4qMfKQH92dYooaG4tirXYaa+EuGqMpdMKa87XMjGIOKJ6g0mnMMgB9RyjtdK8j94YIYcxZz0f+fHyXih4OOROMOw3HlLWOuNJnfTZL/PgwLodIklnq023ZRLMdCJ5qH+Zkjimb2lv+0P4ibzCOPZFwx32s8LUx7X+haS/IczaHA=
Received: from DS7PR05CA0087.namprd05.prod.outlook.com (2603:10b6:8:56::9) by
 SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.22; Sun, 12 Mar 2023 00:46:01 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::30) by DS7PR05CA0087.outlook.office365.com
 (2603:10b6:8:56::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.23 via Frontend
 Transport; Sun, 12 Mar 2023 00:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Sun, 12 Mar 2023 00:46:00 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 11 Mar 2023 18:45:57 -0600
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
Subject: [PATCH v11 07/15] arm64: Add config for AMD Pensando SoC platforms
Date:   Sat, 11 Mar 2023 16:44:37 -0800
Message-ID: <20230312004445.15913-8-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230312004445.15913-1-blarson@amd.com>
References: <20230312004445.15913-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|SN7PR12MB6768:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b7b532b-0554-4ea2-a10f-08db229326c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dWLTUimUAErUjTcR+Vmtydp4N7JhBwF3b88gSaugZUwbeIDBJLiVgsPLFfoUHY6QrNAPkinSjQ2GbOlGRESnG13hHzu5AHj0OBySxVlVBq63lf1Ts9Sulyx6QwZrG6DV0zKjzKsRYrZWNpPDLH2tnwbsmfvT3cq7mFvv3F72HxxqfaA9j2fik1F4FwZQDDTkKleCXGXWM0vV5RgF3b8svOdz5rhIZQ+0KyjUUOpFacEutSlUXDWGZOJ+rE7m0S+iu8Dng1iX+zYpm86xMOv7Tn0G23VtD7gvUGP665jR7PT8FUVAH4GmrbqBoN5JjEQB8QGkOlSm3Rp5SQJ9d8dROP/0z0RLXm7Uj08NWZuPsxfFkEXW96Y6XMXz/lsf0pPmKpbSL3/swd1JXlwMtXenRIAU8hgf8+M+YQkDDc7ZBiah2rMiGgUQ+5w9KxXysqM9eKEbMJLN/HzLsoen9Urb9r+yMSCs73j4ZR+RRDYUDXpw0Xt3KRr1nFh/XNQix9Bfmg0ccPhmtH8/TKKAWcQ5T8T/M+MX5cWkVeTfPvxaBX7c66yS7rUoYmWSn9deuJMwovGQUElepgIvr32WOoPqJXl+zVz3viw4tJc/jr1Wr4XHDbF3i2y7vwYd29kAu0K58OMepMWGLhgVtolKfSFzCBkPaOAQMXPnyX6JN9Old4JsMXxOVaUVMvKPlrMRZvhY5ycOtvpUif1Cp6RaVYyMrxy9GvCcJxXl2kxE6HP5eKE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(356005)(36860700001)(81166007)(82740400003)(36756003)(8936002)(5660300002)(41300700001)(7416002)(4744005)(7406005)(2906002)(82310400005)(40460700003)(40480700001)(47076005)(186003)(26005)(16526019)(1076003)(6666004)(336012)(54906003)(426003)(316002)(2616005)(8676002)(6916009)(70206006)(4326008)(478600001)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 00:46:00.8167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7b532b-0554-4ea2-a10f-08db229326c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

