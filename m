Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC1683594
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAaSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjAaSrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:17 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EF589B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0zzAyTCkP/Huu/wYZ1L0gVlm5cbaX4OuqYkODWwhCq82AgaYs+HB4D2uPwds9ZC+2/FO8rbQjlZzVV/VTiYfeGEV0NKD1Odv/dDQdIBMXW/v6+a77frRnQwG0IZyE1nQhwKPlL7Sy222f5Gy5lVLamgob4YWXHi4yqNLipuzIxjyUXSwdSgkN4yXV7omdU/7qADxCHpcjqDjkLumYffvgul+DfYW8doYSgqprOT/JrZ2tl6No5wo9qfmqJfG67n+QGT8qbwn2HV1yDavL/WiVUQwCM93mwGuAmFq4yL740yh+hqh3WtYm20Ygve5W7f1+4dIDNEJiyyUMXAg4RaBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMb27UoT51F2jiZ+qfluHAb9UnvJXc5ynlPkyyqTRsw=;
 b=BsiCCAXRWl+4qPEMgwJUO6njUqJM/eKLcSV5eHFKhhOI4P8IEdUP3BTTXwC0QxAzpte526ntI1g34KeuycAstGI8siYx10ewQ7G5SmCxtI6ZVXb3EvPMGJvkxcxcJ9se7tpFQHdEc0BDWBdCQGjrIwWSK9EHkPyqB9mQ0W3bIk3dGD7kdiGnKHWlZ4tvuxT200XansYNcdfT5tXGvB7kC9GY7ZyFmILji78EqMXBZSBmLIB0UlHxbrcdn9sG5wUo6vZnW/rxmjmaX10mjYEC3t8aP2wwNeaa0AomH0q/6F7YN9oMIyF/N7jRKPXI9gNtBfTt2TA/Lu1nohDgjHASKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMb27UoT51F2jiZ+qfluHAb9UnvJXc5ynlPkyyqTRsw=;
 b=dhmRTstUI1xmGdyiBNegmT4OoYlvCwmv/p0lsIb/feEvLjJ7s4wyF7tDJJFpWOPJaUJHaeR72Y3MSOGNAThWAEpkO1s5J3GnUU1bVjOd/vu+qrWytFIYhboFTEeN0S4x4vSCky+qmrV8mTvOlRzVUrfi63JFySjC/DJK/st1NZ8=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Tue, 31 Jan
 2023 18:47:15 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::50) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:12 -0600
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
Subject: [PATCH v3 6/6] ASoC: amd: ps: Add a module parameter to influence pdm_gain
Date:   Tue, 31 Jan 2023 12:46:52 -0600
Message-ID: <20230131184653.10216-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|SA1PR12MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: 36063a56-cb39-433d-6227-08db03bb9167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASHpDunfo4jXRUMO5HB/Nh3AxEod4Ui36qbNYF/jTP/USUm12sxug8/oqwqOXKXXB3xHlCazGPGMJvX17gJJrkYsyGeY1NhphHC4qi/Ih/DDxCIiLfWQFp+3RK72aEpybTsG8A8vvB00CJv2aewRkoGLonDbfhnU3H7wYCJIZs7Ks+E2I+tGZ///scd3x53bAVgLJmUkSd5u9PPDmwj/XasJbXIsfcv2lupO+Vx01+escXWptFRq+JbCAhyxJsKdeLwjQTbFYZlPKSUG8FznJ1uuILnpthiZQaYHXsKx/UjM/VX5H3eyrJdQSe6JsgvzeTVtW3rmt/a7RK0ra7p+zxbnBMqSGXB4eTbzr86T8In0dss89nvkB1MFcsRKWgM0h4a/e8IxplgPXzRU5Qce5Nv9Jy2u/WfOcmKECzx7t2dqgRA2CEY+ezFcpHfg3/jHbf1K+DOaZz8+t9n5hDL5TsYqovYlDSmsaAKqFidqo0oOc78BSBylV7QdlLyurA5XnFOyVjEOtXCpANa1nUDA134KoOVJ6a52SiNsNFPz6mBvyJsssStu7fHFfTbLhR6rVSma60vhDdpZVjz+0LdXv4wt4QnmifbNKF1AUMQZAOYf5BliR4NB8DbwuhHflWe2zh1Yniq2nLUUgkezyD2t1kw1SHEA7o3zlEpOtM34miz9DngoJT5hmbZqVRx2LcVLTuntDEaEiQRqchJgLm3WNdNjXsPA+dJ50BdDRYdRrTE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(36840700001)(46966006)(40470700004)(81166007)(86362001)(36756003)(82310400005)(356005)(6666004)(336012)(83380400001)(426003)(1076003)(82740400003)(36860700001)(47076005)(2616005)(26005)(16526019)(186003)(316002)(7696005)(110136005)(8676002)(54906003)(478600001)(40480700001)(2906002)(5660300002)(70586007)(4326008)(70206006)(44832011)(40460700003)(41300700001)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:13.5828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36063a56-cb39-433d-6227-08db03bb9167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
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
 sound/soc/amd/ps/acp63.h      | 2 +-
 sound/soc/amd/ps/ps-pdm-dma.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index bae8288d8231c..bed4d51e226a5 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -30,7 +30,7 @@
 #define ACP_ERROR_STAT	29
 #define PDM_DECIMATION_FACTOR	2
 #define ACP_PDM_CLK_FREQ_MASK	7
-#define ACP_WOV_MISC_CTRL_MASK	0x18
+#define ACP_WOV_GAIN_CONTROL	GENMASK(4, 3)
 #define ACP_PDM_ENABLE		1
 #define ACP_PDM_DISABLE		0
 #define ACP_PDM_DMA_EN_STATUS	2
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index eea71a9d2ef1a..91f1631f42c6b 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <sound/pcm_params.h>
@@ -18,6 +19,10 @@
 
 #define DRV_NAME "acp_ps_pdm_dma"
 
+static int pdm_gain = 3;
+module_param(pdm_gain, int, 0644);
+MODULE_PARM_DESC(pdm_gain, "Gain control (0-3)");
+
 static const struct snd_pcm_hardware acp63_pdm_hardware_capture = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
@@ -55,7 +60,8 @@ static void acp63_enable_pdm_clock(void __iomem *acp_base)
 
 	acp63_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = acp63_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
 	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
-- 
2.34.1

