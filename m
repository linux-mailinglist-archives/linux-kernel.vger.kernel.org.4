Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1718A640326
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiLBJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiLBJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:21:11 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAEEBD0DC;
        Fri,  2 Dec 2022 01:21:07 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p12Dz-003AoK-7J; Fri, 02 Dec 2022 17:20:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 17:20:51 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Fri, 02 Dec 2022 17:20:51 +0800
Subject: [PATCH 3/10] crypto: ccree - Set DMA alignment explicitly
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
Message-Id: <E1p12Dz-003AoK-7J@formenos.hmeau.com>
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

 drivers/crypto/ccree/cc_aead.c       |   62 ++++++++++++-------------
 drivers/crypto/ccree/cc_buffer_mgr.c |   18 +++----
 drivers/crypto/ccree/cc_hash.c       |   86 +++++++++++++++++------------------
 3 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 35794c7271fb..109ffb375fc6 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -138,7 +138,7 @@ static int cc_aead_init(struct crypto_aead *tfm)
 	ctx->flow_mode = cc_alg->flow_mode;
 	ctx->auth_mode = cc_alg->auth_mode;
 	ctx->drvdata = cc_alg->drvdata;
-	crypto_aead_set_reqsize(tfm, sizeof(struct aead_req_ctx));
+	crypto_aead_set_reqsize_dma(tfm, sizeof(struct aead_req_ctx));
 
 	/* Allocate key buffer, cache line aligned */
 	ctx->enckey = dma_alloc_coherent(dev, AES_MAX_KEY_SIZE,
@@ -208,7 +208,7 @@ static int cc_aead_init(struct crypto_aead *tfm)
 static void cc_aead_complete(struct device *dev, void *cc_req, int err)
 {
 	struct aead_request *areq = (struct aead_request *)cc_req;
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(areq);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(areq);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(cc_req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
 
@@ -723,7 +723,7 @@ static void cc_set_assoc_desc(struct aead_request *areq, unsigned int flow_mode,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(areq);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(areq);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(areq);
 	enum cc_req_dma_buf_type assoc_dma_type = areq_ctx->assoc_buff_type;
 	unsigned int idx = *seq_size;
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
@@ -762,7 +762,7 @@ static void cc_proc_authen_desc(struct aead_request *areq,
 				struct cc_hw_desc desc[],
 				unsigned int *seq_size, int direct)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(areq);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(areq);
 	enum cc_req_dma_buf_type data_dma_type = areq_ctx->data_buff_type;
 	unsigned int idx = *seq_size;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(areq);
@@ -827,7 +827,7 @@ static void cc_proc_cipher_desc(struct aead_request *areq,
 				unsigned int *seq_size)
 {
 	unsigned int idx = *seq_size;
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(areq);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(areq);
 	enum cc_req_dma_buf_type data_dma_type = areq_ctx->data_buff_type;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(areq);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
@@ -873,7 +873,7 @@ static void cc_proc_digest_desc(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int idx = *seq_size;
 	unsigned int hash_mode = (ctx->auth_mode == DRV_HASH_SHA1) ?
 				DRV_HASH_HW_SHA1 : DRV_HASH_HW_SHA256;
@@ -923,7 +923,7 @@ static void cc_set_cipher_desc(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int hw_iv_size = req_ctx->hw_iv_size;
 	unsigned int idx = *seq_size;
 	int direct = req_ctx->gen_ctx.op_type;
@@ -965,7 +965,7 @@ static void cc_set_cipher_desc(struct aead_request *req,
 static void cc_proc_cipher(struct aead_request *req, struct cc_hw_desc desc[],
 			   unsigned int *seq_size, unsigned int data_flow_mode)
 {
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	int direct = req_ctx->gen_ctx.op_type;
 	unsigned int idx = *seq_size;
 
@@ -1082,7 +1082,7 @@ static void cc_proc_header_desc(struct aead_request *req,
 				struct cc_hw_desc desc[],
 				unsigned int *seq_size)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	unsigned int idx = *seq_size;
 
 	/* Hash associated data */
@@ -1158,7 +1158,7 @@ static void cc_proc_scheme_desc(struct aead_request *req,
 static void cc_mlli_to_sram(struct aead_request *req,
 			    struct cc_hw_desc desc[], unsigned int *seq_size)
 {
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
@@ -1212,7 +1212,7 @@ static void cc_hmac_authenc(struct aead_request *req, struct cc_hw_desc desc[],
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	int direct = req_ctx->gen_ctx.op_type;
 	unsigned int data_flow_mode =
 		cc_get_data_flow(direct, ctx->flow_mode,
@@ -1265,7 +1265,7 @@ cc_xcbc_authenc(struct aead_request *req, struct cc_hw_desc desc[],
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	int direct = req_ctx->gen_ctx.op_type;
 	unsigned int data_flow_mode =
 		cc_get_data_flow(direct, ctx->flow_mode,
@@ -1312,7 +1312,7 @@ static int validate_data_size(struct cc_aead_ctx *ctx,
 			      enum drv_crypto_direction direct,
 			      struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	unsigned int assoclen = areq_ctx->assoclen;
 	unsigned int cipherlen = (direct == DRV_CRYPTO_DIRECTION_DECRYPT) ?
@@ -1411,7 +1411,7 @@ static int cc_ccm(struct aead_request *req, struct cc_hw_desc desc[],
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int idx = *seq_size;
 	unsigned int cipher_flow_mode;
 	dma_addr_t mac_result;
@@ -1533,7 +1533,7 @@ static int config_ccm_adata(struct aead_request *req)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	//unsigned int size_of_a = 0, rem_a_size = 0;
 	unsigned int lp = req->iv[0];
 	/* Note: The code assume that req->iv[0] already contains the value
@@ -1591,7 +1591,7 @@ static void cc_proc_rfc4309_ccm(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 
 	/* L' */
 	memset(areq_ctx->ctr_iv, 0, AES_BLOCK_SIZE);
@@ -1615,7 +1615,7 @@ static void cc_set_ghash_desc(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int idx = *seq_size;
 
 	/* load key to AES*/
@@ -1693,7 +1693,7 @@ static void cc_set_gctr_desc(struct aead_request *req, struct cc_hw_desc desc[],
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int idx = *seq_size;
 
 	/* load key to AES*/
@@ -1730,7 +1730,7 @@ static void cc_proc_gcm_result(struct aead_request *req,
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	dma_addr_t mac_result;
 	unsigned int idx = *seq_size;
 
@@ -1792,7 +1792,7 @@ static void cc_proc_gcm_result(struct aead_request *req,
 static int cc_gcm(struct aead_request *req, struct cc_hw_desc desc[],
 		  unsigned int *seq_size)
 {
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	unsigned int cipher_flow_mode;
 
 	//in RFC4543 no data to encrypt. just copy data from src to dest.
@@ -1830,7 +1830,7 @@ static int config_gcm_context(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *req_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *req_ctx = aead_request_ctx_dma(req);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 
 	unsigned int cryptlen = (req_ctx->gen_ctx.op_type ==
@@ -1879,7 +1879,7 @@ static void cc_proc_rfc4_gcm(struct aead_request *req)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 
 	memcpy(areq_ctx->ctr_iv + GCM_BLOCK_RFC4_NONCE_OFFSET,
 	       ctx->ctr_nonce, GCM_BLOCK_RFC4_NONCE_SIZE);
@@ -1896,7 +1896,7 @@ static int cc_proc_aead(struct aead_request *req,
 	struct cc_hw_desc desc[MAX_AEAD_PROCESS_SEQ];
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct cc_aead_ctx *ctx = crypto_aead_ctx(tfm);
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct cc_crypto_req cc_req = {};
 
@@ -2019,7 +2019,7 @@ static int cc_proc_aead(struct aead_request *req,
 
 static int cc_aead_encrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
@@ -2039,7 +2039,7 @@ static int cc_rfc4309_ccm_encrypt(struct aead_request *req)
 {
 	/* Very similar to cc_aead_encrypt() above. */
 
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
@@ -2063,7 +2063,7 @@ static int cc_rfc4309_ccm_encrypt(struct aead_request *req)
 
 static int cc_aead_decrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	memset(areq_ctx, 0, sizeof(*areq_ctx));
@@ -2081,7 +2081,7 @@ static int cc_aead_decrypt(struct aead_request *req)
 
 static int cc_rfc4309_ccm_decrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
@@ -2193,7 +2193,7 @@ static int cc_rfc4543_gcm_setauthsize(struct crypto_aead *authenc,
 
 static int cc_rfc4106_gcm_encrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
@@ -2217,7 +2217,7 @@ static int cc_rfc4106_gcm_encrypt(struct aead_request *req)
 
 static int cc_rfc4543_gcm_encrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
@@ -2244,7 +2244,7 @@ static int cc_rfc4543_gcm_encrypt(struct aead_request *req)
 
 static int cc_rfc4106_gcm_decrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
@@ -2268,7 +2268,7 @@ static int cc_rfc4106_gcm_decrypt(struct aead_request *req)
 
 static int cc_rfc4543_gcm_decrypt(struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc;
 
 	rc = crypto_ipsec_check_assoclen(req->assoclen);
diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 9efd88f871d1..bcca55bff910 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -52,7 +52,7 @@ static inline char *cc_dma_buf_type(enum cc_req_dma_buf_type type)
 static void cc_copy_mac(struct device *dev, struct aead_request *req,
 			enum cc_sg_cpy_direct dir)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	u32 skip = req->assoclen + req->cryptlen;
 
 	cc_copy_sg_portion(dev, areq_ctx->backup_mac, req->src,
@@ -456,7 +456,7 @@ int cc_map_cipher_request(struct cc_drvdata *drvdata, void *ctx,
 
 void cc_unmap_aead_request(struct device *dev, struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	unsigned int hw_iv_size = areq_ctx->hw_iv_size;
 	struct cc_drvdata *drvdata = dev_get_drvdata(dev);
 	int src_direction = (req->src != req->dst ? DMA_TO_DEVICE : DMA_BIDIRECTIONAL);
@@ -546,7 +546,7 @@ static int cc_aead_chain_iv(struct cc_drvdata *drvdata,
 			    struct buffer_array *sg_data,
 			    bool is_last, bool do_chain)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	unsigned int hw_iv_size = areq_ctx->hw_iv_size;
 	struct device *dev = drvdata_to_dev(drvdata);
 	gfp_t flags = cc_gfp_flags(&req->base);
@@ -586,7 +586,7 @@ static int cc_aead_chain_assoc(struct cc_drvdata *drvdata,
 			       struct buffer_array *sg_data,
 			       bool is_last, bool do_chain)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	int rc = 0;
 	int mapped_nents = 0;
 	struct device *dev = drvdata_to_dev(drvdata);
@@ -652,7 +652,7 @@ static int cc_aead_chain_assoc(struct cc_drvdata *drvdata,
 static void cc_prepare_aead_data_dlli(struct aead_request *req,
 				      u32 *src_last_bytes, u32 *dst_last_bytes)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	enum drv_crypto_direction direct = areq_ctx->gen_ctx.op_type;
 	unsigned int authsize = areq_ctx->req_authsize;
 	struct scatterlist *sg;
@@ -678,7 +678,7 @@ static void cc_prepare_aead_data_mlli(struct cc_drvdata *drvdata,
 				      u32 *src_last_bytes, u32 *dst_last_bytes,
 				      bool is_last_table)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	enum drv_crypto_direction direct = areq_ctx->gen_ctx.op_type;
 	unsigned int authsize = areq_ctx->req_authsize;
 	struct device *dev = drvdata_to_dev(drvdata);
@@ -790,7 +790,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 			      struct buffer_array *sg_data,
 			      bool is_last_table, bool do_chain)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	struct device *dev = drvdata_to_dev(drvdata);
 	enum drv_crypto_direction direct = areq_ctx->gen_ctx.op_type;
 	unsigned int authsize = areq_ctx->req_authsize;
@@ -895,7 +895,7 @@ static int cc_aead_chain_data(struct cc_drvdata *drvdata,
 static void cc_update_aead_mlli_nents(struct cc_drvdata *drvdata,
 				      struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	u32 curr_mlli_size = 0;
 
 	if (areq_ctx->assoc_buff_type == CC_DMA_BUF_MLLI) {
@@ -945,7 +945,7 @@ static void cc_update_aead_mlli_nents(struct cc_drvdata *drvdata,
 
 int cc_map_aead_request(struct cc_drvdata *drvdata, struct aead_request *req)
 {
-	struct aead_req_ctx *areq_ctx = aead_request_ctx(req);
+	struct aead_req_ctx *areq_ctx = aead_request_ctx_dma(req);
 	struct mlli_params *mlli_params = &areq_ctx->mlli_params;
 	struct device *dev = drvdata_to_dev(drvdata);
 	struct buffer_array sg_data;
diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index 683c9a430e11..f418162932fe 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -283,9 +283,9 @@ static void cc_unmap_result(struct device *dev, struct ahash_req_ctx *state,
 static void cc_update_complete(struct device *dev, void *cc_req, int err)
 {
 	struct ahash_request *req = (struct ahash_request *)cc_req;
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 
 	dev_dbg(dev, "req=%pK\n", req);
 
@@ -301,9 +301,9 @@ static void cc_update_complete(struct device *dev, void *cc_req, int err)
 static void cc_digest_complete(struct device *dev, void *cc_req, int err)
 {
 	struct ahash_request *req = (struct ahash_request *)cc_req;
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 
 	dev_dbg(dev, "req=%pK\n", req);
@@ -321,9 +321,9 @@ static void cc_digest_complete(struct device *dev, void *cc_req, int err)
 static void cc_hash_complete(struct device *dev, void *cc_req, int err)
 {
 	struct ahash_request *req = (struct ahash_request *)cc_req;
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 
 	dev_dbg(dev, "req=%pK\n", req);
@@ -341,9 +341,9 @@ static void cc_hash_complete(struct device *dev, void *cc_req, int err)
 static int cc_fin_result(struct cc_hw_desc *desc, struct ahash_request *req,
 			 int idx)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 
 	/* Get final MAC result */
@@ -364,9 +364,9 @@ static int cc_fin_result(struct cc_hw_desc *desc, struct ahash_request *req,
 static int cc_fin_hmac(struct cc_hw_desc *desc, struct ahash_request *req,
 		       int idx)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 
 	/* store the hash digest result in the context */
@@ -417,9 +417,9 @@ static int cc_fin_hmac(struct cc_hw_desc *desc, struct ahash_request *req,
 
 static int cc_hash_digest(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 	struct scatterlist *src = req->src;
 	unsigned int nbytes = req->nbytes;
@@ -555,9 +555,9 @@ static int cc_restore_hash(struct cc_hw_desc *desc, struct cc_hash_ctx *ctx,
 
 static int cc_hash_update(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	unsigned int block_size = crypto_tfm_alg_blocksize(&tfm->base);
 	struct scatterlist *src = req->src;
 	unsigned int nbytes = req->nbytes;
@@ -631,9 +631,9 @@ static int cc_hash_update(struct ahash_request *req)
 
 static int cc_do_finup(struct ahash_request *req, bool update)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 	struct scatterlist *src = req->src;
 	unsigned int nbytes = req->nbytes;
@@ -711,9 +711,9 @@ static int cc_hash_final(struct ahash_request *req)
 
 static int cc_hash_init(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 
 	dev_dbg(dev, "===== init (%d) ====\n", req->nbytes);
@@ -736,7 +736,7 @@ static int cc_hash_setkey(struct crypto_ahash *ahash, const u8 *key,
 	u32 larval_addr;
 	struct device *dev;
 
-	ctx = crypto_ahash_ctx(ahash);
+	ctx = crypto_ahash_ctx_dma(ahash);
 	dev = drvdata_to_dev(ctx->drvdata);
 	dev_dbg(dev, "start keylen: %d", keylen);
 
@@ -922,7 +922,7 @@ static int cc_xcbc_setkey(struct crypto_ahash *ahash,
 			  const u8 *key, unsigned int keylen)
 {
 	struct cc_crypto_req cc_req = {};
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	int rc = 0;
 	unsigned int idx = 0;
@@ -1007,7 +1007,7 @@ static int cc_xcbc_setkey(struct crypto_ahash *ahash,
 static int cc_cmac_setkey(struct crypto_ahash *ahash,
 			  const u8 *key, unsigned int keylen)
 {
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 
 	dev_dbg(dev, "===== setkey (%d) ====\n", keylen);
@@ -1109,7 +1109,7 @@ static int cc_alloc_ctx(struct cc_hash_ctx *ctx)
 
 static int cc_get_hash_len(struct crypto_tfm *tfm)
 {
-	struct cc_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 
 	if (ctx->hash_mode == DRV_HASH_SM3)
 		return CC_SM3_HASH_LEN_SIZE;
@@ -1119,7 +1119,7 @@ static int cc_get_hash_len(struct crypto_tfm *tfm)
 
 static int cc_cra_init(struct crypto_tfm *tfm)
 {
-	struct cc_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 	struct hash_alg_common *hash_alg_common =
 		container_of(tfm->__crt_alg, struct hash_alg_common, base);
 	struct ahash_alg *ahash_alg =
@@ -1127,8 +1127,8 @@ static int cc_cra_init(struct crypto_tfm *tfm)
 	struct cc_hash_alg *cc_alg =
 			container_of(ahash_alg, struct cc_hash_alg, ahash_alg);
 
-	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
-				 sizeof(struct ahash_req_ctx));
+	crypto_ahash_set_reqsize_dma(__crypto_ahash_cast(tfm),
+				     sizeof(struct ahash_req_ctx));
 
 	ctx->hash_mode = cc_alg->hash_mode;
 	ctx->hw_mode = cc_alg->hw_mode;
@@ -1140,7 +1140,7 @@ static int cc_cra_init(struct crypto_tfm *tfm)
 
 static void cc_cra_exit(struct crypto_tfm *tfm)
 {
-	struct cc_hash_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_tfm_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 
 	dev_dbg(dev, "cc_cra_exit");
@@ -1149,9 +1149,9 @@ static void cc_cra_exit(struct crypto_tfm *tfm)
 
 static int cc_mac_update(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	unsigned int block_size = crypto_tfm_alg_blocksize(&tfm->base);
 	struct cc_crypto_req cc_req = {};
@@ -1217,9 +1217,9 @@ static int cc_mac_update(struct ahash_request *req)
 
 static int cc_mac_final(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct cc_crypto_req cc_req = {};
 	struct cc_hw_desc desc[CC_MAX_HASH_SEQ_LEN];
@@ -1338,9 +1338,9 @@ static int cc_mac_final(struct ahash_request *req)
 
 static int cc_mac_finup(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	struct cc_crypto_req cc_req = {};
 	struct cc_hw_desc desc[CC_MAX_HASH_SEQ_LEN];
@@ -1419,9 +1419,9 @@ static int cc_mac_finup(struct ahash_request *req)
 
 static int cc_mac_digest(struct ahash_request *req)
 {
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
 	u32 digestsize = crypto_ahash_digestsize(tfm);
 	struct cc_crypto_req cc_req = {};
@@ -1499,8 +1499,8 @@ static int cc_mac_digest(struct ahash_request *req)
 static int cc_hash_export(struct ahash_request *req, void *out)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(ahash);
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	u8 *curr_buff = cc_hash_buf(state);
 	u32 curr_buff_cnt = *cc_hash_buf_cnt(state);
 	const u32 tmp = CC_EXPORT_MAGIC;
@@ -1525,9 +1525,9 @@ static int cc_hash_export(struct ahash_request *req, void *out)
 static int cc_hash_import(struct ahash_request *req, const void *in)
 {
 	struct crypto_ahash *ahash = crypto_ahash_reqtfm(req);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(ahash);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(ahash);
 	struct device *dev = drvdata_to_dev(ctx->drvdata);
-	struct ahash_req_ctx *state = ahash_request_ctx(req);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(req);
 	u32 tmp;
 
 	memcpy(&tmp, in, sizeof(u32));
@@ -1846,7 +1846,7 @@ static struct cc_hash_alg *cc_alloc_hash_alg(struct cc_hash_template *template,
 			 template->driver_name);
 	}
 	alg->cra_module = THIS_MODULE;
-	alg->cra_ctxsize = sizeof(struct cc_hash_ctx);
+	alg->cra_ctxsize = sizeof(struct cc_hash_ctx) + crypto_dma_padding();
 	alg->cra_priority = CC_CRA_PRIO;
 	alg->cra_blocksize = template->blocksize;
 	alg->cra_alignmask = 0;
@@ -2073,9 +2073,9 @@ static void cc_setup_xcbc(struct ahash_request *areq, struct cc_hw_desc desc[],
 			  unsigned int *seq_size)
 {
 	unsigned int idx = *seq_size;
-	struct ahash_req_ctx *state = ahash_request_ctx(areq);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(areq);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 
 	/* Setup XCBC MAC K1 */
 	hw_desc_init(&desc[idx]);
@@ -2130,9 +2130,9 @@ static void cc_setup_cmac(struct ahash_request *areq, struct cc_hw_desc desc[],
 			  unsigned int *seq_size)
 {
 	unsigned int idx = *seq_size;
-	struct ahash_req_ctx *state = ahash_request_ctx(areq);
+	struct ahash_req_ctx *state = ahash_request_ctx_dma(areq);
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(areq);
-	struct cc_hash_ctx *ctx = crypto_ahash_ctx(tfm);
+	struct cc_hash_ctx *ctx = crypto_ahash_ctx_dma(tfm);
 
 	/* Setup CMAC Key */
 	hw_desc_init(&desc[idx]);
