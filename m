Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843D674B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjATEoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjATEoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61273C41F6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:39:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2538B8205E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9329EC433F0;
        Thu, 19 Jan 2023 10:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124432;
        bh=npgZ7cZeUwSLp5eCEJfUGNc7XF3CC0gI/VnUQs/Izac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5CyF4nhl/sPhosnfmyBDZkfATOIrnH65bhMX7uiJpXb3LqcXkiVMld1wtWv9uiMM
         paGOrfGBK0873J/gDcCkWGaOJrLu6FWC0Qw43ylGnDi+V+92SDbTR0FxkiHlyNU35C
         D4t8awrdxLlLs6QCbHWiZyLJeiVQ0H9qUUq9+2yqpBiAOKqkyWBau6NEA1GOIG/YRi
         jBQKF0LRVARgzwtm/4WYVVDomBG9UTN6FdaTDMF3S67N3FwZASgslU6IwyIIb5MM7D
         mjWE80TkVFb5TSXNvbRwC4zJHvUvWeYuqnm0x40EuZtZRaWfhsFvvJQ0dYyjddSCd5
         Le9nZfwNhHofg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/10] habanalabs: optimize command submission completion timestamp
Date:   Thu, 19 Jan 2023 12:33:35 +0200
Message-Id: <20230119103339.718430-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

Completion timestamp is taken during the actual command submission
release. As the release happens in a work queue, the timestamp taken
is not accurate. Hence, we will take the timestamp in the interrupt
handler itself while propagating it to the release function.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../accel/habanalabs/common/command_submission.c    | 12 ++++++++++--
 drivers/accel/habanalabs/common/habanalabs.h        |  4 ++++
 drivers/accel/habanalabs/common/irq.c               | 13 +++++++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/habanalabs/common/command_submission.c b/drivers/accel/habanalabs/common/command_submission.c
index 00fedf2d8654..8270db0a72a2 100644
--- a/drivers/accel/habanalabs/common/command_submission.c
+++ b/drivers/accel/habanalabs/common/command_submission.c
@@ -398,8 +398,16 @@ static void hl_complete_job(struct hl_device *hdev, struct hl_cs_job *job)
 	 * flow by calling 'hl_hw_queue_update_ci'.
 	 */
 	if (cs_needs_completion(cs) &&
-		(job->queue_type == QUEUE_TYPE_EXT || job->queue_type == QUEUE_TYPE_HW))
+			(job->queue_type == QUEUE_TYPE_EXT || job->queue_type == QUEUE_TYPE_HW)) {
+
+		/* In CS based completions, the timestamp is already available,
+		 * so no need to extract it from job
+		 */
+		if (hdev->asic_prop.completion_mode == HL_COMPLETION_MODE_JOB)
+			cs->completion_timestamp = job->timestamp;
+
 		cs_put(cs);
+	}
 
 	hl_cs_job_put(job);
 }
@@ -776,7 +784,7 @@ static void cs_do_release(struct kref *ref)
 	}
 
 	if (cs->timestamp) {
-		cs->fence->timestamp = ktime_get();
+		cs->fence->timestamp = cs->completion_timestamp;
 		hl_push_cs_outcome(hdev, &cs->ctx->outcome_store, cs->sequence,
 				   cs->fence->timestamp, cs->fence->error);
 	}
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index a0dfbf4f6cbb..afc0c0d3f9e3 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1940,6 +1940,7 @@ struct hl_userptr {
  * @type: CS_TYPE_*.
  * @jobs_cnt: counter of submitted jobs on all queues.
  * @encaps_sig_hdl_id: encaps signals handle id, set for the first staged cs.
+ * @completion_timestamp: timestamp of the last completed cs job.
  * @sob_addr_offset: sob offset from the configuration base address.
  * @initial_sob_count: count of completed signals in SOB before current submission of signal or
  *                     cs with encaps signals.
@@ -1972,6 +1973,7 @@ struct hl_cs {
 	struct list_head	staged_cs_node;
 	struct list_head	debugfs_list;
 	struct hl_cs_encaps_sig_handle *encaps_sig_hdl;
+	ktime_t			completion_timestamp;
 	u64			sequence;
 	u64			staged_sequence;
 	u64			timeout_jiffies;
@@ -2007,6 +2009,7 @@ struct hl_cs {
  * @debugfs_list: node in debugfs list of command submission jobs.
  * @refcount: reference counter for usage of the CS job.
  * @queue_type: the type of the H/W queue this job is submitted to.
+ * @timestamp: timestamp upon job completion
  * @id: the id of this job inside a CS.
  * @hw_queue_id: the id of the H/W queue this job is submitted to.
  * @user_cb_size: the actual size of the CB we got from the user.
@@ -2033,6 +2036,7 @@ struct hl_cs_job {
 	struct list_head	debugfs_list;
 	struct kref		refcount;
 	enum hl_queue_type	queue_type;
+	ktime_t			timestamp;
 	u32			id;
 	u32			hw_queue_id;
 	u32			user_cb_size;
diff --git a/drivers/accel/habanalabs/common/irq.c b/drivers/accel/habanalabs/common/irq.c
index a986d7dea453..04844e843a7b 100644
--- a/drivers/accel/habanalabs/common/irq.c
+++ b/drivers/accel/habanalabs/common/irq.c
@@ -72,15 +72,17 @@ static void irq_handle_eqe(struct work_struct *work)
  * @hdev: pointer to device structure
  * @cs_seq: command submission sequence
  * @cq: completion queue
+ * @timestamp: interrupt timestamp
  *
  */
-static void job_finish(struct hl_device *hdev, u32 cs_seq, struct hl_cq *cq)
+static void job_finish(struct hl_device *hdev, u32 cs_seq, struct hl_cq *cq, ktime_t timestamp)
 {
 	struct hl_hw_queue *queue;
 	struct hl_cs_job *job;
 
 	queue = &hdev->kernel_queues[cq->hw_queue_id];
 	job = queue->shadow_queue[hl_pi_2_offset(cs_seq)];
+	job->timestamp = timestamp;
 	queue_work(hdev->cq_wq[cq->cq_idx], &job->finish_work);
 
 	atomic_inc(&queue->ci);
@@ -91,9 +93,10 @@ static void job_finish(struct hl_device *hdev, u32 cs_seq, struct hl_cq *cq)
  *
  * @hdev: pointer to device structure
  * @cs_seq: command submission sequence
+ * @timestamp: interrupt timestamp
  *
  */
-static void cs_finish(struct hl_device *hdev, u16 cs_seq)
+static void cs_finish(struct hl_device *hdev, u16 cs_seq, ktime_t timestamp)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	struct hl_hw_queue *queue;
@@ -113,6 +116,7 @@ static void cs_finish(struct hl_device *hdev, u16 cs_seq)
 		atomic_inc(&queue->ci);
 	}
 
+	cs->completion_timestamp = timestamp;
 	queue_work(hdev->cs_cmplt_wq, &cs->finish_work);
 }
 
@@ -130,6 +134,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 	bool shadow_index_valid, entry_ready;
 	u16 shadow_index;
 	struct hl_cq_entry *cq_entry, *cq_base;
+	ktime_t timestamp = ktime_get();
 
 	if (hdev->disabled) {
 		dev_dbg(hdev->dev,
@@ -171,9 +176,9 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
 		if (shadow_index_valid && !hdev->disabled) {
 			if (hdev->asic_prop.completion_mode ==
 					HL_COMPLETION_MODE_CS)
-				cs_finish(hdev, shadow_index);
+				cs_finish(hdev, shadow_index, timestamp);
 			else
-				job_finish(hdev, shadow_index, cq);
+				job_finish(hdev, shadow_index, cq, timestamp);
 		}
 
 		/* Clear CQ entry ready bit */
-- 
2.25.1

