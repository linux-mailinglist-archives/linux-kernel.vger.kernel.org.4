Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A25704E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjEPMya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjEPMyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:54:24 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07BCBD
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f450815d0bso74803475e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241650; x=1686833650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHfKWQN5qNmIaor+bUPf6Gw9IbAjQ9a+/M7m53OG8rQ=;
        b=bOgfyfAHUwsfg/QA3znVupJQpSN93W4nNi9lrHk6A+85DoGyiX7v6ZnOqhGJwtRcr2
         TwER5dqYHdVvr+ZJmlxEL5fa/igp6k6ajhLlT5nOkU2QAv4EOV4Td1cwxC/1gTEYeYVw
         aj3OQQTqLkncAZ+QWZ+tEIGvoEr5uUObN36jlvlFXAnNDjJZ711M0e6mQ+7m4VBgYslo
         XYa8cZVakfdbt2S2yrhWVvFQ3uC4qNkmBj8BktuyHuIO5ozeJAqsn8lPsvYxdbuDY5Yf
         I1Lo1h/u68pdZYAb9REKb2wLxoHDBH0oDVWFMmdSkLhfLJmYmQKWcJnjb5fSrl6YvF5W
         PlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241650; x=1686833650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHfKWQN5qNmIaor+bUPf6Gw9IbAjQ9a+/M7m53OG8rQ=;
        b=CqMR++xG/I1WbTYsky8WxBsNY+oQBQiNgFHa9gNQgdsG2qA4fW3JWOj/MBGv9WiHkN
         gTrnE9Z3l2uuUjVvsPvenAadpG9uq2E8yHk2gZFmUiffAmnoA42rx8lCK90oqp37SHp8
         giSxhEs63fUGKJx5FIWNWz67DLYbz7IWWliZDkzsRw9c4OO8Wz4/05QKAsjo+lFGFUuq
         dCKpL7xkkSaAcIOuvV50YjVIbTwZaXmlV+C9BWkmmg8QGmWYWGtrSBp0gIkQekAciTu4
         eWZL9HQBhKSgTt+8rM0OIcs0ruRS9FtqnRyR/4D8KoipDvoeXAMfRc/nDHwfvbTlxu8J
         hUIg==
X-Gm-Message-State: AC+VfDx40ARpGK2KnWT1uJ+BH7rlxrbpWq0hAqCxIIfkpjTyvPYIcXS0
        58l09MOkBmMDBad3l/l2ajwGIP6INNKaPfrPYqg=
X-Google-Smtp-Source: ACHHUZ46uSK37InAmYxPUA1vxT7S29fG0nYW5wGQruuVn1DTHGuNdgNv3tjqszcGA+zui9h4A1WU0g==
X-Received: by 2002:a1c:f703:0:b0:3f1:979f:a733 with SMTP id v3-20020a1cf703000000b003f1979fa733mr27699054wmh.31.1684241649744;
        Tue, 16 May 2023 05:54:09 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (87-88-164-239.abo.bbox.fr. [87.88.164.239])
        by smtp.gmail.com with ESMTPSA id r18-20020a056000015200b003047d5b8817sm2521963wrx.80.2023.05.16.05.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:54:09 -0700 (PDT)
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
Subject: [PATCH v8 2/4] tee: system session
Date:   Tue, 16 May 2023 14:51:09 +0200
Message-Id: <20230516125111.2690204-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516125111.2690204-1-etienne.carriere@linaro.org>
References: <20230516125111.2690204-1-etienne.carriere@linaro.org>
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

Adds kernel client API function tee_client_system_session() for a client
to request a system service entry in TEE context.

This feature is needed to prevent a system deadlock when several TEE
client applications invoke TEE, consuming all TEE thread contexts
available in the secure world. The deadlock can happen in the OP-TEE
driver for example if all these TEE threads issue an RPC call from TEE
to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
device clock or regulator controller is accessed through an OP-TEE SCMI
services. In that case, Linux SCMI driver must reach OP-TEE SCMI service
without waiting until one of the consumed TEE threads is freed.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
No change since v7

Changes since v6:
- Fixed commit message from review comments.
- Applied Sumit's R-b tag.

No change since v5

Changes since v4:
- Changes extracted from "[PATCH v4 1/2] tee: system invocation" and
  revised with Jens contribution to cover only definition of tee driver
  new API function tee_client_system_session() for kernel clients to
  register their session as a system session.
- Commit message rephrased, including header line changed from
  "tee: system invocation" to "tee: system session" has the feature
  relates to system attributes of tee sessions.

Changes since v3:
- Fixed new SMC funcIDs to reserved/unreserve OP-TEE thread contexts:
  minor renaming + define as fastcall funcIDs.
- Moved system_ctx_count from generic struct tee_context to optee's
  private struct optee_context_data. This changes optee smc_abi.c
  to release reserved thread contexts when the optee device is released.
- Fixed inline description comments.

No change since v2

Change since v1
- Addressed comment on Linux client to claim reservation on TEE context.
  This brings 2 new operations from client to TEE to request and release
  system thread contexts: 2 new tee_drv.h API functions, 2 new ops
  functions in struct tee_driver_ops. The OP-TEE implement shall implement
  2 new fastcall SMC funcIDs.
- Fixed typos in commit message.
---
 drivers/tee/tee_core.c  |  8 ++++++++
 include/linux/tee_drv.h | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0eb342de0b00..91932835d0f7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1170,6 +1170,14 @@ int tee_client_close_session(struct tee_context *ctx, u32 session)
 }
 EXPORT_SYMBOL_GPL(tee_client_close_session);
 
+int tee_client_system_session(struct tee_context *ctx, u32 session)
+{
+	if (!ctx->teedev->desc->ops->system_session)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->system_session(ctx, session);
+}
+EXPORT_SYMBOL_GPL(tee_client_system_session);
+
 int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param)
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 17eb1c5205d3..911ddf92dcee 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -84,6 +84,7 @@ struct tee_param {
  * @release:		release this open file
  * @open_session:	open a new session
  * @close_session:	close a session
+ * @system_session:	declare session as a system session
  * @invoke_func:	invoke a trusted function
  * @cancel_req:		request cancel of an ongoing invoke or open
  * @supp_recv:		called for supplicant to get a command
@@ -100,6 +101,7 @@ struct tee_driver_ops {
 			    struct tee_ioctl_open_session_arg *arg,
 			    struct tee_param *param);
 	int (*close_session)(struct tee_context *ctx, u32 session);
+	int (*system_session)(struct tee_context *ctx, u32 session);
 	int (*invoke_func)(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
@@ -429,6 +431,20 @@ int tee_client_open_session(struct tee_context *ctx,
  */
 int tee_client_close_session(struct tee_context *ctx, u32 session);
 
+/**
+ * tee_client_system_session() - Declare session as a system session
+ * @ctx:	TEE Context
+ * @session:	Session id
+ *
+ * This function requests TEE to provision an entry context ready to use for
+ * that session only. The provisioned entry context is used for command
+ * invocation and session closure, not for command cancelling requests.
+ * TEE releases the provisioned context upon session closure.
+ *
+ * Return < 0 on error else 0 if an entry context has been provisioned.
+ */
+int tee_client_system_session(struct tee_context *ctx, u32 session);
+
 /**
  * tee_client_invoke_func() - Invoke a function in a Trusted Application
  * @ctx:	TEE Context
-- 
2.25.1

