Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC3653C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiLVHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiLVHiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:38:06 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4210323EB9;
        Wed, 21 Dec 2022 23:38:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFhYMSk22jKqRO0uqn5xQO9SuciKMZzV2DSW2dI7Xb+WiM9TmY5ALZw68JQrDzB8UFnxQ8fsmYTzPT5NgGmpUa/F1IKfdwLzUrkgoEEb46JkkUj5ZMtLMkL9pslOK3IofXvxLRcnKbFa6w/rcGak5zYpytSHhImQsM2Wgllj1ld8oCaXbhmSLY/JVQ1q4ZHJjiD5xXTDJkUtWRJuMeVY/17a28cxkiEDtcYtNGxraJrrhb2DnJd4GGT6ZrrszseNzioC+NT4CZODlYsIzKsQ2+aCHwSzgnvie6JppBugNN51rCWxg4EWElx6NUh6crzFsT4bP9/UvwddOJs5ijOeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hegXW4IkTRNCp/QL2Fb493fkmLJRkeLVs83hlQZq6Ts=;
 b=bl30NHTxP06i66mMGjxBNzRP8bhGlHR7RwErOMoy/T6MEZrI7m1QFYlshUxsB8yR+3Wb46L6ReOUL15a22yWsqyb1wSOCBuhw1XLOfwRZRVhHDTXb4XRjNOQkpmJvfNKq3cM1rO7P85ODUiB5APKCC1O1qJ0PdgrG4Wis9SswCq+VsnoYweSpVqbz+ycYXVNyNw6Mdwa4OwaFGVnJk755oNTfqAhi0J2HN6v58aK8Qslq3iE3h2I8SIDNKLIYZQe21OhgHaGK4fnUemOwE229o7Lq2o0ynPmleyjJrrQaGcdzehLRMCuMPK7zH6ZI/t2USzYoxumVGqSRS3g/cJ+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hegXW4IkTRNCp/QL2Fb493fkmLJRkeLVs83hlQZq6Ts=;
 b=RAQDSDDxOcfDRKGXoixEMpoH09r/0sXfHQDbHiM+1DOkZGElhzXFt1yZRNw+llsDgw8QJNo4vWdjxrPNaZRIP4erGwLfvCbTAkg5YfHNrTzGcjFhILbpi15+s85u0k7APNwnr3P6tPevtBzHPTZSF32ujY4QpF5+pfv5iRsnIv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 07:38:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 07:38:04 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 3/3] ASoC: fsl_xcvr: Add constraints of period size while using eDMA
Date:   Thu, 22 Dec 2022 15:36:18 +0800
Message-Id: <20221222073618.1064415-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222073618.1064415-1-chancel.liu@nxp.com>
References: <20221222073618.1064415-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dddba45-6f4d-4a02-a9a7-08dae3ef75d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtIcRh9jAShnfrGotjDG1GvYwIkjkxg4gGvUa+hz2rdB8NQ6B9rREtHj8PJRd8DzPRzjaa2IqU2skf4t1AO3E2gGsnOP3l5uNJSB+FpuFAjr3WHbo+KB52jqr07UzH4hrlXSkS6KZnNSi58MwGdO6g8wpAOBAdVlB0C+LP6/Ym2SHPR6zvqSccmwrQ19G8qwXPevC6r0ycqbzSLc1MeZe/7EU/Ng9F6F7RbW3LF/PV/VdYFxD+HlnpFsQ6QZCZtTSD+zwe+zCha4wcpHiawErMq9Me5+WNOH8uh4+ap+cMfaLgPHXXQZ5GyaKe7Ie/s3xag9rBIW0svl+sc1oJfptrT8VlJQ8fydamyp5GAeBgxDlaAJgDTOqOOgFLipCkthAIox34BH7n4iiyMsvupnQIaxsKY0JIsinugRZ/7pHYgt2UD/nqZtmJQz5aWkYBgmiLiAlRVKm0bs/2S6lghwDDqNck9HITBjxJgDZ0Ta4gKbzyJk4wtIMCA8GMRrTcxWcR1JDs6/tZ49ik2j5zmDQGan6EaOFhVluath8c0JWB2kuRG1/tfM/EO8oX50xL/so32+p2hQe6LFeVp1asqXXxmGpQ6WC+fLTlWG7vFzlJvqGiL8YiKj9B/S4K12KPlj1TpfIqBwxX3xXdjd8d6SkE0fTiOJOzPjJjwCeXXJxDBNFhcYbcGde4brigUSpZSnUcYrZxtcjIVlvzGqb4CmzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(41300700001)(2906002)(8936002)(4326008)(66476007)(66946007)(66556008)(44832011)(7416002)(86362001)(8676002)(316002)(5660300002)(921005)(6506007)(186003)(6512007)(26005)(38100700002)(38350700002)(52116002)(6666004)(36756003)(2616005)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GUhl0JqA6d2FRIiGdgaS3631MzzIoSAYV8bR2fwKkszq+byEFoPY/+Ie+bbC?=
 =?us-ascii?Q?I98Wj/AZX6js8DCqHU+Bf1+gUONqN94jrCtMcnZQTgrSYwdKx5n2hBnUipvR?=
 =?us-ascii?Q?lTBPsEV4o5MzHjmyZLqOcTv/pAr5mqeBopaZaUprXuBZa4ZEKcXS/IkTO5vZ?=
 =?us-ascii?Q?uKvIKLAEsM/70C43+RcHFmqrQI3SQ4md/GITGORcQ2v7+7jIblQKD/4Qc1MH?=
 =?us-ascii?Q?RcyQ1qrUiN0CG35Qaw5FPMP80Xt4pIH+wUvXX9KaDuXHQz5gMK0oYBUcQJCT?=
 =?us-ascii?Q?CSt6PwDLUSt+fsb61shNgLqQ5sns9gVeec8ka4iAAbLqUVxOg4g5OD/EYV66?=
 =?us-ascii?Q?zrJr9YGe9W49kjwGHuOb6pm2jiszR62OqLJD9fG3GpyyVi2sQh4q4Bamln5T?=
 =?us-ascii?Q?7u9G7gQOhGFT2QOfBOUw+igTY+QtPpbRkyrXEenUK7Jl5yHbl8G7Q9Dr8hjy?=
 =?us-ascii?Q?O1DGsLrMIoNyYLWeskyZJZrwyD3ZmuSltPswHeV+nZMd4ITwwuT87rGV47N1?=
 =?us-ascii?Q?yf1ow/nSfHvcoGEbXUEol9kmUPFbhyXARxZNkl0SBr1EdqTnbvikGrzn33BQ?=
 =?us-ascii?Q?lbKcLtmiq0xDbMe8FJJswFCNhsata6pbEvujb24yNPG7+aTMnYXHLtxouoLh?=
 =?us-ascii?Q?lNdbq5uj3NVhANktdf5jYsMqGCzQNOCrF5zzC+QH8c+QDQOCbi9ff+KZqNSm?=
 =?us-ascii?Q?zQsintRj12gD5F1gHER92m9z1Zt1ww2EhJyY9L5nEi4xF08RCOK7+aufeFuW?=
 =?us-ascii?Q?PadZ/UETVeJa/WdSF7SWe/F2gvT3ETwfYW1j3sNg3HKXNg9XJGozGa5oCh3X?=
 =?us-ascii?Q?2KKA6bHVEnnuCbYN/a/n4Mp0b1rHGcrJHAULGWRb1p2WSpZ5c5CVqAU5Z3r3?=
 =?us-ascii?Q?Za0VgBVND5zLEPPDb0Um7ukEJVXl008fV0d3Pm9sf0g4r6X7uB5T/sjjmVI4?=
 =?us-ascii?Q?ek6q0a0p3MR00Sc3IzdbOy4VnDiPmhnuL9sW8qTBfo3CjRVpvIs8Q6dT7wN+?=
 =?us-ascii?Q?X/fH7sxqFXgrlUH5/8dxrW4bz/7X9memSO8Ug2Gu2Epu2VM+Yx/kApBkcEJP?=
 =?us-ascii?Q?8XMv/DoPv/CwCokawbfmcTeP8ELa9obCRmIGbxwX9p0EYLTfIEdX7jtS9koY?=
 =?us-ascii?Q?t2FKPUkLZbJ95+lDmODBB4foMzD8liplsEB+MATRU/exlUfz50GkNZZ0N6vv?=
 =?us-ascii?Q?TxiiZ0fvqX97RcBG2m78BaVxyTWzUg9zu/lu4s5IeL84PYtoK+cjfYQJvCiL?=
 =?us-ascii?Q?OK4/NoSC/eg48IUwrzYV7qLXjsirqUDv0SYn5D4Qq/lS8J4CIbAWAeLzMc5k?=
 =?us-ascii?Q?mhIQ9i8QB4AxI0Nb7qTHHtdS8z0LcUT7/dSoXizs11LUpM3QaXAFFeLMJ+Jn?=
 =?us-ascii?Q?9alaBYOOzXfPRE8epSL1h9WGId9WzO8FZYfBayO+KkOIaWj35kI0nm94XElh?=
 =?us-ascii?Q?WqEo7eBGL+9LFP8f3q3xfbwOrMlzj4CrTaIvTx68RzO2C1++BaH9opQPVI/W?=
 =?us-ascii?Q?NEboddiCdshzGntmJQgAmjvZUtkVu1JiMhAu+Q1+X6xTQ9vbESkkreyCaqge?=
 =?us-ascii?Q?dDWOwv+1q6c6y3Ad4SPC+ZK85EFQCfPaWZo219eh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dddba45-6f4d-4a02-a9a7-08dae3ef75d8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 07:38:04.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPCPrFZw4HP76xFMDrE2NAHU/MMtmvN3lejUQtKErgLS6u8jbhnYZLc5HRru1Y9FcUfP2kUnvfpJoOC9WV2luw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDMA on i.MX93 platform requires the period size to be multiple of
maxburst.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index c87ae864df77..bb03c04bae9c 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -22,6 +22,7 @@
 struct fsl_xcvr_soc_data {
 	const char *fw_name;
 	bool spdif_only;
+	bool use_edma;
 };
 
 struct fsl_xcvr {
@@ -538,6 +539,16 @@ static int fsl_xcvr_startup(struct snd_pcm_substream *substream,
 		return -EBUSY;
 	}
 
+	/*
+	 * EDMA controller needs period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (xcvr->soc_data->use_edma)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? xcvr->dma_prms_tx.maxburst :
+					   xcvr->dma_prms_rx.maxburst);
+
 	switch (xcvr->mode) {
 	case FSL_XCVR_MODE_SPDIF:
 	case FSL_XCVR_MODE_ARC:
@@ -1207,6 +1218,7 @@ static const struct fsl_xcvr_soc_data fsl_xcvr_imx8mp_data = {
 
 static const struct fsl_xcvr_soc_data fsl_xcvr_imx93_data = {
 	.spdif_only = true,
+	.use_edma = true,
 };
 
 static const struct of_device_id fsl_xcvr_dt_ids[] = {
-- 
2.25.1

