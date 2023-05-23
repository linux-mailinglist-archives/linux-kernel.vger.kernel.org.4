Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116C770E0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjEWPfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbjEWPfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:07 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D81184;
        Tue, 23 May 2023 08:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dckue7xO8RVubcEE/pz+ENeVYe5GNn9ZAEQtzHGTQRsUjRsP8moof2/o/PZNvtm8HLllPaMCwxDwHXtU6ukTxGJl98abdN8W8Cthl1KOTaMKyOaxPLNtpQEkqrg8JSU5uorD+G4h0TO/FtDZO29T6pGCNRXt60ZPeaOexFBpuBVBXPzGf55t6JZ8ZYxEhc2ZNuIylkQjoXXocIAM4TscmhzMERB9tc2SMwHxcwHj/RoAJiaT8ABkcfewD1JCLoOfzjBNZE8WWrS+7emIKOpTnbdcB+ErNVGcRtfroB5xgiv+rClLfbHhgrLI8VhrsNA2FBU40dq7GxvXL9yxH7t7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XILjacwRWzE95f3Osfm39NIwAXS8y+Ydou9mJyuZTxo=;
 b=nPXn2LjbKV0efh6c592FUqZJJ5jV7sX/W29vImYlRl0PkvsPdVGT0WtiKQT81ZlIdyfcXEvc8urYuExMxF3G4VTibWuT5TbqaziOlR3BfkZ/dfW8Uo/+rZxslbdWglPYLwMbqZIUEKJiuuNaNKIJOmLvmNzlIqKNV8SoZDRYiQqCM+bFfAVndyL+XscOipxKGDkfcqk7zFsOwkaNgiHw1bFLXaT7lLDj6yXyjC/p9fKNA34vAgnbaMI74RspfotRb96UjGnf5PJsisFZIXK0xJmkLubLV/csv9Eo1hHc71yFcm8xT/OKtlmLkMcWB2+5KlRX68Sw4pocl/d2Yxvufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XILjacwRWzE95f3Osfm39NIwAXS8y+Ydou9mJyuZTxo=;
 b=HKMwnN8YEoihci9nnq6HWPFFlwFn4oK7E/GBhiHJSw4fyGqXXKMrzd70uYG0m1RdDOxV+3Dm/Ahlo36CTOBqHLcP5bwbkf1pqpiC4Ha0trqy+c8tSqCGp8dCSXtOw/TVUjU7UwW5vC+owDMZfDy5EXjL7akS8V86LstSnPl8CDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7)
 by AM0PR04MB7156.eurprd04.prod.outlook.com (2603:10a6:208:19b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 15:34:57 +0000
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
Subject: [PATCH 3/5] crypto: caam - avoid allocating memory at crypto request runtime for hash
Date:   Tue, 23 May 2023 17:34:19 +0200
Message-Id: <20230523153421.1528359-4-meenakshi.aggarwal@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9571:EE_|AM0PR04MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: aea6391a-7570-478a-0b9e-08db5ba3426c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6AhXdzqH9t5WIjPm0yPkSg350Vri8yGkIm5lTEgMgRq8hP536w8n4CSHRgU+gU0rURxXkbtc4jmOncbnYXRBjCeNtPDg0F9X3sXXEDJU4N9cR6bV+98ZmhRL39IA7FTHCSM82s0qKPSvXNUCBAPxDuA/LkPgnFD/OqZrZUV6j32oxytXy0uh9ppoKKYm0D2mSo/7trlDn52d5JBh23bdL8wX1Kd+iHEDFVhIq/9s0DXDIlpjpBDRweHCpehrURm21ni3CUiuELpvPBFpQ68KxxHCoE6Rxf8OBPrGaXQgAoYyH7TTudPFJtprvCqj0L/oDnDWMdytiiGBL3gFJPLiM4ykvU6ZirZP9eOVmXD0zTcVLD7yz+RVcwCQxei6igGwiCKy0mLsqekmfOdmQhKhYg/lA7HFtuh2JvmkkFVf842Uh5Rr1isFm/7MWafsHQ/cuXF7+BTxKPg5H8MFnQmS1v2BG0QCiwrw82rw9mAN8tMSVWwra/jMcxFTkqbWnVIMX+gDeeBkzkktJqwpTiPj1MHGAqt2y432bcOrFA8dAYJwgcHCEa9WeyykFe/M5XpCiPgHVDi4UVUGA9SfAYp9m2WRROjGtORAHisQIRYodD9eEfp9I4AKgxUo+Nptag+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(52116002)(41300700001)(66556008)(66476007)(66946007)(2906002)(26005)(1076003)(186003)(478600001)(6486002)(4326008)(316002)(6666004)(5660300002)(6512007)(8936002)(8676002)(9686003)(36756003)(2616005)(6506007)(83380400001)(86362001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N8Vx7QHsdiS+c+K94ejBIoaqQxruxUObMj1fHejyOaKrEUGl5iXe4jnqu7N+?=
 =?us-ascii?Q?tZybkqWykGK7X6KhmkCpGYDmDvTW1U7fwfQPWiFH73Dz1E8cmuJdqaATP5Dd?=
 =?us-ascii?Q?I+WLJM3xJW5yXGS3OuLpUppQKHcmR2rTMd16aTXKpDiqqTGkCWNi2VZfsPYd?=
 =?us-ascii?Q?ZfwAeKKQl/aB4Nkxltxy9gkPuHV4s42DVWFWhbncEousUlqWBTFExtOrjqy7?=
 =?us-ascii?Q?INw5lypPydvMyyVneXoJQvQ393xpwgMrSfZaVbXpZhMaTg9GSYpTzpqfD73a?=
 =?us-ascii?Q?9js3YHKyUjxPjt4Wv75G6VeTsXjNE4GhDGjWgsqEYiacaC418r1iQTjHv5R3?=
 =?us-ascii?Q?ne0+Wo+WaydycPCxe1n6j6tqfVd+VX3qUOBXURheXk4iSDkxEgoEvqs3k2Gd?=
 =?us-ascii?Q?fxHwLM6dsZHePXT1eOadVvInYacFGT75YoPDkSjg2IzxyaNKO1pmj60z83N4?=
 =?us-ascii?Q?H4prpCpnRc1uxyOwwRPQOvUKQ8ZLBN0o1lsvxpCHWcQ5GLXmqFxHGx3IriK/?=
 =?us-ascii?Q?LSGZF6Hazx4kIYYRuNnQ3FohcQo+4D4ImJ1FlC/qywwNZNA3OK0ZPlyggrZm?=
 =?us-ascii?Q?LsQs8YbD5tDnekwWmLWqoX8DYf5radGhe7voDOAa3ebEwn/1zpw92q1oYJHE?=
 =?us-ascii?Q?bTUZy5Qv6Uj8edD1iCNJjLKqFKUGIZwkbKzaLeY+7YyfBqVTpWKls1jX03eI?=
 =?us-ascii?Q?H6Pcb9sbYYvhq1g5wIYzmPVrDV0X7aGqLBDM43xZOuQT8Vvv2pe/0hYRe1YY?=
 =?us-ascii?Q?Li/5le5+WsVED/qK1K8G/20tDB6y51q2PCkYXcYIii08u1/4Ozy6Hc/KR/Kx?=
 =?us-ascii?Q?mDe0zlRhaID3wEUTsrtuQc4dR8AyYIMD4NzzlegZxdvc0wqOybPev/SP1SgG?=
 =?us-ascii?Q?94fhDmmBoflDsjEgV0h4zvxZvgORbxgeEOeXeJ3Vp1u/7HMTpwSwmiDc0pU5?=
 =?us-ascii?Q?Lvq/Y+kXUFZIiCemZOZQVsg0ltAP7wzHPgMcnTNWInhFeoLom5igd2k/y73J?=
 =?us-ascii?Q?XFM1LgNmO9EtWl47XkEL5By4QS3U9rfVxZjLp1jRdc+ZJP+mKQhb8zMu66Yk?=
 =?us-ascii?Q?fi5AiZBi+hggUuEGmp2tz9nwKvzyLcC9NX32NyB9QvqpOL7B0UlsLhT5Hj6s?=
 =?us-ascii?Q?9EIWdQAqokgj1BC1EDgK0neqZjSWN4N/jj3Pp31cgEYCocXbdLeQXgP9QAju?=
 =?us-ascii?Q?rbpgVjsd6qrGmcbdeVBgiit+AIzXBkF/NlH9nGomajQE2RWjdLHjCAPtRJLI?=
 =?us-ascii?Q?toswz5vIgk2CMmT7Tj0eH+/7rNxUcZsSDkVxZjyRJqbwW+HN+J4j0ApqlBbz?=
 =?us-ascii?Q?1FJYBneR1Gc2wyiSUqudWDKMsmoiPJP4/0QKdJyiGlaryj3dXDs2AQyVsFs7?=
 =?us-ascii?Q?Xopai2ylQ4SPfYUJ5rEiFSGJR9s6LP+1eLM5HIfchrLdN1a3dceleQcCPy1a?=
 =?us-ascii?Q?C+kZ3/m7sXVAXmTBrq8A858EmP2pf0AN4a0lEUWV25Patr8jXvbK+tKwpoWX?=
 =?us-ascii?Q?Noi/9ykhxhmSEkS3Bhtzermb4ZpycQy0ZWJD8gHxvr/5+9pDCuz6FZexXF05?=
 =?us-ascii?Q?yMsInaL6gR6Qn0dC8l/L25RGl4PN5i1/av4ogstEfROMjaN5YInnX6bCErQH?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea6391a-7570-478a-0b9e-08db5ba3426c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:55.8265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWfuaLYLY9NRu47e2L1OMyprbD227FL+B0EIWzCLRTYoxIxA1x/HIXMo0gLJqrWOZwNDgBTPouTBbMAxubac3G8Kt8SXJgdL+qSAYtuqXXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7156
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

CRYPTO_ALG_ALLOCATES_MEMORY flag is limited only to
dm-crypt use-cases, which seems to be 4 entries maximum.
Therefore in reqsize we allocate memory for maximum 4 entries
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

