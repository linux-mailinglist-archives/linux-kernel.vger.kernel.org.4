Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1DC729727
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjFIKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbjFIKlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:17 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C953C1D;
        Fri,  9 Jun 2023 03:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1TQf+0HLhHbGrK80gP8LiX1g4GIcjWITIPYvhUoyYlXeEN3emFjYEwvkKC6qC3JlcRhJDX/40GGJJkanyHDl5zX4eob3al2iQ9WjjMDqCrTyItUnzurX/zfAX2St1qE5bbuNiN/4imokxUTDf8BohnlUHSLBqmDezxpnwise0wuaXbbG63paegGN9LOWLzb8uf53THxulCn/3tVcY4T9S4NfzK6oYzqM0RC3OsxCTpa3YC6RRWrBpUtQNVFMRyKhHL4cc7qqcw3lXjBsIRIRAUXfUnzhhXdCIc1bVRK6P24AFD0NfnDRN7w/cXSzeLByEjiKoASP9gTdZppTIuaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruc90nzjtmSoMWJJMZQ/qH4qs3sixuPIMnUPjUCbDKA=;
 b=YztW2MuwxoiTrpp6RsPOj+7uSbIUmzyTeaJoUNNou/nbe8zVIm2qz0DrgpT7d++aQNVKSdOHVOMW0teLA+rSUe14cyoFeJ3btW1T5F0um0j+b16T2YNR98IcANoe5T1EqcoHe0i14c9YsfP2kcA7HUk4r7+3T7/vtx79/rerS++soH+6eN21+lrQb92DT5Zss/3iUx1gRiJ3JY6vcuWCNgSg/5QX8RlvzvDlSTSmCmxBiTaCxym2BMG5RdqPtHMFzKjIs+PtJXG/MaYCyLcUDyEC4GloYoMZfXeT7N5FVkmjv3r2pHSqP9nKoC9bDhccxMQ5vwf8NX4ejhSF6sYvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruc90nzjtmSoMWJJMZQ/qH4qs3sixuPIMnUPjUCbDKA=;
 b=sg2fkY/TCz9bZruM8vRTYJdr46lW7o99wSlT174d2lZow0Z4a10nP8m+iyvt6UsvhJBMaLVv4fcJfHYDa5DbaMEase2nUhrhy69ASFTghvaczhIl/xtGaTzPPsKpQtMdKsRHIprJ/hEwpJm6IyZ3ifw66N4o8S5JCO8K5FKHAGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:38:56 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::adc3:90c7:4b37:392c%5]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:38:57 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 1/5] crypto:caam - avoid allocating memory at crypto request runtime for skcipher
Date:   Fri,  9 Jun 2023 12:38:38 +0200
Message-Id: <20230609103842.4159321-2-meenakshi.aggarwal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: cf80d02f-49a7-44cb-1903-08db68d5babe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1LBMPAe0SX/gWoRHujCqcFkWamc0HvsuJv9yW0K4uHxm2noI5ZIc80tynIzhdRFjUuoW6XO0RuPr4N7TpV75G2URfZ/yCBQkkC30n2LUP+kDlMp3oLFGIrxDR8qRxgGjIpzNOoRGLrqDVIGW8HsQjwX3nn+EO0xYpDK6H37O4rRaBw6Yq0zL+EKXCDjEntgxHKOtNQtscs3j7OIaYD1L0IlR5XcJ7DyTqn6PF/o/HH6NfDY1Mg9t1D+Y+XRu5ZJLtNOVItRkkw15FxIVrpSkrI7n2whAz4wfoN5QSvGFjqo9cK5Mss1L7RGz+bE8NaTcXDbiToTlpRYW/TTN7+pGqP1+nGr5A+V/bY8ezmkCfScgIGJiUJxHXL9fJcp94USHl/gh15nN1nTIvdtMNtXCw5CjMESqWM5pDjEJkR8yVvWlebr0r+DZkR00rqwhxrwJGoaSVJzH8YiLqlm8OUNeuQkttANN1DO8w1fQ8fe1CUOr8RW5ZCncatnmLXfclynqfqDpGDn9w+UB0AMfeBV1SkGge/3HfPeNHKVrkkm/vcApM4IDnfKQTXVUU6VlVFiWodpYsIShsnmXbJpSfWuCAG9Hd8L7VS9+G9tCyplt3iyRcukp8WjvCijwmUEEkCT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4FetQNqpsiOaPj17juQsZjJFOZrTQXf5fryW1p5BQFDwk0S4mBjXr0jz+seg?=
 =?us-ascii?Q?yijVyZADI+wa1hFmNJvgg47XlkD2OyZ0dnUSEiNl7nyVbrzaWHKiwbvqgXHp?=
 =?us-ascii?Q?0AcR+mOeDzXbk+KBIXHTbJF4FyBtPFX8WNL5KzlgH8bdcvp5gqflwgU8G+e6?=
 =?us-ascii?Q?+UOkpK9VP+Aw0cj47SX9i+LrRkIvwD157ThYazuf8u7qkgTwmdf21q3/L85y?=
 =?us-ascii?Q?voPZ6W6jJ0SkYHY5U02B1NE5WW45RbOJP1nbP/v57fWaAW+HrsbMQtMMCXT8?=
 =?us-ascii?Q?vd2uS5Z32O9pgRtBxtlnB8f3+xFuDWX2pQNSrroRjdLOlT6UcNBBuUDPuWMn?=
 =?us-ascii?Q?x7054WLRjtpklH5enL9WUTNO/ceqYDx8QxaQus0xTGA1jld40vsXZvf1k3Nz?=
 =?us-ascii?Q?yLUoh54REn8Y2sE5+AyXEsKx6CvjwuhxtSqH1fEUysXPkFy3Q5VfwMXmTI5Y?=
 =?us-ascii?Q?fEH/Q3WkznxREWCfc6kTaoC9iW9LMKTYP24HVjYEdKIE6fGubxKfuYjOl3Zy?=
 =?us-ascii?Q?9aREjNVkGRz0rnxvQcF0gThaPO0SZ2q+R6mNN36BvR3g1DzQ3PRpzFe6Wh8H?=
 =?us-ascii?Q?UpP1Boi77Eqs73D4lCInc4QTGYVBQFsBaHB/0mzWtMGsWQ/WiGX411QWFRwZ?=
 =?us-ascii?Q?rizFvPMP6Xs0yRvulyouvYIZxj3HLevaBFPnOIRe7Ennremk5LN2LBovDWIi?=
 =?us-ascii?Q?GsYIyzHwBxdgqCjwBTKrNyg5smFl1OtHY1UlPvtOLj5fEeAPaT1zrQPJamef?=
 =?us-ascii?Q?BG0tG6bkM/d0/dv2kp+T/nPGISzDrc+1u71+fjSr+v82eTCggx6YfNNNil8c?=
 =?us-ascii?Q?eqFdVRkHcSB9Z5Zi5dfPbmlTbDZCwHAekvvSrViJAtNo8GnamYnc5VY8/86Q?=
 =?us-ascii?Q?H3nFdv1uNTzSBZ5zG8OmO2wswVivRiOxHuGG1MRTnUOTmtcbb1B2gGIpleVl?=
 =?us-ascii?Q?9+BzBq9wd9E3E1W/SPBP01SfHVLAlhKWZLYTNF62UFsQfNrFqAyWx9SAqt17?=
 =?us-ascii?Q?jdfM0Klcb2faIxGDKw2Mk/KMBz14wqP/8IOBFUnpcF2lh1DM5ljIyza9/lS9?=
 =?us-ascii?Q?qo8ERMcCunTLqtD5aJWd9N86OzmLMKbnDLA8BHfcRHAqo1ZvZdrKYi3aMZzb?=
 =?us-ascii?Q?FxfqjmfImMn6GJV2P/BBkoSS2zygEWClPw+Csi20tHSS2vSQq60sWTbGxRi2?=
 =?us-ascii?Q?iMYX7Qv5cuOpSKFVx+R0QWn6Yhh34ggtlVFABU0AbvuqNemfa+DJNse9GXXI?=
 =?us-ascii?Q?u9cjd6aX6hYVY4xjbd5HigEZvTBhaupgFnLMjLe1PiRpk39xJw1HrTEbUSwg?=
 =?us-ascii?Q?o8O1b9hS+imFxPS09YHoXWx0s40Mnh//GqRlZa7v/BaX3rb6GNRW9LIeaDkr?=
 =?us-ascii?Q?JB9UKEspZY5yzY8yvJ8vKqSR4WtZhzbxnpBXIXd3wcQGgdvgN+cMo0L5OnLQ?=
 =?us-ascii?Q?Uq3z+hquMtXKk3rR/Hf+8MhRbK2jRn7vhKhO6InTaWu5vui/oPxszV9o6Aog?=
 =?us-ascii?Q?hMYs/kMwSvg/VruZzv4KDtD75kPzZ3Jalrl4ZG1cPbiHA9wjPOEIEe3P5MAM?=
 =?us-ascii?Q?5clKFGW0NKcQbWVU5HbBYz1+d/Z+UnZldltQDzlZsmIN49ZeYHVmnPx8EA93?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf80d02f-49a7-44cb-1903-08db68d5babe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:57.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8/iYIBnF9kFRh0sISkmrGMkDndEDiNj5olD1q6qxw4drED7FwYjiB9HYSJrlOXkqU3CwrbCYWcqabB3pgiA3ql3OVJX3Q/b7jP02W4bI8A=
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
The extra size needed for base extended descriptor and hw
descriptor commands, link tables, IV is computed in frontend
driver (caamalg) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

In reqsize we allocate memory for maximum 4 entries
for src and 1 for IV, and the same for dst, both aligned.
If the driver needs more than the 4 entries maximum, the memory
is dynamically allocated, at runtime.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
---
 drivers/crypto/caam/caamalg.c | 73 ++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 19 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index feb86013dbf6..dbc5d5eaf695 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -911,6 +911,7 @@ struct aead_edesc {
  * @iv_dma: dma address of iv for checking continuity and link table
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
  * @bklog: stored to determine if the request needs backlog
+ * @free: stored to determine if skcipher_edesc needs to be freed
  * @sec4_sg_dma: bus physical mapped address of h/w link table
  * @sec4_sg: pointer to h/w link table
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
@@ -924,6 +925,7 @@ struct skcipher_edesc {
 	dma_addr_t iv_dma;
 	int sec4_sg_bytes;
 	bool bklog;
+	bool free;
 	dma_addr_t sec4_sg_dma;
 	struct sec4_sg_entry *sec4_sg;
 	u32 hw_desc[];
@@ -1049,7 +1051,8 @@ static void skcipher_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 		     DUMP_PREFIX_ADDRESS, 16, 4, req->dst,
 		     edesc->dst_nents > 1 ? 100 : req->cryptlen, 1);
 
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 
 	/*
 	 * If no backlog flag, the completion of the request is done
@@ -1690,20 +1693,35 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 
 	sec4_sg_bytes = sec4_sg_ents * sizeof(struct sec4_sg_entry);
 
-	/*
-	 * allocate space for base edesc and hw desc commands, link tables, IV
-	 */
+	/* Check if there's enough space for edesc saved in req */
 	aligned_size = sizeof(*edesc) + desc_bytes + sec4_sg_bytes;
 	aligned_size = ALIGN(aligned_size, dma_get_cache_alignment());
 	aligned_size += ~(ARCH_KMALLOC_MINALIGN - 1) &
 			(dma_get_cache_alignment() - 1);
 	aligned_size += ALIGN(ivsize, dma_get_cache_alignment());
-	edesc = kzalloc(aligned_size, flags);
-	if (!edesc) {
-		dev_err(jrdev, "could not allocate extended descriptor\n");
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, 0, 0);
-		return ERR_PTR(-ENOMEM);
+
+	if (aligned_size > (crypto_skcipher_reqsize(skcipher) -
+			  sizeof(struct caam_skcipher_req_ctx))) {
+		/*
+		 * allocate space for base edesc and hw desc commands,
+		 * link tables, IV
+		 */
+		edesc = kzalloc(aligned_size, flags);
+		if (!edesc) {
+			caam_unmap(jrdev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/*
+		 * get address for base edesc and hw desc commands,
+		 * link tables, IV
+		 */
+		edesc = (struct skcipher_edesc *)((u8 *)rctx +
+			sizeof(struct caam_skcipher_req_ctx));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
@@ -1725,7 +1743,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 			dev_err(jrdev, "unable to map IV\n");
 			caam_unmap(jrdev, req->src, req->dst, src_nents,
 				   dst_nents, 0, 0, 0, 0);
-			kfree(edesc);
+			if (edesc->free)
+				kfree(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 
@@ -1755,7 +1774,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 			dev_err(jrdev, "unable to map S/G table\n");
 			caam_unmap(jrdev, req->src, req->dst, src_nents,
 				   dst_nents, iv_dma, ivsize, 0, 0);
-			kfree(edesc);
+			if (edesc->free)
+				kfree(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -1786,7 +1806,8 @@ static int skcipher_do_one_req(struct crypto_engine *engine, void *areq)
 
 	if (ret != -EINPROGRESS) {
 		skcipher_unmap(ctx->jrdev, rctx->edesc, req);
-		kfree(rctx->edesc);
+		if (rctx->edesc->free)
+			kfree(rctx->edesc);
 	} else {
 		ret = 0;
 	}
@@ -1863,7 +1884,8 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 
 	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
 		skcipher_unmap(jrdev, edesc, req);
-		kfree(edesc);
+		if (edesc->free)
+			kfree(edesc);
 	}
 
 	return ret;
@@ -3415,10 +3437,22 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 		container_of(alg, typeof(*caam_alg), skcipher);
 	struct caam_ctx *ctx = crypto_skcipher_ctx_dma(tfm);
 	u32 alg_aai = caam_alg->caam.class1_alg_type & OP_ALG_AAI_MASK;
-	int ret = 0;
+	int ret = 0, extra_reqsize = 0;
 
 	ctx->enginectx.op.do_one_request = skcipher_do_one_req;
 
+	/*
+	 * Compute extra space needed for base edesc and
+	 * hw desc commands, link tables, IV
+	 */
+	extra_reqsize = sizeof(struct skcipher_edesc) +
+			DESC_JOB_IO_LEN * CAAM_CMD_SZ + /* hw desc commands */
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct sec4_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
+
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
 		struct crypto_skcipher *fallback;
@@ -3433,9 +3467,11 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 
 		ctx->fallback = fallback;
 		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx) +
-					    crypto_skcipher_reqsize(fallback));
+					    crypto_skcipher_reqsize(fallback) +
+					    extra_reqsize);
 	} else {
-		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx));
+		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx) +
+					    extra_reqsize);
 	}
 
 	ret = caam_init_common(ctx, &caam_alg->caam, false);
@@ -3508,8 +3544,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY);
+	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY);
 
 	alg->init = caam_cra_init;
 	alg->exit = caam_cra_exit;
-- 
2.25.1

