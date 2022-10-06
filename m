Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C5E5F6284
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJFIYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJFIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA7923DE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 734D161890
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 08:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C5C433D6;
        Thu,  6 Oct 2022 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665044604;
        bh=tUxIKzHrkEhVK618Ugy8GnHgWCzvOHEJIiRhWvOQbRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kA8aPPZdQje5J2KciePduY1WUHj4E3txNVOMWKZvbzc12fFyHxo5zr1dxgmYzAAWQ
         XNZfJ6nCBiLotszJ7Lzq0mdTYGTZtHx7XgNWyeQ6ZTipkYn4/PNoYv1Vm2nvcBjefL
         oYzpXpD5iGOMk7IF7prlt+opuJfdX5f3+k3SopI3tsDECoHQs59oSeasz0cuLHMXxm
         oBDUwBJhYmgwtTYvVHZ0WA0df7qkYvs5ApQtTD2IQz3jJyd3EILuKFwO67O9TUlpLf
         QAbR6v9g8o6GYPhmemgwoXbsAkt7zZGRGGStj/+Dpvai9NtaIdDd/XJZ46Ozn81aXi
         w+vauZJO3MM6A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/13] habanalabs: move reset workqueue to be under hl_device
Date:   Thu,  6 Oct 2022 11:23:04 +0300
Message-Id: <20221006082308.1266716-9-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

'struct hl_device_reset_work' is used as a wrapper for the reset work
and its parameters, including the reset workqueue on which it runs.
In a future commit, another reset related work with similar parameters
is going to be added, but it won't use the reset workqueue.

As in any case there is a single reset workqueue, and to allow the resue
of this structure, move the reset workqueue to 'struct hl_device'.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 15 ++++++---------
 drivers/misc/habanalabs/common/habanalabs.h | 12 ++++++------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e60ed0c8a9db..e9b373a8cdad 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -684,9 +684,8 @@ static void device_hard_reset_pending(struct work_struct *work)
 			"Could not reset device. will try again in %u seconds",
 			HL_PENDING_RESET_PER_SEC);
 
-		queue_delayed_work(device_reset_work->wq,
-			&device_reset_work->reset_work,
-			msecs_to_jiffies(HL_PENDING_RESET_PER_SEC * 1000));
+		queue_delayed_work(hdev->reset_wq, &device_reset_work->reset_work,
+					msecs_to_jiffies(HL_PENDING_RESET_PER_SEC * 1000));
 	}
 }
 
@@ -801,9 +800,8 @@ static int device_early_init(struct hl_device *hdev)
 
 	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);
 
-	hdev->device_reset_work.wq =
-			create_singlethread_workqueue("hl_device_reset");
-	if (!hdev->device_reset_work.wq) {
+	hdev->reset_wq = create_singlethread_workqueue("hl_device_reset");
+	if (!hdev->reset_wq) {
 		rc = -ENOMEM;
 		dev_err(hdev->dev, "Failed to create device reset WQ\n");
 		goto free_cb_mgr;
@@ -879,7 +877,7 @@ static void device_early_fini(struct hl_device *hdev)
 	destroy_workqueue(hdev->ts_free_obj_wq);
 	destroy_workqueue(hdev->cs_cmplt_wq);
 	destroy_workqueue(hdev->eq_wq);
-	destroy_workqueue(hdev->device_reset_work.wq);
+	destroy_workqueue(hdev->reset_wq);
 
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		destroy_workqueue(hdev->cq_wq[i]);
@@ -1460,8 +1458,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		 * Because the reset function can't run from heartbeat work,
 		 * we need to call the reset function from a dedicated work.
 		 */
-		queue_delayed_work(hdev->device_reset_work.wq,
-			&hdev->device_reset_work.reset_work, 0);
+		queue_delayed_work(hdev->reset_wq, &hdev->device_reset_work.reset_work, 0);
 
 		return 0;
 	}
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6d8ce4a1dbb1..4913197c433e 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2682,17 +2682,15 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 struct hwmon_chip_info;
 
 /**
- * struct hl_device_reset_work - reset workqueue task wrapper.
- * @wq: work queue for device reset procedure.
+ * struct hl_device_reset_work - reset work wrapper.
  * @reset_work: reset work to be done.
  * @hdev: habanalabs device structure.
  * @flags: reset flags.
  */
 struct hl_device_reset_work {
-	struct workqueue_struct		*wq;
-	struct delayed_work		reset_work;
-	struct hl_device		*hdev;
-	u32				flags;
+	struct delayed_work	reset_work;
+	struct hl_device	*hdev;
+	u32			flags;
 };
 
 /**
@@ -3061,6 +3059,7 @@ struct hl_reset_info {
  *               context.
  * @ts_free_obj_wq: work queue for timestamp registration objects release.
  * @prefetch_wq: work queue for MMU pre-fetch operations.
+ * @reset_wq: work queue for device reset procedure.
  * @kernel_ctx: Kernel driver context structure.
  * @kernel_queues: array of hl_hw_queue.
  * @cs_mirror_list: CS mirror list for TDR.
@@ -3232,6 +3231,7 @@ struct hl_device {
 	struct workqueue_struct		*cs_cmplt_wq;
 	struct workqueue_struct		*ts_free_obj_wq;
 	struct workqueue_struct		*prefetch_wq;
+	struct workqueue_struct		*reset_wq;
 	struct hl_ctx			*kernel_ctx;
 	struct hl_hw_queue		*kernel_queues;
 	struct list_head		cs_mirror_list;
-- 
2.25.1

