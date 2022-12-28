Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14D2657FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 17:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiL1QIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 11:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbiL1QHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 11:07:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6958193D4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 08:07:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45430B81730
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06939C433F0;
        Wed, 28 Dec 2022 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672243654;
        bh=Y4X7RMwk9+vTUyMZ9CXeP4qzat5tfskxOFNjJ7+LrII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLYKyDvWN6RokSrIFp/UMAwc+wcsKNyI0JmOucG3oh7awnE9pQT1m37NRN3wN03+l
         P+4lf1QyrmnMH7DnhbgNZzIJ0ALoMeFQqJQrpt6VMbyKXnFi8vZbHU8FwsrsffaWZn
         GRq8d+i4KjYC+7PxJLUJH3xMgMVc9Te2CJGDZAP/vzBpzxwM8VtuM0HpY/vEPDEcoK
         +Ei2ZJ1pBouUOdw3JjN9rslYlafae5mOx8Nxx9r2Yb7o6H25lBoL5SLfcdUgmXlxuH
         /Vb5a6gKte9AyYbG2dnwQmOJbr3C95L7z6NP6PTHlwnfUn90GpikQ9JX4rjj6bxwnH
         kIUehOTlWfP4Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/9] habanalabs: verify that kernel CB is destroyed only once
Date:   Wed, 28 Dec 2022 18:07:16 +0200
Message-Id: <20221228160723.387-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221228160723.387-1-ogabbay@kernel.org>
References: <20221228160723.387-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Remove the distinction between user CB and kernel CB, and verify for
both that they are not destroyed more than once.

As kernel CB might be taken from the pre-allocated CB pool, so we need
to clear the handle destroyed indication when returning a CB to the
pool.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../accel/habanalabs/common/command_buffer.c  | 32 ++++++++-----------
 drivers/accel/habanalabs/common/device.c      |  2 +-
 drivers/accel/habanalabs/common/habanalabs.h  |  4 +--
 .../accel/habanalabs/common/habanalabs_drv.c  |  2 +-
 drivers/accel/habanalabs/common/memory_mgr.c  |  4 +--
 5 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_buffer.c b/drivers/accel/habanalabs/common/command_buffer.c
index 6263d01cb9c1..390011b02239 100644
--- a/drivers/accel/habanalabs/common/command_buffer.c
+++ b/drivers/accel/habanalabs/common/command_buffer.c
@@ -88,6 +88,7 @@ static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
 static void cb_do_release(struct hl_device *hdev, struct hl_cb *cb)
 {
 	if (cb->is_pool) {
+		atomic_set(&cb->is_handle_destroyed, 0);
 		spin_lock(&hdev->cb_pool_lock);
 		list_add(&cb->pool_list, &hdev->cb_pool);
 		spin_unlock(&hdev->cb_pool_lock);
@@ -301,28 +302,23 @@ int hl_cb_destroy(struct hl_mem_mgr *mmg, u64 cb_handle)
 	struct hl_cb *cb;
 	int rc;
 
-	/* Make sure that a CB handle isn't destroyed by user more than once */
-	if (!mmg->is_kernel_mem_mgr) {
-		cb = hl_cb_get(mmg, cb_handle);
-		if (!cb) {
-			dev_dbg(mmg->dev, "CB destroy failed, no CB was found for handle %#llx\n",
-				cb_handle);
-			rc = -EINVAL;
-			goto out;
-		}
+	cb = hl_cb_get(mmg, cb_handle);
+	if (!cb) {
+		dev_dbg(mmg->dev, "CB destroy failed, no CB was found for handle %#llx\n",
+			cb_handle);
+		return -EINVAL;
+	}
 
-		rc = atomic_cmpxchg(&cb->is_handle_destroyed, 0, 1);
-		hl_cb_put(cb);
-		if (rc) {
-			dev_dbg(mmg->dev, "CB destroy failed, handle %#llx was already destroyed\n",
-				cb_handle);
-			rc = -EINVAL;
-			goto out;
-		}
+	/* Make sure that CB handle isn't destroyed more than once */
+	rc = atomic_cmpxchg(&cb->is_handle_destroyed, 0, 1);
+	hl_cb_put(cb);
+	if (rc) {
+		dev_dbg(mmg->dev, "CB destroy failed, handle %#llx was already destroyed\n",
+			cb_handle);
+		return -EINVAL;
 	}
 
 	rc = hl_mmap_mem_buf_put_handle(mmg, cb_handle);
-out:
 	if (rc < 0)
 		return rc; /* Invalid handle */
 
diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 6620580e9ba8..fe3540ed60d7 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -855,7 +855,7 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_chip_info;
 
-	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr, 1);
+	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
 
 	hdev->reset_wq = create_singlethread_workqueue("hl_device_reset");
 	if (!hdev->reset_wq) {
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 95bbc00c6262..9bcefbef5ad7 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -876,13 +876,11 @@ struct hl_mmap_mem_buf;
  * @dev: back pointer to the owning device
  * @lock: protects handles
  * @handles: an idr holding all active handles to the memory buffers in the system.
- * @is_kernel_mem_mgr: indicate whether the memory manager is the per-device kernel memory manager
  */
 struct hl_mem_mgr {
 	struct device *dev;
 	spinlock_t lock;
 	struct idr handles;
-	u8 is_kernel_mem_mgr;
 };
 
 /**
@@ -3824,7 +3822,7 @@ __printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
 char *hl_format_as_binary(char *buf, size_t buf_len, u32 n);
 const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
 
-void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg, u8 is_kernel_mem_mgr);
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg);
 void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
 int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index a2983913d7c0..7815c60df54e 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -164,7 +164,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
-	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr, 0);
+	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr);
 
 	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
diff --git a/drivers/accel/habanalabs/common/memory_mgr.c b/drivers/accel/habanalabs/common/memory_mgr.c
index 92d20ed465b4..0f2759e26547 100644
--- a/drivers/accel/habanalabs/common/memory_mgr.c
+++ b/drivers/accel/habanalabs/common/memory_mgr.c
@@ -308,16 +308,14 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
  *
  * @dev: owner device pointer
  * @mmg: structure to initialize
- * @is_kernel_mem_mgr: indicate whether the memory manager is the per-device kernel memory manager
  *
  * Initialize an instance of unified memory manager
  */
-void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg, u8 is_kernel_mem_mgr)
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg)
 {
 	mmg->dev = dev;
 	spin_lock_init(&mmg->lock);
 	idr_init(&mmg->handles);
-	mmg->is_kernel_mem_mgr = is_kernel_mem_mgr;
 }
 
 /**
-- 
2.34.1

