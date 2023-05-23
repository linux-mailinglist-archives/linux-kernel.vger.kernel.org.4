Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3930D70E0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjEWPfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbjEWPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:35:08 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E3188;
        Tue, 23 May 2023 08:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvtksHHOOwk7BYineddBxlo7oWb8WdGuqNRk+7wYGBjbmwkSZlxzJpjAbfyVMuQv2gXzPuT9ju6gzgYQvbcw35DmoHN/vbWtMVwhVcxqJiWpOiQLm273/4Cr8ZPnNpMVImxbnbaHbjRMMyBDsWHCwznPwmwi8wi/QXix1Qk0PJ9IuOQzhUYbqoZ/5wOLMk0dBfVukMLBSxb3q4ZRpT5NbXoiNHuyEuAogVP4lyIDUv2isOn+euQ7XzwwypDubLjOUWbX+pfTG8QySmKxJFhBsP1avJuvgG6d+eN2Cp6nqN1bsvAYh4zYpsa6wqizE4sp++D+S8zVeRuz9QZQ5XGCRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgnsORy7pN77TaNeDUoifgr/9zb/l8eEG+nlOdK/89E=;
 b=bFtFVkBIrnLtKd9T3jkTPyMk3UKqZPGQFT9B75dZ0a1X5Fy00gXSxdev3x4bzdmWUoBq9JgpJprrbUcQZZDSrgdxxqh1PneX64gBLY9OJGpLAD7jknfqkZcEb7hS+x6dUyCr5PBW5ypcLjvj68AzIJp8soPRYNfFuOpOXaIQHEC1Hukb4CSN0e9wgNA8Ia1/W+HAhigk+uP0pYll9cO4wH0Y7qp9P8cu8/4x6vteWxdB318aZ1xMpN/SjfD3HukMdk8Ted/4ZY4MZV9BtbW4pVwRJZKerYKE+94buKT3i/H4IiWFEN/KA7ZNxyowcMzwewIiVgyUT9Ku8aQSB3nsWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgnsORy7pN77TaNeDUoifgr/9zb/l8eEG+nlOdK/89E=;
 b=eTOO6pYt4mNIUPu5Z6rjQCli2mkpQrQ7/NQGqqIe2kO4EltuyWrC/niRFQ1ZX3d/PneKUmFCnHSm3VUbSjlYJwknCjtm6eb+x84BgVNWQdZHpAvkB54O/02+dlqBpo5hq6GLVLVxmpQYmD9jBqOk/+Z6mIFscqREqnasp4A5YlA=
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
Subject: [PATCH 4/5] crypto: caam/qi - avoid allocating memory at crypto request runtime
Date:   Tue, 23 May 2023 17:34:20 +0200
Message-Id: <20230523153421.1528359-5-meenakshi.aggarwal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 733ae638-9d5e-45e2-9d85-08db5ba342e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbT9PmqqFSk1gx43TNIxU1eKaSDsehbBj7CiMny1k8WnMHVz1MK0TMy96csWqdwlsSjY0Mi4vGgeRCSCZiDMC6qCGJQLMlCSaJ/pFvthSgLOUQOlXgASQiO4QxMlQg6fxlE9IDdr5MpzTXkLjCStjD4eIHS/2p6DJZrVjT9ekGseO5QjUKvrtZ/KSBBXmHhdJoJqF52IUuaE4GVw76wQZJCj1xLp0Nm+Lfykwy66mEy2evsbTDDY0EN1UyzZ5AN0NcDBKDXRMOgmoFGxqJEheyUUeNqJkDtBWjVY2ygLZHOeAevYdwYpq9oxtHZysPkhXdNHgVSNW8wBOG9EkUFblx+I883HGVdSl0uZupFAc0+5SN8r2Gm7SQ14t91Z49SP3Rf+pTgNafBmwW44KXVS33vQtpaOxQLgj6nw13Cg4GBvDnvoUHXtJHiWUxJL0nPiEkgjKUH1xd/v3ucs+Ct4wnDBtAZK9mxuddX73Nnzo4xajnpV+FnrKI7kE59hRqaKvmMxi7MI1IcLtc4r6DYBhQsmWoUeQZOvg/GLTRGInLwISH6Gsw/ZhU/KkZmkEfG3ZoGH6Xl+W/QO2b7MySm1qeApDdRNW0HbrRt/CzkvARZBml91Z8ciosZdyNnI5a5a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9571.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(41300700001)(6486002)(52116002)(6666004)(316002)(26005)(9686003)(6506007)(6512007)(1076003)(5660300002)(36756003)(8936002)(8676002)(38100700002)(38350700002)(478600001)(86362001)(2616005)(83380400001)(30864003)(186003)(66476007)(66556008)(66946007)(2906002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RgaWkAX+B5EyVsQU1ivQYM4mZt6nGUiivpFVu27lknkBBcyfyyxleRyIe5di?=
 =?us-ascii?Q?H9KF07ls9IZsQNEC4YYngwoGvacgIWakx9cjw2adW0UNijRJgEIDYMG/2rm2?=
 =?us-ascii?Q?vzvV45judwJ3Y8rpftnY1C+wzyO8P8ZgT6uatHY20uyagQlgoUb1xdqRLq8t?=
 =?us-ascii?Q?WXtJYiO6zKduoYqd9U8m02UUXLdsgPIf13CGnwYToIwKuIDsqemFT0SbJkdA?=
 =?us-ascii?Q?d648c+hN02yftlSnX1aMZR7AEDzcNEd+13amt4BhmMknGyX4NijAT8TIVW1M?=
 =?us-ascii?Q?RwvXpFM0J1ttDsBB6zd22K5gaDTovphBgh9lKT/6+1xlfkJmPIFgZMAqwp44?=
 =?us-ascii?Q?TIHGs5t/4vVGJXxoTQcB4hz7rtcKHPtbtQrOZ/TCCztpSPrWDYXvlYXAyjvi?=
 =?us-ascii?Q?b35EaBy6KkG27qOnJvjvbHniEQvk4zq8jNYMZFoXeiihRab33M5NGoC2tGdb?=
 =?us-ascii?Q?GbI5xRU+iFCbF0HlmxuaYpHUBPPn6a3N/Ol/3So/h7Q2oAJ8mm+zOMwszl8E?=
 =?us-ascii?Q?iVTsilhBeJHI7qDKgLpalrdSw2vCVJIAC01Oh0/m5EiNRcOwH+HGDdVavg2u?=
 =?us-ascii?Q?MTbNufQbOhkEBggtCJc0N2o+3iwEFh06h0l6FddUMcyxlnYiSRvie5tAA3AO?=
 =?us-ascii?Q?29Bp5UCDEOHOsiYWSnJULzX8UZ+5RX2cczxYrcI58L9cM1J87Ya9fzyB9Fgd?=
 =?us-ascii?Q?D6yiW5WyUbsEO8GBsbGpWmHFVCg2M9W+W/vEH8H3Ia4MeZrjJrOhKDrp/6dK?=
 =?us-ascii?Q?5HxgmxULTj9mTZPIqjfOI8UTT3Y7pfd8zEhhx6DJXnQTo6k/d5vnjozjezhw?=
 =?us-ascii?Q?JXWCrQZ1ozq/4NZaVonas3/gno44h5lA67bgUhD7WEjWAdA7phnnHHE8hrLB?=
 =?us-ascii?Q?aB1+bn1EqGwZ8ct+hYtFgGF9NSMKcYiTBb1P6gqzVccz6U1jxHpkZpdaAEc0?=
 =?us-ascii?Q?KojApbESulbTb9QFjNF26RMk/osmcOtKoqySBvsCKif9agNewcoCFrIX2wpD?=
 =?us-ascii?Q?VkfxjGnddyW9jhFpwZdXMaCzTmhfuSagI441EW1cl/b+WT2B8/3g/Ufq59HN?=
 =?us-ascii?Q?HAbh4i2BRCxrL25TLangLhbyQ8p0D8X7rb9u7sc2/fEaG+G7viOpfJHqos+S?=
 =?us-ascii?Q?X7pUYaSTyqQX07VcpK+qZuk9cds0bhFcP0wtfZp6edthf0wqxC7bcABy/4mP?=
 =?us-ascii?Q?bguvNUhWymVPH1gcr4j4oqMCHWL6Ozn3auSoRzbBEg5EdLkYq2toNvsn5WFL?=
 =?us-ascii?Q?yZ4TW86whEhdPWXcNW9mTC72vO+vAN0360Vp+sqtWA5Xbg+LGxjYIIYT6Fzi?=
 =?us-ascii?Q?eTdPsrQMDCNO8p/3/ZTi+a4f1KvrUSqGLJ+iPzWfGYb6/Kf0hBLPRn1x7gGT?=
 =?us-ascii?Q?OhDwy2ZndWdiY05SXrGD0iJXpGwpZqks2EG3K26NUODcO1M8kWMRaY8OjQIf?=
 =?us-ascii?Q?JQMIvnK+vINljfJ9mDuH+YrDRZjQgIn1Yj7sjD5UXZAsQEyNyl1+unP0BUBq?=
 =?us-ascii?Q?KZAmnXb7sx7+SKVMIA4zn6Fa9ar9YpU6GptJofnecbofhnMdBNblbR5dhfgA?=
 =?us-ascii?Q?7udrrgMfqUcuZykGtv/kuOl07iVaYT3/6KDxEgomX5x+GPuJvaN5hk41ALNc?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733ae638-9d5e-45e2-9d85-08db5ba342e5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9561.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 15:34:56.6542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W18hR2n7dZ8cY/C1OiBrS84QKVb9ei0Lb1J7L2lHRne88H58hGgg/bwSi8Me/7gOy4f2tejf4M184OL635v9eP8FwtlGh+jeoa+UlpI1GNQ=
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
driver (caamalg_qi) initialization and saved in reqsize field
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
 drivers/crypto/caam/caamalg_qi.c | 131 +++++++++++++++++++++----------
 1 file changed, 89 insertions(+), 42 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi.c b/drivers/crypto/caam/caamalg_qi.c
index 743ce50c14f2..d7078f37ef9f 100644
--- a/drivers/crypto/caam/caamalg_qi.c
+++ b/drivers/crypto/caam/caamalg_qi.c
@@ -793,6 +793,7 @@ static int xts_skcipher_setkey(struct crypto_skcipher *skcipher, const u8 *key,
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if aead_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @assoclen: associated data length, in CAAM endianness
  * @assoclen_dma: bus physical mapped address of req->assoclen
@@ -804,6 +805,7 @@ struct aead_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	unsigned int assoclen;
 	dma_addr_t assoclen_dma;
@@ -817,6 +819,7 @@ struct aead_edesc {
  * @dst_nents: number of segments in output scatterlist
  * @iv_dma: dma address of iv for checking continuity and link table
  * @qm_sg_bytes: length of dma mapped h/w link table
+ * @free: stored to determine if skcipher_edesc needs to be freed
  * @qm_sg_dma: bus physical mapped address of h/w link table
  * @drv_req: driver-specific request structure
  * @sgt: the h/w link table, followed by IV
@@ -826,6 +829,7 @@ struct skcipher_edesc {
 	int dst_nents;
 	dma_addr_t iv_dma;
 	int qm_sg_bytes;
+	bool free;
 	dma_addr_t qm_sg_dma;
 	struct caam_drv_req drv_req;
 	struct qm_sg_entry sgt[];
@@ -932,7 +936,8 @@ static void aead_done(struct caam_drv_req *drv_req, u32 status)
 	aead_unmap(qidev, edesc, aead_req);
 
 	aead_request_complete(aead_req, ecode);
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 }
 
 /*
@@ -954,7 +959,7 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	dma_addr_t qm_sg_dma, iv_dma = 0;
 	int ivsize = 0;
 	unsigned int authsize = ctx->authsize;
-	int qm_sg_index = 0, qm_sg_ents = 0, qm_sg_bytes;
+	int qm_sg_index = 0, qm_sg_ents = 0, qm_sg_bytes, edesc_size = 0;
 	int in_len, out_len;
 	struct qm_sg_entry *sg_table, *fd_sgt;
 	struct caam_drv_ctx *drv_ctx;
@@ -963,13 +968,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	if (IS_ERR(drv_ctx))
 		return (struct aead_edesc *)drv_ctx;
 
-	/* allocate space for base edesc and hw desc commands, link tables */
-	edesc = qi_cache_alloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(qidev, "could not allocate extended descriptor\n");
-		return ERR_PTR(-ENOMEM);
-	}
-
 	if (likely(req->src == req->dst)) {
 		src_len = req->assoclen + req->cryptlen +
 			  (encrypt ? authsize : 0);
@@ -978,7 +976,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -986,7 +983,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 					      DMA_BIDIRECTIONAL);
 		if (unlikely(!mapped_src_nents)) {
 			dev_err(qidev, "unable to map source\n");
-			qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	} else {
@@ -997,7 +993,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(src_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in src S/G\n",
 				src_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(src_nents);
 		}
 
@@ -1005,7 +1000,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		if (unlikely(dst_nents < 0)) {
 			dev_err(qidev, "Insufficient bytes (%d) in dst S/G\n",
 				dst_len);
-			qi_cache_free(edesc);
 			return ERR_PTR(dst_nents);
 		}
 
@@ -1014,7 +1008,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 						      src_nents, DMA_TO_DEVICE);
 			if (unlikely(!mapped_src_nents)) {
 				dev_err(qidev, "unable to map source\n");
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -1029,7 +1022,6 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 				dev_err(qidev, "unable to map destination\n");
 				dma_unmap_sg(qidev, req->src, src_nents,
 					     DMA_TO_DEVICE);
-				qi_cache_free(edesc);
 				return ERR_PTR(-ENOMEM);
 			}
 		} else {
@@ -1061,18 +1053,35 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 	else
 		qm_sg_ents = pad_sg_nents(qm_sg_ents);
 
-	sg_table = &edesc->sgt[0];
 	qm_sg_bytes = qm_sg_ents * sizeof(*sg_table);
-	if (unlikely(offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize >
-		     CAAM_QI_MEMCACHE_SIZE)) {
+
+	/* Check if there's enough space for edesc saved in req */
+	edesc_size = offsetof(struct aead_edesc, sgt) + qm_sg_bytes + ivsize;
+	if (unlikely(edesc_size > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(qidev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
+	} else if (edesc_size > crypto_aead_reqsize(aead)) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_alloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(qidev, "could not allocate extended descriptor\n");
+			caam_unmap(qidev, req->src, req->dst, src_nents,
+				   dst_nents, 0, 0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct aead_edesc *)((u8 *)aead_request_ctx(req));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
+	sg_table = &edesc->sgt[0];
+
 	if (ivsize) {
 		u8 *iv = (u8 *)(sg_table + qm_sg_ents);
 
@@ -1084,7 +1093,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 			dev_err(qidev, "unable to map IV\n");
 			caam_unmap(qidev, req->src, req->dst, src_nents,
 				   dst_nents, 0, 0, DMA_NONE, 0, 0);
-			qi_cache_free(edesc);
+			if (edesc->free)
+				qi_cache_free(edesc);
 			return ERR_PTR(-ENOMEM);
 		}
 	}
@@ -1103,7 +1113,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dev_err(qidev, "unable to map assoclen\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1125,7 +1136,8 @@ static struct aead_edesc *aead_edesc_alloc(struct aead_request *req,
 		dma_unmap_single(qidev, edesc->assoclen_dma, 4, DMA_TO_DEVICE);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_TO_DEVICE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1179,7 +1191,8 @@ static inline int aead_crypt(struct aead_request *req, bool encrypt)
 		ret = -EINPROGRESS;
 	} else {
 		aead_unmap(ctx->qidev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -1247,7 +1260,8 @@ static void skcipher_done(struct caam_drv_req *drv_req, u32 status)
 	if (!ecode)
 		memcpy(req->iv, skcipher_edesc_iv(edesc), ivsize);
 
-	qi_cache_free(edesc);
+	if (edesc->free)
+		qi_cache_free(edesc);
 	skcipher_request_complete(req, ecode);
 }
 
@@ -1333,21 +1347,28 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 	len = ALIGN(len, dma_get_cache_alignment());
 	len += ivsize;
 
+	/* Check if there's enough space for edesc saved in req */
 	if (unlikely(len > CAAM_QI_MEMCACHE_SIZE)) {
 		dev_err(qidev, "No space for %d S/G entries and/or %dB IV\n",
 			qm_sg_ents, ivsize);
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
 		return ERR_PTR(-ENOMEM);
-	}
-
-	/* allocate space for base edesc, link tables and IV */
-	edesc = qi_cache_alloc(flags);
-	if (unlikely(!edesc)) {
-		dev_err(qidev, "could not allocate extended descriptor\n");
-		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
-			   0, DMA_NONE, 0, 0);
-		return ERR_PTR(-ENOMEM);
+	} else if (len > crypto_skcipher_reqsize(skcipher)) {
+		/* allocate space for base edesc, link tables and IV */
+		edesc = qi_cache_alloc(flags);
+		if (unlikely(!edesc)) {
+			dev_err(qidev, "could not allocate extended descriptor\n");
+			caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
+				   0, DMA_NONE, 0, 0);
+			return ERR_PTR(-ENOMEM);
+		}
+		edesc->free = true;
+	} else {
+		/* get address for base edesc, link tables and IV */
+		edesc = (struct skcipher_edesc *)((u8 *)skcipher_request_ctx(req));
+		/* clear memory */
+		memset(edesc, 0, sizeof(*edesc));
 	}
 
 	edesc->src_nents = src_nents;
@@ -1367,7 +1388,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 		dev_err(qidev, "unable to map IV\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents, 0,
 			   0, DMA_NONE, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1388,7 +1410,8 @@ static struct skcipher_edesc *skcipher_edesc_alloc(struct skcipher_request *req,
 		dev_err(qidev, "unable to map S/G table\n");
 		caam_unmap(qidev, req->src, req->dst, src_nents, dst_nents,
 			   iv_dma, ivsize, DMA_BIDIRECTIONAL, 0, 0);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1462,7 +1485,8 @@ static inline int skcipher_crypt(struct skcipher_request *req, bool encrypt)
 		ret = -EINPROGRESS;
 	} else {
 		skcipher_unmap(ctx->qidev, edesc, req);
-		qi_cache_free(edesc);
+		if (edesc->free)
+			qi_cache_free(edesc);
 	}
 
 	return ret;
@@ -2509,7 +2533,16 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
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
+			16 * sizeof(struct qm_sg_entry);
+	extra_reqsize += ALIGN(extra_reqsize, dma_get_cache_alignment());
+	extra_reqsize += AES_BLOCK_SIZE; /* ivsize */
 
 	if (alg_aai == OP_ALG_AAI_XTS) {
 		const char *tfm_name = crypto_tfm_alg_name(&tfm->base);
@@ -2525,7 +2558,10 @@ static int caam_cra_init(struct crypto_skcipher *tfm)
 
 		ctx->fallback = fallback;
 		crypto_skcipher_set_reqsize(tfm, sizeof(struct caam_skcipher_req_ctx) +
-					    crypto_skcipher_reqsize(fallback));
+					    crypto_skcipher_reqsize(fallback) +
+					    extra_reqsize);
+	} else {
+		crypto_skcipher_set_reqsize(tfm, extra_reqsize);
 	}
 
 	ret = caam_init_common(ctx, &caam_alg->caam, false);
@@ -2541,6 +2577,19 @@ static int caam_aead_init(struct crypto_aead *tfm)
 	struct caam_aead_alg *caam_alg = container_of(alg, typeof(*caam_alg),
 						      aead);
 	struct caam_ctx *ctx = crypto_aead_ctx_dma(tfm);
+	int extra_reqsize = 0;
+
+	/* Compute extra space needed for base edesc, link tables and IV */
+	extra_reqsize = sizeof(struct aead_edesc) +
+			/* link tables for src and dst:
+			 * 4 entries max + 1 for IV, aligned = 8
+			 */
+			(16 * sizeof(struct qm_sg_entry)) +
+			AES_BLOCK_SIZE; /* ivsize */
+	/*
+	 * Set the size for the space needed for base edesc, link tables, IV
+	 */
+	crypto_aead_set_reqsize(tfm, extra_reqsize);
 
 	return caam_init_common(ctx, &caam_alg->caam, !caam_alg->caam.nodkp);
 }
@@ -2596,8 +2645,7 @@ static void caam_skcipher_alg_init(struct caam_skcipher_alg *t_alg)
 	alg->base.cra_module = THIS_MODULE;
 	alg->base.cra_priority = CAAM_CRA_PRIORITY;
 	alg->base.cra_ctxsize = sizeof(struct caam_ctx) + crypto_dma_padding();
-	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY |
-				CRYPTO_ALG_KERN_DRIVER_ONLY);
+	alg->base.cra_flags |= (CRYPTO_ALG_ASYNC | CRYPTO_ALG_KERN_DRIVER_ONLY);
 
 	alg->init = caam_cra_init;
 	alg->exit = caam_cra_exit;
@@ -2610,8 +2658,7 @@ static void caam_aead_alg_init(struct caam_aead_alg *t_alg)
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

