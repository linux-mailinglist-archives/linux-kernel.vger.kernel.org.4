Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFD65CBEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjADCkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjADCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:40:35 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30225D0;
        Tue,  3 Jan 2023 18:40:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWrQ1v8i3t/NN2rzP+vRPtodLcUkVkvY9CMQ8MLAuZRMdy3wO7d6teY2zIeDGhd5CdeJ9uZTc/ZT3TlzfsIGQW/TNUE4jzoeUlq1e5VmBQllG2jou4JlmSW42Vzkr1kpPJPm13scQv/K4/0+trppL6If6m/r1oW7h3WJcak2DjpOP+ED3z5fhNDurwavZRfjCJztrU1n+U58UboGn5a3H7BQy5W34D5vM/BsHQqR+/BNgZ42T2VMKsJ1kMD/5g0RfwTXR019wAUVObgs57Ye092IbocqUbwnX14mOdhBYe7PPWd/AkJfTDE1rH1s3yVFkdUTKbM2BIPIGKVy3xe/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfqqfKq+p5L47STbaiUShceGluBUv/TPjceQ6WfftIM=;
 b=EBxI14q1YL4DazbFnFhDO7iWb0nQ8ZYWaF5NutNqBQXIj3eOWcitSJaiumCZIH1lWn+Xtl2X0q2Ueh6W6SGxA+oMIBLDVKR0sU7QX0ly/EYUSrokI+F9saTjmwZrGD5m4KZVJJEuhAkFumkS6n2nfbfJMSElvou1s0Fx16xyf/vB19nkp9wfGgpbd4w7hppVfqHZOed64jqnMMRwikTpLVxdc/zJsQkDsX49YTvBgW3OmEsGGSwPvugQCn7umfSbIPPfdcFN4KQTWNJRtEjzHOgu8R3cmFqOlS3+eTjlnVLVdEff+gDWF6JB1nIUOtZIW1e2tNt/WN5YzBhj/HoxGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfqqfKq+p5L47STbaiUShceGluBUv/TPjceQ6WfftIM=;
 b=lhoeWhxVfwBtJ9Ij2fWglthZe69BPN1bALFBfKoPHlfxtAGe9vzrCrY0GvPnpvRl3Q2YNyS7FPiFa8dqXDfHtmy7JzeK225wFXTOReFs/FIAPZxCzG/E2TAhBtgccV1JvpSIWBYbKwILEaoILyGwhll8lbwsEO6drdnsViWV2Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:40:31 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5944.018; Wed, 4 Jan 2023
 02:40:31 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, tiwai@suse.com, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [RESEND v2 3/3] ASoC: fsl_xcvr: Add constraints of period size while using eDMA
Date:   Wed,  4 Jan 2023 10:39:53 +0800
Message-Id: <20230104023953.2973362-4-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104023953.2973362-1-chancel.liu@nxp.com>
References: <20230104023953.2973362-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: deb709da-4e7e-457d-f6e6-08daedfd0c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2y5t+7/Zfok6umTtS7E7NBqtige4x8338vyycTDikSGMTyDd3vBYuvQAwg20XgFA83dVjrJKvKfJaa9gajxqqIq4dWRNgf7WsCGY+a9cciMAECiz2k+yJox+ZNO5D5fO/BtcfernsO7EDcbnpRfhU702E1L1yytmKLqMZ3b6CC5/xL/F0y8NxC4PRpbUG5aRUK9fgQKECd+NRrsYxez6OLvekBQch7ldnQ7a7afIw28PjJ4hTdIMVDaSUNclgMv2Bn5NpOXTiQzaVZS7EJ7kxOGw75j9INgYiuU8eQLlZ+Z4FbhQCFFS4MbmiBqX6QQ2Wctz2k2acRSnhMvyn4xX77LUy/2m7StwnMFTyHFdPschEfHItXgpmc1zvyCUab0l1ACilT35pGTCGtH2fpwCuaCgdbQJDedewhwAP7lMUf7Y1DbjcHgJOzQHT27YF9JC3EIUwUTvAXX8VjbK8rIs3ssEugyNazQhMvRoxRbtHajLjG+dyhZaAQW44SG2voqjtG8lYIQk5BIiINeiGt9QTO0ynj9uRPBnrYvSdYercNCCC6W9ELGIdavj+OSeibNTkxFiqwV14k8RZKytWrZUvNqD5y7n8QpYXjv897UmQ8jvY6zdJezu2yZOS29xwKjXrpFoehkbbEq9B7+ENkuN+tUwusxG3W/CZ+zR6RoiOedTZA9qi+zHNv6JfoWDxmm6EefPA/zfFsJhbC34MOf89A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(8936002)(7416002)(41300700001)(8676002)(4326008)(66476007)(5660300002)(66946007)(66556008)(44832011)(316002)(2906002)(6506007)(52116002)(6512007)(6486002)(26005)(186003)(478600001)(6666004)(86362001)(1076003)(2616005)(921005)(38350700002)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZEg6KyT26XnxtLUr5ruWoIxFCwr42QOYmsuE0WV8Y1SnyWljZPpjz3GvoNif?=
 =?us-ascii?Q?qfTyoRaWhta2cGQG20JmEdpNAD9PP1b2gjv6ZFU9SvzQDJ7szU16cwtN2FpZ?=
 =?us-ascii?Q?NXBeX2YhpCqiOTxyQupr1nuzajgM0DbeI3kqcpBwvb05HRI/w8gATHbGjU/8?=
 =?us-ascii?Q?5cknXeSVnAnnzw4F4yGNskF4qSfTVKfF/tFgEtmPSL/9ZWfpp0uqq5B9nEhJ?=
 =?us-ascii?Q?KqSc4ZyHIkuGaQtbr2o/RiBHI8pf/B441GercUypeQt94B8mHadj+gSNy62S?=
 =?us-ascii?Q?1WE8TVYDOMqUR6k1dBQx6yw0H9S9tKedEqpEUUxcJXdU7Jr75e1mW8zQ06fn?=
 =?us-ascii?Q?eoZb17sgXTUmVKQLUVYy2UIJ3334RiImp9XlIGUJYtb5jvroYKnQsLt0hCar?=
 =?us-ascii?Q?vEQ9IhTNe6OmXh0W6lA1t+P2y2Ghd3sgSNEXs1Mnx8mCquz2ROPevBkUniKb?=
 =?us-ascii?Q?Vxk0p6lSyPCHAtsJ8lAyWz/2v7XmSs+uDE3gmakqZtht/HnWDhUalvLRUeVk?=
 =?us-ascii?Q?Ip+nLvcgG6c9lqFInMxPXcnh/p/JsRcEihX9VL548sK8LZM8uWrj4sDJdNpP?=
 =?us-ascii?Q?0xWy+wPVDFURaKPvI5mmvodha14Cz+3+1M3qiATTaGWjM024OlaY6iVFQfil?=
 =?us-ascii?Q?nZRcec5oO62mmIZ31EI2+ZjwD6218oCWkbkXUnAzBju5245vFEtr/4v2tYDs?=
 =?us-ascii?Q?J5EwacyfngEogve4kLgT3+KAPPo33P34tORBoK187tPciXsmfvZtxC9C+CSH?=
 =?us-ascii?Q?efdOBi0QJfDJels7ZQATf62+xAwM1QQ7MLJF4Klv1z5d9ed6MnVS/mvYDKsM?=
 =?us-ascii?Q?D7BRC4nD6MjX29E9jjdN9OsmgzAivEXiZiwX/rxMSTxY+nFlSaX93b+QzVQt?=
 =?us-ascii?Q?SrunAHaPTe2SJeNneu8H4pU5OaApNlHej4rjgeaz6lSpQLs5Ir6x9psg1GW+?=
 =?us-ascii?Q?teRlDmKmLBvtL0dnmfaa3hdfYZ7gt8lh6VSZXdDc3hB0GrML9YA6DQ+1vrS2?=
 =?us-ascii?Q?ejwiWMZfKXfepJDpexkIT983eplnC4mbonSPWsOhDZY+a8PfNIgRKcY8O2bR?=
 =?us-ascii?Q?z5euiw7I7eLnTBKbhkWo9yWI2cmkoGI4twHMloFFa9qCLjqGhI7q8W30KV/Z?=
 =?us-ascii?Q?I5wWjSMdzr+7l0CQ5wHqjAf4mmxl0pQOUR0IG5QBz9FLMu6bhiaF/HqlvqcF?=
 =?us-ascii?Q?VtIAK1K5fh+JnZDpZhTGZQB3dXYyMhH7ICrtDjenWZ3zcX8E97bUsJcUWEhu?=
 =?us-ascii?Q?YTM41CFsJaFDMySho4R0JlaNGyizRJ6zidg/1/ILcB5uKJB32ls/WXyILV+8?=
 =?us-ascii?Q?LdVCD99kdt6e51C6Z6nyGruDM1YqFTSZIgC0pW2JP8nuGA0kwPD7L+W6jjI1?=
 =?us-ascii?Q?IKOBz9bTDZqFJk5XqD/ydw66/75hr/6r379JIp5NlswLGIQl67D8Z2pC2Hdz?=
 =?us-ascii?Q?aYh2fTff+PrZMBwbOhzZP3B9egVPHrYdoCEbofE+yF13EsKNIrXOQheP64pY?=
 =?us-ascii?Q?aXqV3SPdIWP+/poO6e+ab6p7jCVIRILre2H+I2w1kHOb49PKKv9eUC3o9/RK?=
 =?us-ascii?Q?TGL3IZmksnuianIjTYy+bXGtzkt6exUT0lx/fu7e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb709da-4e7e-457d-f6e6-08daedfd0c1c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:40:31.6298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m3vuzFTrsF5hhBP9WhWG4dgbzUxj2jlJ0P/d9mFvHjoTNA3eBOU22diDLhhyrHQ3TtfoVYp5gHJCHqM5ex/Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491
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
index b794158a7876..2a78243df752 100644
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

