Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35309736CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjFTNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjFTNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784B31BD5;
        Tue, 20 Jun 2023 06:01:16 -0700 (PDT)
Date:   Tue, 20 Jun 2023 13:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687266053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dAf0GEt2bqtXlVtGRtDFvrC3WajYNjMM7B5erNke8E=;
        b=jVCRRZVh+lA0lLZlUw3HnBDGOL36IvOHtINUzSR5E26Z7TDDlMKtbgZcGibcp52BYaEflt
        3rrq6UeYD9MDcdSQnV2Ip6sfPBIIB5W7fCPRwjGu0gnSlRQXUQSbqoPoy57nDIZTdRtUOa
        KLcv6csS3xTAzTuUpdOStDAxhlQX2lSYxy9AtniSN0yyXk+1NzRCyW4Vxr3KflQNjJxMGC
        K5zCZGS6zh7GtDtZEHuzJckDOGmrQ4g9PlreMgH0e1L1lh2cWH5iXSVCcH5/LGKo4wvdJN
        XiRkj6v9q/C8fYLZn1nq2Evj2uste8SQv8WLI0kJ6PELuo1/0sClozVrS3m3rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687266053;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dAf0GEt2bqtXlVtGRtDFvrC3WajYNjMM7B5erNke8E=;
        b=ED35lgG54RyXwtKhzVfj8yzvysx/HWnIGHW0RCJ3ToamY0nkwLl3GodGOoiplMu9N5nijh
        hugQAq0m4XNoN/Cw==
From:   "tip-bot2 for Tony Battersby" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/smp: Dont access non-existing CPUID leaf
Cc:     Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
MIME-Version: 1.0
Message-ID: <168726605213.404.14930030700633140033.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9b040453d4440659f33dc6f0aa26af418ebfe70b
Gitweb:        https://git.kernel.org/tip/9b040453d4440659f33dc6f0aa26af418ebfe70b
Author:        Tony Battersby <tonyb@cybernetics.com>
AuthorDate:    Thu, 15 Jun 2023 22:33:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Jun 2023 14:51:46 +02:00

x86/smp: Dont access non-existing CPUID leaf

stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. Intel
CPUs return the content of the highest supported leaf when a non-existing
leaf is read, while AMD CPUs return all zeros for unsupported leafs.

So the result of the test on Intel CPUs is lottery.

While harmless it's incorrect and causes the conditional wbinvd() to be
issued where not required.

Check whether the leaf is supported before reading it.

[ tglx: Adjusted changelog ]

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
Link: https://lore.kernel.org/r/20230615193330.322186388@linutronix.de

---
 arch/x86/kernel/process.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 05924bc..ff9b80a 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -763,6 +763,7 @@ struct cpumask cpus_stop_mask;
 
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
 	unsigned int cpu = smp_processor_id();
 
 	local_irq_disable();
@@ -777,7 +778,7 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	set_cpu_online(cpu, false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -791,7 +792,7 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
 
 	/*
