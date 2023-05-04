Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC366F6819
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjEDJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEDJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B693ABF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D22333933;
        Thu,  4 May 2023 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRpPk2OAt1XjanwaNas9Trw8tVdU+qjHxgEEKaT3M8k=;
        b=tsRL6enyVg3JADqIgAi/8v8/VS66p/iqZy4ZQoGgRd5ZATVqbnKQDLSixPSIg9ftTAKC5i
        ZdpxDq02zsM4EkayMddRZVlw5gYLgM935jN6pLKuoYOKjgCKYf2YxYOLvXOuam5XsW7Q84
        cA5cGHsNPH387j/YsIHA576D2v1IFdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRpPk2OAt1XjanwaNas9Trw8tVdU+qjHxgEEKaT3M8k=;
        b=bVao6M3qpKLZuXT1/NibtApS5MzcgAlI8zo3j0d4QE9xW/1bV+hkCc/gXuyyRQbrfxeysd
        I+9YBiqdwYlCxEDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C37713444;
        Thu,  4 May 2023 09:13:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id doEtFiN3U2ToTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:07 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 7/9] nvme-rdma: replace state machine with generic one
Date:   Thu,  4 May 2023 11:12:57 +0200
Message-Id: <20230504091259.29100-8-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504091259.29100-1-dwagner@suse.de>
References: <20230504091259.29100-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 703 ++++++++++-----------------------------
 1 file changed, 173 insertions(+), 530 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b0ab5a9d5fe0..1fde65e8c2b5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -568,35 +568,16 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_ctrl *nctrl, int idx)
+static int __nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
+				   struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct nvme_rdma_queue *queue;
 	struct sockaddr *src_addr = NULL;
-	size_t queue_size;
 	int ret;
 
-	if (idx == 0)
-		queue_size = NVME_AQ_DEPTH;
-	else
-		queue_size = ctrl->ctrl.sqsize + 1;
-
-	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
-	if (idx && ctrl->ctrl.max_integrity_segments)
-		queue->pi_support = true;
-	else
-		queue->pi_support = false;
 	init_completion(&queue->cm_done);
 
-	if (idx > 0)
-		queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
-	else
-		queue->cmnd_capsule_len = sizeof(struct nvme_command);
-
-	queue->queue_size = queue_size;
-
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
@@ -638,62 +619,120 @@ static int nvme_rdma_alloc_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
+static void __nvme_rdma_free_queue(struct nvme_rdma_ctrl *ctrl,
+				   struct nvme_rdma_queue *queue)
 {
-	rdma_disconnect(queue->cm_id);
-	ib_drain_qp(queue->qp);
+	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
+	rdma_destroy_id(queue->cm_id);
+	nvme_rdma_destroy_queue_ib(queue);
+	mutex_destroy(&queue->queue_lock);
 }
 
-static void nvme_rdma_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static int nvme_rdma_alloc_admin_queue(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+	struct nvme_rdma_queue *queue = &ctrl->queues[0];
+	bool pi_capable = false;
+	int ret;
 
-	mutex_lock(&queue->queue_lock);
-	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
-		__nvme_rdma_stop_queue(queue);
-	mutex_unlock(&queue->queue_lock);
+	queue->cmnd_capsule_len = sizeof(struct nvme_command);
+	queue->queue_size = NVME_AQ_DEPTH;
+	queue->pi_support = false;
+
+	ret = __nvme_rdma_alloc_queue(ctrl, queue);
+	if (ret)
+		return ret;
+
+	ctrl->device = queue->device;
+	nctrl->numa_node = ibdev_to_node(ctrl->device->dev);
+
+	/* T10-PI support */
+	if (ctrl->device->dev->attrs.kernel_cap_flags &
+	    IBK_INTEGRITY_HANDOVER)
+		pi_capable = true;
+
+	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
+							pi_capable);
+
+	/*
+	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
+	 * It's safe, since any chage in the underlying RDMA device will issue
+	 * error recovery and queue re-creation.
+	 */
+	ret = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+				 sizeof(struct nvme_command), DMA_TO_DEVICE);
+	if (ret) {
+		__nvme_rdma_free_queue(ctrl, queue);
+		return ret;
+	}
+
+	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
+	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
+	if (pi_capable)
+		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
+	else
+		ctrl->ctrl.max_integrity_segments = 0;
+
+	return 0;
 }
 
-static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
+static int nvme_rdma_alloc_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
-	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
-		return;
+	queue->cmnd_capsule_len = ctrl->ctrl.ioccsz * 16;
+	queue->queue_size = ctrl->ctrl.sqsize + 1;
+	if (ctrl->ctrl.max_integrity_segments)
+		queue->pi_support = true;
+	else
+		queue->pi_support = false;
 
-	rdma_destroy_id(queue->cm_id);
-	nvme_rdma_destroy_queue_ib(queue);
-	mutex_destroy(&queue->queue_lock);
+	return __nvme_rdma_alloc_queue(ctrl, queue);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_free_admin_queue(struct nvme_ctrl *nctrl)
 {
-	int i;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[0];
+
+	if (ctrl->async_event_sqe.data) {
+		cancel_work_sync(&ctrl->ctrl.async_event_work);
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+				  sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_free_queue(&ctrl->ctrl, i);
+	__nvme_rdma_free_queue(ctrl, queue);
 }
 
-static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_free_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	int i;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_stop_queue(&ctrl->ctrl, i);
+	__nvme_rdma_free_queue(ctrl, queue);
+}
+
+static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
+{
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)) {
+		rdma_disconnect(queue->cm_id);
+		ib_drain_qp(queue->qp);
+	}
+	mutex_unlock(&queue->queue_lock);
 }
 
-static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
+static int nvme_rdma_start_admin_queue(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
+	struct nvme_rdma_queue *queue = &ctrl->queues[0];
 	int ret;
 
-	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
-		ret = nvmf_connect_admin_queue(nctrl);
+	ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
 		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
@@ -701,58 +740,74 @@ static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 			__nvme_rdma_stop_queue(queue);
 		dev_info(ctrl->ctrl.device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
+			"failed to connect queue: %d ret=%d\n", 0, ret);
 	}
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
-				     int first, int last)
+static int nvme_rdma_start_io_queue(struct nvme_ctrl *nctrl, int idx)
 {
-	int i, ret = 0;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
+	int ret;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_stop_queues;
+	ret = nvmf_connect_io_queue(nctrl, idx);
+	if (!ret) {
+		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
+	} else {
+		if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+			__nvme_rdma_stop_queue(queue);
+		dev_info(ctrl->ctrl.device,
+			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
+	return ret;
+}
 
-	return 0;
+static void nvme_rdma_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[0];
 
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->ctrl, i);
-	return ret;
+	__nvme_rdma_stop_queue(queue);
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
+	__nvme_rdma_stop_queue(queue);
+}
+
+static unsigned int nvme_rdma_nr_io_queues(struct nvme_ctrl *ctrl)
+{
+	struct ib_device *ibdev = to_rdma_ctrl(ctrl)->device->dev;
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	unsigned int nr_io_queues;
+
+	nr_io_queues = min_t(unsigned int, ibdev->num_comp_vectors,
+			     min(opts->nr_io_queues, num_online_cpus()));
+	nr_io_queues += min_t(unsigned int, ibdev->num_comp_vectors,
+			      min(opts->nr_write_queues, num_online_cpus()));
+	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
+
+	return nr_io_queues;
+}
+
+static void nvme_rdma_set_io_queues(struct nvme_ctrl *nctrl,
+		unsigned int nr_io_queues)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct ib_device *ibdev = ctrl->device->dev;
-	unsigned int nr_io_queues, nr_default_queues;
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_default_queues;
 	unsigned int nr_read_queues, nr_poll_queues;
-	int i, ret;
 
 	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
 				min(opts->nr_io_queues, num_online_cpus()));
 	nr_default_queues =  min_t(unsigned int, ibdev->num_comp_vectors,
 				min(opts->nr_write_queues, num_online_cpus()));
 	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
-	nr_io_queues = nr_read_queues + nr_default_queues + nr_poll_queues;
-
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->ctrl.device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
-
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
 
 	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
 		/*
@@ -781,20 +836,6 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 		ctrl->io_queues[HCTX_TYPE_POLL] =
 			min(nr_poll_queues, nr_io_queues);
 	}
-
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_free_queues;
-	}
-
-	return 0;
-
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->ctrl, i);
-
-	return ret;
 }
 
 static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
@@ -812,231 +853,6 @@ static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
 			cmd_size);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
-{
-	if (ctrl->async_event_sqe.data) {
-		cancel_work_sync(&ctrl->ctrl.async_event_work);
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-				sizeof(struct nvme_command), DMA_TO_DEVICE);
-		ctrl->async_event_sqe.data = NULL;
-	}
-	nvme_rdma_free_queue(&ctrl->ctrl, 0);
-}
-
-static int nvme_rdma_init_queue(struct nvme_ctrl *nctrl, int qid)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	bool pi_capable = false;
-	int error;
-
-	if (qid != 0)
-		/* only admin queue needs additional work. */
-		return 0;
-
-
-	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.numa_node = ibdev_to_node(ctrl->device->dev);
-
-	/* T10-PI support */
-	if (ctrl->device->dev->attrs.kernel_cap_flags &
-	    IBK_INTEGRITY_HANDOVER)
-		pi_capable = true;
-
-	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev,
-							pi_capable);
-
-	/*
-	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
-	 * It's safe, since any chage in the underlying RDMA device will issue
-	 * error recovery and queue re-creation.
-	 */
-	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
-	if (error)
-		return error;
-
-	ctrl->ctrl.max_segments = ctrl->max_fr_pages;
-	ctrl->ctrl.max_hw_sectors = ctrl->max_fr_pages << (ilog2(SZ_4K) - 9);
-	if (pi_capable)
-		ctrl->ctrl.max_integrity_segments = ctrl->max_fr_pages;
-	else
-		ctrl->ctrl.max_integrity_segments = 0;
-
-	return 0;
-}
-
-static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	if (qid != 0)
-		return;
-
-	if (ctrl->async_event_sqe.data) {
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-			sizeof(struct nvme_command), DMA_TO_DEVICE);
-		ctrl->async_event_sqe.data = NULL;
-	}
-}
-
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool new)
-{
-	int error;
-
-	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
-	if (error)
-		return error;
-
-	error = nvme_rdma_init_queue(&ctrl->ctrl, 0);
-	if (error)
-		goto out_free_queue;
-
-	if (new) {
-		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
-				&ctrl->admin_tag_set, &nvme_rdma_admin_mq_ops,
-				sizeof(struct nvme_rdma_request) +
-				NVME_RDMA_DATA_SGL_SIZE);
-		if (error)
-			goto out_deinit_admin_queue;
-
-	}
-
-	error = nvme_rdma_start_queue(&ctrl->ctrl, 0);
-	if (error)
-		goto out_remove_admin_tag_set;
-
-	error = nvme_enable_ctrl(&ctrl->ctrl);
-	if (error)
-		goto out_stop_queue;
-
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-
-	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
-	if (error)
-		goto out_quiesce_queue;
-
-	return 0;
-
-out_quiesce_queue:
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-out_stop_queue:
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-out_remove_admin_tag_set:
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-out_deinit_admin_queue:
-	nvme_rdma_deinit_queue(&ctrl->ctrl, 0);
-out_free_queue:
-	nvme_rdma_free_queue(&ctrl->ctrl, 0);
-	return error;
-}
-
-static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
-{
-	int ret, nr_queues;
-
-	ret = nvme_rdma_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
-		if (ret)
-			goto out_free_io_queues;
-	}
-
-	/*
-	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
-	 * queue number might have changed.
-	 */
-	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
-	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
-	if (ret)
-		goto out_cleanup_tagset;
-
-	if (!new) {
-		nvme_unquiesce_io_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
-		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
-			ctrl->ctrl.queue_count - 1);
-		nvme_unfreeze(&ctrl->ctrl);
-	}
-
-	/*
-	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
-	 */
-	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
-					ctrl->tag_set.nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
-
-	return 0;
-
-out_wait_freeze_timed_out:
-	nvme_quiesce_io_queues(&ctrl->ctrl);
-	nvme_sync_io_queues(&ctrl->ctrl);
-	nvme_rdma_stop_io_queues(ctrl);
-out_cleanup_tagset:
-	nvme_cancel_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-out_free_io_queues:
-	nvme_rdma_free_io_queues(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
-{
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (remove) {
-		nvme_unquiesce_admin_queue(&ctrl->ctrl);
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	}
-	nvme_rdma_destroy_admin_queue(ctrl);
-}
-
-static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
-{
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
-		nvme_quiesce_io_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
-		if (remove) {
-			nvme_unquiesce_io_queues(&ctrl->ctrl);
-			nvme_remove_io_tag_set(&ctrl->ctrl);
-		}
-		nvme_rdma_free_io_queues(ctrl);
-	}
-}
-
-static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	flush_work(&ctrl->ctrl.err_work);
-	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
-}
-
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1054,169 +870,13 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
-		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
-			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
-	} else {
-		nvme_delete_ctrl(&ctrl->ctrl);
-	}
-}
-
-static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
-{
-	int ret;
-	bool changed;
-
-	ret = nvme_rdma_configure_admin_queue(ctrl, new);
-	if (ret)
-		return ret;
-
-	if (ctrl->ctrl.icdoff) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (!(ctrl->ctrl.sgls & (1 << 2))) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device,
-			"Mandatory keyed sgls are not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
-	}
-
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
-		dev_warn(ctrl->ctrl.device,
-			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
-	}
-
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-		dev_warn(ctrl->ctrl.device,
-			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
-		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
-	}
-
-	if (ctrl->ctrl.sgls & (1 << 20))
-		ctrl->use_inline_data = true;
-
-	if (ctrl->ctrl.queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, new);
-		if (ret)
-			goto destroy_admin;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	if (!changed) {
-		/*
-		 * state change failure is ok if we started ctrl delete,
-		 * unless we're during creation of a new controller to
-		 * avoid races with teardown flow.
-		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		WARN_ON_ONCE(new);
-		ret = -EINVAL;
-		goto destroy_io;
-	}
-
-	nvme_start_ctrl(&ctrl->ctrl);
-	return 0;
-
-destroy_io:
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_quiesce_io_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
-		if (new)
-			nvme_remove_io_tag_set(&ctrl->ctrl);
-		nvme_rdma_free_io_queues(ctrl);
-	}
-destroy_admin:
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
-			struct nvme_ctrl, connect_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	++ctrl->ctrl.nr_reconnects;
-
-	if (nvme_rdma_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
-			ctrl->ctrl.nr_reconnects);
-
-	ctrl->ctrl.nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery_work(struct work_struct *work)
+static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *nctrl = container_of(work,
-			struct nvme_ctrl, err_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	flush_work(&ctrl->ctrl.async_event_work);
-	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_unquiesce_io_queues(&ctrl->ctrl);
-	nvme_rdma_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_auth_stop(&ctrl->ctrl);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
+	return nvme_alloc_admin_tag_set(ctrl, &to_rdma_ctrl(ctrl)->admin_tag_set,
+					&nvme_rdma_admin_mq_ops,
+					sizeof(struct nvme_rdma_request) +
+					   NVME_RDMA_DATA_SGL_SIZE);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -1240,7 +900,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1759,7 +1419,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad command_id %#x on QP %#x\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1773,7 +1433,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Bogus remote invalidation for rkey %#x\n",
 				req->mr ? req->mr->rkey : 0);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 	} else if (req->mr) {
 		int ret;
@@ -1783,7 +1443,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, ret);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 		/* the local invalidation completion will end the request */
 		return;
@@ -1810,7 +1470,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(wc->byte_len < len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected nvme completion length(%d)\n", wc->byte_len);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 
@@ -1980,7 +1640,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1988,7 +1648,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -2006,7 +1666,7 @@ static void nvme_rdma_complete_timed_out(struct request *rq)
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_rdma_queue *queue = req->queue;
 
-	nvme_rdma_stop_queue(ctrl, nvme_rdma_queue_id(queue));
+	nvme_rdma_stop_io_queue(ctrl, nvme_rdma_queue_id(queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
@@ -2041,7 +1701,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2242,41 +1902,9 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
-{
-	nvme_rdma_teardown_io_queues(ctrl, shutdown);
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
-	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
-}
-
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_rdma_shutdown_ctrl(to_rdma_ctrl(ctrl), true);
-}
-
-static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl =
-		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
-
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure should never happen */
-		WARN_ON_ONCE(1);
-		return;
-	}
-
-	if (nvme_rdma_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvmf_teardown_ctrl(ctrl, true);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
@@ -2290,7 +1918,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.stop_ctrl		= nvme_rdma_stop_ctrl,
+	.stop_ctrl		= nvmf_stop_ctrl,
 };
 
 /*
@@ -2322,6 +1950,21 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static struct nvme_fabrics_ops nvme_rdma_fabrics_ops = {
+	.alloc_admin_queue	= nvme_rdma_alloc_admin_queue,
+	.free_admin_queue	= nvme_rdma_free_admin_queue,
+	.start_admin_queue	= nvme_rdma_start_admin_queue,
+	.stop_admin_queue	= nvme_rdma_stop_admin_queue,
+	.alloc_io_queue		= nvme_rdma_alloc_io_queue,
+	.free_io_queue		= nvme_rdma_free_io_queue,
+	.start_io_queue		= nvme_rdma_start_io_queue,
+	.stop_io_queue		= nvme_rdma_stop_io_queue,
+	.alloc_admin_tag_set	= nvme_rdma_alloc_admin_tag_set,
+	.alloc_tag_set		= nvme_rdma_alloc_tag_set,
+	.nr_io_queues		= nvme_rdma_nr_io_queues,
+	.set_io_queues		= nvme_rdma_set_io_queues,
+};
+
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2333,6 +1976,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_rdma_fabrics_ops;
 	INIT_LIST_HEAD(&ctrl->list);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
@@ -2369,10 +2013,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
-
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvmf_reset_ctrl_work);
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
@@ -2392,7 +2035,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
 
-	ret = nvme_rdma_setup_ctrl(ctrl, true);
+	ret = nvmf_setup_ctrl(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
-- 
2.40.0

