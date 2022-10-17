Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD63600535
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 04:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJQCXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 22:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJQCXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CBC4448F
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:23:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id t25so5889390qkm.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgvzfTo10fUh6wL0Be86sWN8sYva4oru+ZVyiKWp+7o=;
        b=bJfwht3rs+702qTg88rThp0SVceTHUIu8QoBQUe98sLXZ/TAcNBy80z76iyqgro1cm
         avnocQr6OftIjGrc5MT18zQKIQ8UNeIS8Ex/vaNAxit025upC/utdcKezqe/xH/MD8IW
         9wcVzV97GcGFbwHry3wbdIjt3YKipTh8HxNDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgvzfTo10fUh6wL0Be86sWN8sYva4oru+ZVyiKWp+7o=;
        b=o6GiNs2Ujc75ZsprI/zgOcn0GxxOpeCKAWV7oq6kgGkpnzaj7g8rmQFsPPXV0Ji6pN
         BsCSE1Aqa+cHltQBFdUe5cFR6HQDBtArQrAnTs23qAezEtEqGPnh+tBRZmYU/R1cwfUZ
         Lbaq7OXCuQztH0YWhJ0ri3yStXJ0H7aJa5dSMritZyCQ9o9j2jalqYFpkoADeFMvp008
         UWtg2ZzuOYIMTuQT9xmQhW45sEiMOB+QHez6ga6LzQRlPC5Ya7odNkCRYs2Lr7NwSqhb
         2ND/t+YDwPgI9ew0f0Km08/974IE1Ooh2cwyJ4e/ijlV8RqujlA9t0g83BCgNpUq95zs
         BlXg==
X-Gm-Message-State: ACrzQf1004muadjxCEKca+lCu6DqIB2TMyZP7xuQBUL4RW3t0KmLTxAh
        GhkX93XT9DHTvPYEKs/vsj/LrQ==
X-Google-Smtp-Source: AMsMyM6QsYzM0328aIAcELidgvLZlM6ZbJs6rGiVe2Rmyo0+aoan5RxpfFbPPe56XwOa00ubfTqbAQ==
X-Received: by 2002:a37:e205:0:b0:6ee:834:1a1b with SMTP id g5-20020a37e205000000b006ee08341a1bmr6052061qki.342.1665973386420;
        Sun, 16 Oct 2022 19:23:06 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id b26-20020ac8679a000000b00393c2067ca6sm6847097qtp.16.2022.10.16.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:06 -0700 (PDT)
Date:   Mon, 17 Oct 2022 02:23:05 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Connor O'Brien <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 00/11] Reviving the Proxy Execution Series
Message-ID: <Y0y8iURTSAv7ZspC@google.com>
References: <20221003214501.2050087-1-connoro@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003214501.2050087-1-connoro@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 09:44:50PM +0000, Connor O'Brien wrote:
> Proxy execution is an approach to implementing priority inheritance
> based on distinguishing between a task's scheduler context (information
> required in order to make scheduling decisions about when the task gets
> to run, such as its scheduler class and priority) and its execution
> context (information required to actually run the task, such as CPU
> affinity). With proxy execution enabled, a task p1 that blocks on a
> mutex remains on the runqueue, but its "blocked" status and the mutex on
> which it blocks are recorded. If p1 is selected to run while still
> blocked, the lock owner p2 can run "on its behalf", inheriting p1's
> scheduler context. Execution context is not inherited, meaning that
> e.g. the CPUs where p2 can run are still determined by its own affinity
> and not p1's.
> 
> In practice a number of more complicated situations can arise: the mutex
> owner might itself be blocked on another mutex, or it could be sleeping,
> running on a different CPU, in the process of migrating between CPUs,
> etc. Details on handling these various cases can be found in patch 7/11
> ("sched: Add proxy execution"), particularly in the implementation of
> proxy() and accompanying comments.
> 
> Past discussions of proxy execution have often focused on the benefits
> for deadline scheduling. Current interest for Android is based more on
> desire for a broad solution to priority inversion on kernel mutexes,
> including among CFS tasks. One notable scenario arises when cpu cgroups
> are used to throttle less important background tasks. Priority inversion
> can occur when an "important" unthrottled task blocks on a mutex held by
> an "unimportant" task whose CPU time is constrained using cpu
> shares. The result is higher worst case latencies for the unthrottled
> task.[0] Testing by John Stultz with a simple reproducer [1] showed
> promising results for this case, with proxy execution appearing to
> eliminate the large latency spikes associated with priority
> inversion.[2]
> 
> Proxy execution has been discussed over the past few years at several
> conferences[3][4][5], but (as far as I'm aware) patches implementing the
> concept have not been discussed on the list since Juri Lelli's RFC in
> 2018.[6] This series is an updated version of that patchset, seeking to
> incorporate subsequent work by Juri[7], Valentin Schneider[8] and Peter
> Zijlstra along with some new fixes.
> 
> Testing so far has focused on stability, mostly via mutex locktorture
> with some tweaks to more quickly trigger proxy execution bugs. These
> locktorture changes are included at the end of the series for
> reference. The current series survives runs of >72 hours on QEMU without
> crashes, deadlocks, etc. Testing on Pixel 6 with the android-mainline
> kernel [9] yields similar results. In both cases, testing used >2 CPUs
> and CONFIG_FAIR_GROUP_SCHED=y, a configuration Valentin Schneider
> reported[10] showed stability problems with earlier versions of the
> series.
> 
> That said, these are definitely still a work in progress, with some
> known remaining issues (e.g. warnings while booting on Pixel 6,
> suspicious looking min/max vruntime numbers) and likely others I haven't
> found yet. I've done my best to eliminate checks and code paths made
> redundant by new fixes but some probably remain. There's no attempt yet
> to handle core scheduling. Performance testing so far has been limited
> to the aforementioned priority inversion reproducer. The hope in sharing
> now is to revive the discussion on proxy execution and get some early
> input for continuing to revise & refine the patches.

I ran a test to check CFS time sharing. The accounting on top is confusing,
but ftrace confirms the proxying happening.

Task A - pid 122
Task B - pid 123
Task C - pid 121
Task D - pid 124

Here D and B just spin all the time. C is lock owner (in-kernel mutex) and
spins all the time, while A blocks on the same in-kernel mutex and remains
blocked.

Then I did "top -H" while the test was running which gives below output.
The first column is PID, and the third-last column is CPU percentage.

Without PE:
  121 root      20   0   99496   4   0 R  33.6   0.0   0:02.76 t  (task C)
  123 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task B)
  124 root      20   0   99496   4   0 R  33.2   0.0   0:02.75 t  (task D)

With PE:
  PID
  122 root      20   0   99496   4   0 D  25.3   0.0   0:22.21 t  (task A)
  121 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task C)
  123 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task B)
  124 root      20   0   99496   4   0 R  25.0   0.0   0:22.20 t  (task D)

With PE, I was expecting 2 threads with 25% and 1 thread with 50%. Instead I
get 4 threads with 25% in the top. Ftrace confirms that the D-state task is
in fact not running and proxying to the owner task so everything seems
working correctly, but the accounting seems confusing, as in, it is confusing
to see the D-state task task taking 25% CPU when it is obviously "sleeping".

Yeah, yeah, I know D is proxying for C (while being in the uninterruptible
sleep state), so may be it is OK then, but I did want to bring this up :-)

thanks,

 - Joel


> [0] https://raw.githubusercontent.com/johnstultz-work/priority-inversion-demo/main/results/charts/6.0-rc7-throttling-starvation.png
> [1] https://github.com/johnstultz-work/priority-inversion-demo
> [2] https://raw.githubusercontent.com/johnstultz-work/priority-inversion-demo/main/results/charts/6.0-rc7-vanilla-vs-proxy.png
> [3] https://lpc.events/event/2/contributions/62/
> [4] https://lwn.net/Articles/793502/
> [5] https://lwn.net/Articles/820575/
> [6] https://lore.kernel.org/lkml/20181009092434.26221-1-juri.lelli@redhat.com/
> [7] https://github.com/jlelli/linux/tree/experimental/deadline/proxy-rfc-v2
> [8] https://gitlab.arm.com/linux-arm/linux-vs/-/tree/mainline/sched/proxy-rfc-v3/
> [9] https://source.android.com/docs/core/architecture/kernel/android-common
> [10] https://lpc.events/event/7/contributions/758/attachments/585/1036/lpc20-proxy.pdf#page=4
> 
> Connor O'Brien (2):
>   torture: support randomized shuffling for proxy exec testing
>   locktorture: support nested mutexes
> 
> Juri Lelli (3):
>   locking/mutex: make mutex::wait_lock irq safe
>   kernel/locking: Expose mutex_owner()
>   sched: Fixup task CPUs for potential proxies.
> 
> Peter Zijlstra (4):
>   locking/ww_mutex: Remove wakeups from under mutex::wait_lock
>   locking/mutex: Rework task_struct::blocked_on
>   sched: Split scheduler execution context
>   sched: Add proxy execution
> 
> Valentin Schneider (2):
>   kernel/locking: Add p->blocked_on wrapper
>   sched/rt: Fix proxy/current (push,pull)ability
> 
>  include/linux/mutex.h        |   2 +
>  include/linux/sched.h        |  15 +-
>  include/linux/ww_mutex.h     |   3 +
>  init/Kconfig                 |   7 +
>  init/init_task.c             |   1 +
>  kernel/Kconfig.locks         |   2 +-
>  kernel/fork.c                |   6 +-
>  kernel/locking/locktorture.c |  20 +-
>  kernel/locking/mutex-debug.c |   9 +-
>  kernel/locking/mutex.c       | 109 +++++-
>  kernel/locking/ww_mutex.h    |  31 +-
>  kernel/sched/core.c          | 679 +++++++++++++++++++++++++++++++++--
>  kernel/sched/deadline.c      |  37 +-
>  kernel/sched/fair.c          |  33 +-
>  kernel/sched/rt.c            |  63 ++--
>  kernel/sched/sched.h         |  42 ++-
>  kernel/torture.c             |  10 +-
>  17 files changed, 955 insertions(+), 114 deletions(-)
> 
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
