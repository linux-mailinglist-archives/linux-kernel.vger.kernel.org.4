Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1202D6C1BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjCTQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjCTQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:34:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7D01F48A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so49005093edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679329691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDeOjoDocOcxKnFCxzE5QJGiGWBwUocZvCAgOgQgvYw=;
        b=VQ3Ll/QEHTAVHgk5aZWji5s2msSwIubq36YfwWXvN4t5sNjy3LcpbNYbSeRuEi+XsN
         z8/r52uCLQ1nvuDcfeP3Zblyi9SQ8N37Tf9w3MwpqRuJPlxP145OJmsO8faVxykxaEk7
         morENENmyDCTIuj72SdNyim/3pjqU/SyJGoQQq9JuiZFg2sDxYG1Fj58DJUSBo6PXSb+
         B5ulTW11sWw/n0iD1MYG4AwMj3XS/AasSlThmCzX0Lp01ti3LRQX6Ths8WKgWmohEI9z
         zQ1xIFKKG8rryb89Q7TNeZQQpDlEx+JR4brDlwTB0V/RwCrNFIhN4Rtp57u3ytW5iKGL
         ZJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDeOjoDocOcxKnFCxzE5QJGiGWBwUocZvCAgOgQgvYw=;
        b=YPuIs03qfomKNUfXUFpT3+Flk2M3kzA72S36Ld9R0yT5FO+wP/U9NXdRrrBUBijMjw
         4ngu6Cwz1vhgZ+7CrvveFo6cdPrF0I9Hv8QCmVA6T0bdFAb89xrC4NVY6FajzKJMGUWB
         /bqSkflTK+Bopgz2YcbajUZ5mQH+1uiXogiTA2VFd730/dWAaGLpburbatXnFpZwvdrM
         AGSz2+3Cb2wRCu4lnFdAa36svn7m5LGhtIU8CtpQJLnQPTrCCFDDTCtuKjCBnDSSw2Nb
         Lql1leATjcpri9Y3GL7dMHJuE5n2nXYd+esrgV+5MrD+Gx3BkMhvY4Az5VnN/ZDp+a7u
         i83w==
X-Gm-Message-State: AO0yUKVcqRLfUynxTCyVGTJ3SJYRa8oSlpgsv0Nrhs0ouWBr98IIesyL
        8eTZnGdxcO0xFo0CiBFndRJV2jKKAvGjZDbc7Uc=
X-Google-Smtp-Source: AK7set+4poO5jiBNV/Qz3zcdFXCmCVoALDUP20qdaRa3np+7mHDQhPXGZw8LTkcDF3/gj4+iCEcfgg==
X-Received: by 2002:a17:907:3f93:b0:933:15c0:6e05 with SMTP id hr19-20020a1709073f9300b0093315c06e05mr9929989ejc.7.1679329690771;
        Mon, 20 Mar 2023 09:28:10 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:104a:5611:7bcb:e0c2:1993:f82b])
        by smtp.gmail.com with ESMTPSA id b17-20020a17090630d100b009300424a2fdsm4646335ejb.144.2023.03.20.09.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:28:10 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v5 2/4] tee: system session
Date:   Mon, 20 Mar 2023 17:27:59 +0100
Message-Id: <20230320162801.2811542-2-etienne.carriere@linaro.org>
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

Adds kernel client API function tee_client_system_session() for a client
to request a system service entry in TEE context.

This feature is needed to prevent a system deadlock when several TEE
client applications invoke TEE, consuming all TEE thread contexts
available in the secure world. The deadlock can happen in the OP-TEE
driver for example if all these TEE threads issue an RPC call from TEE
to Linux OS to access an eMMC RPMB partition (TEE secure storage) which
device clock or regulator controller is accessed through an OP-TEE SCMI
services. In that case, Linux SCMI driver must reach OP-TEE SCMI service
without waiting one of the consumed TEE thread is freed.

Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
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
index 98da206cd761..cf241bf1c6f7 100644
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

