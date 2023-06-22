Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C273A4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjFVP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjFVP14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:27:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694482726
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFVwV/LyLPhqp31pVznWNkj5MRgrkGMeTmzetOpjLJHiRB+efzHGMWtdTaxCxXEVqna7Gz/XZ4QhTzmYf17Nu+wFMm+fdQLwPyiJh0V2gWAJSV8e9XIiN0/HlBXjLmlH96IV57qXIswLXtNuYI+6FbwnFkc+/WZGFrObr0FoFH+vNvIPtLi7V1SKz9AQqhUF0HyWVkoDEd+uBA7p/EubbsOtrLPJpO6voNY0zMM3y6Hax5n0y128OLv0JeVdNRVEo++DzdjXH3JKgjYUq/892mNIogDeIqV3sBWhKQqSmL/3GRHBFLIbZtN3aYJSAI3MlN2JlKat/6Y2so1Z3VCCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuC/p36abO8JEZCdYis01V1LLwMVRik6s9LS9KgnaLE=;
 b=aUjxE9fjhIWv0BGnxAIZw9zbNDw9TxTPax+Z9rFfO90G3UwjQLvfsc5h67A7B7ws4yUoqD7RwwNiU01WQQw1iL22QzvE5GXph/QqCtRyZFLCCXhnQ10QZ2k853nvYa6whvtbEeSjVkXUJArq/ML+33GymyYsC8SGu3aJwW93thQFEjNoHlTfmxUF4eQ5/WAmEyA8tF/I5zSpYYVPeZuuhh8OBDd5sytrYB9LAt8RbtYrfrWtzn0jRviBiTHCfp3xmz1iVL0RpxlVHGy9SvK7CUuHxplowAQfiRWvTvPiekFkZO0dBjJMG4qyyEN9I8xzGu8EGJW6RiMpxIFcu3FFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuC/p36abO8JEZCdYis01V1LLwMVRik6s9LS9KgnaLE=;
 b=Ees8tQpgHvu70+U4Em5FhHH3fM34l3wOZDq34ZsM2r/2Z5SpVdw9Jg1RaZh8F1zmUzAJl3RM6F7LTvFD7hsZ+8dzSzTUWLpmtSjM09hL3OXBnrFojgQhXn0ztX5E+Z6MhPJICz5IPhfL+qKGnhXWkzO1drGBKv8snRYU4L+yOgg=
Received: from SA1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:806:2d3::15)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 15:27:11 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::b5) by SA1PR03CA0012.outlook.office365.com
 (2603:10b6:806:2d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 15:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.23 via Frontend Transport; Thu, 22 Jun 2023 15:27:10 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 10:27:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:27:03 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Thu, 22 Jun 2023 10:26:59 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/12] ASoC: amd: acp: store the pdm stream channel mask
Date:   Thu, 22 Jun 2023 20:53:57 +0530
Message-ID: <20230622152406.3709231-20-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
References: <20230622152406.3709231-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a44dc3c-38b6-40d1-481b-08db733525ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/oMpo+DEurf46h0l+XXiT3P2nfYdLBxN5lYemnb1aHnlWx+H1klfqncyl5xScku8NnVPXZTiSi1uClvjJ8h/AM91yjKlWguGexny6yRjtifKQ2pHnShPzSJFzEFKou4rFquqDs33GvZWuA02bA7VCik/kdIl0c4rMxV2/tQMX0OGNtDaLw73u5q8MvsK1F78iraDgv5egTKKrU/e0ZfpIHPPdLrvGPL0vrk7lvy5M1QZhpjGpfUSX5eUKc9jDJfoLzSLeZZW50zLtlKFHxfXZp3Fkaj9Kx8bf/bO7ixWDFVNlQubZ1hGu4kWcnxJdu4EofL1thLP2gchto1x6gpNHdV7StvHK2YL5kYCHymvrH847lTpOn0IDFyS7C41thaxrAO9JoxRYrW7NbLdLEFvZe400XvibKLTkbv9o7r06tIs+dYj47L0krTdKr7u/VEoaDwnY6ciOeP/R/VPeRwvZMq/lIlQJ6AcFbWeiIzYHIaUhKGQrcvo4DV8yrHgSVJiPeIqgcqgx+BK/8MshC17TSDKMH66cyicdDsnOgvMrU1VWdPx8itf52oLPZUM0/BWLqpNoCx0H/2cWnFjR3HhQ6tGAVmbSSIYhC1g9C+8to4lCNLsWDMcfOCXazHXPntI1HaEzg92vD8bX4RAz/YloWwuSlXFFV3suMQzFRvbWD+Q2h77TdwGuzefFkl7Vz8gD7Jd9ILLvwpffPzGssjvDUju6zjjB+VV+ArKMrF4AwxhjaywKkjzorH9Wwtz3vM8N30YlSZysM+wM8KKxztaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(82310400005)(7696005)(70206006)(70586007)(4326008)(478600001)(36756003)(40460700003)(316002)(110136005)(86362001)(54906003)(186003)(47076005)(1076003)(26005)(426003)(2616005)(336012)(81166007)(82740400003)(356005)(8936002)(41300700001)(5660300002)(8676002)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:27:10.9003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a44dc3c-38b6-40d1-481b-08db733525ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the pdm stream channel mask, it will be used during system
level resume.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-pdm.c | 1 +
 sound/soc/amd/acp/amd.h     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-pdm.c b/sound/soc/amd/acp/acp-pdm.c
index f8030b79ac17..2833d2b7e596 100644
--- a/sound/soc/amd/acp/acp-pdm.c
+++ b/sound/soc/amd/acp/acp-pdm.c
@@ -135,6 +135,7 @@ static int acp_dmic_hwparams(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	adata->ch_mask = ch_mask;
 	if (params_format(hwparams) != SNDRV_PCM_FORMAT_S32_LE) {
 		dev_err(dai->dev, "Invalid format:%d\n", params_format(hwparams));
 		return -EINVAL;
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 38c152c6c8c6..82e0684cb284 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -164,6 +164,7 @@ struct acp_dev_data {
 	u32 lrclk_div;
 
 	struct acp_resource *rsrc;
+	u32 ch_mask;
 	u32 tdm_tx_fmt[3];
 	u32 tdm_rx_fmt[3];
 	u32 xfer_tx_resolution[3];
-- 
2.25.1

