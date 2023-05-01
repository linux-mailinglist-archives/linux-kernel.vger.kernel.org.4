Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E7A6F2E34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjEADYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjEADXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6C7D8A;
        Sun, 30 Apr 2023 20:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32ECE60F9A;
        Mon,  1 May 2023 03:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31802C433D2;
        Mon,  1 May 2023 03:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910038;
        bh=KXJLN6MZGUoUox3x+K+WE5vMoTDjKZFodfXyKKEXQC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/bF91V5Ilh6TR5m387ohUK0LbxAGcs5a9A4fL7Hmt/SSEcQbEu6oC9VH0FYhsv7C
         KAbkXuUzxsxMkoShwh0G9AZpHbHHeZwhQU0cCm6eDowG9G8CQ5Beq/4o5RxmlGJQvP
         WGX3q8FxdWX78LmWkfXNwyvY9s3Hq0aGbpeGiydivXt8HGrh6DD3bXQzThJ6yr7zGv
         7a0R1cPm2L/BARYTYW9xWOIdeVchK82OyIZ5mzlZvG5+jj18dzNJus5GePmZp4gySH
         wP16tUO2v+iQtyTm6feI6EElfRb36+o3rTX4usfXqE+luIxFRhwGeI0zJqxmbMjUKs
         8sDHZNcnqlMTw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>, gregkh@linuxfoundation.org,
        dliberman@habana.ai, osharabi@habana.ai, obitton@habana.ai,
        dhirschfeld@habana.ai, ynudelman@habana.ai, talcohen@habana.ai,
        bjauhari@habana.ai, rkatta@habana.ai
Subject: [PATCH AUTOSEL 6.2 11/37] accel/habanalabs: postpone mem_mgr IDR destruction to hpriv_release()
Date:   Sun, 30 Apr 2023 22:59:19 -0400
Message-Id: <20230501025945.3253774-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

[ Upstream commit 2e8e9a895c4589f124a37fc84d123b5114406e94 ]

The memory manager IDR is currently destroyed when user releases the
file descriptor.
However, at this point the user context might be still held, and memory
buffers might be still in use.
Later on, calls to release those buffers will fail due to not finding
their handles in the IDR, leading to a memory leak.
To avoid this leak, split the IDR destruction from the memory manager
fini, and postpone it to hpriv_release() when there is no user context
and no buffers are used.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/common/device.c         |  9 +++++++++
 drivers/misc/habanalabs/common/habanalabs.h     |  1 +
 drivers/misc/habanalabs/common/habanalabs_drv.c |  1 +
 drivers/misc/habanalabs/common/memory_mgr.c     | 13 ++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index f7b9c3871518b..1334d2b664ec6 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -423,6 +423,9 @@ static void hpriv_release(struct kref *ref)
 	mutex_destroy(&hpriv->ctx_lock);
 	mutex_destroy(&hpriv->restore_phase_mutex);
 
+	/* There should be no memory buffers at this point and handles IDR can be destroyed */
+	hl_mem_mgr_idr_destroy(&hpriv->mem_mgr);
+
 	/* Device should be reset if reset-upon-device-release is enabled, or if there is a pending
 	 * reset that waits for device release.
 	 */
@@ -517,6 +520,10 @@ static int hl_device_release(struct inode *inode, struct file *filp)
 	hl_release_pending_user_interrupts(hpriv->hdev);
 
 	hl_ctx_mgr_fini(hdev, &hpriv->ctx_mgr);
+
+	/* Memory buffers might be still in use at this point and thus the handles IDR destruction
+	 * is postponed to hpriv_release().
+	 */
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
 
 	hdev->compute_ctx_in_release = 1;
@@ -890,6 +897,7 @@ static int device_early_init(struct hl_device *hdev)
 
 free_cb_mgr:
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
+	hl_mem_mgr_idr_destroy(&hdev->kernel_mem_mgr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
 free_prefetch_wq:
@@ -933,6 +941,7 @@ static void device_early_fini(struct hl_device *hdev)
 	mutex_destroy(&hdev->clk_throttling.lock);
 
 	hl_mem_mgr_fini(&hdev->kernel_mem_mgr);
+	hl_mem_mgr_idr_destroy(&hdev->kernel_mem_mgr);
 
 	kfree(hdev->hl_chip_info);
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index e2527d976ee05..c2dcc2f66835a 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -3801,6 +3801,7 @@ const char *hl_sync_engine_to_string(enum hl_sync_engine_type engine_type);
 
 void hl_mem_mgr_init(struct device *dev, struct hl_mem_mgr *mmg);
 void hl_mem_mgr_fini(struct hl_mem_mgr *mmg);
+void hl_mem_mgr_idr_destroy(struct hl_mem_mgr *mmg);
 int hl_mem_mgr_mmap(struct hl_mem_mgr *mmg, struct vm_area_struct *vma,
 		    void *args);
 struct hl_mmap_mem_buf *hl_mmap_mem_buf_get(struct hl_mem_mgr *mmg,
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 7815c60df54e2..82d0242ea8670 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -235,6 +235,7 @@ int hl_device_open(struct inode *inode, struct file *filp)
 out_err:
 	mutex_unlock(&hdev->fpriv_list_lock);
 	hl_mem_mgr_fini(&hpriv->mem_mgr);
+	hl_mem_mgr_idr_destroy(&hpriv->mem_mgr);
 	hl_ctx_mgr_fini(hpriv->hdev, &hpriv->ctx_mgr);
 	filp->private_data = NULL;
 	mutex_destroy(&hpriv->ctx_lock);
diff --git a/drivers/misc/habanalabs/common/memory_mgr.c b/drivers/misc/habanalabs/common/memory_mgr.c
index 1936d653699ed..93a2b9faf419f 100644
--- a/drivers/misc/habanalabs/common/memory_mgr.c
+++ b/drivers/misc/habanalabs/common/memory_mgr.c
@@ -342,8 +342,19 @@ void hl_mem_mgr_fini(struct hl_mem_mgr *mmg)
 				"%s: Buff handle %u for CTX is still alive\n",
 				topic, id);
 	}
+}
 
-	/* TODO: can it happen that some buffer is still in use at this point? */
+/**
+ * hl_mem_mgr_idr_destroy() - destroy memory manager IDR.
+ * @mmg: parent unified memory manager
+ *
+ * Destroy the memory manager IDR.
+ * Shall be called when IDR is empty and no memory buffers are in use.
+ */
+void hl_mem_mgr_idr_destroy(struct hl_mem_mgr *mmg)
+{
+	if (!idr_is_empty(&mmg->handles))
+		dev_crit(mmg->dev, "memory manager IDR is destroyed while it is not empty!\n");
 
 	idr_destroy(&mmg->handles);
 }
-- 
2.39.2

