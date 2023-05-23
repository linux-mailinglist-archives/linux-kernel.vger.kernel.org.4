Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E05970E0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbjEWPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237473AbjEWPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:13 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB2126;
        Tue, 23 May 2023 08:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWS0v4FTnV/k5snWDChS6n0nSe7FNaaHDVbPyuXsB7T4GldFPXDN7tgu3Bp6QqymTGbaol0vClz3EB38LuLkVdsZI+H3WUtIyI9nlxz93SfWS0pnjGAc+KiOCOZao93PL3AYys/eeQMZIUj9BK9yQRYVlGCzqdw6wPo8ywlxdRYhnQVDqR7S23muDJhqkCTDgVGlLQLNzEE61Hu9fEZkyODJrnz+3d4FXZWbhm5D6IIGsJZHmhtIRTZ5/ITY7An/uP6OL8px7LZwrApya2bfXiiKWl3mqcqmMMYy7i+Xn32vglKes1WSRDnlMwTs3dov+lmOTdRh0jsYYgSp65ymBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwLFTO49hOmOtrrgW7Di3P+CrgGZZnLOsuy0+ujom3Y=;
 b=gqbKtjHV97a5HX95jL2Y/+DW1P7FJf5zCA21QqGMYL5hTc3QU82W2blqyXFX0bKl7Ja9MpyQiTtJebjyZ0nSncRQ2PGB/oClqBR4Q5kLAPgrzmL83I9U7nFQTAkusaA6WWHf0qN3kHGmLq4Dc0BbxgdWBSqmsNlJ4mgDb9AdP5sFcuVfiinX2vYgYfO7edXQ7zj7pX517SJ/OzcY1qnZNQXMEvPtCri/RXxXvZxQoAkUdLv5D9U0XUmDWmGTBdqaIZRkr4ZVZO/IUAfc0zCmBKmPuAu3eASdyd1dms8kjr1z36cr/EKmyDeln+eUWjwNl2FKrjpxabLO9i1O+J6Ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwLFTO49hOmOtrrgW7Di3P+CrgGZZnLOsuy0+ujom3Y=;
 b=BelkduLV5rlglrwOEomD8GixNLSi3+ibflWBXCv42O6YAnLn2R+eqLliSb291IX02k/LgycwdJ1DtHHnGYlGXdF85iAgJu26kG0mkIAYa4hHQR+NNfhbq70O2RMx159giBTjmRIWsAeYtI1V8v6p2M/KOzAEyi6L7vc0tHMzgKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AM9PR04MB8586.eurprd04.prod.outlook.com (2603:10a6:20b:439::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 15:34:58 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 15:34:58 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 5/5] crypto: caam/qi2 - avoid allocating memory at crypto request runtime
Date:   Tue, 23 May 2023 17:34:21 +0200
Message-Id: <20230523153421.1528359-6-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To DU0PR04MB9561.eurprd04.prod.outlook.com
 (2603:10a6:10:312::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9571:EE_|AM9PR04MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: f503457d-b0f5-4494-b853-08db5ba34368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AtzLK8eJKg1At2V+deddvi7TXGdo+t0qzUhzeLTJQL8C+GfhwJwf62s1ArIzqruGXP8WZaoAg8AvkFjTvIuOCHb8wk1CkxgDHhcE1vQvrlkWTWpEhlRgXr1nMx9WFYoyaXaDX3mX9auLtciGlEN6au8SyVzMQhf72/6ouujXkVOuP/tDb0qijbYz5eDrppNclEtGGwwGEQ6unRZJS/543LvKV9Up7SoxhIkwZg8LgQt4sBm1TvYeOBp/Qkm9uY6xcpCDLpNf8Syyzci9gdlsFl0X5qiZQ+2esG9+7KR2Rv3ZwptgU9s7E+W8KDEiRcr4SK0gIsAnJNG2muLPrjoSN4k4VnjnrfzfGloh/clqclatu1DKC/D7oct3vmzucpmhyJBuFI3Lm76i/67cmtgIDL6fyHNDDyailuyis2tYW0/9XBw9PmX5zz8R4pBZG/s/XxvL9o/AgIKbnfBmeHFBHAKJHOWu5xhHExMEOX1rNhr1AHbqsHnjmNp8xGFa2Z0hMb9oHYN7Z64zh3YwHmGuCeSzaasS+FqufB9n0i2DUAxVTmMRzChSLXEr33HAsLP+KiSlnx3OCVwpQ+jMxu5/n2vd9I+hsznGardrZokYfyLIwz4KBlQHlIeg95z9bjam
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(41300700001)(6486002)(52116002)(6666004)(316002)(26005)(9686003)(6506007)(6512007)(1076003)(5660300002)(36756003)(8936002)(8676002)(38100700002)(38350700002)(478600001)(86362001)(2616005)(83380400001)(30864003)(186003)(66476007)(66556008)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eu+qxid+cP3mmkKQaK8T0s7p+ero8Pl26aIWPl42pgf3yFcS0fSCFEgbdM9s?=
 =?us-ascii?Q?Vghc9danBsj6CrpGRJhA1HsMAKEO6mS4JTswvgbt/V5/eydQFwLWgi1Z5vv3?=
 =?us-ascii?Q?zfxwFAmTZ+/eMGxlrSkolmAG60blPTSGNNdK2DWsm0U0C5HtxsiLEEL0S6T6?=
 =?us-ascii?Q?fqd6qRoyTwqOQBqMp97N2pgRReIzegOcHg3redlxDn/nO6dgevp+8zSf1bzQ?=
 =?us-ascii?Q?CCdWrhNxDvaiPtzyICuEE9m9OOphd4lLt2mcYEG6kT/3OnHXehdpXEZsXLbS?=
 =?us-ascii?Q?2xcCVJVAnp57zRQEG8Fobayw9MxLveSlLRyhXhLxdMcWGE+/MEZL961hZTta?=
 =?us-ascii?Q?LQqcjr/lpHipPjkK4tdcitqHHXkO8MVh0vHIMODFJD+9s9AT+r/TeCslAEJW?=
 =?us-ascii?Q?gXp2qxA/Wfir0sBowXNMzMrHlfo1luYzxFeOj9s/t1rhnxBGni4OGrWzrR/d?=
 =?us-ascii?Q?U06eTEpp/r7XcZfqFx3y0TInal2c/DzxGkAQn9rJxRaer2xtVgOTJdJbiavG?=
 =?us-ascii?Q?39UaakL9sjPX33Ina+2bXh7g0ADe1ZbidvsAWrYEn8ycpwCoDwSbKbKlAJQP?=
 =?us-ascii?Q?0Ih5Qj8/99i6FKnEogLKKulf75QBktBPGW6RPWcXgztHnlR29eI7PdFnPvJY?=
 =?us-ascii?Q?mzPasQXRhzzDrSJhgwv7QjDYyMH5bNEKxhLITU3uIHw+H9mD4ZAfkZypBhNV?=
 =?us-ascii?Q?RpYIp0+Xq2m+spIPLQ+iToPge6FlA59rX3Mg9HIiDDQaavucyr/HJpZvhMeI?=
 =?us-ascii?Q?LUwUyLo6prbXtBNa+2khWLqwhfGn/k5Kp2unj8Jrx22kJKKo/oo05hIh7LTM?=
 =?us-ascii?Q?Q3IuRNmTVpSxUua/mUvjC9XyQw6b6IBKMQ+yMD5/IjmYTukD1nPF0lU9Debx?=
 =?us-ascii?Q?NcTU4idkrHqn+jyNHkw5STsML+F8BIFhwHUnh6YQffaS0sohQMZlxvmpcbvu?=
 =?us-ascii?Q?qHripEGFSX3StWpJsv2TprvRK/VYemev04w1zVlplB/61g8F1oAttj4hB+t6?=
 =?us-ascii?Q?ULnck1ITMUyHVUZM+aUSWbI7CMn4c0AoayQL7BjXxy+rKnO7E/I9pwcaA2WO?=
 =?us-ascii?Q?WxWjj5CL9/eldl4cs5+OsraJsfFAjiPe3/3ayvqnZZu0xT0ZuHugXP1tB2on?=
 =?us-ascii?Q?0k2sL48IA0+cco4O9z8N6GgNYeYIeQK9c5aXOBGZB37Y8GNJZIV00QT9eA/p?=
 =?us-ascii?Q?FVRZq2RK1z542wpj1k41/Q8y7FzZyI2a4wzZHJMoR4feTu3cvbQHx+Tt4UfE?=
 =?us-ascii?Q?RAhQlFAQIKWnVOBQXHQfHKV3Eo0+cc7A7pc2R3wPJjtR5nwaEEYH742NDWY5?=
 =?us-ascii?Q?GbcdOYdHbtAA5bSMmT8zvcIO6x8K+Rb0+Lxnu1GKZtUU53LSR8egeUEfz7pe?=
 =?us-ascii?Q?yNdBxT7f0iX4QEkt0mDEvnFbIGJn9RujcFWLYqdxP6nsH/67bs5/eCEcFo1V?=
 =?us-ascii?Q?JCOQ+3oPFuB48v1GqfBkEeLIT4TkCxxtyoNzJa4PawERopE8yMTViRWbHjO8?=
 =?us-ascii?Q?hoWWY2JzNuINz7g7h4BlwFPR+Ud9vIlp7WCan6dIH/HSIKz43qg1I4BsbeNB?=
 =?us-ascii?Q?09TqI0tq1K08Ab3N/kqLCiCKHKaNxt2qwHyo3y+vTrQTV14eb7kaDtbHT1vK?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f503457d-b0f5-4494-b853-08db5ba34368
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:57.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMjoXIo7GBPJy+Z+KjeMDhrHZfS71usM1J0OczjtOVXXRe4ntWhh5Y2FzqT6ZERBXKHDGGsT3hlEi5m0WGWXaaWse+JZfJIfVYdKaNt9yMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8586
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

Remove CRYPTO_ALG_ALLOCATES_MEMORY flag and allocate the memory
needed by the driver, to fulfil a request, within the crypto
request object.
The extra size needed for base extended descriptor, hw
descriptor commands and link tables is computed in frontend
driver (caamalg_qi2) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to
dm-crypt use-cases, which seems to be 4 entries maximum.
Therefore in reqsize we allocate memory for maximum 4 entries
for src and 4 for dst, aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caamalg_qi2.c | 421 ++++++++++++++++++++----------
 drivers/crypto/caam/caamalg_qi2.h |   6 +
 2 files changed, 293 insertions(+), 134 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 5c8d35edaa1c..5bf6e29ec2f5 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -367,17 +367,10 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	dma_addr_t qm_sg_dma, iv_dma = 0;
 	int ivsize = 0;
 	unsigned int authsize = ctx->authsize;
-	int qm_sg_index = 0, qm_sg_nents = 0, qm_sg_bytes;
+	int qm_sg_index = 0, qm_sg_nents = 0, qm_sg_bytes, edesc_size = 0;
 	int in_len, out_len;
 	struct dpaa2_sg_entry *sg_table;
 
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(dev, "could not allocate extended descriptor\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (unlikely(req->dst != req->src)) {
 		src_len = req->assoclen + req->cryptlen;
 		dst_len = src_len + (encrypt ? authsize : (-authsize));
@@ -386,7 +379,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -394,7 +386,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(dst_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in dst S/G\n",
 				dst_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(dst_nents);
 		}
 
@@ -403,7 +394,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 						      DMA_TO_DEVICE);
 			if (unlikely(!mapped_src_nents)) {
 				dev_err(dev, "unable to map source\n");
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -417,7 +407,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 				dev_err(dev, "unable to map destination\n");
 				dma_unmap_sg(dev, req->src, src_nents,
 					     DMA_TO_DEVICE);
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -431,7 +420,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(dev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -439,7 +427,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					      DMA_BIDIRECTIONAL);
 		if (unlikely(!mapped_src_nents)) {
 			dev_err(dev, "unable to map source\n");
-			qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -469,18 +456,35 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	else
 		qm_sg_nents = pad_sg_nents(qm_sg_nents);
 
-	sg_table = &edesc->sgt[0];
 	qm_sg_bytes = qm_sg_nents * sizeof(*sg_table);
-	if (unlikely(offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize >
-		     CAAM_QI_MEMCACHE_SIZE)) {
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(dev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_nents, ivsize);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > (crypto_aead_reqsize(aead) -
+				 sizeof(struct caam_request))) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_zalloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(dev, "could not allocate extended descriptor\n");
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct aead_edesc *)((u8 *)req_ctx +
+			 sizeof(struct caam_request));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
+	sg_table = &edesc->sgt[0];
+
 	if (ivsize) {
 		u8 *iv = (u8 *)(sg_table + qm_sg_nents);
 
@@ -492,7 +496,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 			dev_err(dev, "unable to map IV\n");
 			caam_unmap(dev, req->src, req->dst, src_nents,
 				   dst_nents, 0, 0, DMA_NONE, 0, 0);
-			qi_cache_free(edesc);
+			if (edesc->free)
+				qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -516,7 +521,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dev_err(dev, "unable to map assoclen\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -538,7 +544,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dma_unmap_single(dev, edesc->assoclen_dma, 4, DMA_TO_DEVICE);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1123,7 +1130,7 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 	dma_addr_t iv_dma;
 	u8 *iv;
 	int ivsize = crypto_skcipher_ivsize(skcipher);
-	int dst_sg_idx, qm_sg_ents, qm_sg_bytes;
+	int dst_sg_idx, qm_sg_ents, qm_sg_bytes, edesc_size = 0;
 	struct dpaa2_sg_entry *sg_table;
 
 	src_nents = sg_nents_for_len(req->src, req->cryptlen);
@@ -1181,22 +1188,31 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		qm_sg_ents = 1 + pad_sg_nents(qm_sg_ents);
 
 	qm_sg_bytes = qm_sg_ents * sizeof(struct dpaa2_sg_entry);
-	if (unlikely(offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes +
-		     ivsize > CAAM_QI_MEMCACHE_SIZE)) {
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct skcipher_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(dev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
 		return ERR_PTR(-ENOMEM);
-	}
-
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_zalloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(dev, "could not allocate extended descriptor\n");
-		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, DMA_NONE, 0, 0);
-		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > (crypto_skcipher_reqsize(skcipher) -
+				 sizeof(struct caam_request))) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_zalloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(dev, "could not allocate extended descriptor\n");
+			caam_unmap(dev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct skcipher_edesc *)((u8 *)req_ctx +
+			 sizeof(struct caam_request));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	/* Make sure IV is located in a DMAable area */
@@ -1209,7 +1225,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		dev_err(dev, "unable to map IV\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1233,7 +1250,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req)
 		dev_err(dev, "unable to map S/G table\n");
 		caam_unmap(dev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_BIDIRECTIONAL, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1297,7 +1315,8 @@ static void aead_encrypt_done(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	aead_request_complete(req, ecode);
 }
 
@@ -1318,7 +1337,8 @@ static void aead_decrypt_done(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	aead_unmap(ctx->dev, edesc, req);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	aead_request_complete(req, ecode);
 }
 
@@ -1344,7 +1364,8 @@ static int aead_encrypt(struct aead_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		aead_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1372,7 +1393,8 @@ static int aead_decrypt(struct aead_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		aead_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1422,7 +1444,8 @@ static void skcipher_encrypt_done(void *cbk_ctx, u32 status)
 		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
 		       ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1460,7 +1483,8 @@ static void skcipher_decrypt_done(void *cbk_ctx, u32 status)
 		memcpy(req->iv, (u8 *)&edesc->sgt[0] + edesc->qm_sg_bytes,
 		       ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1516,7 +1540,8 @@ static int skcipher_encrypt(struct skcipher_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		skcipher_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1566,7 +1591,8 @@ static int skcipher_decrypt(struct skcipher_request *req)
 	if (ret != -EINPROGRESS &&
 	    !(ret == -EBUSY && req->base.flags & CRYPTO_TFM_REQ_MAY_BACKLOG)) {
 		skcipher_unmap(ctx->dev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1607,7 +1633,15 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 		container_of(alg, typeof(*caam_alg), skcipher);
 	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
-	int ret = 0;
+	int ret = 0, extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct skcipher_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct dpaa2_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
 
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
@@ -1625,10 +1659,12 @@ static int caam_cra_init_skcipher(struct crypto_skcipher *tfm)
 		ctx->fallback = fallback;
 		crypto_skcipher_set_reqsize_dma(
 			tfm, sizeof(struct caam_request) +
-			     crypto_skcipher_reqsize(fallback));
+			crypto_skcipher_reqsize(fallback +
+			extra_reqsize));
 	} else {
 		crypto_skcipher_set_reqsize_dma(tfm,
-						sizeof(struct caam_request));
+						sizeof(struct caam_request) +
+						extra_reqsize);
 	}
 
 	ret = caam_cra_init(ctx, &caam_alg->caam, false);
@@ -1644,7 +1680,18 @@ static int caam_cra_init_aead(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
 
-	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_request));
+	int extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct aead_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct dpaa2_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
+
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct caam_request) +
+				    extra_reqsize);
 	return caam_cra_init(crypto_aead_ctx_dma(tfm), &caam_alg->caam,
 			     !caam_alg->caam.nodkp);
 }
@@ -3013,8 +3060,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY);
+	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY);
 
 	alg->init = caam_cra_init_skcipher;
 	alg->exit = caam_cra_exit;
@@ -3027,8 +3073,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY;
+	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 
 	alg->init = caam_cra_init_aead;
 	alg->exit = caam_cra_exit_aead;
@@ -3413,7 +3458,8 @@ static void ahash_done(void *cbk_ctx, u32 status)
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
 	memcpy(req->result, state->caam_ctx, digestsize);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
@@ -3438,7 +3484,8 @@ static void ahash_done_bi(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	scatterwalk_map_and_copy(state->buf, req->src,
 				 req->nbytes - state->next_buflen,
@@ -3478,7 +3525,8 @@ static void ahash_done_ctx_src(void *cbk_ctx, u32 status)
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
 	memcpy(req->result, state->caam_ctx, digestsize);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	print_hex_dump_debug("ctx@" __stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
@@ -3503,7 +3551,8 @@ static void ahash_done_ctx_dst(void *cbk_ctx, u32 status)
 		ecode = caam_qi2_strstatus(ctx->dev, status);
 
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 
 	scatterwalk_map_and_copy(state->buf, req->src,
 				 req->nbytes - state->next_buflen,
@@ -3541,7 +3590,7 @@ static int ahash_update_ctx(struct ahash_request *req)
 	int in_len = *buflen + req->nbytes, to_hash;
 	int src_nents, mapped_nents, qm_sg_bytes, qm_sg_src_index;
 	struct ahash_edesc *edesc;
-	int ret = 0;
+	int ret = 0, edesc_size = 0;
 
 	*next_buflen = in_len & (crypto_tfm_alg_blocksize(&ahash->base) - 1);
 	to_hash = in_len - *next_buflen;
@@ -3567,18 +3616,31 @@ static int ahash_update_ctx(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
-		}
-
-		edesc->src_nents = src_nents;
 		qm_sg_src_index = 1 + (*buflen ? 1 : 0);
 		qm_sg_bytes = pad_sg_nents(qm_sg_src_index + mapped_nents) *
 			      sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
+		}
+
+		edesc->src_nents = src_nents;
 		sg_table = &edesc->sgt[0];
 
 		ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3640,7 +3702,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3655,18 +3718,31 @@ static int ahash_final_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes;
+	int qm_sg_bytes, edesc_size = 0;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	struct dpaa2_sg_entry *sg_table;
 	int ret;
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc)
-		return -ENOMEM;
-
 	qm_sg_bytes = pad_sg_nents(1 + (buflen ? 1 : 0)) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc)
+			return -ENOMEM;
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
+	}
+
 	sg_table = &edesc->sgt[0];
 
 	ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3711,7 +3787,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3726,7 +3803,7 @@ static int ahash_finup_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes, qm_sg_src_index;
+	int qm_sg_bytes, qm_sg_src_index, edesc_size = 0;
 	int src_nents, mapped_nents;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
@@ -3750,17 +3827,31 @@ static int ahash_finup_ctx(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return -ENOMEM;
-	}
-
-	edesc->src_nents = src_nents;
 	qm_sg_src_index = 1 + (buflen ? 1 : 0);
 	qm_sg_bytes = pad_sg_nents(qm_sg_src_index + mapped_nents) *
 		      sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return -ENOMEM;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
+	}
+
+	edesc->src_nents = src_nents;
 	sg_table = &edesc->sgt[0];
 
 	ret = ctx_map_to_qm_sg(ctx->dev, state, ctx->ctx_len, sg_table,
@@ -3805,7 +3896,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_BIDIRECTIONAL);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3820,8 +3912,9 @@ static int ahash_digest(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int digestsize = crypto_ahash_digestsize(ahash);
-	int src_nents, mapped_nents;
+	int src_nents, mapped_nents, qm_sg_bytes, edesc_size = 0;
 	struct ahash_edesc *edesc;
+	struct dpaa2_sg_entry *sg_table;
 	int ret = -ENOMEM;
 
 	state->buf_dma = 0;
@@ -3843,21 +3936,33 @@ static int ahash_digest(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return ret;
+	qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return ret;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
 	memset(&req_ctx->fd_flt, 0, sizeof(req_ctx->fd_flt));
 
 	if (mapped_nents > 1) {
-		int qm_sg_bytes;
-		struct dpaa2_sg_entry *sg_table = &edesc->sgt[0];
-
-		qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+		sg_table = &edesc->sgt[0];
 		sg_to_qm_sg_last(req->src, req->nbytes, sg_table, 0);
 		edesc->qm_sg_dma = dma_map_single(ctx->dev, sg_table,
 						  qm_sg_bytes, DMA_TO_DEVICE);
@@ -3900,7 +4005,8 @@ static int ahash_digest(struct ahash_request *req)
 
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3912,18 +4018,17 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 	struct caam_request *req_ctx = &state->caam_req;
 	struct dpaa2_fl_entry *in_fle = &req_ctx->fd_flt[1];
 	struct dpaa2_fl_entry *out_fle = &req_ctx->fd_flt[0];
-	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
-		      GFP_KERNEL : GFP_ATOMIC;
 	u8 *buf = state->buf;
 	int buflen = state->buflen;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	int ret = -ENOMEM;
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc)
-		return ret;
+	/* get address for base edesc and link tables */
+	edesc = (struct ahash_edesc *)((u8 *)state +
+		 sizeof(struct caam_hash_state));
+	/* clear memory */
+	memset(edesc, 0, sizeof(*edesc));
 
 	if (buflen) {
 		state->buf_dma = dma_map_single(ctx->dev, buf, buflen,
@@ -3973,7 +4078,6 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
 	return ret;
 }
 
@@ -3991,7 +4095,7 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
 	int in_len = *buflen + req->nbytes, to_hash;
-	int qm_sg_bytes, src_nents, mapped_nents;
+	int qm_sg_bytes, src_nents, mapped_nents, edesc_size = 0;
 	struct ahash_edesc *edesc;
 	int ret = 0;
 
@@ -4019,17 +4123,30 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
+		qm_sg_bytes = pad_sg_nents(1 + mapped_nents) *
+			      sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
 		}
 
 		edesc->src_nents = src_nents;
-		qm_sg_bytes = pad_sg_nents(1 + mapped_nents) *
-			      sizeof(*sg_table);
 		sg_table = &edesc->sgt[0];
 
 		ret = buf_map_to_qm_sg(ctx->dev, sg_table, state);
@@ -4094,7 +4211,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_TO_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4109,7 +4227,7 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		      GFP_KERNEL : GFP_ATOMIC;
 	int buflen = state->buflen;
-	int qm_sg_bytes, src_nents, mapped_nents;
+	int qm_sg_bytes, src_nents, mapped_nents, edesc_size = 0;
 	int digestsize = crypto_ahash_digestsize(ahash);
 	struct ahash_edesc *edesc;
 	struct dpaa2_sg_entry *sg_table;
@@ -4132,15 +4250,29 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 		mapped_nents = 0;
 	}
 
-	/* allocate space for base edesc and link tables */
-	edesc = qi_cache_zalloc(flags);
-	if (!edesc) {
-		dma_unmap_sg(ctx->dev, req->src, src_nents, DMA_TO_DEVICE);
-		return ret;
+	qm_sg_bytes = pad_sg_nents(2 + mapped_nents) * sizeof(*sg_table);
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = qi_cache_zalloc(flags);
+		if (!edesc) {
+			dma_unmap_sg(ctx->dev, req->src, src_nents,
+				     DMA_TO_DEVICE);
+			return ret;
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
-	qm_sg_bytes = pad_sg_nents(2 + mapped_nents) * sizeof(*sg_table);
 	sg_table = &edesc->sgt[0];
 
 	ret = buf_map_to_qm_sg(ctx->dev, sg_table, state);
@@ -4190,7 +4322,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 	return ret;
 unmap:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_FROM_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4208,7 +4341,7 @@ static int ahash_update_first(struct ahash_request *req)
 	int *buflen = &state->buflen;
 	int *next_buflen = &state->next_buflen;
 	int to_hash;
-	int src_nents, mapped_nents;
+	int src_nents, mapped_nents, qm_sg_bytes, edesc_size = 0;
 	struct ahash_edesc *edesc;
 	int ret = 0;
 
@@ -4237,12 +4370,26 @@ static int ahash_update_first(struct ahash_request *req)
 			mapped_nents = 0;
 		}
 
-		/* allocate space for base edesc and link tables */
-		edesc = qi_cache_zalloc(flags);
-		if (!edesc) {
-			dma_unmap_sg(ctx->dev, req->src, src_nents,
-				     DMA_TO_DEVICE);
-			return -ENOMEM;
+		qm_sg_bytes = pad_sg_nents(mapped_nents) * sizeof(*sg_table);
+
+		/* Check if there's enough space for edesc saved in req */
+		edesc_size = sizeof(*edesc) +  qm_sg_bytes;
+		if (edesc_size > (crypto_ahash_reqsize(ahash) -
+				  sizeof(struct caam_hash_state))) {
+			/* allocate space for base edesc and link tables */
+			edesc = qi_cache_zalloc(flags);
+			if (!edesc) {
+				dma_unmap_sg(ctx->dev, req->src, src_nents,
+					     DMA_TO_DEVICE);
+				return -ENOMEM;
+			}
+			edesc->free = true;
+		} else {
+			/* get address for base edesc and link tables */
+			edesc = (struct ahash_edesc *)((u8 *)state +
+				 sizeof(struct caam_hash_state));
+			/* clear memory */
+			memset(edesc, 0, sizeof(*edesc));
 		}
 
 		edesc->src_nents = src_nents;
@@ -4253,11 +4400,7 @@ static int ahash_update_first(struct ahash_request *req)
 		dpaa2_fl_set_len(in_fle, to_hash);
 
 		if (mapped_nents > 1) {
-			int qm_sg_bytes;
-
 			sg_to_qm_sg_last(req->src, src_len, sg_table, 0);
-			qm_sg_bytes = pad_sg_nents(mapped_nents) *
-				      sizeof(*sg_table);
 			edesc->qm_sg_dma = dma_map_single(ctx->dev, sg_table,
 							  qm_sg_bytes,
 							  DMA_TO_DEVICE);
@@ -4319,7 +4462,8 @@ static int ahash_update_first(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(ctx->dev, edesc, req, DMA_TO_DEVICE);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	return ret;
 }
 
@@ -4566,7 +4710,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 					 HASH_MSG_LEN + 64,
 					 HASH_MSG_LEN + SHA512_DIGEST_SIZE };
 	dma_addr_t dma_addr;
-	int i;
+	int i, extra_reqsize = 0;
 
 	ctx->dev = caam_hash->dev;
 
@@ -4604,7 +4748,16 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 				   OP_ALG_ALGSEL_SUBMASK) >>
 				  OP_ALG_ALGSEL_SHIFT];
 
-	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct caam_hash_state));
+	/* Compute extra space needed for base edesc and link tables */
+	extra_reqsize = sizeof(struct ahash_edesc) +
+			/* link tables for src:
+			 * 4 entries max + max 2 for remaining buf, aligned = 8
+			 */
+			(8 * sizeof(struct dpaa2_sg_entry));
+
+	crypto_ahash_set_reqsize_dma(ahash,
+				     sizeof(struct caam_hash_state) +
+				     extra_reqsize);
 
 	/*
 	 * For keyed hash algorithms shared descriptors
@@ -4659,7 +4812,7 @@ static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
 	alg->cra_priority = CAAM_CRA_PRIORITY;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
-	alg->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY;
+	alg->cra_flags = CRYPTO_ALG_ASYNC;
 
 	t_alg->alg_type = template->alg_type;
 	t_alg->dev = dev;
diff --git a/drivers/crypto/caam/caamalg_qi2.h b/drivers/crypto/caam/caamalg_qi2.h
index abb502bb675c..c700438de9e6 100644
--- a/drivers/crypto/caam/caamalg_qi2.h
+++ b/drivers/crypto/caam/caamalg_qi2.h
@@ -100,6 +100,7 @@ struct dpaa2_caam_priv_per_cpu {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if aead_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @assoclen: associated data length, in CAAM endianness
  * @assoclen_dma: bus physical mapped address of req->assoclen
@@ -110,6 +111,7 @@ struct aead_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	unsigned int assoclen;
 	dma_addr_t assoclen_dma;
@@ -122,6 +124,7 @@ struct aead_edesc {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped qm_sg space
+ * @free: stored to determine if skcipher_edesc needs to be freed
  * @qm_sg_dma: I/O virtual address of h/w link table
  * @sgt: the h/w link table, followed by IV
  */
@@ -130,6 +133,7 @@ struct skcipher_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	struct dpaa2_sg_entry sgt[];
 };
@@ -139,12 +143,14 @@ struct skcipher_edesc {
  * @qm_sg_dma: I/O virtual address of h/w link table
  * @src_nents: number of segments in input scatterlist
  * @qm_sg_bytes: length of dma mapped qm_sg space
+ * @free: stored to determine if ahash_edesc needs to be freed
  * @sgt: pointer to h/w link table
  */
 struct ahash_edesc {
 	dma_addr_t qm_sg_dma;
 	int src_nents;
 	int qm_sg_bytes;
+	bool free;
 	struct dpaa2_sg_entry sgt[];
 };
 
-- 
2.25.1

