Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69DC645857
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiLGK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLGK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:58:47 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD8240A3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:58:36 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3c21d6e2f3aso181640987b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aeNaA5s/1gaYQglEQwHFijEgcd6Lomr0scUqybx2qK8=;
        b=PhUlSRX2S3Zsh64uyHe0+XZewDXgdjAEx1bxk2KiHCDS4EgD0tBGnQRS5i7du7+lHE
         3mPWyTftECpWaMwzTKeka2zXilCi4QpjCRfTHYBtcVN1S+3thaLVx1lTZRnF6WOrR6PH
         qq2Oad6PyhzAq0HFhlPjIbkrYoNxQ0ULrgTLaSZIFrfctoKoE2z8P3+5nJ4bU2mIyd1S
         6vRDhDJsdrXLdei2Bg8dT6B9eD1NHtvlmcNq9dJW2tZyCLTweyRDW9XP6fz57xwPljmc
         U5R2FO4auYWAOUow4hZ/Y0w+wTC9fdnsF3NWAxt/AnLby5BJmxnElSJpF7RoiBDr8BV8
         VevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aeNaA5s/1gaYQglEQwHFijEgcd6Lomr0scUqybx2qK8=;
        b=7zSmfBMZR12tImcPUzM8+xdU7joKx0nAz/gfsM3/7m2hmcZc59ChtZQZiRI/4V+Coy
         SMiWneq1ydnDm7S75gdJiRfZLucaBriCMJUldWZNUX2gF3hmbVD1PzmmufoHf8fO9BiN
         Z40RVsc4LPgoWHKnAi77Tw+kiVs3IhjpcwHmODbQShYg+PCXkpYjZ4lDDFJTbJnZI51Z
         K+yzOJzZiqJcOon7BDYUIcIjpEuyv99EGP3GEr9ILLHPV7RfKJNi5CTc7uw1kmIe0ggn
         57orwqrm/qHHm51xWo/YgN5TP2TiLq4FO+VGlArCgrod+wOeFkviZMC0p8gdgOM1dmFM
         bkGA==
X-Gm-Message-State: ANoB5pltg6mtJoEOoV+VHWog4Br/VU+ofkMdz8InmsMUM1oFAQ2OX+Gk
        v47unbNhE5Ju7008+20qiP43SI5IhdVMj44BiXSRnQ==
X-Google-Smtp-Source: AA0mqf7g0c4zU4yoqKXmTswg9i/Ic1tWrv6sHE8HKf8l2Fs00wLY59sOIoopjFJCvWWmAVDSSLwiWlRpdCQwIYTzEY4=
X-Received: by 2002:a81:49c6:0:b0:3bd:7135:c319 with SMTP id
 w189-20020a8149c6000000b003bd7135c319mr52728076ywa.89.1670410716003; Wed, 07
 Dec 2022 02:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20221129111055.953833-1-peternewman@google.com>
 <20221129111055.953833-2-peternewman@google.com> <a713ba13-634d-3061-933c-25a8d62eb0be@intel.com>
In-Reply-To: <a713ba13-634d-3061-933c-25a8d62eb0be@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 7 Dec 2022 11:58:25 +0100
Message-ID: <CALPaoCg6YROmpFa_RCYOCDzHBtR5tSCh2JwsOwPPpzBraOHK4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with task_call_func()
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

On Tue, Dec 6, 2022 at 7:57 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
> On 11/29/2022 3:10 AM, Peter Newman wrote:
> > When the user moves a running task to a new rdtgroup using the tasks
> > file interface, the resulting change in CLOSID/RMID must be immediately
> > propagated to the PQR_ASSOC MSR on the task's CPU.
> >
> > It is possible for a task to wake up or migrate while it is being moved
> > to a new group. If __rdtgroup_move_task() fails to observe that a task
> > has begun running or misses that it migrated to a new CPU, the task will
> > continue to use the old CLOSID or RMID until it switches in again.
> >
> > __rdtgroup_move_task() assumes that if the task migrates off of its CPU
> > before it can IPI the task, then the task has already observed the
> > updated CLOSID/RMID. Because this is done locklessly and an x86 CPU can
> > delay stores until after loads, the following incorrect scenarios are
> > possible:
> >
> >  1. __rdtgroup_move_task() stores the new closid and rmid in
> >     the task structure after it loads task_curr() and task_cpu().
>
> Stating how this scenario encounters the problem would help
> so perhaps something like (please feel free to change):
> "If the task starts running between a reordered task_curr() check and
> the CLOSID/RMID update then it will start running with the old CLOSID/RMID
> until it is switched again because __rdtgroup_move_task() failed to determine
> that it needs to be interrupted to obtain the new CLOSID/RMID."

That is largely what I was trying to state in paragraph 2 above, though
at a higher level. I hoped the paragraph following it would do enough to
connect the high-level description with the low-level problem scenarios.

>
> >  2. resctrl_sched_in() loads t->{closid,rmid} before the calling context
> >     switch stores new task_curr() and task_cpu() values.
>
> This scenario is not clear to me. Could you please provide more detail about it?
> I was trying to follow the context_switch() flow and resctrl_sched_in() is
> one of the last things done (context_switch()->switch_to()->resctrl_sched_in()).
> From what I can tell rq->curr, as used by task_curr() is set before
> even context_switch() is called ... and since the next task is picked from
> the CPU's runqueue (and set_task_cpu() sets the task's cpu when moved to
> a runqueue) it seems to me that the value used by task_cpu() would also
> be set early (before context_switch() is called). It is thus not clear to
> me how the above reordering could occur so an example would help a lot.

Perhaps in both scenarios I didn't make it clear that reordering in the
CPU can cause the incorrect behavior rather than the program order. In
this explanation, items 1. and 2. are supposed to be completing the
sentence ending with a ':' at the end of paragraph 3, so I thought that
would keep focus on the CPU.

I had assumed that the ordering requirements were well-understood, since
they're stated in existing code comments a few times, and that making a
case for how the expected ordering could be violated would be enough,
but I'm happy to draw up a side-by-side example.

>
> >
> > Use task_call_func() in __rdtgroup_move_task() to serialize updates to
> > the closid and rmid fields in the task_struct with context switch.
>
> Is there a reason why there is a switch between the all caps CLOSID/RMID
> at the beginning to the no caps here?

It's because I referred to the task_struct fields explicitly here.

-Peter
