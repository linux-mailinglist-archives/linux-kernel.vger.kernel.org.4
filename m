Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478276C4B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCVNWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCVNWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:22:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C07527497
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:22:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t15so17048913wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679491338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENfXvmOGL5vIB8CbuQoa7P0A6qSNAoya8SLjspFiA/w=;
        b=Cy9+IQSovjf0UhzGuT+GvAHgM+t21Cz1V84/2G6thvVeQJ+5LnO8ISSu6TYZJyfISA
         Ov3Mkbx+FPTa4TQOjuhVTh5ugLAByjYt6dCM/dNCIgqyd5gDioo9Ga0ON8MDVMND9z6I
         vGkE9ZJSXH9Nhkz8EXMeVkxl8Ffa9po6T/wo89f8C0RphZqHNVQzB3RZFaJ3XQkISnCh
         yQwNltw1TsDSmdr6WvmVtiJoPfUM46Vncj+qP1qmwLYwFAozINx0Q3iGHAdGfKUg7Dee
         FHK+y+CXnceyL8ErmZoCaLSkutdh1EPUw+uYM/1sgByWGgEBdiHxAZDN+CW3uCRdc57L
         98sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENfXvmOGL5vIB8CbuQoa7P0A6qSNAoya8SLjspFiA/w=;
        b=gB8vsPp9k0Ml/no7HbmSB2m7RAcpEKO8WUQgP81U02DyVQr3yze8ta9vAUX2sKnSLZ
         6bCQPwYwC1ZWwcPkV0RkjMQBUDMDwSdqp7MbLgfGw7/z/31sZv5WMS6z4dSvWJaVctiu
         LwKzzsg4VScwjQ9B9x5yF3SfkR2wlgiGZF37cCKmJdz0OSWV8OcHgcH0H/vX601yTVW6
         +3Z6CfoAeSSpHO9/0HtdTKWI56Rn3yN0Ldsnhm76Q+Nvpxl8ZjK2hFM1tpavfRb/SPeV
         id73fndny8UCc1TJ9w1nmTN1l8MqjbED4Ub/KvWOOm0ArvVObCAa2tD9t+tR+5161XBM
         P4Zg==
X-Gm-Message-State: AO0yUKVd4B1spCL1/xfv6iDQbMBjVn85Lpi82EB6BGkNHfXHdQEJBpmZ
        vuVP6r/2m53+Ysmvt3iDfyjOUmEaxONd47ibxXc=
X-Google-Smtp-Source: AK7set/DeUiHYzqELuLUmycuvSEbjgaVaMiklVNIAkai6QIXqhnCQeoqS4vHo2Hbgcrz1TOma1gAOw==
X-Received: by 2002:adf:ea42:0:b0:2d2:39d3:ce78 with SMTP id j2-20020adfea42000000b002d239d3ce78mr5093853wrn.10.1679491338464;
        Wed, 22 Mar 2023 06:22:18 -0700 (PDT)
Received: from lmecxl1178.lme.st.com ([2a04:cec0:1013:81e9:8520:c2b5:32d0:9bd9])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe30f000000b002c706c754fesm13867142wrj.32.2023.03.22.06.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:22:18 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v6 2/2] optee: add per cpu asynchronous notification
Date:   Wed, 22 Mar 2023 14:22:12 +0100
Message-Id: <20230322132212.3646972-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322132212.3646972-1-etienne.carriere@linaro.org>
References: <20230322132212.3646972-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes since v5:
- Removed spurious __percpu attributes reported by kernel test robot
  (https://lore.kernel.org/lkml/202303190039.RsU7kCIu-lkp@intel.com/).

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
 drivers/tee/optee/smc_abi.c       | 122 +++++++++++++++++++++++++++++-
 2 files changed, 142 insertions(+), 4 deletions(-)

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
index a1c1fa1a9c28..de7ac9a46354 100644
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
 
@@ -1040,12 +1063,103 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
 	return 0;
 }
 
+static irqreturn_t notif_pcpu_irq_handler(int irq, void *dev_id)
+{
+	struct optee_pcpu *pcpu = dev_id;
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
+	for_each_present_cpu(cpu)
+		per_cpu_ptr(optee_pcpu, cpu)->optee = optee;
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

