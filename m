Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9740A687D53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 13:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBBM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 07:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBBM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 07:28:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CC1448C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 04:28:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEAgwpfbQ9CWyUOc5mvhSw3pXc2YTuE/sIjYkxIg971seydfHmnNYsGupga43YsojeE+buq0UfbzZsU5p2fUudqCWw5zwv/Y20oNVm0wbfdeFaWrreZTMZYss6YfY1PDgqXB/gPcuMEmBlvQxTrtuu11GqRJh6/iOGF77j6D8WhV6tUdUj/sdrPmhD6bpVPNcVBJgPjPjympz863+oULcf8xrPFXEb14KH9UTSDuSSMR/N/wSwSYwyuA3aOmcggIPaPMAUusLZmz04FU7rK1p/W+9rM3sae+B7eYM/HsfLSkI3YO7SqUbhP2anXL4tLfhabXjcA5WaR2P37iJF736g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7N1bJaz6MlWIOxfR8rOi2BGCsogP/eGeNfYjP0oXdM=;
 b=JNJqVFY2VUm43rdqiIuT7kIK5BqlkWkcNwbiKlsdBCmNtaq7/gDkmlhQNq/IKkxOPp79Yd7kj0AasKi78G0mdkE6Ceo1pC8pgLlOjqTGCg8CsqC3/LYxks74aTUb5YHFf/Gu9PqDZaQDauTmTcfX8cny3iQWBNLWGOROYMaz9a5iM0eNZEASibu2NEl0FVyQo5ntxID2JkDIg3VqSbo6BGQ4lRlUawFF9NJ4r/05GeAi/dnBGLngz9xFiPNOxVYVu5Hjx9kJuULUEZnh2c6qxxCZDySHnJaf5exHmNVQVY+/gCIlcCU+sHsF6JVx8vxhsWvAjM9LDa+0j44z0Ta+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7N1bJaz6MlWIOxfR8rOi2BGCsogP/eGeNfYjP0oXdM=;
 b=fXNPmzX8O+Ats3xMehmcGAWA/7JEfCN0YF8+IhdpkGxxrODwmX/zlNGg6br+gZY12j0ikbWZ5tPiFjfw65opXwuPSQEAgiXnCHHlNcj0cLEU/L9zuRa9vqLPjdljX84+q7G0MDyIH63ckgpS5MYde8QBqvKi9Bp9dFi1lGhFOhU=
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 12:28:18 +0000
Received: from CY4PEPF0000C964.namprd02.prod.outlook.com
 (2603:10b6:930:88:cafe::5b) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27 via Frontend
 Transport; Thu, 2 Feb 2023 12:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000C964.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Thu, 2 Feb 2023 12:28:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 06:28:16 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Thu, 2 Feb 2023 06:28:11 -0600
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Ajit Kumar Pandey" <AjitKumar.Pandey@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: SOF: amd: Fix for handling spurious interrupts from DSP
Date:   Fri, 3 Feb 2023 18:02:52 +0530
Message-ID: <20230203123254.1898794-1-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C964:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 254767e3-0de9-491c-c880-08db0518f6a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyDQduxVeOk9WODGGBunmzzTpav+bOATYpFlz+IlzabehttlTbT5q0Y9SwG1ZlsFuZriuqfH6CWttMnLBq6wxsy0/S/DLHlufgjAC2DD2LtwBmICvgLtK830RK5at2W2rn2R/kMB3CjScSp8u4T2zVLHnWzUUnKMNW2+s8g8FUrvmHCV/jO7bUvrzjV1aOyZTQHSSTMeMAbsF+pP0QdJ74mQ1dR5G4JOV3A6tIcTDx/pvVZKzr8XgTED0DbIL4LKNL4euRHq71Fe9dFiAVhC2s/saUHOwg4fftAV+ZIZxZM4VPMD8R2wAXawMU1Bwd+BWOd2jCdIeKyq7j/IfS1PWNraj/4Jhlc2RpwwGy8v2qdetDxSauX5t2ZJqkTozfCPwiLWsWAzCPIfqG++qs8c383SCfj14xAxXlLdvPiz8eEmd+n2XE/L5r35xaGFyp+as2uYdLizfWyXwiJ2hAYJWv8lDZW2ucoEF81TCuWKoHeovam6lVhH9WGO/GV8yupgMvIfbcTNwItiGxgIPkC0HjUMVEXJEULYxQM7JSlNfITeoG+oOTPAPnr2Kuc5acrl+SxhsOd2TdVVpJkbrBlbWBwPZMUv9eIuhgaT20skMVv3itO74Wg2qE8vgILx+ncrJGtwqImRRo7P6DulIK/D7GQ9VO/pVrQqAYe502S6xDhq2+y25xvyqMdYbulZttXpoFSyUPJn5O+V8ARLVtEVNVQq8IAiP30y14RVNRqHcRo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(110136005)(86362001)(82740400003)(54906003)(7416002)(5660300002)(356005)(81166007)(40460700003)(6666004)(36756003)(1076003)(26005)(186003)(2616005)(316002)(2906002)(82310400005)(47076005)(40480700001)(70206006)(83380400001)(426003)(7696005)(8676002)(336012)(478600001)(8936002)(4326008)(70586007)(41300700001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 12:28:17.7573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 254767e3-0de9-491c-c880-08db0518f6a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C964.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As interrupts are Level-triggered,unless and until we deassert the register
the interrupts are generated which causes spurious interrupts unhandled.

Now we deasserted the interrupt at top half which solved the below
"nobody cared" warning.

warning reported in dmesg:
	irq 80: nobody cared (try booting with the "irqpoll" option)
	CPU: 5 PID: 2735 Comm: irq/80-AudioDSP
		Not tainted 5.15.86-15817-g4c19f3e06d49 #1 1bd3fd932cf58caacc95b0504d6ea1e3eab22289
	Hardware name: Google Skyrim/Skyrim, BIOS Google_Skyrim.15303.0.0 01/03/2023
	Call Trace:
	<IRQ>
	dump_stack_lvl+0x69/0x97
	 __report_bad_irq+0x3a/0xae
	note_interrupt+0x1a9/0x1e3
	handle_irq_event_percpu+0x4b/0x6e
	handle_irq_event+0x36/0x5b
	handle_fasteoi_irq+0xae/0x171
	 __common_interrupt+0x48/0xc4
	</IRQ>

	handlers:
	acp_irq_handler [snd_sof_amd_acp] threaded [<000000007e089f34>] acp_irq_thread [snd_sof_amd_acp]
	Disabling IRQ #80

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 6bd2888fbb66..d5ccd4d09278 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -318,7 +318,6 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 {
 	struct snd_sof_dev *sdev = context;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
-	unsigned int base = desc->dsp_intr_base;
 	unsigned int val, count = ACP_HW_SEM_RETRY_COUNT;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
@@ -328,28 +327,20 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 		return IRQ_HANDLED;
 	}
 
-	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
-	if (val & ACP_DSP_TO_HOST_IRQ) {
-		while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
-			/* Wait until acquired HW Semaphore lock or timeout */
-			count--;
-			if (!count) {
-				dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
-				return IRQ_NONE;
-			}
+	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
+		/* Wait until acquired HW Semaphore lock or timeout */
+		count--;
+		if (!count) {
+			dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
+			return IRQ_NONE;
 		}
-
-		sof_ops(sdev)->irq_thread(irq, sdev);
-		val |= ACP_DSP_TO_HOST_IRQ;
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET, val);
-
-		/* Unlock or Release HW Semaphore */
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset, 0x0);
-
-		return IRQ_HANDLED;
 	}
 
-	return IRQ_NONE;
+	sof_ops(sdev)->irq_thread(irq, sdev);
+	/* Unlock or Release HW Semaphore */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset, 0x0);
+
+	return IRQ_HANDLED;
 };
 
 static irqreturn_t acp_irq_handler(int irq, void *dev_id)
@@ -360,8 +351,11 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 	unsigned int val;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
-	if (val)
+	if (val) {
+		val |= ACP_DSP_TO_HOST_IRQ;
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET, val);
 		return IRQ_WAKE_THREAD;
+	}
 
 	return IRQ_NONE;
 }
-- 
2.25.1

