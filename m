Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDD681DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjA3WI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjA3WIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:08:19 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669943CE1F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:08:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab9Qtc0l3Hwx/Cc63OQr7KOPQGKogu4bldGwCssb2WgxGKIb7JhGjyuacUhIMdTbulAy67o4scTkhu/Mhx97KdVfbAWM2izu8KZ/i5A5+c5gdW+Uac4XuB0fYwRjZ/KY96h8XCAaOwFOkF+yV3BLAThNGcBYjhPScIpJm7WP8faXd3UHt2iuZ0Gqx6nwXmsbZpeEF4aFA1eNoa0ytCaN8i83xahULmyx+dp40P17rViCW7xu7pJEi7GBOdeJiNq6O8KfkH3fS4tK3icNTh9wUu46BIF1lFBFkyc0Qi3Y58cpBHABk7qVHHa0unyb8JD+dDWu+Ak+uClMQQXzAQRbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgM1juvU/GVR4OO6ohMnSYuaIZ1Y7TOmayaeQ6fpr/c=;
 b=VPQQo2rsv88NxdLuAO+2vhM6kPhOjOqnEfoNd/qkHuQxCm4ZSBTGFUeHOHWkfc7nn7FV7fK/x+Gp48Uu58HJWKacYEgaQ0MM0eZ0bAe/wAKXLhmEJv2LBJA9ggztbjgLdA1WH1zgwWmQVAbkFPtB43hd5zf0LxVvKbnEtYliCOA4yHkGbKeHETPLKt6bbk3YgCtcEa4JcpM69JtLhCiVQW9r0aL7th/AQC9b57rlQr0VYBR5/0Wp5nxn9vvZgdrLqWPuaX4kO5wLLeKjfVsWoWx+l0bRQyNmT4lc9doQgfKoRgf2tDJjz6dUzenP8K7Po36VACVu6eTDufPbtLYdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgM1juvU/GVR4OO6ohMnSYuaIZ1Y7TOmayaeQ6fpr/c=;
 b=PUYtMWQIQuhYQCeX5X6cCpaBYhoODmY1kOFDW9FXqIfWd/gBPvwehtw3eEAzA5nGqn+lEMSTr+BiaWFpVd7REGrINWuHa9O+ekUWS314RNfeMJCfAu52jF3OFx9WmEe9LNTJMnveTaz2ln75JFVeWlHV1xJx5z5eYEYkgRKhOII=
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:08:14 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::10) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.20 via Frontend
 Transport; Mon, 30 Jan 2023 22:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.25 via Frontend Transport; Mon, 30 Jan 2023 22:08:14 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 16:08:12 -0600
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
Subject: [PATCH v2 6/6] ASoC: amd: ps: Add a module parameter to influence pdm_gain
Date:   Mon, 30 Jan 2023 16:07:54 -0600
Message-ID: <20230130220754.8379-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT115:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c480c5a-d22e-4f52-543f-08db030e7bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHxDDJW/z+dkMFzWx2KWIPGszYg7Gq+aOzctlYOgzpcLlXEdCp25SAoFEQhX2XXi15Cu8thjThorcNeG21LUF1IHV56sNZsjQ80Jj2B3cl+kyVuIo+Jbrpes8gjBImq1trqWYWI0wbxlRgnlOFQ0bnkWmzFuCNv3CauqnTNqllXSEo9Az6ww0viSdao36TpgY4lfFHo3tpxJ9rkWdSFlzDtP/RxB/5cag7AuUh80/S3BCIdo5a79sPft/UEHv+CQ+bparSlzBwTTb0M4fnWK+N2sshlSNy9xVsfYRZP5mfviawcsXZ5kVD4nu2abNcY9r2eYdi6TmHygdPuUR79UEcslqSaSBJXMGKBjW0FgGbfbstq5H5iBrqVE6BFZz6hNeWw8Z5MVL5PFAcAGVvAuinfE/llotREo013M8wbIukQLo8+og7aYpPF3inJKTi9/YzOwQdKD4ok8RPNBp8KfH0xzbMXMhMkO2m78sogyBWmnmNBhqwxmoxr3ohw83i53RlaAewbRb8ITJhFvCg9Y5oNq1UH97k2NRIa3G/VNvWkio8q4uS8JcTdo1oSn1PVJqt0wnoZFXYW7YAbtA+ryz/CyGxYUyTyM0NO7gv8zIN9uCHnBgvcOEa390ol/1RFUrQehTxdkI1x+3DaQ1TctdMrL7f6YLLws0Twh0dEgmjIY+5fpAdP9X3xS9t/6/yFUi7kKixd7b2r0WXElEyYzGuH2prn2ZMov3q2rJS/VAPU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(36756003)(110136005)(54906003)(8676002)(4326008)(70586007)(8936002)(316002)(5660300002)(36860700001)(70206006)(81166007)(86362001)(356005)(82740400003)(16526019)(26005)(1076003)(6666004)(186003)(336012)(44832011)(82310400005)(2906002)(40460700003)(40480700001)(7696005)(478600001)(426003)(47076005)(41300700001)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:08:14.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c480c5a-d22e-4f52-543f-08db030e7bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248
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
 sound/soc/amd/ps/acp63.h      |  2 +-
 sound/soc/amd/ps/ps-pdm-dma.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index eea71a9d2ef1a..c85cd471e739e 100644
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
@@ -55,7 +60,10 @@ static void acp63_enable_pdm_clock(void __iomem *acp_base)
 
 	acp63_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = acp63_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= FIELD_PREP(ACP_WOV_GAIN_CONTROL, 0);
+	if (pdm_gain > 3)
+		pdm_gain = 3;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, pdm_gain);
 	acp63_writel(pdm_ctrl, acp_base + ACP_WOV_MISC_CTRL);
 }
 
-- 
2.34.1

