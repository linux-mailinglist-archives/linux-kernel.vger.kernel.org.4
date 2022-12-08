Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE4B647295
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiLHPOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiLHPOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:14:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C77B56F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 07:14:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE5461F6F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2770C433B5;
        Thu,  8 Dec 2022 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670512442;
        bh=lDCu27sI9boaM5mz1HqLBlHxhSBKXjqQ9eZ6bpk1ac0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkbzVw+ypy5dTMcvP9Ll+zqUf8fmFnO/CkjMNMYkgzU4OegtD6isNvlB8UBeaCvtT
         86r60suvKGXHBtB/DirDwWrdJClF/bzhguoSqpn4khu7Fs3bsqsM3evNXGOC1HoaFN
         tSaCrE6KJi8ojlX3OmXsuOnqkQkygUH7wiu5/dR8I+WPKeN5xwoVfC9uOE3p3XIgfI
         ayPP3XtfngmnerIf72gV5BttRj7VSRNFlTwq79vg/2AUgGmzspXpaYbNZ1+hA2BG3c
         sxEeeReIJpMIZjuFdBoWjFIifqpQlIp4zEaWg50Vwtcr3+Pe91/GYTUElYQ0dLqX2b
         lTUEOAE7MwHBw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 06/26] habanalabs: don't allow user to destroy CB handle more than once
Date:   Thu,  8 Dec 2022 17:13:30 +0200
Message-Id: <20221208151350.1833823-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221208151350.1833823-1-ogabbay@kernel.org>
References: <20221208151350.1833823-1-ogabbay@kernel.org>
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

The refcount of a CB buffer is initialized when user allocates a CB,
and is decreased when he destroys the CB handle.

If this refcount is increased also from kernel and user sends more than
one destroy requests for the handle, the buffer will be released/freed
and later be accessed when the refcount is put from kernel side.

To avoid it, prevent user from destroying the handle more than once.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c   | 22 +++++++++++++++++++
 drivers/misc/habanalabs/common/device.c       |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   |  6 ++++-
 .../misc/habanalabs/common/habanalabs_drv.c   |  2 +-
 drivers/misc/habanalabs/common/memory_mgr.c   |  4 +++-
 5 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 2b332991ac6a..24100501f8ca 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -298,9 +298,31 @@ int hl_cb_create(struct hl_device *hdev, struct hl_mem_mgr *mmg,
 
 int hl_cb_destroy(struct hl_mem_mgr *mmg, u64 cb_handle)
 {
+	struct hl_cb *cb;
 	int rc;
 
+	/* Make sure that a CB handle isn't destroyed by user more than once */
+	if (!mmg->is_kernel_mem_mgr) {
+		cb = hl_cb_get(mmg, cb_handle);
+		if (!cb) {
+			dev_dbg(mmg->dev, "CB destroy failed, no CB was found for handle %#llx\n",
+				cb_handle);
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = atomic_cmpxchg(&cb->is_handle_destroyed, 0, 1);
+		hl_cb_put(cb);
+		if (rc) {
+			dev_dbg(mmg->dev, "CB destroy failed, handle %#llx was already destroyed\n",
+				cb_handle);
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
 	rc = hl_mmap_mem_buf_put_handle(mmg, cb_handle);
+out:
 	if (rc < 0)
 		return rc; /* Invalid handle */
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 92721111b652..afd9d4d46574 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -853,7 +853,7 @@ static int device_early_init(struct hl_device *hdev)
 	if (rc)
 		goto free_chip_info;
 
-	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
+	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr, 1);
 
 	hdev->reset_wq = create_singlethread_workqueue("hl_device_reset");
 	if (!hdev->reset_wq) {
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 7fb45610ad0c..ecf7e5da8f1d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -872,11 +872,13 @@ struct hl_mmap_mem_buf;
  * @dev: back pointer to the owning device
  * @lock: protects handles
  * @handles: an idr holding all active handles to the memory buffers in the system.
+ * @is_kernel_mem_mgr: indicate whether the memory manager is the per-device kernel memory manager
  */
 struct hl_mem_mgr {
 	struct device *dev;
 	spinlock_t lock;
 	struct idr handles;
+	u8 is_kernel_mem_mgr;
 };
 
 /**
@@ -935,6 +937,7 @@ struct hl_mmap_mem_buf {
  * @size: holds the CB's size.
  * @roundup_size: holds the cb size after roundup to page size.
  * @cs_cnt: holds number of CS that this CB participates in.
+ * @is_handle_destroyed: atomic boolean indicating whether or not the CB handle was destroyed.
  * @is_pool: true if CB was acquired from the pool, false otherwise.
  * @is_internal: internally allocated
  * @is_mmu_mapped: true if the CB is mapped to the device's MMU.
@@ -951,6 +954,7 @@ struct hl_cb {
 	u32			size;
 	u32			roundup_size;
 	atomic_t		cs_cnt;
+	atomic_t		is_handle_destroyed;
 	u8			is_pool;
 	u8			is_internal;
 	u8			is_mmu_mapped;
@@ -3805,7 +3809,7 @@ __printf(4, 5) int hl_snprintf_resize(char **buf, size_t *size, size_t *offset,
 char *hl_format_as_binary(char *buf, size_t buf_len, u32 n);
 const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
 
-void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg);
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg, u8 is_kernel_mem_mgr);
 void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
 int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 7815c60df54e..a2983913d7c0 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -164,7 +164,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 	nonseekable_open(inode, filp);
 
 	hl_ctx_mgr_init(&hpriv->ctx_mgr);
-	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr);
+	hl_mem_mgr_init(hpriv->hdev->dev, &hpriv->mem_mgr, 0);
 
 	hpriv->taskpid = get_task_pid(current, PIDTYPE_PID);
 
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 1936d653699e..e652db601f0e 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -309,14 +309,16 @@ int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
  *
  * @dev: owner device pointer
  * @mmg: structure to initialize
+ * @is_kernel_mem_mgr: indicate whether the memory manager is the per-device kernel memory manager
  *
  * Initialize an instance of unified memory manager
  */
-void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg)
+void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg, u8 is_kernel_mem_mgr)
 {
 	mmg->dev = dev;
 	spin_lock_init(&mmg->lock);
 	idr_init(&mmg->handles);
+	mmg->is_kernel_mem_mgr = is_kernel_mem_mgr;
 }
 
 /**
-- 
2.25.1

