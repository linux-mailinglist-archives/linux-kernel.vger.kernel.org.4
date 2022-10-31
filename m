Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1F6140CC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJaWpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:45:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4F12AD5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:45:00 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f37so21373104lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMQqyfbMdrgau/z8G/eKPFBv+2qgBW09vti4cEGeyAc=;
        b=MD8v9x1DmAGUEGLn0g2vhCe4emHRns9CFiMHv2EGrV/PthsdXEHCiRs6QTFqvwxCB4
         0j/ZOhfWtATrqJefP+2cOWa2PJoDKPiVxklCrrWylf6T2eX0S6pas2EvBMtJJKLvNTwR
         36nXOBinJUsoDI0l+634UwgUchG+YecWtR1WVXGQZct17byNBT8ibvEDbQXReOvoq+a3
         j9OUrIcnUIoxEBPp4Ky5DVSuXibsZR4/k7tRpL5eikEvx4zo8npNdrlRm9Vkxa+g+EQM
         6yChmKwXdPUE2GSCfJIglW918QTgpI99GdPYAZqQx7yqjcaoI7ouAszpUD6vtUHOyYdD
         AuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMQqyfbMdrgau/z8G/eKPFBv+2qgBW09vti4cEGeyAc=;
        b=BxUQ8GutHrNsUWKbXwYFjH4WfLuSWHHFQw/939FLsN7+rL42ul5p9IHor2v7kTncmW
         ociLt8SXgb4CwaxrMXpO0BZNl0YnNH7yffodRy2zZc6AnuJYeQx2iReCgRmou7wc/wwH
         jqWlzTkRuZZ4IeenJW1lfcPo3LE2kjsxAEu9kSWbYqz+AiPUXl7crP8xiSxNtGyn5CKv
         GP548zIXJtI9OwWBrs0B/Z4t9WF4hpZc63r0h2shgjRnq/DwPd8PsjByJhLOd9S6MwW3
         49FLjGy9Zx06Xi+eu40JHn1gP4mUrfexJgMt6CiZABiX3UwTr+6dDu5ETU1HETL8kisa
         R01g==
X-Gm-Message-State: ACrzQf3ascuZ1/G7zoOsS4F2rpxWkhBUr5KO8e0/clGF0DA5XqZjmJWC
        fZJ1Y1NpUsP92n2Sb4TuJxu35UEUxsu47gmFb8aRow==
X-Google-Smtp-Source: AMsMyM6WztZxOsMFmyfMwai9V5TgXY6e4IbFDTVAcq59NkcZQH+VBd/oK/yGWpCGY4+vSHVA7xKrRoMIbItwyUCRss4=
X-Received: by 2002:a05:6512:2356:b0:4a2:693b:2bc3 with SMTP id
 p22-20020a056512235600b004a2693b2bc3mr6183436lfu.545.1667256298526; Mon, 31
 Oct 2022 15:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221027081630.34081-1-zhouchuyi@bytedance.com>
 <CABk29NtDny9qKZbZZ_i8Brwjtqs5GA0G4_SffzK4HzG3RrXVhQ@mail.gmail.com>
 <64d963b6-2d9c-3f93-d427-a1ff705fb65a@bytedance.com> <CABk29NsbGuMPcA8NJagMfPyHij3864F3DVQ6wpCj3UAo8tbFNQ@mail.gmail.com>
 <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
In-Reply-To: <5af26ac9-3bdb-32d2-77a7-6cd8feca97aa@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 31 Oct 2022 15:44:46 -0700
Message-ID: <CABk29Nt38d31LnazbcSVB036jUYemC1KRpR2Dn7YgLmXkp-QBQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: favor non-idle group in tick preemption
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 31, 2022 at 1:39 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>
> >> =E5=9C=A8 2022/10/28 07:34, Josh Don =E5=86=99=E9=81=93:
> > The reason for limiting the control of weight for idle cgroups is to
> > match the semantics of the per-task SCHED_IDLE api, which gives
> > SCHED_IDLE threads minimum weight. The idea behind SCHED_IDLE is that
> > these entities are intended to soak "unused" cpu cycles, and should
> > give minimal interference to any non-idle thread. However, we don't
> > have strict priority between idle and non-idle, due to the potential
> > for starvation issues.
> >
> > Perhaps you could clarify your use case a bit further. Why do you want
> > to change the weight? Is it to adjust the competition between two idle
> > groups, or something else?
> >
> Suppose we have two cgroups=EF=BC=88idle & non-idle=EF=BC=89in /sys/fs/cg=
roup/cpu.
> Idle cgroup contains some offline service, such as beg data processing;
> non-idle cgroup contains some online service which have
> higher priority to users and are sensitive to latency. We set
> quota/period for idle cgroup which indicates it's *cpu limit*.
> In general, we consider that the idle cgroup's cpu usage
> closer to the limit, the better. However, when the system is busy,
> the idle cgroups can only get little cpu resources with minimum weight.
> To cope with the above situation, we changed the default weight.

I see. So you want the part of SCHED_IDLE that makes the entity highly
preemptible (and avoids preemption of non idle entities), but want to
adjust weight to reach a target cpu split? That seems a bit
counterintuitive to me, since by giving the idle entities higher
weight, you'll end up pushing out the round-robin latency for the
non-idle entities.

Worth noting that SCHED_IDLE is a bit of a CFS hack, but the intended
semantics of it are that these threads soak only "remaining cycles".
This comes with many implications beyond just weight. For example, a
cpu running only SCHED_IDLE entities is considered as "idle" from the
perspective of non-idle entities. If we give these idle entities
meaningful weight, we start to break assumptions there, for example
see sched_idle_cpu() and load balancing.

I wonder if maybe dusting off SCHED_BATCH is a better answer here, for
this type of use case (some amount of throughput "guarantee", but with
preemption properties similar to SCHED_IDLE). Peter, thoughts?

> One more question is, why you think this patch can strave idle entity?
>
>         /*
>          * Ensure that a task that missed wakeup preemption by a
>          * narrow margin doesn't have to wait for a full slice.
>          * This also mitigates buddy induced latencies under load.
>          */
>         se =3D __pick_first_entity(cfs_rq);
>         delta =3D curr->vruntime - se->vruntime;
>
>         if (delta < 0)
>                 return;
>
>         if (delta > ideal_runtime)
>                 resched_curr(rq_of(cfs_rq));
>
> se can preempt curr only when
>         curr->vruntime > se->vruntime &&
>                 curr->vruntime - se->vruntime > ideal_runtime
> is true. I think the original purpose is that se doesn't have to wait
> for a full slice, reduce response time if se is latency sensitive.
> This patch just let curr exhaust it's idleal_runtime when se is idle and
> curr is non-idle. Normally se will be choosed by pick_next_entity().
>
> Maybe I missed something ?
> Thanks

No that was my mistake, I accidentally thought this delta was being
applied to the 'if (delta_exec > ideal_runtime) {' above in
check_preempt_tick().

Some weirdness about this change though, is that if there is a
non-idle current entity, and the two next entities on the cfs_rq are
idle and non-idle respectively, we'll now take longer to preempt the
on-cpu non-idle entity, because the non-idle entity on the cfs_rq is
'hidden' by the idle 'first' entity. Wakeup preemption is different
because we're always directly comparing the current entity with the
newly woken entity.

Best,
Josh
