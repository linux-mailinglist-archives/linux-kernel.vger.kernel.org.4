Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73C46BEF45
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCQRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCQRKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:10:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D66F2885B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:10:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r11so23071586edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679073025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtEeFxoT23CtU3MENEZRGWN2Mg5CRv/PQaaJ0OONiBc=;
        b=O5LUa4WCVXW1n/aKpcWBqSDtoNlM7Eq08F4Un39AoFkKoKtHAGQuTT6RvVRrbNI9Cx
         UMY4x/EaxPdE+biZTgmtTDzSavU2So63ubzXQhcDXgTAOvVl53WvsGnUuiOFvlzh1NPv
         h6pFRMYdWgrFCW15kgCtoN/5Z9vPy2FznOpGUrq8/XebM7VD9mX8lfS3dz/4c8Rkp49B
         I7MH9GrPAAVWAKSgh2jU9B2SKtOCyXs09e7v9UHAOOG6mPrUZkWb7ENf2Rczj/8YDuiE
         DbV+GJ0houfZYTAoXnd0CcgMx72FM36WusXW8OpgqgcjedyX86e3lVjwqSMWfMPfrm1r
         SE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtEeFxoT23CtU3MENEZRGWN2Mg5CRv/PQaaJ0OONiBc=;
        b=EqfhANF+w9pi/icGs02owv+q1jXY7yo4N3yxSdRn2+z95XK3PHEJsHC4rkZdxb7BX0
         8F5d2yeiFpO6Lv8N95g3t3mR7Qp4zdhGMw8GAs8ZQD5emcjwgERjBVshBXgO4kUBHlkE
         Rf/TLJiUFKXCM77QoZUX6Y9cUazimKMrJME0ie6H8rRssNAet3Ru1Em3tf+Iy5vyJ+Ow
         lCg6Y01PuzSO232vAX/fQZimiAK6wXH7RUm+QjumsqpSR1v5teTJrOT/FtMe87B1Wotj
         stGWb4koSUvgvSMfPjkYWjaU9ywUF3uYTv1lzp9w1YF2hq1ryhtEkz5GtDVIXGAZoNtJ
         MhQw==
X-Gm-Message-State: AO0yUKXIneV3Xg+ZeAwpmoo86TL14AoZ6q1OMDW02aO/j0I5Ngg/imdO
        qKPGVery9SPtUmGg0RI698s8Y+TrDeetQ9W1au8=
X-Google-Smtp-Source: AK7set80p5v5IsqG7arccMNJ1B9TVBZlQbUh6glGn8p0tTFnj/v8zA2ViNA81J4h8xv+ARYcGKM4Sg==
X-Received: by 2002:a17:906:9519:b0:889:58bd:86f1 with SMTP id u25-20020a170906951900b0088958bd86f1mr69166ejx.14.1679073024786;
        Fri, 17 Mar 2023 10:10:24 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:10af:6120:339:9abb:39d1:cb35])
        by smtp.gmail.com with ESMTPSA id kx1-20020a170907774100b0091fdd2ee44bsm1181067ejc.197.2023.03.17.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:10:24 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Pascal Paillet <p.paillet@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 2/2] optee: multiplex tee interrupt events on optee async notif irq
Date:   Fri, 17 Mar 2023 18:10:03 +0100
Message-Id: <20230317171003.974801-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317171003.974801-1-etienne.carriere@linaro.org>
References: <20230317171003.974801-1-etienne.carriere@linaro.org>
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

Implements an irqchip in optee driver for the interrupt events notified
from OP-TEE world to the Linux OS. Optee registers up to 1 interrupt
controller and identifies each line with a line number from 0 to
UINT16_MAX. The identifiers and meaning of the interrupt line number
are specific to the platform and shall be found in the OP-TEE platform
documentation

There already exist an optee asynchronous notification mechanism using
an irq for OP-TEE to signal its optee driver in Linux of a pending
interrupt event. The implementation binds each event to the awaking of
a thread waiting to call the TEE. The interrupt notification service
added by this change allows TEE to send interrupt signals to Linux kernel
on secure event occurrences which end consumer is a Linux sub-system.

When optee driver initializes, TEE tells whether it supports interrupt
notification services or not.

OP-TEE SMC ABI defines 4 new SMC function IDs for non-secure world to
manage interrupt events:
- OPTEE_SMC_GET_NOTIF_ITR allows non-secure world to retrieve pending
  interrupts by grapes up to 5 lines. For efficiency, the function also
  reports whether there are pending async values targeting suspended
  threaded sequences execution and whether TEE has background threaded
  work to do.
- OPTEE_SMC_NOTIF_ITR_SET_MASK allows Linux irq consumer to mask/unmask
  the irq line using a fastcall SMC (uninterruptible) service.
- OPTEE_SMC_NOTIF_ITR_SET_STATE allows Linux irq consumer to enable and
  disable the irq line using a yielded TEE call.
- OPTEE_SMC_NOTIF_ITR_SET_WAKEUP allows Linux irq consumer to enable
  and disable the wakeup from low power capability of the interrupt.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>

Co-developed-by: Pascal Paillet <p.paillet@foss.st.com>
Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
Co-developed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
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
 drivers/tee/optee/optee_private.h |  10 ++
 drivers/tee/optee/optee_smc.h     | 133 ++++++++++++++++++++-
 drivers/tee/optee/smc_abi.c       | 186 +++++++++++++++++++++++++++++-
 3 files changed, 323 insertions(+), 6 deletions(-)

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
index 73b5e7760d10..f2aa45dfe1d2 100644
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
+#define OPTEE_SMC_SEC_CAP_ITR_NOTIF		BIT(7)
+
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_MASK	GENMASK(23, 8)
+#define OPTEE_SMC_SEC_CAP_MAX_NOTIF_ITR_SHIFT	8
 
 #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES	9
 #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
@@ -426,6 +432,131 @@ struct optee_smc_disable_shm_cache_result {
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
index a1c1fa1a9c28..f90816df3699 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -977,6 +977,99 @@ static int optee_smc_stop_async_notif(struct tee_context *ctx)
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
@@ -991,6 +1084,61 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
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
 static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
@@ -999,9 +1147,14 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
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
 		if (!value_valid)
 			break;
 
@@ -1009,10 +1162,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
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
 
@@ -1048,6 +1202,9 @@ static void optee_smc_notif_uninit_irq(struct optee *optee)
 			free_irq(optee->smc.notif_irq, optee);
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
+
+		if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ITR_NOTIF)
+			irq_domain_remove(optee->smc.domain);
 	}
 }
 
@@ -1187,6 +1344,7 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
 
 static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
 					    u32 *sec_caps, u32 *max_notif_value,
+					    u32 *max_notif_it,
 					    unsigned int *rpc_param_count)
 {
 	union {
@@ -1219,6 +1377,13 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
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
 
@@ -1364,6 +1529,7 @@ static int optee_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	u32 max_notif_value;
+	u32 max_notif_it;
 	u32 arg_cache_flags;
 	u32 sec_caps;
 	int rc;
@@ -1385,7 +1551,7 @@ static int optee_probe(struct platform_device *pdev)
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
-					     &max_notif_value,
+					     &max_notif_value, &max_notif_it,
 					     &rpc_param_count)) {
 		pr_warn("capabilities mismatch\n");
 		return -EINVAL;
@@ -1506,6 +1672,16 @@ static int optee_probe(struct platform_device *pdev)
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

