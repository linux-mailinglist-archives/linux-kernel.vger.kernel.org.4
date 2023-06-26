Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B073E144
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFZN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjFZN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:57:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0591BC1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9eK5LL07BuOxoyATovV+/cbIEeb1gIVABJkRy/9fsP1Jnid7+ur73nT029kwnBsocBoXAKdrqh11pe4JIXaIjvXT36Ws6yNxWksWw2ymOAXcUxrU7jQ4P2I5c0iGFcgYeY826hAyl1/U9paTPPavKUhOF6/6nu8JlRQNngN3MJAzhX1EPZjgc6DASlqQz7KzYvoxQiFcPSEd4zGtdEaCf2l3VDE8Njzp+wcTX0O7XDcY8gPYl9QhlVbWQtOEhZ14m0KdtuBzS+ZFLH2bBPlSVCSKFtK7O0t22JBoJR6h4WCioZyFTJLRGDv26Bm1bIBvw299Zskd41stOL6Ol/prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuC/p36abO8JEZCdYis01V1LLwMVRik6s9LS9KgnaLE=;
 b=G9NW7VBHdz1WtowoIymLsjAGRoTxqAZ31d8Vt4Ma1+ctfEyqRf0UsWXOpyIFc0GVysuueSuime8WPlgqe2cKmZkml1weO35gQ+uD3iZAMKvGI3SClP2Sc1qZqQwuKeYG8UAD2184NHPCCBx75ogpYdaY/YdYMLqfKTmkmX8G3g3x0r9og1dRinl7olNwyI7dpk5iHJY97VSRKudC5grA+ar+m9/rEHFVRR8bZbe6KcvN02TXBVlgEAr8Yt/7yBL/5K9g1wZ9ZfmQMHtk7uHCCdl2gkN4urCQV4s1+gUPreIFauSaUjwzWf0+5YCLqnkQGemIxtsiVOXvnclXSr0y4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuC/p36abO8JEZCdYis01V1LLwMVRik6s9LS9KgnaLE=;
 b=aNaKnx/n0sMBk6UppIC/7XOjyDluvKFG6OeQcDy4N64jt/wWe4FG9nSi3IeFrRXT0D8nqWjQ5tU/DV8aIr7jG0mTZlhDQ8pEPpaRZ0wbT8FSNt8OMdxRfLVimV8lysiMIoLGQswPWcxkE9yhrZdEJ5xE9d4unMLHWzx5CK4K17Q=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 13:56:52 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ff) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 13:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 13:56:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 08:56:51 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 26 Jun 2023 08:56:47 -0500
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
Subject: [PATCH v2 08/10] ASoC: amd: acp: store the pdm stream channel mask
Date:   Mon, 26 Jun 2023 19:25:12 +0530
Message-ID: <20230626135515.1252063-9-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
References: <20230626135515.1252063-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 09440f0f-7ff1-4c44-e299-08db764d31c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKBYp3eaABjQIWrU2LQcYNOD0FWFUE63ifDYzchQnGxvsANKgKX+mRJ3iyon+QSu7OD5NyFe3sVi35XwBA6+2eptqBQfWslxFtJStTMIs2lb+Ll6ftyoDEB2ax9OIzUtZbAStepnsccmRIr3GySc+lQHBnsdOy0XpaZluwpSxBZa1vv82au4e8nnFEFTmsHRo1pAVOr/XfBgr8s68qhbobVqAP15DyCPb5B4kkV+4cqSFHIfHhCO8CLF3miUgNVpcQFPrun91V0+dHh1kb2dyMebXuEz49XWQWFexRqm5mdlVffsOsS9wxTZMikbrdd3/TcimvqojeBJxtGJIl3FuFLW2tGFj0k6S1q5FdjZGEqiTgLjSqgQIR0k3IdSeVBILyDrkMLeemN9cEdGfIY3fFvZA175eB5Bv0KSnZ5LPMK55Qs0kgToXt30u7G0x7lxoDhOVSuChz5ZrMzLvg7i44M+l1p0ZDo5yhWsO60YkWFiMyB2wVdZ5EHsh+v5ljuhyY10Ibg6rLBWbPG9sLyXDqjFHc9huYIxGospmercLk7H3G+1VmlYPLdR32buPmBJGRkYMcsFVbkQKsNqBUl1NYBAdSZSjS49qTV/ZDc3HutwayNsp+iNV22aSO7XbYbqL8pa72+NkgyXCmkLCQd4gJO21yU9dKNxmuPNwWoydObuXaSlnw73+XzFfvfl+UtodS/VbdztSwO8dM7gZS4lEz6mUz5IEC/pQEuHwcARK0GoMm+fScSpqYVSwsgS3koZE85Zv2i/ZkLGlIH11uWfFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(40480700001)(40460700003)(86362001)(41300700001)(70586007)(8936002)(70206006)(336012)(2616005)(316002)(47076005)(478600001)(426003)(1076003)(7696005)(5660300002)(186003)(54906003)(4326008)(26005)(82740400003)(356005)(110136005)(81166007)(36860700001)(6666004)(2906002)(8676002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 13:56:52.2462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09440f0f-7ff1-4c44-e299-08db764d31c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
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

