Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4A7725FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbjFGMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbjFGMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE32A210A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:47:16 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f63a2e1c5fso2093915e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686142035; x=1688734035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/Lsn91+ee3WkHkcIZxtEhxNatDc00drhhG6bof7lRA=;
        b=b88t5sq2oobU4xV66g5hQD7/yWbCE3+/kZV4AVkDBxs8BYhtS9SqZhGew6mJ39ScmZ
         UEfzMVzg2eOs1nm15ycXtIaTxTFCobvHCGqqfYBt2eG++tYgP+wLqJX3ezEz0PWwIiWe
         caJn4bnpQ3OwmXG6VPSkzTc/iRiFb0n81Fc776q3XBsmgKKLAeHTL56rx7AvAADaghDj
         AceOHOFeHGf0Mxpl/Uix5o+8bRPHlo5UIbYGSDzX7beL6EYaYpN59GNhyXh8ufhee7k+
         sib9eQ2X0qXGziJIPmZlKGWKLpgeyL8BCSfqll2ToTGoQVs4NQOizC9HE5pUB4d38bWj
         CDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142035; x=1688734035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/Lsn91+ee3WkHkcIZxtEhxNatDc00drhhG6bof7lRA=;
        b=Nnl7rbUy1En1rp8FKQ3jp+NfrugQTL9Bkqf0jlgT8fyji7AY1fUWjPyLG4giaP8pD3
         rChY9XgCYdjRFaGGoEN441zO7FKDgtD/qOaaFaxiiYv+ji6/R1CuQvkm1FPdoiqW5EuU
         Cu2uXf1Dq2UJ6qcYYN7QbtUReDwPUKuBMbEZhlkRytf/ojUQuX/MMDTiSVGsrpuV2R8+
         xd9Ghk9wAR+Bm3nYSR/AQltl/G8TWh3BraLwvopVZpmbL1m6UmmhXxJkzAFDigcMWmpP
         ZHvUrkNppYxxcXCbnvjpS/T5vY2lvSZTZQkWGtlXftGZ0NpEsTlwtsOQrDx0ilX5N/N/
         PNCg==
X-Gm-Message-State: AC+VfDz0OGO4FXgVfr1Tm2SCDfL6o1XjY9eNMLht5C3HuEQK40JSZOAc
        YA/E+VP12ErdaPXq6Log+skLwQ==
X-Google-Smtp-Source: ACHHUZ4PSgErdZ8NJTs0chVMfI9TMPT7A9df2ZIGBR9gdsMW36zPyxZu26pNz17IAR/DKjBDG06eBg==
X-Received: by 2002:ac2:4a7c:0:b0:4f3:a99f:1ea7 with SMTP id q28-20020ac24a7c000000b004f3a99f1ea7mr1887107lfp.55.1686142035009;
        Wed, 07 Jun 2023 05:47:15 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id z7-20020a19f707000000b004f4b3e9e0cesm1781708lfe.297.2023.06.07.05.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 05:47:14 -0700 (PDT)
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
Subject: [PATCH 15/16] firmware: arm_scmi: Extend perf support with OPP from genpd providers
Date:   Wed,  7 Jun 2023 14:46:27 +0200
Message-Id: <20230607124628.157465-16-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable a genpd provider to add OPPs for its attached devices,  let's
convert into using the dev_pm_opp_add_dynamic() API, in favor of the
current dev_pm_opp_add() API. This allows us to specify the frequency, the
performance level and the OPP provider type for each OPP that it may be
adding.

Moreover, to let callers of the ->device_opps_add() ops, to specify the OPP
provider let's add a new in-parameter to it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c   |  2 +-
 drivers/firmware/arm_scmi/perf.c | 15 ++++++++++-----
 include/linux/scmi_protocol.h    |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 78f53e388094..a3f89a4ca899 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -188,7 +188,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	  */
 	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
 	if (nr_opp <= 0) {
-		ret = perf_ops->device_opps_add(ph, cpu_dev, domain);
+		ret = perf_ops->device_opps_add(ph, cpu_dev, domain, false);
 		if (ret) {
 			dev_warn(cpu_dev, "failed to add opps to the device\n");
 			goto out_free_cpumask;
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index 03a496ccc603..b6cebe45fbc8 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -581,21 +581,26 @@ static void scmi_perf_domain_init_fc(const struct scmi_protocol_handle *ph,
 }
 
 static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
-				     struct device *dev, u32 domain)
+				     struct device *dev, u32 domain, bool genpd)
 {
 	int idx, ret;
-	unsigned long freq;
+	struct dev_pm_opp_data opp_data;
 	struct perf_dom_info *dom;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	dom = pi->dom_info + domain;
 
 	for (idx = 0; idx < dom->opp_count; idx++) {
-		freq = dom->opp[idx].perf * dom->mult_factor;
+		memset(&opp_data, 0, sizeof(opp_data));
+		opp_data.level = dom->opp[idx].perf;
+		opp_data.freq = dom->opp[idx].perf * dom->mult_factor;
+		opp_data.provider = genpd ? DEV_PM_OPP_TYPE_GENPD :
+					    DEV_PM_OPP_TYPE_NONE;
 
-		ret = dev_pm_opp_add(dev, freq, 0);
+		ret = dev_pm_opp_add_dynamic(dev, &opp_data);
 		if (ret) {
-			dev_warn(dev, "failed to add opp %luHz\n", freq);
+			dev_warn(dev, "failed to add opp %luHz\n",
+				 opp_data.freq);
 			dev_pm_opp_remove_all_dynamic(dev);
 			return ret;
 		}
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 21aea1b2a355..ec421107f94c 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -136,7 +136,7 @@ struct scmi_perf_proto_ops {
 	int (*transition_latency_get)(const struct scmi_protocol_handle *ph,
 				      u32 domain);
 	int (*device_opps_add)(const struct scmi_protocol_handle *ph,
-			       struct device *dev, u32 domain);
+			       struct device *dev, u32 domain, bool genpd);
 	int (*freq_set)(const struct scmi_protocol_handle *ph, u32 domain,
 			unsigned long rate, bool poll);
 	int (*freq_get)(const struct scmi_protocol_handle *ph, u32 domain,
-- 
2.34.1

