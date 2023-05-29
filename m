Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646E714FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2Tju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2Tjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:39:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED6CB7;
        Mon, 29 May 2023 12:39:47 -0700 (PDT)
Date:   Mon, 29 May 2023 19:39:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685389186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KtZGfYQCjjS2SqnUxX40yZ82weExH9THlmAMKW1Z3k=;
        b=x3ergisLX/s9jJg/N/JYXP6tp8uM6lGjQX4pjAf4qhylZr17iFqDi/NrZnz+a4zzomkXC6
        D+UQU19B0X/r2NIyDAiGTc94Hik6QjsWfUqIOOQ+zvW6Ro90Hdj8G6qDgj0oZ5SQg9nMF1
        2/mT5PoTtASzKedTRHg5v9YAFkyqFiQ3kWHxySOZdyrIqJlMYqWFJh9PJnCvfG3lelyROw
        04hwJGLtjYGNXV3BSgTVwje173Svn46DTMvua5ThKZ0Gn73TdkkVIG+ErpH4nlgdwIw+BP
        yCH8tlzNsDn75Lw3k/13PxrvNDyzSga00vshGHjcBfAGskH1WSXGSLkRBjrl7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685389186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KtZGfYQCjjS2SqnUxX40yZ82weExH9THlmAMKW1Z3k=;
        b=EI2+EB4hGX6vpsU31qjJYaZx251wBvNzCi1bb3BjbsADswxgyhCEtfIA6d4SRod1SrPPvr
        IcyF5+qdTnu3PNDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smp: Initialize cpu_primary_thread_mask late
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87sfbhlwp9.ffs@tglx>
References: <87sfbhlwp9.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168538918580.404.12778821542174933312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     5da80b28bf25c3458c7beb23794ff53622ce7eb4
Gitweb:        https://git.kernel.org/tip/5da80b28bf25c3458c7beb23794ff53622ce7eb4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 26 May 2023 21:38:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 May 2023 21:31:23 +02:00

x86/smp: Initialize cpu_primary_thread_mask late

Marking primary threads in the cpumask during early boot is only correct in
certain configurations, but broken e.g. for the legacy hyperthreading
detection.

This is due to the complete mess in the CPUID evaluation code which
initializes smp_num_siblings only half during early init and fixes it up
later when identify_boot_cpu() is invoked.

So using smp_num_siblings before identify_boot_cpu() leads to incorrect
results.

Fixing the early CPU init code to provide the proper data is a larger scale
surgery as the code has dependencies on data structures which are not
initialized during early boot.

Move the initialization of cpu_primary_thread_mask wich depends on
smp_num_siblings being correct to an early initcall so that it is set up
correctly before SMP bringup.

Fixes: f54d4434c281 ("x86/apic: Provide cpu_primary_thread mask")
Reported-by: "Kirill A. Shutemov" <kirill@shutemov.name>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/87sfbhlwp9.ffs@tglx

---
 arch/x86/kernel/apic/apic.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 209c505..af49e24 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2398,6 +2398,21 @@ static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 	if (smp_num_siblings == 1 || !(apicid & mask))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
+
+/*
+ * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
+ * during early boot. Initialize the primary thread mask before SMP
+ * bringup.
+ */
+static int __init smp_init_primary_thread_mask(void)
+{
+	unsigned int cpu;
+
+	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
+		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
+	return 0;
+}
+early_initcall(smp_init_primary_thread_mask);
 #else
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
@@ -2544,7 +2559,8 @@ int generic_processor_info(int apicid, int version)
 	set_cpu_present(cpu, true);
 	num_processors++;
 
-	cpu_mark_primary_thread(cpu, apicid);
+	if (system_state != SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apicid);
 
 	return cpu;
 }
