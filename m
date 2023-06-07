Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8E725FE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjFGMrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjFGMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DB173B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1bb2fc9c6so54981561fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142021; x=1688734021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnl75L/jIOZbJGtPwlZuWXFsaT9kJazt/NZQp8DGAaQ=;
        b=hNyP8cGDfve47KPEBrLpMy1p2yF0gXfx/ce73tAUU3dTRz3CZ1o5QRmrXqHQEuWxuI
         eHtocsXsILg7cyvCEuWsXqkcly82TD5pZ6oa8w0sMDjnQX2eXUJhqvaMjsWCIn5zEcPv
         Awi5PugG8WHXKONksbZ/RQtKbELk66GIR+Lw6fbMwINntkDBlVBr5XsTvMigpB0AOJNH
         Lpcgt/2AvVqhCoTAb0RqxZ065koVG+4H1BuZMANxEaMBmWw/7LmbyAtra8KQlulnmk72
         A3dsQc4eu7LE5Efpghejkw/M1mAIEH4xioquHAOtjOgEOYRXCyv7+9Rt666kS7a+VR2m
         X9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142021; x=1688734021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wnl75L/jIOZbJGtPwlZuWXFsaT9kJazt/NZQp8DGAaQ=;
        b=lxEZD8bgc0ZJRi02qeOfW2yB22h3KIuAzU8d5VBRTKSaCMmY76n1rPuZMR/oQ/yGUj
         UjI33PvUwDxPRAi7WL26fmuQ24SbBxnjf8enOZACpZsV05ZvPNmpj6NSdi3ad9vHCto7
         LiioN+IpOhHGpTxmMUacb2ef4z83obhxHQSK1gVW0kIqp0zRX6gKdBEou9WIs1N5HAE1
         6kHZGMrwYtK3fLz9eHjltiM3sfDqSAe3828iwzkLcFIIH+NAWWsVlw8CPzmsDiK+N72W
         jNO2DZE4rwwnrtNi3502AZvMwuovUXjdlAgmfPglm5qYBTRJXiGzIlqdbg5bkvnoSXt2
         x9MA==
X-Gm-Message-State: AC+VfDySIe7XT/S2QsE5OY5WGJdjXcqCIQW0yq0I3avBfQbksScr+lP4
        COaAT8Omjm2n6rCOvCB6kdyJ5g==
X-Google-Smtp-Source: ACHHUZ7G70szt+FanJ5JBAKKK7ROhnMx8ok02Z1vo1w6BngcOT1BjrYwHTDc4iXjlzTSh1O7cM/U6Q==
X-Received: by 2002:a2e:9616:0:b0:2b1:e5d8:d008 with SMTP id v22-20020a2e9616000000b002b1e5d8d008mr2008954ljh.37.1686142020968;
        Wed, 07 Jun 2023 05:47:00 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
Date:   Wed,  7 Jun 2023 14:46:17 +0200
Message-Id: <20230607124628.157465-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
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

Most scmi_perf_proto_ops are already using an "u32 domain" as an
in-parameter to indicate what performance domain we shall operate upon.
However, some of the ops are using a "struct device *dev", which means an
an additional OF parsing is needed each time the perf ops gets called, to
find the corresponding domain-id.

To avoid a potential unnecessary OF parsing, but also to make the code more
consistent, let's replace the in-parameter "struct device *dev" with an
"u32 domain". Note that, this requires us to make some corresponding
changes to the scmi cpufreq driver, so let's do that too.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c   | 14 +++++++++-----
 drivers/firmware/arm_scmi/perf.c | 18 +++++-------------
 include/linux/scmi_protocol.h    |  6 +++---
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 7d05d48c0337..125e8a8421fb 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -137,7 +137,7 @@ scmi_get_cpu_power(struct device *cpu_dev, unsigned long *power,
 
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret, nr_opp;
+	int ret, nr_opp, domain;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scmi_data *priv;
@@ -149,6 +149,10 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return -ENODEV;
 	}
 
+	domain = scmi_cpu_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -187,7 +191,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	  */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		ret = perf_ops->device_opps_add(ph, cpu_dev);
+		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opps to the device\n");
 			goto out_free_cpumask;
@@ -220,7 +224,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	priv->cpu_dev = cpu_dev;
-	priv->domain_id = scmi_cpu_domain_id(cpu_dev);
+	priv->domain_id = domain;
 
 	policy->driver_data = priv;
 	policy->freq_table = freq_table;
@@ -228,14 +232,14 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	/* SCMI allows DVFS request for any domain from any CPU */
 	policy->dvfs_possible_from_any_cpu = true;
 
-	latency = perf_ops->transition_latency_get(ph, cpu_dev);
+	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
 		latency = CPUFREQ_ETERNAL;
 
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible =
-		perf_ops->fast_switch_possible(ph, cpu_dev);
+		perf_ops->fast_switch_possible(ph, domain);
 
 	return 0;
 
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 216bcd68d549..563fa44b1a71 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -593,18 +593,14 @@ static int scmi_dev_domain_id(struct device *dev)
 }
 
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
-				     struct device *dev)
+				     struct device *dev, u32 domain)
 {
-	int idx, ret, domain;
+	int idx, ret;
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	domain = scmi_dev_domain_id(dev);
-	if (domain < 0)
-		return domain;
-
 	dom = pi->dom_info + domain;
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
@@ -626,14 +622,10 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 
 static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
-				 struct device *dev)
+				 u32 domain)
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	int domain = scmi_dev_domain_id(dev);
-
-	if (domain < 0)
-		return domain;
 
 	dom = pi->dom_info + domain;
 	/* uS to nS */
@@ -693,12 +685,12 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 }
 
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
-				      struct device *dev)
+				      u32 domain)
 {
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	dom = pi->dom_info + scmi_dev_domain_id(dev);
+	dom = pi->dom_info + domain;
 
 	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
 }
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 99c3e985c40f..34ecaeeb51bc 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -136,9 +136,9 @@ struct scmi_perf_proto_ops {
 			 u32 *level, bool poll);
 	int (*device_domain_id)(struct device *dev);
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
-				      struct device *dev);
+				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-			       struct device *dev);
+			       struct device *dev, u32 domain);
 	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
@@ -146,7 +146,7 @@ struct scmi_perf_proto_ops {
 	int (*est_power_get)(const struct scmi_protocol_handle *ph, u32 domain,
 			     unsigned long *rate, unsigned long *power);
 	bool (*fast_switch_possible)(const struct scmi_protocol_handle *ph,
-				     struct device *dev);
+				     u32 domain);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
 };
 
-- 
2.34.1

