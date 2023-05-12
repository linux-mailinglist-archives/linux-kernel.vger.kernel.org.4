Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0D6FFFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjELFmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjELFmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:42:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97317172A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-306281edf15so8896307f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683870156; x=1686462156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TarqP48NYOTu85taHd4SNq5h2RjwngCq6OvHbpWnkT8=;
        b=HiWZog8rsxgihu0IppqJvEd0ULJG7ogmZT2j7g+Cblr13QkRhblBAWurU5VQajSqaS
         FvIx3ovOFglbimLDmHIJamfysHVxazD8Wkkp+QYBeU2dicFklN/S6cLuI7z3xO372EW8
         pcUqefwKtdJkp/qjJTO2jH56yxsxRzwXgg7d/2G0tiWlgrF+zFYIKv/QpuZrxhHP/CSg
         xX6PKwG9zdgSUFBglhZxuxxC4/PRP1ayUdXUHazQv92RbuGO+T92a6MVB0ZvPL2I+GE9
         FdhMOVblJB4PiB/rnYQ4Ntg4ao5/pIZTgtN/VVptLisqEVBXVoB3MAMbOYvGOrwmqOL1
         fqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870156; x=1686462156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TarqP48NYOTu85taHd4SNq5h2RjwngCq6OvHbpWnkT8=;
        b=e6p1fGT/p7lFEjJk8ClQo7wO4dZjD13iaZE8WJyyquaa2fAtJ/K9PI9SV33Z6p9C1x
         /9oGgrg6ylUvMFWYmd1rK9+RND6fmG8laQDuxGsZiTZia5zTCscXwn3OYWPY8dZHeEx0
         tDZBoO8KXAjvX4xEhCWvlP8jAa0TTEbHY+W1Z9sn/TvsFoKmXDyWAjDxN2KRQi8r9Pcu
         MgzGiiufczyNVHLIWstD6IrJtQ4gUsS/SLAi0P59tf30P4+uDICI56KyP2uKKdA+gjOK
         CRAD5aPh7xIukLwhEylW9tIB9akjfbmJtmIsCJKJ1ax+GKQzFoeDGckRl0Yur5FX2BZp
         41lg==
X-Gm-Message-State: AC+VfDwwB4vIvxkpISP/k0oB7tTS6m41tdTpfkR0yih9HWf02y+5L6O7
        R1iHWZX5Cg/55f6veRurluYlnc09obpTjXlgBi4=
X-Google-Smtp-Source: ACHHUZ6DZoSnfL2JTqipZ7lbUwU5L//i1lZGefCN64SKkmT0bNNS3+lUCLoTLU2NpbbbrnNrEvzCsw==
X-Received: by 2002:a5d:604e:0:b0:2f6:9bc4:76f1 with SMTP id j14-20020a5d604e000000b002f69bc476f1mr16642771wrt.1.1683870156638;
        Thu, 11 May 2023 22:42:36 -0700 (PDT)
Received: from lmecxl1178.home (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id j18-20020adfff92000000b00307bc4e39e5sm6301253wrr.117.2023.05.11.22.42.35
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
Subject: [PATCH v7 2/4] tee: system session
Date:   Fri, 12 May 2023 07:42:20 +0200
Message-Id: <20230512054222.2088837-3-etienne.carriere@linaro.org>
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

