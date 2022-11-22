Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF94633FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiKVPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbiKVPRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:17:45 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23D12AF9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:17:43 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id i131so17655147ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3CYg1LUYDkANfwBpGNS7NQfPVpCUtYVWV7f1hN9mcs=;
        b=hzCKe2yWyXp2COnYNXDD40ln6rKffVSGol1mtwyYf2DZzY/9aZdwCpWmAI0tVGN6ej
         aJ9mlbIOjtucEsIG+pQ+rofq5lSZ2Yz/QviwEoDUC40VeaI4rWhFvhYlSihbe97T/ONR
         umu+5XB7A+wj09ulxGLLr0/1g+0WEY8sKPMWyS0DqiwH+4Pmw6YGDxXx/RYtm6V05KYF
         zZ5dnzuCnThLyW+TYKlKaBJXlR4sqvyNWbns++5yr3kJ2u55H62zf8RR7bvOPlNgRyGY
         SxemBPavPODq2qodX50Ntv8gKo7xjfkJsouEjyuBtBVkVR45uqFJMy54BhFND9Xdj5EW
         mD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3CYg1LUYDkANfwBpGNS7NQfPVpCUtYVWV7f1hN9mcs=;
        b=AKW84Voc7+uShNnieVXeeCmPgBMg/0W8mXwleqmeMUpwovlqr1lzGEUJn6rztkAlon
         A0vxRb3OWnm/BW4Iy6hkFIw8kiZuU+6iBJNnS7WA7HC3Jz90Lo9ti01wPXfqJnKBJ0As
         YJ31Cxh6FSlveIXL2lbyBzK7/oSCxNrjfC/PanlgSsM+AmdSv+CzcmfjiSRW9LCtwPEL
         TA8pNZnHUUJ7Ypdl/hY/mDD0Tfh1VEsE7Sm3ysH5RNFzn3xEnEpSmhCF/2wMvxTdOMXk
         OGTuetktfGvyf+l6ylfgRxjSblgfYNA9W7aRIh8TsyyhJo3lrfWAhIe/DKT+1JIr6W+6
         L7AQ==
X-Gm-Message-State: ANoB5pkcXLD9vKVaF9bSFVxjeoUv8fE/oRPeRRplk5AfcmgyTae5lcV7
        L37x/OU0erarz731uKpFZ5FyfbjBpddRsfMoZ/chodgvG8vKDA==
X-Google-Smtp-Source: AA0mqf55S/A0Up5aA2oBw7dRywQM+lJpP0O2xb24NMnOTQFEvjxdJWGvCOt9B+fZ7F9MDENGcHfvjJ1B6vjD2pFF+iU=
X-Received: by 2002:a05:6902:4ce:b0:6be:92a9:c9a8 with SMTP id
 v14-20020a05690204ce00b006be92a9c9a8mr7598543ybs.408.1669130262163; Tue, 22
 Nov 2022 07:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20221115141953.816851-1-peternewman@google.com>
 <20221115141953.816851-3-peternewman@google.com> <85e9d499-5393-f388-7d23-aa68248e5037@intel.com>
In-Reply-To: <85e9d499-5393-f388-7d23-aa68248e5037@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 22 Nov 2022 16:17:31 +0100
Message-ID: <CALPaoCjiDw5WaQG+yJHgKr9=WrNw606Z8oDwt47Yx+cWZBf6eA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] x86/resctrl: update task closid/rmid with task_call_func()
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     fenghua.yu@intel.com, bp@alien8.de, derkling@google.com,
        eranian@google.com, hpa@zytor.com, james.morse@arm.com,
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

Hi Reinette,

On Mon, Nov 21, 2022 at 10:59 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> Patch description in subject should start with upper case.
>
> On 11/15/2022 6:19 AM, Peter Newman wrote:
> > When determining whether running tasks need to be interrupted due to a
> > closid/rmid change, it was possible for the task in question to migrate
> > or wake up concurrently without observing the updated values.
>
> Mixing tenses can quickly become confusing. Please stick to imperative tone.

Sorry about this. Looking at how other bug fix commit messages are
worded, they describe the bug as the present behavior of the kernel
rather than how the kernel used to behave before the patch was applied.
It seems I've been consistently wording problem statements as past
behavior.

> Also, please start with the context of this work before jumping to
> the problem description.
>
> For example (not a requirement to use - feel free to change):
> "A task is moved to a resource group when its task id is written to the
> destination resource group's "tasks" file. Moving a task to a new
> resource group involves updating the task's closid and rmid (found
> in its task_struct) and updating the PQR_ASSOC MSR if the task
> is current on a CPU.
>
> It is possible for the task to migrate or wake up while it is moved
> to a new resource group. In this scenario the task starts running
> with the old closid and rmid values but it may not be considered
> as running and thus continue running with the old values until it is
> rescheduled."

Thanks, I'll use your intro as a starting point.

> > In particular, __rdtgroup_move_task() assumed that a CPU migrating
> > implied that it observed the updated closid/rmid. This assumption is
> > broken by the following reorderings, both of which are allowed on x86:
> >
> >  1. In __rdtgroup_move_task(), stores updating the closid and rmid in
> >     the task structure could reorder with the loads in task_curr() and
> >     task_cpu().
> >  2. In resctrl_sched_in(), the earlier stores to the fields read by
> >     task_curr() could be delayed until after the loads from
> >     t->{closid,rmid}.
> >
> > Preventing this reordering with barriers would have required an smp_mb()
> > in all context switches whenever resctrlfs is mounted.  Instead, when
> > moving a single task, use task_call_func() to serialize updates to the
> > closid and rmid fields in the task_struct with context switch.
>
> Please adjust the above to imperative tone.

Ok.

> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 049971efea2f..511b7cea143f 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -538,10 +538,47 @@ static void _update_task_closid_rmid(void *task)
> >               resctrl_sched_in();
> >  }
> >
> > -static void update_task_closid_rmid(struct task_struct *t)
> > +static int update_locked_task_closid_rmid(struct task_struct *t, void *arg)
> >  {
> > -     if (IS_ENABLED(CONFIG_SMP) && task_curr(t))
> > -             smp_call_function_single(task_cpu(t), _update_task_closid_rmid, t, 1);
> > +     struct rdtgroup *rdtgrp = arg;
> > +
> > +     /*
> > +      * We assume task_call_func() has provided the necessary serialization
> > +      * with resctrl_sched_in().
>
> Please no "we".

Ok.

>
> Also, either task_call_func() provides serialization or it does not. Wording
> it as "assume" creates uncertainty about this change.
>
> > +      */
> > +     if (rdtgrp->type == RDTCTRL_GROUP) {
> > +             t->closid = rdtgrp->closid;
> > +             t->rmid = rdtgrp->mon.rmid;
> > +     } else if (rdtgrp->type == RDTMON_GROUP) {
> > +             t->rmid = rdtgrp->mon.rmid;
> > +     }
>
> wrt the READ_ONCE() in __resctrl_sched_in() ... memory_barriers.txt tells me
> that "When dealing with CPU-CPU interactions, certain types of memory barrier
> should always be paired.  A lack of appropriate pairing is almost certainly
> an error."

Consequently the statement earlier about task_call_func() (maybe)
providing serialization has been incorrect since I stopped using it for
group updates in the v2 series, where I had to put the READ_ONCE() calls
back in __resctrl_sched_in(), so the READ_ONCE() is indeed necessary
again.

>
> > +
> > +     /*
> > +      * If the task is current on a CPU, the PQR_ASSOC MSR needs to be
> > +      * updated to make the resource group go into effect. If the task is not
> > +      * current, the MSR will be updated when the task is scheduled in.
> > +      */
> > +     return task_curr(t);
> > +}
> > +
> > +static void update_task_closid_rmid(struct task_struct *t,
> > +                                 struct rdtgroup *rdtgrp)
> > +{
> > +     /*
> > +      * Serialize the closid and rmid update with context switch. If this
> > +      * function indicates that the task was running, then it needs to be
>
> What does "this function" refer to? Please replace with function name to be
> specific since there are a few functions below.

Ok.

>
> /was running/is running/?

The task is no longer locked here, so it doesn't seem correct to say "is
running" when it could have already stopped running.

Also, maybe related, I was considering moving the task_curr() call out
of update_locked_task_closid_rmid() to avoid giving the misconception
that the result is current, because the value is used after releasing
the task's pi/rq lock.

>
> > +      * interrupted to install the new closid and rmid.
> > +      */
> > +     if (task_call_func(t, update_locked_task_closid_rmid, rdtgrp) &&
> > +         IS_ENABLED(CONFIG_SMP))
> > +             /*
> > +              * If the task has migrated away from the CPU indicated by
> > +              * task_cpu() below, then it has already switched in on the
> > +              * new CPU using the updated closid and rmid and the call below
> > +              * unnecessary, but harmless.
>
> is unnecessary ?

Yes, thanks.

>
> > +              */
> > +             smp_call_function_single(task_cpu(t),
> > +                                      _update_task_closid_rmid, t, 1);
> >       else
> >               _update_task_closid_rmid(t);
> >  }
>
> Could you please keep update_task_closid_rmid() and
> _update_task_closid_rmid() together?

Yes.

> [...]
>
> Reinette

Thanks for your feedback, Reinette. I'll fix the wording throughout the
patch.

I'll read over the wording in the other patch series I sent out as well
to make sure it's consistent.

-Peter
