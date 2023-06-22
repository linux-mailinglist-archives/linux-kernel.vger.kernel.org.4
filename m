Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0573A4E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjFVP1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjFVP1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:27:07 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA22134
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koCr2Fxc76jkBsx/plBmW4YKwfH3MqD0FUp+oMeZmkufBvwkWvzkIszzljfrxcJjVHC6JAGD9aJwPAgE7VLLs/DMNoqwEttu1D7Dvl4W6roNDayEZF1tYt0FBiL3Gsws+PKmOtwhnWnh0hFxWRD6ZjPJHWNlZyjdeBYAssOonI8IQ726hFpXBjYKWcZ2pu8SWFjhKGpYPzpdW7oyaZRFkjR4BsRkdkuO0uKakra/8zYZs4TG535MjA+ibd6QYrrY/ut65YUhHMwswBA36LzsJVJgLPW7Ndu4OAYzFHH1IYRs6zgR/KtVBMgoegWfrsDU7tUTHi6ucSv9G5JCfMB5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHl3imB2MTXt7pew7uDec0h5NMyhhOl3FKPgVMdbHuw=;
 b=Rdabt8eLpX7+7FFbTTFgMcwkkagg7nUpadk2fJssBplpQ7iWXbl++EvfATw+qGb3LlvYndBfJu5+pSsF3eAvWKiA26nVRZmyYtoDHMebvh+nRaBTjPxFWmPBAMQBpe+LlatTmWX0uU6jbFIrUZjTqxUv+4NoTTfHIGL3b3w+XkPXKIkFLM6OnVf0hjdmFNvZt9We0dok2z5aS02EBnR7BFG/eb38xpH7+OSBfqtpH7dTG4DuGsf+hfgKvYALPU1mIY3GwOJUge6GW+lxOFtdsYrm5tGmtaJuwcI9RQnWel40m1ZahMIDoZ8cqhPHu/v+XySzcriFVTpIteM/XckJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHl3imB2MTXt7pew7uDec0h5NMyhhOl3FKPgVMdbHuw=;
 b=0ad5k0RrNMQjD0y1xbAruSX9uxs4CCkzeV9HB/OfTyhXL3MxF5jJj/n/17tanHSVgv0/HaVyKNkrtmiGhU0gCuyNOe5ayKzvIE/geJZCgICB0Gz6TBe4nQqyW2ALvw8C7cBvLxKtRUU8Aowkk49bzyNVpITZ/7m24nn4mESt0p0=
Received: from SA1P222CA0040.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::8)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 22 Jun
 2023 15:26:45 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::1a) by SA1P222CA0040.outlook.office365.com
 (2603:10b6:806:2d0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:26:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 15:26:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:26:44 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:40 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 09/12] ASoC: amd: acp: export config_acp_dma() and config_pte_for_stream() symbols
Date:   Thu, 22 Jun 2023 20:53:54 +0530
Message-ID: <20230622152406.3709231-17-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BL1PR12MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3277e4-ea6d-4fae-6143-08db733516c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMltbWdW+skZ1LWf/x3yX0UntCSfmIqeqiGXqi+yWWkfoawh+aQznWRK60k9fA5HWvWFArbhMESOnOxnfJZ09N5nPIiMfzqZDm+arpFu41EQl0oaWKcVTb5Pxj7aFY81uz85K0/katySINLVuPCEOFaW6R/2w3EgBNdVLGgcFMB9llI+dCpbnKJd/DjW4JWDDjqByHV9iTHW0bABixrL2CrOoAfGoQBGClgqGTGr5xVeYcOkt7BoLKUwmMooAGZNcv2fLMTnc6X6WM+2k60Oe07g3oMmlErk6aYMpNDmegxBDJqKMjHs6JskvfGNwENFEp3PaEvaDSEIxP12kopMWplsbJH0HmZY3LtYVKHmtc1ybr0YSOBTMFqb5GmEJuZFt0c0zT60s5s6qE3kW8nR8A+NtRHHOhNLsM4Pdrn/A9+dFlAEVgs3DfC+8G5VU55okZkzUPMSntHC9GswkeR/Jq43ikZeQV5HaIsFRz26J3Aky2IT+nvUn7mVOejHzlcA8vqOaVpbbdRdkXXpgiw9Ea/fPXDILb+iHlKsNJGhiOMuRzVg3A7b0aKL3+msxj5SNS6kopV+q8AsSrFpih+E9lQUVYpciKi6gkJ1ges9Bi5Qz9UlDckqXBsy5AS7GdikfvH/SAADyfwYcz0H0cCO6c03KbHSL/18n/yFYqOuYsWhhZcB5IkIhhtQxLcFNpy8P7GtlE5MDLHiOS+KBkBZk+SdvbCx0nLAhFFT+TOHdst5sTwX9+q6iCdPaQRx/iz1wIeESaip3ZUZbdw4WpSsPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(70586007)(40460700003)(70206006)(4326008)(356005)(81166007)(2616005)(82310400005)(86362001)(1076003)(36860700001)(26005)(186003)(47076005)(83380400001)(336012)(426003)(82740400003)(110136005)(478600001)(7696005)(36756003)(40480700001)(2906002)(6666004)(41300700001)(5660300002)(8676002)(8936002)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:45.5018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3277e4-ea6d-4fae-6143-08db733516c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export config_acp_dma() and config_pte_for_stream() functions.
These functions will be used to restore stream configuration during
system level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 447612a7a762..d34271862e42 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -128,7 +128,7 @@ static irqreturn_t i2s_irq_handler(int irq, void *data)
 	return IRQ_NONE;
 }
 
-static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
+void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream *stream)
 {
 	struct acp_resource *rsrc = adata->rsrc;
 	u32 pte_reg, pte_size, reg_val;
@@ -144,8 +144,9 @@ static void config_pte_for_stream(struct acp_dev_data *adata, struct acp_stream
 	writel(PAGE_SIZE_4K_ENABLE,  adata->acp_base + pte_size);
 	writel(0x01, adata->acp_base + ACPAXI2AXI_ATU_CTRL);
 }
+EXPORT_SYMBOL_NS_GPL(config_pte_for_stream, SND_SOC_ACP_COMMON);
 
-static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
+void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream, int size)
 {
 	struct snd_pcm_substream *substream = stream->substream;
 	struct acp_resource *rsrc = adata->rsrc;
@@ -169,6 +170,7 @@ static void config_acp_dma(struct acp_dev_data *adata, struct acp_stream *stream
 		addr += PAGE_SIZE;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(config_acp_dma, SND_SOC_ACP_COMMON);
 
 static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_substream *substream)
 {
-- 
2.25.1

