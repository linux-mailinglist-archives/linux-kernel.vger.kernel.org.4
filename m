Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527446BEFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCQR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCQR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:29:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C92399FC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:29:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er8so11513871edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679074143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RN/6059EmJ8uecEffZz5gMIvnjjePGQHRIIWUkBdNM=;
        b=Ut/RR2xA56vEYKrKuS7gEo2q7AVA0iFdxzfP2WAnh6Ag7Ja3e9TZZyuNBuXkY2/RaA
         bWYJAMWbSkEVCwpz0K6Or0TamzEPRMgnKA8NmsmgxUq3uBQk0P/h6FAl4SvTdAgqicb4
         Tcx4OU8+A60lqCbJjZdCn6e8O3cIscx+VnzYYZyAn+/gD5tEPrs7xR0t5YUSrIFg/TIM
         WaKe/2CjwBdoxq+gCFwfFmmfWssB3hONH25pIKGz0dqbHD8iV5nsIIsPcMFoICPW4PEK
         cGBRSZFJY5HmHAt+hR5S2tzISVr/7xV3CEVeQZG1Dntr6fgV/HQ+GeCPIbCobPbfL4K9
         PNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679074143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RN/6059EmJ8uecEffZz5gMIvnjjePGQHRIIWUkBdNM=;
        b=hnHLUz49MJ/GGO4+2zspCTpq0t6kZehgV8cide5d4vzOwPq8rKixpBXmMT1mAxP0Eo
         DkP37I2Px9DgF9H23PgydzQ1QDNn5XVBAnA0lpGWRJHKSxkwADyaCgyj6gSGiHBQ88pw
         y+IX8ZtqW674Xea4Grf80msYhjVvDHU0VFWYyi+/0t9EIZdASUEdxC3PGeJm/G3T4BES
         +eSMAomsqbECGNQTTF6JR5IqtQJ9/JvBIDNDtG2TcVVGzspxIJ8RuWBONiFTcYN6XJC5
         IWHlM99HFR43hUVoRKZB8RD8KWF1FeuJocs70TXc1XSuFf/XbK8sCcUGTvYvFZqkNTNP
         FSgg==
X-Gm-Message-State: AO0yUKXI78Q4zGlZyIBuhsID/m8LJzX2EEwOOCi9LNE0o5ZQ95nnN6rQ
        mLs5d4508BQm37oR3Hmh9x5ZQAXNRMv2plbQUjo=
X-Google-Smtp-Source: AK7set/x889DPM/ZzoOHbdJRs3xuOvqtj4A/489Wofixk5wHGFBTaj30HKkNa1g01923INNvo9kijg==
X-Received: by 2002:a17:906:849a:b0:931:cac0:60ec with SMTP id m26-20020a170906849a00b00931cac060ecmr114338ejx.48.1679074143629;
        Fri, 17 Mar 2023 10:29:03 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:10af:6120:4312:7f15:6b35:a247])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00914001c91fcsm1200089ejc.86.2023.03.17.10.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:29:03 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v5 2/2] optee: add per cpu asynchronous notification
Date:   Fri, 17 Mar 2023 18:28:59 +0100
Message-Id: <20230317172859.989650-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230317172859.989650-1-etienne.carriere@linaro.org>
References: <20230317172859.989650-1-etienne.carriere@linaro.org>
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

Implements use of per-cpu irq for optee asynchronous notification.

Existing optee async notif implementation allows OP-TEE world to
raise an interrupt on which Linux optee driver will query some pending
events. This change allows the signaling interrupt to be a per-cpu
interrupt as with Arm GIC PPIs. Using a PPI instead of an SPI is useful
when no GIC lines are provisioned in the chip design and there are spare
PPI lines.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>

Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v4:
- Used cpuhp_setup_state()/cpuhp_remove_state() to enable/disable the
  per-cpu interrupt and let CPU hotplug also manage it.
- Added a call to destroy_workqueue() that was missing in uninit_pcpu_irq().
- Rephrased commit message.

Changes since v3:
- Fixed typo in commit message.
- Added few words in commit message about why we do this change.
- Appended a 2nd commit to the series for request DT bindings update.

Changes since v2:
- Irq and per-cpu irq no more share the primary same handler function
  but have a common irq_handler() helper function.
- Removed useless spinlocks.
- Wrapped lines > 80 char.

Changes since v1:
- Fixed missing __percpu attribute reported by kernel test robot.
- Rephrased commit message and added Cc tags.
---
 drivers/tee/optee/optee_private.h |  24 ++++++
 drivers/tee/optee/smc_abi.c       | 125 +++++++++++++++++++++++++++++-
 2 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 04ae58892608..6129d43dd354 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -94,11 +94,35 @@ struct optee_supp {
 	struct completion reqs_c;
 };
 
+/*
+ * struct optee_pcpu - per cpu notif private struct passed to work functions
+ * @optee		optee device reference
+ */
+struct optee_pcpu {
+	struct optee *optee;
+};
+
+/*
+ * struct optee_smc - optee smc communication struct
+ * @invoke_fn		handler function to invoke secure monitor
+ * @memremaped_shm	virtual address of memory in shared memory pool
+ * @sec_caps:		secure world capabilities defined by
+ *			OPTEE_SMC_SEC_CAP_* in optee_smc.h
+ * @notif_irq		interrupt used as async notification by OP-TEE or 0
+ * @optee_pcpu		per_cpu optee instance for per cpu work or NULL
+ * @notif_pcpu_wq	workqueue for per cpu aynchronous notification or NULL
+ * @notif_pcpu_work	work for per cpu asynchronous notification
+ * @notif_cpuhp_state   CPU hotplug state assigned for pcpu interrupt management
+ */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
 	void *memremaped_shm;
 	u32 sec_caps;
 	unsigned int notif_irq;
+	struct optee_pcpu __percpu *optee_pcpu;
+	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
+	unsigned int notif_cpuhp_state;
 };
 
 /**
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..a2473fbe2461 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -52,6 +52,23 @@
  */
 #define OPTEE_MIN_STATIC_POOL_ALIGN    9 /* 512 bytes aligned */
 
+/* SMC ABI considers at most a single TEE firmware */
+static unsigned int pcpu_irq_num;
+
+static int optee_cpuhp_enable_pcpu_irq(unsigned int cpu)
+{
+	enable_percpu_irq(pcpu_irq_num, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int optee_cpuhp_disable_pcpu_irq(unsigned int cpu)
+{
+	disable_percpu_irq(pcpu_irq_num);
+
+	return 0;
+}
+
 /*
  * 1. Convert between struct tee_param and struct optee_msg_param
  *
@@ -991,9 +1008,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 	return res.a1;
 }
 
-static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+static irqreturn_t irq_handler(struct optee *optee)
 {
-	struct optee *optee = dev_id;
 	bool do_bottom_half = false;
 	bool value_valid;
 	bool value_pending;
@@ -1016,6 +1032,13 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+{
+	struct optee *optee = dev_id;
+
+	return irq_handler(optee);
+}
+
 static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
@@ -1025,7 +1048,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
 
@@ -1040,12 +1063,106 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
 	return 0;
 }
 
+static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
+{
+	struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
+	struct optee *optee = pcpu->optee;
+
+	if (irq_handler(optee) == IRQ_WAKE_THREAD)
+		queue_work(optee->smc.notif_pcpu_wq,
+			   &optee->smc.notif_pcpu_work);
+
+	return IRQ_HANDLED;
+}
+
+static void notif_pcpu_irq_work_fn(struct work_struct *work)
+{
+	struct optee_smc *optee_smc = container_of(work, struct optee_smc,
+						   notif_pcpu_work);
+	struct optee *optee = container_of(optee_smc, struct optee, smc);
+
+	optee_smc_do_bottom_half(optee->ctx);
+}
+
+static int init_pcpu_irq(struct optee *optee, u_int irq)
+{
+	struct optee_pcpu __percpu *optee_pcpu;
+	int cpu, rc;
+
+	optee_pcpu = alloc_percpu(struct optee_pcpu);
+	if (!optee_pcpu)
+		return -ENOMEM;
+
+	for_each_present_cpu(cpu) {
+		struct optee_pcpu __percpu *p = per_cpu_ptr(optee_pcpu, cpu);
+
+		p->optee = optee;
+	}
+
+	rc = request_percpu_irq(irq, notif_pcpu_irq_handler,
+				"optee_pcpu_notification", optee_pcpu);
+	if (rc)
+		goto err_free_pcpu;
+
+	INIT_WORK(&optee->smc.notif_pcpu_work, notif_pcpu_irq_work_fn);
+	optee->smc.notif_pcpu_wq = create_workqueue("optee_pcpu_notification");
+	if (!optee->smc.notif_pcpu_wq) {
+		rc = -EINVAL;
+		goto err_free_pcpu_irq;
+	}
+
+	optee->smc.optee_pcpu = optee_pcpu;
+	optee->smc.notif_irq = irq;
+
+	pcpu_irq_num = irq;
+	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "optee/pcpu-notif:starting",
+			       optee_cpuhp_enable_pcpu_irq,
+			       optee_cpuhp_disable_pcpu_irq);
+	if (!rc)
+		rc = -EINVAL;
+	if (rc < 0)
+		goto err_free_pcpu_irq;
+
+	optee->smc.notif_cpuhp_state = rc;
+
+	return 0;
+
+err_free_pcpu_irq:
+	free_percpu_irq(irq, optee_pcpu);
+err_free_pcpu:
+	free_percpu(optee_pcpu);
+
+	return rc;
+}
+
+static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+{
+	if (irq_is_percpu_devid(irq))
+		return init_pcpu_irq(optee, irq);
+	else
+		return init_irq(optee, irq);
+}
+
+static void uninit_pcpu_irq(struct optee *optee)
+{
+	cpuhp_remove_state(optee->smc.notif_cpuhp_state);
+
+	destroy_workqueue(optee->smc.notif_pcpu_wq);
+
+	free_percpu_irq(optee->smc.notif_irq, optee->smc.optee_pcpu);
+	free_percpu(optee->smc.optee_pcpu);
+}
+
 static void optee_smc_notif_uninit_irq(struct optee *optee)
 {
 	if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_ASYNC_NOTIF) {
 		optee_smc_stop_async_notif(optee->ctx);
 		if (optee->smc.notif_irq) {
-			free_irq(optee->smc.notif_irq, optee);
+			if (irq_is_percpu_devid(optee->smc.notif_irq))
+				uninit_pcpu_irq(optee);
+			else
+				free_irq(optee->smc.notif_irq, optee);
+
 			irq_dispose_mapping(optee->smc.notif_irq);
 		}
 	}
-- 
2.25.1

