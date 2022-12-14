Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6E64D17F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLNUwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLNUwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:52:09 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B213CF2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:52:07 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id s25so7956330lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzau3A4p+Noit6rG2cYhKf7r8sTOuVsFijjDM6QgMlY=;
        b=tatXVsoOXL+DnvrYuMuy9nweHn/UCOuT9SAsRbK93DuAdWtfCJdyVi620ETPz4AByj
         UtinAJJknhxSKxHghMySR74N4BC9SvQfz13Dz3U+Mtkz8/ygaMyTjW7OmBwfqmgXR0pt
         XXsj9F/yf0R5ChRIGrvmqM67LjusXCLfn0pvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzau3A4p+Noit6rG2cYhKf7r8sTOuVsFijjDM6QgMlY=;
        b=ELKj7vuCr7D4SWFc56KPrvyi8EoWRgrhMwd2PqaUaNPk5HKLMY98d8mW4bcZGAsw8J
         t8g+m6WtuSwCVlKv4XXeaASL5jHl0kDSWZSClyRVwvqhBh11DA0hAMLnG9mb9NnFXCH0
         0Z3gilTmll/aIR1SfCQO91js85UuUXuE7jaAOE1EXKG9lQEanPPaefDB1aePUdD4FjUc
         bm8Dk9NWRy6xUNQe6XEYUkhOE2SI8cNAiErS7HxMXDlCoUQjbWql3m1E0fV8Ip+qbiXO
         0UNILyyJigKcspNoj2Uw15RL9FxgCw27JsX4UN93R5hXvZkti/uKeENpsxWO9QDXiqwc
         y0yA==
X-Gm-Message-State: ANoB5pkWNFzk6fpfCYAxp8RIdv3c9g3jhIm6HhsIdGXUsN1J4MX+bsRk
        3sgjyjzoq315OX+Oh0ay6JuscC5og0ucl0S8xg8vZw==
X-Google-Smtp-Source: AA0mqf7wpFBYWvR8ZCOZCgrt193lIJz1nSQ8l2gmhwzyqfrpM9fWuOx4ZHuckZHwcWWZ5xkr3p5em4w90DjxM+AgSuM=
X-Received: by 2002:a2e:a793:0:b0:27a:3e05:430d with SMTP id
 c19-20020a2ea793000000b0027a3e05430dmr1515030ljf.313.1671051126003; Wed, 14
 Dec 2022 12:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 14 Dec 2022 15:51:54 -0500
Message-ID: <CAEXW_YTztHvaXJG9jQmQ13tF2HdCy8+TbvBDCYWd98tMrsE-vw@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     boqun.feng@gmail.com, frederic@kernel.org, neeraj.iitr10@gmail.com,
        urezki@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Dec 14, 2022 at 2:13 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> The comment in srcu_readers_active_idx_check() following the smp_mb()
> is out of date, hailing from a simpler time when preemption was disabled
> across the bulk of __srcu_read_lock().  The fact that preemption was
> disabled meant that the number of tasks that had fetched the old index
> but not yet incremented counters was limited by the number of CPUs.
>
> In our more complex modern times, the number of CPUs is no longer a limit.
> This commit therefore updates this comment, additionally giving more
> memory-ordering detail.
>
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Reported-by: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
> Reported-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 68b8d8b150db1..ba12c50ee3658 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -469,24 +469,53 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
>
>         /*
>          * If the locks are the same as the unlocks, then there must have
> -        * been no readers on this index at some time in between. This does
> -        * not mean that there are no more readers, as one could have read
> -        * the current index but not have incremented the lock counter yet.
> +        * been no readers on this index at some point in this function.
> +        * But there might be more readers, as a task might have read
> +        * the current ->srcu_idx but not yet have incremented its CPU's
> +        * ->srcu_lock_count[idx] counter.  In fact, it is possible
> +        * that most of the tasks have been preempted between fetching
> +        * ->srcu_idx and incrementing ->srcu_lock_count[idx].  And there
> +        * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
> +        * in a system whose address space was fully populated with memory.
> +        * Call this quantity Nt.

If I understand correctly, here we are saying ULONG_MAX bytes is the
total theoretical size of memory right? So we cannot have more than Nt
tasks preempted.

>          *
> -        * So suppose that the updater is preempted here for so long
> -        * that more than ULONG_MAX non-nested readers come and go in
> -        * the meantime.  It turns out that this cannot result in overflow
> -        * because if a reader modifies its unlock count after we read it
> -        * above, then that reader's next load of ->srcu_idx is guaranteed
> -        * to get the new value, which will cause it to operate on the
> -        * other bank of counters, where it cannot contribute to the
> -        * overflow of these counters.  This means that there is a maximum
> -        * of 2*NR_CPUS increments, which cannot overflow given current
> -        * systems, especially not on 64-bit systems.
> +        * So suppose that the updater is preempted at this point in the
> +        * code for a long time.  That now-preempted updater has already
> +        * flipped ->srcu_idx (possibly during the preceding grace period),
> +        * done an smp_mb() (again, possibly during the preceding grace
> +        * period), and summed up the ->srcu_unlock_count[idx] counters.
> +        * How many times can a given one of the aforementioned Nt tasks
> +        * increment the old ->srcu_idx value's ->srcu_lock_count[idx]
> +        * counter, in the absence of nesting?
>          *
> -        * OK, how about nesting?  This does impose a limit on nesting
> -        * of floor(ULONG_MAX/NR_CPUS/2), which should be sufficient,
> -        * especially on 64-bit systems.
> +        * It can clearly do so once, given that it has already fetched
> +        * the old value of ->srcu_idx and is just about to use that value
> +        * to index its increment of ->srcu_lock_count[idx].  But as soon as
> +        * it leaves that SRCU read-side critical section, it will increment
> +        * ->srcu_unlock_count[idx], which must follow the updater's above
> +        * read from that same value.  Thus, as soon the reading task does
> +        * an smp_mb() and a later fetch from ->srcu_idx, that task will be
> +        * guaranteed to get the new index.  Except that the increment of
> +        * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
> +        * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
> +        * is before the smp_mb().  Thus, that task might not see the new
> +        * value of ->srcu_idx until the -second- __srcu_read_lock(),
> +        * which in turn means that this task might well increment
> +        * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
> +        * not just once.
> +        *
> +        * That is, there can be almost 2 * Nt further increments of
> +        * ->srcu_lock_count[idx] for the old index.  But this is OK because

s/almost/atmost/ ?

and also, I think you need 1 smp_mb() per CPU to reflect the update to
the per-cpu counter, so it min(2 * Nt, number of CPUs) which I think
is much smaller, but that is ok to not mention.

> +        * the size of the task_struct structure limits the value of Nt.
> +        *
> +        * OK, but what about nesting?  This does impose a limit on
> +        * nesting of half of the size of the task_struct structure
> +        * (measured in bytes), which should be sufficient.  A late 2022

Does nesting here mean one SRCU reader section nested within another?
With this definition of nesting, is it not possible for a single task
to increment the 'lock' counter any number of times before getting
preempted?

> +        * TREE01 rcutorture run reported this size to be no less than
> +        * 9408 bytes, allowing up to 4704 levels of nesting, which is
> +        * comfortably beyond excessive.  Especially on 64-bit systems,
> +        * which are unlikely to be configured with an address space fully
> +        * populated with memory, at least not anytime soon.
>          */

Below is a summary from my point of view. Please correct me if I'm
wrong. I was trying to reason that we only need to care about waiting
for readers that sample idx *after* srcu_read_lock() issued smp_mb().

The case to consider a race between readers and
srcu_readers_active_idx_check() IMO is when a reader samples idx,
issues smp_mb() enters its RSCS. If it does not do smp_mb(), its RSCS
need not be waited on as it is not considered to be entered from a
global memory PoV.  Assuming it did issue the smp_mb() in
srcu_read_lock() and then got preempted (which IMO is the only case to
care about the reader for), and say the first scan failed to track
down this in-flight RSCS. The first scan can fail to track the RSCS
for 2 reasons:

#1. The idx being scanned in the first scan is the one that the reader
did not sample.
#2. The smp_mb() in the first scan's srcu_readers_active_idx_check()
happened *before* the smp_mb() post-counter increment in
srcu_read_lock().

In case of #2, the first scan was too early and the second scan will
not even look at this idx as it gets flipped. So we can safely assume
in #2 that this RSCS need not be waited on and was too early. IOW, the
grace period started before the RSCS, so tough luck for that RSCS.

So AFAICS, case #1 is the only one that matters for consideration of
race. In this case, we will rely on the second scan and assume that we
"need to do the right thing" for the case where the srcu_read_lock()'s
smp_mb() happened *before* the second scan's smp_mb() and the idx
being reader-occupied is supposed to be properly nailed down by the
second scan. In this case, the second scan *will* see the lock count
increment of all in-flight readers, preempted or otherwise, because of
the smp_mb() it issues prior to sampling all the lock counts of the
flipped idx.  And upto Nt number of increments can be "caught" by the
second scan, before a wrap around fools it into believing the Nt
readers don't need any love, quiet to their detriment.

I also did not get why you care about readers that come and ago (you
mentioned the first reader seeing incorrect idx and the second reader
seeing the right flipped one, etc). Those readers are irrelevant
AFAICS since they came and went, and need not be waited on , right?.

Thanks for the discussions today!

thanks,

  - Joel

>         return srcu_readers_lock_idx(ssp, idx) == unlocks;
>  }
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index ee8a6a711719a..399c818fe47ce 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4900,6 +4900,7 @@ void __init rcu_init(void)
>         // Kick-start any polled grace periods that started early.
>         if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
>                 (void)start_poll_synchronize_rcu_expedited();
> +       pr_alert("sizeof(struct task_struct) = %lu\n", sizeof(struct task_struct));
>  }
>
>  #include "tree_stall.h"
