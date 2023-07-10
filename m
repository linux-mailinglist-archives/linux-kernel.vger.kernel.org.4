Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819874DDE5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjGJTI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjGJTIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:08:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA221AA;
        Mon, 10 Jul 2023 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689016049; x=1720552049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s749hV2cG8QjwVJFsDpv54QK8I1TXwPz5zms2JhjWZc=;
  b=ScATBEhlF9Zvn41r3O+WyuhNztpeXT+r8BuhSgqETb4KebqaGLFJ8JOs
   YNdD3Q2a+e40KZcNTVEP/OZcAJXVebKdZtIaq+zSzwKbqP1wPZk9pINjq
   DVvc/N9S7FdCBfOzj0czmDue+oy8rPnEhJWHK8V/z8o0Ip9dVGkfht/XS
   f301GCdGYIx4LwaRxwatphOgiyENV4A5iNbVGbreB/z0mBqcF16P/jLqs
   yWXGCrk2pXrdqx1B3c8qzB4V4iIYTI6x2yUfIvdnmxtVhAF2Ji80DYLzr
   JGbjSyolm0a1OzXCemlUvczYlcxvu2AoSs0GkpGSzwjAYiaH5MPUNxudF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="354290853"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="354290853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="844991161"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="844991161"
Received: from jdmillsx-mobl1.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.212.107.12])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 12:07:24 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v7 12/14] crypto: iaa - Add support for deflate-iaa compression algorithm
Date:   Mon, 10 Jul 2023 14:06:52 -0500
Message-Id: <20230710190654.299639-13-tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch registers the deflate-iaa deflate compression algorithm and
hooks it up to the IAA hardware using the 'fixed' compression mode
introduced in the previous patch.

Because the IAA hardware has a 4k history-window limitation, only
buffers <= 4k, or that have been compressed using a <= 4k history
window, are technically compliant with the deflate spec, which allows
for a window of up to 32k.  Because of this limitation, the IAA fixed
mode deflate algorithm is given its own algorithm name, 'deflate-iaa'.

With this change, the deflate-iaa crypto algorithm is registered and
operational, and compression and decompression operations are fully
enabled following the successful binding of the first IAA workqueue
to the iaa_crypto sub-driver.

when there are no IAA workqueues bound to the driver, the IAA crypto
algorithm can be unregistered by removing the module.

A new iaa_crypto 'verify_compress' driver attribute is also added,
allowing the user to toggle compression verification.  If set, each
compress will be internally decompressed and the contents verified,
returning error codes if unsuccessful.  This can be toggled with 0/1:

  echo 0 > /sys/bus/dsa/drivers/crypto/verify_compress

The default setting is '1' - verify all compresses.

The verify_compress value setting at the time the algorithm is
registered is captured in the algorithm's crypto_ctx and used for all
compresses when using the algorithm.

[ Based on work originally by George Powley, Jing Lin and Kyung Min
Park ]

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 crypto/testmgr.c                           |  10 +
 drivers/crypto/intel/iaa/iaa_crypto.h      |  36 +
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 921 ++++++++++++++++++++-
 3 files changed, 950 insertions(+), 17 deletions(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 216878c8bc3d..b6d924e0ff59 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4819,6 +4819,16 @@ static const struct alg_test_desc alg_test_descs[] = {
 				.decomp = __VECS(deflate_decomp_tv_template)
 			}
 		}
+	}, {
+		.alg = "deflate-iaa",
+		.test = alg_test_comp,
+		.fips_allowed = 1,
+		.suite = {
+			.comp = {
+				.comp = __VECS(deflate_comp_tv_template),
+				.decomp = __VECS(deflate_decomp_tv_template)
+			}
+		}
 	}, {
 		.alg = "dh",
 		.test = alg_test_kpp,
diff --git a/drivers/crypto/intel/iaa/iaa_crypto.h b/drivers/crypto/intel/iaa/iaa_crypto.h
index 33e68f9d3d02..4c6b0f5a6b50 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto.h
@@ -10,15 +10,42 @@
 
 #define IDXD_SUBDRIVER_NAME		"crypto"
 
+#define IAA_DECOMP_ENABLE		BIT(0)
+#define IAA_DECOMP_FLUSH_OUTPUT		BIT(1)
+#define IAA_DECOMP_CHECK_FOR_EOB	BIT(2)
+#define IAA_DECOMP_STOP_ON_EOB		BIT(3)
+#define IAA_DECOMP_SUPPRESS_OUTPUT	BIT(9)
+
+#define IAA_COMP_FLUSH_OUTPUT		BIT(1)
+#define IAA_COMP_APPEND_EOB		BIT(2)
+
+#define IAA_COMPLETION_TIMEOUT		1000000
+
+#define IAA_ANALYTICS_ERROR		0x0a
+#define IAA_ERROR_DECOMP_BUF_OVERFLOW	0x0b
+#define IAA_ERROR_COMP_BUF_OVERFLOW	0x19
+#define IAA_ERROR_WATCHDOG_EXPIRED	0x24
+
 #define IAA_COMP_MODES_MAX		2
 
 #define FIXED_HDR			0x2
 #define FIXED_HDR_SIZE			3
 
+#define IAA_COMP_FLAGS			(IAA_COMP_FLUSH_OUTPUT | \
+					 IAA_COMP_APPEND_EOB)
+
+#define IAA_DECOMP_FLAGS		(IAA_DECOMP_ENABLE |	   \
+					 IAA_DECOMP_FLUSH_OUTPUT | \
+					 IAA_DECOMP_CHECK_FOR_EOB | \
+					 IAA_DECOMP_STOP_ON_EOB)
+
 /* Representation of IAA workqueue */
 struct iaa_wq {
 	struct list_head	list;
+
 	struct idxd_wq		*wq;
+	int			ref;
+	bool			remove;
 
 	struct iaa_device	*iaa_device;
 };
@@ -119,4 +146,13 @@ int add_iaa_compression_mode(const char *name,
 
 void remove_iaa_compression_mode(const char *name);
 
+enum iaa_mode {
+	IAA_MODE_FIXED,
+};
+
+struct iaa_compression_ctx {
+	enum iaa_mode	mode;
+	bool		verify_compress;
+};
+
 #endif
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 0c59332456f0..9b4acc343582 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/idxd.h>
 #include <linux/highmem.h>
 #include <linux/sched/smt.h>
+#include <crypto/internal/acompress.h>
 
 #include "idxd.h"
 #include "iaa_crypto.h"
@@ -32,6 +33,20 @@ static unsigned int cpus_per_iaa;
 /* Per-cpu lookup table for balanced wqs */
 static struct wq_table_entry __percpu *wq_table;
 
+static struct idxd_wq *wq_table_next_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
+
+	if (++entry->cur_wq >= entry->n_wqs)
+		entry->cur_wq = 0;
+
+	pr_debug("%s: returning wq at idx %d (iaa wq %d.%d) from cpu %d\n", __func__,
+		 entry->cur_wq, entry->wqs[entry->cur_wq]->idxd->id,
+		 entry->wqs[entry->cur_wq]->id, cpu);
+
+	return entry->wqs[entry->cur_wq];
+}
+
 static void wq_table_add(int cpu, struct idxd_wq *wq)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
@@ -66,6 +81,40 @@ static void wq_table_clear_entry(int cpu)
 static LIST_HEAD(iaa_devices);
 static DEFINE_MUTEX(iaa_devices_lock);
 
+/* If enabled, IAA hw crypto algos are registered, unavailable otherwise */
+static bool iaa_crypto_enabled;
+static bool iaa_crypto_registered;
+
+/* Verify results of IAA compress or not */
+static bool iaa_verify_compress = true;
+
+static ssize_t verify_compress_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", iaa_verify_compress);
+}
+
+static ssize_t verify_compress_store(struct device_driver *driver,
+				     const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtobool(buf, &iaa_verify_compress);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(verify_compress);
+
 static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 
 static int find_empty_iaa_compression_mode(void)
@@ -250,6 +299,12 @@ int add_iaa_compression_mode(const char *name,
 }
 EXPORT_SYMBOL_GPL(add_iaa_compression_mode);
 
+static struct iaa_device_compression_mode *
+get_iaa_device_compression_mode(struct iaa_device *iaa_device, int idx)
+{
+	return iaa_device->compression_modes[idx];
+}
+
 static void free_device_compression_mode(struct iaa_device *iaa_device,
 					 struct iaa_device_compression_mode *device_mode)
 {
@@ -268,6 +323,86 @@ static void free_device_compression_mode(struct iaa_device *iaa_device,
 	kfree(device_mode);
 }
 
+#define IDXD_OP_FLAG_AECS_RW_TGLS       0x400000
+#define IAX_AECS_DEFAULT_FLAG (IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC)
+#define IAX_AECS_COMPRESS_FLAG	(IAX_AECS_DEFAULT_FLAG | IDXD_OP_FLAG_RD_SRC2_AECS)
+#define IAX_AECS_DECOMPRESS_FLAG (IAX_AECS_DEFAULT_FLAG | IDXD_OP_FLAG_RD_SRC2_AECS)
+#define IAX_AECS_GEN_FLAG (IAX_AECS_DEFAULT_FLAG | \
+						IDXD_OP_FLAG_WR_SRC2_AECS_COMP | \
+						IDXD_OP_FLAG_AECS_RW_TGLS)
+
+static int check_completion(struct device *dev,
+			    struct iax_completion_record *comp,
+			    bool compress,
+			    bool only_once);
+
+static int decompress_header(struct iaa_device_compression_mode *device_mode,
+			     struct iaa_compression_mode *mode,
+			     struct idxd_wq *wq)
+{
+	dma_addr_t src_addr, src2_addr;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct device *dev;
+	int ret = 0;
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc))
+		return PTR_ERR(idxd_desc);
+
+	desc = idxd_desc->iax_hw;
+
+	dev = &wq->idxd->pdev->dev;
+
+	src_addr = dma_map_single(dev, (void *)mode->header_table,
+				  mode->header_table_size, DMA_TO_DEVICE);
+	dev_dbg(dev, "%s: mode->name %s, src_addr %llx, dev %p, src %p, slen %d\n",
+		__func__, mode->name, src_addr,	dev,
+		mode->header_table, mode->header_table_size);
+	if (unlikely(dma_mapping_error(dev, src_addr))) {
+		dev_dbg(dev, "dma_map_single err, exiting\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	desc->flags = IAX_AECS_GEN_FLAG;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->src1_size = mode->header_table_size;
+
+	src2_addr = device_mode->aecs_decomp_table_dma_addr;
+	desc->src2_addr = (u64)src2_addr;
+	desc->src2_size = 1088;
+	dev_dbg(dev, "%s: mode->name %s, src2_addr %llx, dev %p, src2_size %d\n",
+		__func__, mode->name, desc->src2_addr, dev, desc->src2_size);
+	desc->max_dst_size = 0; // suppressed output
+
+	desc->decompr_flags = mode->gen_decomp_table_flags;
+
+	desc->priv = 1;
+
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		pr_err("%s: submit_desc failed ret=0x%x\n", __func__, ret);
+		goto out;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret)
+		dev_dbg(dev, "%s: mode->name %s check_completion failed ret=%d\n",
+			__func__, mode->name, ret);
+	else
+		dev_dbg(dev, "%s: mode->name %s succeeded\n", __func__,
+			mode->name);
+out:
+	dma_unmap_single(dev, src_addr, 1088, DMA_TO_DEVICE);
+
+	return ret;
+}
+
 static int init_device_compression_mode(struct iaa_device *iaa_device,
 					struct iaa_compression_mode *mode,
 					int idx, struct idxd_wq *wq)
@@ -300,6 +435,14 @@ static int init_device_compression_mode(struct iaa_device *iaa_device,
 	memcpy(device_mode->aecs_comp_table->ll_sym, mode->ll_table, mode->ll_table_size);
 	memcpy(device_mode->aecs_comp_table->d_sym, mode->d_table, mode->d_table_size);
 
+	if (mode->header_table) {
+		ret = decompress_header(device_mode, mode, wq);
+		if (ret) {
+			pr_debug("iaa header decompression failed: ret=%d\n", ret);
+			goto free;
+		}
+	}
+
 	if (mode->init) {
 		ret = mode->init(device_mode);
 		if (ret)
@@ -372,18 +515,6 @@ static struct iaa_device *iaa_device_alloc(void)
 	return iaa_device;
 }
 
-static void iaa_device_free(struct iaa_device *iaa_device)
-{
-	struct iaa_wq *iaa_wq, *next;
-
-	list_for_each_entry_safe(iaa_wq, next, &iaa_device->wqs, list) {
-		list_del(&iaa_wq->list);
-		kfree(iaa_wq);
-	}
-
-	kfree(iaa_device);
-}
-
 static bool iaa_has_wq(struct iaa_device *iaa_device, struct idxd_wq *wq)
 {
 	struct iaa_wq *iaa_wq;
@@ -426,12 +557,8 @@ static int init_iaa_device(struct iaa_device *iaa_device, struct iaa_wq *iaa_wq)
 
 static void del_iaa_device(struct iaa_device *iaa_device)
 {
-	remove_device_compression_modes(iaa_device);
-
 	list_del(&iaa_device->list);
 
-	iaa_device_free(iaa_device);
-
 	nr_iaa--;
 }
 
@@ -497,6 +624,82 @@ static void clear_wq_table(void)
 	pr_debug("cleared wq table\n");
 }
 
+static void free_iaa_device(struct iaa_device *iaa_device)
+{
+	if (!iaa_device)
+		return;
+
+	remove_device_compression_modes(iaa_device);
+	kfree(iaa_device);
+}
+
+static void __free_iaa_wq(struct iaa_wq *iaa_wq)
+{
+	struct iaa_device *iaa_device;
+
+	if (!iaa_wq)
+		return;
+
+	iaa_device = iaa_wq->iaa_device;
+	if (iaa_device->n_wq == 0)
+		free_iaa_device(iaa_wq->iaa_device);
+}
+
+static void free_iaa_wq(struct iaa_wq *iaa_wq)
+{
+	struct idxd_wq *wq;
+
+	__free_iaa_wq(iaa_wq);
+
+	wq = iaa_wq->wq;
+
+	kfree(iaa_wq);
+	idxd_wq_set_private(wq, NULL);
+}
+
+static int iaa_wq_get(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct iaa_wq *iaa_wq;
+	int ret = 0;
+
+	spin_lock(&idxd->dev_lock);
+	iaa_wq = idxd_wq_get_private(wq);
+	if (iaa_wq && !iaa_wq->remove)
+		iaa_wq->ref++;
+	else
+		ret = -ENODEV;
+	spin_unlock(&idxd->dev_lock);
+
+	return ret;
+}
+
+static int iaa_wq_put(struct idxd_wq *wq)
+{
+	struct idxd_device *idxd = wq->idxd;
+	struct iaa_wq *iaa_wq;
+	bool free = false;
+	int ret = 0;
+
+	spin_lock(&idxd->dev_lock);
+	iaa_wq = idxd_wq_get_private(wq);
+	if (iaa_wq) {
+		iaa_wq->ref--;
+		if (iaa_wq->ref == 0 && iaa_wq->remove) {
+			__free_iaa_wq(iaa_wq);
+			idxd_wq_set_private(wq, NULL);
+			free = true;
+		}
+	} else {
+		ret = -ENODEV;
+	}
+	spin_unlock(&idxd->dev_lock);
+	if (free)
+		kfree(iaa_wq);
+
+	return ret;
+}
+
 static void free_wq_table(void)
 {
 	int cpu;
@@ -580,6 +783,7 @@ static int save_iaa_wq(struct idxd_wq *wq)
 		ret = add_iaa_wq(new_device, wq, &new_wq);
 		if (ret) {
 			del_iaa_device(new_device);
+			free_iaa_device(new_device);
 			goto out;
 		}
 
@@ -587,6 +791,7 @@ static int save_iaa_wq(struct idxd_wq *wq)
 		if (ret) {
 			del_iaa_wq(new_device, new_wq->wq);
 			del_iaa_device(new_device);
+			free_iaa_wq(new_wq);
 			goto out;
 		}
 	}
@@ -724,6 +929,624 @@ static void rebalance_wq_table(void)
 	}
 }
 
+static inline int check_completion(struct device *dev,
+				   struct iax_completion_record *comp,
+				   bool compress,
+				   bool only_once)
+{
+	char *op_str = compress ? "compress" : "decompress";
+	int ret = 0;
+
+	while (!comp->status) {
+		if (only_once)
+			return -EAGAIN;
+		cpu_relax();
+	}
+
+	if (comp->status != IAX_COMP_SUCCESS) {
+		if (comp->status == IAA_ERROR_WATCHDOG_EXPIRED) {
+			ret = -ETIMEDOUT;
+			dev_dbg(dev, "%s timed out, size=0x%x\n",
+				op_str, comp->output_size);
+			goto out;
+		}
+
+		if (comp->status == IAA_ANALYTICS_ERROR &&
+		    comp->error_code == IAA_ERROR_COMP_BUF_OVERFLOW && compress) {
+			ret = -E2BIG;
+			dev_dbg(dev, "compressed > uncompressed size,"
+				" not compressing, size=0x%x\n",
+				comp->output_size);
+			goto out;
+		}
+
+		if (comp->status == IAA_ERROR_DECOMP_BUF_OVERFLOW) {
+			ret = -EOVERFLOW;
+			goto out;
+		}
+
+		ret = -EINVAL;
+		dev_dbg(dev, "iaa %s status=0x%x, error=0x%x, size=0x%x\n",
+			op_str, comp->status, comp->error_code, comp->output_size);
+		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET, 8, 1, comp, 64, 0);
+
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static int iaa_compress(struct crypto_tfm *tfm,	struct acomp_req *req,
+			struct idxd_wq *wq,
+			dma_addr_t src_addr, unsigned int slen,
+			dma_addr_t dst_addr, unsigned int *dlen,
+			u32 *compression_crc,
+			bool disable_async)
+{
+	struct iaa_device_compression_mode *active_compression_mode;
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct iaa_device *iaa_device;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = idxd_wq_get_private(wq);
+	iaa_device = iaa_wq->iaa_device;
+	idxd = iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa compress failed: ret=%ld\n", PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR |
+		IDXD_OP_FLAG_RD_SRC2_AECS | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_COMPRESS;
+	desc->compr_flags = IAA_COMP_FLAGS;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->src1_size = slen;
+	desc->dst_addr = (u64)dst_addr;
+	desc->max_dst_size = *dlen;
+	desc->src2_addr = active_compression_mode->aecs_comp_table_dma_addr;
+	desc->src2_size = sizeof(struct aecs_comp_table_record);
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "%s: compression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n", __func__,
+		active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, true, false);
+	if (ret) {
+		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	*dlen = idxd_desc->iax_completion->output_size;
+
+	*compression_crc = idxd_desc->iax_completion->crc;
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_compress_verify(struct crypto_tfm *tfm, struct acomp_req *req,
+			       struct idxd_wq *wq,
+			       dma_addr_t src_addr, unsigned int slen,
+			       dma_addr_t dst_addr, unsigned int *dlen,
+			       u32 compression_crc)
+{
+	struct iaa_device_compression_mode *active_compression_mode;
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct iaa_device *iaa_device;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = idxd_wq_get_private(wq);
+	iaa_device = iaa_wq->iaa_device;
+	idxd = iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa compress failed: ret=%ld\n",
+			PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	/* Verify (optional) - decompress and check crc, suppress dest write */
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+	desc->decompr_flags = IAA_DECOMP_FLAGS | IAA_DECOMP_SUPPRESS_OUTPUT;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)dst_addr;
+	desc->src1_size = *dlen;
+	desc->dst_addr = (u64)src_addr;
+	desc->max_dst_size = slen;
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "(verify) compression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n",
+		active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc (verify) failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret) {
+		dev_dbg(dev, "(verify) check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	if (compression_crc != idxd_desc->iax_completion->crc) {
+		ret = -EINVAL;
+		dev_dbg(dev, "(verify) iaa comp/decomp crc mismatch:"
+			" comp=0x%x, decomp=0x%x\n", compression_crc,
+			idxd_desc->iax_completion->crc);
+		print_hex_dump(KERN_INFO, "cmp-rec: ", DUMP_PREFIX_OFFSET,
+			       8, 1, idxd_desc->iax_completion, 64, 0);
+		goto err;
+	}
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa compress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
+			  struct idxd_wq *wq,
+			  dma_addr_t src_addr, unsigned int slen,
+			  dma_addr_t dst_addr, unsigned int *dlen,
+			  bool disable_async)
+{
+	struct iaa_device_compression_mode *active_compression_mode;
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct iaa_device *iaa_device;
+	struct idxd_desc *idxd_desc;
+	struct iax_hw_desc *desc;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret = 0;
+
+	iaa_wq = idxd_wq_get_private(wq);
+	iaa_device = iaa_wq->iaa_device;
+	idxd = iaa_device->idxd;
+	pdev = idxd->pdev;
+	dev = &pdev->dev;
+
+	active_compression_mode = get_iaa_device_compression_mode(iaa_device, ctx->mode);
+
+	idxd_desc = idxd_alloc_desc(wq, IDXD_OP_BLOCK);
+	if (IS_ERR(idxd_desc)) {
+		dev_dbg(dev, "idxd descriptor allocation failed\n");
+		dev_dbg(dev, "iaa decompress failed: ret=%ld\n",
+			PTR_ERR(idxd_desc));
+		return PTR_ERR(idxd_desc);
+	}
+	desc = idxd_desc->iax_hw;
+
+	desc->flags = IDXD_OP_FLAG_CRAV | IDXD_OP_FLAG_RCR | IDXD_OP_FLAG_CC;
+	desc->opcode = IAX_OPCODE_DECOMPRESS;
+	desc->max_dst_size = PAGE_SIZE;
+	desc->decompr_flags = IAA_DECOMP_FLAGS;
+	desc->priv = 1;
+
+	desc->src1_addr = (u64)src_addr;
+	desc->dst_addr = (u64)dst_addr;
+	desc->max_dst_size = *dlen;
+	desc->src1_size = slen;
+	desc->completion_addr = idxd_desc->compl_dma;
+
+	dev_dbg(dev, "%s: decompression mode %s,"
+		" desc->src1_addr %llx, desc->src1_size %d,"
+		" desc->dst_addr %llx, desc->max_dst_size %d,"
+		" desc->src2_addr %llx, desc->src2_size %d\n", __func__,
+		active_compression_mode->name,
+		desc->src1_addr, desc->src1_size, desc->dst_addr,
+		desc->max_dst_size, desc->src2_addr, desc->src2_size);
+
+	ret = idxd_submit_desc(wq, idxd_desc);
+	if (ret) {
+		dev_dbg(dev, "submit_desc failed ret=%d\n", ret);
+		goto err;
+	}
+
+	ret = check_completion(dev, idxd_desc->iax_completion, false, false);
+	if (ret) {
+		dev_dbg(dev, "check_completion failed ret=%d\n", ret);
+		goto err;
+	}
+
+	*dlen = idxd_desc->iax_completion->output_size;
+
+	idxd_free_desc(wq, idxd_desc);
+out:
+	return ret;
+err:
+	idxd_free_desc(wq, idxd_desc);
+	dev_dbg(dev, "iaa decompress failed: ret=%d\n", ret);
+
+	goto out;
+}
+
+static int iaa_comp_acompress(struct acomp_req *req)
+{
+	struct iaa_compression_ctx *compression_ctx;
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	u32 compression_crc;
+	struct idxd_wq *wq;
+	struct device *dev;
+
+	compression_ctx = crypto_tfm_ctx(tfm);
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not compressing\n");
+		return -ENODEV;
+	}
+
+	if (!req->src || !req->slen) {
+		pr_debug("invalid src, not compressing\n");
+		return -EINVAL;
+	}
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = iaa_wq_get(wq);
+	if (ret) {
+		pr_debug("no wq available for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	iaa_wq = idxd_wq_get_private(wq);
+
+	if (!req->dst) {
+		gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ? GFP_KERNEL : GFP_ATOMIC;
+		/* incompressible data will always be < 2 * slen */
+		req->dlen = 2 * req->slen;
+		req->dst = sgl_alloc(req->dlen, flags, NULL);
+		if (!req->dst) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
+			   &req->dlen, &compression_crc, false);
+	if (ret == -EINPROGRESS)
+		return ret;
+
+	if (!ret && compression_ctx->verify_compress) {
+		dma_sync_sg_for_device(dev, req->dst, 1, DMA_FROM_DEVICE);
+		dma_sync_sg_for_device(dev, req->src, 1, DMA_TO_DEVICE);
+		ret = iaa_compress_verify(tfm, req, wq, src_addr, req->slen,
+					  dst_addr, &req->dlen, compression_crc);
+	}
+
+	if (ret)
+		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	iaa_wq_put(wq);
+
+	return ret;
+}
+
+static int iaa_comp_adecompress_alloc_dest(struct acomp_req *req)
+{
+	gfp_t flags = req->flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+		GFP_KERNEL : GFP_ATOMIC;
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	struct device *dev;
+	struct idxd_wq *wq;
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = iaa_wq_get(wq);
+	if (ret) {
+		pr_debug("no wq available for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	iaa_wq = idxd_wq_get_private(wq);
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	req->dlen = 4 * req->slen; /* start with ~avg comp rato */
+alloc_dest:
+	req->dst = sgl_alloc(req->dlen, flags, NULL);
+	if (!req->dst) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+			     dst_addr, &req->dlen, true);
+	if (ret == -EOVERFLOW) {
+		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+		sgl_free(req->dst);
+		req->dlen *= 2;
+		if (req->dlen > CRYPTO_ACOMP_DST_MAX)
+			goto err_map_dst;
+		goto alloc_dest;
+	}
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	iaa_wq_put(wq);
+
+	return ret;
+}
+
+static int iaa_comp_adecompress(struct acomp_req *req)
+{
+	struct crypto_tfm *tfm = req->base.tfm;
+	dma_addr_t src_addr, dst_addr;
+	int nr_sgs, cpu, ret = 0;
+	struct iaa_wq *iaa_wq;
+	struct device *dev;
+	struct idxd_wq *wq;
+
+	if (!iaa_crypto_enabled) {
+		pr_debug("iaa_crypto disabled, not decompressing\n");
+		return -ENODEV;
+	}
+
+	if (!req->src || !req->slen) {
+		pr_debug("invalid src, not decompressing\n");
+		return -EINVAL;
+	}
+
+	if (!req->dst)
+		return iaa_comp_adecompress_alloc_dest(req);
+
+	cpu = get_cpu();
+	wq = wq_table_next_wq(cpu);
+	put_cpu();
+	if (!wq) {
+		pr_debug("no wq configured for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = iaa_wq_get(wq);
+	if (ret) {
+		pr_debug("no wq available for cpu=%d\n", cpu);
+		return -ENODEV;
+	}
+
+	iaa_wq = idxd_wq_get_private(wq);
+
+	dev = &wq->idxd->pdev->dev;
+
+	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto out;
+	}
+	src_addr = sg_dma_address(req->src);
+	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
+		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+		req->src, req->slen, sg_dma_len(req->src));
+
+	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+	if (nr_sgs <= 0 || nr_sgs > 1) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
+			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
+			iaa_wq->wq->id, ret);
+		ret = -EIO;
+		goto err_map_dst;
+	}
+	dst_addr = sg_dma_address(req->dst);
+	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
+		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+		req->dst, req->dlen, sg_dma_len(req->dst));
+
+	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
+			     dst_addr, &req->dlen, false);
+	if (ret == -EINPROGRESS)
+		return ret;
+
+	if (ret != 0)
+		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
+
+	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
+err_map_dst:
+	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+out:
+	iaa_wq_put(wq);
+
+	return ret;
+}
+
+static void compression_ctx_init(struct iaa_compression_ctx *ctx)
+{
+	ctx->verify_compress = iaa_verify_compress;
+}
+
+static int iaa_comp_init_fixed(struct crypto_acomp *acomp_tfm)
+{
+	struct crypto_tfm *tfm = crypto_acomp_tfm(acomp_tfm);
+	struct iaa_compression_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	compression_ctx_init(ctx);
+
+	ctx->mode = IAA_MODE_FIXED;
+
+	return 0;
+}
+
+static struct acomp_alg iaa_acomp_fixed_deflate = {
+	.init			= iaa_comp_init_fixed,
+	.compress		= iaa_comp_acompress,
+	.decompress		= iaa_comp_adecompress,
+	.dst_free		= sgl_free,
+	.base			= {
+		.cra_name		= "deflate-iaa",
+		.cra_driver_name	= "deflate_iaa",
+		.cra_ctxsize		= sizeof(struct iaa_compression_ctx),
+		.cra_module		= THIS_MODULE,
+	}
+};
+
+static int iaa_register_compression_device(void)
+{
+	int ret;
+
+	ret = crypto_register_acomp(&iaa_acomp_fixed_deflate);
+	if (ret) {
+		pr_err("deflate algorithm acomp fixed registration failed (%d)\n", ret);
+		goto out;
+	}
+
+	iaa_crypto_registered = true;
+out:
+	return ret;
+}
+
+static int iaa_unregister_compression_device(void)
+{
+	if (iaa_crypto_registered)
+		crypto_unregister_acomp(&iaa_acomp_fixed_deflate);
+
+	return 0;
+}
+
 static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
@@ -741,6 +1564,11 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	mutex_lock(&wq->wq_lock);
 
+	if (idxd_wq_get_private(wq)) {
+		mutex_unlock(&wq->wq_lock);
+		return -EBUSY;
+	}
+
 	if (!idxd_wq_driver_name_match(wq, dev)) {
 		dev_dbg(dev, "wq %d.%d driver_name match failed: wq driver_name %s, dev driver name %s\n",
 			idxd->id, wq->id, wq->driver_name, dev->driver->name);
@@ -774,12 +1602,28 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 
 	rebalance_wq_table();
 
+	if (first_wq) {
+		iaa_crypto_enabled = true;
+		ret = iaa_register_compression_device();
+		if (ret != 0) {
+			iaa_crypto_enabled = false;
+			dev_dbg(dev, "IAA compression device registration failed\n");
+			goto err_register;
+		}
+		try_module_get(THIS_MODULE);
+
+		pr_info("iaa_crypto now ENABLED\n");
+	}
+
 	mutex_unlock(&iaa_devices_lock);
 out:
 	mutex_unlock(&wq->wq_lock);
 
 	return ret;
 
+err_register:
+	remove_iaa_wq(wq);
+	free_iaa_wq(idxd_wq_get_private(wq));
 err_save:
 	if (first_wq)
 		free_wq_table();
@@ -795,6 +1639,9 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
 static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 {
 	struct idxd_wq *wq = idxd_dev_to_wq(idxd_dev);
+	struct idxd_device *idxd = wq->idxd;
+	struct iaa_wq *iaa_wq;
+	bool free = false;
 
 	idxd_wq_quiesce(wq);
 
@@ -802,11 +1649,37 @@ static void iaa_crypto_remove(struct idxd_dev *idxd_dev)
 	mutex_lock(&iaa_devices_lock);
 
 	remove_iaa_wq(wq);
+
+	spin_lock(&idxd->dev_lock);
+	iaa_wq = idxd_wq_get_private(wq);
+	if (!iaa_wq) {
+		pr_err("%s: no iaa_wq available to remove\n", __func__);
+		return;
+	}
+
+	if (iaa_wq->ref) {
+		iaa_wq->remove = true;
+	} else {
+		wq = iaa_wq->wq;
+		__free_iaa_wq(iaa_wq);
+		idxd_wq_set_private(wq, NULL);
+		free = true;
+	}
+	spin_unlock(&idxd->dev_lock);
+
+	if (free)
+		kfree(iaa_wq);
+
 	drv_disable_wq(wq);
 	rebalance_wq_table();
 
-	if (nr_iaa == 0)
+	if (nr_iaa == 0) {
+		iaa_crypto_enabled = false;
 		free_wq_table();
+		module_put(THIS_MODULE);
+
+		pr_info("iaa_crypto now DISABLED\n");
+	}
 
 	mutex_unlock(&iaa_devices_lock);
 	mutex_unlock(&wq->wq_lock);
@@ -844,10 +1717,19 @@ static int __init iaa_crypto_init_module(void)
 		goto err_driver_reg;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				 &driver_attr_verify_compress);
+	if (ret) {
+		pr_debug("IAA verify_compress attr creation failed\n");
+		goto err_verify_attr_create;
+	}
+
 	pr_debug("initialized\n");
 out:
 	return ret;
 
+err_verify_attr_create:
+	idxd_driver_unregister(&iaa_crypto_driver);
 err_driver_reg:
 	iaa_aecs_cleanup_fixed();
 
@@ -856,6 +1738,11 @@ static int __init iaa_crypto_init_module(void)
 
 static void __exit iaa_crypto_cleanup_module(void)
 {
+	if (iaa_unregister_compression_device())
+		pr_debug("IAA compression device unregister failed\n");
+
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_verify_compress);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
 
-- 
2.34.1

