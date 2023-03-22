Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A196C5A26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCVXPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCVXPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:15:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB061910F;
        Wed, 22 Mar 2023 16:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hKMA4pE4ZC1WEjwlMS0oahB5WbuLzi761bi+OVXv/X8=; b=k4/hIANBdxC2Z8c++HmkBPk16F
        hq1n4vi1aFY7d/izKMGpm0/zkTd++0c77IZs+Q5bV257Gjkiy34yMSDd8L7TKq46+CV0zDSHb27H+
        4KSIRSylcgYZ2OMei78Bb1gC7STjWled8MJkcwhhG29tpOAa6HtPIFWPyA9seeGrRiJr3vWUYPsTp
        3Vu3FPyPpiLcCMVxhaxuIGSboSf1mmZy7nxDek09nDmg/P6bBJA5M4EMw//9ErW/pvBC1TxeGCDAY
        4DGmD2DpR96GbtKoxaTV3TYyxFMIuFbNKoIU/LaGvb2xuytoT+Rk3V4s2DX53haN44indyDWk1fXo
        N1G/mBcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pf7f5-004hB6-38;
        Wed, 22 Mar 2023 23:14:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9046D30035F;
        Thu, 23 Mar 2023 00:14:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73D47202F7F60; Thu, 23 Mar 2023 00:14:28 +0100 (CET)
Date:   Thu, 23 Mar 2023 00:14:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
Message-ID: <20230322231428.GV2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
 <xhsmhmt45c703.mognet@vschneid.remote.csb>
 <20230322140434.GC2357380@hirez.programming.kicks-ass.net>
 <xhsmhjzz8d8km.mognet@vschneid.remote.csb>
 <20230322172242.GH2357380@hirez.programming.kicks-ass.net>
 <xhsmhh6ucd4t7.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhh6ucd4t7.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:22:28PM +0000, Valentin Schneider wrote:
> On 22/03/23 18:22, Peter Zijlstra wrote:

> >>        hackbench-157   [001]    10.894320: ipi_send_cpu:         cpu=3 callsite=check_preempt_curr+0x37 callback=0x0
> >
> > Arguably we should be setting callback to scheduler_ipi(), except
> > ofcourse, that's not an actual function...
> >
> > Maybe we can do "extern inline" for the actual users and provide a dummy
> > function for the symbol when tracing.
> >
> 
> Huh, I wasn't aware that was an option, I'll look into that. I did scribble
> down a comment next to smp_send_reschedule(), but having a decodable
> function name would be better!

So clang-15 builds the below (and generates the expected code), but
gcc-12 vomits nonsense about a non-static inline calling a static inline
or somesuch bollocks :-/

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1991,7 +1991,7 @@ extern char *__get_task_comm(char *to, s
 })
 
 #ifdef CONFIG_SMP
-static __always_inline void scheduler_ipi(void)
+extern __always_inline void scheduler_ipi(void)
 {
 	/*
 	 * Fold TIF_NEED_RESCHED into the preempt_count; anybody setting
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -130,9 +130,9 @@ extern void arch_smp_send_reschedule(int
  * scheduler_ipi() is inline so can't be passed as callback reason, but the
  * callsite IP should be sufficient for root-causing IPIs sent from here.
  */
-#define smp_send_reschedule(cpu) ({		  \
-	trace_ipi_send_cpu(cpu, _RET_IP_, NULL);  \
-	arch_smp_send_reschedule(cpu);		  \
+#define smp_send_reschedule(cpu) ({				\
+	trace_ipi_send_cpu(cpu, _RET_IP_, &scheduler_ipi);	\
+	arch_smp_send_reschedule(cpu);				\
 })
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3790,6 +3790,15 @@ static int ttwu_runnable(struct task_str
 }
 
 #ifdef CONFIG_SMP
+void scheduler_ipi(void)
+{
+	/*
+	 * Actual users should end up using the extern inline, this is only
+	 * here for the symbol.
+	 */
+	BUG();
+}
+
 void sched_ttwu_pending(void *arg)
 {
 	struct llist_node *llist = arg;
