Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8B06E60F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjDRMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjDRMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:16:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FA73580
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:16:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681820172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SbfVCxQkPCMEbMiCeEKOWEBgvAaqYdww9xSC7ukJlN0=;
        b=sw4bDGCqlcYiJsWKnNpRtww2/uFO4heCem2hznP04bzy8vFvEWmfIwXJtJqBBjDgCiz+Mb
        T+iaE6ozzkRqPkphNpz2HpgawcyqLbxuhH7u5RKj3flWYQu675fs0p6sRXFVvSDi5kywMA
        /M9oM2GcrTMXYfiocynvipoe1cb84d2OlRBwQ1uGCsYcqGn33jgWmmUFeMDeqAeMTV0xMO
        E2gIqdRm78rkmlThWP1CfIoZfK0/aklnlk5+563gJti/Zw0eU3B4o1eunAE+xHuBM3h+pG
        kf+R0OEp0dKOdZhEXF3AjxAERmu/DQjRtWiwJxB9id3RuNYO6ys7XN5Sn0MBgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681820172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SbfVCxQkPCMEbMiCeEKOWEBgvAaqYdww9xSC7ukJlN0=;
        b=ktHPUesE5gTBgC2r0/03ayhPF1qLzLdA5OmmM/rOi5psNuO1sPZp8v/InZ35hb6Z+e6gX6
        IQcawWjYsuPy49Bw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC] preempt: Put preempt_enable() within an
 instrumentation*() section.
In-Reply-To: <20230309072724.3F6zRkvw@linutronix.de>
References: <20230309072724.3F6zRkvw@linutronix.de>
Date:   Tue, 18 Apr 2023 14:16:11 +0200
Message-ID: <87fs8x4c8k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09 2023 at 08:27, Sebastian Andrzej Siewior wrote:
> Callers of preempt_enable() can be within an noinstr section leading to:
> | vmlinux.o: warning: objtool: native_sched_clock+0x97: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: kvm_clock_read+0x22: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: local_clock+0xb4: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section

> | vmlinux.o: warning: objtool: enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x140: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0xf2: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section 

I'm confused where this preempt_enable is in those
*_enter_from_user_mode() functions.

Kernel config and compiler version please.

>  #define preempt_enable() \
>  do { \
>  	barrier(); \
> -	if (unlikely(preempt_count_dec_and_test())) \
> +	if (unlikely(preempt_count_dec_and_test())) { \
> +		instrumentation_begin(); \
>  		__preempt_schedule(); \
> +		instrumentation_end(); \
> +	} \
>  } while (0)

This would paper over a misplaced preempt_disable/enable() pair in
noinstr code. I'm not really happy about that.

Thanks,

        tglx
