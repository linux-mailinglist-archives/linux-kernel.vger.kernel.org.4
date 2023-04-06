Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37F96DA18D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjDFThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbjDFTht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:37:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9D93EB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:37:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680809861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=favdqIENNaDRfSmkC30oxkY4bWGc0KOI6FH54pc0iYU=;
        b=3VghqapWsLDJImLuOzn1LnT84YNqHwtl2rRs1514BjtBJNJLZbaiQu5DRQ4TfYeTK6MKgN
        plzcfOwNp/usoKOspMWNn6YJ8zIu39jbdvBG+T1LhV4TWayCgCI3VLe665XeBj4l2ce0tw
        KkF6i3J1+jht3Cb+r0f5OWNxwN1jWJElUFjCvaUX1ETyBP/DS9DLDn5Mvf1qUyOBmAPzKU
        HhLVxm+R3IDr9PgKRJF4sxJPM/7zpWDmeGMOAsz/EXXtKKRAlvFhSs14CuxwwQilZS9vP6
        Ic0Y6P2ayWEItdQGFLgVpnVZ8x9vVij/fPYIh/YvwQ6eNYeqtBA3v+VygsReIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680809861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=favdqIENNaDRfSmkC30oxkY4bWGc0KOI6FH54pc0iYU=;
        b=Hp4yRgQL/ho1lkuOMEDwW1XY2hYyJ7ssQFZW+UhTVH5gjrP5CMiw1qRnK8omoX0V/fwo8A
        416acZyeyCwo0tAw==
To:     Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARNING in timer_wait_running
In-Reply-To: <ZC3z2UhQeXENKvrb@lothringen>
References: <000000000000566d5405ae2f6f70@google.com>
 <ZC3jDC6R/SGLk5vj@elver.google.com> <ZC3z2UhQeXENKvrb@lothringen>
Date:   Thu, 06 Apr 2023 21:37:40 +0200
Message-ID: <87h6tsred7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06 2023 at 00:19, Frederic Weisbecker wrote:
> On Wed, Apr 05, 2023 at 11:07:24PM +0200, Marco Elver wrote:
>> Up-to-date warning:
>> 
>>  | WARNING: CPU: 1 PID: 6695 at kernel/time/posix-timers.c:849 timer_wait_running+0x255/0x290 kernel/time/posix-timers.c:849
>> 
>> Why is it wrong for timer_wait_running to be NULL?
>
> It appears to concern clock_posix_cpu which indeed doesn't implement
> ->timer_wait_running even though posix_cpu_timer_set() might return
> TIMER_RETRY if the timer is about to fire.
>
> Then on RT and if CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y then
> timer_wait_running() must busy loop waiting for the task to complete
> the task work.
>
> We could arrange for doing the same thing as hrtimer_cancel_wait_running()
> but for posix cpu timers, with taking a similar lock within
> handle_posix_cpu_timers() that timer_wait_running() could sleep on and
> inject its PI into.

I have a faint memory that we discussed something like that, but there
was an issue which completely escaped my memory.

But yes, something like this could work.

Though we should quickly shut this warning up for the !RT case by
providing an callback which does

  WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT);

and let the RT folks deal with it.

Thanks,

        tglx
