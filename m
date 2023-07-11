Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3374E301
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGKBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjGKBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:09:19 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A6C10F4;
        Mon, 10 Jul 2023 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689037739; x=1720573739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aODFKOoERpdpMb+cr314m7Sc7Io2x3Zhb5iJbRFOqQA=;
  b=n4dpSz5tPB2KqjCHeFP7DNlNNqH07g6F7utaIZIJvqiOKjKeZudUg0Dx
   RiF2tzlAwWYzkKDs+qfw3uJ8oQE48HcAy1q1UHWP3B73Pxspg00obO+MN
   isaPmbU2VH/3s8CUpGUT6qVTm1tHg9rlx/jEeQ9ieogNDws3e/lGwXyLn
   S61xkImoY57P/WtxLi7UvgENHSKgDyiU1Y6+w3ddQQvwHN/n2Dz3zjHwd
   4YJi3+/pBFMT6LdibJbICMXPwpoLRFFEf4IB2JwmRici2YPRM6t8ke8a3
   oOcfFMlXEZqB+SoxD5czBcS6O0o6XnsYvuxVyupgIYajVkbI2RntQ6LwT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344816120"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="344816120"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 18:08:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810999907"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810999907"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 18:08:55 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/9] iommu: Remove iommu_[un]register_device_fault_handler()
Date:   Tue, 11 Jul 2023 09:06:39 +0800
Message-Id: <20230711010642.19707-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711010642.19707-1-baolu.lu@linux.intel.com>
References: <20230711010642.19707-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of interfaces are not used anywhere in the tree. Remove it to
avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      | 23 ---------
 drivers/iommu/iommu-sva.h  |  4 +-
 drivers/iommu/io-pgfault.c |  6 +--
 drivers/iommu/iommu.c      | 96 --------------------------------------
 4 files changed, 4 insertions(+), 125 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a00fb43b5e73..f10be6680f8a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -198,7 +198,6 @@ struct iommu_page_response {
 
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
-typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -538,14 +537,10 @@ struct iommu_fault_event {
 
 /**
  * struct iommu_fault_param - per-device IOMMU fault data
- * @handler: Callback function to handle IOMMU faults at device level
- * @data: handler private data
  * @faults: holds the pending faults which needs response
  * @lock: protect pending faults list
  */
 struct iommu_fault_param {
-	iommu_dev_fault_handler_t handler;
-	void *data;
 	struct list_head faults;
 	struct mutex lock;
 };
@@ -669,11 +664,6 @@ extern int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 extern struct iommu_group *iommu_group_get(struct device *dev);
 extern struct iommu_group *iommu_group_ref_get(struct iommu_group *group);
 extern void iommu_group_put(struct iommu_group *group);
-extern int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data);
-
-extern int iommu_unregister_device_fault_handler(struct device *dev);
 
 extern int iommu_report_device_fault(struct device *dev,
 				     struct iommu_fault_event *evt);
@@ -1055,19 +1045,6 @@ static inline void iommu_group_put(struct iommu_group *group)
 {
 }
 
-static inline
-int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data)
-{
-	return -ENODEV;
-}
-
-static inline int iommu_unregister_device_fault_handler(struct device *dev)
-{
-	return 0;
-}
-
 static inline
 int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 {
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
index c848661c4e20..7b26224c536b 100644
--- a/drivers/iommu/iommu-sva.h
+++ b/drivers/iommu/iommu-sva.h
@@ -13,7 +13,7 @@ struct iommu_fault;
 struct iopf_queue;
 
 #ifdef CONFIG_IOMMU_SVA
-int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
+int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev);
 
 int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev);
 int iopf_queue_remove_device(struct iopf_queue *queue,
@@ -26,7 +26,7 @@ enum iommu_page_response_code
 iommu_sva_handle_iopf(struct iommu_fault *fault, struct device *dev, void *data);
 
 #else /* CONFIG_IOMMU_SVA */
-static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+static inline int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 {
 	return -ENODEV;
 }
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index fa604e1b5c5c..1749e0869f2e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -103,7 +103,7 @@ static void iopf_handler(struct work_struct *work)
 /**
  * iommu_queue_iopf - IO Page Fault handler
  * @fault: fault event
- * @cookie: struct device, passed to iommu_register_device_fault_handler.
+ * @dev: struct device.
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
@@ -140,14 +140,12 @@ static void iopf_handler(struct work_struct *work)
  *
  * Return: 0 on success and <0 on error.
  */
-int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
+int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
 {
 	int ret;
 	struct iopf_group *group;
 	struct iopf_fault *iopf, *next;
 	struct iopf_device_param *iopf_param;
-
-	struct device *dev = cookie;
 	struct dev_iommu *param = dev->iommu;
 
 	lockdep_assert_held(&param->lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8d1f0935ea71..fc5e9698b35c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1199,98 +1199,6 @@ void iommu_group_put(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_put);
 
-/**
- * iommu_register_device_fault_handler() - Register a device fault handler
- * @dev: the device
- * @handler: the fault handler
- * @data: private data passed as argument to the handler
- *
- * When an IOMMU fault event is received, this handler gets called with the
- * fault event and data as argument. The handler should return 0 on success. If
- * the fault is recoverable (IOMMU_FAULT_PAGE_REQ), the consumer should also
- * complete the fault by calling iommu_page_response() with one of the following
- * response code:
- * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
- * - IOMMU_PAGE_RESP_INVALID: terminate the fault
- * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
- *   page faults if possible.
- *
- * Return 0 if the fault handler was installed successfully, or an error.
- */
-int iommu_register_device_fault_handler(struct device *dev,
-					iommu_dev_fault_handler_t handler,
-					void *data)
-{
-	struct dev_iommu *param = dev->iommu;
-	int ret = 0;
-
-	if (!param)
-		return -EINVAL;
-
-	mutex_lock(&param->lock);
-	/* Only allow one fault handler registered for each device */
-	if (param->fault_param) {
-		ret = -EBUSY;
-		goto done_unlock;
-	}
-
-	get_device(dev);
-	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
-	if (!param->fault_param) {
-		put_device(dev);
-		ret = -ENOMEM;
-		goto done_unlock;
-	}
-	param->fault_param->handler = handler;
-	param->fault_param->data = data;
-	mutex_init(&param->fault_param->lock);
-	INIT_LIST_HEAD(&param->fault_param->faults);
-
-done_unlock:
-	mutex_unlock(&param->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
-
-/**
- * iommu_unregister_device_fault_handler() - Unregister the device fault handler
- * @dev: the device
- *
- * Remove the device fault handler installed with
- * iommu_register_device_fault_handler().
- *
- * Return 0 on success, or an error.
- */
-int iommu_unregister_device_fault_handler(struct device *dev)
-{
-	struct dev_iommu *param = dev->iommu;
-	int ret = 0;
-
-	if (!param)
-		return -EINVAL;
-
-	mutex_lock(&param->lock);
-
-	if (!param->fault_param)
-		goto unlock;
-
-	/* we cannot unregister handler if there are pending faults */
-	if (!list_empty(&param->fault_param->faults)) {
-		ret = -EBUSY;
-		goto unlock;
-	}
-
-	kfree(param->fault_param);
-	param->fault_param = NULL;
-	put_device(dev);
-unlock:
-	mutex_unlock(&param->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
-
 static int iommu_handle_io_pgfault(struct device *dev,
 				   struct iommu_fault *fault)
 {
@@ -1337,10 +1245,6 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
 	/* we only report device fault if there is a handler registered */
 	mutex_lock(&param->lock);
 	fparam = param->fault_param;
-	if (!fparam || !fparam->handler) {
-		ret = -EINVAL;
-		goto done_unlock;
-	}
 
 	if (evt->fault.type == IOMMU_FAULT_PAGE_REQ &&
 	    (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
-- 
2.34.1

