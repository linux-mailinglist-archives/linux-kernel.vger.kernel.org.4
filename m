Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B31E7048BA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 11:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjEPJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 05:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjEPJKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 05:10:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62BE4227;
        Tue, 16 May 2023 02:10:05 -0700 (PDT)
Date:   Tue, 16 May 2023 09:10:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684228202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHaRK3I24TIpOwkk8o0h35z1n6u18ucV9SW/BP6B49Y=;
        b=zsbK+Q8TLSbFRZJw2EWhpjsiiLNi3bS0ZGmNU2X9zALnjHTa6tqNo3m9eIoxuJLKKRDHim
        kWQazWrHWgeTOyXZXZ5YySD8vZw6AyaltaoXYfikR7RkHjkE9NeIA+Yv7Kvr8Hj8MxexxQ
        SWWdQHMiBdH9e9R+7wUGYECsPCBvWWB+4RWPg48LQ+7dQkyGcU1IDAOuLVtnryAzts2AWs
        f/qbaDLdKqFX0SCi55tz8H+3BZ8BR140ywvzQHJxhZCMgbeHbqusi+PIORTrxeuBU8B8Ee
        OMcbVv6ogOsv+O045VeM5plvUMedKoOVCygVwjLos4k4FrqgO/5tPjMwXLCztg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684228202;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHaRK3I24TIpOwkk8o0h35z1n6u18ucV9SW/BP6B49Y=;
        b=qlo0+caWMBb2zW1wf/sYJje82WD2zKue+xTJQnm3buAt9TcoRzjLP6MvfjJSe9EunM8SV/
        bJ6vVaUFOkGXsAAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] x86/smpboot: Remove unnecessary barrier()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230512205255.875713771@linutronix.de>
References: <20230512205255.875713771@linutronix.de>
MIME-Version: 1.0
Message-ID: <168422820167.404.7473956116508095076.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     c7f15dd3f0e9f1d12d1ae21f0bbd61302ef3abcf
Gitweb:        https://git.kernel.org/tip/c7f15dd3f0e9f1d12d1ae21f0bbd61302ef3abcf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 12 May 2023 23:07:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 May 2023 13:44:50 +02:00

x86/smpboot: Remove unnecessary barrier()

Peter stumbled over the barrier() after the invocation of smp_callin() in
start_secondary():

  "...this barrier() and it's comment seem weird vs smp_callin(). That
   function ends with an atomic bitop (it has to, at the very least it must
   not be weaker than store-release) but also has an explicit wmb() to order
   setup vs CPU_STARTING.

   There is no way the smp_processor_id() referred to in this comment can land
   before cpu_init() even without the barrier()."

The barrier() along with the comment was added in 2003 with commit
d8f19f2cac70 ("[PATCH] x86-64 merge") in the history tree. One of those
well documented combo patches of that time which changes world and some
more. The context back then was:

	/*
	 * Dont put anything before smp_callin(), SMP
	 * booting is too fragile that we want to limit the
	 * things done here to the most necessary things.
	 */
	cpu_init();
	smp_callin();

+	/* otherwise gcc will move up smp_processor_id before the cpu_init */
+ 	barrier();

	Dprintk("cpu %d: waiting for commence\n", smp_processor_id());

Even back in 2003 the compiler was not allowed to reorder that
smp_processor_id() invocation before the cpu_init() function call.
Especially not as smp_processor_id() resolved to:

  asm volatile("movl %%gs:%c1,%0":"=r" (ret__):"i"(pda_offset(field)):"memory");

There is no trace of this change in any mailing list archive including the
back then official x86_64 list discuss@x86-64.org, which would explain the
problem this change solved.

The debug prints are gone by now and the the only smp_processor_id()
invocation today is farther down in start_secondary() after locking
vector_lock which itself prevents reordering.

Even if the compiler would be allowed to reorder this, the code would still
be correct as GSBASE is set up early in the assembly code and is valid when
the CPU reaches start_secondary(), while the code at the time when this
barrier was added did the GSBASE setup in cpu_init().

As the barrier has zero value, remove it.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Link: https://lore.kernel.org/r/20230512205255.875713771@linutronix.de
---
 arch/x86/kernel/smpboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 466e83a..f5f4328 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -238,8 +238,6 @@ static void notrace start_secondary(void *unused)
 	x86_cpuinit.early_percpu_clock_init();
 	smp_callin();
 
-	/* otherwise gcc will move up smp_processor_id before the cpu_init */
-	barrier();
 	/* Check TSC synchronization with the control CPU: */
 	check_tsc_sync_target();
 
