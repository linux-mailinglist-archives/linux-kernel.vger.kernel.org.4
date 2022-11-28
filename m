Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9624863A110
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 07:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK1GK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 01:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK1GKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 01:10:23 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EEF13F55
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 22:10:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLPwf+xN092D5QOk3UMMrjg5YBhDuBbubF8coCBEo0Ye8FPZniuu8BOLW/Ce3DdH91Ao1LfI9w0mj/8oTpyosAaIfkU/JIXRtmT57ClhurzeD82bDgKSwf7lxUYFaUMDxskpuiWmRFeP7XV7TFRJIInghW4RLqRy4GDjNjLptIkZy7rS88qww1LVojQmzqIGyX2M9SaV+bVG75Jd8KMypQWnsZqk3CgZUlcaElI3PgLnT+9AoUkKgHxl5vi69CHHYdTcBwQYPThnNw1cUoLXYjRTPk9TZdKwvSmMIPG6q8+8s4KSQrDeqRBKWgqkFqRIVuWliGI0KNDc2GCofVKFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzHHYrJy4Vgra6wM4KLruSFH9621GhmZ5y0mi4FRjBU=;
 b=SD+TYH4GzNC7w6QdzvyvDOkSbapI15wNTr7h6gcYpwMc/sn1KBdWscYgx4aXEwL/HYCaE6Hvlq3saUXxwJW4tRnKcDCj23Ms+wZZEZo6cFn2bkvquJRgNfAr9fmfmPteHK9+Fqy1qtCnT//mZW0x1fjzFaIDAV1F0T5gPI9KIYiH86YV2y0PCVlbFQiZjlFrONs7cH7k2d9+r90VG5QdwNZk8j3fFph3itm1h1vyV8CvCC8hDEWLv34DOOeceSW8sGRA8wRrqvCg0cNsgdPXdhuaCX9ekBWEC4fjR0azVryLDmz3Un9hLAbrW6EG3EpJCcFdjRc7sBx3Q9bdKYy5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzHHYrJy4Vgra6wM4KLruSFH9621GhmZ5y0mi4FRjBU=;
 b=IqW4SrpxDjf8RAmQS8M8WyN40FT8TgQWtmMISiwwd4wRtW2g+gOCGSEX0Z7CAE/uftRYF08xZvi7B7+inZrPBUinyw2JAtQkFKrUSwHvDpa0DLvriTEBUpF9tIxFOsZg70eDdkDWdQgcpoBpCftNglJJ7l+EgNTK/WGh2SNlyrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
 by AM9PR04MB8876.eurprd04.prod.outlook.com (2603:10a6:20b:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Mon, 28 Nov
 2022 06:10:19 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::1b5f:5d12:d73b:236c]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::1b5f:5d12:d73b:236c%5]) with mapi id 15.20.5857.023; Mon, 28 Nov 2022
 06:10:19 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated
Date:   Mon, 28 Nov 2022 14:09:50 +0800
Message-Id: <20221128060950.3540845-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To VI1PR04MB4222.eurprd04.prod.outlook.com (2603:10a6:803:46::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4222:EE_|AM9PR04MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b55aa9b-db04-4b60-cc45-08dad10739a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soPAv1GFLzkVkBrGsy/srs6MrWl2bC1T7HnmCoRibNzyAae0a21PRPIPbZUxq/qsOZFL33Hki+LhzARK+6FpgSyfp328/dbndYlp09eduvkv2dJpu8sJWJaccL/QMSrmJWqvBWu57F0VwbY2li3gHZdTvqofA43wdH8hpXnBnsbT9m4mGNEmUH7f4sE7IEDsN69w2+ICxOEGtKl/ypRrdpxU0vE4Uflk037ieasLY8tF20pPGM7qsMaOD99BWWgA7xFwjugZ6VMRxnJ1/NxhRvRhDzeOGSyNPDd0ccVbAaZRakehmLdnbyLM6Up3Tic6fzokzenEj7kgayjTcsL7shgobNoMZgRGI0XoR4yfShigxjijS/HCrHpHQZa02EdY9jNScYdcNZr6Ylz/FKrG+zWH1P0wNThuqVvx05JVgV9nd6Ru8RlDUD5ybZpbssQWYwBu2c6W8VKT9UsaCDOxyK/KGaRFjC56YJx1Tua/6zArtFun6EoLF8y4ZScFehlbdfYEioJNJiEKA86BuHy6zpiu6UeHQJav+AFOpMYxVXIJjll8HjUY0zbOnM2r2j9hyREW5EvsV+kygXrWrfIe4RcjP5y0QxyFu+Nb5lyGYPikf6tLoUTSM7I2hKWFi9V5g32BaPqPbIoYUgJ5UxHfMFjVGGD0ja+60wqRCsIc0vF3TKqRycFioVJh8VmL+l0tj8oC1MYbXH1/b1lwS3zv4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199015)(52116002)(36756003)(478600001)(6512007)(6506007)(6666004)(38100700002)(38350700002)(15650500001)(6486002)(26005)(41300700001)(66946007)(8676002)(66476007)(66556008)(2616005)(86362001)(4326008)(316002)(44832011)(8936002)(5660300002)(1076003)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?58UAgNMv3KvKZDzwcsyFw34lK8XXY+1gkwU9f4WoFhR5WOQl5YmwQVpKn3Er?=
 =?us-ascii?Q?sMb1khdDQqLF2rukTpN1xtmg5+32vu4Z2QCqdNRhyK5lLYwART21AzJjr7+/?=
 =?us-ascii?Q?Ag7Wg4ujFYKTTPRMUK06SjnJtkq8OxU9nFoydQ3PYqTg5QDT8OBPOht0j5es?=
 =?us-ascii?Q?Z/QfHEDrAI7BsKKOwLB5nvOv4eTc+c+r7dBwRjfV8A/K/iQI39WvIhy8ijIv?=
 =?us-ascii?Q?ae2ys4e5SClP+QVpe/poO/SGJdtYVin3kDLtwALD7aYDXz4YAqOwqqb1unGn?=
 =?us-ascii?Q?J1by0dsRg2Y0KWQ65zZ0dZac4LIdkKCVZftrNY/m9ynI9pfOorMA/fOF21Tq?=
 =?us-ascii?Q?1bn50zyBPBHOOz0QhIXsEOBm/Sek8982RK5VHDWEIsKBOraWZgqMSOsQ+E7n?=
 =?us-ascii?Q?ga8wwFxueNeGZks0NK4b0qdNPiPNt1WWVqkuNV6uc4uzT6rN2OAeD7B1DY/j?=
 =?us-ascii?Q?avBFvFhTG+ABcPL23Wm4nesCyOEasrHm+Y/f5Uvy4C7/TPe7mJDxfdI52RUT?=
 =?us-ascii?Q?9Q51mVW5qNqLnyspyzxNmckR3NvmYCT4bmhDAvYD8ZtZKK9r5CYD6lCdKdzk?=
 =?us-ascii?Q?+SpeGuV340RUTswQXp/8as1m2RtcyisZER0oTAY6TrY/X4J3M+eU67WnyqGB?=
 =?us-ascii?Q?g163yDAmayPSnfwQdIcD4rTvAk2eksgSsaZ8lLJoidUzFNf5tRbgDkjDPtay?=
 =?us-ascii?Q?UnoOadroi47/d43yXlzKrti3Tw0tK1ku/AdYethdcr51I6kPxCy/KeeqoGqH?=
 =?us-ascii?Q?4YPe/q5ddja4vwNjWuC4750yms99bzINsXWV63NafZqYS7ZT18cNKICQBh4F?=
 =?us-ascii?Q?agL0QCyBBgvS7T2Zl39gN3t+lkxzWxCkH0CU0lcz73/UvKeJ/NY+/WUUINep?=
 =?us-ascii?Q?N79v4xGb4gW8rOPwq/ZMuYsx9xtqRVUUZNUPtRsumsvNjoo2KDHDP33BFaSK?=
 =?us-ascii?Q?+LMQyn9AA19m1t2yNGBxxnFILcrQ+JufIJozCyFzlbzhql5qo4mcnTvBALgd?=
 =?us-ascii?Q?HBXvISjfUEt0aqEVQOxB2ET7P5FE9Fa69G1Rbqsq0gnN4hTc4+TTw8RhUxrp?=
 =?us-ascii?Q?l6fXIlzaG01S+tANLtuusFEKnXUqA3nZRqElmLG/ckbIlvG+nGnm3fyFEaIC?=
 =?us-ascii?Q?GKrj17NIbyRplaeU5Umj+vfkIeBymtq/dW2f6wUxBbfz9/m/52wt4SX8yqf9?=
 =?us-ascii?Q?Sm4SzoXhzy1lPwHILBtc7o9nkHNqJ0MluDsyJipCkT3Oc/vxvIRrtz3ygcJx?=
 =?us-ascii?Q?sGu8S8UFJGP2bg2acG/4w93K2RpgDrr5IA4DS+und5gXTk5hP0RqkPpOyXDs?=
 =?us-ascii?Q?Xy9ussvgWhweMkGknD95WYFGmFrKdLk0vMrCL/3tP4Ph6qxnpTLAFcHbELWT?=
 =?us-ascii?Q?9PKp3MzrkMJaVcHc/7oAu9XC+W97+T+/XSFfJFHSgAvwmmBopVhASjzsne+m?=
 =?us-ascii?Q?LbVLzTCb0iU5gMVO5wVj2rC8Ev7a2chgc1l128VeA22qdt+CvBl1lWhnT9tq?=
 =?us-ascii?Q?crfXoNcsGzLVZjSYai5VsfWsk6HllRSVsBw9MDgZ6EC33B7eDKheG0Wzp4lO?=
 =?us-ascii?Q?c8GoIQkpLBKMS6pHpAJWKdOX+CZf/aMzrwCJ0ZOb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b55aa9b-db04-4b60-cc45-08dad10739a3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 06:10:19.0077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O48pNpen5UHeHm+NkEwRzzXDHRkS6uOedmKGkvqWGm3BixQmXXm76oa8jIhsYnEA04bzK8cRZE3JDIIF/q2ZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAIs parameters should be cleared if there's no active stream. Before,
we implemented it in soc_pcm_hw_free() by detecting stream_active. If
the running stream is the last active stream, we're going to clear
parameters.

However it will cause DAIs parameters never be cleared if there're
more than one stream. For example, we have stream1 and stream2 about
to stop. stream2 executes soc_pcm_hw_free() before stream1 executes
soc_pcm_close(). At the moment, stream2 should clear DAIs parameters.
Since stream_active is not yet updated by stream1 in soc_pcm_close(),
stream2 will not clear DAIs parameters. In result both stream1 and
stream2 don't clear the parameters.

This patch moves DAIs parameters cleanup after stream_active is
updated.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-pcm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fb87d6d23408..85a7f0a3eb70 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -709,8 +709,17 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
 
 	snd_soc_dpcm_mutex_assert_held(rtd);
 
-	if (!rollback)
+	if (!rollback) {
 		snd_soc_runtime_deactivate(rtd, substream->stream);
+		/* clear the corresponding DAIs parameters when going to be inactive */
+		for_each_rtd_dais(rtd, i, dai) {
+			if (snd_soc_dai_active(dai) == 0)
+				soc_pcm_set_dai_params(dai, NULL);
+
+			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
+				snd_soc_dai_digital_mute(dai, 1, substream->stream);
+		}
+	}
 
 	for_each_rtd_dais(rtd, i, dai)
 		snd_soc_dai_shutdown(dai, substream, rollback);
@@ -945,15 +954,6 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 
 	snd_soc_dpcm_mutex_assert_held(rtd);
 
-	/* clear the corresponding DAIs parameters when going to be inactive */
-	for_each_rtd_dais(rtd, i, dai) {
-		if (snd_soc_dai_active(dai) == 1)
-			soc_pcm_set_dai_params(dai, NULL);
-
-		if (snd_soc_dai_stream_active(dai, substream->stream) == 1)
-			snd_soc_dai_digital_mute(dai, 1, substream->stream);
-	}
-
 	/* run the stream event */
 	snd_soc_dapm_stream_stop(rtd, substream->stream);
 
-- 
2.25.1

