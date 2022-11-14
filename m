Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCEC6279FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiKNKFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236707AbiKNKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:05:03 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551701EEC1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:02:54 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so12814041ybb.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qkd07ZMYfb07YplnpCXQcfrTcvTzL+DPGQOK6Rh1tt8=;
        b=d25ayXICfgBBSvAsOm9Ao5b9QJUKAl2Znjb40mYGdDRwW/IUvgqwis6NAG2otR9yoU
         xM3e94/OgMRak8La6SG4mV8DuO+x7K8ItM3rD07WXvkEcTVdnduYMHe+lsM99zjHGV2X
         cc4SyMzYGK5JUdgErXcMTX3F4/kFpqbp8lmRFhMGq7Swp3NtXrDoAgmbuIRT58sdN7Ao
         Js9ezgbKTOgTmTBDV4xwB/1ZVJOlANcu0d5dji4JfHu1TnQV46I5+fuTOmzu3CKldVj/
         QMLJhUGpVTyUg4sOOZQKxiNMemCN+A6PvTXUeA01WZWwH8CU+YAZBdbEBEKn81qVMop6
         JHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkd07ZMYfb07YplnpCXQcfrTcvTzL+DPGQOK6Rh1tt8=;
        b=0uJckOSoahTcrP7QYE2eFZUGotkwM7CCpYxW40x2ena6PYtB+nK4skSW3fb6b17kp1
         ALt3uVIXTcZWMRrIQjtLv9ZlujyyrYhq4V/Bcxj3PydN9rTWsWM++vEfuY8bq4HCfQan
         VK8qkYtTubP7SVrPuRebIFEidkxSkIH/CN0kXnkNzqzrz6NJtx5kQ5FtJjRg0drU/E/i
         0arDB3l7JRk/nb1YuUjE43fCaGOd2nhNA5ywcVavYo8AGhYjTwxbDm64IL3lDH6eaynl
         /6wXYgY1gD4h9uAy1SwLygoxyYM/oVpuWNTF/Jwne8bqglRxh3Ki9wrMySStIUixSops
         2t8A==
X-Gm-Message-State: ANoB5pndhrFzz3ywyCWci/GFvdc+ZC4VRNxa9DI3JyKpHRbqTTzSCTBz
        ug24VwF6/QjmYN7+r7ixA8DoGgL1ta93xjQTGBUprQ==
X-Google-Smtp-Source: AA0mqf6p19FApYdHPqwJOJPRBMV/G6p8mYu15xSub/RUDNPN3O2v9PmBmW7rw2k0y/przUpOUGdmw63/jPGZcK1N7b8=
X-Received: by 2002:a25:3484:0:b0:6c4:1751:f0d1 with SMTP id
 b126-20020a253484000000b006c41751f0d1mr11417280yba.422.1668420173373; Mon, 14
 Nov 2022 02:02:53 -0800 (PST)
MIME-Version: 1.0
References: <20221110135346.2209839-1-peternewman@google.com>
 <20221110135346.2209839-2-peternewman@google.com> <f191bff5-b868-e008-376b-7b0a316dc5be@arm.com>
In-Reply-To: <f191bff5-b868-e008-376b-7b0a316dc5be@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 14 Nov 2022 11:02:42 +0100
Message-ID: <CALPaoChEMCdrVkYzqkWuXJVhsSyB0PB2CTZcvKXUJTavC7dYjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/resctrl: fix task closid/rmid update race
To:     James Morse <james.morse@arm.com>
Cc:     reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        derkling@google.com, eranian@google.com, hpa@zytor.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
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

Hi James,

On Fri, Nov 11, 2022 at 7:38 PM James Morse <james.morse@arm.com> wrote:
> On 10/11/2022 13:53, Peter Newman wrote:
> > This was because stores updating the closid and rmid in the task
> > structure could reorder with the loads in task_curr() and task_cpu().
>
> Mentioning this happens in __rdtgroup_move_task() would make this easier to review.

ok

> > Similar reordering also impacted resctrl_sched_in(), where reading the
> > updated values could reorder with prior stores to t->on_cpu.
>
> Where does restrl_sched_in() depend on t->on_cpu?

I misworded this. I should probably say "occurs" or "happens" rather
than saying "impacted". There is no impact on resctrl_sched_in() itself, but
rather the reordering that occurs around resctrl_sched_in() further breaks the
assumptions of __rdtgroup_move_task().

Also I think the mention of t->on_cpu comes from a prototype on an older
branch before you changed it to use task_curr(). Now it's rq->curr and
t->cpu reordering with t->{closid,rmid} that I'm concerned about.

>
>
> > Instead, when moving a single task, use task_call_func() to serialize
> > updates to the closid and rmid fields in the task_struct with context
> > switch.
> >
> > When deleting a group, just update the MSRs on all CPUs rather than
> > calling task_call_func() on every task in a potentially long list while
> > read-locking the tasklist_lock.
>
> This rmdir stuff feels like something that should go in a preparatory patch with an
> expanded justification. (the stuff in the comment below). Real-time users may care about
> unconditionally IPIing all CPUs, but I suspect changes to resctrl while the system is
> running aren't realistic.
>
> A group of smaller patches that make independent changes is easier to review than one big
> one! (especially as some of those changes are mechanical)

I think I made a mess of the patch when I pivoted to a different
approach in v2. It was more cohesive when I had the rmdir stuff using
update_task_closid_rmid().

>
>
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index e5a48f05e787..d645f9a6c22e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -538,12 +538,38 @@ static void _update_task_closid_rmid(void *task)
> >               resctrl_sched_in();
> >  }
> >
> > -static void update_task_closid_rmid(struct task_struct *t)
> > +static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
> >  {
> > -     if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> > -             smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> > -     else
> > -             _update_task_closid_rmid(t);
>
> [...]
>
> >  static int __rdtgroup_move_task(struct task_struct *tsk,
> > @@ -557,39 +583,26 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>
> > -     update_task_closid_rmid(tsk);
> > +     if (update_task_closid_rmid(tsk, rdtgrp) && IS_ENABLED(CONFIG_SMP))
> > +             /*
> > +              * If the task has migrated away from the CPU indicated by
> > +              * task_cpu() below, then it has already switched in on the
> > +              * new CPU using the updated closid and rmid and the call below
> > +              * unnecessary, but harmless.
> > +              */
> > +             smp_call_function_single(task_cpu(tsk),
> > +                                      _update_task_closid_rmid, tsk, 1);
> > +     else
> > +             _update_task_closid_rmid(tsk);
>
> I think it would result in less churn if you kept this chunk in update_task_closid_rmid().

This is another thing that made more sense in the v1 approach, where it
had to be done a little differently in the rmdir case. I'll fix it.

Also, I find it strange that the same function calls
update_task_closid_rmid(), followed by _update_task_closid_rmid(). It
gives the impression that there was a layering which has now been
disregarded.

> > @@ -2385,12 +2398,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
> >   * Move tasks from one to the other group. If @from is NULL, then all tasks
> >   * in the systems are moved unconditionally (used for teardown).
> >   *
> > - * If @mask is not NULL the cpus on which moved tasks are running are set
> > - * in that mask so the update smp function call is restricted to affected
> > - * cpus.
> > + * Following this operation, the caller is required to update the MSRs on all
> > + * CPUs. The cost of constructing the precise mask of CPUs impacted by this
> > + * operation will likely be high, during which we'll be blocking writes to the
> > + * tasklist, and in non-trivial cases, the resulting mask would contain most of
> > + * the CPUs anyways.
>
> This is the argument for not building the mask. I think it would be better placed in the
> commit message of a patch that removes that support. It's not really necessary for new
> users to read about what the function doesn't do....

The first sentence details an important requirement for the caller which
I think should remain, but I suppose I should have stopped myself from
rambling on about the rationale inline.

>
>
> With the caveat that I don't understand memory ordering:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks for your review. I'll clean this up and send out an update.

Thanks!
-Peter
