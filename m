Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40FD6809D0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235349AbjA3JmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjA3JmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:42:12 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491AA5589
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:42:10 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1581944wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A/fX6lK4kyxqMY7Pp3GDtdcgmqukLTrE8ke8XBHGOTA=;
        b=ju53VfroPlDppWOtB93M8K7Bqn1MGhyRPaPLLDed3/0mTJGYkaXIGQhCi4OW1Aiu+n
         aUbvQgFJJPHorz6OJMqr6SQWxAp/BsKQFAIDwBNgcxRpJMV8gS5uceWOS9/y3nXAPidd
         Mjq99Er6rI67wnQvnFXercYS0fBeYVoIVO7MWtDt/6U0oyOVfQeSSg9OfVQaGqDUW8S+
         hU/qtPT+St+FS9nyrHax/BnCpMKqA/oRZ9D65oIiC8dhRvvynUtUvPQ1Jx9di1ANWZTK
         tKnoqwL7j/T9kWZUjqeG6DA1sOYU/ZO3BuRPozQjm0KOMkyJ+hCVvqKk0wFTZBcK1ejY
         DY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/fX6lK4kyxqMY7Pp3GDtdcgmqukLTrE8ke8XBHGOTA=;
        b=wiry00rpnYReqBxbJfSR0s3gnTJmfIiByzxzEqLVZWzcTm1Cr1iujlAe0sUzvqGD4H
         NBsUfqER/CB7VCEI2kPwX0CCHrL0tyOognFTV3bS6RSTEJmxYZRp30S4rgL/K7A5u2y0
         B+OpOyaBVn/HYi8Xza8opu5UyKKDJliizlIM0LPuC6vmx+55fm3nut7M71K/8VtKWD8a
         T18jYnoptwT3NHoU1C6LUGjOJkz6u1Fip1q7mATV8+fa/+ugAk2vTC9s3N2OoXVBLVjL
         MA4QUW2QLO/FU2dHZ8gngH8QIZ9IPYTg3fs+RVxDFFvkrHLB6xjrDWDIKBAgj6W3GHz2
         GCDg==
X-Gm-Message-State: AFqh2kpXHBWulh9MMIKPXmIEcdDKe5eyfCwj3aAwsUOiGMBQTBBP6Wew
        1xfZQ8IuiBsrqu1/Ywk7bgyfaZSbYp/Dco23
X-Google-Smtp-Source: AMrXdXsoyDXYaQTzXXbRjiz1dXjuc9fryyMN3KlXmOeDuM3N3ggoIMP6q7ypPh6889jmSj3Pl1PXlQ==
X-Received: by 2002:a05:600c:3c92:b0:3d5:365b:773e with SMTP id bg18-20020a05600c3c9200b003d5365b773emr50188850wmb.39.1675071728384;
        Mon, 30 Jan 2023 01:42:08 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.193.251])
        by smtp.gmail.com with ESMTPSA id i27-20020a05600c4b1b00b003dc54d9aeeasm3865606wmp.36.2023.01.30.01.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 01:42:07 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 1/2] tee: system invocation
Date:   Mon, 30 Jan 2023 10:41:56 +0100
Message-Id: <20230130094157.1082712-1-etienne.carriere@linaro.org>
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

Adds TEE context flag sys_service to be enabled for invocation contexts
that should used TEE provisioned system resources. OP-TEE SMC ABI entry
rely this information to use a dedicated entry function to request
allocation of a system thread from a dedicated system context pool.

This feature is needed when a TEE invocation cannot afford to wait for
a free TEE thread when all TEE threads context are used and suspended
as these may be suspended waiting for a system service, as an SCMI clock
or voltage regulator, to be enabled. An example is when OP-TEE invokes
a Linux OS remove service (RPC) to access an eMMC RPMB partition and
the eMMC device is supplied by an OP-TEE SCMI regulator.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/optee/optee_smc.h | 14 +++++++++++---
 drivers/tee/optee/smc_abi.c   |  6 +++++-
 include/linux/tee_drv.h       |  4 ++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..7c7eedf183c5 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -108,7 +108,8 @@ struct optee_smc_call_get_os_revision_result {
  * Call with struct optee_msg_arg as argument
  *
  * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
- * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
+ * OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
+ * in a0 there is one RPC struct optee_msg_arg
  * following after the first struct optee_msg_arg. The RPC struct
  * optee_msg_arg has reserved space for the number of RPC parameters as
  * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
@@ -130,8 +131,8 @@ struct optee_smc_call_get_os_revision_result {
  * a4-6	Not used
  * a7	Hypervisor Client ID register
  *
- * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
- * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
+ * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG and OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG:
+ * a0	SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG or OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG
  * a1	Upper 32 bits of a 64-bit shared memory cookie
  * a2	Lower 32 bits of a 64-bit shared memory cookie
  * a3	Offset of the struct optee_msg_arg in the shared memory with the
@@ -175,6 +176,8 @@ struct optee_smc_call_get_os_revision_result {
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
 #define OPTEE_SMC_CALL_WITH_REGD_ARG \
 	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
+#define OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG)
 
 /*
  * Get Shared Memory Config
@@ -254,6 +257,8 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world provisions thread for system service invocation */
+#define OPTEE_SMC_SEC_CAP_SYSTEM_THREAD		BIT(7)
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -426,6 +431,9 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/* See OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG above */
+#define OPTEE_SMC_FUNCID_CALL_SYSTEM_WITH_REGD_ARG	20
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..513038a138f6 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -889,7 +889,11 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
 	}
 
 	if  (rpc_arg && tee_shm_is_dynamic(shm)) {
-		param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
+		if (ctx->sys_service &&
+		    (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SYSTEM_THREAD))
+			param.a0 = OPTEE_SMC_CALL_SYSTEM_WITH_REGD_ARG;
+		else
+			param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
 		reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
 		param.a3 = offs;
 	} else {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..1ff292ba7679 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -47,6 +47,9 @@ struct tee_shm_pool;
  *              non-blocking in nature.
  * @cap_memref_null: flag indicating if the TEE Client support shared
  *                   memory buffer with a NULL pointer.
+ * @sys_service: flag set by the TEE Client to indicate that it is part of
+ *		 a system service and that the TEE may use resources reserved
+ *		 for this.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -55,6 +58,7 @@ struct tee_context {
 	bool releasing;
 	bool supp_nowait;
 	bool cap_memref_null;
+	bool sys_service;
 };
 
 struct tee_param_memref {
-- 
2.25.1

