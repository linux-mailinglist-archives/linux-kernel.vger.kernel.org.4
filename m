Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1B064918A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 00:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiLJXan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 18:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 18:30:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411EFDF26
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 15:30:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670715036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQUtA/o32bo53tf1Eepa0K5uzactmbN/psEIDg7UwN8=;
        b=3nzezORCzAp5TL6d+IFZGytwxYpF73cyzdk9LmAjNtTF3oYQsbLpU/btACkdb/EZ4DpCoT
        PJasKHAkUSuBR6Pk2bxkllxRnV+OBzDHvVS1whFzWmYDjLlf2ZHSdKW+GdmqbtqvTFWDR2
        1ghhyddCEawoRycSgq/uXFUBZ8FYEUiqe9wIuVpl26cGvUswuP6RR4RVwUm3Siv2v9NH1q
        h8S3zvZX3cVOKFJiv0X/p41EhIITAQ5Fc4pf1pO38nruB6jtnYBMOTSIKE4js188SlFkFw
        7ftrJG+XlsJ8oggQp8zwozo+WJG/iKI+hT8NV6Ewmpknb6iFo8yI0xYwIJkcsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670715036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qQUtA/o32bo53tf1Eepa0K5uzactmbN/psEIDg7UwN8=;
        b=cGQGwaUmqIUxzjyoBKcxX7uAyriyRKIknKJyTPLHuDoykv7ag2XoT6OzfT5YSE/5czA07Y
        oWkBM/gdtezRr7CA==
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [for-next][PATCH 13/25] x86/mm/kmmio: Use
 rcu_read_lock_sched_notrace()
In-Reply-To: <20221210133425.4657985e@gandalf.local.home>
References: <20221210135750.425719934@goodmis.org>
 <20221210135825.241167123@goodmis.org>
 <20221210174753.GD4001@paulmck-ThinkPad-P17-Gen-1>
 <20221210133425.4657985e@gandalf.local.home>
Date:   Sun, 11 Dec 2022 00:30:36 +0100
Message-ID: <87359mdeg3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10 2022 at 13:34, Steven Rostedt wrote:
> On Sat, 10 Dec 2022 09:47:53 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>> This does mess with preempt_count() redundantly, but the overhead from
>> that should be way down in the noise.
>
> I was going to remove it, but then I realized that it would be a functional
> change, as from the comment above, it uses "preempt_enable_no_resched(),
> which there is not a rcu_read_unlock_sched() variant.

preempt_enable_no_resched() in this context is simply garbage.

preempt_enable_no_resched() tries to avoid the overhead of checking
whether rescheduling is due after decrementing preempt_count() because
the code which it this claims to know that it is _not_ the outermost one
which brings preempt count back to preemtible state.

I concede that there are hot paths which actually can benefit, but this
code has exactly _ZERO_ benefit from that. Taking that tracing exception
and handling it is orders of magnitudes more expensive than a regular
preempt_enable().

So just get rid of it and don't proliferate cargo cult programming.

Thanks,

        tglx


