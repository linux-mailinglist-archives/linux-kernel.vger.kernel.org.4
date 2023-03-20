Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244006C1BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjCTQf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjCTQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA0E14E86
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn12so3390671edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=coZgV39qyKs2/pDs+sDQc1r5OQnfwOGVkRlYCqNjnyE=;
        b=vZPpqCB0zHiXyY5Vq7/Rq1B+h4CLkskS6DB6FYg80B54N9sBmBrheRnsP23RGgVuCa
         CD6Sc+6H3KQbGiX3RMUWmR8+WWvzDtaDbCMmi6x4JBthUCmWD38at9OoL36aw1lJ25DK
         tkaeOFyfH/S0Ty3Zj26VvjvVcV3qyYlURIEvKgydLC2VqyUk5LoOr9ZdvRlP0ZIPSBPE
         JOR5+LL0CeNKbn4U7UPc56UerGL4AcpPRWZEv94e9WuZsakjYwZoKAV1rPzRm4zfZwKi
         Eph0jH0ZBGS3ctnxs2SwJ5paDP4J013492RUkmqobgNobO7eJo1uZaj2ePyjeVkDaPK4
         NBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coZgV39qyKs2/pDs+sDQc1r5OQnfwOGVkRlYCqNjnyE=;
        b=q2bw9qJLJvamI9fdm/D5hEAphPH4GX633agZEftxbAh30UFO5cb8sdG9gm3ev4SbXc
         24fZwKMsjVTVdEXZ86Diweg4VYcGeUy9NH+xwDDZZbvUd0W1jqhxk09GvYgTJrWVytQt
         XL9FtbkfJ6INJkzEZ4XmSfb7U4a4NetgO44/6MCj9e4IruxsZU64KN46L6dTYlts3pVZ
         cNFj6btWIqXjTLDpcPSgFXX6FkhSehTbc9llChUFAZN4zOGz7MVmWULjBLtWDWnVLhhd
         hfjyxNALU3Oa81s6A32icRu/EGM+3YQiaGaLNJfgyu65aD/AQYl7G0LLgpGRV/VTriNl
         tQUQ==
X-Gm-Message-State: AO0yUKWkT/fqS9HDMAgJ4im5+10oig/y7SD5bO5qoZNmVJ84eZxsBjdM
        ar5YcXBXXeQYcqbnzQdliAmt766nxC5aIoMexi0=
X-Google-Smtp-Source: AK7set9vVVR6TdJWdgTvIcpwc9IcsAI2ILvyrwC150LW17ANHzImC+U/QrTW+RgBxUnPVmnU3zuPlg==
X-Received: by 2002:a17:906:b1c9:b0:907:9bda:93b9 with SMTP id bv9-20020a170906b1c900b009079bda93b9mr9763751ejb.17.1679329689860;
        Mon, 20 Mar 2023 09:28:09 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:104a:5611:7bcb:e0c2:1993:f82b])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm4646335ejb.144.2023.03.20.09.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:28:09 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v5 1/4] tee: optee: system call property
Date:   Mon, 20 Mar 2023 17:27:58 +0100
Message-Id: <20230320162801.2811542-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Adds an argument to do_call_with_arg() handler to tell whether the call
is a system call or nor. This change always sets this info to false
hence no functional change.

This change prepares management of system invocation proposed in a later
change.

Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
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
index 290b1bb0e9cd..844d2bdc68db 100644
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
index 04ae58892608..bdbc0dc293bb 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -130,7 +130,8 @@ struct optee;
  */
 struct optee_ops {
 	int (*do_call_with_arg)(struct tee_context *ctx,
-				struct tee_shm *shm_arg, u_int offs);
+				struct tee_shm *shm_arg, u_int offs,
+				bool system_thread);
 	int (*to_msg_param)(struct optee *optee,
 			    struct optee_msg_param *msg_params,
 			    size_t num_params, const struct tee_param *params);
@@ -180,6 +181,7 @@ struct optee {
 struct optee_session {
 	struct list_head list_node;
 	u32 session_id;
+	bool use_sys_thread;
 };
 
 struct optee_context_data {
@@ -228,7 +230,8 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u32 num_params,
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
index a1c1fa1a9c28..df77700804e5 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -487,7 +487,7 @@ static int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	msg_arg->params->u.tmem.buf_ptr = virt_to_phys(pages_list) |
 	  (tee_shm_get_page_offset(shm) & (OPTEE_MSG_NONCONTIG_PAGE_SIZE - 1));
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 
@@ -530,7 +530,7 @@ static int optee_shm_unregister(struct tee_context *ctx, struct tee_shm *shm)
 	msg_arg->params[0].attr = OPTEE_MSG_ATTR_TYPE_RMEM_INPUT;
 	msg_arg->params[0].u.rmem.shm_ref = (unsigned long)shm;
 
-	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0) ||
+	if (optee->ops->do_call_with_arg(ctx, shm_arg, 0, false) ||
 	    msg_arg->ret != TEEC_SUCCESS)
 		rc = -EINVAL;
 out:
@@ -865,7 +865,8 @@ static void optee_handle_rpc(struct tee_context *ctx,
  * Returns return code from secure world, 0 is OK
  */
 static int optee_smc_do_call_with_arg(struct tee_context *ctx,
-				      struct tee_shm *shm, u_int offs)
+				      struct tee_shm *shm, u_int offs,
+				      bool system_thread)
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_call_waiter w;
@@ -957,7 +958,7 @@ static int simple_call_with_arg(struct tee_context *ctx, u32 cmd)
 		return PTR_ERR(msg_arg);
 
 	msg_arg->cmd = cmd;
-	optee_smc_do_call_with_arg(ctx, shm, offs);
+	optee_smc_do_call_with_arg(ctx, shm, offs, false);
 
 	optee_free_msg_arg(ctx, entry, offs);
 	return 0;
-- 
2.25.1

