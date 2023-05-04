Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782EA6F1FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346871AbjD1U5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbjD1U4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:56:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3637459F2;
        Fri, 28 Apr 2023 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715376; x=1714251376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccJ7ex3fYIuaj8/TVXqPLF+MfKcH1klXSYN6/oR20DY=;
  b=ZGfuvTjd3eX8Ub6TOq01ivtRkS+Y+6FBQh/ruvX3ku8FRJQpgXrezzTF
   9D4TIjLdC371VSBf5ZUcGZrdfO7q5pbCdLs2++kuze7Qel8SgIXbzMz73
   iRFAf1lZbwLIZSttCZQKl+qaZwDw0AJpSkZikDPGRu12EftbavHUsCU9m
   KUsZliTg7Noy5Ci9PYAYwIvcE4VsiVU3rONjwhjfZGjWlHZasv9ErOFtu
   5FiRBKlEMuyL9b4XpDgOI6SzajZZBTtF+W2eCWZf4fdQ8SMp4wGSRCa5Z
   jjJz56WMbzwV3XMx4Q+gPDq1CvwC3KsVVxXcwRpd8TugkcGQRWZ/fq/XC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336937740"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="336937740"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:56:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="838980653"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="838980653"
Received: from ykaur1-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.209.181.29])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:56:14 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 14/15] crypto: iaa - Add irq support for the crypto async interface
Date:   Fri, 28 Apr 2023 15:55:38 -0500
Message-Id: <20230428205539.113902-15-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
References: <20230428205539.113902-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing iaa crypto async support provides an implementation that
satisfies the interface but does so in a synchronous manner - it fills
and submits the IDXD descriptor and then waits for it to complete
before returning.  This isn't a problem at the moment, since all
existing callers (e.g. zswap) wrap any asynchronous callees in a
synchronous wrapper anyway.

This change makes the iaa crypto async implementation truly
asynchronous: it fills and submits the IDXD descriptor, then returns
immediately with -EINPROGRESS.  It also sets the descriptor's 'request
completion irq' bit and sets up a callback with the IDXD driver which
is called when the operation completes and the irq fires.  The
existing callers such as zswap use synchronous wrappers to deal with
-EINPROGRESS and so work as expected without any changes.

This mode can be enabled by writing 'async_irq' to the sync_mode
iaa_crypto driver attribute:

  echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode

Async mode without interrupts (caller must poll) can be enabled by
writing 'async' to it:

  echo async > /sys/bus/dsa/drivers/crypto/sync_mode

The default sync mode can be enabled by writing 'sync' to it:

  echo sync > /sys/bus/dsa/drivers/crypto/sync_mode

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 226 ++++++++++++++++++++-
 1 file changed, 224 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index c82e002043bb..b1293400d466 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -117,6 +117,102 @@ static ssize_t verify_compress_store(struct device_driver *driver,
 }
 static DRIVER_ATTR_RW(verify_compress);
 
+/*
+ * The iaa crypto driver supports three 'sync' methods determining how
+ * compressions and decompressions are performed:
+ *
+ * - sync:      the compression or decompression completes before
+ *              returning.  This is the mode used by the async crypto
+ *              interface when the sync mode is set to 'sync' and by
+ *              the sync crypto interface regardless of setting.
+ *
+ * - async:     the compression or decompression is submitted and returns
+ *              immediately.  Completion interrupts are not used so
+ *              the caller is responsible for polling the descriptor
+ *              for completion.  This mode is applicable to only the
+ *              async crypto interface and is ignored for anything
+ *              else.
+ *
+ * - async_irq: the compression or decompression is submitted and
+ *              returns immediately.  Completion interrupts are
+ *              enabled so the caller can wait for the completion and
+ *              yield to other threads.  When the compression or
+ *              decompression completes, the completion is signaled
+ *              and the caller awakened.  This mode is applicable to
+ *              only the async crypto interface and is ignored for
+ *              anything else.
+ *
+ * These modes can be set using the iaa_crypto sync_mode driver
+ * attribute.
+ */
+
+/* Use async mode */
+static bool async_mode;
+/* Use interrupts */
+static bool use_irq;
+
+/**
+ * set_iaa_sync_mode - Set IAA sync mode
+ * @name: The name of the sync mode
+ *
+ * Make the IAA sync mode named @name the current sync mode used by
+ * compression/decompression.
+ */
+
+static int set_iaa_sync_mode(const char *name)
+{
+	int ret = 0;
+
+	if (sysfs_streq(name, "sync")) {
+		async_mode = false;
+		use_irq = false;
+	} else if (sysfs_streq(name, "async")) {
+		async_mode = true;
+		use_irq = false;
+	} else if (sysfs_streq(name, "async_irq")) {
+		async_mode = true;
+		use_irq = true;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t sync_mode_show(struct device_driver *driver, char *buf)
+{
+	int ret = 0;
+
+	if (!async_mode && !use_irq)
+		ret = sprintf(buf, "%s\n", "sync");
+	else if (async_mode && !use_irq)
+		ret = sprintf(buf, "%s\n", "async");
+	else if (async_mode && use_irq)
+		ret = sprintf(buf, "%s\n", "async_irq");
+
+	return ret;
+}
+
+static ssize_t sync_mode_store(struct device_driver *driver,
+			       const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = set_iaa_sync_mode(buf);
+	if (ret == 0)
+		ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(sync_mode);
+
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 static int active_compression_mode;
 
@@ -1073,6 +1169,73 @@ static inline int check_completion(struct device *dev,
 	return ret;
 }
 
+static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
+			       struct idxd_wq *wq,
+			       dma_addr_t src_addr, unsigned int slen,
+			       dma_addr_t dst_addr, unsigned int *dlen,
+			       u32 compression_crc);
+
+static void iaa_desc_complete(struct idxd_desc *idxd_desc,
+			      enum idxd_complete_type comp_type,
+			      bool free_desc, void *__ctx,
+			      u32 *status)
+{
+	struct crypto_ctx *ctx = __ctx;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret, err = 0;
+
+	iaa_wq = idxd_wq_private(idxd_desc->wq);
+	idxd = iaa_wq->iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	dev_dbg(dev, "%s: compression mode %s,"
+		" ctx->src_addr %llx, ctx->dst_addr %llx\n", __func__,
+		iaa_wq->iaa_device->active_compression_mode->name,
+		ctx->src_addr, ctx->dst_addr);
+
+	ret = check_completion(dev, idxd_desc->iax_completion,
+			       ctx->compress, false);
+	if (ret) {
+		dev_dbg(dev, "%s: check_completion failed ret=%d\n", __func__, ret);
+		err = -EIO;
+		goto err;
+	}
+
+	ctx->req->dlen = idxd_desc->iax_completion->output_size;
+
+	if (ctx->compress && iaa_verify_compress) {
+		u32 compression_crc;
+
+		compression_crc = idxd_desc->iax_completion->crc;
+		dma_sync_sg_for_device(dev, ctx->req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, ctx->req->src, 1, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(ctx->tfm, ctx->req, iaa_wq->wq, ctx->src_addr,
+					  ctx->req->slen, ctx->dst_addr, &ctx->req->dlen,
+					  compression_crc);
+		if (ret) {
+			dev_dbg(dev, "%s: compress verify failed ret=%d\n", __func__, ret);
+			err = -EIO;
+		}
+	}
+err:
+	if (ctx->req->base.complete)
+		acomp_request_complete(ctx->req, err);
+
+	dma_unmap_sg(dev, ctx->req->dst, sg_nents(ctx->req->dst), DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, ctx->req->src, sg_nents(ctx->req->src), DMA_TO_DEVICE);
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
+
+	if (free_desc)
+		idxd_free_desc(idxd_desc->wq, idxd_desc);
+	iaa_wq_put(idxd_desc->wq);
+}
+
 static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 			struct idxd_wq *wq,
 			dma_addr_t src_addr, unsigned int slen,
@@ -1118,6 +1281,22 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 	desc->src2_size = sizeof(struct aecs_comp_table_record);
 	desc->completion_addr = idxd_desc->compl_dma;
 
+	if (use_irq) {
+		desc->flags |= IDXD_OP_FLAG_RCI;
+
+		idxd_desc->crypto.req = req;
+		idxd_desc->crypto.tfm = tfm;
+		idxd_desc->crypto.src_addr = src_addr;
+		idxd_desc->crypto.dst_addr = dst_addr;
+		idxd_desc->crypto.compress = true;
+
+		dev_dbg(dev, "%s use_async_irq: compression mode %s,"
+			" src_addr %llx, dst_addr %llx\n", __func__,
+			iaa_wq->iaa_device->active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: compression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1132,6 +1311,12 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 		goto err;
 	}
 
+	if (async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, true, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1142,7 +1327,8 @@ static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
 
 	*compression_crc = idxd_desc->iax_completion->crc;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1295,6 +1481,22 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		desc->flags |= IDXD_OP_FLAG_RD_SRC2_AECS;
 	}
 
+	if (use_irq && !disable_async) {
+		desc->flags |= IDXD_OP_FLAG_RCI;
+
+		idxd_desc->crypto.req = req;
+		idxd_desc->crypto.tfm = tfm;
+		idxd_desc->crypto.src_addr = src_addr;
+		idxd_desc->crypto.dst_addr = dst_addr;
+		idxd_desc->crypto.compress = false;
+
+		dev_dbg(dev, "%s: use_async_irq compression mode %s,"
+			" src_addr %llx, dst_addr %llx\n", __func__,
+			iaa_wq->iaa_device->active_compression_mode->name,
+			src_addr, dst_addr);
+	} else if (async_mode && !disable_async)
+		req->base.data = idxd_desc;
+
 	dev_dbg(dev, "%s: decompression mode %s,"
 		" desc->src1_addr %llx, desc->src1_size %d,"
 		" desc->dst_addr %llx, desc->max_dst_size %d,"
@@ -1309,6 +1511,12 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 		goto err;
 	}
 
+	if (async_mode && !disable_async) {
+		ret = -EINPROGRESS;
+		dev_dbg(dev, "%s: returning -EINPROGRESS\n", __func__);
+		goto out;
+	}
+
 	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
 	if (ret) {
 		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
@@ -1317,7 +1525,8 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 
 	*dlen = idxd_desc->iax_completion->output_size;
 
-	idxd_free_desc(wq, idxd_desc);
+	if (!async_mode)
+		idxd_free_desc(wq, idxd_desc);
 out:
 	return ret;
 err:
@@ -1779,6 +1988,7 @@ static struct idxd_device_driver iaa_crypto_driver = {
 	.remove = iaa_crypto_remove,
 	.name = IDXD_SUBDRIVER_NAME,
 	.type = dev_types,
+	.desc_complete = iaa_desc_complete,
 };
 
 static int __init iaa_crypto_init_module(void)
@@ -1821,10 +2031,20 @@ static int __init iaa_crypto_init_module(void)
 		goto err_verify_attr_create;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_sync_mode);
+	if (ret) {
+		pr_debug("IAA sync mode attr creation failed\n");
+		goto err_sync_attr_create;
+	}
+
 	pr_debug("initialized\n");
 out:
 	return ret;
 
+err_sync_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 err_verify_attr_create:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
@@ -1843,6 +2063,8 @@ static void __exit iaa_crypto_cleanup_module(void)
 	if (iaa_unregister_compression_device())
 		pr_debug("IAA compression device unregister failed\n");
 
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_compression_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
-- 
2.34.1

