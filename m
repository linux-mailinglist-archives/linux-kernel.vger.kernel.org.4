Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D6729729
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240093AbjFIKl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjFIKlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:41:19 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978E03C21;
        Fri,  9 Jun 2023 03:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2OWato2UAs6UjJI8fVhRs+LhAWX1hO7UUaUtq9NtOhx6oow3MAzcRFVO6wX4vm9OpTS4K5r0fYwy+eAOf6cFLCwEe7jDzDQYLmdUEuVJj9cqtI6Vl4t6juZiQg3+3Ms1/l+yOFeiuXnJ9K1/tkQaXrDNmhEeRlJCzA/NYZre5lzti3cx8dCQ/ZUkGqnZSCYwlzB9xbehN0rn1rVc+T3za1xBpZKattP9PM+24dNDFCMD/DJpxhZKra9eN16gsxa9yl36urzTetPSX+wbpu+0zpEaBSy00jakW7YefwDvUBaGWb8fLBaDnyU5+j2yDl+/g/4FJyTFuS0v3GRkZKSyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdND22cx1GljIQcqKTFXZorRGHDlelWRNsDEt1JFTr8=;
 b=c4TRByrdE3EKaXX521WnytvBwBdu1ULKr9I6wkLm98e95CDvnz5j6b2L1dpaVG/T+lZ0NYsn3gHrV+Gphn8dQETBFT0caApAsEecId2U2P3d7eNwLPmpthV48Q8WBSSWTXGiW7GDlKloS8SpUZ173VsKZ8rYmA3C017THiIWOOfHPSsNaCQKfMAbQZujWsAN5h/M6NqE4U0MIy8IfjHhRFpW2O/e2MD+GK7LH4vloPsuCW2Ac/s+6oyLMWfHw0DIbCLTaHGPz7DvtF+N3bUx/qkbOyTSIgUHvtxaqw9GbwIO3ZpN5ePvknyRmisb30XAbeT03bVe1+eDCel1cxFg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdND22cx1GljIQcqKTFXZorRGHDlelWRNsDEt1JFTr8=;
 b=k3gE2+m/5F3fyGAUs5eRXq7SjdDe54BwRI7/Z53YoAXovu5dMrJ8IcOkFyCQiCA/yjuyDtyr1wBwkQwC8V5YYWLsPQ/CnbLnQiTHVhhsu1Y4LYjDpR6zioR7xqAn4zKxjkYgLK0deyCbgW1JL0oe2vGUQJQVQ8pXNgyjChJF0SU=
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
Subject: [PATCH v2 2/5] crypto:caam - avoid allocating memory at crypto request runtime for aead
Date:   Fri,  9 Jun 2023 12:38:39 +0200
Message-Id: <20230609103842.4159321-3-meenakshi.aggarwal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 632b7eb9-42c1-41b1-d563-08db68d5bb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggFZ+F7J4wPVrQvQ4smozh8RL1F2Y678dHXDDnLATsWHDQKozQt2iu57u5NCudWcV714I81sWiFBt47rwHrzt7a1lEf94pl42GKlR4LaNfSEn+gJykp6eUYpuftd/27vs+14c7he8KWXUCD8bhAG8GFcZ13R/Q7yPwx3krBnNQHFSuMfBJnUlMloKw0gJNfFr5ZT+65pzpntDr+UUFMmvN4E99toVOgViNQX56e9IvpwnEbtzXI/Mrq31ZOJrVm6eKgFYC3DXfgz6cYJE7peNkUTgXoUsf8hAaUqVGEza4hGNbDO3bxOrxhH93wIgbcZP0ab4NWd8DLSJAY+8eBgAWNA3BGMN/i+V5nOFcxU9TgrCKS6UqGFwVRaq80Hb2GvbWjxKr2qSJLTvj6lh643vTpZ80bBVz9EH9DFC81B/Kio2fuUxZQ6PQ8UHqpf0G3W5UysZs038/8QK8RKq3Dy1ZUKQe8XGkjvigWcoRnAExdlBAHDtnHlxocAicSA5+Djiz/7Eo/HUugxYBGiVvgh3aQv0Xq6NJo36IYFggwozywLRIqJag0dvPzyiDKNwtEdALBVoenas8DNbwPhjyiHhGupQghDycLlcrWwGSQxR5fHm29X1wZre1vdueCg/tJK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199021)(66946007)(66476007)(2906002)(478600001)(4326008)(8936002)(8676002)(316002)(41300700001)(5660300002)(66556008)(6666004)(6486002)(52116002)(9686003)(6506007)(26005)(6512007)(1076003)(186003)(2616005)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/DWWsJPCb9ZkiBifC0jZU7rqir0V+H7IUw6fIamS5v8iIL61j2/2O2nhI9Z?=
 =?us-ascii?Q?SjaULY+9ttDfnIBHc31svMx6QHcyFYIc8F4UHGQO7Ly3CAsclUUvCrY1Cjxg?=
 =?us-ascii?Q?QttDENCt/Hb+VvDosybTzcNPXWEo370lHJ7SxMDnXFYdUz052Eq/Utwq/5Vy?=
 =?us-ascii?Q?s9/K9kV7/f0BUUokT5kOkc57NRyofR7GvnV8/LzwFC4VYhIvxTQZus7A9Db2?=
 =?us-ascii?Q?63acWVFSv7panwj2ONuqM0usMDc26NwWsJ/rMcZqQO+aFGrFM77ovhqkSw1d?=
 =?us-ascii?Q?feBhKMT8I0p/JDYeKS/u98/N9AWnntX4O8M1TqU2CMA61V9dXqZJPaLDaeVu?=
 =?us-ascii?Q?tSWy5fmrWooewDKwjcEawq7ttSJ54l3bjl04Kbad47p/1M6NVWcuYvESMgrq?=
 =?us-ascii?Q?XyZOfOAwMUMdkIw/oqy/BGHRZa9KUSrGx9VkU9SwGJF//JSOaxotEtJbmDuT?=
 =?us-ascii?Q?h8OPmDq6QgoGGWW4/5FNc9Z0aIU2WsfgaG0z1fD7lqQKO3btHGMVVUJMtqrj?=
 =?us-ascii?Q?wgRNgQC206J3Yn1rXrqgl8C1BhDraisGUzStY4Lx+BICl8ZsuSznat/BRvoM?=
 =?us-ascii?Q?ZPzXyKgi1jIicj+8m9nxVF/6Ym1Rxg+5hSI/EvvjgM3tHNHi+YJgka5zpW6I?=
 =?us-ascii?Q?ojJPQMAtfL9rlOuhd9j5dSoqMFWZ9tStjHkT2EWv8TZg3Zn+MvNPBCPoZIMZ?=
 =?us-ascii?Q?7QmH3Pz/Ej2Jqd/o91I1GFHY/S4uzQvKos98lNwf3aOuXeI5GHKOPhjVhFAn?=
 =?us-ascii?Q?RmtEBRElbwDawlcq9Lc72S/BTHjxUjJRjykk/4QMxMpi1fDYtn0wkSuXXkjS?=
 =?us-ascii?Q?umGKBCX8vp4itrnGNZXrE6i0/AzLaSs1KtVVKdEfzPhpt8NIxgU/EhV6kR5k?=
 =?us-ascii?Q?qzbDf9EVrR9WbZSv6YXaGRyAHZztZwHH+2qJHuFFHZ/4zs9j/gcm5tvO3GEu?=
 =?us-ascii?Q?3cw2rI3/VYZer5oU92wj6VDL6MXSB1NdqxqcvygliCtLDsVZ9SPTKq7Xm3gf?=
 =?us-ascii?Q?HvU5AE4zIypmZW9YkhuW7E1H6wQA7mw5Z7MOIONKlgSMWo7GvGIHRo71sIKW?=
 =?us-ascii?Q?kZuN6/XSjnrQPlLIVnQJiczX+UxrGHXQXL0WFq3G8cbswVUxreurnnQCp2kz?=
 =?us-ascii?Q?GGYOIw5FKn0U/ob/oB8/dXDBqpX0MWmjUs6+nrglR80VmV9dKFZ/WWbTpFaa?=
 =?us-ascii?Q?Q0pbSKH21HjazeqyiHqpcefRNE5CQL5AmDUbR14Ssx25pEzhs0W11wl7WTj/?=
 =?us-ascii?Q?BFyMAuA+SyXkQHGeF9iXV6DQWVu6imkGO5AosgjjqVef5OAbKltpWDRIfeUj?=
 =?us-ascii?Q?Mb6UPfQUa6+lMiAe4xGs+iuUFzqz6D66wPZBilsSAufWEsWoBooMGw7EFvmz?=
 =?us-ascii?Q?VWzIy43EOPl8b/hO1INzGPtF7YYy26FSVypuM3awBrAh6I381wSpU0CuHDbb?=
 =?us-ascii?Q?nWlPGa4GY8nX41oGKJ5R9V/t2uZTNWwkV/luDGhgwQgJ/afH44ojUfRi6qXc?=
 =?us-ascii?Q?DEUmin/FsLQgrWtgJHrbQgoD9VbFX3mcgQWoyC4sbK6638ulEe3D89q7lgHb?=
 =?us-ascii?Q?HsZX3V6LQmQW0Ca+qlfGZPDPB31yojATZrZfJSsATYCoH4g44h9t8V3tUXHf?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632b7eb9-42c1-41b1-d563-08db68d5bb00
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:38:57.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYXNdH+ikMu/5kXwsVT6vmeXDFCBiGDxvzCownM6VpQLcz7Z3Fjwk5OvKheV4vO135Eq7rYuayfAy+z0BCoy+EfZNt+askbte4XeUNSwdtc=
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
The extra size needed for base extended descriptor, hw
descriptor commands and link tables is computed in frontend
driver (caamalg) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

In reqsize we allocate memory for maximum 4 entries
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

