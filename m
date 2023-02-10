Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA63969240D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBJRJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjBJRJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:09:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848361D20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:08:50 -0800 (PST)
Date:   Fri, 10 Feb 2023 18:08:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676048929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PXWRKDtM0vwcjRCmXqGmFFt3DGCl+KfkQiOlBGqx1c=;
        b=K+qyG8R4ZiHfQrBuQl8tYT/sv4M0UnNV9K+6HXOfds+8J28ZDPV0r/RXp0wps1giJlN4Q+
        Fau11McXznowC70+/aVV9VCXABCIzUK4XJpfUeZKxDOgPSIWmnc8eGud7eJOAuaw6V2QCS
        HBN73AAPxKQIjPEPUYGECCmJJUKSStzGm4LR3DVzu/rowqXkWzgsrgGi7SwOmLK84mJSI4
        sZ364VRWEGptzXPG5GMcgM3EZDQ0acQCbbiJUltCmGxGRToUudu1qmCcZPfPcf/9zWx7X5
        BAebH5wSsSUMuLgFUfCKl1R3Hg+1j27RHzvFXzx5xhaqxvuEbWdqpTBAViC5ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676048929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PXWRKDtM0vwcjRCmXqGmFFt3DGCl+KfkQiOlBGqx1c=;
        b=Y0UJUj7a9jPLyBfGY8wpU1XgZgI5p2TjvRwzaS7AEHV8a/51lY+isa4fRR1270zt5BVe56
        LBLpwrHDtsu0HDDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Hu Chunyu <chuhu@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v4] kernel/fork: beware of __put_task_struct calling
 context
Message-ID: <Y+Z6H4eiWChxHF4a@linutronix.de>
References: <20230206130449.41360-1-wander@redhat.com>
 <20230206170927.9d5afee653dfa0738983dbfa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206170927.9d5afee653dfa0738983dbfa@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 17:09:27 [-0800], Andrew Morton wrote:
> On Mon,  6 Feb 2023 10:04:47 -0300 Wander Lairson Costa <wander@redhat.com> wrote:
> 
> > Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> > locks. Therefore, it can't be called from an non-preemptible context.
> 
> Well that's regrettable.  Especially if non-preempt kernels don't do
> this.

Non-preemptible context on PREEMPT_RT. Interrupts handler and timers
don't count as non-preemptible because interrupt handler are threaded
and hrtimers are invoked in softirq context (which is preemptible on
PREEMPT_RT).

This here is different because the hrtimer in question was marked as
HRTIMER_MODE_REL_HARD. In this case it is invoked in hardirq context as
requested with all the problems that follow.

> Why does PREEMPT_RT do this and can it be fixed?

PREEMPT_RT tries to move as much as it can out of hardirq context into
preemptible context. A spinlock_t is preemptible on PREEMPT_RT while
it is not in other preemption models. The scheduler needs to use
raw_spinlock_t in order to be able to schedule a task from
hardirq-context without a deadlock.
For memory allocation only sleeping locks (spinlock_t) is used since
there are no memory allocation/ deallocation on PREEMPT_RT in hardirq
context. These two need to be separated.

> If it cannot be fixed then we should have a might_sleep() in
> __put_task_struct() for all kernel configurations, along with an
> apologetic comment explaining why.

__put_task_struct() should not be invoked in atomic context on
PREEMPT_RT. It is fine however in a regular timer hrtimer. Adding
might_sleep() will trigger a lot of false positives on a preemptible
kernel and RT.

A might_lock() on a spinlock_t should do the trick from LOCKDEP
perspective if CONFIG_PROVE_RAW_LOCK_NESTING is enabled.
In this case it should be visible due to rq-lock or due to hrtimer.

Sebastian
