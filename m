Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328C5640325
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiLBJVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiLBJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:11 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20853BE4ED;
        Fri,  2 Dec 2022 01:21:08 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12E1-003AoY-9l; Fri, 02 Dec 2022 17:20:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:53 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:53 +0800
Subject: [PATCH 4/10] crypto: chelsio - Set DMA alignment explicitly
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1p12E1-003AoY-9l@formenos.hmeau.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has been implicitly relying on kmalloc alignment
to be sufficient for DMA.  This may no longer be the case with
upcoming arm64 changes.

This patch changes it to explicitly request DMA alignment from
the Crypto API.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/crypto/chelsio/chcr_algo.c |   43 ++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 6933546f87b1..2158bc237dbb 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -210,7 +210,7 @@ static inline int chcr_handle_aead_resp(struct aead_request *req,
 					 unsigned char *input,
 					 int err)
 {
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_dev *dev = a_ctx(tfm)->dev;
 
@@ -718,7 +718,7 @@ static inline int get_qidxs(struct crypto_async_request *req,
 	{
 		struct aead_request *aead_req =
 			container_of(req, struct aead_request, base);
-		struct chcr_aead_reqctx *reqctx = aead_request_ctx(aead_req);
+		struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(aead_req);
 		*txqidx = reqctx->txqidx;
 		*rxqidx = reqctx->rxqidx;
 		break;
@@ -2362,7 +2362,7 @@ static void chcr_hmac_cra_exit(struct crypto_tfm *tfm)
 
 inline void chcr_aead_common_exit(struct aead_request *req)
 {
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct uld_ctx *u_ctx = ULD_CTX(a_ctx(tfm));
 
@@ -2373,7 +2373,7 @@ static int chcr_aead_common_init(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	int error = -EINVAL;
 
@@ -2417,7 +2417,7 @@ static int chcr_aead_fallback(struct aead_request *req, unsigned short op_type)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
-	struct aead_request *subreq = aead_request_ctx(req);
+	struct aead_request *subreq = aead_request_ctx_dma(req);
 
 	aead_request_set_tfm(subreq, aeadctx->sw_cipher);
 	aead_request_set_callback(subreq, req->base.flags,
@@ -2438,7 +2438,7 @@ static struct sk_buff *create_authenc_wr(struct aead_request *req,
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
 	struct chcr_authenc_ctx *actx = AUTHENC_CTX(aeadctx);
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
 	struct cpl_rx_phys_dsgl *phys_cpl;
@@ -2576,7 +2576,7 @@ int chcr_aead_dma_map(struct device *dev,
 		      unsigned short op_type)
 {
 	int error;
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	int src_len, dst_len;
@@ -2637,7 +2637,7 @@ void chcr_aead_dma_unmap(struct device *dev,
 			 struct aead_request *req,
 			 unsigned short op_type)
 {
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	unsigned int authsize = crypto_aead_authsize(tfm);
 	int src_len, dst_len;
@@ -2678,7 +2678,7 @@ void chcr_add_aead_src_ent(struct aead_request *req,
 			   struct ulptx_sgl *ulptx)
 {
 	struct ulptx_walk ulp_walk;
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 
 	if (reqctx->imm) {
 		u8 *buf = (u8 *)ulptx;
@@ -2704,7 +2704,7 @@ void chcr_add_aead_dst_ent(struct aead_request *req,
 			   struct cpl_rx_phys_dsgl *phys_cpl,
 			   unsigned short qid)
 {
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct dsgl_walk dsgl_walk;
 	unsigned int authsize = crypto_aead_authsize(tfm);
@@ -2894,7 +2894,7 @@ static int generate_b0(struct aead_request *req, u8 *ivptr,
 	unsigned int l, lp, m;
 	int rc;
 	struct crypto_aead *aead = crypto_aead_reqtfm(req);
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	u8 *b0 = reqctx->scratch_pad;
 
 	m = crypto_aead_authsize(aead);
@@ -2932,7 +2932,7 @@ static int ccm_format_packet(struct aead_request *req,
 			     unsigned short op_type,
 			     unsigned int assoclen)
 {
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
 	int rc = 0;
@@ -2963,7 +2963,7 @@ static void fill_sec_cpl_for_aead(struct cpl_tx_sec_pdu *sec_cpl,
 	struct chcr_context *ctx = a_ctx(tfm);
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	unsigned int cipher_mode = CHCR_SCMD_CIPHER_MODE_AES_CCM;
 	unsigned int mac_mode = CHCR_SCMD_AUTH_MODE_CBCMAC;
 	unsigned int rx_channel_id = reqctx->rxqidx / ctx->rxq_perchan;
@@ -3036,7 +3036,7 @@ static struct sk_buff *create_aead_ccm_wr(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(a_ctx(tfm));
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
 	struct cpl_rx_phys_dsgl *phys_cpl;
@@ -3135,7 +3135,7 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	struct chcr_context *ctx = a_ctx(tfm);
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct sk_buff *skb = NULL;
 	struct chcr_wr *chcr_req;
 	struct cpl_rx_phys_dsgl *phys_cpl;
@@ -3255,9 +3255,10 @@ static int chcr_aead_cra_init(struct crypto_aead *tfm)
 					       CRYPTO_ALG_ASYNC);
 	if  (IS_ERR(aeadctx->sw_cipher))
 		return PTR_ERR(aeadctx->sw_cipher);
-	crypto_aead_set_reqsize(tfm, max(sizeof(struct chcr_aead_reqctx),
-				 sizeof(struct aead_request) +
-				 crypto_aead_reqsize(aeadctx->sw_cipher)));
+	crypto_aead_set_reqsize_dma(
+		tfm, max(sizeof(struct chcr_aead_reqctx),
+			 sizeof(struct aead_request) +
+			 crypto_aead_reqsize(aeadctx->sw_cipher)));
 	return chcr_device_init(a_ctx(tfm));
 }
 
@@ -3735,7 +3736,7 @@ static int chcr_aead_op(struct aead_request *req,
 			create_wr_t create_wr_fn)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_reqctx  *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct chcr_context *ctx = a_ctx(tfm);
 	struct uld_ctx *u_ctx = ULD_CTX(ctx);
 	struct sk_buff *skb;
@@ -3785,7 +3786,7 @@ static int chcr_aead_op(struct aead_request *req,
 static int chcr_aead_encrypt(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	struct chcr_context *ctx = a_ctx(tfm);
 	unsigned int cpu;
 
@@ -3816,7 +3817,7 @@ static int chcr_aead_decrypt(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct chcr_context *ctx = a_ctx(tfm);
 	struct chcr_aead_ctx *aeadctx = AEAD_CTX(ctx);
-	struct chcr_aead_reqctx *reqctx = aead_request_ctx(req);
+	struct chcr_aead_reqctx *reqctx = aead_request_ctx_dma(req);
 	int size;
 	unsigned int cpu;
 
