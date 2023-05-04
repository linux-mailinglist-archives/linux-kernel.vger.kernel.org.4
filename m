Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49A76F6817
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjEDJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjEDJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9944A1
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D39D6209AE;
        Thu,  4 May 2023 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ne5S41rksW/94j/aPAVYR86xIk3eBjYReoVu8x8zS6Y=;
        b=QB07Bz7K4iEVfOY+6W98tVaKgnXTKUXPf0+OVvvGWRcKlv98G/thxH8oJ1OP5Dw/s/hV+m
        dZxxnEK6YP2o+1qTTLRmh4MN29oFBfV4S0t1TdYmW5FR7lYxR3gcGX7NSk/+lBm37PmuQO
        L/7xnPkt3/+vKKv2sCAUq5uYPQBmuVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ne5S41rksW/94j/aPAVYR86xIk3eBjYReoVu8x8zS6Y=;
        b=BxUFEGgHb6iGYwXkg7SiwFxOiEkvbImXjlJ1MjD0g4KpuEWmAbGpDH3ceXy/LNZSnrGcsP
        zHKS1Hyz+9UI4xBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2EDE13444;
        Thu,  4 May 2023 09:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hm2WLyJ3U2TmTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 6/9] nvme-tcp: replace state machine with generic one
Date:   Thu,  4 May 2023 11:12:56 +0200
Message-Id: <20230504091259.29100-7-dwagner@suse.de>
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
 drivers/nvme/host/tcp.c | 698 ++++++++++------------------------------
 1 file changed, 175 insertions(+), 523 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 74ccc84d244a..32c4346b7322 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -519,15 +519,6 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->ddgst_remaining = 0;
 }
 
-static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
-}
-
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
@@ -539,7 +530,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
 			cqe->command_id, nvme_tcp_queue_id(queue));
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EINVAL;
 	}
 
@@ -581,7 +572,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x SUCCESS set but not last PDU\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return -EPROTO;
 	}
 
@@ -895,7 +886,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			dev_err(queue->ctrl->ctrl.device,
 				"receive failed:  %d\n", result);
 			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 			return result;
 		}
 	}
@@ -945,7 +936,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 	case TCP_LAST_ACK:
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	default:
 		dev_info(queue->ctrl->ctrl.device,
@@ -1299,34 +1290,6 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	return 0;
 }
 
-static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
-{
-	struct page *page;
-	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
-	unsigned int noreclaim_flag;
-
-	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-		return;
-
-	if (queue->hdr_digest || queue->data_digest)
-		nvme_tcp_free_crypto(queue);
-
-	if (queue->pf_cache.va) {
-		page = virt_to_head_page(queue->pf_cache.va);
-		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
-		queue->pf_cache.va = NULL;
-	}
-
-	noreclaim_flag = memalloc_noreclaim_save();
-	sock_release(queue->sock);
-	memalloc_noreclaim_restore(noreclaim_flag);
-
-	kfree(queue->pdu);
-	mutex_destroy(&queue->send_mutex);
-	mutex_destroy(&queue->queue_lock);
-}
-
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 {
 	struct nvme_tcp_icreq_pdu *icreq;
@@ -1488,10 +1451,9 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 }
 
-static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
+static int __nvme_tcp_alloc_queue(struct nvme_tcp_ctrl *ctrl,
+				 struct nvme_tcp_queue *queue)
 {
-	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret, rcv_pdu_size;
 
 	mutex_init(&queue->queue_lock);
@@ -1501,16 +1463,10 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
 
-	if (qid > 0)
-		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
-	else
-		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
-						NVME_TCP_ADMIN_CCSZ;
-
 	ret = sock_create(ctrl->addr.ss_family, SOCK_STREAM,
 			IPPROTO_TCP, &queue->sock);
 	if (ret) {
-		dev_err(nctrl->device,
+		dev_err(ctrl->ctrl.device,
 			"failed to create socket: %d\n", ret);
 		goto err_destroy_mutex;
 	}
@@ -1534,8 +1490,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		sock_set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+	if (ctrl->ctrl.opts->tos >= 0)
+		ip_sock_set_tos(queue->sock->sk, ctrl->ctrl.opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -1550,38 +1506,39 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	queue->pdu_offset = 0;
 	sk_set_memalloc(queue->sock->sk);
 
-	if (nctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
+	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_TRADDR) {
 		ret = kernel_bind(queue->sock, (struct sockaddr *)&ctrl->src_addr,
 			sizeof(ctrl->src_addr));
 		if (ret) {
-			dev_err(nctrl->device,
+			dev_err(ctrl->ctrl.device,
 				"failed to bind queue %d socket %d\n",
-				qid, ret);
+				nvme_tcp_queue_id(queue), ret);
 			goto err_sock;
 		}
 	}
 
-	if (nctrl->opts->mask & NVMF_OPT_HOST_IFACE) {
-		char *iface = nctrl->opts->host_iface;
+	if (ctrl->ctrl.opts->mask & NVMF_OPT_HOST_IFACE) {
+		char *iface = ctrl->ctrl.opts->host_iface;
 		sockptr_t optval = KERNEL_SOCKPTR(iface);
 
 		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
 				      optval, strlen(iface));
 		if (ret) {
-			dev_err(nctrl->device,
+			dev_err(ctrl->ctrl.device,
 			  "failed to bind to interface %s queue %d err %d\n",
-			  iface, qid, ret);
+			  iface, nvme_tcp_queue_id(queue), ret);
 			goto err_sock;
 		}
 	}
 
-	queue->hdr_digest = nctrl->opts->hdr_digest;
-	queue->data_digest = nctrl->opts->data_digest;
+	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
+	queue->data_digest = ctrl->ctrl.opts->data_digest;
 	if (queue->hdr_digest || queue->data_digest) {
 		ret = nvme_tcp_alloc_crypto(queue);
 		if (ret) {
-			dev_err(nctrl->device,
-				"failed to allocate queue %d crypto\n", qid);
+			dev_err(ctrl->ctrl.device,
+				"failed to allocate queue %d crypto\n",
+				nvme_tcp_queue_id(queue));
 			goto err_sock;
 		}
 	}
@@ -1594,13 +1551,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 		goto err_crypto;
 	}
 
-	dev_dbg(nctrl->device, "connecting queue %d\n",
-			nvme_tcp_queue_id(queue));
+	dev_dbg(ctrl->ctrl.device, "connecting queue %d\n",
+		nvme_tcp_queue_id(queue));
 
 	ret = kernel_connect(queue->sock, (struct sockaddr *)&ctrl->addr,
-		sizeof(ctrl->addr), 0);
+			     sizeof(ctrl->addr), 0);
 	if (ret) {
-		dev_err(nctrl->device,
+		dev_err(ctrl->ctrl.device,
 			"failed to connect socket: %d\n", ret);
 		goto err_rcv_pdu;
 	}
@@ -1644,142 +1601,182 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
 	return ret;
 }
 
-static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
+static void __nvme_tcp_free_queue(struct nvme_tcp_ctrl *ctrl,
+				  struct nvme_tcp_queue *queue)
 {
-	struct socket *sock = queue->sock;
+	struct page *page;
+	unsigned int noreclaim_flag;
 
-	write_lock_bh(&sock->sk->sk_callback_lock);
-	sock->sk->sk_user_data  = NULL;
-	sock->sk->sk_data_ready = queue->data_ready;
-	sock->sk->sk_state_change = queue->state_change;
-	sock->sk->sk_write_space  = queue->write_space;
-	write_unlock_bh(&sock->sk->sk_callback_lock);
+	if (!test_and_clear_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		return;
+
+	if (queue->hdr_digest || queue->data_digest)
+		nvme_tcp_free_crypto(queue);
+
+	if (queue->pf_cache.va) {
+		page = virt_to_head_page(queue->pf_cache.va);
+		__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
+		queue->pf_cache.va = NULL;
+	}
+
+	noreclaim_flag = memalloc_noreclaim_save();
+	sock_release(queue->sock);
+	memalloc_noreclaim_restore(noreclaim_flag);
+
+	kfree(queue->pdu);
+	mutex_destroy(&queue->send_mutex);
+	mutex_destroy(&queue->queue_lock);
 }
 
-static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
+
+static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *nctrl)
 {
-	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-	nvme_tcp_restore_sock_calls(queue);
-	cancel_work_sync(&queue->io_work);
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[0];
+	int err;
+
+	queue->cmnd_capsule_len = sizeof(struct nvme_command) +
+						NVME_TCP_ADMIN_CCSZ;
+
+	err = __nvme_tcp_alloc_queue(ctrl, queue);
+	if (err)
+		return err;
+
+	err = nvme_tcp_alloc_async_req(ctrl);
+	if (err)
+		__nvme_tcp_free_queue(ctrl, queue);
+
+	return err;
 }
 
-static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
+static int nvme_tcp_alloc_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
-	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
-		return;
+	queue->cmnd_capsule_len = nctrl->ioccsz * 16;
 
-	mutex_lock(&queue->queue_lock);
-	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		__nvme_tcp_stop_queue(queue);
-	mutex_unlock(&queue->queue_lock);
+	return __nvme_tcp_alloc_queue(ctrl, queue);
 }
 
-static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
+static void nvme_tcp_free_admin_queue(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
-	int ret;
-
-	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx);
-	else
-		ret = nvmf_connect_admin_queue(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[0];
 
-	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
-	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &ctrl->queues[idx].flags))
-			__nvme_tcp_stop_queue(&ctrl->queues[idx]);
-		dev_err(nctrl->device,
-			"failed to connect queue: %d ret=%d\n", idx, ret);
+	if (ctrl->async_req.pdu) {
+		cancel_work_sync(&nctrl->async_event_work);
+		nvme_tcp_free_async_req(ctrl);
+		ctrl->async_req.pdu = NULL;
 	}
-	return ret;
+	__nvme_tcp_free_queue(ctrl, queue);
 }
 
-static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
+static void nvme_tcp_free_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
-		cancel_work_sync(&ctrl->async_event_work);
-		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
-		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
-	}
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
-	nvme_tcp_free_queue(ctrl, 0);
+	__nvme_tcp_free_queue(ctrl, queue);
 }
 
-static void nvme_tcp_free_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_restore_sock_calls(struct nvme_tcp_queue *queue)
 {
-	int i;
+	struct socket *sock = queue->sock;
 
-	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_free_queue(ctrl, i);
+	write_lock_bh(&sock->sk->sk_callback_lock);
+	sock->sk->sk_user_data  = NULL;
+	sock->sk->sk_data_ready = queue->data_ready;
+	sock->sk->sk_state_change = queue->state_change;
+	sock->sk->sk_write_space  = queue->write_space;
+	write_unlock_bh(&sock->sk->sk_callback_lock);
 }
 
-static void nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl)
+static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
 {
-	int i;
-
-	for (i = 1; i < ctrl->queue_count; i++)
-		nvme_tcp_stop_queue(ctrl, i);
+	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	nvme_tcp_restore_sock_calls(queue);
+	cancel_work_sync(&queue->io_work);
 }
 
-static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl,
-				    int first, int last)
+static int nvme_tcp_start_admin_queue(struct nvme_ctrl *nctrl)
 {
-	int i, ret;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[0];
+	int ret;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_tcp_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
+	ret = nvmf_connect_admin_queue(nctrl);
+	if (!ret) {
+		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	} else {
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+			__nvme_tcp_stop_queue(queue);
+		dev_err(nctrl->device,
+			"failed to connect queue: %d ret=%d\n", 0, ret);
 	}
-
-	return 0;
-
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_tcp_stop_queue(ctrl, i);
 	return ret;
 }
 
-static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
+static int nvme_tcp_start_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	int ret;
 
-	ret = nvme_tcp_alloc_queue(ctrl, 0);
-	if (ret)
-		return ret;
+	ret = nvmf_connect_io_queue(nctrl, qid);
+	if (!ret) {
+		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
+	} else {
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+			__nvme_tcp_stop_queue(queue);
+		dev_err(nctrl->device,
+			"failed to connect queue: %d ret=%d\n", qid, ret);
+	}
+	return ret;
+}
 
-	ret = nvme_tcp_alloc_async_req(to_tcp_ctrl(ctrl));
-	if (ret)
-		goto out_free_queue;
+static void nvme_tcp_stop_admin_queue(struct nvme_ctrl *nctrl)
+{
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[0];
 
-	return 0;
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		return;
 
-out_free_queue:
-	nvme_tcp_free_queue(ctrl, 0);
-	return ret;
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
 }
 
-static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_stop_io_queue(struct nvme_ctrl *nctrl, int qid)
 {
-	int i, ret;
+	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 
-	for (i = 1; i < ctrl->queue_count; i++) {
-		ret = nvme_tcp_alloc_queue(ctrl, i);
-		if (ret)
-			goto out_free_queues;
-	}
+	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+		return;
 
-	return 0;
+	mutex_lock(&queue->queue_lock);
+	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		__nvme_tcp_stop_queue(queue);
+	mutex_unlock(&queue->queue_lock);
+}
 
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_tcp_free_queue(ctrl, i);
+static int nvme_tcp_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
+{
+	return nvme_alloc_admin_tag_set(ctrl, &to_tcp_ctrl(ctrl)->admin_tag_set,
+					&nvme_tcp_admin_mq_ops,
+					sizeof(struct nvme_tcp_request));
+}
+
+static int nvme_tcp_alloc_tag_set(struct nvme_ctrl *ctrl)
+{
+	return nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
+				     &nvme_tcp_mq_ops,
+				     ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
+				     sizeof(struct nvme_tcp_request));
 
-	return ret;
 }
 
 static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
@@ -1828,370 +1825,9 @@ static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
 	}
 }
 
-static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
-{
-	unsigned int nr_io_queues;
-	int ret;
-
-	nr_io_queues = nvme_tcp_nr_io_queues(ctrl);
-	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
-
-	ctrl->queue_count = nr_io_queues + 1;
-	dev_info(ctrl->device,
-		"creating %d I/O queues.\n", nr_io_queues);
-
-	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
-
-	return __nvme_tcp_alloc_io_queues(ctrl);
-}
-
-static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_io_queues(ctrl);
-	if (remove)
-		nvme_remove_io_tag_set(ctrl);
-	nvme_tcp_free_io_queues(ctrl);
-}
-
-static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
-{
-	int ret, nr_queues;
-
-	ret = nvme_tcp_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
-				&nvme_tcp_mq_ops,
-				ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2,
-				sizeof(struct nvme_tcp_request));
-		if (ret)
-			goto out_free_io_queues;
-	}
-
-	/*
-	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
-	 * queue number might have changed.
-	 */
-	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
-	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
-		nvme_unquiesce_io_queues(ctrl);
-		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
-		blk_mq_update_nr_hw_queues(ctrl->tagset,
-			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
-	}
-
-	/*
-	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
-	 */
-	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
-				       ctrl->tagset->nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
-
-	return 0;
-
-out_wait_freeze_timed_out:
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-out_cleanup_connect_q:
-	nvme_cancel_tagset(ctrl);
-	if (new)
-		nvme_remove_io_tag_set(ctrl);
-out_free_io_queues:
-	nvme_tcp_free_io_queues(ctrl);
-	return ret;
-}
-
-static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
-{
-	nvme_tcp_stop_queue(ctrl, 0);
-	if (remove)
-		nvme_remove_admin_tag_set(ctrl);
-	nvme_tcp_free_admin_queue(ctrl);
-}
-
-static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
-{
-	int error;
-
-	error = nvme_tcp_alloc_admin_queue(ctrl);
-	if (error)
-		return error;
-
-	if (new) {
-		error = nvme_alloc_admin_tag_set(ctrl,
-				&to_tcp_ctrl(ctrl)->admin_tag_set,
-				&nvme_tcp_admin_mq_ops,
-				sizeof(struct nvme_tcp_request));
-		if (error)
-			goto out_free_queue;
-	}
-
-	error = nvme_tcp_start_queue(ctrl, 0);
-	if (error)
-		goto out_cleanup_tagset;
-
-	error = nvme_enable_ctrl(ctrl);
-	if (error)
-		goto out_stop_queue;
-
-	nvme_unquiesce_admin_queue(ctrl);
-
-	error = nvme_init_ctrl_finish(ctrl, false);
-	if (error)
-		goto out_quiesce_queue;
-
-	return 0;
-
-out_quiesce_queue:
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-out_stop_queue:
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-out_cleanup_tagset:
-	if (new)
-		nvme_remove_admin_tag_set(ctrl);
-out_free_queue:
-	nvme_tcp_free_admin_queue(ctrl);
-	return error;
-}
-
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_admin_queue(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, remove);
-}
-
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
-		bool remove)
-{
-	if (ctrl->queue_count <= 1)
-		return;
-	nvme_quiesce_admin_queue(ctrl);
-	nvme_start_freeze(ctrl);
-	nvme_quiesce_io_queues(ctrl);
-	nvme_sync_io_queues(ctrl);
-	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
-	if (remove)
-		nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_destroy_io_queues(ctrl, remove);
-}
-
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
-			ctrl->state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(ctrl)) {
-		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
-			ctrl->opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->connect_work,
-				ctrl->opts->reconnect_delay * HZ);
-	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
-		nvme_delete_ctrl(ctrl);
-	}
-}
-
-static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
-{
-	struct nvmf_ctrl_options *opts = ctrl->opts;
-	int ret;
-
-	ret = nvme_tcp_configure_admin_queue(ctrl, new);
-	if (ret)
-		return ret;
-
-	if (ctrl->icdoff) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->device, "icdoff is not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (!nvme_ctrl_sgl_supported(ctrl)) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (opts->queue_size > ctrl->sqsize + 1)
-		dev_warn(ctrl->device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			opts->queue_size, ctrl->sqsize + 1);
-
-	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
-		dev_warn(ctrl->device,
-			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->sqsize + 1, ctrl->maxcmd);
-		ctrl->sqsize = ctrl->maxcmd - 1;
-	}
-
-	if (ctrl->queue_count > 1) {
-		ret = nvme_tcp_configure_io_queues(ctrl, new);
-		if (ret)
-			goto destroy_admin;
-	}
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
-		/*
-		 * state change failure is ok if we started ctrl delete,
-		 * unless we're during creation of a new controller to
-		 * avoid races with teardown flow.
-		 */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		WARN_ON_ONCE(new);
-		ret = -EINVAL;
-		goto destroy_io;
-	}
-
-	nvme_start_ctrl(ctrl);
-	return 0;
-
-destroy_io:
-	if (ctrl->queue_count > 1) {
-		nvme_quiesce_io_queues(ctrl);
-		nvme_sync_io_queues(ctrl);
-		nvme_tcp_stop_io_queues(ctrl);
-		nvme_cancel_tagset(ctrl);
-		nvme_tcp_destroy_io_queues(ctrl, new);
-	}
-destroy_admin:
-	nvme_quiesce_admin_queue(ctrl);
-	blk_sync_queue(ctrl->admin_q);
-	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
-	nvme_tcp_destroy_admin_queue(ctrl, new);
-	return ret;
-}
-
-static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
-			struct nvme_ctrl, connect_work);
-
-	++ctrl->nr_reconnects;
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
-			ctrl->nr_reconnects);
-
-	ctrl->nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
-			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl = container_of(work,
-				struct nvme_ctrl, err_work);
-
-	nvme_stop_keep_alive(ctrl);
-	flush_work(&ctrl->async_event_work);
-	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(ctrl);
-	nvme_auth_stop(ctrl);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
-{
-	nvme_tcp_teardown_io_queues(ctrl, shutdown);
-	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
-}
-
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_tcp_teardown_ctrl(ctrl, true);
-}
-
-static void nvme_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *ctrl =
-		container_of(work, struct nvme_ctrl, reset_work);
-
-	nvme_stop_ctrl(ctrl);
-	nvme_tcp_teardown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
-			     ctrl->state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	if (nvme_tcp_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
-}
-
-static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-{
-	flush_work(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->connect_work);
+	nvmf_teardown_ctrl(ctrl, true);
 }
 
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
@@ -2275,7 +1911,7 @@ static void nvme_tcp_complete_timed_out(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 
-	nvme_tcp_stop_queue(ctrl, nvme_tcp_queue_id(req->queue));
+	nvme_tcp_stop_io_queue(ctrl, nvme_tcp_queue_id(req->queue));
 	nvmf_complete_timed_out_request(rq);
 }
 
@@ -2314,7 +1950,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_tcp_error_recovery(ctrl);
+	nvmf_error_recovery(ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2540,7 +2176,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvme_tcp_get_address,
-	.stop_ctrl		= nvme_tcp_stop_ctrl,
+	.stop_ctrl		= nvmf_stop_ctrl,
 };
 
 static bool
@@ -2560,6 +2196,21 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static struct nvme_fabrics_ops nvme_tcp_fabrics_ops = {
+	.alloc_admin_queue	= nvme_tcp_alloc_admin_queue,
+	.free_admin_queue	= nvme_tcp_free_admin_queue,
+	.start_admin_queue	= nvme_tcp_start_admin_queue,
+	.stop_admin_queue	= nvme_tcp_stop_admin_queue,
+	.alloc_io_queue		= nvme_tcp_alloc_io_queue,
+	.free_io_queue		= nvme_tcp_free_io_queue,
+	.start_io_queue		= nvme_tcp_start_io_queue,
+	.stop_io_queue		= nvme_tcp_stop_io_queue,
+	.alloc_admin_tag_set	= nvme_tcp_alloc_admin_tag_set,
+	.alloc_tag_set		= nvme_tcp_alloc_tag_set,
+	.nr_io_queues		= nvme_tcp_nr_io_queues,
+	.set_io_queues		= nvme_tcp_set_io_queues,
+};
+
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2572,15 +2223,16 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
+	ctrl->ctrl.fabrics_ops = &nvme_tcp_fabrics_ops;
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_tcp_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvmf_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
@@ -2641,7 +2293,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_uninit_ctrl;
 	}
 
-	ret = nvme_tcp_setup_ctrl(&ctrl->ctrl, true);
+	ret = nvmf_setup_ctrl(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
-- 
2.40.0

