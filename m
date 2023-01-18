Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602DF67257D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjARRuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjARRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:50:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28934EC57
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:50:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso2153640wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjYSw2n+Ps1iOJAbRHWuOEZaS8GB8SIlpqdkEMs8TMY=;
        b=CJapJn14m/+bbp95Kyo9SGUMzxZCp/hwd1y8DIUfbcRdvhSGO0TmVif35R3TpzCtfh
         2vk8h0Zl1oCeggG5n/iHEJaVwbtkxOPHOx5C8ctpSpBxXlvcGBfH/M/zfyqlO8sId7sA
         2xlOPnDbl0172Rr4Q+xO1U/ZET4yumMTQyGt1oRNLQ0RZ/YmmS83W2YAq0YyAFp9H+Om
         0SBlOwcM4gQqQIuvA0dVQSh8xfJJz+0gjE+R7qBpYcS6XXB80QMQEfw9jwMeDbOiJf2K
         U6Y69vfIv1P2LMoga9MZV2cvQ/VN3ChqBnqHWWhxqxhFF6zbNFk5ZQcn9aQPx7ux+nB8
         4JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjYSw2n+Ps1iOJAbRHWuOEZaS8GB8SIlpqdkEMs8TMY=;
        b=K8C/rKdEJVgQ8ORlCYHPwOkcfiXLzC29uKb4DhMZHqT4b13IzUgpobVh9A6bD1FwyP
         b7GfAYAQRGejOULbSY1qgbYhHnL1qJ1nVNfzsSJPD6/kSHLPRY1TVY+1RZJ9FS72Hhk6
         /J6N5vQJM7s5z33767A1XZZtfUZNB24bln4MttkV1AGspebbBnqXcL83YLseHGfl5k8f
         oIgnacgvO5xon8gpxoiiaiKbvvquE9YVq+y0srpHUzTfaPdBGepjt+H9D5IYk5KfCPfA
         ZCDitm77jUtIiXKs0C8ZDyZaPVLWfVoxBVn8BSFmbsrQ51XT6pYdDAgdJmUT5I8XTOV6
         iVrQ==
X-Gm-Message-State: AFqh2koZ4mKY21ZpZomun4HNsliHl5StBGU1rZNrSVEU8CeB1ENqnwlo
        98suGtKBtZgA00eGyRKLL2Np08Uszo8WpjQF
X-Google-Smtp-Source: AMrXdXui/pL9AQaRfGB+nJ8v6XbmkLiMwkqomyCZ5il8ZXln2vQBhoUydeHqnkxo0/+Y04o+k5oWdw==
X-Received: by 2002:a05:600c:4256:b0:3da:2a78:d7a3 with SMTP id r22-20020a05600c425600b003da2a78d7a3mr7279762wmm.33.1674064206347;
        Wed, 18 Jan 2023 09:50:06 -0800 (PST)
Received: from lmecxl1178.lme.st.com (lfbn-nan-1-1169-52.w86-212.abo.wanadoo.fr. [86.212.112.52])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c7702000000b003d995a704fdsm2503290wmi.33.2023.01.18.09.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:50:05 -0800 (PST)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v2] optee: add per cpu asynchronous notification
Date:   Wed, 18 Jan 2023 18:49:09 +0100
Message-Id: <20230118174909.2049638-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Implements use of per CPU irq for optee asynchronous notification.

Existing optee async notif implementation allows OP-TE world to
raise an interrupt for the Linux optee driver to query pending events
bound to waiting tasks in Linux world or threaded bottom half tasks
to be invoked in TEE world. This change allows the signaling interrupt
to be a per cpu interrupt as with Arm GIC PPIs.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>

Co-developed-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
Changes since v1:
- Fixed missing __percpu attribute reported by kernel test robot.
- Rephrased commit message and added Cc tags.
---
 drivers/tee/optee/optee_private.h |  22 ++++++
 drivers/tee/optee/smc_abi.c       | 107 ++++++++++++++++++++++++++++--
 2 files changed, 124 insertions(+), 5 deletions(-)

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
index a1c1fa1a9c28..ffa3f3aa7244 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -993,12 +993,20 @@ static u32 get_async_notif_value(optee_invoke_fn *invoke_fn, bool *value_valid,
 
 static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 {
-	struct optee *optee = dev_id;
+	struct optee *optee;
 	bool do_bottom_half = false;
 	bool value_valid;
 	bool value_pending;
 	u32 value;
 
+	if (irq_is_percpu_devid(irq)) {
+		struct optee_pcpu __percpu *pcpu = (struct optee_pcpu *)dev_id;
+
+		optee = pcpu->optee;
+	} else {
+		optee = dev_id;
+	}
+
 	do {
 		value = get_async_notif_value(optee->smc.invoke_fn,
 					      &value_valid, &value_pending);
@@ -1011,8 +1019,13 @@ static irqreturn_t notif_irq_handler(int irq, void *dev_id)
 			optee_notif_send(optee, value);
 	} while (value_pending);
 
-	if (do_bottom_half)
-		return IRQ_WAKE_THREAD;
+	if (do_bottom_half) {
+		if (irq_is_percpu_devid(irq))
+			queue_work(optee->smc.notif_pcpu_wq, &optee->smc.notif_pcpu_work);
+		else
+			return IRQ_WAKE_THREAD;
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -1025,7 +1038,7 @@ static irqreturn_t notif_irq_thread_fn(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
+static int init_irq(struct optee *optee, u_int irq)
 {
 	int rc;
 
@@ -1040,12 +1053,96 @@ static int optee_smc_notif_init_irq(struct optee *optee, u_int irq)
 	return 0;
 }
 
+static void notif_pcpu_irq_work_fn(struct work_struct *work)
+{
+	struct optee_smc *optee_smc = container_of(work, struct optee_smc, notif_pcpu_work);
+	struct optee *optee = container_of(optee_smc, struct optee, smc);
+
+	optee_smc_do_bottom_half(optee->ctx);
+}
+
+static int init_pcpu_irq(struct optee *optee, u_int irq)
+{
+	struct optee_pcpu __percpu *optee_pcpu;
+	spinlock_t lock;
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
+	rc = request_percpu_irq(irq, notif_irq_handler,
+				"optee_pcpu_notification", optee_pcpu);
+	if (rc)
+		goto err_free_pcpu;
+
+	spin_lock_init(&lock);
+
+	spin_lock(&lock);
+	enable_percpu_irq(irq, 0);
+	spin_unlock(&lock);
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
+	spin_lock(&lock);
+	disable_percpu_irq(irq);
+	spin_unlock(&lock);
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
+	spinlock_t lock;
+
+	spin_lock_init(&lock);
+	spin_lock(&lock);
+	disable_percpu_irq(optee->smc.notif_irq);
+	spin_unlock(&lock);
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

