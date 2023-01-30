Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8825681DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjA3WIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjA3WIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:16 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9E3A5BC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erMNaNB8BnFQxTJLc/svYfQ+F01L7owz+ll6vaA2kjxrFFiIq/JwgXiqNDCgkrH+ZWp2L1h3ye/0Y8DsXmkralt/oN+J7EShy9rzsVhOM6VTwYAq+lIsnYizz0h90nUOg7qGjeQZXyJraIThg/sfsROQwO72wNrGZfaopIXqYgEVGLWEWlMzDjbXmG6bJYrkrkJavotVvM567yQNHU4wYSsk2BOhkjw8SDtcak33khGCpcj1VWEN7yL+tvPxKsiEwDhq6RTdehWjsAbsz+o04+LirkO9cI9lfHI+W1caNNfRGvTqP4T5O46b7mdEQbt8CwttbgGErjUQ0DjUfcPo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/8511HDqNx9BFiFOeiqBy0XH6KI5pNo1EYEK/Be4Fo=;
 b=D+BfSltUediaHcWZM8p+jl2Vq/UjrgqcpIWLxmIpHhVIQhcedk4Fkr2SWMqeiQHc1GBTPv9WtndexAhbesTGVfb6m6gvYt+yw4Iz7bSkvU3Xn03EqG+3q2v3+iLzkJX9odLryo/TCG2TPW2Vv9XUL1hMh41GfrBN8o9NPrbaVRQcjavA6BWTnT8CAPMIKfuSbP7pZIhgqjXRJrEDqOgxAGTtHJ29g4+z7Z1ttfPwhQVxMp8uulAqZ5JayOSlANcfasyQefMWMY/JT2GbqgvZbC3dCtYLRA1/CP0ZKBby3of+igf85W4fzqqj87QTD2/JWPl6rTu+HF5fntAWEEX5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/8511HDqNx9BFiFOeiqBy0XH6KI5pNo1EYEK/Be4Fo=;
 b=WIDvcg3/AoYMNnNJxbvQUqsz6TSvL+Bty0e104Z32f0ILK1op3okJUmu6xBltHo5JUNby6XObk22aAUrklqgXOhmN3SusJp5LdfEMf+t2jtNodL3RWhAO84YjxitSt7FyT9+XAEVYWscHCBkyHI0/OBSYVvvSn0Je7fFoFVAhxk=
Received: from DM6PR17CA0001.namprd17.prod.outlook.com (2603:10b6:5:1b3::14)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:08:12 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::5) by DM6PR17CA0001.outlook.office365.com
 (2603:10b6:5:1b3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Mon, 30 Jan 2023 22:08:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:10 -0600
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
Subject: [PATCH v2 4/6] ASoC: amd: renoir: Add a module parameter to influence pdm_gain
Date:   Mon, 30 Jan 2023 16:07:52 -0600
Message-ID: <20230130220754.8379-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230130220754.8379-1-mario.limonciello@amd.com>
References: <20230130220754.8379-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ccd41d-1839-4af0-202e-08db030e7a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SlP+CFJog3VmnKxTgtaNr76pppN+B3ySbPM4Z4duNBZ2pscOC1XA3xb/LaXHlttXPXaxbYovqqzHidjqhHvR7Ynh0lp9M6VUBcNC1UJVwM0hlA7v3vtLdRshDIMsIEhzzSTR5MRNve5vKQi9lN0J10phP50MUaMy76jfTQ70PU8AdOJAlEI05TbQTdeOJsfIiJZIDwTPThjPbFCWcx4nMGqCZ1MlJOjUSy/Zic9p934l/dLBdvu9oUUyWJRgZ2wXgDjUEmro08JpqGZljQ5/9nxnVBCodRfoBiemswa5/QT03O6n0brxwUT6KUUudFzUMt1pGBD4VlQELNh0c2tDiXnXu/nCG/M/dKElFQBAaUwyNTDFOFOZ2zvQALM1DS9BEIFy5mdrzPF85Cij83jEkZivRIceNxPPvU1T8GYFhzWGyN73qDFE8xkaT6oE3Rngmm8Cvj6S++YQH3ldmW362FOORX6ZCcIp2nXjdL0Ai9ZG6IXBpIiQ/hF8nlnsKwYKNojlXHcuLIQW+K/cxCeA0i1PV/Wyzlfv79kkoI7xjbCnJOVBuiv1Oww9/7cORpzg0zyZLECjV5PLaabTTj2rz0CcvCqvHSZbssinrBGphXT3pEeH2ANFYAxeJUWxPZ/djOPzJ2Qa8oC4+gejoFBNpftl8Lzw8qhcICYc0wjheh30meRZdfP5v/kcvW07d2BcG/BcB7FTgZAO4OHzbcV9seonFcVAIAAvIzjeFJehHHA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199018)(40470700004)(36840700001)(46966006)(2906002)(316002)(186003)(5660300002)(356005)(44832011)(1076003)(16526019)(36756003)(110136005)(54906003)(2616005)(40460700003)(26005)(81166007)(6666004)(82310400005)(40480700001)(86362001)(47076005)(7696005)(426003)(336012)(83380400001)(82740400003)(478600001)(4326008)(70206006)(8676002)(70586007)(8936002)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:12.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ccd41d-1839-4af0-202e-08db030e7a73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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

This parameter should be removed in the future:
 * If it's determined that the parameter is not needed, just hardcode
   the correct value as before
 * If users do end up using it to debug and report different values
   we should introduce a config knob that can have policy set by ucm.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a guard for values > 3 to overflow the FIELD_PREP
 * Clear ACP_WOV_GAIN_CONTROL before setting it
---
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 10 +++++++++-
 sound/soc/amd/renoir/rn_acp3x.h      |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 7203c6488df0e..4582d4b8cdf73 100644
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
@@ -80,7 +85,10 @@ static void enable_pdm_clock(void __iomem *acp_base)
 
 	rn_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = rn_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= FIELD_PREP(ACP_WOV_GAIN_CONTROL, 0);
+	if (pdm_gain > 3)
+		pdm_gain = 3;
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

