Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91362B658
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiKPJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiKPJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:22:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2DA26496;
        Wed, 16 Nov 2022 01:22:00 -0800 (PST)
Date:   Wed, 16 Nov 2022 09:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668590519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2QCi91rjS1KvSEfaQMdVz/AWN4dBQtHDsuiO7ZSipA=;
        b=C63eBMnnuYI99bFSvUY2eh4q0nLt/5n1+H/GNtf6hMTZmHN3aRMrpmcjEyqDmwkz21AOWc
        VHqxboe+8xVx0s7I2hMc+2wtSoKa5tV2LFcRojIOnjf9kwCnVaQx/wxu2Tv1f8zrWMVL19
        iViZ/+LpuzElJLRmD8Gnvb0hpSxF7awhDO14XuNp+H9pqT4jPEZgv3k1Ws0AarWQdf3rVH
        cZ4S6vqN/40JzX5sVBxqk8L5+UYYMFgK5y3RJudNbMLX0eQ6zPQEz5HCwJECgcusNuJF++
        7a+0mUzTzjuk/q08dWHEOJPmplEJMEtKgN2ViUNu1Ri7xFKic62BCThQffDxzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668590519;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2QCi91rjS1KvSEfaQMdVz/AWN4dBQtHDsuiO7ZSipA=;
        b=p1x8WBNvJdLjWVJBcHKXVBgibWqCYcBhHH/m3+N0d/qoKOdLF7OdAcItDU42TrMvUxSg4s
        8dWWiq2SJSo/k7DQ==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd: Fix crash due to race between
 amd_pmu_enable_all, perf NMI and throttling
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221114044029.373-1-ravi.bangoria@amd.com>
References: <20221114044029.373-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <166859051766.4906.13011883252870783939.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     baa014b9543c8e5e94f5d15b66abfe60750b8284
Gitweb:        https://git.kernel.org/tip/baa014b9543c8e5e94f5d15b66abfe60750b8284
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 14 Nov 2022 10:10:29 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Nov 2022 10:12:58 +01:00

perf/x86/amd: Fix crash due to race between amd_pmu_enable_all, perf NMI and throttling

amd_pmu_enable_all() does:

      if (!test_bit(idx, cpuc->active_mask))
              continue;

      amd_pmu_enable_event(cpuc->events[idx]);

A perf NMI of another event can come between these two steps. Perf NMI
handler internally disables and enables _all_ events, including the one
which nmi-intercepted amd_pmu_enable_all() was in process of enabling.
If that unintentionally enabled event has very low sampling period and
causes immediate successive NMI, causing the event to be throttled,
cpuc->events[idx] and cpuc->active_mask gets cleared by x86_pmu_stop().
This will result in amd_pmu_enable_event() getting called with event=NULL
when amd_pmu_enable_all() resumes after handling the NMIs. This causes a
kernel crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000198
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  [...]
  Call Trace:
   <TASK>
   amd_pmu_enable_all+0x68/0xb0
   ctx_resched+0xd9/0x150
   event_function+0xb8/0x130
   ? hrtimer_start_range_ns+0x141/0x4a0
   ? perf_duration_warn+0x30/0x30
   remote_function+0x4d/0x60
   __flush_smp_call_function_queue+0xc4/0x500
   flush_smp_call_function_queue+0x11d/0x1b0
   do_idle+0x18f/0x2d0
   cpu_startup_entry+0x19/0x20
   start_secondary+0x121/0x160
   secondary_startup_64_no_verify+0xe5/0xeb
   </TASK>

amd_pmu_disable_all()/amd_pmu_enable_all() calls inside perf NMI handler
were recently added as part of BRS enablement but I'm not sure whether
we really need them. We can just disable BRS in the beginning and enable
it back while returning from NMI. This will solve the issue by not
enabling those events whose active_masks are set but are not yet enabled
in hw pmu.

Fixes: ada543459cab ("perf/x86/amd: Add AMD Fam19h Branch Sampling support")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221114044029.373-1-ravi.bangoria@amd.com
---
 arch/x86/events/amd/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8b70237..d6f3703 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -861,8 +861,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 	pmu_enabled = cpuc->enabled;
 	cpuc->enabled = 0;
 
-	/* stop everything (includes BRS) */
-	amd_pmu_disable_all();
+	amd_brs_disable_all();
 
 	/* Drain BRS is in use (could be inactive) */
 	if (cpuc->lbr_users)
@@ -873,7 +872,7 @@ static int amd_pmu_handle_irq(struct pt_regs *regs)
 
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
-		amd_pmu_enable_all(0);
+		amd_brs_enable_all();
 
 	return amd_pmu_adjust_nmi_window(handled);
 }
