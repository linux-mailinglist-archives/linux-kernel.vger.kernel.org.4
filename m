Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8691C6CCF78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjC2B1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2B1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:27:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4361C123
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:27:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so14586003pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680053226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g8qO8NUpgB4tUj3e2MVUm8XYarfp3L7c/C/TzKZhwbk=;
        b=mqakwUvZDRZP94Nbn4lJxi3CBpGWKZUB/kLIK1BIk19KokTaqRGbh/xWe5oSopHrDo
         NJCH1VJNxn01C3dgxTKIxPAsFBnH8/HTcailXwO0k/N5o2EcziGpwvbUWeLONgAMmZrp
         A69JuGMCW1Jn2P2CrfzUXlL+neA6RZdaFMYzRZ7dSYxuwSxDoQR6lnkNmBl1RJScz/aX
         RFaQUPq7QM7ZjFakP61uHOvJ7vL0omRyqNB+iyibZcMmqA00PQVff5cvuYV+lqqbmzPf
         7mdFytRUdNUkupMb4RflOd/Wvl1C08dXqWcL2ap5txmAm5Ss9f1kWW8qH1sU8u7UsNMs
         6w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680053226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8qO8NUpgB4tUj3e2MVUm8XYarfp3L7c/C/TzKZhwbk=;
        b=1rIsSa/2EWMlfN/sOMFsqkcq3osliWt49FABCki95ZtvBaJ3lopg9ZUwgZQaM2o2y2
         R5S73HTPsxp0PHhPsS+Pc1r3w5bB3P17xxEQC3lyGcm0a9cyRfhypyxxwOpinvrE3QTV
         3ZHk6zeAt8X17JbIPDlQasGgQINfdI2Aw5x1iamVEGwXOaumm19/Xn1CYHXl6+HL8C8H
         pTnc5kV3ssl5LZ9Teb9LxuFDz4bxw9Uz/G9dnILRKy/baWtcFMLVLNouB2U+o3LKgMl0
         E3QHT0TCMFUihx0L9jqJFrNN73MqPeHtMZIkE5SKF0x54B6ckofnP1jRjcooSL6mE0b+
         grMg==
X-Gm-Message-State: AAQBX9dE0PcVKW3bN58h1LWw2lJ13Q6UkitKMPqpnQMT2cdUeQMdO4y4
        LfQ/JAzt8e+rN30pZYJ4oKPGLpoMDIW90VOtxHqwlQ==
X-Google-Smtp-Source: AKy350aoGjlMNkuZPQjhWxyMhM3CugFjaBCDCQsZhcWjmIFDTfSxyPywm02XuDKnBoF0M75cKOexSuG1ioHeG1Wtjdc=
X-Received: by 2002:a17:90a:6943:b0:236:a1f9:9a9d with SMTP id
 j3-20020a17090a694300b00236a1f99a9dmr225757pjm.2.1680053225375; Tue, 28 Mar
 2023 18:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230328092622.062917921@infradead.org> <20230328110354.141543852@infradead.org>
In-Reply-To: <20230328110354.141543852@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 28 Mar 2023 18:26:51 -0700
Message-ID: <CABk29Nt4T67S+L9Qs1qeOUyo5gY1Qy5KuOwuCYNM74E58J81Eg@mail.gmail.com>
Subject: Re: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

This is a really interesting proposal and in general I think the
incorporation of latency/deadline is quite a nice enhancement. We've
struggled for a while to get better latency bounds on performance
sensitive threads in the face of antagonism from overcommit.

>  void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> +       s64 lag, limit;
> +
>         SCHED_WARN_ON(!se->on_rq);
> -       se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
> +       lag = avg_vruntime(cfs_rq) - se->vruntime;
> +
> +       limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> +       se->vlag = clamp(lag, -limit, limit);

This is for dequeue; presumably you'd want to update the vlag at
enqueue in case the average has moved again due to enqueue/dequeue of
other entities?

> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +{
> +       struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
> +       struct sched_entity *curr = cfs_rq->curr;
> +       struct sched_entity *best = NULL;
> +
> +       if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> +               curr = NULL;
> +
> +       while (node) {
> +               struct sched_entity *se = __node_2_se(node);
> +
> +               /*
> +                * If this entity is not eligible, try the left subtree.
> +                */
> +               if (!entity_eligible(cfs_rq, se)) {
> +                       node = node->rb_left;
> +                       continue;
> +               }
> +
> +               /*
> +                * If this entity has an earlier deadline than the previous
> +                * best, take this one. If it also has the earliest deadline
> +                * of its subtree, we're done.
> +                */
> +               if (!best || deadline_gt(deadline, best, se)) {
> +                       best = se;
> +                       if (best->deadline == best->min_deadline)
> +                               break;

Isn't it possible to have a child with less vruntime (ie. rb->left)
but with the same deadline? Wouldn't it be preferable to choose the
child instead since the deadlines are equivalent but the child has
received less service time?

> +               }
> +
> +               /*
> +                * If the earlest deadline in this subtree is in the fully
> +                * eligible left half of our space, go there.
> +                */
> +               if (node->rb_left &&
> +                   __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
> +                       node = node->rb_left;
> +                       continue;
> +               }
> +
> +               node = node->rb_right;
> +       }
> +
> +       if (!best || (curr && deadline_gt(deadline, best, curr)))
> +               best = curr;
> +
> +       if (unlikely(!best)) {
> +               struct sched_entity *left = __pick_first_entity(cfs_rq);
> +               if (left) {
> +                       pr_err("EEVDF scheduling fail, picking leftmost\n");
> +                       return left;
> +               }
> +       }
> +
> +       return best;
> +}
> +
>
>  static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
> @@ -5088,19 +5307,20 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  static void
>  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
> -       unsigned long ideal_runtime, delta_exec;
> +       unsigned long delta_exec;
>         struct sched_entity *se;
>         s64 delta;
>
> -       /*
> -        * When many tasks blow up the sched_period; it is possible that
> -        * sched_slice() reports unusually large results (when many tasks are
> -        * very light for example). Therefore impose a maximum.
> -        */
> -       ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
> +       if (sched_feat(EEVDF)) {
> +               if (pick_eevdf(cfs_rq) != curr)
> +                       goto preempt;

This could shortcircuit the loop in pick_eevdf once we find a best
that has less vruntime and sooner deadline than curr, since we know
we'll never pick curr in that case. Might help performance when we
have a large tree for this cfs_rq.

> +
> +               return;
> +       }
>
>         delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> -       if (delta_exec > ideal_runtime) {
> +       if (delta_exec > curr->slice) {
> +preempt:
>                 resched_curr(rq_of(cfs_rq));
>                 /*
>                  * The current task ran long enough, ensure it doesn't get
> @@ -5124,7 +5344,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq
>         if (delta < 0)
>                 return;
>
> -       if (delta > ideal_runtime)
> +       if (delta > curr->slice)
>                 resched_curr(rq_of(cfs_rq));
>  }

Best,
Josh
