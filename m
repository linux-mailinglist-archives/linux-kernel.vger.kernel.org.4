Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE26BE136
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCQG1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCQG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:26:59 -0400
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB3B71B3;
        Thu, 16 Mar 2023 23:26:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 112831A00AE2;
        Fri, 17 Mar 2023 14:26:54 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WitBJxWGFz4N; Fri, 17 Mar 2023 14:26:53 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 727801A00ADF;
        Fri, 17 Mar 2023 14:26:52 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfshcina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] crypto: remove unnecessary (void*) conversions
Date:   Fri, 17 Mar 2023 14:26:03 +0800
Message-Id: <20230317062603.1729-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_VALIDITY_RPBL,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer variables of void * type do not require type cast.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/crypto/hifn_795x.c | 24 ++++++++++++------------
 drivers/crypto/img-hash.c  |  2 +-
 drivers/crypto/sa2ul.c     |  6 +++---
 drivers/crypto/sahara.c    |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index 5a7f6611803c..8e4a49b7ab4f 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -879,7 +879,7 @@ static int hifn_enable_crypto(struct hifn_device *dev)
 
 static void hifn_init_dma(struct hifn_device *dev)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	u32 dptr = dev->desc_dma;
 	int i;
 
@@ -1072,7 +1072,7 @@ static int hifn_setup_crypto_command(struct hifn_device *dev,
 		u8 *buf, unsigned dlen, unsigned slen,
 		u8 *key, int keylen, u8 *iv, int ivsize, u16 mode)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	struct hifn_crypt_command *cry_cmd;
 	u8 *buf_pos = buf;
 	u16 cmd_len;
@@ -1113,7 +1113,7 @@ static int hifn_setup_cmd_desc(struct hifn_device *dev,
 		struct hifn_context *ctx, struct hifn_request_context *rctx,
 		void *priv, unsigned int nbytes)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	int cmd_len, sa_idx;
 	u8 *buf, *buf_pos;
 	u16 mask;
@@ -1231,7 +1231,7 @@ static int hifn_setup_cmd_desc(struct hifn_device *dev,
 static int hifn_setup_src_desc(struct hifn_device *dev, struct page *page,
 		unsigned int offset, unsigned int size, int last)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	int idx;
 	dma_addr_t addr;
 
@@ -1264,7 +1264,7 @@ static int hifn_setup_src_desc(struct hifn_device *dev, struct page *page,
 
 static void hifn_setup_res_desc(struct hifn_device *dev)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 
 	dma->resr[dma->resi].l = __cpu_to_le32(HIFN_USED_RESULT |
 			HIFN_D_VALID | HIFN_D_LAST);
@@ -1290,7 +1290,7 @@ static void hifn_setup_res_desc(struct hifn_device *dev)
 static void hifn_setup_dst_desc(struct hifn_device *dev, struct page *page,
 		unsigned offset, unsigned size, int last)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	int idx;
 	dma_addr_t addr;
 
@@ -1710,7 +1710,7 @@ static void hifn_process_ready(struct skcipher_request *req, int error)
 
 static void hifn_clear_rings(struct hifn_device *dev, int error)
 {
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	int i, u;
 
 	dev_dbg(&dev->pdev->dev, "ring cleanup 1: i: %d.%d.%d.%d, u: %d.%d.%d.%d, "
@@ -1784,7 +1784,7 @@ static void hifn_work(struct work_struct *work)
 
 	spin_lock_irqsave(&dev->lock, flags);
 	if (dev->active == 0) {
-		struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+		struct hifn_dma *dma = dev->desc_virt;
 
 		if (dma->cmdu == 0 && (dev->flags & HIFN_FLAG_CMD_BUSY)) {
 			dev->flags &= ~HIFN_FLAG_CMD_BUSY;
@@ -1815,7 +1815,7 @@ static void hifn_work(struct work_struct *work)
 	if (reset) {
 		if (++dev->reset >= 5) {
 			int i;
-			struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+			struct hifn_dma *dma = dev->desc_virt;
 
 			dev_info(&dev->pdev->dev,
 				 "r: %08x, active: %d, started: %d, "
@@ -1848,8 +1848,8 @@ static void hifn_work(struct work_struct *work)
 
 static irqreturn_t hifn_interrupt(int irq, void *data)
 {
-	struct hifn_device *dev = (struct hifn_device *)data;
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_device *dev = data;
+	struct hifn_dma *dma = dev->desc_virt;
 	u32 dmacsr, restart;
 
 	dmacsr = hifn_read_1(dev, HIFN_1_DMA_CSR);
@@ -1914,7 +1914,7 @@ static void hifn_flush(struct hifn_device *dev)
 	unsigned long flags;
 	struct crypto_async_request *async_req;
 	struct skcipher_request *req;
-	struct hifn_dma *dma = (struct hifn_dma *)dev->desc_virt;
+	struct hifn_dma *dma = dev->desc_virt;
 	int i;
 
 	for (i = 0; i < HIFN_D_RES_RSIZE; ++i) {
diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index fe93d19e3044..00e5e709af65 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -209,7 +209,7 @@ static int img_hash_xmit_cpu(struct img_hash_dev *hdev, const u8 *buf,
 
 static void img_hash_dma_callback(void *data)
 {
-	struct img_hash_dev *hdev = (struct img_hash_dev *)data;
+	struct img_hash_dev *hdev = data;
 	struct img_hash_request_ctx *ctx = ahash_request_ctx(hdev->req);
 
 	if (ctx->bufcnt) {
diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index f4bc06c24ad8..df5f9d675c57 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1037,7 +1037,7 @@ static void sa_free_sa_rx_data(struct sa_rx_data *rxd)
 
 static void sa_aes_dma_in_callback(void *data)
 {
-	struct sa_rx_data *rxd = (struct sa_rx_data *)data;
+	struct sa_rx_data *rxd = data;
 	struct skcipher_request *req;
 	u32 *result;
 	__be32 *mdptr;
@@ -1351,7 +1351,7 @@ static int sa_decrypt(struct skcipher_request *req)
 
 static void sa_sha_dma_in_callback(void *data)
 {
-	struct sa_rx_data *rxd = (struct sa_rx_data *)data;
+	struct sa_rx_data *rxd = data;
 	struct ahash_request *req;
 	struct crypto_ahash *tfm;
 	unsigned int authsize;
@@ -1689,7 +1689,7 @@ static void sa_sha_cra_exit(struct crypto_tfm *tfm)
 
 static void sa_aead_dma_in_callback(void *data)
 {
-	struct sa_rx_data *rxd = (struct sa_rx_data *)data;
+	struct sa_rx_data *rxd = data;
 	struct aead_request *req;
 	struct crypto_aead *tfm;
 	unsigned int start;
diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index dd4c703cd855..4c799df3e883 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1035,7 +1035,7 @@ static int sahara_sha_process(struct ahash_request *req)
 
 static int sahara_queue_manage(void *data)
 {
-	struct sahara_dev *dev = (struct sahara_dev *)data;
+	struct sahara_dev *dev = data;
 	struct crypto_async_request *async_req;
 	struct crypto_async_request *backlog;
 	int ret = 0;
@@ -1270,7 +1270,7 @@ static struct ahash_alg sha_v4_algs[] = {
 
 static irqreturn_t sahara_irq_handler(int irq, void *data)
 {
-	struct sahara_dev *dev = (struct sahara_dev *)data;
+	struct sahara_dev *dev = data;
 	unsigned int stat = sahara_read(dev, SAHARA_REG_STATUS);
 	unsigned int err = sahara_read(dev, SAHARA_REG_ERRSTATUS);
 
-- 
2.11.0

