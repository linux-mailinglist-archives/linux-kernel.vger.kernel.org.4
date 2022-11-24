Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D1B63708F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 03:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKXCjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 21:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKXCjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 21:39:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E9565873
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 18:39:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FE4BB8265E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54220C433C1;
        Thu, 24 Nov 2022 02:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669257576;
        bh=v/MVsTswqTV6pYQHqN9mCNsFiduQhw05EJKbm6J8B9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqnAV5JxjBhMTnqY+nsEdkJAdIqMvZR6VuuOrh2h8I9tTjoLWtiHgBBOY2p/LTeO5
         3YNbf4WRvW0FihD+OMLoGtrv+IGs1wE9PkexlM6ybOshYiULCYuLx+FuabWE0Qn2VR
         tsZTzMZFV7QQGp3alstflhnff41Gqilqe4MxebM3kFf1PwF1ILeZMwVv1V3zrf1hBn
         yEpi21i7a8rhnjF21bqIGrM/b2+T1HTYE7U5KMWUw25bH9izmkcy2yVOVUenrEXXpL
         6zOCT7RrE95YnQ7bEHjtOLm2IfSv2A+USxLAuH4UPXotiUB7Tm9MdiiIcF+nqu9aeR
         oJ9CfKu49phXA==
Date:   Wed, 23 Nov 2022 18:39:34 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: objtool warning for next-20221118
Message-ID: <20221124023934.nft3udxelth4lvai@treble>
References: <20221121040736.GA3738360@paulmck-ThinkPad-P17-Gen-1>
 <Y3thrQxfcvZSXFlr@hirez.programming.kicks-ass.net>
 <20221121145215.GF4001@paulmck-ThinkPad-P17-Gen-1>
 <20221122051605.4hcbslwxez2trdvt@treble>
 <Y3yJxQJ9DwxTx7km@hirez.programming.kicks-ass.net>
 <20221123012350.kelmmadh65lyswqz@treble>
 <Y33gAiFP2IpVdxJu@hirez.programming.kicks-ass.net>
 <2255c45f-d8ba-3f32-9d99-737ad3040dd7@citrix.com>
 <20221123170337.keacggyvn4ykbtsw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123170337.keacggyvn4ykbtsw@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:03:40AM -0800, Josh Poimboeuf wrote:
> On Wed, Nov 23, 2022 at 10:52:09AM +0000, Andrew Cooper wrote:
> > > Well, if you return from arch_cpu_idle_dead() you're back in the idle
> > > loop -- exactly where you would be if you were to bootstrap the whole
> > > CPU -- provided you have it remember the whole state (easier with a
> > > vCPU).
> 
> play_dead() really needs sane semantics.  Not only does it introduce a
> surprise to the offlining code in do_idle(), it also skips the entire
> hotplug state machine.  Not sure if that introduces any bugs, but at the
> very least it's subtle and surprising.
> 
> > > But maybe I'm missing something, lets add Xen folks on.
> > 
> > Calling VCPUOP_down on oneself always succeeds, but all it does is
> > deschedule the vCPU.
> > 
> > It can be undone at a later point by a different vcpu issuing VCPUOP_up
> > against the previously-downed CPU, at which point the vCPU gets rescheduled.
> > 
> > This is why the VCPUOP_down hypercall returns normally.  All state
> > really is intact.
> > 
> > As for what Linux does, this is how xen_pv_cpu_up() currently behaves. 
> > If you want to make Xen behave more everything else, then bug a BUG()
> > after VCPUOP_down, and adjust xen_pv_cpu_up() to skip its initialised
> > check and always use VCPUOP_initialise to bring the vCPU back online.
> 
> Or we could do what sev_es_play_dead() does and just call start_cpu0()
> after the hypercall returns?

Something like so (untested).  This is only the x86 bits.

I think I convinced myself that start_cpu0() isn't buggy.  I'm looking
at other cleanups, e.g. converging cpu_bringup_and_idle() with
start_secondary().

I can pick it up again next week, post-turkey.

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20dab1a..e6d1d2810e38 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -93,9 +93,10 @@ static inline void __cpu_die(unsigned int cpu)
 	smp_ops.cpu_die(cpu);
 }
 
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	smp_ops.play_dead();
+	BUG();
 }
 
 static inline void smp_send_reschedule(int cpu)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 26e8f57c75ad..8e2841deb1eb 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -700,7 +700,7 @@ EXPORT_SYMBOL(boot_option_idle_override);
 static void (*x86_idle)(void);
 
 #ifndef CONFIG_SMP
-static inline void play_dead(void)
+static inline void __noreturn play_dead(void)
 {
 	BUG();
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..d8b12ac1a7c5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1833,9 +1833,12 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();	/* Only returns on failure */
+	mwait_play_dead();	/* Only returns if mwait is not supported */
+
 	if (cpuidle_play_dead())
 		hlt_play_dead();
+
+	BUG();
 }
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 480be82e9b7b..30dc904ca990 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -385,17 +385,9 @@ static void xen_pv_play_dead(void) /* used only with HOTPLUG_CPU */
 {
 	play_dead_common();
 	HYPERVISOR_vcpu_op(VCPUOP_down, xen_vcpu_nr(smp_processor_id()), NULL);
-	cpu_bringup();
-	/*
-	 * commit 4b0c0f294 (tick: Cleanup NOHZ per cpu data on cpu down)
-	 * clears certain data that the cpu_idle loop (which called us
-	 * and that we return from) expects. The only way to get that
-	 * data back is to call:
-	 */
-	tick_nohz_idle_enter();
-	tick_nohz_idle_stop_tick_protected();
 
-	cpuhp_online_idle(CPUHP_AP_ONLINE_IDLE);
+	/* FIXME: converge cpu_bringup_and_idle() and start_secondary() */
+	cpu_bringup_and_idle();
 }
 
 #else /* !CONFIG_HOTPLUG_CPU */
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9d..7fbbd1572288 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -185,7 +185,7 @@ void arch_cpu_idle(void);
 void arch_cpu_idle_prepare(void);
 void arch_cpu_idle_enter(void);
 void arch_cpu_idle_exit(void);
-void arch_cpu_idle_dead(void);
+void __noreturn arch_cpu_idle_dead(void);
 
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..097afe98e53e 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -71,7 +71,7 @@ static noinline int __cpuidle cpu_idle_poll(void)
 void __weak arch_cpu_idle_prepare(void) { }
 void __weak arch_cpu_idle_enter(void) { }
 void __weak arch_cpu_idle_exit(void) { }
-void __weak arch_cpu_idle_dead(void) { }
+void __weak __noreturn arch_cpu_idle_dead(void) { BUG(); }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
