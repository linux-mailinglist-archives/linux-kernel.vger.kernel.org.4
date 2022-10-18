Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B185A602BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJRMXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJRMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:23:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB13C1151
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWbWjSPJnJNLcooyz8DLmqGTfyH6qLdDwg2JUfNPu/ycl1orL/+AOT8IKGhe/vtdaey0wWlU4k8crN5nvXtaeUvKum9+pSBMd8sIdSxzhsXfEkvhXaG3ZWtttkbiQ9BAZNNC44GR+GfUgN80EorKe6eeTfYMzQar6qPELD/QOLcdHhkW64j+h3rtEyIWR05HknNIoP2Zw9JXIuCQQTDuQQ7trtqXccGzpLl2kwFjrDjcX1pK9BRGF/R50NX1/zUnuZi0/MPDCK2nqbbHAQcRyPuY0ikJVqsjFZQahEyl/o9Yyoc89qzUUJN5u66tW1YNrACk8/1o7HB6ay3ffc6yhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QAaNCs9I+7zyHhQe9YVUzoRog0YTxYZODG4wJ8vQ+8=;
 b=WtdZKTi5WEDun+YBLY/hB6F5v0Edcm01/uHhOnAFnqNq1oBV2ylho683rMWX/4RG24ltV9YSvhZaPzK2ToHxyyaDl5vX0phqWZtccSSaprONBzNWz3F6EqjwxH2WIchKz5wjM6Rf92bmLphS70GiSOpPXIY7yJZyuE9zr3etJokEmhlSv971Ejroi4yl0ymd2YAb7pgEgl2EjkX2ydtRLyWz68t7npkBPIoa0QIckjPjlbLz85i8vsjEonQsynGp99hwpoLmDKk9B7qOX8n1Edr4QvcW8nadMyaeqb3ioYgFtNg1emmfVz2Iv5MNRadCiIBWHFwzELgr9P+6CQHeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QAaNCs9I+7zyHhQe9YVUzoRog0YTxYZODG4wJ8vQ+8=;
 b=ELqjXet0ziTOACz1i4y8et8GMXobAK2aMYGcupVs9PUZlcPu+3HIkW/dKN0x0cm+25igQZvl86L2SlR01GWBWZvAUo+HYCwhbW/W0WtBjQd63EBge4PaSfPGg78YBGBtfsedhbZRFO2kFAJav18JIxsqITSXRjFVN4LSYgB+Vps=
Received: from BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31)
 by PH8PR12MB7134.namprd12.prod.outlook.com (2603:10b6:510:22d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 12:23:16 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::81) by BL1PR13CA0146.outlook.office365.com
 (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.16 via Frontend
 Transport; Tue, 18 Oct 2022 12:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:23:15 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:23:14 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 18 Oct 2022 07:23:05 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASOC: amd: acp: Add TDM slots setting support for ACP I2S controller
Date:   Tue, 18 Oct 2022 17:57:06 +0530
Message-ID: <20221018122711.2559452-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|PH8PR12MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: e0630dda-b2be-463f-448b-08dab1038840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YlqSMHSlaTea3XF+MQ7j1FBaAknA1UJfyTkN+pA28Hg109M25OHeL4eZ9ltO0CaQ6PVB/Vla4LPwdBUVJsmZ/Y7Wvi9T+fxBcR7lvl6l8qEoraaqbtyLUEEHUimMne4MZ8ANWRGXiQsPhwJLkVZhNC/nU0M0tAJt9meS2ANJ/GRE+kg0zjwb2D38SzxYYdFJ3yAM2jMYWACCZ8dYIlYtF9FArNQDxl2tgIlCwfR4oSaXXWQNAqY2MDHFRHPWMDEUiEzYXD/4JKTOtWBauyEuZqPKo6ZPfKTrJhY8f2mNIkq9xbuU876pfUMcWvJ6VEmyZsF09TzAaEjyZwTvidzpZNnY+JwZ+qP3QqXpX7kZou9NC5peaTMy3c6BrfmmvgjYXkpiuNUtLXhSUhn0q9yzbgGRJqs2mtdbi2r/1uY93abGfxkS1MeMA7NzKceKvEKsfcmhd2XgseJuOdDA+uaeT2i1JwXSOncEh6x+wOQXMNgMqRWJnanYEyOviui3aWEkiv2CCuOnpsgRV5FciiAlq/XCtacV/12A7MsJojfpQTIR0OhAvV/kTRT87wIHolXwqvcpm+c2oKM+G5uyaJAdkuVvqAByz/MWgWPZ6Q1zozUFFClM59lI7uDkEJ9jmu1UhFRzrhKXF6mo73KUi3xSzYbQOrhM55b3NW9d1n/1ue8v4s/uYom9VLVEqw7G/rLlppRc2p5vkejcpUxnjAGFgctcVcyjdZ6W760Yw7ZHzZKXg2ALopij3A/qrhiHqVGo97KV3tzh8mYBQOyzdRLU9jP+kho3Va5oH60FaBCsBymD7ULnV3q3F/hHZ7nSzV+h
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(110136005)(54906003)(478600001)(26005)(4326008)(70206006)(8676002)(70586007)(41300700001)(8936002)(5660300002)(316002)(7696005)(2616005)(83380400001)(82740400003)(47076005)(2906002)(186003)(336012)(356005)(426003)(40480700001)(81166007)(36756003)(86362001)(1076003)(82310400005)(40460700003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:23:15.0902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0630dda-b2be-463f-448b-08dab1038840
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify set tdm slot function to set ACP I2S controller slots
in tdm mode based on number of slots.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index ac416572db0d..09b6511c0a26 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -51,7 +51,7 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 	struct device *dev = dai->component->dev;
 	struct acp_dev_data *adata = snd_soc_dai_get_drvdata(dai);
 	struct acp_stream *stream;
-	int slot_len;
+	int slot_len, no_of_slots;
 
 	switch (slot_width) {
 	case SLOT_WIDTH_8:
@@ -71,6 +71,20 @@ static int acp_i2s_set_tdm_slot(struct snd_soc_dai *dai, u32 tx_mask, u32 rx_mas
 		return -EINVAL;
 	}
 
+	switch (slots) {
+	case 1 ... 7:
+		no_of_slots = slots;
+		break;
+	case 8:
+		no_of_slots = 0;
+		break;
+	default:
+		dev_err(dev, "Unsupported slots %d\n", slots);
+		return -EINVAL;
+	}
+
+	slots = no_of_slots;
+
 	spin_lock_irq(&adata->acp_lock);
 	list_for_each_entry(stream, &adata->stream_list, list) {
 		if (tx_mask && stream->dir == SNDRV_PCM_STREAM_PLAYBACK)
-- 
2.25.1

