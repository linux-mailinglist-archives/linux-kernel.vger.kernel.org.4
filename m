Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CBA5B96FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIOJGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIOJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:06:02 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF096FDD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:05:58 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 28F95IbA074947
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 17:05:18 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918PCW.spreadtrum.com (10.0.74.50) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 15 Sep 2022 17:05:18 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <viresh.kumar@linaro.org>, <konrad.dybcio@somainline.org>,
        <rafael@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <di.shen@unisoc.com>
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Add cpufreq qos for LMh
Date:   Thu, 15 Sep 2022 17:05:15 +0800
Message-ID: <20220915090515.1660-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.50]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 28F95IbA074947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before update thermal pressure, the max cpufreq should be limited.
Add QOS control for Lmh throttle cpufreq.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d5ef3c66c762..deb1219435a5 100644
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
@@ -318,6 +321,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	} else {
 		throttled_freq = freq_hz / HZ_PER_KHZ;
 
+		freq_qos_update_request(&data->throttle_freq_req, throttled_freq);
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

