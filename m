Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095316BAF56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCOLdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCOLdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:33:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500F070434
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:32:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd5so40279189edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58bQlg5XFWdYEFpUno48HS+VmEV9oIwYieu15PZRLsE=;
        b=Zjg6N5HdSzLZUuyuDWtsjN0vF7J8ooqEbEvSurifcZJ7MBtxlqvJHJCKvvNdNtA6hZ
         89vak07pWu3zzFgFtqpE+LX3hqOMF6OOd4tQLeHcbZ1lba/90QhErIcNwqoGk/Uh3Qp7
         vzFpfVOuQL49nBziENFgAJ2yKINlQvmn44ynl/0prhQudLNX6kmg4Qo7ZXmT90COQedk
         /qNiFUeqQRDvHXCwOfrC1I2kAzNN22uCLgvCr02eCg8cqguJkO8LiC9OutlCDuEYaLCs
         YlbDYJ6WMB/02N6uzhniPdL+W0JkzYKe3OZEXRrX45R2d5ssj0Ku1JUigq33g1nZxx8Y
         ihSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=58bQlg5XFWdYEFpUno48HS+VmEV9oIwYieu15PZRLsE=;
        b=PgEZfjnsreNQ2KxkZwvs+QkLy2WsYsQlukYbt6GhE3zaw6+rlDEFoaXbpGCnDyGb7B
         Np9okfQK8O41E2JKN6JR6+EyPspTtjSpq4ZZofgboyNfg/evupv6C20fq+gy4P7NEQKD
         OuV4vgYzQctxZ79/+FB4Owao+pTfimF3d4AInqV5uwyP3eTbODmAj94BdKbIxC5axZ/u
         z+dVeRCjk3HcY/S+Bb0a7T9kUpdWDQIS180bFR5JfaKIJ63tevWltlFVqlYkfWplhW/Z
         sj6CHKMpQCvFHgCMDngcbgxoMyekbuS0CA1kKWvXnqVxIhvhRUXO312h3r/NIQWyBfsY
         /80A==
X-Gm-Message-State: AO0yUKW1+RbG1Vsd4Vk5JO+Ujsi7Mrvvt8EyGnHp6V7laIwPMnMx9dtd
        nkkk2nS8StOs3X6h0uswsrRPfzaIRYPePafoGdY=
X-Google-Smtp-Source: AK7set8Bqi0XnV+LtwHzfFf4SEsYO4CeJxiJv2RN5O7vOK24mi0uZaBYSF067yGF7Ul58CBTT0Vxew==
X-Received: by 2002:a05:6402:687:b0:4fd:1f7b:9fbd with SMTP id f7-20020a056402068700b004fd1f7b9fbdmr2526017edy.6.1678879928584;
        Wed, 15 Mar 2023 04:32:08 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1008:2d39:4d4b:ab19:bc3b:a0cd])
        by smtp.gmail.com with ESMTPSA id 1-20020a508e41000000b004fb95f51f54sm2264151edx.12.2023.03.15.04.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:32:08 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 3/3] optee: add enable/disable/set_wake handlers to optee irqs
Date:   Wed, 15 Mar 2023 12:32:01 +0100
Message-Id: <20230315113201.1343781-3-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230315113201.1343781-1-etienne.carriere@linaro.org>
References: <20230315113201.1343781-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements OP-TEE's It Notif PTA API to deactivate and activate an
interrupt notifier and to configure the wakeup capability
of that interrupt. These controls are useful for efficient power
management of the device when an interrupt controller resources is
hosted in OP-TEE world.

When OP-TEE does not implement the It Notif PTA, the related handlers
simply return with success. If OP-TEE exposes the PTA services, they
are invoked on enable, disable and set_wake irqchip operations.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v3:
- Renamed it_notif/IT_NOTIF to itr_notif/ITR_NOTIF.

Changes since v2:
- Patch added in v2 series for power-up/down and wakeup configuration
  of the irq chip.

Patch not present in v1
- Patch added for power-up/down and wakeup configuration of the irq chip.
---
 drivers/tee/optee/optee_private.h |   2 +
 drivers/tee/optee/smc_abi.c       | 157 ++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index f467409e02e9..4b4002d81315 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -166,6 +166,7 @@ struct optee_ops {
  * @scan_bus_done	flag if device registation was already done.
  * @scan_bus_wq		workqueue to scan optee bus and register optee drivers
  * @scan_bus_work	workq to scan optee bus and register optee drivers
+ * @notif_itr_pta_ctx   TEE context for invoking interrupt configuration services
  */
 struct optee {
 	struct tee_device *supp_teedev;
@@ -185,6 +186,7 @@ struct optee {
 	bool   scan_bus_done;
 	struct workqueue_struct *scan_bus_wq;
 	struct work_struct scan_bus_work;
+	struct tee_context *notif_itr_pta_ctx;
 };
 
 struct optee_session {
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 6e6c6979abfd..046aa242b2ef 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -52,6 +52,43 @@
  */
 #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
 
+/*
+ * Interrupt notification can be configured using Notif-IT PTA services.
+ * Below are the PTA UUID and its API commands.
+ */
+#define PTA_ITR_NOTIF_UUID \
+	UUID_INIT(0x4461e5c7, 0xb523, 0x4b73, 0xac, 0xed, 0x75, 0xad, \
+		  0x2b, 0x9b, 0x59, 0xa1)
+
+/*
+ * PTA_ITR_NOTIF_ACTIVATE_DETECTION - Enable a interrupt notification
+ *
+ * [in]  params[0].value.a     Interrupt ID
+ */
+#define PTA_ITR_NOTIF_ACTIVATE_DETECTION	0
+
+/*
+ * PTA_ITR_NOTIF_DEACTIVATE_DETECTION - Disable a interrupt notification
+ *
+ * [in]  params[0].value.a     Interrupt ID
+ */
+#define PTA_ITR_NOTIF_DEACTIVATE_DETECTION	1
+
+/*
+ * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Enable an interrupt wakeup source
+ *
+ * [in]  params[0].value.a     Interrupt ID
+ */
+#define PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE	2
+
+/*
+ * PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE - Disable an interrupt wakeup source
+ *
+ * [in]  params[0].value.a     Interrupt ID
+ */
+#define PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE	3
+
+
 /*
  * 1. Convert between struct tee_param and struct optee_msg_param
  *
@@ -977,6 +1014,92 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
  * 5. Asynchronous notification
  */
 
+static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static void init_optee_pta_context(struct optee *optee)
+{
+	struct tee_context *ctx = NULL;
+	const uuid_t pta_uuid = PTA_ITR_NOTIF_UUID;
+	struct tee_ioctl_open_session_arg sess_arg;
+	int ret;
+
+	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(ctx))
+		return;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	export_uuid(sess_arg.uuid, &pta_uuid);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		pr_err("Can't open ITR_NOTIF PTA session: %#x\n", sess_arg.ret);
+		tee_client_close_context(ctx);
+		return;
+	}
+
+	tee_client_close_session(ctx, sess_arg.session);
+
+	optee->notif_itr_pta_ctx = ctx;
+}
+
+static void release_optee_pta_context(struct optee *optee)
+{
+	if (optee->notif_itr_pta_ctx) {
+		tee_client_close_context(optee->notif_itr_pta_ctx);
+		optee->notif_itr_pta_ctx = NULL;
+	}
+}
+
+static int invoke_optee_pta(struct optee *optee, unsigned int command,
+			    unsigned int irq_id)
+{
+	const uuid_t pta_uuid = PTA_ITR_NOTIF_UUID;
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_ioctl_invoke_arg inv_arg;
+	struct tee_param param[1];
+	int ret;
+
+	if (!optee->notif_itr_pta_ctx)
+		return -ENOENT;
+
+	memset(&sess_arg, 0, sizeof(sess_arg));
+	export_uuid(sess_arg.uuid, &pta_uuid);
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+
+	ret = tee_client_open_session(optee->notif_itr_pta_ctx, &sess_arg, NULL);
+	if ((ret < 0) || (sess_arg.ret != 0)) {
+		pr_err("tee_client_open_session failed, err: %#x\n", sess_arg.ret);
+		if (!ret)
+			ret = -EINVAL;
+		return ret;
+	}
+
+	memset(&inv_arg, 0, sizeof(inv_arg));
+	inv_arg.session = sess_arg.session;
+	inv_arg.func = command;
+	inv_arg.num_params = 1;
+
+	memset(&param, 0, sizeof(param));
+	param[0].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
+	param[0].u.value.a = irq_id;
+
+	ret = tee_client_invoke_func(optee->notif_itr_pta_ctx, &inv_arg, param);
+	if ((ret < 0) || (inv_arg.ret != 0)) {
+		pr_err("tee_client_invoke_func failed, ret: %d, err: %#x\n",
+		       ret, inv_arg.ret);
+		if (!ret)
+			ret = -EINVAL;
+	}
+
+	tee_client_close_session(optee->notif_itr_pta_ctx, sess_arg.session);
+
+	return ret;
+}
+
 static void optee_itr_notif_mask(struct irq_data *d)
 {
 	struct optee *optee = d->domain->host_data;
@@ -995,10 +1118,40 @@ static void optee_itr_notif_unmask(struct irq_data *d)
 			     0, 0, 0, 0, 0, &res);
 }
 
+static void optee_itr_notif_disable(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	(void)invoke_optee_pta(optee, PTA_ITR_NOTIF_DEACTIVATE_DETECTION, d->hwirq);
+}
+
+static void optee_itr_notif_enable(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	(void)invoke_optee_pta(optee, PTA_ITR_NOTIF_ACTIVATE_DETECTION, d->hwirq);
+}
+
+static int optee_itr_notif_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct optee *optee = d->domain->host_data;
+	u32 command;
+
+	if (on)
+		command = PTA_ITR_NOTIF_ENABLE_WAKEUP_SOURCE;
+	else
+		command = PTA_ITR_NOTIF_DISABLE_WAKEUP_SOURCE;
+
+	return invoke_optee_pta(optee, command, d->hwirq);
+}
+
 static struct irq_chip optee_irq_chip = {
 	.name = "optee-it",
 	.irq_mask = optee_itr_notif_mask,
 	.irq_unmask = optee_itr_notif_unmask,
+	.irq_disable = optee_itr_notif_disable,
+	.irq_enable = optee_itr_notif_enable,
+	.irq_set_wake = optee_itr_notif_set_wake,
 };
 
 static int optee_itr_alloc(struct irq_domain *d, unsigned int virq,
@@ -1459,6 +1612,7 @@ static int optee_smc_remove(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 
 	optee_smc_notif_uninit_irq(optee);
+	release_optee_pta_context(optee);
 
 	optee_remove_common(optee);
 
@@ -1646,6 +1800,8 @@ static int optee_probe(struct platform_device *pdev)
 				irq_dispose_mapping(irq);
 				goto err_notif_uninit;
 			}
+
+			init_optee_pta_context(optee);
 		}
 
 		enable_async_notif(optee->smc.invoke_fn);
@@ -1683,6 +1839,7 @@ static int optee_probe(struct platform_device *pdev)
 		optee_disable_shm_cache(optee);
 	optee_smc_notif_uninit_irq(optee);
 	optee_unregister_devices();
+	release_optee_pta_context(optee);
 err_notif_uninit:
 	optee_notif_uninit(optee);
 err_close_ctx:
-- 
2.25.1

