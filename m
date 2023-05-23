Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C370E0A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbjEWPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbjEWPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836B1139;
        Tue, 23 May 2023 08:35:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHMiKqtRkUshOyQpPQX7afFWYKVxIfviflPbTSSPGJA53HgYRUuxgLlPRMt2ZVzXr4RZWdNw2vpbRYO/Q/ocwbjmOdqOA64jIfiaBuMAemdXEwWlDQDO7haVW3gl4sVeKzgkaC4m4O6IaqqYhQwBL/6ljjTq/FdyQ4vgHX5sEEdtQOWFzQT7d1BV6ATUJAiSO3MCwpxE4BotJe4Pa0c+2ZDUKqmH9e5BNgptAOzbEQfXhwl8l07lo8lEZeq4FowiLDpwxi4Tobi+c0x/E4XpkCxKQ1mUHdVoeoTKNwZ5llO3SoxODHjE5aPBALcanZ9IyIHdK/qV6+rQ2c3oCdAMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWff3JRzv+TcPY5FBSukENdfI0kfOpnU9HCsjOMSzok=;
 b=QnjvlXT/cxapaT8QtUxXkjdvi19OhOgdwz+dGJxMaWe2jS7/bTDxFI9FGE91wXfX7uFOp/LgY1/+bh6zllo6z0+mF0aW1tfWbB9zJVtW6vSpimDd+qhLcbiBm6BMDrldVKyky9nMTHxizR8wojZPZYj9UJDS2JVgCNfJMRf+CimFRWHYMIzFyaocsdgTx8auUR0g40d444rgtomJ8x1jaZqo1QB8WXuZhkxmVAzz/ZyTrFgfylEHyLVXUYY/yHIcohdTBbUj61v96b25uv1TFo3K5bKmfmDvGpC35aJwhH3E3AGUVSgEEqXrmztOyFcKzyMsiXAVBDlOQxhFEJinog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWff3JRzv+TcPY5FBSukENdfI0kfOpnU9HCsjOMSzok=;
 b=nCwtxrWJCvu5lSgjxyPHvhqhWKrraYtfSbjGzeQmMOggOEfrjLkLGwNGab7bDgApkfZKg4Yu7/vxSFoWInXJ/7r3p9BRXi3k43dv9N5KKCmonFfnFnWIgdLOf1+PTQIOfIJZwgAAD9yXzhoIuLssj2+JsrQ5lFElX2cIvLhj1Pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 15:34:55 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 15:34:55 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 2/5] crypto:caam - avoid allocating memory at crypto request runtime for aead
Date:   Tue, 23 May 2023 17:34:18 +0200
Message-Id: <20230523153421.1528359-3-meenakshi.aggarwal@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9571:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 6486cd51-944a-4884-7b74-08db5ba341f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drcdE8/4F0Jk5gI9Xe+kVxJez7ftDYztFLAzXsv+/ZEL/32ktFokgphnV9RRBFZr+4m6USCJjQ/4JiQQb0wCR3wc/DKSJxASo5ydqX/C20YHBOQ79RjrNYVXbQ5AWZREHiU3nkhB6HrVj78KDOkj0DQTRi0fX6Eor7WOvm96FuIJz7U0wKURgFfCRldNs6KDXYuOE/gAe18VKXmPKgbXdb/f1+64e4Qad71wMZpXKF/kzSxkyn61ZV/woP0GaLr2vzgFYvCVtRcDYUmc95/eYcbQCuTEJimpLOv1TaRzlUkVjZCiiGnHC+Scm2USucDFEmmSCtdbzLbRn0Rk0DnzSSeWPgoDtQEZC5wv84HF++XDaDBQ4SLYrLu+y+9nIN1i0w8E9L0Q0FF+HXCkN6fSiaPFCEMa2b/154HznTP7uFI7mCCJLn6onQcgZbg8KS3q2YoiToqP4mpVToSBnp6P6AB7nZ8eN+WyryY79wsoJcLr6FBTkI1EjpH7fnFIug4JQVB1Vo83uUSrtOzARcUQhf5AVsCi1bOtfmneMSd2lKHUS7lXHzLOL42h+x5QxJoSRY4V2LFwOSmTOMi401gRkB54+RYuUjuvZrGDdPVbHLX0B8KQWKOjJCWem99+4NKY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(38350700002)(38100700002)(36756003)(86362001)(9686003)(6512007)(6506007)(8676002)(1076003)(8936002)(2616005)(2906002)(186003)(478600001)(4326008)(316002)(5660300002)(26005)(41300700001)(6666004)(66476007)(6486002)(52116002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kmfCDMEEB5jeo/DZh32pyqS2CMJ9VmuI4kkbzcXBSCyE2qayTwsg0HHdzecY?=
 =?us-ascii?Q?hup8NpDt25/viqsuA9XWjnzUnePAHBnVIZXD0GjXsfP87jbSU3pBnILY0X0z?=
 =?us-ascii?Q?KKOUSic1KfCpjFq41oe2wri7WTSlzW/Vgd3j4RgEHCZHYP+/RODQGzVbRdbf?=
 =?us-ascii?Q?e/qm3vHSgjJQUXKTCR1x99fmCrFWZAbuDR4l3nzge8gv7iiQYCMLSSvBCkRR?=
 =?us-ascii?Q?B8y54pYtJCMjyRNfKgMqjVpxZNCG9nXlWc9bGBLMmCClWt0wg+ySy4o+1KKi?=
 =?us-ascii?Q?HPhtOXkdiqzGuejhCp8sOE/vcJmE5ooELS72KfwWIUhEr9JnnaiObLTA0mzh?=
 =?us-ascii?Q?oK/bX6OkJTfMjpsZfQVOLxFnGX9sfcsRbRvRda1XQlglGiWZaeLsJb1FM5v0?=
 =?us-ascii?Q?pR4dTG/dkP5HXbjNWmqembhwazhAnEM3nzKZmWuqfyghJSAkMwpUZOyuV5k+?=
 =?us-ascii?Q?yPBDtlSKO8vjAUg/DxCQhZUMMybikoZvGxbPH6ShHqyRw9LL0JGX19TzLm5J?=
 =?us-ascii?Q?U3757wFmFso46axy3lZwAG4TuKzGtOtzskjWBeTifLt/V1tmVgxxgnE1EaN9?=
 =?us-ascii?Q?2+n1QFiW/+IKvxEOhVshtBOfPy3J3msjy5d1v6QTnMe/cuu6lnCq7uKvV5VK?=
 =?us-ascii?Q?4JFvumBjv9CyXH8BlCDRXmK7oeFHT2HVayo3GLdncVKk79ERLluQ+OhjXeku?=
 =?us-ascii?Q?SxR1p5Gm1GmS9AAplJanaXlbXIm6q0FyOOA+s+F/qvtWpGMuuUEuiwnI1fWj?=
 =?us-ascii?Q?mnc6Y8aSUpP+KcBwJ0M4RWWcBpxFE4BofQ+9er3i1B/1lUeCTWDeL7d6FWLV?=
 =?us-ascii?Q?XKCf2H3aEi7046vRaWXeMrZ38q5sOeRaMya3iZqCMwYdEt+joSlCTj0vIQPh?=
 =?us-ascii?Q?BHmFnKme1XXgNEV2O54F1dc/uK6d9ragmuUBBbxfRx2Sl4hNvZAXgj1RaVGx?=
 =?us-ascii?Q?BQkvY2/a00RHYYr5prk/rlPUu9chTGkJhQvi9d1VUc4wKW3vVCct1g4retur?=
 =?us-ascii?Q?xbh+MUGZ0zEnTNIplXIUUJedaNCWRMItfAdLWnQpXeEisOl1gQuc3xff06L1?=
 =?us-ascii?Q?waJvCiRUyz0ECjn4y5jgh+VNzqOKJvxQW9Ov+e0PRwHc3nrf4io/gq3jplFP?=
 =?us-ascii?Q?bUofQjdmeX/OnFy02/+sJ3PsEY1Q8myaQzHlXZhnYb/v73nK3Ah3UPwswdIV?=
 =?us-ascii?Q?GYFQWVYY73yknbZvMHGuc05ISFN+/bbzRnHLN5WpGqNTb8e3WZv7yGAO4MuY?=
 =?us-ascii?Q?hkDPUKIs4pkVtLAwUfqdwNl7cMmhP3W9jhEI6C+gn+l1SijjGiTGl0jQUsFq?=
 =?us-ascii?Q?qDHv4tpQckUpeTYyc37bWI6dQQjxoWSLRoWQPXdM7E06QaLDpAc+vMwT+371?=
 =?us-ascii?Q?o4VsYbIJnM1+5WpJ4HJySyc2OP5GHBE9AjER3SEraJ5b9tlgh4LXSEEWQGas?=
 =?us-ascii?Q?63CosIEWj2ZohNkgVS2H/gcmShUPDEWJag5FjSDyKVfCvjhjNO6YQFJJrc4E?=
 =?us-ascii?Q?g7Jfvcu24v6x5QIN9RRGzRox7hw8tM1IxwDMMYZIfPxVM0MnpZpEYjIQRM4X?=
 =?us-ascii?Q?XXaNmHs1lbiRsTLTROuIyR3jCIzquAgRL/qoQLfo4Rb4FzVjmp6Tzoe9ojDZ?=
 =?us-ascii?Q?4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6486cd51-944a-4884-7b74-08db5ba341f2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:55.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3O0g6jR2J049ywZuEhJMauvelywoDJxIlJGpCzKRYb09fQMPSvEZ3LA8ou45NQf27qqZp+J4cLB4IhZq5lMbkBcsOojuh9NyO9wOHQOX2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544
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
driver (caamalg) initialization and saved in reqsize field
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
 drivers/crypto/caam/caamalg.c | 69 ++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index dbc5d5eaf695..dea2a32f2f25 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -886,6 +886,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
  * @mapped_dst_nents: number of segments in output h/w link table
  * @sec4_sg_bytes: length of dma mapped sec4_sg space
  * @bklog: stored to determine if the request needs backlog
+ * @free: stored to determine if aead_edesc needs to be freed
  * @sec4_sg_dma: bus physical mapped address of h/w link table
  * @sec4_sg: pointer to h/w link table
  * @hw_desc: the h/w job descriptor followed by any referenced link tables
@@ -897,6 +898,7 @@ struct aead_edesc {
 	int mapped_dst_nents;
 	int sec4_sg_bytes;
 	bool bklog;
+	bool free;
 	dma_addr_t sec4_sg_dma;
 	struct sec4_sg_entry *sec4_sg;
 	u32 hw_desc[];
@@ -993,8 +995,8 @@ static void aead_crypt_done(struct device *jrdev, u32 *desc, u32 err,
 		ecode = caam_jr_strstatus(jrdev, err);
 
 	aead_unmap(jrdev, edesc, req);
-
-	kfree(edesc);
+	if (edesc->free)
+		kfree(edesc);
 
 	/*
 	 * If no backlog flag, the completion of the request is done
@@ -1313,7 +1315,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	int src_nents, mapped_src_nents, dst_nents = 0, mapped_dst_nents = 0;
 	int src_len, dst_len = 0;
 	struct aead_edesc *edesc;
-	int sec4_sg_index, sec4_sg_len, sec4_sg_bytes;
+	int sec4_sg_index, sec4_sg_len, sec4_sg_bytes, edesc_size = 0;
 	unsigned int authsize = ctx->authsize;
 
 	if (unlikely(req->dst != req->src)) {
@@ -1393,12 +1395,30 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 
 	sec4_sg_bytes = sec4_sg_len * sizeof(struct sec4_sg_entry);
 
-	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = kzalloc(sizeof(*edesc) + desc_bytes + sec4_sg_bytes, flags);
-	if (!edesc) {
-		caam_unmap(jrdev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, 0, 0);
-		return ERR_PTR(-ENOMEM);
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = sizeof(*edesc) + desc_bytes + sec4_sg_bytes;
+	if (edesc_size > (crypto_aead_reqsize(aead) -
+			  sizeof(struct caam_aead_req_ctx))) {
+		/*
+		 * allocate space for base edesc and
+		 * hw desc commands, link tables
+		 */
+		edesc = kzalloc(edesc_size, flags);
+		if (!edesc) {
+			caam_unmap(jrdev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/*
+		 * get address for base edesc and
+		 * hw desc commands, link tables
+		 */
+		edesc = (struct aead_edesc *)((u8 *)rctx +
+			sizeof(struct caam_aead_req_ctx));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
@@ -1431,7 +1451,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	if (dma_mapping_error(jrdev, edesc->sec4_sg_dma)) {
 		dev_err(jrdev, "unable to map S/G table\n");
 		aead_unmap(jrdev, edesc, req);
-		kfree(edesc);
+		if (edesc->free)
+			kfree(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1461,7 +1482,8 @@ static int aead_enqueue_req(struct device *jrdev, struct aead_request *req)
 
 	if ((ret != -EINPROGRESS) && (ret != -EBUSY)) {
 		aead_unmap(jrdev, edesc, req);
-		kfree(rctx->edesc);
+		if (rctx->edesc->free)
+			kfree(rctx->edesc);
 	}
 
 	return ret;
@@ -1552,7 +1574,8 @@ static int aead_do_one_req(struct crypto_engine *engine, void *areq)
 
 	if (ret != -EINPROGRESS) {
 		aead_unmap(ctx->jrdev, rctx->edesc, req);
-		kfree(rctx->edesc);
+		if (rctx->edesc->free)
+			kfree(rctx->edesc);
 	} else {
 		ret = 0;
 	}
@@ -3450,8 +3473,10 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 			/* link tables for src and dst:
 			 * 4 entries max + 1 for IV, aligned = 8
 			 */
-			(16 * sizeof(struct sec4_sg_entry)) +
-			AES_BLOCK_SIZE; /* ivsize */
+			(16 * sizeof(struct sec4_sg_entry));
+	extra_reqsize = ALIGN(extra_reqsize, dma_get_cache_alignment());
+	extra_reqsize += ~(ARCH_KMALLOC_MINALIGN - 1) & (dma_get_cache_alignment() - 1);
+	extra_reqsize += ALIGN(AES_BLOCK_SIZE, dma_get_cache_alignment()); /* ivsize */
 
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
@@ -3487,8 +3512,19 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg =
 		 container_of(alg, struct caam_aead_alg, aead);
 	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
+	int extra_reqsize = 0;
+
+	/*
+	 * Compute extra space needed for base edesc and
+	 * hw desc commands, link tables, IV
+	 */
+	extra_reqsize = sizeof(struct aead_edesc) +
+			 /* max size for hw desc commands */
+			(AEAD_DESC_JOB_IO_LEN + CAAM_CMD_SZ * 6) +
+			/* link tables for src and dst, 4 entries max, aligned */
+			(8 * sizeof(struct sec4_sg_entry));
 
-	crypto_aead_set_reqsize(tfm, sizeof(struct caam_aead_req_ctx));
+	crypto_aead_set_reqsize(tfm, sizeof(struct caam_aead_req_ctx) + extra_reqsize);
 
 	ctx->enginectx.op.do_one_request = aead_do_one_req;
 
@@ -3557,8 +3593,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-			      CRYPTO_ALG_KERN_DRIVER_ONLY;
+	alg->base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY;
 
 	alg->init = caam_aead_init;
 	alg->exit = caam_aead_exit;
-- 
2.25.1

