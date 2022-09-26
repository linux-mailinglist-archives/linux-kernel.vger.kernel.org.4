Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898ED5E9C20
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbiIZIfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbiIZIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:35:21 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7513DD8;
        Mon, 26 Sep 2022 01:35:19 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28Q8YCkJ085089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Mon, 26 Sep 2022 16:34:12 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918PCW.spreadtrum.com (10.0.74.50) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 26 Sep 2022 16:34:12 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <viresh.kumar@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <rafael@kernel.org>, <di.shen@unisoc.com>
Subject: [PATCH v2] cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh
Date:   Mon, 26 Sep 2022 16:34:05 +0800
Message-ID: <20220926083405.7801-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926055130.yr67653e52vyuutv@vireshk-i7>
References: <20220926055130.yr67653e52vyuutv@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.50]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28Q8YCkJ085089
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before update thermal pressure, the max cpufreq should be limited.
Add QOS control for Lmh throttle cpufreq.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
v1->v2:
	reabse to cpufreq/arm/linux-next;
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index bb32659820ce..833589bc95e4 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -13,6 +13,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/units.h>
@@ -56,6 +57,8 @@ struct qcom_cpufreq_data {
 	struct cpufreq_policy *policy;
 
 	bool per_core_dcvs;
+
+	struct freq_qos_request throttle_freq_req;
 };
 
 static unsigned long cpu_hw_rate, xo_rate;
@@ -321,6 +324,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
+	freq_qos_update_request(&data->throttle_freq_req, throttled_freq);
+
 	/* Update thermal pressure (the boost frequencies are accepted) */
 	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
 
@@ -413,6 +418,14 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 	if (data->throttle_irq < 0)
 		return data->throttle_irq;
 
+	ret = freq_qos_add_request(&policy->constraints,
+				   &data->throttle_freq_req, FREQ_QOS_MAX,
+				   FREQ_QOS_MAX_DEFAULT_VALUE);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to add freq constraint (%d)\n", ret);
+		return ret;
+	}
+
 	data->cancel_throttle = false;
 	data->policy = policy;
 
@@ -479,6 +492,7 @@ static void qcom_cpufreq_hw_lmh_exit(struct qcom_cpufreq_data *data)
 	if (data->throttle_irq <= 0)
 		return;
 
+	freq_qos_remove_request(&data->throttle_freq_req);
 	free_irq(data->throttle_irq, data);
 }
 
-- 
2.25.1

