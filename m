Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA016795D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjAXK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjAXK46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:56:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF84EFB5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:56:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id q5so8809951wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0XsyXY+n4GmucCFBe52Rya1+343IWilmPWRC806Fhg=;
        b=jbXCuDn2lEsFfmOYVq5Vyfw0PcjbNLGJHTKCMz6JdOor9KLvZTd2JrpFPjSA5IBM+f
         tud2Rt1SCaQkciYEOjWm92GOJ44oUWYX+dKEnIfU4TJnXsvonQc4IHubNZez7SMvZSNb
         bAdTE2izXCwRtnn80WMWjNMX5jLqI2Btxqfo5htF17CvYmb8ZLm/9YNAtX+XfUgvrtix
         5iYsqy4BraYM4qWDjbmoXPECDnweok9L8w0K9gZC1DQL60P1D9uYobxig9HtMtmdwmLu
         QgWrjxDHD5JUv0NJlZFu5w/ueJVEsZWHa3PKTZ5feFT3IJxmIEeeu9Wv/m5Z4+twQNV4
         Hdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0XsyXY+n4GmucCFBe52Rya1+343IWilmPWRC806Fhg=;
        b=E6uLL8gg+et3yTbL07hC/fjGcTTikbwvCxfSqxFOu2DBjqaeXsJ6+wbA6fg2ix0TX3
         bw4YEKS5tBAbdIZDfN7HIFCRd0nb2XyG+IFDSt2FyUjuy57cJiuLOa6RCSrLOQXTi5Iv
         FtmbtfDnlfwXJdCKbXd/5FJmXCzDnTeZe60ptF+hGocYe2CSXmXkFScl2D5vDc1cpuzO
         +nDIyALdt8KQ5pwqMARfcMNd/1pa7wU6/+GSDBVxNlldfkeY81G9twgJxQGNc5TlhDcT
         blhH0zds4S49Xs+07yp8/9UmxySyc69EhW8IK/qNE7En7rVi8O+Cp2XuUOh078Ve2BPW
         A2fA==
X-Gm-Message-State: AFqh2kqTXuo97b7GY9/ycNo8wIdQfUDaKs53hi5GIHWe0fVs9uRUkOGc
        lE/dB9GcJyjslk9hFKqt7wFdKPct81ksdmnZ
X-Google-Smtp-Source: AMrXdXtPz+GpgYGE05+JjJAHgw4wT5S0YgCLQyzZGYXQMsedFZnckr4GOghB74eVNHhIHnD9ZhgRMw==
X-Received: by 2002:a5d:50d0:0:b0:2bd:c2d7:2700 with SMTP id f16-20020a5d50d0000000b002bdc2d72700mr25279331wrt.42.1674557814429;
        Tue, 24 Jan 2023 02:56:54 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.43.103])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b00286ad197346sm1599336wrn.70.2023.01.24.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:56:54 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 2/3] optee: multiplex tee interrupt events on optee async notif irq
Date:   Tue, 24 Jan 2023 11:56:42 +0100
Message-Id: <20230124105643.1737250-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230124105643.1737250-1-etienne.carriere@linaro.org>
References: <20230124105643.1737250-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements an irqchip in optee driver to relay interrupts notified
from OP-TEE world to the Linux OS. Optee registers up to 1 interrupt
controller and identifies each line with a line number from 0 to
UINT16_MAX.

Existing optee async notif uses an irq for OP-TEE to signal Linux of a
pending event. The implementation binds each event (an async notif value)
to the awaking of a waiting thread or the processing of some TEE
background (bottom half) tasks to be scheduled. The interrupt
notification service added by this change allows TEE to relay interrupt
signals to Linux on secure interrupt occurrences where the end consumer
of the signal lives in normal world.

When optee driver initializes, it negotiates with the TEE whether
interrupt notification is supported or not. The feature is enabled
if both Linux kernel and OP-TEE support it.

OP-TEE defines 2 SMC function IDs for non-secure world to control
interrupt events.

SMC function OPTEE_SMC_GET_NOTIF_IT allows non-secure world to
retrieve pending interrupts by grapes up to 5 lines. The function also
reports whether there are pending async values targeting suspended
threaded sequences execution and whether TEE has background threaded
work to do (async notif value 0 was retrieved).

SMC function OPTEE_SMC_CONFIG_NOTIF_IT configures the insterrupt line
for masking and enabling state and wakeup source.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>

Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v1:
- Removed dependency on optee per-cpu irq notification.
- Change SMC function ID API to retrieves up to 5 optee irq events,
  the optee bottom half event and returns if other async notifications
  are pending, in a single invocation.
- Implement only mask/unmask irqchip handlers with a 2nd SMC function
  to mask/unmask a optee irq in OP-TEE world from an interrupt context.
- Added Cc: tags.
---
 drivers/tee/optee/optee_private.h |  10 ++
 drivers/tee/optee/optee_smc.h     |  88 ++++++++++++++++-
 drivers/tee/optee/smc_abi.c       | 158 ++++++++++++++++++++++++++++--
 3 files changed, 249 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 04ae58892608..f467409e02e9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -94,11 +94,21 @@ struct optee_supp {
 	struct completion reqs_c;
 };
 
+/*
+ * struct optee_smc - optee smc communication struct
+ * @invoke_fn		handler function to invoke secure monitor
+ * @memremaped_shm	virtual address of memory in shared memory pool
+ * @sec_caps:		secure world capabilities defined by
+ *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @notif_irq		interrupt used as async notification by OP-TEE or 0
+ * @domain		interrupt domain registered by OP-TEE driver
+ */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
 	void *memremaped_shm;
 	u32 sec_caps;
 	unsigned int notif_irq;
+	struct irq_domain *domain;
 };
 
 /**
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 73b5e7760d10..df32ad18eddb 100644
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
@@ -426,6 +432,86 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/*
+ * Retrieve up to 5 pending interrupt event notified by OP-TEE world
+ * and whether threaded event are pending on OP-TEE async notif
+ * controller, all this since the last call of this function.
+ *
+ * OP-TEE keeps a record of all posted interrupt notification events.
+ * When the async notif interrupt is received by
+ * non-secure world, this function should be called until all pended
+ * interrupt events have been retrieved. When an interrupt event is
+ * retrieved it is cleared from the record in OP-TEE world.
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_GET_NOTIF_IT
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	Bit[7:0]: Number of pending interrupt carried in a1..a5
+ *	Bit[8]: OPTEE_SMC_NOTIF_IT_PENDING if other interrupt(s) are pending
+ *	Bit[9]: OPTEE_SMC_NOTIF_ASYNC_PENDING if an threaded event is pending
+ *	Bit[10]: OPTEE_SMC_NOTIF_DO_BOTTOM_HALF if retrieved bottom half notif
+ *	Bit[15:11]: Reserved for furture use, MBZ
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 1
+ * a2	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 2
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 3
+ * a3	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 4
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF == 5
+ * a4-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_NOTIF_IT_COUNT_MASK		GENMASK(7, 0)
+#define OPTEE_SMC_NOTIF_IT_PENDING		BIT(8)
+#define OPTEE_SMC_NOTIF_VALUE_PENDING		BIT(9)
+#define OPTEE_SMC_NOTIF_DO_BOTTOM_HALF		BIT(10)
+
+#define OPTEE_SMC_FUNCID_GET_NOTIF_IT		20
+#define OPTEE_SMC_GET_NOTIF_IT \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_NOTIF_IT)
+
+/*
+ * Configure an interrupt notification event
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_CONFIGURE_NOTIF_IT
+ * a1	Interrupt identifier value
+ * a2	Bit[0]: 1 to configure interrupt mask with a3[bit 0], else 0
+ *	Bit[31:1] Reserved for future use, MBZ
+ * a3	Bit[0]: 1 to mask the interrupt, 0 to unmask (applies if a2[bit 0]=1)
+ *	Bit[31:1] Reserved for future use, MBZ
+ * a4-6	Reserved for furture use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_NOTIF_CONFIG_MASK		BIT(0)
+
+#define OPTEE_SMC_FUNCID_CONFIGURE_NOTIF_IT	21
+#define OPTEE_SMC_CONFIGURE_NOTIF_IT \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_CONFIGURE_NOTIF_IT)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..9f4fdd28f04a 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -977,6 +977,71 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
  * 5. Asynchronous notification
  */
 
+static void config_notif_it(optee_invoke_fn *invoke_fn, u32 it_value,
+			    u32 op_mask, u32 val_mask)
+{
+	struct arm_smccc_res res = { };
+
+	invoke_fn(OPTEE_SMC_CONFIGURE_NOTIF_IT, it_value, op_mask, val_mask,
+		  0, 0, 0, 0, &res);
+}
+
+static void optee_it_irq_mask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	config_notif_it(optee->smc.invoke_fn, d->hwirq, OPTEE_SMC_NOTIF_CONFIG_MASK,
+			OPTEE_SMC_NOTIF_CONFIG_MASK);
+}
+
+static void optee_it_irq_unmask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+
+	config_notif_it(optee->smc.invoke_fn, d->hwirq, OPTEE_SMC_NOTIF_CONFIG_MASK, 0);
+}
+
+static struct irq_chip optee_it_irq_chip = {
+	.name = "optee-it",
+	.irq_mask = optee_it_irq_mask,
+	.irq_unmask = optee_it_irq_unmask,
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
+static int optee_irq_domain_init(struct platform_device *pdev,
+				 struct optee *optee, u_int max_it)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+
+	optee->smc.domain = irq_domain_add_linear(np, max_it,
+						  &optee_it_irq_domain_ops,
+						  optee);
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
@@ -991,6 +1056,60 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 	return res.a1;
 }
 
+static void forward_irq(struct optee *optee, unsigned int id)
+{
+	if (generic_handle_domain_irq(optee->smc.domain, id)) {
+		pr_err("No consumer for optee irq %u, it will be masked\n", id);
+		config_notif_it(optee->smc.invoke_fn, id,
+				OPTEE_SMC_NOTIF_CONFIG_MASK,
+				OPTEE_SMC_NOTIF_CONFIG_MASK);
+	}
+}
+
+static void retrieve_pending_irqs(struct optee *optee, bool *async_value_pending,
+				  bool *do_bottom_half)
+
+{
+	struct arm_smccc_res res;
+	bool it_pending;
+	ssize_t cnt;
+	const unsigned int lsb_mask = GENMASK(15, 0);
+	const unsigned int msb_shift = 16;
+
+	*async_value_pending = false;
+	*do_bottom_half = false;
+
+	do {
+		optee->smc.invoke_fn(OPTEE_SMC_GET_NOTIF_IT, 0, 0, 0, 0, 0, 0, 0, &res);
+
+		if (res.a0)
+			return;
+
+		if (res.a1 & OPTEE_SMC_NOTIF_DO_BOTTOM_HALF)
+			*do_bottom_half = true;
+
+		it_pending = res.a1 & OPTEE_SMC_NOTIF_IT_PENDING;
+		cnt = res.a1 & OPTEE_SMC_NOTIF_IT_COUNT_MASK;
+		if (cnt > 5 || (!cnt && it_pending)) {
+			WARN_ONCE(0, "Unexpected interrupt notif count %zi\n", cnt);
+			break;
+		}
+
+		if (--cnt >= 0)
+			forward_irq(optee, res.a1 >> msb_shift);
+		if (--cnt >= 0)
+			forward_irq(optee, res.a2 & lsb_mask);
+		if (--cnt >= 0)
+			forward_irq(optee, res.a2 >> msb_shift);
+		if (--cnt >= 0)
+			forward_irq(optee, res.a3 & lsb_mask);
+		if (--cnt >= 0)
+			forward_irq(optee, res.a3 >> msb_shift);
+	} while (it_pending);
+
+	*async_value_pending = res.a1 & OPTEE_SMC_NOTIF_VALUE_PENDING;
+}
+
 static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
@@ -999,9 +1118,14 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 	bool value_pending;
 	u32 value;
 
-	do {
-		value = get_async_notif_value(optee->smc.invoke_fn,
-					      &value_valid, &value_pending);
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
+		retrieve_pending_irqs(optee, &value_pending, &do_bottom_half);
+	else
+		value_pending = true;
+
+	while (value_pending) {
+		value = get_async_notif_value(optee->smc.invoke_fn, &value_valid,
+					      &value_pending);
 		if (!value_valid)
 			break;
 
@@ -1009,10 +1133,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 			do_bottom_half = true;
 		else
 			optee_notif_send(optee, value);
-	} while (value_pending);
+	};
 
 	if (do_bottom_half)
 		return IRQ_WAKE_THREAD;
+
 	return IRQ_HANDLED;
 }
 
@@ -1048,6 +1173,9 @@ static void optee_smc_notif_uninit_irq(struct optee *optee)
 			free_irq(optee->smc.notif_irq, optee);
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
+
+		if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF)
+			irq_domain_remove(optee->smc.domain);
 	}
 }
 
@@ -1187,13 +1315,14 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 					    u32 *sec_caps, u32 *max_notif_value,
+					    u32 *max_notif_it,
 					    unsigned int *rpc_param_count)
 {
 	union {
 		struct arm_smccc_res smccc;
 		struct optee_smc_exchange_capabilities_result result;
 	} res;
-	u32 a1 = 0;
+	u32 a1 = OPTEE_SMC_SEC_CAP_IT_NOTIF;
 
 	/*
 	 * TODO This isn't enough to tell if it's UP system (from kernel
@@ -1219,6 +1348,12 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
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
 
@@ -1364,6 +1499,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
+	u32 max_notif_it;
 	u32 arg_cache_flags;
 	u32 sec_caps;
 	int rc;
@@ -1385,7 +1521,7 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value,
+					     &max_notif_value, &max_notif_it,
 					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
@@ -1506,6 +1642,16 @@ static int optee_probe(struct platform_device *pdev)
 			irq_dispose_mapping(irq);
 			goto err_notif_uninit;
 		}
+
+		if (sec_caps & OPTEE_SMC_SEC_CAP_IT_NOTIF) {
+			rc = optee_irq_domain_init(pdev, optee, max_notif_it);
+			if (rc) {
+				free_irq(optee->smc.notif_irq, optee);
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

