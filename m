Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C066F6812
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjEDJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjEDJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D849448A
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 04CCA209A9;
        Thu,  4 May 2023 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FerwgbpotSBgm/052+82shHYk+aggnxdQyii9bK83Gk=;
        b=CrPIlzqI0JwtYTzc0Kz2O+wUUHm31AsHdIS0efgmOkmGE5tuwa4SttPz/hg+uwMdrBpuOJ
        L1YkWXADwCQvAKTbxYCtCyAJf/VoMGPga1uJqeOviE/mshs30MRMB839ZZ7U7vTFT2r9II
        r3ZVcwkiLAkg+g5yBhmRpiFEwLBjAwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FerwgbpotSBgm/052+82shHYk+aggnxdQyii9bK83Gk=;
        b=Ofb0ixFjSghTjuGMOD2zvJj5ISEa1j2JhbRVo5tozg8WoiTZH7ZZ1UviLv6J8J/RhJ3r2S
        gzAvc1jojTCCyjDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBF2713444;
        Thu,  4 May 2023 09:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eieuOR93U2TYTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:03 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 1/9] nvme-rdma: stream line queue functions arguments
Date:   Thu,  4 May 2023 11:12:51 +0200
Message-Id: <20230504091259.29100-2-dwagner@suse.de>
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

In preparation to move common code from the fabrics driver to fabrics.c,
we stream line the low level functions. This allows any common code just
to pass in nvme subsystem global types, such as 'struct nvme_ctrl'
instead of the driver specialized types 'struct nvme_rdma_ctrl'.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 62 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..92e5d0ccf3a9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -132,6 +132,11 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
+static inline int nvme_rdma_queue_id(struct nvme_rdma_queue *queue)
+{
+	return queue - queue->ctrl->queues;
+}
+
 static LIST_HEAD(device_list);
 static DEFINE_MUTEX(device_list_mutex);
 
@@ -566,13 +571,19 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_ctrl *nctrl, int idx)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue;
 	struct sockaddr *src_addr = NULL;
+	size_t queue_size;
 	int ret;
 
+	if (idx == 0)
+		queue_size = NVME_AQ_DEPTH;
+	else
+		queue_size = ctrl->ctrl.sqsize + 1;
+
 	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
 	queue->ctrl = ctrl;
@@ -636,16 +647,22 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 	ib_drain_qp(queue->qp);
 }
 
-static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_stop_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
 	mutex_unlock(&queue->queue_lock);
 }
 
-static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
+
 	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
@@ -659,7 +676,7 @@ static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->ctrl, i);
 }
 
 static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -667,18 +684,19 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->ctrl, i);
 }
 
-static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[idx];
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+		ret = nvmf_connect_io_queue(nctrl, idx);
 	else
-		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
+		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
 		set_bit(NVME_RDMA_Q_LIVE, &queue->flags);
@@ -697,7 +715,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
 	int i, ret = 0;
 
 	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
+		ret = nvme_rdma_start_queue(&ctrl->ctrl, i);
 		if (ret)
 			goto out_stop_queues;
 	}
@@ -706,7 +724,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
 
 out_stop_queues:
 	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->ctrl, i);
 	return ret;
 }
 
@@ -768,8 +786,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	}
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
+		ret = nvme_rdma_alloc_queue(&ctrl->ctrl, i);
 		if (ret)
 			goto out_free_queues;
 	}
@@ -778,7 +795,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->ctrl, i);
 
 	return ret;
 }
@@ -806,7 +823,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 				sizeof(struct nvme_command), DMA_TO_DEVICE);
 		ctrl->async_event_sqe.data = NULL;
 	}
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -815,7 +832,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = nvme_rdma_alloc_queue(&ctrl->ctrl, 0);
 	if (error)
 		return error;
 
@@ -850,7 +867,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	}
 
-	error = nvme_rdma_start_queue(ctrl, 0);
+	error = nvme_rdma_start_queue(&ctrl->ctrl, 0);
 	if (error)
 		goto out_remove_admin_tag_set;
 
@@ -877,7 +894,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 out_remove_admin_tag_set:
 	if (new)
@@ -889,7 +906,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		ctrl->async_event_sqe.data = NULL;
 	}
 out_free_queue:
-	nvme_rdma_free_queue(&ctrl->queues[0]);
+	nvme_rdma_free_queue(&ctrl->ctrl, 0);
 	return error;
 }
 
@@ -962,7 +979,7 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (remove) {
 		nvme_unquiesce_admin_queue(&ctrl->ctrl);
@@ -1113,7 +1130,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (new)
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
@@ -1960,9 +1977,10 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 static void nvme_rdma_complete_timed_out(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_rdma_queue *queue = req->queue;
 
-	nvme_rdma_stop_queue(queue);
+	nvme_rdma_stop_queue(ctrl, nvme_rdma_queue_id(queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
-- 
2.40.0

