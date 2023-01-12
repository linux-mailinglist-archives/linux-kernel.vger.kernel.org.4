Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0707F666B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjALHBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjALHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:01:43 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D22E4BD71
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 23:01:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsACSdImt/WxwQ10SXp1CnxzAujrmxqmCudSyGfzevgDY9oktKWJz0V8nkL0TSG+OhZROg4I6nbmVDe1DVDaYijbKdEj0Y3zYcNAA21lFjUqIGAxCUcTTh+8vo355n/QIKmyJsPKL7XBCTmJWYM71O6MXhn37jSRFasnnZhgqX72tJu+SYcUI8rp/309p6ZOY9Q1WJ/TvkC3I3OAqvujGaEdhFGN3O7WoHIcVUjQAGrSX4LJCnhBWfleaLFfl6tXkSQ+tIZQo78FafwC33/8cskGNI5dgXAVNs/A7+y+MsT03ii8giM4fhpx2I4VTm1rjJjd5CWdXli+sFIoHnQmOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOAtMYRuRL8In3aNN24NDfEsnl+Nf5FDIVmgF64/MqQ=;
 b=VzsvpKYSnzhw9OgfLlJbW0S/Uy5XJpOp3PVjbpNPMIJ0HhJcepUGKCYyQycMsmW+QwwDJsvepg9DOdIA3s4wPglnUR+xW831Iu7VKh/KPg/H7nkPsCcDrV6C+r5Qs9RSPSC19dIJUSXn27LbF4X5kLEAsS0wdcaOP2xdjd4P+1z8wt7rGIskFB2WaUXXqDmMg0/tGViv/1L27Eh4J8PHKvBdeEbZGcWaeXB/3Qs5q3cHztgSTZaZxS16eAAkw1zl1XAIaE/NYJ57kBbTbdSLNlr2LoUlfCP364xzLSmFi1cJtzJoStGJ/fxO5BPb1Wu6iKlSkcX6dJiPQxoP3iJf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOAtMYRuRL8In3aNN24NDfEsnl+Nf5FDIVmgF64/MqQ=;
 b=hZkQ90K68d1IwdgH4xvZefh653sNE8aQaZ0ue51I50eT7w5lEUFXTouWNqEa5M93pVxPH6cnURM74TSwmQEQvI1oXbYA7e0EB6eRc1XlByNn653Tu4wKdYGEDq7mHCRIISzvR9MP0VZtaEUSxigkrjB7DFuGNCsJXBcC2kA72SY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (2603:10a6:208:5b::30)
 by DB8PR04MB6826.eurprd04.prod.outlook.com (2603:10a6:10:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 07:01:38 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::c1e7:eafb:408c:6ae5%4]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 07:01:37 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: soc-pcm.c: Introduce a count to record the times of setting DAIs parameters
Date:   Thu, 12 Jan 2023 14:58:34 +0800
Message-Id: <20230112065834.580192-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:5b::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB4211:EE_|DB8PR04MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bade384-558e-4e5a-1422-08daf46ad962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5VcSa3LUIC9t6JIP3a6gOzjVlxJlQtbGWkXXG1JIQn4oc4Gislw38GzRAGmndLXiQsVkM+Ie0ZXJWNNrLdTVjh8md3lK0SynQlSPB1h/cavceAdlMDHMOJCOyssTuU5eVn/6x4Dq9nYzSrw0P3I+NCdq6qS17WzAIaDpMnXqExwGx1FcxLUb6bKdUUWPvXf7MMHXpfuYqrL7NQzLhacZ+h1f2CYkCr8tUxc1X+xmWokfk3JfBqf53NbAcwuCV/bTnkMRSBQ9QYRwRrz/rHGG+eKh+pAp1fvODCdlfzS2iD5/23UAycF6ua9jTMQX/BW2120DQ/9tsMYyitLLJZuGWsa5FLwlKLTOlAp2rL5IDEUK8iXVMlOyRfRll3YjbZkvibOX3QuVcK6ddqea3NgQW1ed/547XjrJZKshrlkxTnzlhr30w1oheMXrDkEiE8yAJ+BcXEIB9gn5UOFoSkFsf82ktJMvmPKRcbHoqlOYlXmmxWObhCB0mt59fHeRglTgfngOa6lqtQ05pydgqohIyCYzPzhgyp+UiJ2XHBxQDkM7mvG/NvhElktHny7uS44PaNGVnekWx1OSZZm30I/rkI6zCS5VhXXdSywafMyVazDLWnFntF3VTZhifPqlhPLjWjftDhdCRVKKpxbQe5cPHvqRS94kox37k5R5ZlGlsSd7mEEsDxDHwe1Mlt1VUQ/42Hrasg8V4kXv4A2B0xCyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4211.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199015)(36756003)(2906002)(8676002)(66946007)(66476007)(8936002)(5660300002)(86362001)(44832011)(66556008)(83380400001)(38100700002)(38350700002)(4326008)(478600001)(6486002)(316002)(52116002)(41300700001)(2616005)(1076003)(186003)(6512007)(6666004)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ivnkcVLTrG4Wwqu500jD4SvUidKOC5NI4PpCmApLbGTDPt4316gAkmtq+JV?=
 =?us-ascii?Q?1CYGqFlg4dqtOo30sOtiOF0WcWkfrV2s78U1OMFSdpB90bLWK5R2lHGuL2ux?=
 =?us-ascii?Q?E7AFKy1Qebf597ztB1Fk2zMybD6Ty4nFvu0Al5JxPLlKClKRfoik/45ewdVk?=
 =?us-ascii?Q?7YIEX3oU5sLyrCUGjdkdFY+7t1DJdA7wuGv78ldxDZAZiS2/dYayui1YL+Z5?=
 =?us-ascii?Q?2KO1pVEjJo/tEzXAwfQlD8oicuAV3ynQ9zu2X3y1ZCHg2tW3hBEFowF5cCBB?=
 =?us-ascii?Q?gHisp6lVHTUTjRpnGHmfxs8qu6Vy+DwpwumR+lXLBz0TWJuITDaY4+KPfrWt?=
 =?us-ascii?Q?0At4itusPAhLlqd7Z90yb7KbSCo5QjAF01024FrBNkM18FpP9XTTbRo2CiHw?=
 =?us-ascii?Q?IUYRjndkLyR8tdOz7fTdlAO4XdifDy77A6d+oVkQC4Xu+c2T0FxFTkObfypp?=
 =?us-ascii?Q?rBHoVFNN9mqFGCQgELl2yEFzfoMKqp3zHK/V0SicxySq4ggJAiql6EnzvFnK?=
 =?us-ascii?Q?WsuwxvstLUqCA6wHd1QTyvQ1LlxghnQDgd59A7p5MPlJ3rpsNp8NxpJPgyxw?=
 =?us-ascii?Q?Ng6vOPk1D90HO5ABcsk6slU+pZSJW4NAQYSHW2eKJF7N5nRdpGg1eTG6JKjc?=
 =?us-ascii?Q?2B8xX+PcCICgpY/0lEZKJZPjOjf2RGwHUCUmYUa11TZVyH8eDBMnK70uPj8Z?=
 =?us-ascii?Q?40p1JwtAPe1M7L5w6aZ83GDQsIR/eNyGrdRVnXtTUtey8oaP7Ie68aw+v1bU?=
 =?us-ascii?Q?pEteclbZ1KY1YFV+UtX1DB7D7Eo5J25vlzy6NQqmMrxyXTWGZgSGu4wnyK0l?=
 =?us-ascii?Q?QEUwk+mD22FtOonW9YVSMhu5nWdjIdMqLeU0ejNmRcZ3El8yjyeU3apTqM6N?=
 =?us-ascii?Q?IELtRi/RV1i+lHHr3xhnE1ZqDbEwptSPP22pHqZL33eBlao1px4WhPwqo1GM?=
 =?us-ascii?Q?f5OZxQlcaGNpKVG6nCj6lDMy2fDkdVmzz9FwkTOKG2GJocCg07CTLgNPLNrR?=
 =?us-ascii?Q?AI35t7g+HNY3Y1hhzzn/eNnRp3KMblqalFhZHRzdI1x36/joUJBtvhKO3kGa?=
 =?us-ascii?Q?HCswTlN4h7TtGZPM6bAQ+gCBdZw5QqNo/bkO3zoHpULYiEXPIQfhexuAM8Iw?=
 =?us-ascii?Q?YjIauTc47aWGPJGK3YYx4SCgJcgW7Hb31JLpO+f1VWULnC5HEQlN5vvneyVl?=
 =?us-ascii?Q?84/Vptzmp9h3iTqBE2eJemBnSubsguYcf3fTQl5ZH2vw3M4YBNC3dR8ZqkTy?=
 =?us-ascii?Q?A+J/CvrE3n8mH6sIKi5LiTPHmtUz0DnXFQXohA1m0PaGaJ3GbaF0UZ/OTIii?=
 =?us-ascii?Q?qOv4Ski6mZ1pfFWrKGErgWgL/k9g8VmWiB+3+fYYBSTZ6Ap/uIRIJ6hEVp7f?=
 =?us-ascii?Q?F+8XK5/iWRuNWo0d4UZPtspnNdblXANiWI/nMzrmVg/CQNUYJBwrQRLR2iFb?=
 =?us-ascii?Q?fx/zmvg/ROs5q2jNEcniZ8ULAnreI4ssBkaJpPQ2cSs90Jq8Lw0xJSZW7v3k?=
 =?us-ascii?Q?NRx5yqHg1SUDDFDF5CYHtUtellNQWQ1flbfwPZG36bfpyTO40fX9Z/6PSIG7?=
 =?us-ascii?Q?rIXfwaxtHspuweC18UTzMRI6wLgSzp/WTMjzn1tK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bade384-558e-4e5a-1422-08daf46ad962
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4211.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 07:01:37.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DoeXtKbYBJl7cuX2M31Osa8EPxbelzIHSa9u0YbS5qnRkfvHtowf0SOP8pWumUOiI6RmHdVbmEjVA8LeKWzSAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6826
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after
stream_active is updated") tries to make sure DAIs parameters can be
cleared properly through moving the cleanup to the place where
stream_active is updated. However, it will cause the cleanup only
happening in soc_pcm_close().

Suppose a case: aplay -Dhw:0 44100.wav 48000.wav. The case calls
soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()->
soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. The
parameters would be remained in the system even if the playback of
44100.wav is finished.

The case requires us clearing parameters in phase of soc_pcm_hw_free().
We shouldn't use stream_active to decide if we must do the cleanup
since it is finally updated in soc_pcm_close().

This patch introduces a usage count called hw_params_count in
snd_soc_dai structure. It records the times of setting parameters to
this DAI then decreases each time soc_pcm_hw_free() is called. If the
count decreases to 0, it means this DAI is not used now and we should
clear the parameters.

Fixes: 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated")

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 include/sound/soc-dai.h |  3 +++
 sound/soc/soc-pcm.c     | 16 +++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index ea7509672086..a7e589a0fe72 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -451,6 +451,9 @@ struct snd_soc_dai {
 	unsigned int channels;
 	unsigned int sample_bits;
 
+	/* Count of setting DAI parameters */
+	unsigned int hw_params_count;
+
 	/* parent platform/codec */
 	struct snd_soc_component *component;
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 579a44d81d9a..2c2a5dcf9e06 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -711,14 +711,10 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
 
 	if (!rollback) {
 		snd_soc_runtime_deactivate(rtd, substream->stream);
-		/* clear the corresponding DAIs parameters when going to be inactive */
-		for_each_rtd_dais(rtd, i, dai) {
-			if (snd_soc_dai_active(dai) == 0)
-				soc_pcm_set_dai_params(dai, NULL);
 
+		for_each_rtd_dais(rtd, i, dai)
 			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
 				snd_soc_dai_digital_mute(dai, 1, substream->stream);
-		}
 	}
 
 	for_each_rtd_dais(rtd, i, dai)
@@ -949,6 +945,14 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 
 	snd_soc_dpcm_mutex_assert_held(rtd);
 
+	/* clear the corresponding DAIs parameters when hw_params_count decreases to 0 */
+	for_each_rtd_dais(rtd, i, dai)
+		if (snd_soc_dai_stream_valid(dai, substream->stream)) {
+			dai->hw_params_count--;
+			if (dai->hw_params_count == 0)
+				soc_pcm_set_dai_params(dai, NULL);
+		}
+
 	/* run the stream event */
 	snd_soc_dapm_stream_stop(rtd, substream->stream);
 
@@ -1051,6 +1055,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
 
 		soc_pcm_set_dai_params(codec_dai, &codec_params);
 		snd_soc_dapm_update_dai(substream, &codec_params, codec_dai);
+		codec_dai->hw_params_count++;
 	}
 
 	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
@@ -1068,6 +1073,7 @@ static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
 		/* store the parameters for each DAI */
 		soc_pcm_set_dai_params(cpu_dai, params);
 		snd_soc_dapm_update_dai(substream, params, cpu_dai);
+		cpu_dai->hw_params_count++;
 	}
 
 	ret = snd_soc_pcm_component_hw_params(substream, params);
-- 
2.25.1

