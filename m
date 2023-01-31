Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D15683591
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjAaSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjAaSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B1755299
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn6eLJJZK6tg/6QEV4GZZ9xV94UyeHYNbvLQdgafir2xsTCyTtyoaCaV9WHIVocwy6YkA3UVZs+Hzh8KnnQGgiE9NvuZn5olVAL/nirZZpara1VOMGVi9NeaRYUrmmtJRxyP0VeLFZG4IiOhphHpeMGOPCcJAaOX2+T6lRAGN2IRZt6VP8CHATnSsvhjp0d4Fn89kw9r0VikZeA4pT6JsNjBbN7e4CIDcspgiUgUKNmxlzLle5aGgge2iUdD+E0zFpBf82ViTPnkut5Dbb4TOTSRp/z1ViJWA0ic6v4Uz3xjZj3ZOZ4VduvSzomOBJT62cLK3CbaRWaNuhlsmswh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAd1NZLR+FUKZnFAoMjgWppZMiDNdLbEXqRN7gKfx0c=;
 b=GwOHjGc6Ffi5Pk0j1WGRTOAUlLqiNz361YwzC54T2D0Z1fqK9ObV7nXl+0hvgXDKty8phANTPGz/aNIrsijxliyGWZt+oav7fjT66jvxluJvazscqW2JieeztyM7oThC2+y6CK7m1reuspEV9jD9Ctro9MyshC2jY/H+zApuJ4BhUYBHQTml87UU2px72Mm60GJ6CJlWgY9FaeruBNTrivNuSGV0tP1DHxXxtz7HwxZrmSSvGrYjeUQv27aC4OBLz86IjC8170F2y+OpAK+DJyPnRVNVHvRmqYPAoSI+C997LWSmJo8lY/TFjG1gRSSjcRF3Vkn0XEVXX0bBWJR4GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAd1NZLR+FUKZnFAoMjgWppZMiDNdLbEXqRN7gKfx0c=;
 b=EbOWBKLogCL+C9uVdUHD3NTJ7FRnXgcwq6UEM8bjUffzkuO87/FrhOhsvu1P62sPwcemqQtmVOgyfg8OPu6hhu8rNS1SfZ6cxikbXjBz5w+eor+1oVQFCWm0xj+aTvK9CR3ai8UYQwQSCgrsVjXeKQ4j2EYT3bKu8p+LUcuqCfo=
Received: from BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 18:47:09 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::2c) by BL1PR13CA0098.outlook.office365.com
 (2603:10b6:208:2b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:07 -0600
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
Subject: [PATCH v3 2/6] ASoC: amd: yc: Add a module parameter to influence pdm_gain
Date:   Tue, 31 Jan 2023 12:46:48 -0600
Message-ID: <20230131184653.10216-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131184653.10216-1-mario.limonciello@amd.com>
References: <20230131184653.10216-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: ad827265-73d4-46f7-8697-08db03bb8ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzH3CE1wWwrwehoRI0YpSoxsjm6et1uHBTQId6EFvX6MuL10lj2PylRmxHhf9nzPwezIAUAb8KV09ARDku5UQAIVaH69896cW1T8wxrurs6OXBnhJ1xbCzFHyDS7jTCFf+5412+lKdxuAdKa15WFiHenmAAPSKup7GncHumUrhzaaCg2GDpjOzuOLY/niROVqJwy1peVyJxWT7lKA5KfE/DpuIaSPHsXbcJxml+bLcHXF7965CRSEPeaGhuPN5GVHcoxzXotH17VWYg5ddobnmT2e4Z+uBbyokabuIdIAbvG5Gh4IpGh76tVoiYmyADfmD1qgywmf/jqnpEQPWz7C3cm1Pj9hpXYZRXd0pYTgX94oaWSfdS5hOtT3ZLmL1vCJkqeBF5rgsZIO2z+08Yr7R5jp7ShTSiiLNr+DDUUpj30b0604X3Q7F93lTF5UdJYszSLjRpvpelW14h+aJf2vqtCLD34eAqhYfsuA/ftzWxK8mVPBPMhzmcq4XrH4FbfwU/bv14mU8rEPY+DHWeIeiuafjq7dLZykNWLa68lzyTSPnxJvc3qMzv31lShtBSyPTidKPvEvDoFzT/D5zOZCoLRWALcdYroACYfH67prXA6s06DqP1iL8pTLZ7TchzIw33SbtxsBs04jw1ie8yIH673CNR2o8l6bGadrgddNKWjQP93c/rTVTKO2Xk4R6istutti2g6Yj5M3+4B1yYzYKnrhh+zWWW7Il3omluLdxE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(81166007)(86362001)(36756003)(82310400005)(356005)(6666004)(336012)(83380400001)(426003)(1076003)(82740400003)(36860700001)(47076005)(2616005)(26005)(16526019)(186003)(316002)(7696005)(110136005)(8676002)(54906003)(478600001)(40480700001)(2906002)(5660300002)(70586007)(4326008)(70206006)(44832011)(40460700003)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:08.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad827265-73d4-46f7-8697-08db03bb8ea9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426
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
v2->v3:
 * Use clamp() and clear bits appropriately
v1->v2:
 * Add a guard for values > 3 to overflow the FIELD_PREP
 * Clear ACP_WOV_GAIN_CONTROL before setting it
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 8 +++++++-
 sound/soc/amd/yc/acp6x.h         | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index acecd6a4ec4b1..294dd7fb43c9b 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <sound/pcm_params.h>
@@ -18,6 +19,10 @@
 
 #define DRV_NAME "acp_yc_pdm_dma"
 
+static int pdm_gain = 3;
+module_param(pdm_gain, int, 0644);
+MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
+
 static const struct snd_pcm_hardware acp6x_pdm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -55,7 +60,8 @@ static void acp6x_enable_pdm_clock(void __iomem *acp_base)
 
 	acp6x_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = acp6x_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
 	acp6x_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index 846ca10e24d3f..036207568c048 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -31,7 +31,7 @@
 #define ACP_ERROR_STAT	29
 #define PDM_DECIMATION_FACTOR	2
 #define ACP_PDM_CLK_FREQ_MASK	7
-#define ACP_WOV_MISC_CTRL_MASK	0x18
+#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
 #define ACP_PDM_ENABLE		1
 #define ACP_PDM_DISABLE		0
 #define ACP_PDM_DMA_EN_STATUS	2
-- 
2.34.1

