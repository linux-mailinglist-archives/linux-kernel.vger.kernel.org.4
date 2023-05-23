Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11570E0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbjEWPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbjEWPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:09 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625EEC4;
        Tue, 23 May 2023 08:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLmfTBgrxB8pE8xon5rR2KmDlSKgdqfdJ3K8fQSHw34fc3AWSf5kTzQTnLOMIucmjgB9c/IAEM+TAfBOpbasZNdgWgwEzbFpBmjUa0TYdBRD0++1wfyKNASDBdtAduADnHdR4EwEAw7mRfvfLeatXEa6oXxz31UlzI8KfXT8e0P9g7aKbC/FyBIZnB3cUQe6siccBau6twnDcUPI6rA8RsLFHWWxt8QPPkk5cbTO6MgCDT2L/vxuzipRZq4kA+X3TbTx4hsWGbMZjuCQ8BWPwiUl0pvBWoOwd5P1yd6CZ/D98Z3w63cbmUibLePLdEgz29Fdiq38neQk8I38CmscOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1CRUfDyIq9V+N40XewrDJcqIvsAj8oSwwKFkjXRNJU=;
 b=aPcD2nIIofn0M2Nwhj8Ujycmtu3r2k76B6xM0sfC1H3nicOzlYwnbY0ABRYgeovqmiOsGJXuwX+kC9anMKmUOv3JfpZAexSAIa3THRk8E7/F+5qWxGmn19SMFXHjXUEdJXPcN85Oq1PcYNYsZ7iOuui4U42TbxO5Bn6JjVXRcyzp1zgjcRMvIpdWig+CV6elkY7zl4TX8hPib9SxUnyKSMfzmZNBWDiYjPOfmWnE3l7dW/y0PorO3SxeoV8UEugem63VQTcH/Su14Z6mmixn27/V1QYuLjAaNwlger3SvMLO9VgBrbVoXkE2AZPSM/e9N2+ik7wUpMdF7QVyBWMekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1CRUfDyIq9V+N40XewrDJcqIvsAj8oSwwKFkjXRNJU=;
 b=lhh4BQ2zOIocRakj/UpaKbe4p3Fj9zPgP8cMDADV0kZis8u9pby1K1xq7EVFsfpUZJsyAkvMzjJ09mKTBuiX86x0JTU7NUt4RKQNOcq18Xj67Ei/cLnXsyV5GKtw20EDZNg7REo/WxPfuB8N0fVnqC22yMCsd4bF7m7YemNEouI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Tue, 23 May
 2023 15:34:54 +0000
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448]) by PAXPR04MB9571.eurprd04.prod.outlook.com
 ([fe80::b082:c033:f721:d448%7]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 15:34:54 +0000
From:   meenakshi.aggarwal@nxp.com
To:     horia.geanta@nxp.com, V.sethi@nxp.com, pankaj.gupta@nxp.com,
        gaurav.jain@nxp.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, iuliana.prodan@nxp.com
Cc:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH 1/5] crypto:caam - avoid allocating memory at crypto request runtime for skcipher
Date:   Tue, 23 May 2023 17:34:17 +0200
Message-Id: <20230523153421.1528359-2-meenakshi.aggarwal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c21474dc-ac13-446c-5ed6-08db5ba3416f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TqCEE98vQN5MZfWRGhz3iy0Rp0wav4vnU+z+5rHWQ2Ke+xdTytQV8Ke+cHmKpQS3rp4ZMUa3zGa97jZi5OIBWjqW0ImkC1sN5sq+C3rACYw21TZGQ3KBjk57DhTVxXF4PLQV5f/mMqTawf46C/7LeHyJNdRPn0/wKSm1pG/8Ro2e2MF6ntOLXND/Tm14nLcyQjbMVQPVcDJ39wiRLHvjzn3gti922+FX/riC8SReJJj9rF5vN7l63rsq4XE4ifUwUWsb2Dfvbf5d9Mn0gti8pzKV0tDDT/q5+m1fSrYD6GeH0RkoMkcDzZ3By17nkXrl2Rmr/QtKB4ovd0R51gvrmJyTC+WX4BX/dMN2a/AuJMzokQitFjiDAVT0lAgNKTYSUC1h/Hui4vfsJ+Zvm6IsQfloX7Ap4r1oX/WOL7AXBYO6n+9uu2B4h8hU2Bc1gNE+qCB6AgxleTA3SmpKpn9kFfXnf6EfdN47i74MkmvSS96nIOx+dtWp4sLSfxnVugT7zbVOk2rBjMdlBJWz7ScrI6ZVNlR3fPgrING8ffZ5+AUtgQksFNdPAmhnOA+rszrw9CWgc1qC4RBAIGldS48w7W5x1KIaum0EV/qAeXRUuQBp1JWq5uTBEbC+byitZQZV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(38350700002)(38100700002)(36756003)(86362001)(9686003)(6512007)(6506007)(8676002)(1076003)(8936002)(2616005)(2906002)(186003)(478600001)(4326008)(316002)(5660300002)(26005)(41300700001)(6666004)(66476007)(6486002)(52116002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KKMfb9k7VVOcmI3OjCIL7NRiRCc32iUkjt1Gwf9VbPqGqPoW6om5bg18N4D8?=
 =?us-ascii?Q?lHSgaJdbS2QvwwC+YbP26fMNsfNqsGUzffloAx2nYAXnmb4+iw78Is16BhwK?=
 =?us-ascii?Q?RPexa3T9M1g1U9fQck3SkkcndvnlLsUfrJ+jFlGE9PsBmgZonrXExUr2IB68?=
 =?us-ascii?Q?UirPAQU8iZm9bzXGNn2NeXJ8o4S35kOHiwG/kEwIGKOtysGHx15sRtNPNg66?=
 =?us-ascii?Q?19+qNuoTKDSPI4MPkx4ETEioJOptsIROlOpebD39wfrZQkqIMFZoy73WvZYn?=
 =?us-ascii?Q?IIVjh7wZf6RiEQVZqmmq84GERhr+DTWKDC/6Uie9hZ0Chg2ttyoKfgZDN87U?=
 =?us-ascii?Q?S9khdlasN6K2jhEHVHA+cc2Vejh8bTHj+GPBugsKPIpb4VJuKxPQejyhi/aR?=
 =?us-ascii?Q?JeoH+zYN71O/mX7RA6ZclPO8ZpDM2L/Bst3lWht6zoUks2xLkTx7LHcmvO+J?=
 =?us-ascii?Q?QsRj+DqLmKwvmKyZurDGkJVyyxgmgMQ3x5QfS6db68R34zMB/Wzc/pUHM2k4?=
 =?us-ascii?Q?5LDnbiNkKE/4qC732oted9W5tWEAQAx2fE0Ij+Wf3fNXCEbHhGvw3Lg9d+5N?=
 =?us-ascii?Q?9DxM3D3k/9wYz/bFznN4CPrRMMlyP7B1GBvBxqJu+Pcvlezc5xzR3d6ot3Xt?=
 =?us-ascii?Q?KlBz/5Rkpgy3FURbOiaXUhn+HH94B3HqPi6i1DaJKpr++8P4Hg5Tqc+l96XW?=
 =?us-ascii?Q?+OGO7kGZvnI/B76HGnIdTXtyB+1gTnGRO7lyCT6hndkp4xIlhDSp+SHJt+4D?=
 =?us-ascii?Q?dyl9NzUbTJHX74yIoLngcHI3DRpKbLP4/VwSwBSv8Gqy78OGz9SXh+14Jev/?=
 =?us-ascii?Q?Gwz0qmNUJAKJC4GevFZuHEmooVOvUuUeXzQRSO3Unc64uGPsMA/63FZpN5ze?=
 =?us-ascii?Q?iiyPp9mWmZ3U91bfabBYPye0R3xkw3CI2fS1CF7YfbSWnUQwhFp0bWJjioB2?=
 =?us-ascii?Q?wc2jbkVjM2OvvnSisVtnrrqOXtnMOnxEGlIct4oEFexcPBK3z85ER0HmalZp?=
 =?us-ascii?Q?WfcX2fDfH2btMapm68xLusNVaZkDI8i2npYSosJX5jtb+f2u1GyCHx7TZ3p5?=
 =?us-ascii?Q?iRdfCBjqkc2t/lwJ9SRS5Dig7t3oyz0hASN/CI0KjyGCKZxmdFBM3B/4DxWV?=
 =?us-ascii?Q?/kj6GZ1cRwKFljTDzZrqRMw5GtsUnl52DaUkthtCGRiydjl8DvfdcR7A/LNw?=
 =?us-ascii?Q?qOlEG72m90QN/N819FA/fopZFr6zl/UMmNkVKC9duKfKSrJkFzFay3TfcSp0?=
 =?us-ascii?Q?YNfPG3xzo8JcSqksOGJULSzpIM/m45x74cdmWAVbZUvT2VmucFvOBqoYOQ1F?=
 =?us-ascii?Q?ojRS680WklesbJDuwfsFLFIar6mAhbeSkXGmXw1jO/7kETZg7+y9MXxSRr+T?=
 =?us-ascii?Q?x6Mzux75vLwfiazX34Yed7baDZ5EAy+eMMPXE+KTzs6oU6vhtb9o1b4s6/Yh?=
 =?us-ascii?Q?uXvXkEzrBppI2aqVn8378l3VE2ejOQuS4eQ97CSxn1aVErQA6662CXCSpBap?=
 =?us-ascii?Q?x06WYyO4bbfLyYSg8+msfYUag6sAp97FuLEjoxXgB62dFWoT+sDw8u1HPv8h?=
 =?us-ascii?Q?LM1hXIMv69zXovaR9jkSCb8MhCgx9yUpXlLB84DK/NXymmWgiofGfAf8yZL+?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21474dc-ac13-446c-5ed6-08db5ba3416f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:54.2205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoeZV7vinJCU+rGszWxulC69uaHPGGh62OzAnA6jgyszKfALWPapKw284ghD8lB4491hupRIHN8dURuSQwuj0VWYD0usODs28JBpUIZktH4=
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
The extra size needed for base extended descriptor and hw
descriptor commands, link tables, IV is computed in frontend
driver (caamalg) initialization and saved in reqsize field
that indicates how much memory could be needed per request.

CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to
dm-crypt use-cases, which seems to be 4 entries maximum.
Therefore in reqsize we allocate memory for maximum 4 entries
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

