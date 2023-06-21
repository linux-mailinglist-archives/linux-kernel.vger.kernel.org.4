Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5906A738A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjFUQHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFUQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:07:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0967F95
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Irz5Qpl7uqHkmOH8xg8sH866sarfqlfHBBBnDq2uu8Y=; b=pTpTik8d9/h5sZ0N4xIZBhUvbm
        qH7ogE+S8Jghp2uF4HWL7S33Jya9fmaJ3twtpkLWqFXna6vAAa3pRDZzeFpcXS5rJaKr6arwC6iBL
        3+iBIxTvPNmLiwBYwnchswNcStnzq2AnU5jqQEdz6rAYsj7sCwJa0ReGfMMT7mmAKyMblitdRaEZt
        2w4ihHc7zHNuK2ssefQm9MJMT97xc7MxdNSdz2WKsJnsGDdtyqrkEy8NipW3NfbPeQeSJYLipB2pc
        EMAjKG9DJzf7GQGnE6BSPRh951IGRSU9yDgMMoiUJd//Zlq1oM1hi5Fb7lx5U2cmJ7Y4bxBbGwEVg
        8IXUlDMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qC0MD-00EdZh-Gh; Wed, 21 Jun 2023 16:06:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 170283002F0;
        Wed, 21 Jun 2023 18:06:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F14FB2766ADC9; Wed, 21 Jun 2023 18:06:55 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:06:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Message-ID: <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:31:15PM +0200, Arnd Bergmann wrote:

> I don't know much about x86 exception handling, but my guess is
> that this is where the stack overflows, so this backtrace
> is not all that useful. Looking at the full log from your link,
> I see that recursion through asm_exc_int3:
> 
> <4>[   49.886694]  ? exc_int3+0x62/0x80
> <4>[   49.886714]  ? asm_exc_int3+0x3e/0x50
> <4>[   49.886759]  ? preempt_count_sub+0x5/0x80
> <4>[   49.886783]  ? preempt_count_sub+0x5/0x80
> <4>[   49.886805]  ? irq_work_queue+0x40/0x80
> <4>[   49.886826]  ? defer_console_output+0x49/0x80
> <4>[   49.886840]  ? vprintk+0x42/0x60
> <4>[   49.886857]  ? _printk+0x5d/0x80
> <4>[   49.886891]  ? die+0x9c/0xe0
> <4>[   49.886922]  ? exc_int3+0x62/0x80
> <4>[   49.886942]  ? asm_exc_int3+0x3e/0x50

So this is exc_int3(), but it is past poke_int3_handler() which is the
counter-part of text_poke_bp_batch() -- die() seems to suggest we're
even past do_int3().

The fact that it continued past poke_int3_handler() suggests that it is
a 'stray' int3, not covered by an active text modification site.

> <4>[   49.886966]  ? __pfx_tick_sched_timer+0x10/0x10
> <4>[   49.886980]  ? __pfx_read_tsc+0x10/0x10
> <4>[   49.887010]  ? preempt_count_sub+0x5/0x80
> <4>[   49.887035]  ? preempt_count_sub+0x5/0x80
> <4>[   49.887057]  ? __hrtimer_run_queues+0xee/0x330
> <4>[   49.887070]  ? _raw_spin_unlock_irqrestore+0x28/0x50
> <4>[   49.887085]  ? __hrtimer_run_queues+0xee/0x330
> <4>[   49.887136]  ? hrtimer_interrupt+0xf6/0x390
> <4>[   49.887167]  ? __sysvec_apic_timer_interrupt+0x64/0x1a0
> <4>[   49.887189]  ? sysvec_apic_timer_interrupt+0x7a/0x90
> <4>[   49.887206]  </IRQ>
> <4>[   49.887219]  <TASK>
> <4>[   49.887231]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> <4>[   49.887252]  ? sched_rt_period_timer+0x4/0x390
> <4>[   49.887272]  ? __pfx_do_sync_core+0x10/0x10
> <4>[   49.887305]  ? insn_get_displacement+0x9/0x160
> <4>[   49.887329]  ? insn_get_displacement+0x9/0x160
> <4>[   49.887344]  ? insn_get_immediate+0xd2/0x270
> <4>[   49.887365]  ? insn_decode+0x113/0x150
> <4>[   49.887384]  ? text_poke_loc_init+0xea/0x220
> <4>[   49.887429]  ? sched_rt_period_timer+0x4/0x390
> <4>[   49.887451]  ? text_poke_queue+0x89/0xa0

This is the text_poke_queue() stage, it is still collecting sites to
poke but hasn't actually started yet. The actual poking happens in
text_poke_bp_batch(), which isn't in the call-chain afaict.

> <4>[   49.887477]  ? ftrace_replace_code+0x149/0x1f0
> <4>[   49.887508]  ? ftrace_modify_all_code+0x71/0x140
> <4>[   49.887533]  ? arch_ftrace_update_code+0xd/0x20
> <4>[   49.887550]  ? ftrace_shutdown+0xf5/0x220
> <4>[   49.887577]  ? unregister_ftrace_function+0x2e/0x150
> <4>[   49.887608]  ? stack_trace_sysctl+0x82/0xb0
> <4>[   49.887636]  ? proc_sys_call_handler+0x18b/0x280
> <4>[   49.887675]  ? proc_sys_write+0x17/0x20
> <4>[   49.887692]  ? vfs_write+0x324/0x3f0
> <4>[   49.887742]  ? ksys_write+0x75/0xe0
> <4>[   49.887771]  ? __x64_sys_write+0x1f/0x30
> <4>[   49.887787]  ? do_syscall_64+0x48/0xa0
> <4>[   49.887802]  ? sysvec_apic_timer_interrupt+0x4d/0x90
> <4>[   49.887822]  ? entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> <4>[   49.887878]  </TASK>
