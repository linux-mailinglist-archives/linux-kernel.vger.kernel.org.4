Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC270288D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbjEOJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbjEOJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:28:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C32130;
        Mon, 15 May 2023 02:27:49 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QKYnK6gKpzTkGJ;
        Mon, 15 May 2023 17:23:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:27:46 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC:     <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-acpi@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH 1/2] cpufreq: CPPC: keep target core awake when reading its cpufreq rate
Date:   Mon, 15 May 2023 18:00:03 +0800
Message-ID: <20230515100005.3540793-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ARM AMU's document says, all counters are subject to any changes
in clock frequency, including clock stopping caused by the WFI and WFE
instructions.

Therefore, using smp_call_function_single() to trigger target CPU to
read self's AMU counters, which ensures the counters are working
properly during calculation.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..169af7ff9a2a 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -837,29 +837,31 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 	return (reference_perf * delta_delivered) / delta_reference;
 }
 
+static void cppc_get_perf_ctrs_smp(void *val)
+{
+	int cpu = smp_processor_id();
+	struct cppc_perf_fb_ctrs *fb_ctrs = val;
+
+	cppc_get_perf_ctrs(cpu, fb_ctrs);
+
+	udelay(2); /* 2usec delay between sampling */
+
+	cppc_get_perf_ctrs(cpu, fb_ctrs + 1);
+}
+
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	struct cppc_perf_fb_ctrs fb_ctrs[2] = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 delivered_perf;
-	int ret;
 
 	cpufreq_cpu_put(policy);
 
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-	if (ret)
-		return ret;
-
-	udelay(2); /* 2usec delay between sampling */
-
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
-	if (ret)
-		return ret;
-
-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-					       &fb_ctrs_t1);
+	smp_call_function_single(cpu, cppc_get_perf_ctrs_smp, fb_ctrs, 1);
 
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, fb_ctrs,
+					       fb_ctrs + 1);
 	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
 }
 
-- 
2.25.1

