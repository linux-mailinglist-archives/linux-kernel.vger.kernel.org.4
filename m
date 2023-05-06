Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC646F9036
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjEFHfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjEFHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:34:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A7511B72
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 00:34:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3063afa2372so2384263f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683358441; x=1685950441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elSZ1iM4lPgMf8RIr00md+R+6iwTaNcFXEW7Nchz8q4=;
        b=mwTe5T5ISeT7NYnKeLjjecbelxpKHCnNSZQHYfs1WlntedDT38lMj6aG6/YyaJklQN
         LWXEXfJYpOtzaltccriTW2Ak8ZJCZwzIaVRtZbqDd5EtxlzgWILiHzmNA9BABbOrxNMy
         Pf3eer1NxBBz8vzlou7QTZMsn7zCcRryg8aWMACIHiX+g9AN3atj2XfejzVoui+EqwBn
         u7fAPIyYXt8X6r7B0KEd1BHNyytXlMAbca4M8XsLZ3uA1HuUD1Iu9sIWoC7wDa2CYAws
         X7vM6xdvxgJ8feOplhmKchoVuZE7NWVM85Gu+ahnvAEXV4OIQKkD4yBX6UjFzZx9vgtz
         qg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683358441; x=1685950441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elSZ1iM4lPgMf8RIr00md+R+6iwTaNcFXEW7Nchz8q4=;
        b=JEAiABBW3b5RFm2B7e2Kd19QfxntZJ9xtDROmeCbeoIjA8Iy+qfLwV3Woz89J7J79A
         XVNoMOM4nOVJpzkHX24qZyPXMj8CTXI5nXGpx7CxoClJIMimxSNT+ZcFSp6HrTrX0bop
         Vf59d32P5EBlAw2VACgOSlYuLW0y8qch7itU9pb3hFMKf/wsYkceuP3y8VS8OdGqQ/HI
         tpLi72LYiEFcKS0Ad5YmvYkEZA0EWt+QsxW/t2Rm/4JP5sARyaqZlEIJZyx0I0PCdAGd
         Sm3ThYz+4xOYv3JD7OOXrX4aCrrGDXkqp/H5FRBuyuo68zBhBiM271vBcnHjqlMCY+4E
         qBEQ==
X-Gm-Message-State: AC+VfDykN8erXzWdWmrWc16HGw6p/+SR0EVybv9aOdlmSeXvHJr4/DsQ
        LVDed+ppTwt3H3/EqDVb7pvZ4nh/iQoXuVkGj6M=
X-Google-Smtp-Source: ACHHUZ6Dh+CAWq0CLUJpejlX0ejq/prkUoKdcaeLMcni1OmzJIFqw2YEXunHyR7lZ7ZNEZVK+eGfGg==
X-Received: by 2002:a5d:5283:0:b0:306:2b55:4605 with SMTP id c3-20020a5d5283000000b003062b554605mr3231086wrv.31.1683358441345;
        Sat, 06 May 2023 00:34:01 -0700 (PDT)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d5009000000b003063430ad9bsm4506523wrt.88.2023.05.06.00.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 00:34:01 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v5 2/2] optee: multiplex tee interrupt events on optee async notif irq
Date:   Sat,  6 May 2023 09:32:35 +0200
Message-Id: <20230506073235.2770292-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230506073235.2770292-1-etienne.carriere@linaro.org>
References: <20230506073235.2770292-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements an irqchip in optee driver for the interrupt events notified
from OP-TEE world to the Linux kernel. Optee registers up to 1 interrupt
controller and identifies each line with a line number from 0 to
UINT16_MAX. The interrupt line identifiers and their meaning are
specific to the platform and shall be found in the OP-TEE platform
documentation

There already exists an optee asynchronous notification mechanism using
an irq for OP-TEE to signal to Linux kernel optee driver of a pending
asynchronous events. This existing implementation binds each notified
event to the awaking of a thread waiting to call the TEE. The optee
irqchip service added by this change uses that same irq for
optee interrupt notification.

When optee driver initializes, TEE tells whether it supports interrupt
notification services or not upon what optee driver registers or not
its irqchip controller.

OP-TEE SMC ABI defines 4 new SMC function IDs for non-secure world to
manage optee interrupt events.

Fastcall SMC funcID OPTEE_SMC_GET_NOTIF_ITR allows non-secure world to
retrieve pending interrupts by grapes up to 5 lines. For efficiency,
the function also reports whether there are pending async values
targeting suspended threaded sequences execution and whether TEE has
background threaded work to do.

Fastcall SMC funcID OPTEE_SMC_NOTIF_ITR_SET_MASK allows a Linux kernel
optee irq consumer to mask/unmask the irq line.

Yielded SMC funcID OPTEE_SMC_NOTIF_ITR_SET_STATE allows a Linux kernel
optee irq consumer to enable and disable the irq line

Yielded SMC funcID OPTEE_SMC_NOTIF_ITR_SET_WAKEUP allows a Linux kernel
optee irq consumer to enable and disable the wakeup from low power
capability of the interrupt.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Resolved rebase conflicts since integration in v6.3-rc3 of
  commit b3b4ced12c1b ("optee: add per cpu asynchronous notification").
- Slightly rephrased commit message.

Changes since v3:
- Removed OP-TEE PTA service for interrup enable/wakeup config and
  replaced with OP-TEE standard SMC funcion IDs
  OPTEE_SMC_NOTIF_ITR_SET_STATE and OPTEE_SMC_NOTIF_ITR_SET_WAKEUP.
  With this update, patch 3/3 of v3 is no more needed.

Changes since v2:
- Renamed it_notif/IT_NOTIF to itr_notif/ITR_NOTIF.
- Updated retrieve_pending_irqs() loop from review comments.
- Changed OP-TEE ABI function CONFIGURE_IT to a only act on interrupt
  mask state. The function is renamed xxx_NOTIF_ITR_SET_MASK.
- Don't set OPTEE_SMC_SEC_CAP_IT_NOTIF among non-secure capabilities, the
  capability is related only to whether secure world supports interrupt
  notification to normal world.
- Fixed inline description from review comments.
- Rephrased commit message and added a sentence about optee irq line
  number values and meaning.

Changes since v1:
- Removed dependency on optee per-cpu irq notification.
- Change SMC function ID API to retrieves up to 5 optee irq events,
  the optee bottom half event and returns if other async notifications
  are pending, in a single invocation.
- Implement only mask/unmask irqchip handlers with a 2nd SMC function
  to mask/unmask a optee irq in OP-TEE world from an interrupt context.
- Added Cc: tags.
---
 drivers/tee/optee/optee_private.h |   2 +
 drivers/tee/optee/optee_smc.h     | 133 ++++++++++++++++++++-
 drivers/tee/optee/smc_abi.c       | 186 +++++++++++++++++++++++++++++-
 3 files changed, 315 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 72685ee0d53f..3406c6c8ea30 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -113,6 +113,7 @@ struct optee_pcpu {
  * @notif_pcpu_wq	workqueue for per cpu asynchronous notification or NULL
  * @notif_pcpu_work	work for per cpu asynchronous notification
  * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt management
+ * @domain		interrupt domain registered by OP-TEE driver
  */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
@@ -123,6 +124,7 @@ struct optee_smc {
 	struct workqueue_struct *notif_pcpu_wq;
 	struct work_struct notif_pcpu_work;
 	unsigned int notif_cpuhp_state;
+	struct irq_domain *domain;
 };
 
 /**
diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
index 7d9fa426505b..73160379c738 100644
--- a/drivers/tee/optee/optee_smc.h
+++ b/drivers/tee/optee/optee_smc.h
@@ -250,7 +250,8 @@ struct optee_smc_get_shm_config_result {
  * a3	Bit[7:0]: Number of parameters needed for RPC to be supplied
  *		  as the second MSG arg struct for
  *		  OPTEE_SMC_CALL_WITH_ARG
- *	Bit[31:8]: Reserved (MBZ)
+ *	Bit[23:8]: The maximum interrupt event notification number
+ *	Bit[31:24]: Reserved (MBZ)
  * a4-7	Preserved
  *
  * Error return register usage:
@@ -278,6 +279,11 @@ struct optee_smc_get_shm_config_result {
 #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF		BIT(5)
 /* Secure world supports pre-allocating RPC arg struct */
 #define OPTEE_SMC_SEC_CAP_RPC_ARG		BIT(6)
+/* Secure world supports interrupt events notification to normal world */
+#define OPTEE_SMC_SEC_CAP_ITR_NOTIF		BIT(7)
+
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_MASK	GENMASK(23, 8)
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_SHIFT	8
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -450,6 +456,131 @@ struct optee_smc_disable_shm_cache_result {
 /* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
 #define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG	19
 
+/*
+ * Retrieve up to 5 pending interrupt events notified by OP-TEE world,
+ * whether bottom half is to be scheduled and if there are pending
+ * async event for waiting threads, all this since the last call of
+ * this function.
+ *
+ * Interrupts notified by OP-TEE are identified by a number from 0 to
+ * the interrupt number max value for that platform. Values for each
+ * interrupt number are platform specific and shall be found in the
+ * OP-TEE platform documentation.
+ *
+ * OP-TEE keeps a record of all posted interrupt notification events.
+ * When the async notif interrupt is received by normal world,
+ * this function should be called until all pended interrupt events
+ * have been retrieved. When an interrupt event is retrieved, it is
+ * cleared from the record in OP-TEE world. When do bottom half event
+ * is retrieved (async value 0), it is also cleared from its related
+ * record in OP-TEE world.
+ *
+ * It is expected that this function is called from an interrupt handler
+ * in normal world.
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_GET_NOTIF_ITR
+ * a1-6	Not used
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1	Bit[7:0]: Number of pending interrupt carried in a1..a5
+ *	Bit[8]: OPTEE_SMC_NOTIF_ITR_PENDING if other interrupt(s) are pending
+ *	Bit[9]: OPTEE_SMC_NOTIF_ASYNC_PENDING if a threaded event is pending
+ *		excluding bottom half notification that is retrieved in Bit[10].
+ *	Bit[10]: OPTEE_SMC_NOTIF_DO_BOTTOM_HALF if retrieved bottom half notif
+ *	Bit[15:11]: Reserved for future use, MBZ
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 1
+ * a2	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 2
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF >= 3
+ * a3	Bit[15:0]:  Pending interrupt line value if a1 & 0xFF >= 4
+ *	Bit[31:16]: Pending interrupt line value if a1 & 0xFF == 5
+ * a4-7 Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_NOTIF_ITR_COUNT_MASK		GENMASK(7, 0)
+#define OPTEE_SMC_NOTIF_ITR_PENDING		BIT(8)
+#define OPTEE_SMC_NOTIF_VALUE_PENDING		BIT(9)
+#define OPTEE_SMC_NOTIF_DO_BOTTOM_HALF		BIT(10)
+
+#define OPTEE_SMC_FUNCID_GET_NOTIF_ITR		20
+#define OPTEE_SMC_GET_NOTIF_ITR \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_NOTIF_ITR)
+
+/*
+ * Mask/unmask an interrupt notification
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_MASK
+ * a1	Interrupt number identifier value
+ * a2	1 to mask, 0 to unmask the interrupt notification.
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ *
+ * Not supported return register usage:
+ * a0	OPTEE_SMC_RETURN_ENOTAVAIL
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_MASK	21
+#define OPTEE_SMC_NOTIF_ITR_SET_MASK \
+	OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_MASK)
+
+/*
+ * Enable/disable an interrupt notification
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_STATE
+ * a1	Interrupt number identifier value
+ * a2	1 to enable, 0 to disable the interrupt notification
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_STATE	22
+#define OPTEE_SMC_NOTIF_ITR_SET_STATE \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_STATE)
+
+/*
+ * Enable/disable the wake up from low power feature of an interrupt event
+ *
+ * Call requests usage:
+ * a0	SMC Function ID, OPTEE_SMC_NOTIF_ITR_SET_WAKEUP
+ * a1	Interrupt number identifier value
+ * a2	1 to enable, 0 to disable the interrupt wake up capability
+ * a3-6	Reserved for future use, MBZ
+ * a7	Hypervisor Client ID register
+ *
+ * Normal return register usage:
+ * a0	OPTEE_SMC_RETURN_OK
+ * a1-7	Preserved
+ *
+ * Invalid command with provided arguments return usage:
+ * a0	OPTEE_SMC_RETURN_EBADCMD
+ * a1-7	Preserved
+ */
+#define OPTEE_SMC_FUNCID_NOTIF_ITR_SET_WAKEUP	23
+#define OPTEE_SMC_NOTIF_ITR_SET_WAKEUP \
+	OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_NOTIF_ITR_SET_WAKEUP)
+
 /*
  * Resume from RPC (for example after processing a foreign interrupt)
  *
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 49702cb08f4f..e383811a5f6d 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -997,6 +997,99 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
  * 5. Asynchronous notification
  */
 
+static void optee_itr_notif_mask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+	struct arm_smccc_res res = { };
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, d->hwirq, 1,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_unmask(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+	struct arm_smccc_res res = { };
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, d->hwirq, 0,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_enable(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_STATE, d->hwirq, 1,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static void optee_itr_notif_disable(struct irq_data *d)
+{
+	struct optee *optee = d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_STATE, d->hwirq, 0,
+			     0, 0, 0, 0, 0, &res);
+}
+
+static int optee_itr_notif_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct optee *optee = d->domain->host_data;
+	struct arm_smccc_res res;
+
+	optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_WAKEUP, d->hwirq, !!on,
+			     0, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		return -EINVAL;
+	return 0;
+}
+
+static struct irq_chip optee_irq_chip = {
+	.name = "optee-itr-notif",
+	.irq_mask = optee_itr_notif_mask,
+	.irq_unmask = optee_itr_notif_unmask,
+	.irq_disable = optee_itr_notif_disable,
+	.irq_enable = optee_itr_notif_enable,
+	.irq_set_wake = optee_itr_notif_set_wake,
+};
+
+static int optee_itr_alloc(struct irq_domain *d, unsigned int virq,
+			  unsigned int nr_irqs, void *data)
+{
+	struct irq_fwspec *fwspec = data;
+	irq_hw_number_t hwirq;
+
+	hwirq = fwspec->param[0];
+
+	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &optee_irq_chip,
+				      d->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops optee_irq_domain_ops = {
+	.alloc = optee_itr_alloc,
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
+						  &optee_irq_domain_ops, optee);
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
@@ -1011,6 +1104,61 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 	return res.a1;
 }
 
+static void forward_irq(struct optee *optee, unsigned int itr_num)
+{
+	if (generic_handle_domain_irq(optee->smc.domain, itr_num)) {
+		struct arm_smccc_res res = { };
+
+		pr_err("No consumer for optee irq %u, masked\n", itr_num);
+		optee->smc.invoke_fn(OPTEE_SMC_NOTIF_ITR_SET_MASK, itr_num, 1,
+				     0, 0, 0, 0, 0, &res);
+	}
+}
+
+static void retrieve_pending_irqs(struct optee *optee, bool *async_pending,
+				  bool *do_bottom_half)
+
+{
+	struct arm_smccc_res res;
+	bool irq_pending;
+	ssize_t cnt;
+	const unsigned int lsb_mask = GENMASK(15, 0);
+	const unsigned int msb_shift = 16;
+
+	*do_bottom_half = false;
+
+	do {
+		optee->smc.invoke_fn(OPTEE_SMC_GET_NOTIF_ITR, 0, 0, 0, 0, 0, 0,
+				     0, &res);
+
+		if (res.a0)
+			return;
+
+		if (res.a1 & OPTEE_SMC_NOTIF_DO_BOTTOM_HALF)
+			*do_bottom_half = true;
+
+		irq_pending = res.a1 & OPTEE_SMC_NOTIF_ITR_PENDING;
+		cnt = res.a1 & OPTEE_SMC_NOTIF_ITR_COUNT_MASK;
+		if (cnt > 5 || (!cnt && irq_pending)) {
+			WARN_ONCE(0, "Unexpected irq notif count %zi\n", cnt);
+			break;
+		}
+
+		if (cnt > 0)
+			forward_irq(optee, res.a1 >> msb_shift);
+		if (cnt > 1)
+			forward_irq(optee, res.a2 & lsb_mask);
+		if (cnt > 2)
+			forward_irq(optee, res.a2 >> msb_shift);
+		if (cnt > 3)
+			forward_irq(optee, res.a3 & lsb_mask);
+		if (cnt == 5)
+			forward_irq(optee, res.a3 >> msb_shift);
+	} while (irq_pending);
+
+	*async_pending = res.a1 & OPTEE_SMC_NOTIF_VALUE_PENDING;
+}
+
 static irqreturn_t irq_handler(struct optee *optee)
 {
 	bool do_bottom_half = false;
@@ -1018,9 +1166,15 @@ static irqreturn_t irq_handler(struct optee *optee)
 	bool value_pending;
 	u32 value;
 
-	do {
-		value = get_async_notif_value(optee->smc.invoke_fn,
-					      &value_valid, &value_pending);
+	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+		retrieve_pending_irqs(optee, &value_pending, &do_bottom_half);
+	else
+		value_pending = true;
+
+	while (value_pending) {
+		value = get_async_notif_value(optee->smc.invoke_fn, &value_valid,
+					      &value_pending);
+
 		if (!value_valid)
 			break;
 
@@ -1028,7 +1182,7 @@ static irqreturn_t irq_handler(struct optee *optee)
 			do_bottom_half = true;
 		else
 			optee_notif_send(optee, value);
-	} while (value_pending);
+	}
 
 	if (do_bottom_half)
 		return IRQ_WAKE_THREAD;
@@ -1165,6 +1319,9 @@ static void optee_smc_notif_uninit_irq(struct optee *optee)
 
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
+
+		if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+			irq_domain_remove(optee->smc.domain);
 	}
 }
 
@@ -1320,6 +1477,7 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 					    u32 *sec_caps, u32 *max_notif_value,
+					    u32 *max_notif_it,
 					    unsigned int *rpc_param_count)
 {
 	union {
@@ -1352,6 +1510,13 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 	else
 		*rpc_param_count = 0;
 
+	if (*sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+		*max_notif_it = (res.result.data &
+				 OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_MASK) >>
+				OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_SHIFT;
+	else
+		*max_notif_it = 0;
+
 	return true;
 }
 
@@ -1611,6 +1776,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
+	u32 max_notif_it;
 	u32 arg_cache_flags;
 	u32 sec_caps;
 	int rc;
@@ -1636,7 +1802,7 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value,
+					     &max_notif_value, &max_notif_it,
 					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
@@ -1757,6 +1923,16 @@ static int optee_probe(struct platform_device *pdev)
 			irq_dispose_mapping(irq);
 			goto err_notif_uninit;
 		}
+
+		if (sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF) {
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

