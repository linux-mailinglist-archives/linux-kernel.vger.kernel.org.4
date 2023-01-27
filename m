Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4570967EA4F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbjA0QDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjA0QCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:02:53 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E6F875B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:02:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyXhilHyBMEK+PMlePu0c2y/5rtMWqT3TXDBCPQ+jsAesGFlAfQfMy/QEnMXGN7xxI701mY/ZlW3gh6UZtvJzsRwP8YiaPxy7EWi4kDiA0vz2VhidFPorpTZ4hEv9AjqFCEBrhqUdwhTC5XVd4DWEKPa2oox2PPYApFeimKEZYUcFA04mBDLiY95mugO6pU5kco2Lch7BiVJiioI/ETddDsnGtbqANOpnG7vpF6htxZ+Lq+YIUvr1IQS6q8te3OSLYWXbO6UfFXm4yjSatDJtI+ZUDI/dI6CYRU9yFyxtVFLcFZchzD+L/u5Y1ICkXnlJLBQWZm38BbRz2jp5jS8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ee4fX0leAMmk7Ip4HBtExrw5NQnPEsGXZ8xp7vWklk=;
 b=N6q5X04M0rDpOFJgdle+MQM1rfsnEZlgv9wwGQwCLBVCqrYS2aUSHN3nV55EKXQW/eH7ljpsQrCvbzyzQ2U8ELIdxl/ofEewThPNzl3ETBID56P7udDelyq6zou1fHcXWqJFQTItW/h6x8GyBh45y0Hb0iIeQZZKic0mguxHo6YgaEhs4B+08m3T74GIny68CyXJkKXThQClJuor/YGEyBAn2wZxppE8utbhpidYDH985yobZzIOYXCTwDVYd+yigvJE3aSPTd7+vvbjFXp3eh4KMT3nGMWSXvAfHRU9840n9Hhu6b1Od9uiKYlxx9U7zx8nMMgMhozJE2si91GeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ee4fX0leAMmk7Ip4HBtExrw5NQnPEsGXZ8xp7vWklk=;
 b=08bA5TIcUEY/mLJaY57IoP+kfm+dYL5gEV+k0Als/WVD/zHIneQEZJpHCQhimjkXR3qNOMBRJYA0MH9cFc69kZ3UhfZSsOzd7YlD8h8x3xs9l3813F7NjfO95mnJKAB9dWF6JVt4pyLzTe8yzngbOm7oh4CxNSKSpzxjZK8Hy9M=
Received: from MW4PR03CA0154.namprd03.prod.outlook.com (2603:10b6:303:8d::9)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:e1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 16:02:17 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:303:8d:cafe::91) by MW4PR03CA0154.outlook.office365.com
 (2603:10b6:303:8d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 16:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.10 via Frontend Transport; Fri, 27 Jan 2023 16:02:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 10:02:14 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Jaroslav Kysela <jkysela@redhat.com>,
        Mukunda Vijendar <Vijendar.Mukunda@amd.com>,
        Saba Kareem Syed <Syed.SabaKareem@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>
Subject: [PATCH 4/6] ASoC: amd: renoir: Add a module parameter to influence pdm_gain
Date:   Fri, 27 Jan 2023 10:01:31 -0600
Message-ID: <20230127160134.2658-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127160134.2658-1-mario.limonciello@amd.com>
References: <20230127160134.2658-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: a0763530-192e-47e5-1b17-08db007fdd0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZdCy9UDx83dpl6QH3U1YZDqnYHixQ8ZXh419/r8BPSkUMBElm29NXbfWd4mUljCeebakN7tDwKz43CNwmcgkfzZZXmb7YVkKo+idngBYJ3r1lOjbqG75gRcCRE1gG+f6mxcQ+V4P03QX6tEF+rduMMjFL6i14BPRf8LBTPY3HtylbIv99d/N6DYL8S1X3qQf0PNwKYr4LlF1nOuOfOYboeBeFCvWyB2sJczCDUWsrZSSemhxfxe3zNcBDV4/Xb9rf6lrihDw+tFCE1tgUnxRgVm7c7M9TBQ2YCg8S5641EJ0cl6kLFdl3luTKAdKYg658+BznVdan7Jv2DdocGJDmIaCMIALg1MSi/xBxvJ+PCIlCJP8Bg3QboMfLKqjfdqUO1QPXw5oE11slS+enqU0o+YRkqGKwNLn61Z6SPMJcqKVvFZL3NR4ufAbLH298I7NQzavoTUo2Urez3fWXyYX6Dz+CiQLyhHv7p+bk+nkyE0uBoxyHEOC2W9HXHmQuR7HcLgBjd4NNT9Y5M0PfLGmzou8GR318b9idymUavCnnQk99kqPxSTRNcqCdgd2C9tFp0UPtlkGkUT1l811DewOb2FfEZ63mf18g6NjCLsXTclYfkhvggvbdLMIihwP/w3sRpyHHJ6/mj9vY/T0PjbB9Dw4pk+VYGYTBYTElbucQRl1VenYZyLu2ssjQgzv5FuxSidr0jEWsuFzsyzLZ4GXqV8hkQK66Tk0EAzLxJ56sk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(26005)(36860700001)(356005)(83380400001)(478600001)(54906003)(8676002)(2616005)(70586007)(47076005)(70206006)(1076003)(110136005)(426003)(36756003)(7696005)(41300700001)(2906002)(82740400003)(81166007)(5660300002)(86362001)(186003)(40480700001)(316002)(6666004)(336012)(40460700003)(44832011)(8936002)(82310400005)(4326008)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 16:02:17.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0763530-192e-47e5-1b17-08db007fdd0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of regressions for any users that the new pdm_gain value is
too high and for additional debugging, introduce a module parameter
that would let them configure it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 7 ++++++-
 sound/soc/amd/renoir/rn_acp3x.h      | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 7203c6488df0e..74b70bc4b52fd 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
@@ -17,6 +18,10 @@
 
 #define DRV_NAME "acp_rn_pdm_dma"
 
+static int pdm_gain = 3;
+module_param(pdm_gain, int, 0644);
+MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
+
 static const struct snd_pcm_hardware acp_pdm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -80,7 +85,7 @@ static void enable_pdm_clock(void __iomem *acp_base)
 
 	rn_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = rn_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
 	rn_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
diff --git a/sound/soc/amd/renoir/rn_acp3x.h b/sound/soc/amd/renoir/rn_acp3x.h
index c174f84650d24..7d0f4e6a2834d 100644
--- a/sound/soc/amd/renoir/rn_acp3x.h
+++ b/sound/soc/amd/renoir/rn_acp3x.h
@@ -34,7 +34,7 @@
 #define ACP_ERROR_STAT 29
 #define PDM_DECIMATION_FACTOR 0x2
 #define ACP_PDM_CLK_FREQ_MASK 0x07
-#define ACP_WOV_MISC_CTRL_MASK 0x18
+#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
 #define ACP_PDM_ENABLE 0x01
 #define ACP_PDM_DISABLE 0x00
 #define ACP_PDM_DMA_EN_STATUS 0x02
-- 
2.34.1

