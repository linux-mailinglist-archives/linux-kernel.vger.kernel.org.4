Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D2683592
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjAaSrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjAaSrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:47:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548D5529C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:47:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1VRbbOhme9OALuaBXp5oJN+unuA4admPUnB5lEFRwVm19RZQH4jvIEQaPb2uzx/D3XniNRdNOsR0OEUDj0OoD2fPjN5qMlScB1OiHlWuiSoaFB7sVrNPi8A/9oT19/FermzQ8uwqubtYKzMsO4mSfGj4/RnOeonNUtYL3EBkvDPb4hJKdzcS9OBVsMqh4xhhZciXbJHi+zAX6meN609thvckdIVyEQQknrTNa79JhtVZsdaYxksZIRJxNdEttKdERLnDqZO7RwfCO0CmDDbKU0tNUBXrDMLdZN8xNXpa3fjGg0a3PewAfIEfh5fjouYudPqM1mQoNwhVZzAkor26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxiMDW/X7/0SvWq9rTK1uXLqBW0d2EkED+WcBSW6i1M=;
 b=ZW6neh8Fi28GPu8sYgoNqaKL7VmHFqKQApkNyH31l1ZjbEWZ8V7GnP5durH8/C5qQjiJyftgxzP66vDauqKSUW4Ptuk8W3aDQvouoPrqmHHa0cxxfn9ewDoLf81wdM0DjnonySJVzNS2XCoZQpjWUcyFe4Ui7gDhmoy5UlLlo99UEfzk9qQEIxD9nEPFNwBvtKABXxi9H6Nf0fmnU8ztbkFS19sbwZ1/XmmwHVcrSvWro0e2O8LAS8AA2QeCUk0AuADFj8nDYKZ2OM94LF6F+hLIrLoOh+c6QpI6OhMukx8BahWXAXmRmADBZZ/ua4wSDvew/9HQtdiHqlJW6PlUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxiMDW/X7/0SvWq9rTK1uXLqBW0d2EkED+WcBSW6i1M=;
 b=A23qewsF0Q+ClgVgpxW3OduEPeePRw+GiWc9G/KXHv2tcQVosCH50jMydEJ1DaJEHa0aq9p0C4Es9Fr4dg2EmyzBJA1Nxez8hCcLzy3JkRbrKmcMrp4RdQ3Ehv+6Op/+HxohHPvU3prIdNDMAbfzfWn2so5kVEWyFYkI43psI6E=
Received: from BN1PR10CA0017.namprd10.prod.outlook.com (2603:10b6:408:e0::22)
 by DM4PR12MB7696.namprd12.prod.outlook.com (2603:10b6:8:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 18:47:11 +0000
Received: from BL02EPF0000C409.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::a3) by BN1PR10CA0017.outlook.office365.com
 (2603:10b6:408:e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 18:47:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C409.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Tue, 31 Jan 2023 18:47:11 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 12:47:10 -0600
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
Subject: [PATCH v3 4/6] ASoC: amd: renoir: Add a module parameter to influence pdm_gain
Date:   Tue, 31 Jan 2023 12:46:50 -0600
Message-ID: <20230131184653.10216-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0000C409:EE_|DM4PR12MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e700995-cc26-4eea-6b3c-08db03bb9005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmtsjelyhHGP/AMvpxWLnZSykDUM2eG9t+BFfR4cUb/0BGqvPDlC4dJyqp+f5G12UxAqIjsSGBbr7OqLrQuiiAlqHvUp4fNxuSzMEdytp+Of1gueUxq6RcE85qcZl/62qQ5zcBCYFPsIuvmhyyDJ+WKeoiSV39sIYc6liZICUmF+2NCbCXivjvNec5bH408D4Fw0QAKIuvSxbu7v8i0AO9Q317WhoEv1xnhMVRhSm8ppdd7f3KKA1mod2a2bJqs3z7yQ8v+rMaaMTVXJgDjKruM9fNY44xQjwTiEUuTNOtTH0P1P0248zjB4TNsGVERQaRnztHLsDqy6GQZAImJh89ZM5XwQWCbUHnW9mNp3N3+NOTmyF+D1G4CR63Mjiooc85lJ47Xv/jQV7e8WY2yObC/s/lmnyjZtmD8lCOn6MGbk89c+sDjZFW63vx17p/+jGLAFewUUBf4PWDCwyeaaeTzWvd7un30HiOL/+ugvDrri0Ip19ARQMDhS29lVoT/UhFadbt6yt9/jmMhMJvCLc4i4+ggq9lMXLYZMkUCHaWsQM/B5MJ9Ks3R+LewyeeQBl6SsBHwnGrT0qs+aJBvs1H55dpjoJaGwgUlN/PplWFQclDxAry8XJiOiFpyOVXnW7ILmNOVG+hZISbGpmcj3/eXQ6d/ZA5yFe0Tzs6ReQnE9EnxFYAYMsF2fWTeitJzhhce528z0OJOW2Onhp1vjjlzSd90kqtfVit1A99oEFxg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(316002)(8936002)(82740400003)(6666004)(1076003)(86362001)(7696005)(478600001)(2616005)(336012)(82310400005)(26005)(81166007)(186003)(356005)(16526019)(44832011)(36860700001)(36756003)(40460700003)(426003)(5660300002)(110136005)(2906002)(54906003)(40480700001)(47076005)(4326008)(8676002)(70206006)(70586007)(41300700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 18:47:11.2630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e700995-cc26-4eea-6b3c-08db03bb9005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7696
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
 sound/soc/amd/renoir/acp3x-pdm-dma.c | 8 +++++++-
 sound/soc/amd/renoir/rn_acp3x.h      | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index 7203c6488df0e..0d8b693aecc9f 100644
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
@@ -80,7 +85,8 @@ static void enable_pdm_clock(void __iomem *acp_base)
 
 	rn_writel(pdm_clk_enable, acp_base + ACP_WOV_CLK_CTRL);
 	pdm_ctrl = rn_readl(acp_base + ACP_WOV_MISC_CTRL);
-	pdm_ctrl |= ACP_WOV_MISC_CTRL_MASK;
+	pdm_ctrl &= ~ACP_WOV_GAIN_CONTROL;
+	pdm_ctrl |= FIELD_PREP(ACP_WOV_GAIN_CONTROL, clamp(pdm_gain, 0, 3));
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

