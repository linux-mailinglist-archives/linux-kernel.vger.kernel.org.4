Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740E9681DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjA3WIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjA3WIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:12 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330C86B2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZHGb5MmU+SO2GjFbMc57AAjQzlffjGPdtgOWyRWBqM+d0y19YspyN29q5ZzzBtxRcR/nbxbtlb1kJHlGfgcA3A1VU/MBDQNIEcZLgmYBFxfRLOjL0YiPOKelB+A0PTLf2IBVnYCGAooSweBOXNNfhR8MtrCBNTNu+CRF1Cap0cJI5/BuKVvMyElPltb6NUtrg8HMJnCo1MLLozH44qCqpmHgTvKkWpiiF6lsFqV746IK5Xu52E0c38Oi18Mk8XWD15jMpmUg7CI8FHMaxOqB9yOUM0Lr+PZh5xmzUNEJnZPzSHmpvoh+auhjvm0IjibXaRV0JyudqfvqhJxX4GNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40Z2QG+kXxpSw+po0RsvIEJYYU/V1nwfSsaV7p53keA=;
 b=jTZKzu21EpCjElaK5H/25m4VjHnT6jz0ToVypzbIRI9GXySx/j4BaEPz2wpI2HuxigkHGLXQt43UW8VuE4sSkBefVSfYGlDqNpmRH9ZGVk4JnNA4ajz6rDRBpehiZhTI/ORLpBq27WefF1jdHe8uTGJ9h8yeRorq/6erHYZa5htGDkDUwU3vIyAa4npBsvCAH7IRhgWJY3Lxx9gxeyA1U7okrFG0cGVXrY75v/fKlGz8wDXQ6Lxy7pgK1/khh1dHD/bD/+7GRA/CLcoGOT5WfM/s4lLVvoeP52wCqxwNtIR7PoET7UJYEcPorReIZOMaaI67B8Mth5Q9jmzeOKS8dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40Z2QG+kXxpSw+po0RsvIEJYYU/V1nwfSsaV7p53keA=;
 b=o2n8V+96lcZu4V0YvIwiDTrvmjQk8qTH7i7p/+Jj30d+Lvoto6khxEsXBsaTeBqNVWJgzo7cBvO1Wmq9xCHRrr2HaTnLKk+ONqu3MrMWd8DyZ3YcLEygSsRhAmfEq65UvamY5w/C1NcwzQ8IG8eiVn0FyvySZG7IdYuFsetc0F8=
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:08:09 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::3) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Mon, 30 Jan 2023 22:08:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:07 -0600
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
Subject: [PATCH v2 2/6] ASoC: amd: yc: Add a module parameter to influence pdm_gain
Date:   Mon, 30 Jan 2023 16:07:50 -0600
Message-ID: <20230130220754.8379-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT017:EE_|DM4PR12MB5232:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d68a55-8682-4c02-96af-08db030e78b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hks8ocH/ejoXCQnAeGsBid+/+0rK5Oiaye6pmU9vqBF5jJPBw/YFd9Bd0Y/q0qxl6hSwPGvkTj6We2EagNsVuPYezQer9oTfwrZluA5YvSTeOf8fuUb3enetfH5mtuTMcyRbPCoQqwlBeqNKXOZdFtnLjGILO4RRjDt/GMA2TrdWsXtsVW5c2QI60ZRil1hlgqDbLQGnRAukNxY+DyuoiQkeAiC9Hf7Twsa99I4N1K+MgQvttnP9Dk/pGYzUTt1kszB0VLdqN1p2Q6YLcog2BcYRW2B/yj/v93sVf9BZQmuymVZAKgV4vIiv86FzKjyRvM8xvLjw5xeaLEtPiseldAaN/Q3zKTcASSbD5vlnun69dKQItK75+18Wa9NFHXfLcplKT4g3QTNS1JoSSe8GdrX1VObYBpTILJNuvXDDvRg28fsGcni+G4i/X/yKJ8MdGNo1EIU2fy9r06PCtQ4aEYvRvqO0+5eh56/+VQ/GRzj17TKYelp3sp4Zq76o1jaJq64dpvClrNUeXKW8YIjM0wtGV2QzFU+cXXIlNiPNTSbO+C9QUaaTA77pYDXQDhUJErkbUSndp7akLEsWWxuB7bmMxAmOHX1mvX4z5LgU07iNJdsNQBkO64Tfv24hmIgpk3kZTG1X8cmZ7RPzV8cLJOtWERlUBkDw3G/rV+sU1FL2gfXwK1tgdk7r3ZS1dReDWbC3+7drQ9IExIcIOGNa9E+xmTNr9aWiubbU5hv3FfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(356005)(81166007)(86362001)(36860700001)(82740400003)(110136005)(54906003)(36756003)(82310400005)(8936002)(41300700001)(5660300002)(316002)(70586007)(8676002)(4326008)(70206006)(2906002)(47076005)(40460700003)(40480700001)(44832011)(336012)(426003)(83380400001)(2616005)(478600001)(7696005)(26005)(16526019)(186003)(6666004)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:09.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d68a55-8682-4c02-96af-08db030e78b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
 sound/soc/amd/yc/acp6x-pdm-dma.c | 10 +++++++++-
 sound/soc/amd/yc/acp6x.h         |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index acecd6a4ec4b1..2bb3ea14bae9c 100644
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
@@ -55,7 +60,10 @@ static void acp6x_enable_pdm_clock(void __iomem *acp_base)
 
 	acp6x_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = acp6x_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= FIELD_PREP(ACP_WOV_GAIN_CONTROL, 0);
+	if (pdm_gain > 3)
+		pdm_gain = 3;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
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

