Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0146626B0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjAINR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjAINRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:17:25 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F19AB1D8
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jACECCT9MRLFv3pYd84W3Tkel+sxfOs/0hqfvV0ulYCSpVrDT6x2Kg50PA3mcJ7dPZL+yajEb5q5r1PwRNmy00RIeim3DFhf1pa7cFw/biUSnPO1UkBpVJNOegnRYzC9rCkJOoLOyVjA+4Wlc1YzY8hZZHD9yinSjdGFx58HZTjhJrmk9VyXL9TQLaOEQkR7ZpjsSLi0IRI5wUcy6dfj5VjtQnnsdFgZxe382dna5D45i9SFi0vc9jKmv7nQeTi1T/+BgX1rx93kcCus1gyjmX+LiKrvM2pL7CSeAe4dkH3oDfuBn9F9CalQLWGO8Jrt/27oKRboS55TOTiQtOcLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yfcAl7POneQ0uR3Cfw3nXjoLLHffyl4xyfJdMbwd5E=;
 b=QMdblCIjf1qILX3IqaOC3z6c+0qSILBhAH26XKvDg08hzMf0yNrXWFxUJk3TtUHR0mdxZsQoZc3WUMInRbFUUZeWNZw/bgsD8bLypDmdyMVvMO+YxKTBAy0b2Dq/V7AX9iZZOZog/NWPfW/lfciRUVJmA4ZhP4dqiJPX/qL7vIwwhqSlmbBIqMvc/oasOVA1SgmgzFAVgQK5knNwdBIjVskQonHN8FE6URFnQOEsA+3DbVgXuFd9FdgOivS7XdpEyhuLC1WtIVtpHp8+fvUgy7mUh2SHoWm0kR53seNVeJJNrmE3hlewTJYWxmo0ou80vVt9NLCoQ/og4MgNjguzog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yfcAl7POneQ0uR3Cfw3nXjoLLHffyl4xyfJdMbwd5E=;
 b=0ATASPz8M0JBzvkFOmQtKO9AX0MQQa+tw5o+4SJQI63QgDBlqm/J7ZPS2LF/J4puO5o2dsLqwLqSqSNzw3Ak9qYi4ubcqt4SJFP3fSif6RDLdFJN3VU+kSmC6c1g5/nI5mz3Sp9HOYn0MkfEQOCqD9azmog58ekYO42q3eL249g=
Received: from BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 13:17:14 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::3) by BL1P223CA0002.outlook.office365.com
 (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 13:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Mon, 9 Jan 2023 13:17:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 07:17:02 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Mon, 9 Jan 2023 07:16:52 -0600
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
        ye xingchen <ye.xingchen@zte.com.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/5] ASoC: amd: acp: Add new cpu dai's in machine driver
Date:   Mon, 9 Jan 2023 18:51:00 +0530
Message-ID: <20230109132104.1259479-2-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
References: <20230109132104.1259479-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a6d233-cd6b-458b-261c-08daf243d2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uacn6So2RnrWsJpV85kPa/vGdqXkrduT6WDEHFjcAU1lEk5Wt0hPO5l2+wDoJFEqz0bFBzBYjpuSEJ2bnVjLiYGYtzK+XqHjL22ht/rrx9l33Z0QH0W7xJiYUDsDbt4HXGuCNz/Nvrb8uT1upvUzLAfaoTrm2R5v1Vx4zmhUTfrWzQS4HyN6TTln6S2zxLvF4I9Z8k4lNNm16EOCWzBzCBmzXa2l+MlbftfgEUXxttIglQusX1ikgUNCoEHgpc37LbjliWWiLPRJS7DNZjvuIXLViDkRe6TEuQP2d4yIIStYlVGb3ncyBfFpPr2SzJBcMWzbipz3EGONRGA7SWV7iwjgqrzprGG0Xlmtlsf3XQhaA1udJPjVHZDudFGIRjoHBSn8BDXd4/mS/x1LfGWkrzyZ+vqlW6aMZexCXopu1sMYfwlmmBZ154+3agNuFOZk45MK2YrwrzW4kW94qjl88NSK/e5GfwKh62telNuldT0yRP0TJU6MEu3NWXTs9ctOhy4DFDI/+vUqh4V6O63vAnHiXeHdCsPgP9k8wuhvF0rlGMCz1HzQ7+9IP14c6sXniwsRc+zjdmVvSnjLWnyTs5mumM9S/5ookfUBCHwWfDtw9sqh2t4mqZc6XLxkBAVFg8AU9MX065kV5aPJOySS71Gn63fGGGJyj8h2ud7FCNtaaj1UGHyN442QWaW8PqHpq1DyhLyyhx6XZuDFGK03+Gf6c5/+HhMewfkhV6EkrWM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(6666004)(316002)(110136005)(186003)(81166007)(26005)(54906003)(4326008)(2616005)(336012)(70586007)(1076003)(70206006)(7696005)(8676002)(478600001)(426003)(83380400001)(41300700001)(8936002)(47076005)(356005)(2906002)(5660300002)(36860700001)(82740400003)(36756003)(86362001)(40460700003)(82310400005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 13:17:13.8285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a6d233-cd6b-458b-261c-08daf243d2be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when using same cpu dai for 2 different dai links
below error is reported.
error: can't find BE for DAI ACPHS_VIRTUAL1.OUT

To avoid this error add new cpu dai.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index a78cf29387a7..86fc5ec5ea08 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -565,8 +565,12 @@ SND_SOC_DAILINK_DEF(i2s_hs,
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
@@ -701,8 +705,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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
@@ -733,8 +737,8 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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

