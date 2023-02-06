Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C220F68C098
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBFO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBFO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:57:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADE166D1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:56:58 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:56:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675695416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDujTEnegc8pi7+IQ4fzDNueUc4Fzk0Yx9FbbxF0L5c=;
        b=PoO4FoelGMf6VzNr3vZVX+oYMvdS7wdpkcP4188MKSosfennt1i+ejyDHwAxWWnmFnRmi2
        HmghgRRnw5/prls2k+DP7U/mfI/Sue0ZN/3IwsXS6u+taLYSEGEeEBhflBtCi/DIRy+dd8
        49IdomJl3HaBRbQ5oQP8FdQenL7X750A0LMWbvw1D59PTbzSlZ87g+Bf4MKGpIkYgj2ePq
        TsQXgvzQZOtLD7uuz0pYm8qxt2nkFTdQsoP1yVdF5oazfCeBY7CSVEYPCnHOfxsZAcYIBA
        8kNM05+BFmETYZmH+8HCP1S84/+FBCCbMmfhBdVTkZHUWGl3UEKbUQq/vMc7Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675695416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDujTEnegc8pi7+IQ4fzDNueUc4Fzk0Yx9FbbxF0L5c=;
        b=SozKxp4L52cbBpcMsGRizja0MfBC5l+WI0sVR3hJaQK+QXwKjQdFBG+7bLhOQBxSDm/woY
        8nRHeGQZnAgNqmDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <Y+EVNz4ORkFSvTfP@linutronix.de>
References: <20230206130449.41360-1-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206130449.41360-1-wander@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-06 10:04:47 [-0300], Wander Lairson Costa wrote:
> Under PREEMPT_RT, __put_task_struct() indirectly acquires sleeping
> locks. Therefore, it can't be called from an non-preemptible context.
>=20
> One practical example is splat inside inactive_task_timer(), which is
> called in a interrupt context:

Do you have more?
The inactive_task_timer() is marked as HRTIMER_MODE_REL_HARD which means
in runs in hardirq-context. The author of commit
   850377a875a48 ("sched/deadline: Ensure inactive_timer runs in hardirq co=
ntext")

should have been aware of that.
We have on workaround of that put_task() in sched-switch. I wasn't aware
of this shortcoming. So either we have more problems or potential
problems or this is the only finding so far.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..532dd2ceb6a3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -857,6 +857,29 @@ void __put_task_struct(struct task_struct *tsk)
=E2=80=A6
> +void __put_task_struct(struct task_struct *tsk)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (!preemptible() || !in_task()))

Is it safe to use the rcu member in any case? If so why not use it
unconditionally?

> +		/*
> +		 * under PREEMPT_RT, we can't call put_task_struct
> +		 * in atomic context because it will indirectly
> +		 * acquire sleeping locks.
> +		 *
> +		 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +		 * to be called in process context.
> +		 */
> +		call_rcu(&tsk->rcu, delayed_put_task_struct_rcu);
> +	else
> +		___put_task_struct(tsk);
> +}
>  EXPORT_SYMBOL_GPL(__put_task_struct);
> =20
>  void __init __weak arch_task_cache_init(void) { }

Sebastian
