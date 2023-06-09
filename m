Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2672972E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjFIKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239804AbjFIKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:22 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33388199D;
        Fri,  9 Jun 2023 03:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msNKud5FBjIxwf8EVvhf0LEIOuBYoo5BuB3C7jHw2CWdtWnwgtFmRjk2LFRzPaZMmfOpR88UC/Y6NSw/3Bo6PGoIu8yfRYxh3fNM2w7Mpu1d93cEhWDJWC4tM++ED8aG7rDclD2DniY524Tn2GCuHs5pakb4mH3fhKgmwAKLN7ruI9q6VpunYNcYuoWSUZ68M2SB/IPpsiaen3XnOsl0IgilTAp/pFL3+eZZN0Ba29VoGjE0Kk+w4DTogQIDcKXTzbUQe+IbNy9vrh7iATBEw1C3bKVVxX/QmsalehC5WvqtfwFyaYvNBz5kSpkBAFHtdZ73KaIOvA1p5Waga9vGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctNwIKlhQQ6tNgxnawD38dGrU6vBzcG9uOrix3F3Uwk=;
 b=YrXb0I2GsUQFUM0H3QtDm2h+ckgqk8wKav42R4YEbkmNRFzi6xqSPkltLPDDw3Q4Taw+Zg6Rp8LV0s7qjTV/IndVsfNlqqeb46p5AubsrLROWQdfH4VZ/Mqdzr0w7BW6ROrZLXpe5GLFXl/a15lXVnq4vSxiC+hm52akuEM8xRW0bY48t4CLXhy1AUdnpI51U2aw1dT0y/TW2ak9OvoPYDdnMi5jRdyrOAW7u0DQHl6vM59oCvzGveerIvnb+9v1sFs8HMXMxxEI36a+wxVswnrjTFfL7yTFGJxUyaFKpIqQha2P1YeSmhavAnt8jbXq0HNPA8er67B41jS/3YW0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctNwIKlhQQ6tNgxnawD38dGrU6vBzcG9uOrix3F3Uwk=;
 b=QI1jRwJssN2kO/12X3RlBTRqXsYt/PiO5l294C7qpaRTahLHdIDiHfGZrxwD/X7BkxJrMlOJzAWYY2Ud1YtvaJYtsIq0yyLOHUTKjkF279uoEOocYJrjqtfZCSTwz9d8IsVQX7F9O3oseiCIolVGuRYoY+ZXguZdsapLNJ/S5z4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:38:57 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:38:58 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 3/5] crypto: caam - avoid allocating memory at crypto request runtime for hash
Date:   Fri,  9 Jun 2023 12:38:40 +0200
Message-Id: <20230609103842.4159321-4-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
References: <20230523153421.1528359-1-meenakshi.aggarwal@nxp.com>
 <20230609103842.4159321-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9563:EE_|AS1PR04MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c21c45b-df3a-4233-5654-08db68d5bb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YV24GWiXOPJ9O+VHgHPC3Cq9rL8OC7/YwmQkUcL+zRQyIGy8miiMTwhKbh6xEkZkenEjd7KW1sxmaIp5zBNz9zgpJOpufY453ND6QLP89T6RjsMY1pzJMVs9GHokP11ltdQcnveaE8hN6Czqsi8RhzNy0p5o+GzP9zWXsw9HaOLc+dL9z7gA7i4VBfa29QOJQUEF+tOP2Cu39CUSmusBYkG/HCDbb1o7OLZkgSQ5GJa3OXHxeydLnF57iQ0inK8CsBIfjpuAMHOq4fIxA7YGHBQhezHJO6RwJ8i60XykUvNeFI9/hGRaEMA1bWAltKrMdlq43bTzr/1h2uC5+L8YEYqnu+xjN3IWchUrWDeIQmzoT+U1lyzM/29pPH/tKPl2tv3mOg9nEFAxC5dcbPLvkle/dIeErdieXPcGCWBDhQr8/+hd1Yf4SUHC/VJiUTs0sJvpOIs9Uy26daWm9KMPRPRLBKNIJY6PAFr5vZiQmPNc8eAA8iNlskG8kpWyvB1W5s69mKFdvcbsRe7yZxNYLz+yl1EU6+wWFtTDA6KwPGYwjv8hCqrMmNyR8K3shoLZcW/aZMknakwjMbeFabdhFstJkBTkupCPVIxjkmFND07U9p9l0lgm+oaQXjDGfSM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q2fMPtMh0B/KUvll89t8ng+OZZvd89mG0VLEqNaOovLDti5prZq8ikBZhGS+?=
 =?us-ascii?Q?PachpTaZMCrrH6k1D23DA3B0HRieOKTDeGlG8P8HgZ1nYPBfC6E4w+dMUxz6?=
 =?us-ascii?Q?jR2lZT9eZ6N6BnwK/PeGx9/7FVzsgoc5Fc8EigFxjtSTFH0yNgA0K3QXcoGx?=
 =?us-ascii?Q?z/d1t1gPoMthZT/9MEdzo/9NtTmh5H09JgvAqnVI9aDh0AbivSobv7s6J9v5?=
 =?us-ascii?Q?10FkwmMal/CQsNYUnLzWmteq/PjSpXIdF0BHp6A7iKU9wp1mmmzNPir2Wdbg?=
 =?us-ascii?Q?jSR/UChWBdN2a9rGCjag9mLgjbnZhxJsRXOKDx7F5J79Lw6AE43rLO0k2jwe?=
 =?us-ascii?Q?cD/J0wUD4j3XldqLwsmZW0VXlWzgjEBx1Dswn1jbWT5TC7H+yxGwD2xCJwTC?=
 =?us-ascii?Q?BEvygv4Ys3LVvDTiCYIeGFo8BADGDTvzIlVp+mKpACVP2gln9ECgPNLHPqUs?=
 =?us-ascii?Q?dGhM0aXMkkBYCiJBmQwaLC7zGde8Kahpyi3uhVinvlqdQdjiGYzRRpzTiilv?=
 =?us-ascii?Q?q9JVutx1YYQFaxFsExNixW9CGfuwIL1O4clPM5gS/p8WCSj0nwfWctTOBIZU?=
 =?us-ascii?Q?FP/Mfmf5tATPmR0P9fio64N4kb9fug4EsbQmLWgG9jD+IDBYHpv90RD20cWi?=
 =?us-ascii?Q?LuCDsoBRE01j9Lo/QACWvvyM+OQmhlHMSJZjYidCfkEftIylwpkbyAkKt19U?=
 =?us-ascii?Q?pS++jLsXpkJxazWTFaWTpuCXQ9IkKf+YrTGw7fdx0CRdrToLr8/OWHVz+MHV?=
 =?us-ascii?Q?ovr/IRm7fZDzyiLdZaBGohzG5Di8JnpPxZ6br7+JkPF1AjBdxp0ayGC01+2B?=
 =?us-ascii?Q?28pC0/4DatPw9E0HXH774cs3tlyqqWDqKvdL+ZXu0bHqTp82nSM7iS0SJg+q?=
 =?us-ascii?Q?mgVmoNWj6sqmq/Y8WX53KxisAGNONh1qVwdTd3NhTuVDQZwBTxy7NOSwbFBd?=
 =?us-ascii?Q?YLq1LmvXblVvxSLzhYi/83zFDWEKMBtTa0UZSg5k9ZP9/fywqPnNKZbUMWgC?=
 =?us-ascii?Q?gcIhOcN6RJ7p6opvUNbqaTOXZpe9DsmdVR0BnwzIHp/KwlW9kwJ2cNNPDtp9?=
 =?us-ascii?Q?kutX6iafBWQZvGvflrV68hZK+7q5X2v8YW6EZJf62Q8OIsMWYcAnRqoj7hM0?=
 =?us-ascii?Q?3Dz2gJBBNpwVteu50hDAqZ75d2MvM4Vk0+MrsN2pHSBfYqjuPjd8rSNC8Xx+?=
 =?us-ascii?Q?Z45cFKI9Nr0/7faU2+DwRQJdkkeDWdngO000b1yMDeXdquUreA+BRGi8/2Tk?=
 =?us-ascii?Q?GewElUAn4cJ/ywN0ChUrBVuHg3F/UPGOQZcwqkd+Bx8TJ8d6Ydx1mFSSNrpG?=
 =?us-ascii?Q?ebarHVR2Zu4QBCPfRxsucIFNJDv0w2M43p+rl+ER7qTWTC/QF6KkzgiEEWe5?=
 =?us-ascii?Q?9QcATVEPop01qv0GBUdSFGFLp7f91ay0I98bo9c9smwOzCQY/5Hgk+yF3mMf?=
 =?us-ascii?Q?Tixo7Jni3/0A5peJqsDEMfD9vVyvPHu5TOzCxWk8PH7O949HkxuPW0PbDJ04?=
 =?us-ascii?Q?a4a7UYePAfT1KkZrFlatmx7yDBW/GPoZMYddkbAdvLZ7QVNoFCPrnnOEv909?=
 =?us-ascii?Q?Yk9H6jR01Gr3ryKkwVopXz4fuhzTAK5Tg+f7+4Elzi2M0swKHejAMf2lEg4p?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c21c45b-df3a-4233-5654-08db68d5bb48
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:58.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANHN/r6bV2navxUEwz23inR3pzrQxK0iLu1Uq0Alr6Ek2kpHSJG1oUIrLD7LsbE9Mx3ZDjuZYVtAtJ4+ckUmy5lQEv3OQv4ufFxcSKqWjtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9336
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
The extra size needed for base extended descriptor and link tables
is computed in frontend driver (caamhash) initialization and saved
in reqsize field that indicates how much memory could be needed per
request.

In reqsize we allocate memory for maximum 4 entries
for src and 4, aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caamhash.c | 77 ++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 80deb003f0a5..75df8bca9ca9 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -535,6 +535,7 @@ static int acmac_setkey(struct crypto_ahash *ahash, const u8 *key,
  * @src_nents: number of segments in input scatterlist
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
  * @bklog: stored to determine if the request needs backlog
+ * @free: stored to determine if ahash_edesc needs to be freed
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
  * @sec4_sg: h/w link table
  */
@@ -543,6 +544,7 @@ struct ahash_edesc {
 	int src_nents;
 	int sec4_sg_bytes;
 	bool bklog;
+	bool free;
 	u32 hw_desc[DESC_JOB_IO_LEN_MAX / sizeof(u32)] ____cacheline_aligned;
 	struct sec4_sg_entry sec4_sg[];
 };
@@ -603,7 +605,8 @@ static inline void ahash_done_cpy(struct device *jrdev, u32 *desc, u32 err,
 
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, dir);
 	memcpy(req->result, state->caam_ctx, digestsize);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 
 	print_hex_dump_debug("ctx@"__stringify(__LINE__)": ",
 			     DUMP_PREFIX_ADDRESS, 16, 4, state->caam_ctx,
@@ -652,7 +655,8 @@ static inline void ahash_done_switch(struct device *jrdev, u32 *desc, u32 err,
 		ecode = caam_jr_strstatus(jrdev, err);
 
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, dir);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 
 	scatterwalk_map_and_copy(state->buf, req->src,
 				 req->nbytes - state->next_buflen,
@@ -703,17 +707,28 @@ static struct ahash_edesc *ahash_edesc_alloc(struct ahash_request *req,
 					     dma_addr_t sh_desc_dma)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct caam_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct caam_hash_state *state = ahash_request_ctx_dma(req);
 	gfp_t flags = (req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP) ?
 		       GFP_KERNEL : GFP_ATOMIC;
 	struct ahash_edesc *edesc;
 	unsigned int sg_size = sg_num * sizeof(struct sec4_sg_entry);
-
-	edesc = kzalloc(sizeof(*edesc) + sg_size, flags);
-	if (!edesc) {
-		dev_err(ctx->jrdev, "could not allocate extended descriptor\n");
-		return NULL;
+	int edesc_size;
+
+	 /* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) + sg_size;
+	if (edesc_size > (crypto_ahash_reqsize(ahash) -
+			  sizeof(struct caam_hash_state))) {
+		/* allocate space for base edesc and link tables */
+		edesc = kzalloc(sizeof(*edesc) + sg_size, flags);
+		if (!edesc)
+			return ERR_PTR(-ENOMEM);
+		edesc->free = true;
+	} else {
+		/* get address for base edesc and link tables */
+		edesc = (struct ahash_edesc *)((u8 *)state +
+			 sizeof(struct caam_hash_state));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	state->edesc = edesc;
@@ -778,7 +793,8 @@ static int ahash_do_one_req(struct crypto_engine *engine, void *areq)
 
 	if (ret != -EINPROGRESS) {
 		ahash_unmap(jrdev, state->edesc, req, 0);
-		kfree(state->edesc);
+		if (state->edesc->free)
+			kfree(state->edesc);
 	} else {
 		ret = 0;
 	}
@@ -813,7 +829,8 @@ static int ahash_enqueue_req(struct device *jrdev,
 
 	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
 		ahash_unmap_ctx(jrdev, edesc, req, dst_len, dir);
-		kfree(edesc);
+		if (edesc->free)
+			kfree(edesc);
 	}
 
 	return ret;
@@ -941,7 +958,8 @@ static int ahash_update_ctx(struct ahash_request *req)
 	return ret;
 unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, DMA_BIDIRECTIONAL);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return ret;
 }
 
@@ -1002,7 +1020,8 @@ static int ahash_final_ctx(struct ahash_request *req)
 				 digestsize, DMA_BIDIRECTIONAL);
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return ret;
 }
 
@@ -1076,7 +1095,8 @@ static int ahash_finup_ctx(struct ahash_request *req)
 				 digestsize, DMA_BIDIRECTIONAL);
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, digestsize, DMA_BIDIRECTIONAL);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return ret;
 }
 
@@ -1125,7 +1145,8 @@ static int ahash_digest(struct ahash_request *req)
 				  req->nbytes);
 	if (ret) {
 		ahash_unmap(jrdev, edesc, req, digestsize);
-		kfree(edesc);
+		if (edesc->free)
+			kfree(edesc);
 		return ret;
 	}
 
@@ -1134,7 +1155,8 @@ static int ahash_digest(struct ahash_request *req)
 	ret = map_seq_out_ptr_ctx(desc, jrdev, state, digestsize);
 	if (ret) {
 		ahash_unmap(jrdev, edesc, req, digestsize);
-		kfree(edesc);
+		if (edesc->free)
+			kfree(edesc);
 		return -ENOMEM;
 	}
 
@@ -1191,7 +1213,8 @@ static int ahash_final_no_ctx(struct ahash_request *req)
 				 digestsize, DMA_FROM_DEVICE);
  unmap:
 	ahash_unmap(jrdev, edesc, req, digestsize);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return -ENOMEM;
 }
 
@@ -1312,7 +1335,8 @@ static int ahash_update_no_ctx(struct ahash_request *req)
 	return ret;
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, DMA_TO_DEVICE);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return ret;
 }
 
@@ -1387,7 +1411,8 @@ static int ahash_finup_no_ctx(struct ahash_request *req)
 				 digestsize, DMA_FROM_DEVICE);
  unmap:
 	ahash_unmap(jrdev, edesc, req, digestsize);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return -ENOMEM;
 
 }
@@ -1495,7 +1520,8 @@ static int ahash_update_first(struct ahash_request *req)
 	return ret;
  unmap_ctx:
 	ahash_unmap_ctx(jrdev, edesc, req, ctx->ctx_len, DMA_TO_DEVICE);
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 	return ret;
 }
 
@@ -1782,6 +1808,7 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 						      sh_desc_update);
 	dma_addr_t dma_addr;
 	struct caam_drv_private *priv;
+	int extra_reqsize = 0;
 
 	/*
 	 * Get a Job ring from Job Ring driver to ensure in-order
@@ -1862,7 +1889,15 @@ static int caam_hash_cra_init(struct crypto_tfm *tfm)
 
 	ctx->enginectx.op.do_one_request = ahash_do_one_req;
 
-	crypto_ahash_set_reqsize_dma(ahash, sizeof(struct caam_hash_state));
+	/* Compute extra space needed for base edesc and link tables */
+	extra_reqsize = sizeof(struct ahash_edesc) +
+			/* link tables for src:
+			 * 4 entries max + max 2 for remaining buf, aligned = 8
+			 */
+			(8 * sizeof(struct sec4_sg_entry));
+
+	crypto_ahash_set_reqsize_dma(ahash,
+				     sizeof(struct caam_hash_state) + extra_reqsize);
 
 	/*
 	 * For keyed hash algorithms shared descriptors
@@ -1937,7 +1972,7 @@ caam_hash_alloc(struct caam_hash_template *template,
 	alg->cra_priority = CAAM_CRA_PRIORITY;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
-	alg->cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY;
+	alg->cra_flags = CRYPTO_ALG_ASYNC;
 
 	t_alg->alg_type = template->alg_type;
 
-- 
2.25.1

