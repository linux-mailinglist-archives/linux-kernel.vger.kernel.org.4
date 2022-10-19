Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCF0604E0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiJSRFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJSRF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB5011543A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666199125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wRlM29TsBk84PT3EFPJ45IAV9PT73BI1jDJ0EjPevXQ=;
        b=OhgQzX659YpwPS/7j1EzCqbIGj+vXd8AVQR2dIRGrNnXYASz2dFxl/ZN5qP6ECDuaoogt5
        hj58gTcijsLP6i4RL5t9/hCl9v9u8RtMGiabrtBAhhW19UeojqgOdZ7pqg5sxhU1zedwbP
        8xgQA1qEyyTmtiam9qzPFq3tJei3pw0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-522-8SIJFKu6Muq08P91yJ5h_g-1; Wed, 19 Oct 2022 13:05:23 -0400
X-MC-Unique: 8SIJFKu6Muq08P91yJ5h_g-1
Received: by mail-qk1-f197.google.com with SMTP id o13-20020a05620a2a0d00b006cf9085682dso15161662qkp.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRlM29TsBk84PT3EFPJ45IAV9PT73BI1jDJ0EjPevXQ=;
        b=wN926PtVbEgcKHEQVwIghaX4QvCpzCjYUM5jjnNdA2hpzxZtOZRic7SS7bFjkBGJoF
         J97wHGXIqt+wkp9aqvPyyM3U7XQORePQD0FRu3k+sTD1nmwsCW7nbezA+Bc7SY/hh+fa
         3F4StEgrsz6qo19d5kJyOdQhU8wuxqCPy88PUOWkPrgLAUhI903Rky14LJz46rbSN2Cd
         kHEX9LBNsZyM4IHjNEL7cqyBqD1cMBnZKlm1/YMnmlEQJ7RnPkfArEygoLs168lJmZLn
         udfqZtDShreUXrHhhTpUFZb+l2H9N23r8JwbMDxmEKNqPCD580HClAG7n0golQm7Vns5
         C3iw==
X-Gm-Message-State: ACrzQf1HIMN5fWpX+Zm2ryhBQTB+4a2DBsfsUQX+DPeiEZ2WBPL/kztb
        wYD8v2tjfbPGNtDG6hNr41cpSh1OKrB9ex+XbJGgww2Ql1o3+iBp34cq5YmPZ1xjsxKBxKGc66b
        m7yw67HdNxXLsZRtXUycQ6/d+
X-Received: by 2002:ae9:eb45:0:b0:6ee:94aa:7520 with SMTP id b66-20020ae9eb45000000b006ee94aa7520mr6370107qkg.516.1666199123157;
        Wed, 19 Oct 2022 10:05:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6P/LumJVhQ+ZNgLEioRK4Cgr9Xp/VVNoYEZQzYUNECOawXEVXsRdzBsxknpUsYt9+PvBC5Qw==
X-Received: by 2002:ae9:eb45:0:b0:6ee:94aa:7520 with SMTP id b66-20020ae9eb45000000b006ee94aa7520mr6370082qkg.516.1666199122869;
        Wed, 19 Oct 2022 10:05:22 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006ec62032d3dsm5312452qkl.30.2022.10.19.10.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 10:05:22 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Connor O'Brien <connoro@google.com>
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
Subject: Re: [RFC PATCH 09/11] sched/rt: Fix proxy/current (push,pull)ability
In-Reply-To: <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
References: <20221003214501.2050087-1-connoro@google.com>
 <20221003214501.2050087-10-connoro@google.com>
 <xhsmhv8orgb59.mognet@vschneid.remote.csb>
 <CALE1s+ODz2FUJoSHcORa25kckk81qSHuZ6RSE6-k=s2gzQ+eOQ@mail.gmail.com>
Date:   Wed, 19 Oct 2022 18:05:18 +0100
Message-ID: <xhsmhtu3zwxpt.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/22 15:32, Connor O'Brien wrote:
> On Mon, Oct 10, 2022 at 4:40 AM Valentin Schneider <vschneid@redhat.com> wrote:
>> Consider:
>>
>>    p0 (FIFO42)
>>     |
>>     | blocked_on
>>     v
>>    p1 (FIFO41)
>>     |
>>     | blocked_on
>>     v
>>    p2 (FIFO40)
>>
>>   Add on top p3 an unrelated FIFO1 task, and p4 an unrelated CFS task.
>>
>>   CPU0
>>   current:  p0
>>   proxy:    p2
>>   enqueued: p0, p1, p2, p3
>>
>>   CPU1
>>   current:  p4
>>   proxy:    p4
>>   enqueued: p4
>>
>>
>> pick_next_pushable_task() on CPU0 would pick p1 as the next highest
>> priority task to push away to e.g. CPU1, but that would be undone as soon
>> as proxy() happens on CPU1: we'd notice the CPU boundary and punt it back
>> to CPU0. What we would want here is to pick p3 instead to have it run on
>> CPU1.
>
> Given this point, is there any reason that blocked tasks should ever
> be pushable, even if they are not part of the blocked chain for the
> currently running task? If we could just check task_is_blocked()
> rather than needing to know whether the task is in the middle of the
> "active" chain, that would seem to simplify things greatly. I think
> that approach might also require another dequeue/enqueue, in
> ttwu_runnable(), to catch non-proxy blocked tasks becoming unblocked
> (and therefore pushable), but that *seems* OK...though I could
> certainly be missing something.
>

So for an active chain yes we probably don't want any task in the chain to
be visible to load-balance - proxy and curr because they both make up the
currently-executed task (but there are active load balances in
e.g. CFS...), and the rest of the chain because of the above issues.

As for blocked tasks in a separate chain, ideally we would want them to be
picked up by load-balance. Consider:

      blocked_on       owner
  p0 ------------> m0 -------> p1
FIFO4                         FIFO3

      blocked_on       owner
  p2 ------------> m1 -------> p3
FIFO2                         FIFO1


If all those tasks end up on a single CPU for whatever reason, we'll pick
p0, go through proxy(), and run p1.

If p2 isn't made visible to load-balance, we'll try to move p3 away -
unfortunately nothing will make it bring p2 with it. So if all other CPUs
are running FIFO1 tasks, load-balance will do nothing.

If p2 is made visible to load-balance, we'll try to move it away, but
if/when we try to pick it we'll move it back to where p3 is...
One possible change here is to make the blocked chain migrate towards the
proxy rather than the owner - this makes scheduling priority considerations
a bit saner, but is bad towards the owner (migrating blocked tasks is
"cheap", migrating running tasks isn't).

> A related load balancing correctness question that caught my eye while
> taking another look at this code: when we have rq->curr != rq->proxy
> and then rq->curr is preempted and switches out, IIUC rq->curr should
> become pushable immediately - but this does not seem to be the case
> even with this patch. Is there a path that handles this case that I'm
> just missing, or a reason that no special handling is needed?
> Otherwise I wonder if __schedule() might need a dequeue/enqueue for
> the prev task as well in this case.

pick_next_task() does a put_prev_task() before picking the new highest
priority task, so if curr gets preempted (IOW pick_next_task() returns a p
!= curr) then it has had put_prev_task() done on it which which should make
it pushable.

>>
>> I *think* we want only the proxy of an entire blocked-chain to be visible
>> to load-balance, unfortunately PE gathers the blocked-chain onto the
>> donor's CPU which kinda undoes that.
>>
>> Having the blocked tasks remain in the rq is very handy as it directly
>> gives us the scheduling context and we can unwind the blocked chain for the
>> execution context, but it does wreak havock in load-balancing :/
>>

