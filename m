Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508F6F6816
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjEDJNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjEDJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:13:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD110E7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:13:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4865E209AD;
        Thu,  4 May 2023 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683191586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKAGQVKaUUQJ0wwOeUiQWcm9V9pH23Rwd+Th8ukWdzU=;
        b=uZ7bOMI9miJeH5qI7b8UnbZiQtsJRiarmxjqlTk8c1zns69jtqB/bv3YPHuV5iirx2CoUY
        sPkM+Q6HUbKXOjwJCdgsePKr1vlWmSHja70KZTd5IR0xh6fya6s6V1ARydcTqarO4gO0gi
        r3umVQxI2RJhXaSHceoJAMk09U9O4zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683191586;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jKAGQVKaUUQJ0wwOeUiQWcm9V9pH23Rwd+Th8ukWdzU=;
        b=LH63OfEVGSOWMN6H8Zcd3tK7gqcA43wPFLUvAvrEzLgZDGTBUeq/E+AZPlAZcPyVbxxKLg
        urTl3ro1kQyBg+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AD6F13444;
        Thu,  4 May 2023 09:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y4dUDiJ3U2TkTwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 04 May 2023 09:13:06 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [RFC v3 5/9] nvme-fabrics: add fabric state machine
Date:   Thu,  4 May 2023 11:12:55 +0200
Message-Id: <20230504091259.29100-6-dwagner@suse.de>
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

The transports are sharing a lot of common code for the state machine.
Add a generic static machine based on tcp transport.

In this first step additional callbacks such as alloc_admin_tag_set()
are in the callback API. These will be remove later again. This is just
a for making the areas where more than moving code around is necessary
a bit easier to review.

This is approach just for discussion purpose and the proper series
wont have these intermediate steps. I suppose, the later steps in
this series would go in before the main state machine.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 426 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  25 +++
 drivers/nvme/host/nvme.h    |   3 +
 3 files changed, 454 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..3d2cde17338d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1134,6 +1134,432 @@ nvmf_create_ctrl(struct device *dev, const char *buf)
 	return ERR_PTR(ret);
 }
 
+static int nvmf_start_io_queues(struct nvme_ctrl *ctrl,
+				    int first, int last)
+{
+	int i, ret;
+
+	for (i = first; i < last; i++) {
+		ret = ctrl->fabrics_ops->start_io_queue(ctrl, i);
+		if (ret)
+			goto out_stop_queues;
+	}
+
+	return 0;
+
+out_stop_queues:
+	for (i--; i >= first; i--)
+		ctrl->fabrics_ops->stop_io_queue(ctrl, i);
+	return ret;
+}
+
+static void nvmf_stop_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->fabrics_ops->stop_io_queue(ctrl, i);
+}
+
+static int __nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, ret;
+
+	for (i = 1; i < ctrl->queue_count; i++) {
+		ret = ctrl->fabrics_ops->alloc_io_queue(ctrl, i);
+		if (ret)
+			goto out_free_queues;
+	}
+
+	return 0;
+
+out_free_queues:
+	for (i--; i >= 1; i--)
+		ctrl->fabrics_ops->free_io_queue(ctrl, i);
+
+	return ret;
+}
+
+static int nvmf_alloc_io_queues(struct nvme_ctrl *ctrl)
+{
+	unsigned int nr_io_queues;
+	int ret;
+
+	nr_io_queues = ctrl->fabrics_ops->nr_io_queues(ctrl);
+	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
+	if (ret)
+		return ret;
+
+	if (nr_io_queues == 0) {
+		dev_err(ctrl->device,
+			"unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
+
+	ctrl->queue_count = nr_io_queues + 1;
+	dev_info(ctrl->device,
+		"creating %d I/O queues.\n", nr_io_queues);
+
+	ctrl->fabrics_ops->set_io_queues(ctrl, nr_io_queues);
+
+	return __nvmf_alloc_io_queues(ctrl);
+}
+
+static void nvmf_free_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 1; i < ctrl->queue_count; i++)
+		ctrl->fabrics_ops->free_io_queue(ctrl, i);
+}
+
+static int nvmf_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
+{
+	int ret, nr_queues;
+
+	ret = nvmf_alloc_io_queues(ctrl);
+	if (ret)
+		return ret;
+
+	if (new) {
+		ret = ctrl->fabrics_ops->alloc_tag_set(ctrl);
+		if (ret)
+			goto out_free_io_queues;
+	}
+
+	/*
+	 * Only start IO queues for which we have allocated the tagset
+	 * and limitted it to the available queues. On reconnects, the
+	 * queue number might have changed.
+	 */
+	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
+	ret = nvmf_start_io_queues(ctrl, 1, nr_queues);
+	if (ret)
+		goto out_cleanup_connect_q;
+
+	if (!new) {
+		nvme_unquiesce_io_queues(ctrl);
+		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			ret = -ENODEV;
+			goto out_wait_freeze_timed_out;
+		}
+		blk_mq_update_nr_hw_queues(ctrl->tagset,
+			ctrl->queue_count - 1);
+		nvme_unfreeze(ctrl);
+	}
+
+	/*
+	 * If the number of queues has increased (reconnect case)
+	 * start all new queues now.
+	 */
+	ret = nvmf_start_io_queues(ctrl, nr_queues,
+				   ctrl->tagset->nr_hw_queues + 1);
+	if (ret)
+		goto out_wait_freeze_timed_out;
+
+	return 0;
+
+out_wait_freeze_timed_out:
+	nvme_quiesce_io_queues(ctrl);
+	nvme_sync_io_queues(ctrl);
+	nvmf_stop_io_queues(ctrl);
+out_cleanup_connect_q:
+	nvme_cancel_tagset(ctrl);
+	if (new)
+		nvme_remove_io_tag_set(ctrl);
+out_free_io_queues:
+	nvmf_free_io_queues(ctrl);
+	return ret;
+}
+
+static int nvmf_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
+{
+	int error;
+
+	error = ctrl->fabrics_ops->alloc_admin_queue(ctrl);
+	if (error)
+		return error;
+
+	if (new) {
+		error = ctrl->fabrics_ops->alloc_admin_tag_set(ctrl);
+		if (error)
+			goto out_free_admin_queue;
+
+	}
+
+	error = ctrl->fabrics_ops->start_admin_queue(ctrl);
+	if (error)
+		goto out_remove_admin_tag_set;
+
+	error = nvme_enable_ctrl(ctrl);
+	if (error)
+		goto out_stop_queue;
+
+	nvme_unquiesce_admin_queue(ctrl);
+
+	error = nvme_init_ctrl_finish(ctrl, false);
+	if (error)
+		goto out_quiesce_queue;
+
+	return 0;
+
+out_quiesce_queue:
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+out_stop_queue:
+	ctrl->fabrics_ops->stop_admin_queue(ctrl);
+	nvme_cancel_admin_tagset(ctrl);
+out_remove_admin_tag_set:
+	if (new)
+		nvme_remove_admin_tag_set(ctrl);
+out_free_admin_queue:
+	ctrl->fabrics_ops->free_admin_queue(ctrl);
+	return error;
+}
+
+static void nvmf_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	nvmf_stop_io_queues(ctrl);
+	if (remove)
+		nvme_remove_io_tag_set(ctrl);
+	nvmf_free_io_queues(ctrl);
+}
+
+static void nvmf_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	ctrl->fabrics_ops->stop_admin_queue(ctrl);
+	if (remove)
+		nvme_remove_admin_tag_set(ctrl);
+
+	ctrl->fabrics_ops->free_admin_queue(ctrl);
+}
+
+static void nvmf_teardown_admin_queue(struct nvme_ctrl *ctrl, bool remove)
+{
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+	ctrl->fabrics_ops->stop_admin_queue(ctrl);
+	nvme_cancel_admin_tagset(ctrl);
+	if (remove)
+		nvme_unquiesce_admin_queue(ctrl);
+	nvmf_destroy_admin_queue(ctrl, remove);
+}
+
+static void nvmf_teardown_io_queues(struct nvme_ctrl *ctrl, bool remove)
+{
+	if (ctrl->queue_count <= 1)
+		return;
+	nvme_quiesce_admin_queue(ctrl);
+	nvme_start_freeze(ctrl);
+	nvme_quiesce_io_queues(ctrl);
+	nvme_sync_io_queues(ctrl);
+	nvmf_stop_io_queues(ctrl);
+	nvme_cancel_tagset(ctrl);
+	if (remove)
+		nvme_unquiesce_io_queues(ctrl);
+	nvmf_destroy_io_queues(ctrl, remove);
+}
+
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	nvmf_teardown_io_queues(ctrl, shutdown);
+	nvme_quiesce_admin_queue(ctrl);
+	nvme_disable_ctrl(ctrl, shutdown);
+	nvmf_teardown_admin_queue(ctrl, shutdown);
+}
+EXPORT_SYMBOL_GPL(nvmf_teardown_ctrl);
+
+void nvmf_stop_ctrl(struct nvme_ctrl *ctrl)
+{
+	flush_work(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->connect_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_stop_ctrl);
+
+int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
+{
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int ret;
+
+	ret = nvmf_configure_admin_queue(ctrl, new);
+	if (ret)
+		return ret;
+
+	if (ctrl->icdoff) {
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->device, "icdoff is not supported!\n");
+		goto destroy_admin;
+	}
+
+	if (!nvme_ctrl_sgl_supported(ctrl)) {
+		ret = -EOPNOTSUPP;
+		dev_err(ctrl->device, "Mandatory sgls are not supported!\n");
+		goto destroy_admin;
+	}
+
+	if (opts->queue_size > ctrl->sqsize + 1)
+		dev_warn(ctrl->device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->sqsize + 1);
+
+	if (ctrl->sqsize + 1 > ctrl->maxcmd) {
+		dev_warn(ctrl->device,
+			"sqsize %u > ctrl maxcmd %u, clamping down\n",
+			ctrl->sqsize + 1, ctrl->maxcmd);
+		ctrl->sqsize = ctrl->maxcmd - 1;
+	}
+
+	if (ctrl->queue_count > 1) {
+		ret = nvmf_configure_io_queues(ctrl, new);
+		if (ret)
+			goto destroy_admin;
+	}
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE)) {
+		/*
+		 * state change failure is ok if we started ctrl delete,
+		 * unless we're during creation of a new controller to
+		 * avoid races with teardown flow.
+		 */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		WARN_ON_ONCE(new);
+		ret = -EINVAL;
+		goto destroy_io;
+	}
+
+	nvme_start_ctrl(ctrl);
+	return 0;
+
+destroy_io:
+	if (ctrl->queue_count > 1) {
+		nvme_quiesce_io_queues(ctrl);
+		nvme_sync_io_queues(ctrl);
+		nvmf_stop_io_queues(ctrl);
+		nvme_cancel_tagset(ctrl);
+		nvmf_destroy_io_queues(ctrl, new);
+	}
+destroy_admin:
+	nvme_quiesce_admin_queue(ctrl);
+	blk_sync_queue(ctrl->admin_q);
+	ctrl->fabrics_ops->stop_admin_queue(ctrl);
+	nvme_cancel_admin_tagset(ctrl);
+	nvmf_destroy_admin_queue(ctrl, new);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvmf_setup_ctrl);
+
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl)
+{
+	/* If we are resetting/deleting then do nothing */
+	if (ctrl->state != NVME_CTRL_CONNECTING) {
+		WARN_ON_ONCE(ctrl->state == NVME_CTRL_NEW ||
+			ctrl->state == NVME_CTRL_LIVE);
+		return;
+	}
+
+	if (nvmf_should_reconnect(ctrl)) {
+		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
+			ctrl->opts->reconnect_delay);
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
+				ctrl->opts->reconnect_delay * HZ);
+	} else {
+		dev_info(ctrl->device, "Removing controller...\n");
+		nvme_delete_ctrl(ctrl);
+	}
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
+
+void nvmf_error_recovery_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work,
+				struct nvme_ctrl, err_work);
+
+	nvme_stop_keep_alive(ctrl);
+	flush_work(&ctrl->async_event_work);
+	nvmf_teardown_io_queues(ctrl, false);
+	/* unquiesce to fail fast pending requests */
+	nvme_unquiesce_io_queues(ctrl);
+	nvmf_teardown_admin_queue(ctrl, false);
+	nvme_unquiesce_admin_queue(ctrl);
+	nvme_auth_stop(ctrl);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery_work);
+
+void nvmf_reset_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, reset_work);
+
+	nvme_stop_ctrl(ctrl);
+	nvmf_teardown_ctrl(ctrl, false);
+
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
+		/* state change failure is ok if we started ctrl delete */
+		WARN_ON_ONCE(ctrl->state != NVME_CTRL_DELETING &&
+			     ctrl->state != NVME_CTRL_DELETING_NOIO);
+		return;
+	}
+
+	if (nvmf_setup_ctrl(ctrl, false))
+		goto out_fail;
+
+	return;
+
+out_fail:
+	++ctrl->nr_reconnects;
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_reset_ctrl_work);
+
+void nvmf_reconnect_ctrl_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+			struct nvme_ctrl, connect_work);
+
+	++ctrl->nr_reconnects;
+
+	if (nvmf_setup_ctrl(ctrl, false))
+		goto requeue;
+
+	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
+			ctrl->nr_reconnects);
+
+	ctrl->nr_reconnects = 0;
+
+	return;
+
+requeue:
+	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
+			ctrl->nr_reconnects);
+	nvmf_reconnect_or_remove(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmf_reconnect_ctrl_work);
+
+void nvmf_error_recovery(struct nvme_ctrl *ctrl)
+{
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return;
+
+	dev_warn(ctrl->device, "starting error recovery\n");
+	queue_work(nvme_reset_wq, &ctrl->err_work);
+}
+EXPORT_SYMBOL_GPL(nvmf_error_recovery);
+
 static struct class *nvmf_class;
 static struct device *nvmf_device;
 static DEFINE_MUTEX(nvmf_dev_mutex);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..345d6de6bc86 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -172,6 +172,23 @@ struct nvmf_transport_ops {
 					struct nvmf_ctrl_options *opts);
 };
 
+struct nvme_fabrics_ops {
+	int	(*alloc_admin_queue)(struct nvme_ctrl *ctrl);
+	int	(*start_admin_queue)(struct nvme_ctrl *ctrl);
+	void	(*stop_admin_queue)(struct nvme_ctrl *ctrl);
+	void	(*free_admin_queue)(struct nvme_ctrl *ctrl);
+	int	(*alloc_io_queue)(struct nvme_ctrl *ctrl, int qid);
+	int	(*start_io_queue)(struct nvme_ctrl *ctrl, int qid);
+	void	(*stop_io_queue)(struct nvme_ctrl *ctrl, int qid);
+	void	(*free_io_queue)(struct nvme_ctrl *ctrl, int qid);
+
+	/* these should be replaced with a single one setup_transport() */
+	int	(*alloc_admin_tag_set)(struct nvme_ctrl *ctrl);
+	int	(*alloc_tag_set)(struct nvme_ctrl *ctrl);
+	unsigned int	(*nr_io_queues)(struct nvme_ctrl *ctrl);
+	void	(*set_io_queues)(struct nvme_ctrl *ctrl, unsigned int nr_io_queues);
+};
+
 static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
@@ -215,5 +232,13 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
 bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts);
+int nvmf_setup_ctrl(struct nvme_ctrl *ctrl, bool new);
+void nvmf_stop_ctrl(struct nvme_ctrl *ctrl);
+void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+void nvmf_reset_ctrl_work(struct work_struct *work);
+void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
+void nvmf_error_recovery_work(struct work_struct *work);
+void nvmf_reconnect_ctrl_work(struct work_struct *work);
+void nvmf_error_recovery(struct nvme_ctrl *ctrl);
 
 #endif /* _NVME_FABRICS_H */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5aa30b00dd17..fcea2678094c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -244,6 +244,8 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_STOPPED		= 3,
 };
 
+struct nvme_fabrics_ops;
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -251,6 +253,7 @@ struct nvme_ctrl {
 	spinlock_t lock;
 	struct mutex scan_lock;
 	const struct nvme_ctrl_ops *ops;
+	const struct nvme_fabrics_ops *fabrics_ops;
 	struct request_queue *admin_q;
 	struct request_queue *connect_q;
 	struct request_queue *fabrics_q;
-- 
2.40.0

