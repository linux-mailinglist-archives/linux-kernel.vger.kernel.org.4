Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E6566789F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240330AbjALPIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbjALPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:06:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A4653721
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:55:41 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so9127574wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO1qPhV1IetJ3e/aoUepVBj7y30h3+DK1HnH3CspGDY=;
        b=suru85umNT2w65xqaTjkxlovTI6k6Vpg3VVNHrzRUmHK9A7T3IF/2wVwQbRrysGwf4
         vDTQVElJqcZPegfvg3tAVFaAkQWAoh4yzVnmZAe0UIwy40Af23JmRg0JvyJtUj6JrBE9
         Aj5ObFOLbTB5+EieahKN8y4dT+K8Cwl7uWKz8LazDGoIm/VBTBtJJ9pfnKoUWefZKZ+2
         Raj6AzIqDt7a4LEzz14Rl5MyakM6F8wzsz2UBLS9xfEJ8by1dx7VPbjqNzRpiokyWxst
         x9wIIqqP9Iv9sZa9D5HD2PFzrySLrhZzDili9E7+ZQIUSQMsfDUEu50mKCb2Tqahgyhh
         sJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO1qPhV1IetJ3e/aoUepVBj7y30h3+DK1HnH3CspGDY=;
        b=c4aGKXN72bK/TgRepfXubh5wA9KcHt/YQFO3jflwkJy/jAJwRZIyv+mdqNwPJ7se+b
         vQZaXuECV4zukvY0n3rf/j2zymputbmPzuGUayPVmZEhJTr4DB49CxRXku4vmWE+mWDw
         cseTm5xdNUGfpyPEHLcrF+Vj0xKUFR8DrNKXX5Z03iYfxMRdNeK4YAfFifUgR8WHZyLT
         i1MMX4t2/AwgVcpSIjQi05Ysq/WbLQZ+kCaG8Zx7Z0ZBPkpJGxmiyxqC8oZwPIP4KBza
         oaBB5IUorsbDUiqEfXPxQnRUgDcgQycrV9MwqU1cv0w4tCVpSJNlGYhEy33hUtGxLDno
         /c/Q==
X-Gm-Message-State: AFqh2kpSXma3b0G1ghox9tUgR3PZWNELBUbpgxIC/XmNnDkEJYOeNeNs
        fZJtXz8GmaHWDlh78c4o+iZ3HcnoTImQ6MUC
X-Google-Smtp-Source: AMrXdXtHVQLXQMBwYj5oNZifThd+AtMQysIXelqiSFcIRkCuHxnVG60YJiQBhtnUCNVcs6CB9lC0Qw==
X-Received: by 2002:adf:ea12:0:b0:2bd:c097:848b with SMTP id q18-20020adfea12000000b002bdc097848bmr5686018wrm.16.1673535340536;
        Thu, 12 Jan 2023 06:55:40 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.38.209])
        by smtp.gmail.com with ESMTPSA id v14-20020adff68e000000b002365730eae8sm16599779wrp.55.2023.01.12.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 06:55:40 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 3/3] optee core: add irq chip using optee async notification
Date:   Thu, 12 Jan 2023 15:54:24 +0100
Message-Id: <20230112145424.3791276-4-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112145424.3791276-1-etienne.carriere@linaro.org>
References: <20230112145424.3791276-1-etienne.carriere@linaro.org>
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

Adds an irq chip in optee driver to generate interrupts from OP-TEE
notified interrupt events based on optee async notification. Upon such
notification, optee driver invokes OP-TEE to query a pending interrupt
event. If an interrupt notification is pending the invocation return
OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT and optee driver can get the pending
interrupt number with SMC function ID OPTEE_SMC_FUNCID_GET_IT_VALUE.

SMC function ID OPTEE_SMC_FUNCID_SET_IT_MASK allows Linux to mask/unmask
an interrupt notification services.

The optee irq_chip if flagged IRQCHIP_SKIP_SET_WAKE to skip set_wake
as optee interrupt notifications doesn't support the set_wake option.
In case a device is using the optee irq and is marked as wakeup source,
this result in an "Unbalanced IRQ xx wake disable" backtrace, since:
- in irq_set_irq_wake(ON), wake_depth gets incremented, then reset due to
  set_irq_wake_real() returns an error (irq_set_wake() isn't implemented)
- in irq_set_irq_wake(OFF), wake_depth is always 0, hence the warning

Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/optee/optee_private.h |   2 +
 drivers/tee/optee/optee_smc.h     |  78 +++++++++++++++-
 drivers/tee/optee/smc_abi.c       | 142 ++++++++++++++++++++++++++++--
 3 files changed, 216 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e5bd3548691f..2a146d884d27 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -112,6 +112,7 @@ struct optee_pcpu {
  * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
  * @notif_pcpu_wq	workqueue for per cpu aynchronous notification or NULL
  * @notif_pcpu_work	work for per cpu asynchronous notification
+ * @domain		interrupt domain registered by OP-TEE driver
  */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
@@ -121,6 +122,7 @@ struct optee_smc {
 	struct optee_pcpu __percpu *optee_pcpu;
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct notif_pcpu_work;
+	struct irq_domain *domain;
 };
 
 /**
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..0cf83d5a2931 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -226,7 +226,8 @@ struct optee_smc_get_shm_config_result {
  * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
  *		  as the second MSG arg struct for
  *		  OPTEE_SMC_CALL_WITH_ARG
- *	Bit[31:8]: Reserved (MBZ)
+ *	Bit[23:8]: The maximum interrupt event notification number
+ *	Bit[31:24]: Reserved (MBZ)
  * a4-7	Preserved
  *
  * Error return register usage:
@@ -254,6 +255,11 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world supports interrupt events notification to normal world */
+#define OPTEE_SMC_SEC_CAP_IT_NOTIF		BIT(7)
+
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK	GENMASK(23, 8)
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT	8
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -416,6 +422,12 @@ struct optee_smc_disable_shm_cache_result {
  */
 #define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF	0
 
+/*
+ * Notification that OP-TEE triggers an interrupt event to Linux kernel
+ * for an interrupt consumer.
+ */
+#define OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT		1
+
 #define OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE	17
 #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
 	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
@@ -426,6 +438,70 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/*
+ * Retrieve the interrupt number of the pending interrupt event notified to
+ * non-secure world since the last call of this function.
+ *
+ * OP-TEE keeps a record of all posted interrupt notification events. When the
+ * async notif interrupt is received by non-secure world, this function should
+ * be called until all pended interrupt events have been retrieved. When an
+ * interrupt event is retrieved it is cleared from the record in secure world.
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_GET_IT_NOTIF_VALUE
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	IT_NOTIF interrupt identifier value
+ * a2	Bit[0]: OPTEE_SMC_IT_NOTIF_VALID if the value in a1 is
+ *		valid, else 0 if no interrupt event were pending
+ * a2	Bit[1]: OPTEE_SMC_IT_NOTIF_PENDING if another interrupt event
+ *		value is pending, else 0.
+ *	Bit[31:2]: MBZ
+ * a3-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_IT_NOTIF_VALID		BIT(0)
+#define OPTEE_SMC_IT_NOTIF_PENDING		BIT(1)
+
+#define OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE	20
+#define OPTEE_SMC_GET_IT_NOTIF_VALUE \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_IT_NOTIF_VALUE)
+
+/*
+ * Mask or unmask an interrupt notification event.
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_SET_IT_NOTIF_MASK
+ * a1	Interrupt identifier value
+ * a2	Bit[0]: 1 if interrupt event is to be masked, 0 if it is to be unmasked
+ * a2   Bit[31:1] MBZ
+ * a3-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK	21
+#define OPTEE_SMC_SET_IT_NOTIF_MASK \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_SET_IT_NOTIF_MASK)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 8c2d58d605ac..0360afde119f 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -977,6 +977,112 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
  * 5. Asynchronous notification
  */
 
+static u32 get_it_value(optee_invoke_fn *invoke_fn, bool *value_valid,
+			bool *value_pending)
+{
+	struct arm_smccc_res res;
+
+	invoke_fn(OPTEE_SMC_GET_IT_NOTIF_VALUE, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		return 0;
+
+	*value_valid = res.a2 & OPTEE_SMC_IT_NOTIF_VALID;
+	*value_pending = res.a2 & OPTEE_SMC_IT_NOTIF_PENDING;
+	return res.a1;
+}
+
+static u32 set_it_mask(optee_invoke_fn *invoke_fn, u32 it_value, bool mask)
+{
+	struct arm_smccc_res res;
+
+	invoke_fn(OPTEE_SMC_SET_IT_NOTIF_MASK, it_value, mask, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		return 0;
+
+	return res.a1;
+}
+
+static int handle_optee_it(struct optee *optee)
+{
+	bool value_valid;
+	bool value_pending;
+	u32 it;
+
+	do {
+		struct irq_desc *desc;
+
+		it = get_it_value(optee->smc.invoke_fn, &value_valid, &value_pending);
+		if (!value_valid)
+			break;
+
+		desc = irq_to_desc(irq_find_mapping(optee->smc.domain, it));
+		if (!desc) {
+			pr_err("no desc for optee IT:%d\n", it);
+			return -EIO;
+		}
+
+		handle_simple_irq(desc);
+
+	} while (value_pending);
+
+	return 0;
+}
+
+static void optee_it_irq_mask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	set_it_mask(optee->smc.invoke_fn, d->hwirq, true);
+}
+
+static void optee_it_irq_unmask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	set_it_mask(optee->smc.invoke_fn, d->hwirq, false);
+}
+
+static struct irq_chip optee_it_irq_chip = {
+	.name = "optee-it",
+	.irq_disable = optee_it_irq_mask,
+	.irq_enable = optee_it_irq_unmask,
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int optee_it_alloc(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+
+	hwirq = fwspec->param[0];
+
+	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_it_irq_chip, d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops optee_it_irq_domain_ops = {
+	.alloc = optee_it_alloc,
+	.free = irq_domain_free_irqs_common,
+};
+
+static int optee_irq_domain_init(struct platform_device *pdev, struct optee *optee, u_int max_it)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	optee->smc.domain = irq_domain_add_linear(np, max_it, &optee_it_irq_domain_ops, optee);
+	if (!optee->smc.domain) {
+		dev_err(dev, "Unable to add irq domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 				 bool *value_pending)
 {
@@ -1008,13 +1114,15 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 	}
 
 	do {
-		value = get_async_notif_value(optee->smc.invoke_fn,
-					      &value_valid, &value_pending);
+		value = get_async_notif_value(optee->smc.invoke_fn, &value_valid, &value_pending);
 		if (!value_valid)
 			break;
 
 		if (value == OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_BOTTOM_HALF)
 			do_bottom_half = true;
+		else if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF &&
+			 value == OPTEE_SMC_ASYNC_NOTIF_VALUE_DO_IT)
+			handle_optee_it(optee);
 		else
 			optee_notif_send(optee, value);
 	} while (value_pending);
@@ -1042,8 +1150,7 @@ static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
 
-	rc = request_threaded_irq(irq, notif_irq_handler,
-				  notif_irq_thread_fn,
+	rc = request_threaded_irq(irq, notif_irq_handler, notif_irq_thread_fn,
 				  0, "optee_notification", optee);
 	if (rc)
 		return rc;
@@ -1145,6 +1252,9 @@ static void optee_smc_notif_uninit_irq(struct optee *optee)
 
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
+
+		if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
+			irq_domain_remove(optee->smc.domain);
 	}
 }
 
@@ -1284,6 +1394,7 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 					    u32 *sec_caps, u32 *max_notif_value,
+					    u32 *max_notif_it,
 					    unsigned int *rpc_param_count)
 {
 	union {
@@ -1316,6 +1427,12 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	else
 		*rpc_param_count = 0;
 
+	if (*sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
+		*max_notif_it = (res.result.data & OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_MASK) >>
+				OPTEE_SMC_SEC_CAP_MAX_NOTIF_IT_SHIFT;
+	else
+		*max_notif_it = 0;
+
 	return true;
 }
 
@@ -1461,6 +1578,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
+	u32 max_notif_it;
 	u32 arg_cache_flags;
 	u32 sec_caps;
 	int rc;
@@ -1482,7 +1600,7 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value,
+					     &max_notif_value, &max_notif_it,
 					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
@@ -1603,6 +1721,20 @@ static int optee_probe(struct platform_device *pdev)
 			irq_dispose_mapping(irq);
 			goto err_notif_uninit;
 		}
+
+		if (sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF) {
+			rc = optee_irq_domain_init(pdev, optee, max_notif_it);
+			if (rc) {
+				if (irq_is_percpu_devid(optee->smc.notif_irq))
+					uninit_pcpu_irq(optee);
+				else
+					free_irq(optee->smc.notif_irq, optee);
+
+				irq_dispose_mapping(irq);
+				goto err_notif_uninit;
+			}
+		}
+
 		enable_async_notif(optee->smc.invoke_fn);
 		pr_info("Asynchronous notifications enabled\n");
 	}
-- 
2.25.1

