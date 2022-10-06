Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0C85F627F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiJFIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJFIXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C98C47A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962776188C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E40C433D6;
        Thu,  6 Oct 2022 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044598;
        bh=k9RFqWiqihoSOzE3GA4zMwPlYF9fYt87ZAQV9BYx2FY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jm/XbkpDlNf/Crb2zTpwZeW5dxhqe9CmGWadAyOm3CNg3GQ3/RDqmImRYSFiBF0iA
         H/sCSpAjFmeI93G0OHI0R7RaoVkxi3+mYZ3perSKFJywLadBOBoOPgG6mA854+VcnG
         0hJq1ilveb2rBJUlC0QVgZLJJGvMf3goSbT9dAMaq9ZYKvbJJ6BPdsFwolR4jHoU4T
         AULO0WgWZmmwraX0h1aLHVUsMoHYj2iuPnVZk7GSH6bODKyW2PHhRZzpz0OHCiZV8B
         DevhJUuO9NDTPtjkTd6WZVsh0/EpG1oUaJ6iBkFhS1cRZXvh5KN5xFYrv6sk87Vtid
         EGtGXp/XhOaNQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 04/13] habanalabs: replace 'pf' to 'prefetch'
Date:   Thu,  6 Oct 2022 11:22:59 +0300
Message-Id: <20221006082308.1266716-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006082308.1266716-1-ogabbay@kernel.org>
References: <20221006082308.1266716-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

pf was an abbreviation for prefetch but because pf already stands
for 'physical function', we decided to change it to 'prefetch'.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 14 ++++++-------
 drivers/misc/habanalabs/common/habanalabs.h |  8 ++++----
 drivers/misc/habanalabs/common/mmu/mmu.c    | 22 ++++++++++-----------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 5dc6c77b4721..bf675cf39f71 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -783,8 +783,8 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_cs_cmplt_wq;
 	}
 
-	hdev->pf_wq = alloc_workqueue("hl-prefetch", WQ_UNBOUND, 0);
-	if (!hdev->pf_wq) {
+	hdev->prefetch_wq = alloc_workqueue("hl-prefetch", WQ_UNBOUND, 0);
+	if (!hdev->prefetch_wq) {
 		dev_err(hdev->dev, "Failed to allocate MMU prefetch workqueue\n");
 		rc = -ENOMEM;
 		goto free_ts_free_wq;
@@ -794,7 +794,7 @@ static int device_early_init(struct hl_device *hdev)
 					GFP_KERNEL);
 	if (!hdev->hl_chip_info) {
 		rc = -ENOMEM;
-		goto free_pf_wq;
+		goto free_prefetch_wq;
 	}
 
 	rc = hl_mmu_if_set_funcs(hdev);
@@ -833,8 +833,8 @@ static int device_early_init(struct hl_device *hdev)
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
-free_pf_wq:
-	destroy_workqueue(hdev->pf_wq);
+free_prefetch_wq:
+	destroy_workqueue(hdev->prefetch_wq);
 free_ts_free_wq:
 	destroy_workqueue(hdev->ts_free_obj_wq);
 free_cs_cmplt_wq:
@@ -877,7 +877,7 @@ static void device_early_fini(struct hl_device *hdev)
 
 	kfree(hdev->hl_chip_info);
 
-	destroy_workqueue(hdev->pf_wq);
+	destroy_workqueue(hdev->prefetch_wq);
 	destroy_workqueue(hdev->ts_free_obj_wq);
 	destroy_workqueue(hdev->cs_cmplt_wq);
 	destroy_workqueue(hdev->eq_wq);
@@ -1076,7 +1076,7 @@ static void cleanup_resources(struct hl_device *hdev, bool hard_reset, bool fw_r
 	hl_cs_rollback_all(hdev, skip_wq_flush);
 
 	/* flush the MMU prefetch workqueue */
-	flush_workqueue(hdev->pf_wq);
+	flush_workqueue(hdev->prefetch_wq);
 
 	/* Release all pending user interrupts, each pending user interrupt
 	 * holds a reference to user context
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 1489240d5a3a..6d8ce4a1dbb1 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2811,7 +2811,7 @@ struct hl_mmu_funcs {
 
 /**
  * struct hl_prefetch_work - prefetch work structure handler
- * @pf_work: actual work struct.
+ * @prefetch_work: actual work struct.
  * @ctx: compute context.
  * @va: virtual address to pre-fetch.
  * @size: pre-fetch size.
@@ -2819,7 +2819,7 @@ struct hl_mmu_funcs {
  * @asid: ASID for maintenance operation.
  */
 struct hl_prefetch_work {
-	struct work_struct	pf_work;
+	struct work_struct	prefetch_work;
 	struct hl_ctx		*ctx;
 	u64			va;
 	u64			size;
@@ -3060,7 +3060,7 @@ struct hl_reset_info {
  * @cs_cmplt_wq: work queue of CS completions for executing work in process
  *               context.
  * @ts_free_obj_wq: work queue for timestamp registration objects release.
- * @pf_wq: work queue for MMU pre-fetch operations.
+ * @prefetch_wq: work queue for MMU pre-fetch operations.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
@@ -3231,7 +3231,7 @@ struct hl_device {
 	struct workqueue_struct		*eq_wq;
 	struct workqueue_struct		*cs_cmplt_wq;
 	struct workqueue_struct		*ts_free_obj_wq;
-	struct workqueue_struct		*pf_wq;
+	struct workqueue_struct		*prefetch_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
diff --git a/drivers/misc/habanalabs/common/mmu/mmu.c b/drivers/misc/habanalabs/common/mmu/mmu.c
index cf8946266615..589179f8cd41 100644
--- a/drivers/misc/habanalabs/common/mmu/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu/mmu.c
@@ -699,7 +699,7 @@ int hl_mmu_invalidate_cache_range(struct hl_device *hdev, bool is_hard,
 
 static void hl_mmu_prefetch_work_function(struct work_struct *work)
 {
-	struct hl_prefetch_work *pfw = container_of(work, struct hl_prefetch_work, pf_work);
+	struct hl_prefetch_work *pfw = container_of(work, struct hl_prefetch_work, prefetch_work);
 	struct hl_ctx *ctx = pfw->ctx;
 	struct hl_device *hdev = ctx->hdev;
 
@@ -723,25 +723,25 @@ static void hl_mmu_prefetch_work_function(struct work_struct *work)
 
 int hl_mmu_prefetch_cache_range(struct hl_ctx *ctx, u32 flags, u32 asid, u64 va, u64 size)
 {
-	struct hl_prefetch_work *handle_pf_work;
+	struct hl_prefetch_work *handle_prefetch_work;
 
-	handle_pf_work = kmalloc(sizeof(*handle_pf_work), GFP_KERNEL);
-	if (!handle_pf_work)
+	handle_prefetch_work = kmalloc(sizeof(*handle_prefetch_work), GFP_KERNEL);
+	if (!handle_prefetch_work)
 		return -ENOMEM;
 
-	INIT_WORK(&handle_pf_work->pf_work, hl_mmu_prefetch_work_function);
-	handle_pf_work->ctx = ctx;
-	handle_pf_work->va = va;
-	handle_pf_work->size = size;
-	handle_pf_work->flags = flags;
-	handle_pf_work->asid = asid;
+	INIT_WORK(&handle_prefetch_work->prefetch_work, hl_mmu_prefetch_work_function);
+	handle_prefetch_work->ctx = ctx;
+	handle_prefetch_work->va = va;
+	handle_prefetch_work->size = size;
+	handle_prefetch_work->flags = flags;
+	handle_prefetch_work->asid = asid;
 
 	/*
 	 * as actual prefetch is done in a WQ we must get the context (and put it
 	 * at the end of the work function)
 	 */
 	hl_ctx_get(ctx);
-	queue_work(ctx->hdev->pf_wq, &handle_pf_work->pf_work);
+	queue_work(ctx->hdev->prefetch_wq, &handle_prefetch_work->prefetch_work);
 
 	return 0;
 }
-- 
2.25.1

