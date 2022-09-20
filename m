Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548475BE65A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiITMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiITMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:52:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BF36C77B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72899B828C7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86966C433D6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663678375;
        bh=v4UlRST0egjIsO0Jzsjn7ecMPiOeqtkiJEDpcpP31cw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GDDwsSzWEwo8E4r0Km/86XR0Iaq/IhmaM0JoTSBVpUSFMtsNFUzdJZfqCgQmUKq+b
         48WTdEgTmh+BgXGPHyhbnjC58/7KCM6BpG7DmYL+JunWy/+xUJl31h8piYt+ESzOv9
         DmXRQB2FHlc2TQDMPzDA4xgCDf/CZAc9QeyWpFy3RtwLjcbmWwHP6pwUqfgif1ij0c
         qzmnkT5iBUxVtGumKKUL4I/Ovie5LIxFY6GXwDKeaSxy7PdB7lyCbxumTCODFfPLIm
         AnnUFl6fZ1U1TLqm+oHdpw96T8JtzzRedmVWr1+3JI6TjAMDWA2CtMdnYvc1JDKaEr
         Qs4dle9SvVGTA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] habanalabs: eliminate aggregate use warning
Date:   Tue, 20 Sep 2022 15:52:45 +0300
Message-Id: <20220920125245.161233-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920125245.161233-1-ogabbay@kernel.org>
References: <20220920125245.161233-1-ogabbay@kernel.org>
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

When doing sizeof() and giving as argument a dereference of
a pointer-to-a-pointer object, clang will issue a warning.

Eliminate the warning by passing struct <name>*

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 drivers/misc/habanalabs/common/device.c             | 4 ++--
 drivers/misc/habanalabs/common/hw_queue.c           | 4 +---
 drivers/misc/habanalabs/common/hwmon.c              | 3 ++-
 drivers/misc/habanalabs/common/memory.c             | 3 +--
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index fbe5003191bf..fa05770865c6 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2571,7 +2571,7 @@ static int hl_cs_poll_fences(struct multi_cs_data *mcs_data, struct multi_cs_com
 	ktime_t max_ktime, first_cs_time;
 	enum hl_cs_wait_status status;
 
-	memset(fence_ptr, 0, arr_len * sizeof(*fence_ptr));
+	memset(fence_ptr, 0, arr_len * sizeof(struct hl_fence *));
 
 	/* get all fences under the same lock */
 	rc = hl_ctx_get_fences(mcs_data->ctx, seq_arr, fence_ptr, arr_len);
@@ -2873,7 +2873,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	}
 
 	/* allocate array for the fences */
-	fence_arr = kmalloc_array(seq_arr_len, sizeof(*fence_arr), GFP_KERNEL);
+	fence_arr = kmalloc_array(seq_arr_len, sizeof(struct hl_fence *), GFP_KERNEL);
 	if (!fence_arr) {
 		rc = -ENOMEM;
 		goto free_seq_arr;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index c6a00bb259fb..233d8b46c831 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -719,7 +719,7 @@ static int device_early_init(struct hl_device *hdev)
 
 	if (hdev->asic_prop.completion_queues_count) {
 		hdev->cq_wq = kcalloc(hdev->asic_prop.completion_queues_count,
-				sizeof(*hdev->cq_wq),
+				sizeof(struct workqueue_struct *),
 				GFP_KERNEL);
 		if (!hdev->cq_wq) {
 			rc = -ENOMEM;
@@ -1863,7 +1863,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	}
 
 	hdev->shadow_cs_queue = kcalloc(hdev->asic_prop.max_pending_cs,
-					sizeof(*hdev->shadow_cs_queue), GFP_KERNEL);
+					sizeof(struct hl_cs *), GFP_KERNEL);
 	if (!hdev->shadow_cs_queue) {
 		rc = -ENOMEM;
 		goto cq_fini;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 3f15ab9d827f..d0087c0ec48c 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -826,9 +826,7 @@ static int ext_and_cpu_queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 
 	q->kernel_address = p;
 
-	q->shadow_queue = kmalloc_array(HL_QUEUE_LENGTH,
-					sizeof(*q->shadow_queue),
-					GFP_KERNEL);
+	q->shadow_queue = kmalloc_array(HL_QUEUE_LENGTH, sizeof(struct hl_cs_job *), GFP_KERNEL);
 	if (!q->shadow_queue) {
 		dev_err(hdev->dev,
 			"Failed to allocate shadow queue for H/W queue %d\n",
diff --git a/drivers/misc/habanalabs/common/hwmon.c b/drivers/misc/habanalabs/common/hwmon.c
index 8c262aeb425e..55eb0203817f 100644
--- a/drivers/misc/habanalabs/common/hwmon.c
+++ b/drivers/misc/habanalabs/common/hwmon.c
@@ -194,7 +194,8 @@ int hl_build_hwmon_channel_info(struct hl_device *hdev, struct cpucp_sensor *sen
 		curr_arr[sensors_by_type_next_index[type]++] = flags;
 	}
 
-	channels_info = kcalloc(num_active_sensor_types + 1, sizeof(*channels_info), GFP_KERNEL);
+	channels_info = kcalloc(num_active_sensor_types + 1, sizeof(struct hwmon_channel_info *),
+				GFP_KERNEL);
 	if (!channels_info) {
 		rc = -ENOMEM;
 		goto channels_info_array_err;
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 096fa3c1ae95..ef28f3b37b93 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -2308,8 +2308,7 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -EFAULT;
 	}
 
-	userptr->pages = kvmalloc_array(npages, sizeof(*userptr->pages),
-					GFP_KERNEL);
+	userptr->pages = kvmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
 	if (!userptr->pages)
 		return -ENOMEM;
 
-- 
2.25.1

