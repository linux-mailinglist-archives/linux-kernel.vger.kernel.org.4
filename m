Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CDA6D23F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjCaP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjCaP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:27:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E095A1D2EF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:27:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso25731990pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680276423; x=1682868423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xPwcpmuVrjBsBiPZBLr8Q91nNeLdwDJX0b7Ulvwj91k=;
        b=kse2XZV9mQt+Aa4VTAs+00ApIS8jXLiHkIQGDvPPkcojsFPplGaQK62cPEOI+NAObz
         Be8nv7ARDZgKCXrRqzuVNmwlN3QWlCJsSD3Ovd0iFwmbeKduDj1hJxNjo5yvGgqWWUp/
         4+eWNPmYt7FMz7wRLogIW6s6GJwPQBMEJSotkz5tM2wUetHJXppcipOmzH/l3412PD6x
         5rzHCORpcrD1lopnHYPVw31S2x3IbcH+e27h4ut28OF43PnsC1c3FJCO8yEATcgrO2EM
         Xmnqc9zkcOzyL3CmrNxj19k8UjqcuuJDlM4v55BMeyFLXMxQryaiaYdD3WyHZfU6xM9N
         7iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680276423; x=1682868423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPwcpmuVrjBsBiPZBLr8Q91nNeLdwDJX0b7Ulvwj91k=;
        b=RI1rNSq0B63CNrS9k8eTB0EZWrS+YiOfv5mOHJ5m2c8CSyZPIgBA0sM2TQh5E41+eq
         tTDQah12ejQg2KozoNL61mJtWG9QZ9nMuuetYTY+ag8LvRpqS2wzeHU8fPgd6W8JlEwW
         88l84u3KCfu3ia0iDowRL/tzzAEWe3HhwPkvOVkWBn+ImLhyoVFmwMmkSIP18U/VfNgU
         q6/Md8aPKBrUjVIMgNkdlY0TVDDIGJ+XsPdLb0koFv2dZYfonTypfAG5+7npDa5nMsPK
         GdhNnKUiUkBrMPemAi4BKdoTD2EM9S+nEW8W3jRGH75YBlisjZAz6F46tkgjDKpNbin6
         0Kkw==
X-Gm-Message-State: AAQBX9dSWJGa3UMceJFnCBNMOcOPCZkLOtMQ4GmTfxqmq4eWSZJPk+Lg
        /IIa9t4OGQgcXZq89Af4X2xIbepQRdvjvpXrI/8+NA==
X-Google-Smtp-Source: AKy350belDmDwqdS79CHQW1E0qfmhG0/1Jm8kVZbOn3sxN39m+iU2nMRfOeoMZtwaa/R8TT0bLPIamb8Z4frK8+j/2U=
X-Received: by 2002:a17:902:c3c6:b0:1a1:b318:2776 with SMTP id
 j6-20020a170902c3c600b001a1b3182776mr10608046plj.0.1680276423327; Fri, 31 Mar
 2023 08:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.562078801@infradead.org>
In-Reply-To: <20230328110354.562078801@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 31 Mar 2023 17:26:51 +0200
Message-ID: <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 13:06, Peter Zijlstra <peterz@infradead.org> wrote:
>
> In the case where (due to latency-nice) there are different request
> sizes in the tree, the smaller requests tend to be dominated by the
> larger. Also note how the EEVDF lag limits are based on r_max.
>
> Therefore; add a heuristic that for the mixed request size case, moves
> smaller requests to placement strategy #2 which ensures they're
> immidiately eligible and and due to their smaller (virtual) deadline
> will cause preemption.
>
> NOTE: this relies on update_entity_lag() to impose lag limits above
> a single slice.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/fair.c     |   14 ++++++++++++++
>  kernel/sched/features.h |    1 +
>  kernel/sched/sched.h    |    1 +
>  3 files changed, 16 insertions(+)
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -616,6 +616,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
>         s64 key = entity_key(cfs_rq, se);
>
>         cfs_rq->avg_vruntime += key * weight;
> +       cfs_rq->avg_slice += se->slice * weight;
>         cfs_rq->avg_load += weight;
>  }
>
> @@ -626,6 +627,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
>         s64 key = entity_key(cfs_rq, se);
>
>         cfs_rq->avg_vruntime -= key * weight;
> +       cfs_rq->avg_slice -= se->slice * weight;
>         cfs_rq->avg_load -= weight;
>  }
>
> @@ -4832,6 +4834,18 @@ place_entity(struct cfs_rq *cfs_rq, stru
>                 lag = se->vlag;
>
>                 /*
> +                * For latency sensitive tasks; those that have a shorter than
> +                * average slice and do not fully consume the slice, transition
> +                * to EEVDF placement strategy #2.
> +                */
> +               if (sched_feat(PLACE_FUDGE) &&
> +                   cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) {
> +                       lag += vslice;
> +                       if (lag > 0)
> +                               lag = 0;

By using different lag policies for tasks, doesn't this create
unfairness between tasks ?

I wanted to stress this situation with a simple use case but it seems
that even without changing the slice, there is a fairness problem:

Task A always run
Task B loops on : running 1ms then sleeping 1ms
default nice and latency nice prio bot both
each task should get around 50% of the time.

The fairness is ok with tip/sched/core
but with eevdf, Task B only gets around 30%

I haven't identified the problem so far


> +               }
> +
> +               /*
>                  * If we want to place a task and preserve lag, we have to
>                  * consider the effect of the new entity on the weighted
>                  * average and compensate for this, otherwise lag can quickly
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -5,6 +5,7 @@
>   * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
>   */
>  SCHED_FEAT(PLACE_LAG, true)
> +SCHED_FEAT(PLACE_FUDGE, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
>
>  /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -559,6 +559,7 @@ struct cfs_rq {
>         unsigned int            idle_h_nr_running; /* SCHED_IDLE */
>
>         s64                     avg_vruntime;
> +       u64                     avg_slice;
>         u64                     avg_load;
>
>         u64                     exec_clock;
>
>
