Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBAE6FFFF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239936AbjELFmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbjELFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:42:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221A2D4D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f4ad71b00eso17949975e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683870158; x=1686462158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWZphTLpEjRd9RsJJvtea8O3x7IiED46e3KmAJCTvP4=;
        b=U6sIqZKbiFuhS4YWIcDxyNDebefBbRwB/fJWkJq0hjc3y9yPuC5BhWeDNxwHJAgavh
         WMl/AmTenrtrYi58RcL3k1VonlyMfC/o0BPNmV78NefesSgKafv03lLQq+IpGV8oUR3K
         i2dJfwCuiMTGL8GMlKYQ6SMCpoS7uKP8ZbDIf6Uh7dnh/wKfJT2cHrPHF90SSxmCR2QW
         b0LcH9RErgoldLNr2N6Te5cLJAglebb0P98KMfD3sx2mOujDK+tpsEIl4Sgvd8/kLwi+
         Des9yMlKvidJln7g8J6tO24YtA2O/xQ8RwyOUxmZL44i53gZkJUYGjLRGFqvM7AeCEvX
         B2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870158; x=1686462158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWZphTLpEjRd9RsJJvtea8O3x7IiED46e3KmAJCTvP4=;
        b=YBrBFTJif7UyRhq3/uG0A3EEmTXIbmyHkj1yH/M4AmDzKCpGJJOwSbdECNjjopkHW+
         yQua5+PxD00gknob5sD0uPnzJZJqMvzroJW49kB+3Cw1xjtTqW12GLCgsUrvezfeEKS0
         74tHX6Jeszn5gAW3rgvnNonPuW4nf2u/zMs/S+od1/utO0crZyoqcSwIds7z0sPnEeT5
         NeCdHw+Y3WK1hHpY2WlMJ4MF6lK0tkqcFPAgFTASkHqMINex6jv8CWcqVklNJpc+C7on
         WnrkJybkIQop0FMnmsrahedylPVRJCAnnE2b5laH4M5VE2too/0vIi4rNnAdoT/XRRRP
         qxtg==
X-Gm-Message-State: AC+VfDzA35IWR/yoGYVCZ981ApQxEVOSxhGYxaLDQ1NrVsL4QcevkBZK
        BY0ibDVfH82Ji5NAIz4sxr5ARKndHLFuIaK2HZ4=
X-Google-Smtp-Source: ACHHUZ4WjymSm1ryUis1yLP/HiQoe2pM/WZqyJsoniBUOcQ4QhBhmcMxUGqNt/ol3Q2xOhyZdQIkoQ==
X-Received: by 2002:a5d:5651:0:b0:306:3153:d2fe with SMTP id j17-20020a5d5651000000b003063153d2femr14933072wrw.27.1683870157634;
        Thu, 11 May 2023 22:42:37 -0700 (PDT)
Received: from lmecxl1178.home (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id j18-20020adfff92000000b00307bc4e39e5sm6301253wrr.117.2023.05.11.22.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 22:42:36 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v7 3/4] tee: optee: support tracking system threads
Date:   Fri, 12 May 2023 07:42:21 +0200
Message-Id: <20230512054222.2088837-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512054222.2088837-1-etienne.carriere@linaro.org>
References: <20230512054222.2088837-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support in the OP-TEE driver to keep track of reserved system
threads. The optee_cq_*() functions are updated to handle this if
enabled. The SMC ABI part of the driver enables this tracking, but the
FF-A ABI part does not.

The call queue list optee_call_queue::waiters is replaced by 2 lists,
one for regular sessions and one system sessions. The struct also
stores count of TEE thread contexts provisioned/used/reserved to
track use of TEE resources. The logic ensures reserved TEE system
threads do not exhaust the total number of thread contexts available
in OP-TEE. For sake of simplicity, initialization of call queue
management is factorized into new helper function optee_cq_init().

Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v6:
- Moved out changes related to adding boolean system thread attribute
  into optee driver call queue and SMC/FF-A ABIs API functions. These
  changes were squashed into patch 1/4 of this patch v7 series.
- Comment about adding a specific commit for call queue refactoring
  was not addressed such a patch would only introduce function
  optee_cq_init()  with very little content in (mutex & list init).
- Added Co-developed-by tag for Jens contribution as he's not responsible
  for the changes I made in this patch v7.

No change since v5

Changes since v4:
- New change that supersedes implementation proposed in PATCH v4
  (tee: system invocation"). Thanks to Jens implementation we don't need
  the new OP-TEE services that my previous patch versions introduced to
  monitor system threads entry. Now, Linux optee SMC ABI driver gets TEE
  provisioned thread contexts count once and monitors thread entries in
  OP-TEE on that basis and the system thread capability of the related
  tee session. By the way, I dropped the WARN_ONCE() call I suggested
  on tee thread exhaustion as it does not provides useful information.
---
 drivers/tee/optee/call.c          | 126 ++++++++++++++++++++++++++++--
 drivers/tee/optee/ffa_abi.c       |   3 +-
 drivers/tee/optee/optee_private.h |  11 ++-
 drivers/tee/optee/smc_abi.c       |  16 +++-
 4 files changed, 143 insertions(+), 13 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 152ae9bb1785..c2d484201f79 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -39,9 +39,26 @@ struct optee_shm_arg_entry {
 	DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
 };
 
+void optee_cq_init(struct optee_call_queue *cq, int thread_count)
+{
+	mutex_init(&cq->mutex);
+	INIT_LIST_HEAD(&cq->normal_waiters);
+	INIT_LIST_HEAD(&cq->sys_waiters);
+	/*
+	 * If cq->total_thread_count is 0 then we're not trying to keep
+	 * track of how many free threads we have, instead we're relying on
+	 * the secure world to tell us when we're out of thread and have to
+	 * wait for another thread to become available.
+	 */
+	cq->total_thread_count = thread_count;
+	cq->free_normal_thread_count = thread_count;
+}
+
 void optee_cq_wait_init(struct optee_call_queue *cq,
 			struct optee_call_waiter *w, bool sys_thread)
 {
+	bool need_wait = false;
+
 	/*
 	 * We're preparing to make a call to secure world. In case we can't
 	 * allocate a thread in secure world we'll end up waiting in
@@ -53,15 +70,40 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
 	mutex_lock(&cq->mutex);
 
 	/*
-	 * We add ourselves to the queue, but we don't wait. This
-	 * guarantees that we don't lose a completion if secure world
-	 * returns busy and another thread just exited and try to complete
-	 * someone.
+	 * We add ourselves to a queue, but we don't wait. This guarantees
+	 * that we don't lose a completion if secure world returns busy and
+	 * another thread just exited and try to complete someone.
 	 */
 	init_completion(&w->c);
-	list_add_tail(&w->list_node, &cq->waiters);
+	w->sys_thread = sys_thread;
+	if (sys_thread) {
+		list_add_tail(&w->list_node, &cq->sys_waiters);
+	} else {
+		list_add_tail(&w->list_node, &cq->normal_waiters);
+		if (cq->total_thread_count) {
+			/*
+			 * Claim a normal thread if one is available, else
+			 * we'll need to wait for a normal thread to be
+			 * released.
+			 */
+			if (cq->free_normal_thread_count > 0)
+				cq->free_normal_thread_count--;
+			else
+				need_wait = true;
+		}
+	}
 
 	mutex_unlock(&cq->mutex);
+
+	while (need_wait) {
+		optee_cq_wait_for_completion(cq, w);
+		mutex_lock(&cq->mutex);
+		if (cq->free_normal_thread_count > 0) {
+			cq->free_normal_thread_count--;
+			need_wait = false;
+		}
+		mutex_unlock(&cq->mutex);
+	}
 }
 
 void optee_cq_wait_for_completion(struct optee_call_queue *cq,
@@ -74,7 +116,10 @@ void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 	/* Move to end of list to get out of the way for other waiters */
 	list_del(&w->list_node);
 	reinit_completion(&w->c);
-	list_add_tail(&w->list_node, &cq->waiters);
+	if (w->sys_thread)
+		list_add_tail(&w->list_node, &cq->sys_waiters);
+	else
+		list_add_tail(&w->list_node, &cq->normal_waiters);
 
 	mutex_unlock(&cq->mutex);
 }
@@ -83,10 +128,19 @@ static void optee_cq_complete_one(struct optee_call_queue *cq)
 {
 	struct optee_call_waiter *w;
 
-	list_for_each_entry(w, &cq->waiters, list_node) {
+	list_for_each_entry(w, &cq->sys_waiters, list_node) {
 		if (!completion_done(&w->c)) {
 			complete(&w->c);
-			break;
+			return;
+		}
+	}
+
+	if (!cq->total_thread_count || cq->free_normal_thread_count > 0) {
+		list_for_each_entry(w, &cq->normal_waiters, list_node) {
+			if (!completion_done(&w->c)) {
+				complete(&w->c);
+				break;
+			}
 		}
 	}
 }
@@ -104,6 +158,9 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
 	/* Get out of the list */
 	list_del(&w->list_node);
 
+	if (!w->sys_thread)
+		cq->free_normal_thread_count++; /* Release a normal thread */
+
 	/* Wake up one eventual waiting task */
 	optee_cq_complete_one(cq);
 
@@ -119,6 +176,36 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
 	mutex_unlock(&cq->mutex);
 }
 
+bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq)
+{
+	bool rc = false;
+
+	mutex_lock(&cq->mutex);
+
+	/* Leave at least 1 normal (non-system) thread */
+	if (cq->res_sys_thread_count + 1 < cq->total_thread_count) {
+		cq->free_normal_thread_count--;
+		cq->res_sys_thread_count++;
+		rc = true;
+	}
+
+	mutex_unlock(&cq->mutex);
+
+	return rc;
+}
+
+void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq)
+{
+	mutex_lock(&cq->mutex);
+	if (cq->res_sys_thread_count > 0) {
+		cq->res_sys_thread_count--;
+		cq->free_normal_thread_count++;
+		/* If there's someone waiting, let it resume */
+		optee_cq_complete_one(cq);
+	}
+	mutex_unlock(&cq->mutex);
+}
+
 /* Requires the filpstate mutex to be held */
 static struct optee_session *find_session(struct optee_context_data *ctxdata,
 					  u32 session_id)
@@ -361,6 +448,27 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
 
+int optee_system_session(struct tee_context *ctx, u32 session)
+{
+	struct optee_context_data *ctxdata = ctx->data;
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_session *sess;
+	int rc = -EINVAL;
+
+	mutex_lock(&ctxdata->mutex);
+
+	sess = find_session(ctxdata, session);
+	if (sess && !sess->use_sys_thread &&
+	    optee_cq_inc_sys_thread_count(&optee->call_queue)) {
+		rc = 0;
+		sess->use_sys_thread = true;
+	}
+
+	mutex_unlock(&ctxdata->mutex);
+
+	return rc;
+}
+
 int optee_close_session_helper(struct tee_context *ctx, u32 session,
 			       bool system_thread)
 {
@@ -378,6 +486,8 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session,
 	msg_arg->session = session;
 	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
 
+	if (system_thread)
+		optee_cq_dec_sys_thread_count(&optee->call_queue);
 	optee_free_msg_arg(ctx, entry, offs);
 
 	return 0;
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 5fde9d4100e3..0c9055691343 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 	if (rc)
 		goto err_unreg_supp_teedev;
 	mutex_init(&optee->ffa.mutex);
-	mutex_init(&optee->call_queue.mutex);
-	INIT_LIST_HEAD(&optee->call_queue.waiters);
+	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
 	ffa_dev_set_drvdata(ffa_dev, optee);
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index b68273051454..6e0863a70843 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -43,12 +43,17 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 struct optee_call_waiter {
 	struct list_head list_node;
 	struct completion c;
+	bool sys_thread;
 };
 
 struct optee_call_queue {
 	/* Serializes access to this struct */
 	struct mutex mutex;
-	struct list_head waiters;
+	struct list_head normal_waiters;
+	struct list_head sys_waiters;
+	int total_thread_count;
+	int free_normal_thread_count;
+	int res_sys_thread_count;
 };
 
 struct optee_notif {
@@ -254,6 +259,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
+int optee_system_session(struct tee_context *ctx, u32 session);
 int optee_close_session_helper(struct tee_context *ctx, u32 session,
 			       bool system_thread);
 int optee_close_session(struct tee_context *ctx, u32 session);
@@ -303,6 +309,9 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
 	mp->u.value.c = p->u.value.c;
 }
 
+void optee_cq_init(struct optee_call_queue *cq, int thread_count);
+bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq);
+void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq);
 void optee_cq_wait_init(struct optee_call_queue *cq,
 			struct optee_call_waiter *w, bool sys_thread);
 void optee_cq_wait_for_completion(struct optee_call_queue *cq,
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index e2763cdcf111..3314ffeb91c8 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1209,6 +1209,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
 	.release = optee_release,
 	.open_session = optee_open_session,
 	.close_session = optee_close_session,
+	.system_session = optee_system_session,
 	.invoke_func = optee_invoke_func,
 	.cancel_req = optee_cancel_req,
 	.shm_register = optee_shm_register,
@@ -1356,6 +1357,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	return true;
 }
 
+static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke_fn)
+{
+	struct arm_smccc_res res;
+
+	invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0)
+		return 0;
+	return res.a1;
+}
+
 static struct tee_shm_pool *
 optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 {
@@ -1609,6 +1620,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	unsigned int rpc_param_count;
+	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
@@ -1636,6 +1648,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	thread_count = optee_msg_get_thread_count(invoke_fn);
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
 					     &max_notif_value,
 					     &rpc_param_count)) {
@@ -1725,8 +1738,7 @@ static int optee_probe(struct platform_device *pdev)
 	if (rc)
 		goto err_unreg_supp_teedev;
 
-	mutex_init(&optee->call_queue.mutex);
-	INIT_LIST_HEAD(&optee->call_queue.waiters);
+	optee_cq_init(&optee->call_queue, thread_count);
 	optee_supp_init(&optee->supp);
 	optee->smc.memremaped_shm = memremaped_shm;
 	optee->pool = pool;
-- 
2.25.1

