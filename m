Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36461694221
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBMJ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjBMJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:58:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982CDDBCE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:58:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso10826840wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wh+/knBj/EM1Bbx/gTGM9Sa9YSP8qWOprwPefMlvOGs=;
        b=YqJecM2gVD9EEZ9dfo8mb8B8iTe+rrguu4n8AKVq7UcNW5iv4GyFHSmop9YAt09iGa
         /g4e9bLOVTgQhrL20hGMiqftGOWR7BSTXdduLzeEnWrhiMVjQoK6VcdCGcvHi8RcFFP1
         7SH416stGSkjSKggSknrZg1Gu/rfc//28AazMd1zehPwveV1tirEadSXSHwage5ttbA2
         w7hKz2DU8SCKy6I2CfS/SqkixOQND9cE2P+5E65S1dI8JMa1GegTOiZcHyKNfWk+PIIp
         mBW8P/Ouk7uBhLOcQyYpajwfBy4m+CsWQdb7ZLJU7VJq86HDdnHxy/n9Ajs2ub+3YBYV
         kcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wh+/knBj/EM1Bbx/gTGM9Sa9YSP8qWOprwPefMlvOGs=;
        b=bX1eAJUbIIakUYTnpNB+7YUhPum56R2uXksjfYhfGeV/NIrm7xIOQBVflc2lirRz7P
         zOyDi9BICDfcgWZKTuK1wMrvpvn/Atk+7S4q0Y5C4D/9z1KEiTqy9/FEpSJwqpd0d5y9
         9N1wuNxu2P3e2wCzwsa0PHiVvrsOWQZdgm3O8Nc9C2qXrAhs4uflDLVFiDVuOlkdqGFV
         P2s0TvIVqWXdgUinkEgQS8gJ6+ZtdCHj/9YkGEGLR/jU7ehfmmnZ9HATh8hd5sN1VzNI
         QPsp8baoS71ZY4mBl8j4t7vVj3+99WdB2uP+h3ZtEALNiyVjkYl6C0zY854SINCF9ARk
         8c0A==
X-Gm-Message-State: AO0yUKXAiI/WWWSSt6pa3sGf3tenhKZviUdB2lKJewr00wOOtlskg/bN
        +eFYgxKtc7pcHHIrJrCQNnD7DHHEAFIJE3DP
X-Google-Smtp-Source: AK7set+S1vNTC8u+GNbosXBhFYtV9vJR4MwGNhreFGeZW6wOVfBk4Ld2nfnt6BE9xIaImCI5C8U1/g==
X-Received: by 2002:a05:600c:1609:b0:3dc:53a2:2690 with SMTP id m9-20020a05600c160900b003dc53a22690mr18222308wmn.7.1676282321988;
        Mon, 13 Feb 2023 01:58:41 -0800 (PST)
Received: from lmecxl1178.lme.st.com ([80.215.89.243])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003dd1c45a7b0sm14105801wms.23.2023.02.13.01.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 01:58:41 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v4 2/2] optee: add per cpu asynchronous notification
Date:   Mon, 13 Feb 2023 10:58:29 +0100
Message-Id: <20230213095829.42911-2-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213095829.42911-1-etienne.carriere@linaro.org>
References: <20230213095829.42911-1-etienne.carriere@linaro.org>
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

Implements use of per-cpu irq for optee asynchronous notification.

Existing optee async notif implementation allows OP-TEE world to
raise an interrupt for which Linux optee driver will query pending
events bound to waiting tasks in Linux world or threaded bottom half
tasks to be invoked in TEE world. This change allows the signaling
interrupt to be a per-cpu interrupt as with Arm GIC PPIs.

Using a PPI instead of an SPI is useful when no GIC lines are provisioned
in the chip design for OP-TEE async notifications. Instead of using an
unused GIC SPI for a specific platform, optee can use a common GIC PPI
across platforms.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>

Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
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
 drivers/tee/optee/optee_private.h | 22 +++++++
 drivers/tee/optee/smc_abi.c       | 97 +++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 04ae58892608..e5bd3548691f 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -94,11 +94,33 @@ struct optee_supp {
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
+ */
 struct optee_smc {
 	optee_invoke_fn *invoke_fn;
 	void *memremaped_shm;
 	u32 sec_caps;
 	unsigned int notif_irq;
+	struct optee_pcpu __percpu *optee_pcpu;
+	struct workqueue_struct *notif_pcpu_wq;
+	struct work_struct notif_pcpu_work;
 };
 
 /**
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index a1c1fa1a9c28..eff35f66399e 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -991,9 +991,8 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 	return res.a1;
 }
 
-static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+static irqreturn_t irq_handler(struct optee *optee)
 {
-	struct optee *optee = dev_id;
 	bool do_bottom_half = false;
 	bool value_valid;
 	bool value_pending;
@@ -1016,6 +1015,11 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t notif_irq_handler(int irq, void *dev_id)
+{
+	return irq_handler((struct optee *)dev_id);
+}
+
 static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 {
 	struct optee *optee = dev_id;
@@ -1025,7 +1029,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
 
@@ -1040,12 +1044,97 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
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
+	int cpu;
+	int rc;
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
+	enable_percpu_irq(irq, 0);
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
+	return 0;
+
+err_free_pcpu_irq:
+	disable_percpu_irq(irq);
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
+	disable_percpu_irq(optee->smc.notif_irq);
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

