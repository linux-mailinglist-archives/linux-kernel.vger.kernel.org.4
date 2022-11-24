Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E768637879
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKXMEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiKXMDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:03:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029664A01;
        Thu, 24 Nov 2022 04:03:07 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:03:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669291385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xqEjEcL0906OzkqaFV8QMEyw4W77Lb+HyFLuikr0780=;
        b=NaUw8Ct/wQ51M21IlEEsRiEBcSmOfvIaxNTEHFxYnyoMfB1m/8XSNxxOSOs/0NjeRY63tP
        YBqfGqXuskfzgc7C9GpJvTJzKCFmM/G/wcSEhl9pwzJkgKviBhbSL/ibjp5qvwQMBfWkpK
        ZEBzxYw3B0HtGrQL+T1f98JzMRhyucienji2OIhRJXFBpX6uJqKYOTSs5YXYMBOoI/LrK1
        yADo4De3mXiJr/Ne6m4JWsHiiR67cjgzYig3pDRqyxVy72V4d6ge1y07P0acms09+XHhnt
        h56NBa+jnu0WudSN0QggkTmTatbqktfCRbSLCIzgE/7iFHYYWcJA/yi/LHTJaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669291385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xqEjEcL0906OzkqaFV8QMEyw4W77Lb+HyFLuikr0780=;
        b=9tTP3yHouq7z6fZ0TjFPXV2A02uU7nyzKcXDkeD0gko5oymE8Qr+XMdknQhfvRnn5gRNg3
        OQ0i3zP3QBZimSAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix function pointer case
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166929138452.4906.418857021586058320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574
Gitweb:        https://git.kernel.org/tip/1af6239d1d3e61d33fd2f0ba53d3d1a67cc50574
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Nov 2022 22:40:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Nov 2022 11:09:18 +01:00

perf: Fix function pointer case

With the advent of CFI it is no longer acceptible to cast function
pointers.

The robot complains thusly:

  kernel-events-core.c:warning:cast-from-int-(-)(struct-perf_cpu_pmu_context-)-to-remote_function_f-(aka-int-(-)(void-)-)-converts-to-incompatible-function-type

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5f262f9..f2b865c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1119,6 +1119,11 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_pmu_context *cpc)
 	return 0;
 }
 
+static int perf_mux_hrtimer_restart_ipi(void *arg)
+{
+	return perf_mux_hrtimer_restart(arg);
+}
+
 void perf_pmu_disable(struct pmu *pmu)
 {
 	int *count = this_cpu_ptr(pmu->pmu_disable_count);
@@ -11270,8 +11275,7 @@ perf_event_mux_interval_ms_store(struct device *dev,
 		cpc = per_cpu_ptr(pmu->cpu_pmu_context, cpu);
 		cpc->hrtimer_interval = ns_to_ktime(NSEC_PER_MSEC * timer);
 
-		cpu_function_call(cpu,
-			(remote_function_f)perf_mux_hrtimer_restart, cpc);
+		cpu_function_call(cpu, perf_mux_hrtimer_restart_ipi, cpc);
 	}
 	cpus_read_unlock();
 	mutex_unlock(&mux_interval_mutex);
