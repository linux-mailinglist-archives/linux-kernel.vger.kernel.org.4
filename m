Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B962D2CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiKQFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiKQFcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:32:17 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD995D683
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:15 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so998905pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 21:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/wG+QZxohAkdtGSCZUjkm9USP+zFO96InHp16ZHrwI=;
        b=ixACoPOpJAo1XabXh0ai5MRohX1nfzDnP+c3V/0XnhmxGFg9bQBQKfx+bZehp287Iw
         tA3P29CfXHaYoVJc84FH804TqJsKSMCHH+XEKIP8es2QGKWIF6FaPN6T06uxw5ElSWor
         uC858F1alnV9dw8S4CnNniwA4xXYNdRYDBuhKAp/c0zFibfw8o5w5cCUZQ3C2HiVXZXP
         u7s9g9NjsbtZ6eouMmxS5QE3oG9Q9tb0Mt0azDxuaPIi0uSDAsaDBjil3E/ohOPY1IuR
         qGu0f/xw32dKzdn6OD6Gso6yELEF3y7GOjJ+3xZj4QZjic7iii/3BT/MwI+xE8deUsnQ
         A1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/wG+QZxohAkdtGSCZUjkm9USP+zFO96InHp16ZHrwI=;
        b=bRW4QCq8uhEj7er4NkJO13diAw4+Uc2NL9bbUerF5/AEq7PzM1+MBV91tfByJs+2pg
         qqq1T7BWAihVm9XZHWGnD7HraK0h0gPVj/p+IErCeoeSdUJMKqaG4A2boP6DIbdwJ2Rl
         ecHmkmyIdqzlhuLcEIetXHfh0Fd6qvPb+Z6EdvqtsIU+VEsOiQFDecPf4dGjgPuM6Sqi
         4cvDuK0sAMUOiBCXZPLDXeGyOUjr3HPVk1MA/cxV7ltWeYvWDcHiX9f38FdNjLAvuUIq
         Ibm6TNcnyrZhuRkg4RlXTt6BEgOrGpnHPS+87ERUCJPbJ0bGJyGZN+mHyVxs1qLYkSu4
         O+vQ==
X-Gm-Message-State: ANoB5pk0iZgV3fuLJOC1haeHs3UWdjddlg6BPrJN9ae1MwBLfD97lPez
        0WjGenF5qFdHYXQZNJWN8rmw
X-Google-Smtp-Source: AA0mqf58iastmjBB+zzq+C4PzyZynXX4kCV+//2vj/rUp30PGh3mRnFTGwdxVoLZwfLF7t7g/CesdA==
X-Received: by 2002:a05:6a00:1a48:b0:56c:b4d3:906e with SMTP id h8-20020a056a001a4800b0056cb4d3906emr1510909pfv.10.1668663134822;
        Wed, 16 Nov 2022 21:32:14 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001865c298588sm96600plh.258.2022.11.16.21.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 21:32:13 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v7 4/4] cpufreq: qcom-hw: Fix the frequency returned by cpufreq_driver->get()
Date:   Thu, 17 Nov 2022 11:01:45 +0530
Message-Id: <20221117053145.10409-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
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

The cpufreq_driver->get() callback is supposed to return the current
frequency of the CPU and not the one requested by the CPUFreq core.
Fix it by returning the frequency that gets supplied to the CPU after
the DCVS operation of EPSS/OSM.

Cc: stable@vger.kernel.org # v5.15
Fixes: 2849dd8bc72b ("cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver")
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 42 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 1faa325d3e52..62f36c76e26c 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -131,7 +131,35 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
 	return 0;
 }
 
+static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
+{
+	unsigned int lval;
+
+	if (qcom_cpufreq.soc_data->reg_current_vote)
+		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_current_vote) & 0x3ff;
+	else
+		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_domain_state) & 0xff;
+
+	return lval * xo_rate;
+}
+
+/* Get the current frequency of the CPU (after throttling) */
 static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	struct qcom_cpufreq_data *data;
+	struct cpufreq_policy *policy;
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy)
+		return 0;
+
+	data = policy->driver_data;
+
+	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
+}
+
+/* Get the frequency requested by the cpufreq core for the CPU */
+static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
 {
 	struct qcom_cpufreq_data *data;
 	const struct qcom_cpufreq_soc_data *soc_data;
@@ -292,18 +320,6 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	}
 }
 
-static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
-{
-	unsigned int lval;
-
-	if (qcom_cpufreq.soc_data->reg_current_vote)
-		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_current_vote) & 0x3ff;
-	else
-		lval = readl_relaxed(data->base + qcom_cpufreq.soc_data->reg_domain_state) & 0xff;
-
-	return lval * xo_rate;
-}
-
 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 {
 	struct cpufreq_policy *policy = data->policy;
@@ -347,7 +363,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	 * If h/w throttled frequency is higher than what cpufreq has requested
 	 * for, then stop polling and switch back to interrupt mechanism.
 	 */
-	if (throttled_freq >= qcom_cpufreq_hw_get(cpu))
+	if (throttled_freq >= qcom_cpufreq_get_freq(cpu))
 		enable_irq(data->throttle_irq);
 	else
 		mod_delayed_work(system_highpri_wq, &data->throttle_work,
-- 
2.25.1

