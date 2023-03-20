Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF76C1BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjCTQfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjCTQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8322025
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x3so48968809edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXkyzw67vzSdH3kz71nVOLRM9uyb/ncUdlbLW1O8cfc=;
        b=s+cifg0Ow6fmWKWvJrsbbVv0fmg0ooOK0C8ng52m/8izTiV+0hB6tXZRsuj/773Ot4
         4KI7jOUsIiCLIRDfkSd4BhCYjCrl4ykeRIQURgIB/qaT1d1jBnzPAbVF5FAhXigm6UdD
         Cl+/1clJEQ5tmTzQUUrKQGXgPGDfPKIx+9CrHwJui1FY61yPhWF/UkZ6DPZtIb7rmlAN
         NmZT45KgDp5P787wxKMtOBGhrJcDfctIN8zbq9uxS6eqM1K/20SRoTOG6lnBOSG7ymho
         DXhme/s4mn9qhH2iSrvtWg6QUFyvc1vBoTcNrU2Wb5Wm5uhH/Xk8IwnYufFwAa8mdzFT
         TZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXkyzw67vzSdH3kz71nVOLRM9uyb/ncUdlbLW1O8cfc=;
        b=Ct5bUEI4hG8LZVfWlF3MGVSX0DSSDrRvp+hx6mhsg0gr5KTpC89e/ZdLt6VZDO32xb
         vN3M0blQrVcS/sG8aR+2dBwG/tecjyVuc2LwJnI9r0QBeqI5X+OnzjLKPHjwxREvRPbV
         oa30eJnxZilLWT73R3oDn/fL2IMgIINjIA4lFl41CiIh6aLIIkfu49YxHxZjJzCPdoCi
         nnv5CjqpWkrTAdh5KjPQhYe4Bp4/7BtyxiHL2U3vuz57BphI3VKC7/kxPvCsrMRJe8DB
         DzzuCnIftICB82TS56tUv/6Wez73ZJ/FCF9/ZxDP7L2v6+l22egCfJX9Wh/UnudGuCqo
         UNoA==
X-Gm-Message-State: AO0yUKU2ZHm3H1rDbItOOqIlcsvkn81iqF0Md6leTkAdZ5XYwk3uvdXK
        0woIc4AGHiUbKR5njZde7wFmZCZNYiE50NI5hsg=
X-Google-Smtp-Source: AK7set+LUVPCstpLjwkx2cevUwe9gjLIplZfwJC/IQC4qHW+MHq3Zq8DROapxu3rJDj/W21sreMLhg==
X-Received: by 2002:a50:fb93:0:b0:4f9:ef7a:27d2 with SMTP id e19-20020a50fb93000000b004f9ef7a27d2mr101712edq.17.1679329691867;
        Mon, 20 Mar 2023 09:28:11 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:104a:5611:7bcb:e0c2:1993:f82b])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm4646335ejb.144.2023.03.20.09.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:28:11 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v5 3/4] tee: optee: support tracking system threads
Date:   Mon, 20 Mar 2023 17:28:00 +0100
Message-Id: <20230320162801.2811542-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320162801.2811542-1-etienne.carriere@linaro.org>
References: <20230320162801.2811542-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Adds support in the OP-TEE driver to keep track of reserved system
threads. The optee_cq_*() functions are updated to handle this if
enabled. The SMC ABI part of the driver enables this tracking, but the
FF-A ABI part does not.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
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
 drivers/tee/optee/call.c          | 128 +++++++++++++++++++++++++++---
 drivers/tee/optee/ffa_abi.c       |  10 +--
 drivers/tee/optee/optee_private.h |  13 ++-
 drivers/tee/optee/smc_abi.c       |  24 ++++--
 4 files changed, 154 insertions(+), 21 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 844d2bdc68db..8b8181099da7 100644
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
-			struct optee_call_waiter *w)
+			struct optee_call_waiter *w, bool sys_thread)
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
index 52cec9d06041..0c9055691343 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -528,7 +528,8 @@ static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
 
 static int optee_ffa_yielding_call(struct tee_context *ctx,
 				   struct ffa_send_direct_data *data,
-				   struct optee_msg_arg *rpc_arg)
+				   struct optee_msg_arg *rpc_arg,
+				   bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
@@ -541,7 +542,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
 	int rc;
 
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		rc = msg_ops->sync_send_receive(ffa_dev, data);
 		if (rc)
@@ -643,7 +644,7 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
 	if (IS_ERR(rpc_arg))
 		return PTR_ERR(rpc_arg);
 
-	return optee_ffa_yielding_call(ctx, &data, rpc_arg);
+	return optee_ffa_yielding_call(ctx, &data, rpc_arg, system_thread);
 }
 
 /*
@@ -851,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
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
index bdbc0dc293bb..4f4201c812e3 100644
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
@@ -230,6 +235,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
+int optee_system_session(struct tee_context *ctx, u32 session);
 int optee_close_session_helper(struct tee_context *ctx, u32 session,
 			       bool system_thread);
 int optee_close_session(struct tee_context *ctx, u32 session);
@@ -279,8 +285,11 @@ static inline void optee_to_msg_param_value(struct optee_msg_param *mp,
 	mp->u.value.c = p->u.value.c;
 }
 
+void optee_cq_init(struct optee_call_queue *cq, int thread_count);
+bool optee_cq_inc_sys_thread_count(struct optee_call_queue *cq);
+void optee_cq_dec_sys_thread_count(struct optee_call_queue *cq);
 void optee_cq_wait_init(struct optee_call_queue *cq,
-			struct optee_call_waiter *w);
+			struct optee_call_waiter *w, bool sys_thread);
 void optee_cq_wait_for_completion(struct optee_call_queue *cq,
 				  struct optee_call_waiter *w);
 void optee_cq_wait_final(struct optee_call_queue *cq,
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index df77700804e5..418c967b83f0 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -261,9 +261,10 @@ static int optee_to_msg_param(struct optee *optee,
 static void optee_enable_shm_cache(struct optee *optee)
 {
 	struct optee_call_waiter w;
+	bool system_thread = false;
 
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		struct arm_smccc_res res;
 
@@ -286,9 +287,10 @@ static void optee_enable_shm_cache(struct optee *optee)
 static void __optee_disable_shm_cache(struct optee *optee, bool is_mapped)
 {
 	struct optee_call_waiter w;
+	bool system_thread = false;
 
 	/* We need to retry until secure world isn't busy. */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		union {
 			struct arm_smccc_res smccc;
@@ -907,7 +909,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 		reg_pair_from_64(&param.a1, &param.a2, parg);
 	}
 	/* Initialize waiter */
-	optee_cq_wait_init(&optee->call_queue, &w);
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
 	while (true) {
 		struct arm_smccc_res res;
 
@@ -1092,6 +1094,7 @@ static const struct tee_driver_ops optee_clnt_ops = {
 	.release = optee_release,
 	.open_session = optee_open_session,
 	.close_session = optee_close_session,
+	.system_session = optee_system_session,
 	.invoke_func = optee_invoke_func,
 	.cancel_req = optee_cancel_req,
 	.shm_register = optee_shm_register,
@@ -1223,6 +1226,16 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
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
@@ -1362,6 +1375,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct optee *optee = NULL;
 	void *memremaped_shm = NULL;
 	unsigned int rpc_param_count;
+	unsigned int thread_count;
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
@@ -1385,6 +1399,7 @@ static int optee_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	thread_count = optee_msg_get_thread_count(invoke_fn);
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
 					     &max_notif_value,
 					     &rpc_param_count)) {
@@ -1474,8 +1489,7 @@ static int optee_probe(struct platform_device *pdev)
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

