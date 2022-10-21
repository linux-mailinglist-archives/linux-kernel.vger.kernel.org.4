Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80747606D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJUCVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:21:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75821F182B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:21:13 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mtp4B0dDbz1P7Cq;
        Fri, 21 Oct 2022 10:16:26 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:21:11 +0800
Received: from huawei.com (10.67.175.41) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 10:21:11 +0800
From:   Yipeng Zou <zouyipeng@huawei.com>
To:     <tglx@linutronix.de>, <bp@alien8.de>, <mingo@redhat.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <rafael.j.wysocki@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Yipeng Zou <zouyipeng@huawei.com>
Subject: [PATCH stable 1/1] x86: aperfmperf: fix overflow problem in the concurrency scenario
Date:   Fri, 21 Oct 2022 10:17:40 +0800
Message-ID: <20221021021740.137196-2-zouyipeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221021021740.137196-1-zouyipeng@huawei.com>
References: <20221021021740.137196-1-zouyipeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.41]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently i was doing some work about calculating CPU frequency on x86 on
stable branch linux-5.10.y, and there are the details of the problem.
I was test on platform Intel Xeon CPU @ 2.10Ghz. In most cases the cpu
freq field cat from /proc/cpuinfo was 2099.800 ~ 2100.300 MHz. At a very
low probability, the values of cpu freq was very small, such as 105.000
MHz.

After debug I found that there is an integer overflow problem in the
concurrency scenario during the calculation of cpu freq. The key code
was the function aperfmperf_snapshot_khz(),

In function aperfmperf_snapshot_khz(), the aperf_delta may be large(a
long time since the last execution). This has the potential to cause
integer overflow when multiplying with it.

And Then to avoid this the stable branch will calculate the cpu freq
twice and sleep 10ms when it is found that this update is a long time
since the last time to ensure calculated the cpu freq correctly.

Consider the following:

Task 0                   Task 1

arch_freq_perpare_all    ....

sleep 10ms               ....

....                     arch_freq_perpare_all    // Within 10ms

....                     aperfmperf_snapshot_cpu  // Within 10ms

aperfmperf_snapshot_cpu  ....

step 0: task0 : arch_freq_perpare_all go through all cpus and update
their time and freq. If this time is a long time since the last update,
then the saved CPU freq is abnormal(integer overflow).

step 1: Then task1 has also come to get the same CPU freq. But since
within 10ms of last task 0 calculation, it cannot update the current
CPU freq, which exception value it will gets.

I've noticed that it has been abandoned on the mainline. On the mainline
it becomes to update [a,m]cnt in timer code with HZ frequency, and it is
actually calculated at the time of reading the cpu freqency. This solves
the problem above.

Fixes: 7d5905dc14a8 ("x86 / CPU: Always show current CPU frequency in /proc/cpuinfo")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
---
 arch/x86/kernel/cpu/aperfmperf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e2f319dc992d..d3f417c06d5f 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -68,10 +68,6 @@ static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 {
 	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
 
-	/* Don't bother re-computing within the cache threshold time. */
-	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
-		return true;
-
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
 
 	/* Return false if the previous iteration was too long ago. */
-- 
2.17.1

