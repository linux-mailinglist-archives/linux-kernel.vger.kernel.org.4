Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA901629261
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiKOHVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiKOHUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:20:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF1820996
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZr92QU9Gaaz/7i03FOuSPorfk+BR/liKbEHzB/exPj16jxaJYNruPOJ7SKGy2b7NliF3/JxrySNLu3tfUOcv8ozJJlrYXL82PoX4uVkHtX7jZ6iqagoN4CSB0Ajz7ZVmuOZ5zHEG884SyBm/+hE5SJfZt96tzZtuMHlXRz8BwHz3NRqyiOrJvOyAg741XPrMWso+4GSAeb/hm3HTqtUc5Rt8hfH6NtJSKciCydU/5O++7KcKODhXUdC1J86D+XgcuQ2qrOIfp5Ud5yTz3/b5cx3E7mkOyFlCQuuStqbx4OlKuP6wfNfHHtv97/LhFSSoIhf8YyVbBMK4hs01ShcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCXHXG5BtEYgf/+BYK3iyUAIplq/6UzsISAOKgrXkEU=;
 b=PqWZZjPNdOGT1CnqThp+hG+FLy2xG2dN6J+1e+s6MUUjatRYkAqGgd3j0IKY0VkZ438KT3ByEQ5jKzO6Y+sbNRPq1CO+ZZZRmHY73V97CxXQB8tWfSNiKvnm8L1Ef9+npd0XdpejhqrcV5HxmhMce/3VZfdFSwNvTIzpdCL649NOWvplGcnhJYgaaDvmOZnbg5wZnccyWivUnoPnn4NC/O4PdT1/qScMVAEhu2j26E2RJUDk5HEM2MtE8dzX1JRNmIoZ3RpUygWD6pUqZvuYuJtI8m1ufyurQRtOksbJbbCOnFMoCFZJDRGgO7oEzp/uGE6yUJYEbDc958QOBWTOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCXHXG5BtEYgf/+BYK3iyUAIplq/6UzsISAOKgrXkEU=;
 b=S7HOKDw5MkhIvP1BxGNyLn1FzuGMdJuO7Znq/OZhC6/SfsxQkPxpvnzb3PpJfM6qOJVLgnXkEPEh/GNFzAOlZc3I2i0hO7yqHty7unSGjwUMRhbus0+9x8tcjtEU30wU6ByxMh+1TCivykGHOkI0Ay5Sqm/Ikvh9BPv/N0MaOxI=
Received: from BN7PR06CA0062.namprd06.prod.outlook.com (2603:10b6:408:34::39)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 07:20:34 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::fe) by BN7PR06CA0062.outlook.office365.com
 (2603:10b6:408:34::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 07:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.11 via Frontend Transport; Tue, 15 Nov 2022 07:20:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 15 Nov
 2022 01:20:00 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 15 Nov 2022 01:19:53 -0600
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
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: SOF: amd: Fix for selecting clock source as external clock.
Date:   Tue, 15 Nov 2022 12:49:54 +0530
Message-ID: <20221115072001.1931617-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115072001.1931617-1-Vsujithkumar.Reddy@amd.com>
References: <20221115072001.1931617-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bd6ff4-12fc-4a1e-32e9-08dac6d9e2dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v08EEO4kHVKEXndxD3FeTwyFW8puM1jt4NQQQ+NDPItEkrbTLwndMsPzqIArCUFfRXaJjSJGT6UhWdLyi0QeSD4ta079LiOlaeh00tb3acUPbORBZx2M0+0xUMeRw3MDjNqoUDbDKr4ZFOvjBx3IVzdtj2EbE7AV1VxDNLWe/5zYExH3fGFFe8SUBpc5BGArXkCcC3MeKsWFLxF6+QMPgDIETVWPlGSYkkZXXU3tKN5zqGOVYHJD8idEcUQAAUVfFFu/+XX96/zp5xcF3FuW28pJiTaVQG/GN279cP8sqxB/PHpIEK+ccKP6ovkTAGUs/TAKa59XDPmowWsysCw+6poBA8VGTV0H1NHsZRUvlUIxT3uYhQS/4d7WbP6Tgm2eU6FIFeg4oRf3ys9sUdfzokHZq8vlE30E0irw9B4Jd1J0FpUTJrdNSIHZlpAjjPfsgV53IEuMyOxItIsZadb8a5CUAeVEQxKZWkLwInpZNygnSm5EZSg9GcqdBWdZiWxgqVt7zfMFc874wMrCSRRqQ4lheLyYrENhqZ/l/4HdPFj6Q9n9p3Xgok7vw5qSB6w5pThYCG19BtlZq9jDxPrc5Bp1UuATS6NYRCdiL94QtnVl1gd+Ta4Q95+S1BiH2ML++k3M/s+8MEL2LohiOy6fBNdY/B85E3xnS73peVb54jcAlUOo24ldoVXRI21QAPB4iOMu2btBkL1Dv1vhItiVlZv6t3wvBITCAYSPuVNRVK9RxN00rdkjOC4rTeNJz3S8BleJmQbEDjXlxjLxww+Q++rIIWCzqennfUj8wFYVS3rVg0crwlNSdllsJd+frypd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(36756003)(40480700001)(86362001)(83380400001)(26005)(7696005)(1076003)(2616005)(47076005)(426003)(336012)(186003)(82740400003)(356005)(81166007)(36860700001)(7416002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(2906002)(70206006)(478600001)(70586007)(316002)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 07:20:34.2162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bd6ff4-12fc-4a1e-32e9-08dac6d9e2dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default clock source is selected as internal clock of 96Mhz
which is not configurable. Now we select the clock source to
external clock (ACLK) which can be configurable to different clock
ranges depending on usecase.

Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp.c | 4 +++-
 sound/soc/sof/amd/acp.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 36966643e36a..47115a77c92c 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -390,6 +390,7 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 
 static int acp_reset(struct snd_sof_dev *sdev)
 {
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int val;
 	int ret;
 
@@ -410,6 +411,7 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		dev_err(sdev->dev, "timeout in releasing reset\n");
 
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
 	return ret;
 }
 
@@ -456,7 +458,7 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
-	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, 0x03);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_clkmux_sel, ACP_CLOCK_ACLK);
 
 	ret = acp_memory_init(sdev);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1529c6d9bf9b..76ad963faec1 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -69,6 +69,14 @@
 #define BOX_SIZE_512				0x200
 #define BOX_SIZE_1024				0x400
 
+enum clock_source {
+	ACP_CLOCK_96M = 0,
+	ACP_CLOCK_48M,
+	ACP_CLOCK_24M,
+	ACP_CLOCK_ACLK,
+	ACP_CLOCK_MCLK,
+};
+
 struct  acp_atu_grp_pte {
 	u32 low;
 	u32 high;
-- 
2.25.1

