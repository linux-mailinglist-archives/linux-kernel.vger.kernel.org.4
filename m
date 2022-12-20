Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83BC651B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiLTHXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 02:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiLTHXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 02:23:06 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59991057E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 23:23:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7ucRJ+zsIBM3Mw8Yi2433DwYRKkB7MVoAMHQSijVt6C8y/85aHNbzydNx+5GdnbHKTXCPfWjqbluWk0A3mHo8+aNcagSsUiieJMDaw/mRlrSOA3qJj7tApx93gZGiRM4kgbVrIvYdgyl/0mtI+OHgbXnu5qB+3dZipaWi2OyXaO8ba156RclZI3re66P6kwQTTrwN0ffr2xR2DTbJRu9RJsBBlT3SnZtuV7zB+ZVok95NwcwmPGqfgFYmfsZ2ahAA3Va4/Ef6qXgOHO6ecfRrMRjbwLKgojgWdbRkuQCeULteO8LLuesIrvBFtc11LUUjkUAld8NAiNnV3OGrX2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wa7IpqNolNQl3j7OOVK9dnF3RlNogITv8+toSIkQVg=;
 b=T8QeTWJyw04FVZCFwLHTJvW7oO0IW5XH9gea97yqPsjEtn/odrYnAtttQ0py3f/xcmyCfJBcY8lbAW8FyrECn4naXcEU9hWyENp+wYfdCcnT96v7MCVhafYb6PbHZwmV6hfRP3brNUfbONG3kR20ibByCbSNZJzM0KQ7TlFVbpoM7fLRtwtYX2DD2ZJY/Rju2uLr3Ypsh85IJjSvYD2nOkdliCygJppLAiu8lg1WwpJbBcYdfxdsB8NjeUu+siVHx634S+Y9+olYxrlYs1n4HpJ+y2hebhyOMEm8si5zw3Hx0rduwwS91ULsbAON11sFTeOVcyHhEM9vd/oGlwsIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wa7IpqNolNQl3j7OOVK9dnF3RlNogITv8+toSIkQVg=;
 b=Y4T8Oom+1bk7pgTLFuOJ0RzgOwL/dRN3qpRh1zxRfavG7YWgwnf18pVU5iKgrVt8VHVxUO4I0PxU6KeGAHEIzC6peyEAW7/4RNyspLHwki+PymfFw+vT9g2oEltlVnhr52/JlgioS8pIoIQwU6bFBf0tvh+gIUEMTw5Ca509d/4=
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:23:03 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::2c) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Tue, 20 Dec 2022 07:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Tue, 20 Dec 2022 07:23:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:23:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Dec
 2022 01:23:01 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Tue, 20 Dec 2022 01:22:51 -0600
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
Subject: [PATCH 2/5] ASoC: amd: acp: Add new cpu dai's in machine driver
Date:   Tue, 20 Dec 2022 12:57:02 +0530
Message-ID: <20221220072705.1456908-3-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
References: <20221220072705.1456908-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 046be12b-fb7c-4d52-2cff-08dae25b07e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QkKybKJo0KE8z92B2gX9c46SoUrCnL6zmFhNFhqQ389kq9Wvw4euf7eBeOvFWqHpIJQZ4RGPcJPG/A30L+6cTDdjVhs0WFnmKhRgEOhH7QmU+6+7p+zd4ySlC1m3IGdwL2LsJzjPcb7umhwPCOBfsulbvXEQ2TWwaugJqWzq5ErBmsAGO39aPjKEraZymasStrRo7bayqPWuSwKjEGYEoXzntpF5/3W3eM/L1+iPP4H5IZ/boK/RgMs4Zvqnm798180bFG2LoHz+daESZja9Ix0sljmZpCxX59yPiBH0iPqwnfAkh5UKs2h29I5yDcJO7GX+DuR4vLDEN52FFIIVdpwHPqL0/WZTKVIZSd2ijmanvew9HOERQHn5VuBgtL8SR7k6GRRNjYWJ2hndt10SQZ9FSZNQdVDamt3Le8qKjTw5BxzXbQ6FJh0hnMNJvaMqxAUZ3oVpgFNJKa3fOjUcrn272u6P6TQUNz879KN31X99WaKRjXo3xbgFRuvGZBTQtnKXS1vby+OgWvS64foRxGCkQWGhMylc2LZqU4NDJyetkNPQNkF0eNu+QLwktma4uyqXd2POYn30M3U1jk8syRd4X/dy7Mtsv4uRZEENwDpNdUbYHJYFqlPyaWBNAdMrf8Cvr+eaOm05fP/400JGM+vzaNzvKA0iIBFWLv+rABC4Fv+LbugUQo6z5Vf8lbwRJ4VYuA3igLc3f29POj2rQC1OJsQETQyDG+KVWh3zj4Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82310400005)(36860700001)(83380400001)(36756003)(1076003)(336012)(2616005)(426003)(86362001)(40480700001)(82740400003)(40460700003)(81166007)(356005)(316002)(8936002)(47076005)(110136005)(2906002)(70206006)(4326008)(8676002)(54906003)(5660300002)(70586007)(186003)(41300700001)(6666004)(7696005)(26005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:23:02.7639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046be12b-fb7c-4d52-2cff-08dae25b07e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While using same cpu dai for 2 different dai links
below error is reported.
error: can't find BE for DAI ACPHS_VIRTUAL1.OUT

To avoid this error add new cpu dai.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index 016110fd6ad8..5132fedef00f 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -568,8 +568,12 @@ SND_SOC_DAILINK_DEF(i2s_hs,
 		    DAILINK_COMP_ARRAY(COMP_CPU("acp-i2s-hs")));
 SND_SOC_DAILINK_DEF(sof_sp,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp")));
+SND_SOC_DAILINK_DEF(sof_sp_virtual,
+	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-sp-virtual")));
 SND_SOC_DAILINK_DEF(sof_hs,
 		    DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs")));
+SND_SOC_DAILINK_DEF(sof_hs_virtual,
+	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-hs-virtual")));
 SND_SOC_DAILINK_DEF(sof_dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("acp-sof-dmic")));
 SND_SOC_DAILINK_DEF(pdm_dmic,
@@ -704,8 +708,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->amp_cpu_id == I2S_SP) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
-		links[i].cpus = sof_sp;
-		links[i].num_cpus = ARRAY_SIZE(sof_sp);
+		links[i].cpus = sof_sp_virtual;
+		links[i].num_cpus = ARRAY_SIZE(sof_sp_virtual);
 		links[i].platforms = sof_component;
 		links[i].num_platforms = ARRAY_SIZE(sof_component);
 		links[i].dpcm_playback = 1;
@@ -736,8 +740,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->amp_cpu_id == I2S_HS) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
-		links[i].cpus = sof_hs;
-		links[i].num_cpus = ARRAY_SIZE(sof_hs);
+		links[i].cpus = sof_hs_virtual;
+		links[i].num_cpus = ARRAY_SIZE(sof_hs_virtual);
 		links[i].platforms = sof_component;
 		links[i].num_platforms = ARRAY_SIZE(sof_component);
 		links[i].dpcm_playback = 1;
-- 
2.25.1

