Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA59A6F1FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346589AbjD1U41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346781AbjD1U4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:56:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5573C26;
        Fri, 28 Apr 2023 13:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682715359; x=1714251359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Z50yNyj1gfD75v2pn3I9ricgtOCDqU3zWpHncHS7Fo=;
  b=TZnhdv3l1ZziZP1Z6s0ExGVzTP1PDW8x3OdQv/a6i7+oOAXFqWjGOVji
   tayk9Gl/gFnPgyLoZKXqJMpJacOpGv4jTX55cIYBXRtDhWdZtjZhDzEi1
   lEpV9FDmn6T76R4A3as+H/rD4gRffTqmIoLnVK1x3Ans133/GVP1LLh70
   HK0FqvhFWYvbDsZWeEx18qtvKqC4kgudAihlncv/KO5ep6VaaLgjK/o5R
   tx3Kq3MY+Do48QrH3aFhHcnRSTMDQnie1RqcRSH8vMSmqi2Zy24zE1jLe
   sInocO9ux27oZiL/RmKNdxZ7xPjNC4sFcrwUktSED8yZMaO1jKphklS7z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="336937673"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="336937673"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="838980406"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="838980406"
Received: from ykaur1-mobl2.amr.corp.intel.com (HELO tzanussi-mobl1.intel.com) ([10.209.181.29])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 13:55:58 -0700
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        hdanton@sina.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: [PATCH v3 07/15] dmaengine: idxd: add callback support for iaa crypto
Date:   Fri, 28 Apr 2023 15:55:31 -0500
Message-Id: <20230428205539.113902-8-tom.zanussi@linux.intel.com>
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

Create a lightweight callback interface to allow idxd sub-drivers to
be notified when work sent to idxd wqs has completed.

For a sub-driver to be notified of work completion, it needs to:

  - Set the descriptor's 'Request Completion Interrupt'
    (IDXD_OP_FLAG_RCI)

  - Set the sub-driver desc_complete() callback when registering the
    sub-driver e.g.:

      struct idxd_device_driver my_drv = {
            .probe = my_probe,
            .desc_complete = my_complete,
      }

  - Set the sub-driver-specific context in the sub-driver's descriptor
    e.g:

      idxd_desc->crypto.req = req;
      idxd_desc->crypto.tfm = tfm;
      idxd_desc->crypto.src_addr = src_addr;
      idxd_desc->crypto.dst_addr = dst_addr;

When the work completes and the completion irq fires, idxd will invoke
the desc_complete() callback with pointers to the descriptor, context,
and completion_type.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/dma/idxd/device.c |  2 +-
 drivers/dma/idxd/dma.c    |  3 +-
 drivers/dma/idxd/idxd.h   | 62 ++++++++++++++++++++++++++++++++-------
 drivers/dma/idxd/irq.c    | 12 ++++----
 drivers/dma/idxd/submit.c |  6 ++--
 5 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 7837d0a56314..636451249046 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1190,7 +1190,7 @@ static void idxd_flush_pending_descs(struct idxd_irq_entry *ie)
 		tx = &desc->txd;
 		tx->callback = NULL;
 		tx->callback_result = NULL;
-		idxd_dma_complete_txd(desc, ctype, true);
+		idxd_dma_complete_txd(desc, ctype, true, NULL, NULL);
 	}
 }
 
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 8bb7e7ff8d6a..9a12b02b0549 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -22,7 +22,7 @@ static inline struct idxd_wq *to_idxd_wq(struct dma_chan *c)
 
 void idxd_dma_complete_txd(struct idxd_desc *desc,
 			   enum idxd_complete_type comp_type,
-			   bool free_desc)
+			   bool free_desc, void *ctx, u32 *status)
 {
 	struct idxd_device *idxd = desc->wq->idxd;
 	struct dma_async_tx_descriptor *tx;
@@ -358,6 +358,7 @@ static enum idxd_dev_type dev_types[] = {
 struct idxd_device_driver idxd_dmaengine_drv = {
 	.probe = idxd_dmaengine_drv_probe,
 	.remove = idxd_dmaengine_drv_remove,
+	.desc_complete = idxd_dma_complete_txd,
 	.name = "dmaengine",
 	.type = dev_types,
 };
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 0402f97d6ff8..105f3fbf95f1 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -13,6 +13,7 @@
 #include <linux/ioasid.h>
 #include <linux/bitmap.h>
 #include <linux/perf_event.h>
+#include <linux/crypto.h>
 #include <uapi/linux/idxd.h>
 #include "registers.h"
 
@@ -56,11 +57,23 @@ enum idxd_type {
 #define IDXD_ENQCMDS_RETRIES		32
 #define IDXD_ENQCMDS_MAX_RETRIES	64
 
+enum idxd_complete_type {
+	IDXD_COMPLETE_NORMAL = 0,
+	IDXD_COMPLETE_ABORT,
+	IDXD_COMPLETE_DEV_FAIL,
+};
+
+struct idxd_desc;
+
 struct idxd_device_driver {
 	const char *name;
 	enum idxd_dev_type *type;
 	int (*probe)(struct idxd_dev *idxd_dev);
 	void (*remove)(struct idxd_dev *idxd_dev);
+	void (*desc_complete)(struct idxd_desc *desc,
+			      enum idxd_complete_type comp_type,
+			      bool free_desc,
+			      void *ctx, u32 *status);
 	struct device_driver drv;
 };
 
@@ -164,12 +177,6 @@ enum idxd_op_type {
 	IDXD_OP_NONBLOCK = 1,
 };
 
-enum idxd_complete_type {
-	IDXD_COMPLETE_NORMAL = 0,
-	IDXD_COMPLETE_ABORT,
-	IDXD_COMPLETE_DEV_FAIL,
-};
-
 struct idxd_dma_chan {
 	struct dma_chan chan;
 	struct idxd_wq *wq;
@@ -322,6 +329,14 @@ struct idxd_device {
 	unsigned long *opcap_bmap;
 };
 
+struct crypto_ctx {
+	struct acomp_req *req;
+	struct crypto_tfm *tfm;
+	dma_addr_t src_addr;
+	dma_addr_t dst_addr;
+	bool compress;
+};
+
 /* IDXD software descriptor */
 struct idxd_desc {
 	union {
@@ -334,7 +349,10 @@ struct idxd_desc {
 		struct iax_completion_record *iax_completion;
 	};
 	dma_addr_t compl_dma;
-	struct dma_async_tx_descriptor txd;
+	union {
+		struct dma_async_tx_descriptor txd;
+		struct crypto_ctx crypto;
+	};
 	struct llist_node llnode;
 	struct list_head list;
 	int id;
@@ -360,6 +378,15 @@ enum idxd_completion_status {
 #define idxd_dev_to_idxd(idxd_dev) container_of(idxd_dev, struct idxd_device, idxd_dev)
 #define idxd_dev_to_wq(idxd_dev) container_of(idxd_dev, struct idxd_wq, idxd_dev)
 
+static inline struct idxd_device_driver *wq_to_idxd_drv(struct idxd_wq *wq)
+{
+	struct device *dev = wq_confdev(wq);
+	struct idxd_device_driver *idxd_drv =
+		container_of(dev->driver, struct idxd_device_driver, drv);
+
+	return idxd_drv;
+}
+
 static inline struct idxd_device *confdev_to_idxd(struct device *dev)
 {
 	struct idxd_dev *idxd_dev = confdev_to_idxd_dev(dev);
@@ -612,6 +639,24 @@ void idxd_driver_unregister(struct idxd_device_driver *idxd_drv);
 #define module_idxd_driver(__idxd_driver) \
 	module_driver(__idxd_driver, idxd_driver_register, idxd_driver_unregister)
 
+void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
+void idxd_dma_complete_txd(struct idxd_desc *desc,
+			   enum idxd_complete_type comp_type,
+			   bool free_desc, void *ctx, u32 *status);
+
+static inline void idxd_desc_complete(struct idxd_desc *desc,
+				      enum idxd_complete_type comp_type,
+				      bool free_desc)
+{
+	struct idxd_device_driver *drv;
+	u32 status;
+
+	drv = wq_to_idxd_drv(desc->wq);
+	if (drv->desc_complete)
+		drv->desc_complete(desc, comp_type, free_desc,
+				   &desc->txd, &status);
+}
+
 int idxd_register_bus_type(void);
 void idxd_unregister_bus_type(void);
 int idxd_register_devices(struct idxd_device *idxd);
@@ -668,15 +713,12 @@ int idxd_wq_request_irq(struct idxd_wq *wq);
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
-void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
 int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
 
 /* dmaengine */
 int idxd_register_dma_device(struct idxd_device *idxd);
 void idxd_unregister_dma_device(struct idxd_device *idxd);
 void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
-void idxd_dma_complete_txd(struct idxd_desc *desc,
-			   enum idxd_complete_type comp_type, bool free_desc);
 
 /* cdev */
 int idxd_cdev_register(void);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index aa314ebec587..3f89236c97c1 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -121,7 +121,7 @@ static void idxd_abort_invalid_int_handle_descs(struct idxd_irq_entry *ie)
 
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del(&d->list);
-		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true);
+		idxd_desc_complete(d, IDXD_COMPLETE_ABORT, true);
 	}
 }
 
@@ -376,7 +376,7 @@ static void idxd_int_handle_resubmit_work(struct work_struct *work)
 		 */
 		if (rc != -EAGAIN) {
 			desc->completion->status = IDXD_COMP_DESC_ABORT;
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, false);
+			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, false);
 		}
 		idxd_free_desc(wq, desc);
 	}
@@ -417,11 +417,11 @@ static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
 			 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 			 */
 			if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-				idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+				idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 				continue;
 			}
 
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
+			idxd_desc_complete(desc, IDXD_COMPLETE_NORMAL, true);
 		} else {
 			spin_lock(&irq_entry->list_lock);
 			list_add_tail(&desc->list,
@@ -460,11 +460,11 @@ static void irq_process_work_list(struct idxd_irq_entry *irq_entry)
 		 * and 0xff, which DSA_COMP_STATUS_MASK can mask out.
 		 */
 		if (unlikely(desc->completion->status == IDXD_COMP_DESC_ABORT)) {
-			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, true);
+			idxd_desc_complete(desc, IDXD_COMPLETE_ABORT, true);
 			continue;
 		}
 
-		idxd_dma_complete_txd(desc, IDXD_COMPLETE_NORMAL, true);
+		idxd_desc_complete(desc, IDXD_COMPLETE_NORMAL, true);
 	}
 }
 
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 5e651e216094..f927743a5ba2 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -127,7 +127,8 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	spin_unlock(&ie->list_lock);
 
 	if (found)
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
+		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false,
+				      NULL, NULL);
 
 	/*
 	 * completing the descriptor will return desc to allocator and
@@ -137,7 +138,8 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	 */
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del_init(&d->list);
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true);
+		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
+				      NULL, NULL);
 	}
 }
 
-- 
2.34.1

