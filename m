Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B31E5FF665
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJNWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:33:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA691CA598
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:33:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id u21so8644082edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaNP/MqQA2XMTgLWSG4/mQLvCDK3B3VNCmOC9wOcOHQ=;
        b=TmtbDeAmgFHSc13cB9cetc8+6ZowCMa1TPxsmAutaFi30L5J/iW3J4/OAEzWaMQzMs
         aelkLJJjYi4dLNuR0mtVxEb/kUJ163wK0H/yi0r4AjG90XHvLX7j3QxZN56SrEcP31aX
         gy9qxgDQUtW6As1ci3L5/IWV1KbFAd17Zj46yN6TWjMxiWfsu4FpO5f005r9AXIDv2GV
         bTajzK8TqElbusc/gmU5gEwlmcUviNH5anLyvZ3MH6L/iR3ZDph/r36eMSbhvIOSYCry
         1Rsv6Q4OPrgowea3eeeO4jDZ5CvHAGzr1fs/V1kSHY4Fiae2VDD+E1HpCbjah8mzU5wL
         pxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaNP/MqQA2XMTgLWSG4/mQLvCDK3B3VNCmOC9wOcOHQ=;
        b=gQxljsMwj7GPRJuVIs3S3ovTAkiV44ICkFE+uSa6k+cJ/BG3ZiX7EpgnHLeEssYkrF
         6/PT05/d3WrgyNMBI0MqkdEA31lkb34i6EaQdwPbIxl7OcQEVgw+oRk8s30d6Xfguejl
         3UZeNIPbM7MafFyjI5KM9MM76A0WZs2DOmy9vUl7EqGGD/BFWzJix1wlB6Ffw46M8Gap
         x3mzEKFwDczf+AzsVYTDte6aU3NY5GBiWjA2Zk1Zt02+b2ZtCh2KBP4O3ZEtq9I7p4t9
         tHeqMxmAu/2u+N8A728Ma7evuJGy4mfc3VK6a+kKAuu24/FrMBbo7FzjBe+Dv30XSnIO
         NrzA==
X-Gm-Message-State: ACrzQf2va/4OIVJPpYAIve2Tq1SQdx4uwcrUy1EDlhWB7kl121Y2rgnW
        veIMLkl1ZORBysu/CEkfv5XiJOuoI9U5PlgxzfAJ+Q==
X-Google-Smtp-Source: AMsMyM5Il2dSY78/IPh/jxR+1OV0Jm67N3rIlljJPoCOTV8rUj2vVbWVWx/+MxtFv4RnUkX0WImbL9EJQ2jekSfDMfQ=
X-Received: by 2002:aa7:c792:0:b0:453:98b7:213c with SMTP id
 n18-20020aa7c792000000b0045398b7213cmr18541eds.159.1665786788233; Fri, 14 Oct
 2022 15:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-10-connoro@google.com>
 <xhsmhv8orgb59.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhv8orgb59.mognet@vschneid.remote.csb>
From:   "Connor O'Brien" <connoro@google.com>
Date:   Fri, 14 Oct 2022 15:32:56 -0700
Message-ID: <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 4:40 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 03/10/22 21:44, Connor O'Brien wrote:
> > From: Valentin Schneider <valentin.schneider@arm.com>
>
> This was one of my attempts at fixing RT load balancing (the BUG_ON in
> pick_next_pushable_task() was quite easy to trigger), but I ended up
> convincing myself this was insufficient - this only "tags" the donor and
> the proxy, the entire blocked chain needs tagging. Hopefully not all of
> what I'm about to write is nonsense, some of the neurons I need for this
> haven't been used in a while - to be taken with a grain of salt.
Made sense to me! Thanks, this was really helpful for understanding
the interactions between proxy execution & load balancing.
>
> Consider pick_highest_pushable_task() - we don't want any task in a blocked
> chain to be pickable. There's no point in migrating it, we'll just hit
> schedule()->proxy(), follow p->blocked_on and most likely move it back to
> where the rest of the chain is. This applies any sort of balancing (CFS,
> RT, DL).
>
> ATM I think PE breaks the "run the N highest priority task on our N CPUs"
> policy. Consider:
>
>    p0 (FIFO42)
>     |
>     | blocked_on
>     v
>    p1 (FIFO41)
>     |
>     | blocked_on
>     v
>    p2 (FIFO40)
>
>   Add on top p3 an unrelated FIFO1 task, and p4 an unrelated CFS task.
>
>   CPU0
>   current:  p0
>   proxy:    p2
>   enqueued: p0, p1, p2, p3
>
>   CPU1
>   current:  p4
>   proxy:    p4
>   enqueued: p4
>
>
> pick_next_pushable_task() on CPU0 would pick p1 as the next highest
> priority task to push away to e.g. CPU1, but that would be undone as soon
> as proxy() happens on CPU1: we'd notice the CPU boundary and punt it back
> to CPU0. What we would want here is to pick p3 instead to have it run on
> CPU1.

Given this point, is there any reason that blocked tasks should ever
be pushable, even if they are not part of the blocked chain for the
currently running task? If we could just check task_is_blocked()
rather than needing to know whether the task is in the middle of the
"active" chain, that would seem to simplify things greatly. I think
that approach might also require another dequeue/enqueue, in
ttwu_runnable(), to catch non-proxy blocked tasks becoming unblocked
(and therefore pushable), but that *seems* OK...though I could
certainly be missing something.

A related load balancing correctness question that caught my eye while
taking another look at this code: when we have rq->curr != rq->proxy
and then rq->curr is preempted and switches out, IIUC rq->curr should
become pushable immediately - but this does not seem to be the case
even with this patch. Is there a path that handles this case that I'm
just missing, or a reason that no special handling is needed?
Otherwise I wonder if __schedule() might need a dequeue/enqueue for
the prev task as well in this case.
>
> I *think* we want only the proxy of an entire blocked-chain to be visible
> to load-balance, unfortunately PE gathers the blocked-chain onto the
> donor's CPU which kinda undoes that.
>
> Having the blocked tasks remain in the rq is very handy as it directly
> gives us the scheduling context and we can unwind the blocked chain for the
> execution context, but it does wreak havock in load-balancing :/
>
