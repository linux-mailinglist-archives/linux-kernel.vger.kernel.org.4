Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A839F6319F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 07:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiKUG6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 01:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 01:58:08 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9A4175A4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:57:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b29so10488246pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 22:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mZ6c9B+MTBQ1H/yMw/9kXxvINGVHAlkajRU3PsyXaY=;
        b=G3TMl2eTdkPNF2LtnqQnjD4N0jCXMSky0n6x3VV/ZqMoPkq4rXR85A1Fh6lFd0jAE+
         KVARYXc1Ittrv3IMmApJdRfqmQz1J0WM9jLK3Rx4D1kIQXjp9ch9UmacL7xcm5dnfzWe
         0ygdXWZwRxIWE5wdlCaBkUWJRSEiq1V5qyjgwwMUKtdH03Oltwk1tUMQOGvoosWVOEEi
         Gv1wzyqLCwUmCNEhZAsSv1SwujZiG1YievpeIGH8wCyrf1GyhDKZEw8gdB8EK/ttgQju
         li4rsnc1W/XZjhxnLV0zS6xQKpJKieTak+rcWnf1aswzj/sY5fw8qHwhX4Trjm8vNJph
         7e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mZ6c9B+MTBQ1H/yMw/9kXxvINGVHAlkajRU3PsyXaY=;
        b=fzeLoI0f52pqkqOXbl30xIzK6442RqZmesqtezFh/t9j98Mq56JyCJddljknIYETpG
         8IgneUOYo5jSiB5obkpg4kurs6E8YbOl+RKkPL8sKSZ2K7SSzqh6LAQkByQ/3q3ueNbJ
         nZldwE1FYuQNCrHZbqdODtOKXsr+oVyW5PkX0mDBau4Bmv3iXghkMhNNr4FopAv7T+FS
         g0aB7qGnqUHY4NscfPZtpBzdKPfS4P6dIZR0iVfs5O1jSR4yVTT88RNMQaAfW8D2hddm
         3rljDgQPd61ZwY6iddOehbharFE2fl+EBWH43XYSMynH7MJ393sh4sTVOiO03G8QYSJl
         5uOw==
X-Gm-Message-State: ANoB5pnp6O5JsHFK3JNV/3WidXqoWR0m8tHNYfqGDDEwEiQmr5kS59+/
        O5aMbiAq/vn2/wGwzb8d1WTGug==
X-Google-Smtp-Source: AA0mqf5OS17NGoXZU3JFtFoCyDvC6ENwVsYwBRlnHgbRGJn5PCl7zNsQxnEoVEboCZTsaGBTuh2kZQ==
X-Received: by 2002:a63:5d0d:0:b0:43c:6413:322c with SMTP id r13-20020a635d0d000000b0043c6413322cmr2930098pgb.472.1669013877304;
        Sun, 20 Nov 2022 22:57:57 -0800 (PST)
Received: from localhost ([122.172.85.60])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709027e4600b0017f36638010sm8700302pln.276.2022.11.20.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 22:57:56 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        johan@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: qcom-cpufreq-hw: Register config_clks helper
Date:   Mon, 21 Nov 2022 12:27:47 +0530
Message-Id: <93bd5ab5346e4f22cd9db78afa778b2060d5741a.1669012140.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1669012140.git.viresh.kumar@linaro.org>
References: <cover.1669012140.git.viresh.kumar@linaro.org>
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

In qcom-cpufreq-hw driver, we want to skip clk configuration that
happens via dev_pm_opp_set_opp(), but still want the OPP core to parse
the "opp-hz" property so we can use the freq based OPP helpers.

The OPP core provides support for the platforms to provide config_clks
helpers now, lets use that to provide an empty callback to skip clock
configuration.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 34 ++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 1bd1e9ae5308..5f8079898940 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -51,6 +51,7 @@ struct qcom_cpufreq_data {
 	 */
 	struct mutex throttle_lock;
 	int throttle_irq;
+	int opp_token;
 	char irq_name[15];
 	bool cancel_throttle;
 	struct delayed_work throttle_work;
@@ -58,7 +59,6 @@ struct qcom_cpufreq_data {
 	struct clk_hw cpu_clk;
 
 	bool per_core_dcvs;
-
 	struct freq_qos_request throttle_freq_req;
 };
 
@@ -197,6 +197,15 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
 	return policy->freq_table[index].frequency;
 }
 
+static int qcom_cpufreq_hw_config_clks(struct device *dev,
+				       struct opp_table *opp_table,
+				       struct dev_pm_opp *opp, void *data,
+				       bool scaling_down)
+{
+	/* We want to skip clk configuration via dev_pm_opp_set_opp() */
+	return 0;
+}
+
 static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 				    struct cpufreq_policy *policy)
 {
@@ -208,11 +217,23 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	int ret;
 	struct qcom_cpufreq_data *drv_data = policy->driver_data;
 	const struct qcom_cpufreq_soc_data *soc_data = qcom_cpufreq.soc_data;
+	const char * const clk_names[] = { NULL, NULL };
+	struct dev_pm_opp_config config = {
+		.clk_names = clk_names,
+		.config_clks = qcom_cpufreq_hw_config_clks,
+	};
 
 	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
 	if (!table)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_set_config(cpu_dev, &config);
+	if (ret < 0) {
+		dev_err(cpu_dev, "Failed to set OPP config: %d\n", ret);
+		goto free_table;
+	}
+	drv_data->opp_token = ret;
+
 	ret = dev_pm_opp_of_add_table(cpu_dev);
 	if (!ret) {
 		/* Disable all opps and cross-validate against LUT later */
@@ -227,8 +248,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 		}
 	} else if (ret != -ENODEV) {
 		dev_err(cpu_dev, "Invalid opp table in device tree\n");
-		kfree(table);
-		return ret;
+		goto clear_config;
 	} else {
 		policy->fast_switch_possible = true;
 		icc_scaling_enabled = false;
@@ -296,6 +316,13 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
 	dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
 
 	return 0;
+
+clear_config:
+	dev_pm_opp_clear_config(drv_data->opp_token);
+
+free_table:
+	kfree(table);
+	return ret;
 }
 
 static void qcom_get_related_cpus(int index, struct cpumask *m)
@@ -594,6 +621,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_remove_all_dynamic(cpu_dev);
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
+	dev_pm_opp_clear_config(data->opp_token);
 	kfree(policy->freq_table);
 	kfree(data);
 	iounmap(base);
-- 
2.31.1.272.g89b43f80a514

