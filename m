Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41212660326
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjAFP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjAFP2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:28:51 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2072.outbound.protection.outlook.com [40.92.98.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D176D8B751;
        Fri,  6 Jan 2023 07:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byeEh3Rp9rK9rjDWdV+oP6uAjLvGZWmUfq77Di9dxJtl+V2UgE9Gli1LSqHtMv+ULrTf89bUOfKv58C1aKINSpESBBk1/HkMjPZh4PERaOlTL/85JszRcFjKylYgT/2h7YOybdpv4ZrtRtEskCvAvokdseNO+FFD9JL1UgtMjwirdfyIvNIh0lzgMGNUTMw6UeAwLrMBOVd0bf7cgqOygsVTNNlaRCsy+K4CnyXrrmTyxDZP2+dQ596tpiWjvQzPE/mwzwVYY2ltXLtQzGMQNtsRpDeYLiMWteySCDfNCRkNPnVzVVeFbeU4lMx0UupB3LQ2x5j3XGnq2EvHIyyNoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BmRLGvIFGf6x6MsdNchUu4m49Fskrvy5WlA1WAaOJE=;
 b=RHHjVVdHTttCwBre3q4Zfus9qQX5zF2y2uZJ8U6oQVJZwjAdCiEX3vz+dSHW5GUwPWdlquOQP4HuiwtZz860MnfFM6YfU4KZat6TVFYpIExM4dZrarmkwUAf2uwGXzYpN5lVCqaZ9BsSOA7ouULDImPtx0iRPKGNR/w3E+EY7LQYawGEvWSgLIam+zjSSn5ZlwCSfSHuTuOoPI1gZtWhJT9Wj7y0Yo781X3Ep/tYXETnVTuRjE+E7/tYufh4TVmTn/M8lIj3BKfuziBMA5lLZCKJxHDR0VFm4UVRwP1waNV1ZzaDUGZJXyjPZX0bUcvy9+FGIWd1fvu5IeCUVR0Img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BmRLGvIFGf6x6MsdNchUu4m49Fskrvy5WlA1WAaOJE=;
 b=ZdmwauXLwuNdGR/byU+gKUM1mG95ijvT++BP08dFpcm3ZuTtB9b+z2clrzxUInAPZPqs3Kw4bjCTeaznlBL+h8qT+zsh11x37PbLQds6G0Tv281TG5538mU3KY559EWY3v4cXooW4DHzzgHQYbVNBFhLxDeStMQHI82XmvjOaOM1T4FcCX1B+x0xlzKUtdgKWSQMED+NNVTCvU5A8hK9E1nt0WOUmQBDxaf9opBUhhSNnEFnGoufslc7KG5qOSM7w93uwS5Af8Wq+jI9OeLXHWJB1is81mHA8nJtqPhZ24Ml/B84/QGPH1eraApDK+p4NPv7WZjfRi6j17YeJVEngw==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by OSZP286MB2315.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 15:28:45 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff96:9cb6:e047:c605%4]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 15:28:45 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] soc: qcom: apr: make remove callback of apr driver void returned
Date:   Fri,  6 Jan 2023 23:28:03 +0800
Message-ID: <TYCP286MB23232B7968D34DB8323B0F16CAFB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [wOxWUVj8v5B3sibpjM3IbgS3aY/UczNH]
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230106152803.27942-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|OSZP286MB2315:EE_
X-MS-Office365-Filtering-Correlation-Id: d36ba945-1d63-4aae-117a-08daeffab322
X-MS-Exchange-SLBlob-MailProps: 7J/vb0KDx3izZZWclzhZiVSziz+VEPOckQAHMgMaaTBtqwRxrt95MFmY1BAtt2TFXK1trFz4np0j1/RIjX07ti0WJh12VtYVpD7iuovdCfCZ+64p5W4px7i1vtnf8lz8cVeefUYw4R0fu074VixKyiXYNAIIf/b8bG3uFtAC1mLnmu4tnVuy1BJ69+YzQNiRi/7XQkbhYUEAEBgUrjvXIdx4YXwAombEgXDyUqIKGiUULWgpSpI4hTvSI7mZrSeuS8N/RgRbj7FVeKZzjKy4HPGel3EKtSkkG4yBFvfRT83ku38D4zPqtOp7hKv5uy1Uo+12QpWzSQ/HRD2te0oQkI0ItGJyLURkqfMufgDCO/cBAJir1G3wG0w2Cl0ATtyYh0Ei2fO8Fs81hbChiYTP0g3VqU1NQ2jeCynrqPch6I/74kUKudzw8nEkr1d4GsTo7z9b9l7MS9ZfEVIHeeM0i+vynTn+Hu79tsS+2Sa1n7xetrtQyPz3A6wq4a/tnDVMx+EXMksDWBdNnNgBGPgVEF8ygMUrssyQ5QMT9+iwoIxBrfAC1FxMLlzEoKNehNJnltTnsOZUBuf2LLscs8yPOeGKglgbgpNMYb2WPE62mH2lZlKemowuAKaFEo6WIfiMndfUdpxFIOEpQEQqEwda20vhv5Ad+EbtnTOoPXF/7WP6mm4PYBNP8vZynzvnwoesTONdCYgZf34hKzIeUwJxYY2CBVEUiVt2xwji8N0A6SKEM3M87wZCDb6Vh5P1IKWJqUtt69nFgBLNA9dFeT/Kvp5PkE7FVyN2skzBx4Hzboo=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PdE29EoagZCD9dIgap/0rI/Zg+hr0fFKcJiYMG8BojQD4FAb58/YlNLPXUS3DLweT8mO+y+MYfRIYm2KhgRHAgTn7mpkeuqHP2lrIyaQuIKK97XslMvQILs2W94X3DKaR4H4azApIeEMWTBIfxBotj6I2uBWQxeBZcCEX0SqoA/q62Zey94IlEK8a8eXnoSihP4wvsKYSiR1Ce0sHd1bXnRT+LDKUsf8ypriO1sPJhQfWJVlJDab+lcEiSqN86sRSfWRkSvfqrhGD1fndXTav7b5VpE8Z9uxDuyblSCQTO7KXTO61Vu3ZoQAmJ44jM0lZpu/xSapV2Kdj5Pc7gvVC3U1hjm1n2TPocNbe+TrFVf+bstzYTJeFq4wIDvH7d/z6lWiCFlxO3tFubFXEPQ6W6cetzZZ6eXEaDniFmtErg5QntBN6f9LVXzzqOC5yG5HPtGgTKQgwPRLl503l9bY5EGIb+C6lcduyVfKtdGzL5OU+bkw3UovKdWo27pDmx1FLJcwOJPvfob6enEElPv0EGQqSbLh6jWBVbelu8t/T/MHV+2AVWd+1bSmeloonCWkqNb2ym+uqhDSkQ1ZEtIYi+ycL+/RswAU1oIPie3xcCLS4cBj++fJnskIJbyNzhuMvjKZBMZMhUAojEMBshcWZQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rrcmz3THTnzaeefWMyNZzW2ojwp6XYmZxCdDLeHCG/cX/vUsy6XsHpKp1015?=
 =?us-ascii?Q?s405yGwN13fMy/06ShowASH7bfjmAEgHg8In66xrYFHBjqNd/IUhQpoaD0gZ?=
 =?us-ascii?Q?INASx4n6q4LoAYyoLPgU69RSUIT0gpSdyJ4FKqB+2dJn9KjtRowFVC1XNh7x?=
 =?us-ascii?Q?qfUa8R1dmOA29rHxzG10JEYNtu8zATSw1HzL2H6He4yTLeKMktAYco1uuso9?=
 =?us-ascii?Q?dKo6k8UnSFaGjcPx56d1iYDWVoChe25m5L+Th+nuU8nW0br9cQm4HUHwaBTK?=
 =?us-ascii?Q?VYPWLWpmc34Wo89UIjl1NvWxki99HFHkvP3RwXddX0xUKNz0ftiOIPwDyvMp?=
 =?us-ascii?Q?OCoTFXpVSy8iYKbWaERQ2m1zajbhrj+NKSMLKyNwzFccN+CAVwKzqb8EY6ay?=
 =?us-ascii?Q?MQ8gQNgfPk0R1Fo3f9UjT2N1HHBs629tNl8Q9ZUNv9lak5GoUEYEStnf8ssQ?=
 =?us-ascii?Q?a4+ue1mKC5C4K42Z02IT2qMCaXA7vZWBtF/fa+fScmEWTTA1X1+CSboRNdlF?=
 =?us-ascii?Q?Lnh9RTbCHYL3jRUA9+LlpjZEsAyTAA29/0Fe+JVfYETraIHHDrCAxll99//3?=
 =?us-ascii?Q?I43DBRROJ45bYHuqHcTvpmduMxg3fydj0npYpyTGM2/dxddQkY6wV68jPStR?=
 =?us-ascii?Q?NnO8YVRfZyq8y5bwxrZXqINJY/7sTEQaaalyJc3BP0wNfa6BNyrkVdOiimAK?=
 =?us-ascii?Q?oQALnE4GKbRc4CuPqF+CfJAWT907I4DJZ7vKMpP728YbYfXaCopyHcM0LriZ?=
 =?us-ascii?Q?sYJEgsDYHtwldsaWsinUKk1+AWQLICrySglt1GaCNnSfZ0qj3+54nI8qiLlw?=
 =?us-ascii?Q?7QHhlvkWc2jBPUA0Vz3MxJZUlvwJe0/f7qT2opliaNXwtekzGeYqoQBZh4/F?=
 =?us-ascii?Q?Bnlfiz8U9alo6iEvDO9iq0xR/MGikeDMUxzIgZFlnNxGIRu6F84+3pQaNz69?=
 =?us-ascii?Q?6tcsZtrjik68hhujFa0JEqbhlUgAJQZW1qzLLob1MnuBo9Sx4cR0oP2/kMY8?=
 =?us-ascii?Q?VIeniM0L6axAianKPOmiuett8ZZC0bDlqzfRYB1rFbBWjLcLodbihI2QyMcF?=
 =?us-ascii?Q?+Go3ZWlX/CkRTddmDHonpYmMl+5qy4Vua2Wo62fxbcTSyr/YPAxw9+asKnPo?=
 =?us-ascii?Q?GLsaQ1fJGfvRv1ZyNpxz5xx/FYQLXRLC0t97E0XOsmWdtCtLQV3XiZI8c7hR?=
 =?us-ascii?Q?JnMhwPCrGJdhQiHinqVVnB7+HP/y3hhLCz6kVmNezEoylWh8infbIG0LJy6B?=
 =?us-ascii?Q?OdRV0W58b2L09XGaQtd3HgTBFOu1URAER3YZzQw/+g=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36ba945-1d63-4aae-117a-08daeffab322
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 15:28:45.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fc7a6209d571 ("bus: Make remove callback return void")
forces bus_type::remove be void-returned, it doesn't make much sense
for any bus based driver implementing remove callbalk to return
non-void to its caller.

As such, change the remove function for apr bus based drivers to
return void.

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
v1 -> v2
- Update commit message.

v1
- https://lore.kernel.org/all/TYCP286MB2323DBD1F01BF918ADD0ABCECA189@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/ 
---
 include/linux/soc/qcom/apr.h  | 2 +-
 sound/soc/qcom/qdsp6/q6core.c | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
index 23c5b30f3511..be98aebcb3e1 100644
--- a/include/linux/soc/qcom/apr.h
+++ b/include/linux/soc/qcom/apr.h
@@ -153,7 +153,7 @@ typedef struct apr_device gpr_device_t;
 
 struct apr_driver {
 	int	(*probe)(struct apr_device *sl);
-	int	(*remove)(struct apr_device *sl);
+	void	(*remove)(struct apr_device *sl);
 	int	(*callback)(struct apr_device *a,
 			    struct apr_resp_pkt *d);
 	int	(*gpr_callback)(struct gpr_resp_pkt *d, void *data, int op);
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index 5358fefd4210..49cfb32cd209 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -339,7 +339,7 @@ static int q6core_probe(struct apr_device *adev)
 	return 0;
 }
 
-static int q6core_exit(struct apr_device *adev)
+static void q6core_exit(struct apr_device *adev)
 {
 	struct q6core *core = dev_get_drvdata(&adev->dev);
 
@@ -350,8 +350,6 @@ static int q6core_exit(struct apr_device *adev)
 
 	g_core = NULL;
 	kfree(core);
-
-	return 0;
 }
 
 #ifdef CONFIG_OF
-- 
2.25.1

