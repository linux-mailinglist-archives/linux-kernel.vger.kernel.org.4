Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B07320FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjFOUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjFOUdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:33:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EC2711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:33:54 -0700 (PDT)
Message-ID: <20230615193330.322186388@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686861233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F5oJwB0GE84n/VmQ+gAa3Veuk6SxbBp4c68eFnUy6Y0=;
        b=UMuAs2SM92SW0z9tELVFy5u/AMkL0NDmXH+pafezqQnMYC6OcnR88nEjpLcIpn5Z31tJ5C
        W91OTZbh7MzxP0ZllmRwkGkeyQN5UNiiJzrNYM+LXF15SvSD08/SZwXgKw1zfeg4uHevjR
        F8k9caqbsp+XR4MbKy6RyPOuTt7yVGEiI0lizgpovAvqGYur+DGqGXWOTcthd6Hov1hqZV
        5CoSfIv9E6/BcqfiQGAUo7BhhyODWKAF8yfLhx+0zXqJdpAA5V2+7RIwrwCKjQE3SvO/Dp
        EP6QVqvQBCZ4A5Cc9S2SKdFgu0mV2lwucvNBc4xvYhl/2NHl6QVSZLgS7OD6QA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686861233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=F5oJwB0GE84n/VmQ+gAa3Veuk6SxbBp4c68eFnUy6Y0=;
        b=c6anQgBHPb6ZHy+bj8yaIUYehPRUCxgGiX9lejOeWUl50NRgTNB9O6jeTDFaMRCzcZoeNN
        luLww6OHL36NQdAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch v3 2/7] x86/smp: Dont access non-existing CPUID leaf
References: <20230615190036.898273129@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 15 Jun 2023 22:33:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Battersby <tonyb@cybernetics.com>

stop_this_cpu() tests CPUID leaf 0x8000001f::EAX unconditionally. CPUs
return the content of the highest supported leaf when a non-existing leaf
is read. So the result of the test is lottery except on AMD CPUs which
support that leaf.

While harmless it's incorrect and causes the conditional wbinvd() to be
issued where not required.

Check whether the leaf is supported before reading it.

[ tglx: Adjusted changelog ]

Fixes: 08f253ec3767 ("x86/cpu: Clear SME feature flag when not in use")
Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com
---
 arch/x86/kernel/process.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -763,6 +763,7 @@ struct cpumask cpus_stop_mask;
 
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
 	unsigned int cpu = smp_processor_id();
 
 	local_irq_disable();
@@ -777,7 +778,7 @@ void __noreturn stop_this_cpu(void *dumm
 	 */
 	set_cpu_online(cpu, false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -791,7 +792,7 @@ void __noreturn stop_this_cpu(void *dumm
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
 
 	/*

