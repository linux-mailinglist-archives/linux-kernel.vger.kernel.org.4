Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7264C333
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiLNEl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiLNEl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:41:26 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2100.outbound.protection.outlook.com [40.107.113.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E0220F9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzLrRRCKucTxMfjcD9KM3AgUtK1XP2YW/pIinlhsZ01HHUw3LHVF5otzIQLbFJM8DjiJshb7PcHbA5UnwVQiv9AxFuKIslEkr2f0b+wHEWA4h3z7t1TgveF4+jwxFAt87C7TyfyfCvB0NYYOWdMsiDwbIGcNW+NMpp5ShszVgltYaAM1ewFkPDbFqCd4F9J3NuR4rqqq7rBUMT5Pdqo4iUpqPDdExua5tO/5Z68jYymGE6iaaAu/2OoIzXEm44HbkWmuvRj54SGrAJFIohDwUfqEgAbqqAgoCAlKyl3THzzHWJrxb2oYZM/d5zKFEXsBNAejCMxvDmaNwuJRGna6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZpCqmyqZU/+aaZ9af4rqkBvnw9gqePMrDi/8pwQvPc=;
 b=WSiI7iGjT/FHsCMFKP52z4BDSFQWA6qW4HRUTMkpE7KQoDAWyxXFC8T8yTqgm7Dt2ZW6g4qjls3zu21Ks2OXfYIc+7HiAUG3zKpOYrz3waQ7pnqEPJvtf6j5ktYDFW6LAQGdFoNUB+EKqEvKafn/RI9GlPCHBCbLAoGKa/MBJxLoE7Kv94D5RkwX9B4OXtyCNcNhgYf/lIgMlX//Ga7+BIlKfA8crlYMMlwtOShdIOJxgM79uwXpG+yZ3+TVwcW/pgFyAuuF6VTn2x4NSjfdWnhjBnadGdLwY5sm25eYDGOAAzhzvT+0yJGgyBrdLR+OZqtZDjfTGG99gJNnagwcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZpCqmyqZU/+aaZ9af4rqkBvnw9gqePMrDi/8pwQvPc=;
 b=EvQSGXRvikZTWA78aZSnrEkvbDwydqPV4jQdUY+vp2mSYZqbWPrdc2hmh99MV68PhZD1UPuAjUOSFYLXQ/cQwt/qJ9A3HRAZgCYMkiPh5SIuUJOB45UndSQQJm2/eEJugWWTZ1lYV2TGB3tknBi5CYe8/n/SLIXuhkazvoQSc7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by OSZPR01MB9580.jpnprd01.prod.outlook.com (2603:1096:604:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:41:21 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::8059:793b:71e3:72af]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::8059:793b:71e3:72af%4]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 04:41:21 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     tiwai@suse.com, perex@perex.cz, piotr.wojtaszczyk@timesys.com
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width to 32 when possible
Date:   Wed, 14 Dec 2022 04:40:58 +0000
Message-Id: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0105.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::15) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|OSZPR01MB9580:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de98093-7674-4b46-4870-08dadd8d7307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CmxNqo7rY6FQ3TzzZm3r3rA0iYIfxY9V09hJDEt6Dutt49JasPw9VHg7t1Zyz4SnXr0XqPmAChDAnN34/D9+gxT3+AQQZRol7O3w85ErwHZkYsUidB8WzKdcgrf66QeW0XQVWiknM57bl4mNwzD91VgqRa9rTvuLzzCdirYz2/fSNNF+nYzzBKujrBupS2RhDWZD9XMC8m/TxoJpz/o+R2Fn1+9P4/kpa0mmsEF1PdvdAu9nqbm+KUpjJ6Va8oUZxbjiPRxxOcDNSWqopasLD0O30Ljo5qP7SHaZzhWsSjTlJMXefjFqOQnVNh1zzovZbK2On5XgyLCwHT7IKai/yUm81NvodcRsK4Z0VmiXXnJfpsXFEq+wDxYQY9bAiq2BXeo/QDHnnY0C2Bu+7il/ZIta0m/m6mPXnf/gbTds3z9uk387/UmONfghrRVspUJ23q36/fwnCaGEbiNkoh8kqtBBTHdggiERjW3ifdx4LaXa4WHW6i94mkH49s2A9x4AH2x8eu7Ye6fyWzphy0yRyhFwUOedOH9djd0ZD/ko4eHnZC8jxe594rTNJ8pi6zVGA+n/u1fQMk0gy59WV5T5VlIC/hzNw0BGuM0xxbwOyUvZGtE7xnnxmwfouac8AyjXYY8OQa5Le+510TbJ402sxVTFAIsq4g6CMJn8BfRJwx1/ufxd7eOhOppX82xHPv1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199015)(38350700002)(38100700002)(103116003)(316002)(6486002)(86362001)(478600001)(8936002)(2906002)(41300700001)(66556008)(5660300002)(66946007)(4326008)(8676002)(83380400001)(66476007)(6666004)(6506007)(6512007)(107886003)(186003)(1076003)(52116002)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UorDIvRi3CFOo5PcxT6tZOtKcVgHkSxW08vjrftWSZFzfWwQwSpwyv2i5VIO?=
 =?us-ascii?Q?7iXFdMjdJJ53w3pbROVDWNT7wA4UcHfiDoXVrwoMsweWJUkMZ9nVSI/1uBw+?=
 =?us-ascii?Q?az2zfp8ZQWSRQJj7rfdt9HW2uQ83LVYoqRP1VJSoCx/xFohaDcFxHww0Y2m6?=
 =?us-ascii?Q?J22T+bt0thg+jndik/Y+onD91ipPGCIM95SecWFHfe+v8ypBg4jSEWRU9M7C?=
 =?us-ascii?Q?FpU28Q8INocweSHv/1t8/4EXcGrn6iG/fRl6odvKnjXWJ3KkLRm3vxS2anSj?=
 =?us-ascii?Q?rwlBtvsf4OsPbC7rewezDG49OneIDqALpBE52uZlUsh11+L49lPTQWwUAcQs?=
 =?us-ascii?Q?vm02ztUuTOgdSMqo1B23N/3qPfWzRsGOz+QAWmLjNbyU92XGAm/9iGspOm4D?=
 =?us-ascii?Q?Xzbnw2AyCHULpHsaMwYGlXNiU2U+1FL+bnKWV0lsgijDtGNSitnapm+ADXrN?=
 =?us-ascii?Q?GnJL3IdPjGpMf2jm1j0aUvGRkEcTQDVUmgSIQbKuxwoI1PQBhmydLWhFb3Rk?=
 =?us-ascii?Q?U+uOMO5dgr5Fo8LntcB4soNo1HZC9LgLfOrGQfjtuOrEqX6Ye3SRGvbTY8iC?=
 =?us-ascii?Q?voNyS8aGH6UW+vVMSe0Es/ZXZI83o1M1OkJj2XObhBk+mh8U84bE5UKZv8Xj?=
 =?us-ascii?Q?QdAnrRJ1aBuRQXp9WbupPKSxeqoOVSNlHUfuIh0xs4x1dfCRa1jMa1wpYHts?=
 =?us-ascii?Q?tZf5JcBAxuY6tWMaTyqpdImkry6aCu1+15+J3Ta02Uad7OetfdTgUXQHLQLm?=
 =?us-ascii?Q?bh6wRe4v/AMF5HkeXj6SIYOrPW6TTa4rwuNLOBY2Dt1HcYdeZFpQPR3spCLa?=
 =?us-ascii?Q?VmxOgFQ6+e7OOi74f1/xM5kesVLbTBFsgeJM+bC2M+svlQLpsX+aq+nb+YC4?=
 =?us-ascii?Q?3nSH92SbN/OrUKdVLqKXUlQotE1azIN81TGD9RwS9t9naWYxsjF08HMOL985?=
 =?us-ascii?Q?eWCSQoRBRaP26yyNBw+4nCCtRa77XEjY3fWAOIzs2cGZlp3C0cerSV0JtHgo?=
 =?us-ascii?Q?q/eAcSYfwAXzPIj3+PUHBI3xJpIC+5wTsWG2BPd+p3HI6lsdkvXG6PnF4uzz?=
 =?us-ascii?Q?gJaFznWv+oDp0FSRxJQzsqdrE5BiiezC6fYJxDw2Fj4al11lMAfiyL+oGgxM?=
 =?us-ascii?Q?FYOZHAme2Uo9kEXZtehgJUb0gRzJu+PytosNVcUhvBoA6ytBKit5ON2uja4Z?=
 =?us-ascii?Q?XB067yjuLQsFASZJ9SLWPY5/ofNvsiPuqEhO+atMkJcEzqiNkZG2mpJYggOH?=
 =?us-ascii?Q?HRG3OiwYKKoVrMfc9a9dDL9VKcaC11wR6UkXPuiuqQpJssDkWXvMw+mD46uP?=
 =?us-ascii?Q?14cOG1NaB/ILr3ejmJ5rYIqDo5DCCt4BXoGn3x/sGSwJSNVyclKU+o9n3BgT?=
 =?us-ascii?Q?6GqLoE0J496rYIVNm9VZq942Vet/Tcnq9U2jX+tThJ8fvyGdsrpe36IckyT4?=
 =?us-ascii?Q?a7eIzpCtP4rTBfPnxjxXJ2sQ/oeXo30uePzaNVVGEzNYSRnFLW+WsuWAnR1y?=
 =?us-ascii?Q?HEuLHiSFH4mNlsh7KA1WVD46uke6GVTK9eJAtrGUKwryX/S2k6sXhZ8/LhhP?=
 =?us-ascii?Q?xHW07sHersn1FMh/rHTQvo+qm/t4toPofXjRisVvSPkNjpFFQkafOfqQj+Xq?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de98093-7674-4b46-4870-08dadd8d7307
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 04:41:21.8530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iysf46asTTKvJW08XnS7CbrPCuXzOOwSbh0zG1Pg7JwfedtkTzUGf4ld2X9VAN7x8zyJByzKyzx7TzxLYB84QIskAOCq1PS6inoGBD9vNXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9580
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the DAI mono mode support and set the frame width to 32

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Tested-by: David Rau <David.Rau.opensource@dm.renesas.com>
Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7213.c | 30 ++++++++++++++++++++++++++++--
 sound/soc/codecs/da7213.h |  3 +++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 544ccbcfc884..0068780fe0a7 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1157,13 +1157,31 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	u8 dai_clk_mode = DA7213_DAI_BCLKS_PER_WCLK_64;
 	u8 dai_ctrl = 0;
 	u8 fs;
 
+	/* Set channels */
+	switch (params_channels(params)) {
+	case 1:
+		if (da7213->fmt != DA7213_DAI_FORMAT_DSP) {
+			dev_err(component->dev, "Mono supported only in DSP mode\n");
+			return -EINVAL;
+		}
+		dai_ctrl |= DA7213_DAI_MONO_MODE_EN;
+		break;
+	case 2:
+		dai_ctrl &= ~(DA7213_DAI_MONO_MODE_EN);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* Set DAI format */
 	switch (params_width(params)) {
 	case 16:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S16_LE;
+		dai_clk_mode = DA7213_DAI_BCLKS_PER_WCLK_32; /* 32bit for 1ch and 2ch */
 		break;
 	case 20:
 		dai_ctrl |= DA7213_DAI_WORD_LENGTH_S20_LE;
@@ -1224,8 +1242,11 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_component_update_bits(component, DA7213_DAI_CTRL, DA7213_DAI_WORD_LENGTH_MASK,
-			    dai_ctrl);
+	snd_soc_component_update_bits(component, DA7213_DAI_CLK_MODE,
+		DA7213_DAI_BCLKS_PER_WCLK_MASK, dai_clk_mode);
+
+	snd_soc_component_update_bits(component, DA7213_DAI_CTRL,
+		DA7213_DAI_WORD_LENGTH_MASK | DA7213_DAI_MONO_MODE_MASK, dai_ctrl);
 	snd_soc_component_write(component, DA7213_SR, fs);
 
 	return 0;
@@ -1300,19 +1321,24 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		dai_ctrl |= DA7213_DAI_FORMAT_I2S_MODE;
+		da7213->fmt = DA7213_DAI_FORMAT_I2S_MODE;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		dai_ctrl |= DA7213_DAI_FORMAT_LEFT_J;
+		da7213->fmt = DA7213_DAI_FORMAT_LEFT_J;
 		break;
 	case SND_SOC_DAIFMT_RIGHT_J:
 		dai_ctrl |= DA7213_DAI_FORMAT_RIGHT_J;
+		da7213->fmt = DA7213_DAI_FORMAT_RIGHT_J;
 		break;
 	case SND_SOC_DAI_FORMAT_DSP_A: /* L data MSB after FRM LRC */
 		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
 		dai_offset = 1;
+		da7213->fmt = DA7213_DAI_FORMAT_DSP;
 		break;
 	case SND_SOC_DAI_FORMAT_DSP_B: /* L data MSB during FRM LRC */
 		dai_ctrl |= DA7213_DAI_FORMAT_DSP;
+		da7213->fmt = DA7213_DAI_FORMAT_DSP;
 		break;
 	default:
 		return -EINVAL;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 97ccf0ddd2be..4ca9cfdea06d 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -195,6 +195,8 @@
 #define DA7213_DAI_WORD_LENGTH_S24_LE				(0x2 << 2)
 #define DA7213_DAI_WORD_LENGTH_S32_LE				(0x3 << 2)
 #define DA7213_DAI_WORD_LENGTH_MASK				(0x3 << 2)
+#define DA7213_DAI_MONO_MODE_EN					(0x1 << 4)
+#define DA7213_DAI_MONO_MODE_MASK				(0x1 << 4)
 #define DA7213_DAI_EN_SHIFT					7
 
 /* DA7213_DIG_ROUTING_DAI = 0x21 */
@@ -542,6 +544,7 @@ struct da7213_priv {
 	bool alc_en;
 	bool fixed_clk_auto_pll;
 	struct da7213_platform_data *pdata;
+	int fmt;
 };
 
 #endif /* _DA7213_H */
-- 
2.17.1

