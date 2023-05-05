Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E2C6F8798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjEERbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbjEERbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:31:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC48A17FDB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 10:31:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-305f0491e62so1971739f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683307871; x=1685899871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jfUukF2i6vd0+ioFWgl7YqhMrlegquDIzdsi1Oy+Kus=;
        b=ppdAqQx69nxjh8O8E3OAleM+UqCo3/ry/CeBOw1IF6Q5syIVXIcDMkwhD34rNJaDIZ
         I9QARsx3ReKaCtQAWPaH+tOrOrRPWLjorjdKgfl2XdcFzGqPQH4y+VskSlq7tAhCsch3
         x5gYD16k5lBfCJfXVDfhTSfQ/KZT5iOssQGuH8zjqC/nX6vLDju4qBTRrYXI2WGJnLcg
         zGCV0cbfPNzyKEJByXo4km4Iim79cfuWQX9uCi00FfRmdZIj1HBgwG2pToTp19PZXZEh
         3+XFXXGQFDuzU8YsRSJ86luV3ce6zEwptnFXIUEd4b9WFoU9EZQ0i/DMmFGNEKW1vzqo
         ZBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683307871; x=1685899871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jfUukF2i6vd0+ioFWgl7YqhMrlegquDIzdsi1Oy+Kus=;
        b=QERmfBzV8o2Skpk2vcL0D8LshvP6+/PkrE5eZIkIiXK1UukOlrZMEpINP+hA4J/9fZ
         SZlGYOsmTee3GdtN3N+AAmbU0eowdjASmcPC/FQzOGzTWgbTlLSB0ruKKR/nVQJletD6
         Kl6iVK9dczfn2O2GV5F9JWW8jWkxBwj6DV2q3ckUOPB1MNIryKMmYyDsQOE9JZXfdEyW
         4Y0d3Sq6/Hl61PLfWZcMS1HjQAo4WJuZVGoSvX49k3jDP94bDU1sHOjFeIZAYjJKen1g
         BSI38mOOcMyyyMdq0XO04xUWwn+U2pEN+05K9G5L02PupQEEfQ35EExDKBpTd3JUWnEM
         3X+w==
X-Gm-Message-State: AC+VfDyJfk6DN4+gvv5u5LNO3qEXyMn7+u/7A/5rENkAh56RzffEbyqP
        sI0tST8N4liTDKZq6CQTRHOyV/u3jHLUyRHAPXo=
X-Google-Smtp-Source: ACHHUZ5m5CPOd3pfClWRKezVnzFI9yFXqzh+EjqXWrj/2iIFhhBzJ/+3dCYB5AFG/VohzcME1E5ReA==
X-Received: by 2002:adf:f3c9:0:b0:306:3319:e432 with SMTP id g9-20020adff3c9000000b003063319e432mr2044697wrp.18.1683307870736;
        Fri, 05 May 2023 10:31:10 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id a15-20020adff7cf000000b002f6176cc6desm2971170wrq.110.2023.05.05.10.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 10:31:10 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v6 1/4] tee: optee: system call property
Date:   Fri,  5 May 2023 19:30:09 +0200
Message-Id: <20230505173012.881083-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an argument to do_call_with_arg() handler to tell whether the call
is a system call or nor. This change always sets this info to false
hence no functional change.

This change prepares management of system invocation proposed in a later
change.

Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No changes since v5

Changes since v4:
- New change, extracted from PATCH v4 1/2 (tee: system invocation") and
  revised to cover preparatory changes in optee driver for system session
  support with contribution from Jens.
---
 drivers/tee/optee/call.c          | 22 ++++++++++++++++------
 drivers/tee/optee/core.c          |  5 +++--
 drivers/tee/optee/ffa_abi.c       |  3 ++-
 drivers/tee/optee/optee_private.h |  7 +++++--
 drivers/tee/optee/smc_abi.c       |  9 +++++----
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..dba5339b61ae 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -328,7 +328,8 @@ int optee_open_session(struct tee_context *ctx,
 		goto out;
 	}
 
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs,
+					 sess->use_sys_thread)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -360,7 +361,8 @@ int optee_open_session(struct tee_context *ctx,
 	return rc;
 }
 
-int optee_close_session_helper(struct tee_context *ctx, u32 session)
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_shm_arg_entry *entry;
@@ -374,7 +376,7 @@ int optee_close_session_helper(struct tee_context *ctx, u32 session)
 
 	msg_arg->cmd = OPTEE_MSG_CMD_CLOSE_SESSION;
 	msg_arg->session = session;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
 
 	optee_free_msg_arg(ctx, entry, offs);
 
@@ -385,6 +387,7 @@ int optee_close_session(struct tee_context *ctx, u32 session)
 {
 	struct optee_context_data *ctxdata = ctx->data;
 	struct optee_session *sess;
+	bool system_thread;
 
 	/* Check that the session is valid and remove it from the list */
 	mutex_lock(&ctxdata->mutex);
@@ -394,9 +397,10 @@ int optee_close_session(struct tee_context *ctx, u32 session)
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
+	system_thread = sess->use_sys_thread;
 	kfree(sess);
 
-	return optee_close_session_helper(ctx, session);
+	return optee_close_session_helper(ctx, session, system_thread);
 }
 
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
@@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
 	struct tee_shm *shm;
+	bool system_thread;
 	u_int offs;
 	int rc;
 
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess = find_session(ctxdata, arg->session);
+	if (sess)
+		system_thread = sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -432,7 +439,7 @@ int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 	if (rc)
 		goto out;
 
-	if (optee->ops->do_call_with_arg(ctx, shm, offs)) {
+	if (optee->ops->do_call_with_arg(ctx, shm, offs, system_thread)) {
 		msg_arg->ret = TEEC_ERROR_COMMUNICATION;
 		msg_arg->ret_origin = TEEC_ORIGIN_COMMS;
 	}
@@ -457,12 +464,15 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 	struct optee_shm_arg_entry *entry;
 	struct optee_msg_arg *msg_arg;
 	struct optee_session *sess;
+	bool system_thread;
 	struct tee_shm *shm;
 	u_int offs;
 
 	/* Check that the session is valid */
 	mutex_lock(&ctxdata->mutex);
 	sess = find_session(ctxdata, session);
+	if (sess)
+		system_thread = sess->use_sys_thread;
 	mutex_unlock(&ctxdata->mutex);
 	if (!sess)
 		return -EINVAL;
@@ -474,7 +484,7 @@ int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session)
 	msg_arg->cmd = OPTEE_MSG_CMD_CANCEL;
 	msg_arg->session = session;
 	msg_arg->cancel_id = cancel_id;
-	optee->ops->do_call_with_arg(ctx, shm, offs);
+	optee->ops->do_call_with_arg(ctx, shm, offs, system_thread);
 
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 2a258bd3b6b5..d01ca47f7bde 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -129,7 +129,8 @@ int optee_open(struct tee_context *ctx, bool cap_memref_null)
 
 static void optee_release_helper(struct tee_context *ctx,
 				 int (*close_session)(struct tee_context *ctx,
-						      u32 session))
+						      u32 session,
+						      bool system_thread))
 {
 	struct optee_context_data *ctxdata = ctx->data;
 	struct optee_session *sess;
@@ -141,7 +142,7 @@ static void optee_release_helper(struct tee_context *ctx,
 	list_for_each_entry_safe(sess, sess_tmp, &ctxdata->sess_list,
 				 list_node) {
 		list_del(&sess->list_node);
-		close_session(ctx, sess->session_id);
+		close_session(ctx, sess->session_id, sess->use_sys_thread);
 		kfree(sess);
 	}
 	kfree(ctxdata);
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 0828240f27e6..52cec9d06041 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -612,7 +612,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
  */
 
 static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct ffa_send_direct_data data = {
 		.data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 72685ee0d53f..3da7960ab34a 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -154,7 +154,8 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg, u_int offs);
+				struct tee_shm *shm_arg, u_int offs,
+				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -204,6 +205,7 @@ struct optee {
 struct optee_session {
 	struct list_head list_node;
 	u32 session_id;
+	bool use_sys_thread;
 };
 
 struct optee_context_data {
@@ -252,7 +254,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
 int optee_open_session(struct tee_context *ctx,
 		       struct tee_ioctl_open_session_arg *arg,
 		       struct tee_param *param);
-int optee_close_session_helper(struct tee_context *ctx, u32 session);
+int optee_close_session_helper(struct tee_context *ctx, u32 session,
+			       bool system_thread);
 int optee_close_session(struct tee_context *ctx, u32 session);
 int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invoke_arg *arg,
 		      struct tee_param *param);
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 49702cb08f4f..56ebbb96ac97 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -507,7 +507,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 
@@ -550,7 +550,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 out:
@@ -885,7 +885,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -977,7 +978,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
 		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
+	optee_smc_do_call_with_arg(ctx, shm, offs, false);
 
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
-- 
2.25.1

