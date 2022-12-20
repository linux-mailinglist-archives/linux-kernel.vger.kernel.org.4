Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE3651B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiLTHXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiLTHW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:22:58 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091FA9FF7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:22:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tq4TL8lkBNPbqekHfdB4r/ZkRKxGYIbD7sBsl7JB0YihMDtdYfXSEYD6hosBmmsl19X4xDKBN7Obqy2HzP2Tx4Pwn7vrLpG/tNLgHv2/ihVCEUzxyegie7/rq40sZo+4ibxLGcmsEe3wjqcH1CLdlYtJs7U3fJrXiiq51d1thqw+53eD+ts/Qet2QdGx8E2E0PPd3xDiCXtrSX+YPukzw5XA6ZHaMDwJUJ0e/P3mLExasOClMfNeO/0l1Hmry+VOuAKdqG7jcvAmczMVYEQo/ZPETa2BfNmrnENPH3tqXaNZrmNnqqDGyjmg7w83l6ZMEXF1s64GQU+67HdSgbu16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FdkS6DEfFHEze2HIBSshFnNVres1tCHRpjco96ctNQ=;
 b=J6qc7NGkFWt3dLU7j1DMJ6ZZR6deu2yzkFzl8kui+QdMoU1a9uIe995pYgIfrgZ28/mQ3+hVp8kVQWuNWKtYwJiGfG57LcLnfUz9iTkrohJeu34YZi8I3ts/AO8ZldReS1zl8JUXfy+q+F4MeBAprNh2xiVxW+5V1Bbm9bi76NsaR/MpjCPXltgsI7aqO/4a4etZ+ZSSLAvdWBr7MBCgKJ3e8kA3uKdMeSTYcieyC++sTX3mXJrkechIZ48WTW9dI5SL3eHb6tlzepgS7znWIBoDkRMgCcyGLjO5Nx+o1pY0beiM71u2VlILSiSiwUXItsCOwIk121dFvCxc/UmPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FdkS6DEfFHEze2HIBSshFnNVres1tCHRpjco96ctNQ=;
 b=1eUzgbClPemi/EwhKlDwgvtIwqgPMAkYlsvVqbUr6thfFNXgzh74WnjSwq7s0ByQnC5vGlIcihKRCg0NRc8vPaVTdwKYFaiUWd7b25iVgdZfl7AAgLwDPKXBTEe/itJk9ajBOSy2cdwaEPhnaNkpaKqgDfTYI5gd8JX2BP7gR7s=
Received: from BN0PR04CA0016.namprd04.prod.outlook.com (2603:10b6:408:ee::21)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:22:54 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::40) by BN0PR04CA0016.outlook.office365.com
 (2603:10b6:408:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.6 via Frontend Transport; Tue, 20 Dec 2022 07:22:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:22:53 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:22:50 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 20 Dec 2022 01:22:40 -0600
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
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] ASoC: amd: acp: Refactor i2s bclk calculation
Date:   Tue, 20 Dec 2022 12:57:01 +0530
Message-ID: <20221220072705.1456908-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 59515763-6905-40f9-25e0-08dae25b02ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hhuIq7NkteP6/j4q6RIzBaSZVYJUvTC+xguxQzfIvk31Eh5oouTyOKZCKK4NFMfPHLr/zAH1bf4MuA+w1eVVu3+9QERQUN/+eNwt9Ki8ySW4wZmYsHYt2JmZqDE60Wa6PSmbQ4bzGy86e+uhRTqA3E9Hsdc8ZD6ST9gZxAACDUuCI+IQLypY0sU6qGOwP92le9b6ZZ8wv6nNbtGqS7MP999sZXHQR7UIEBa75uo7dHtqjuvv9tW97kGCWyxuvSeQ46uaGTfL9QDeW+BvLCrE1McsSm2W3calgxyB3AlOc7GzTD9l0EBdMoYclVwIQ9DgLpsUqQqRifI7hr1Fe4jTJYepnX3kEzR9XWZo7wzMCshb88ab5t4/+fU+s3CFX4Ois2DAWKjwFDPM+kP4W31UDQtolBte4b4GGeJ3pOTKBjsFAN9EsaW2w5tEz+wmF4oa1sTR9blHE1IYheLg5JlMLsvSe1ijAiRVcKw8DDuFHXTnLMFHsXaC0Yg5HdxPHSlctDseVV6NzBFXCry1e3Xgy5k/jhjQv5pnWkJZTzouAVJsubHT1TyoZQ8OvfhRQ+nYBrxbTPFpYcOKFJweWvp01V2f6LmSuTA+y8B42pYzSk3mGOtagz/rrs2O7sGhUpKeX6yzPf9G09yfeNF3hz+R5QrqvUWvhUMDKzFGtWpj+aYHYAMkLcZ5RyWU3Yp9FUPNNr1uSOf4Maf1F8yjtooUpOeHEj+XVrkgPjJCEOHe9kE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(41300700001)(36860700001)(356005)(8936002)(4326008)(70206006)(5660300002)(70586007)(8676002)(83380400001)(81166007)(47076005)(40460700003)(426003)(1076003)(2616005)(336012)(478600001)(186003)(26005)(86362001)(82740400003)(2906002)(7696005)(110136005)(40480700001)(54906003)(6666004)(36756003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:22:54.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59515763-6905-40f9-25e0-08dae25b02ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor i2s bclk value based on hw_params.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index a78cf29387a7..016110fd6ad8 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -352,8 +352,11 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 	struct acp_card_drvdata *drvdata = card->drvdata;
 	struct snd_soc_dai *codec_dai;
 	int srate, i, ret = 0;
+	unsigned int ch, format;
 
 	srate = params_rate(params);
+	ch = params_channels(params);
+	format = 8 * params_format(params);
 
 	if (drvdata->amp_codec_id != RT1019)
 		return -EINVAL;
@@ -363,7 +366,7 @@ static int acp_card_rt1019_hw_params(struct snd_pcm_substream *substream,
 			continue;
 
 		ret = snd_soc_dai_set_pll(codec_dai, 0, RT1019_PLL_S_BCLK,
-					  64 * srate, 256 * srate);
+					  ch * format * srate, 256 * srate);
 		if (ret < 0)
 			return ret;
 
-- 
2.25.1

