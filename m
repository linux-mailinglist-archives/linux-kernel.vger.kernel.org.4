Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A46642809
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiLEMHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiLEMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:07:13 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE902120A8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:07:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRAOcUca+ER+7YC1M83kpeE7NJNvYULRKz8pX1pLqXIvT/H1+EHiB87RM87PFSAfKEnyZqW7OfKnZRr85hBvwgrtuvTefyEyJcx7UeLl+6bkjST673VMITg22b1+Jy1h6oslyJ7WLKYkaDC8680410kOq6mTpGDxgm6qE7rCwTUuwqKQDAm2Ld/rlI8YPhAbahY1XyjSQCGx+Y5Q0D9aJLFd6GtwbOl8Lz7p8VSEU3nIpvU2L+bT3i4vafyxYOq981ZthLStMdtoOkdtASntHATZayFECyXSgeDuuH3AlHOSX08WJfu2pZvJvpay3apL+mQyXAzKTvQRdB/TEPR8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vF/MdoHxIs/dNMRujRZ1nZS3C4cCmscams5Llrr0zHs=;
 b=bGc79BXOuxhf9xR7k/1aQyeMxeSXaJ8LkuG7MYFa1jW3IPHdtpuCFJBiHF+EpC64fXjNwqtn9OQSSjKAGbJccGIrzD4rl1ypu60a/6joJlrgYelU/2g9UaQ+KqRGrnSQHUJxzLSXuU8ul9VxMC2A0N8tAo69ZMYqX1GJ0POl4moJfTcaTNm9uPEIbPO85qEUeduCPZQJ1tuOCN/Ti+oxwBqK3bKvP130RlEoRPYSn/YBeckF+FP2LAhAQedwUvpu7qSPUplDUq2eK0CPgcRkgwqOl1/WmGveTB3LlGEVab87JyeIlqGWPlrZ1zkSs4U6KNs1wHbLNOIqAmgqYTfJmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF/MdoHxIs/dNMRujRZ1nZS3C4cCmscams5Llrr0zHs=;
 b=MivUhBi/2dbvloIonxKTymLC+SgxhVEWwctEij/iVYsvmIQhnjpiyA0ZKnAxLQzoW3/KEM0qtBJZV9bDs04f5EGK84Qp5Av5tjM16lrWdtOmsR9lIFF2JA1tdRgNBuvONqwcWSRQSZnrgM5UIdU0jcbD9nmwFM9EshCqXxtlwc8=
Received: from BN7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:408:34::29)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 12:07:10 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ba) by BN7PR06CA0052.outlook.office365.com
 (2603:10b6:408:34::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 12:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Mon, 5 Dec 2022 12:07:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 06:06:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 06:06:52 -0600
Received: from sof-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 5 Dec 2022 06:06:46 -0600
From:   V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
        <ssabakar@amd.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
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
Subject: [PATCH 1/2] ASoC: SOF: amd: Use poll function instead to read ACP_SHA_DSP_FW_QUALIFIER
Date:   Mon, 5 Dec 2022 17:36:48 +0530
Message-ID: <20221205120649.1950576-2-Vsujithkumar.Reddy@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205120649.1950576-1-Vsujithkumar.Reddy@amd.com>
References: <20221205120649.1950576-1-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3685515d-02cc-46da-76cd-08dad6b93c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXOCcG8NgnTSUSnG5j9Czl/TFlZAi7XnRZFw7kvHT02cfjhHHNMotfsPlDnLzaLGYzyPmldaI0Sf78DYeEFcVzxeC4cbt8+RuXnBuTml7cFUa43zOQhXgXBgF9J49PQVuJED612MKKcY5O0mV+8STk+rrVnkyTpZcaBsb/OS38n1+zXFD3dQXZ3Tt6NHij3aUq+p+OGeHpiSwTQ/TX5vON9ZUk2dluWC7VoBenoTwgpDL6Ex2Txc4VfWxi64QcYOuQoooD/u8ZLgaErXnHvHLygRb85CCnJPRyjcG3KbWBw2wtt/8F5++oJPDjYDnqqena7sJTG1qkrv2aSTmz5SrinTtkWfYxZjjdJJwIEEIxjD3lm7e/5SHaKjnqd2t2E3dFCslbTKOCNsAwRpb/IBHnCYLRTfSoxBfCe73B3P4g5G7z5qFLw15y/ZQMEi9CdRequ1quRVZ5Tegn711iDBgT7ntZh5oK+OHP0wdbSROB8e0CiRcaBwR89+GAnDYjMzd65K1kGsbgL7PlBeaPiCSWt5uy99g8S1GLZwpHMsJLlz1GZooy4fLfXa5M8HslgF4epGIg3MYhTik2fhaYgtIRzSzv8c6+T9BHnJkj9BUqqESp9jV3eKjM2ScppbWG4R6BEXnGEpJosObdzTsT2tA1Tpa+GzVGFuHG9edTSlqDIfOd6pvkrjKR2heTVLWSl9yeoAyXYNSIJHPvqxDfCrX7VpQDlXC5oSZg57pE7evt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(1076003)(41300700001)(7416002)(83380400001)(5660300002)(336012)(8936002)(47076005)(426003)(36860700001)(82310400005)(86362001)(40480700001)(36756003)(40460700003)(82740400003)(356005)(81166007)(26005)(316002)(110136005)(54906003)(7696005)(2616005)(186003)(4326008)(70206006)(70586007)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 12:07:09.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3685515d-02cc-46da-76cd-08dad6b93c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>

The Skyrim project and Whiterun met error when DSP
loading during device boot.
Ex, error in kernel log,
ERR kernel: [   16.124537] snd_sof_amd_rembrandt
0000:04:00.5: PSP validation failed.

Use the snd_sof_dsp_read_poll_timeout function to successfully
read the FW_QUALIFIER register

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
---
 sound/soc/sof/amd/acp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 47115a77c92c..6bd2888fbb66 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -255,10 +255,12 @@ int configure_and_run_sha_dma(struct acp_dev_data *adata, void *image_addr,
 	if (ret)
 		return ret;
 
-	fw_qualifier = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SHA_DSP_FW_QUALIFIER);
-	if (!(fw_qualifier & DSP_FW_RUN_ENABLE)) {
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SHA_DSP_FW_QUALIFIER,
+					    fw_qualifier, fw_qualifier & DSP_FW_RUN_ENABLE,
+					    ACP_REG_POLL_INTERVAL, ACP_DMA_COMPLETE_TIMEOUT_US);
+	if (ret < 0) {
 		dev_err(sdev->dev, "PSP validation failed\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	return 0;
-- 
2.25.1

