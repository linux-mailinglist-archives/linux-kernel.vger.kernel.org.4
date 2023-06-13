Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2B72E2B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbjFMMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjFMMR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:17:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7DCE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:17:58 -0700 (PDT)
Message-ID: <20230613121615.697412459@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686658677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HM6V+irlq0EoYO9XtWgZJ+0ilH4pTT198i0/jTCKMCs=;
        b=GJm07Y878g9vNRWiWCyGq50zu00hhSLlq6nAhrAbyrA0rxJLVi1O8/XalaKYs5Q2A3CwR6
        KkwQ6IpRoXfyLscT9bkdfkIJptf1VvUjNFQUkXsz9kxp9rMbGZqU+s9DPLPzTTQRLBaU8N
        5TQucOy1T+9LZQY2pei87uZM9DkiIsUpi9DJbcGoBMUpkKIo0w2+tNkDHhmyEubRtBm94/
        POvT8ZEdm8HAowmgLsE1pAjxAmbMVTLLphIIptjwzDqgIKBP3iNBd1ORvPwUTpkY3nEbMv
        bdEhlar1yAaVjlBpsIZDg8rjvjy2jji4fRzw0AUSdBpvyEEvOrxYnT5SIoP5zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686658677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HM6V+irlq0EoYO9XtWgZJ+0ilH4pTT198i0/jTCKMCs=;
        b=dyViilN1El+jNxDNYUEbnhtqsOckRJgiExrmzt8Tb/SNbuyGsPTqh4GWxs1VsBxF1AKKtj
        RdnqWTfKf1C21JAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [patch V2 2/8] x86/smp: Dont access non-existing CPUID leaf
References: <20230613115353.599087484@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 13 Jun 2023 14:17:57 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/kernel/process.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -763,13 +763,15 @@ atomic_t stop_cpus_count;
 
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
+
 	local_irq_disable();
 	/*
 	 * Remove this CPU:
 	 */
 	set_cpu_online(smp_processor_id(), false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -783,7 +785,7 @@ void __noreturn stop_this_cpu(void *dumm
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
 
 	/*

