Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192466BA8E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjCOHSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCOHSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:18:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD6D1E5DC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:18:39 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 132so10228941pgh.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678864718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mQx2NsG+Z4PgzfWjOewnx+rt5WVbsi8EmW+zSVcCujg=;
        b=H1lv23td8/KnsGgDTUi6mceEpy1WMvkCKN8iU4eHHhJRhcSSPdqu6xXzb6lo4FicvO
         oDKf0R6ilLZ/YCZqGbK+dWUN3c+SvG7kk6Xf10Apy5E339FZZcvoQjD3yVI+o8jyDJz9
         fPUFa3HztVKYmU5mzthJwTcrKahmxWe9HQCMrPCpIqJOIRjdZXmfXqEcKqD8tnHl9YEH
         zCCx+IpG7jwfShEv41ebIFwPwp/b61sccvnyWr0/gxsKUDcbyhmSB+WzbwBvz2RixMXj
         AEap8783qOZgflCqinYhcVGOx7AyAPzwfAdYbNpN8vyDRnPR6rcUj7717aSlkdMG/KGK
         oMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678864718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQx2NsG+Z4PgzfWjOewnx+rt5WVbsi8EmW+zSVcCujg=;
        b=tuWI9tc4sL00C1v0xltunBib87xq1ZvdsQHwTUxcRp9xw/YPR6zA/gqewBQv8TV9U5
         IvWL/5tPRdCvkYB3rO4EY6EHykUNZgWGAsGrRk5DU+P3S4i4Ly6aVFZkSmtz4M4UMgul
         ulzlShOX/wKfvNyoVRLleip5rT65XOYPTqF8dtn1rfxfip+4cPC959W3/xCOm6vtqfgJ
         DemVqN8gw8X17p0213RUASIW+aAHdufIass0xrPF1in5boemrQPVQkYhNILfQkljqg4Y
         vcm8wp2uFsd141k/jaUQaXw4nTV4trbi8jiw9wvEELMNjCdGMCnyFWYjDaXGHyiXlatU
         X5GA==
X-Gm-Message-State: AO0yUKVcbxdeWQCgkSxVJ63WnE86G4ljbcYQ+SbzrDldKfWH8naORds2
        t1a52sFcoHyPoiZo1186ERTtNaS42AwvHjfJj99otw==
X-Google-Smtp-Source: AK7set8cx2VbHvkuoDS7it86p1tumQmvvb1hCztPiN1aUxW6rLgzMBzejNnCf9MZKo7z/47+HAaUBqBYFW44xqoJJO4=
X-Received: by 2002:a63:b55a:0:b0:503:7c81:4599 with SMTP id
 u26-20020a63b55a000000b005037c814599mr14016500pgo.11.1678864718424; Wed, 15
 Mar 2023 00:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
 <20230309142825.GB273121@hirez.programming.kicks-ass.net> <ZAnvCGdlOrWbIC/o@hirez.programming.kicks-ass.net>
 <CAKfTPtADUas2QHZCQyu0ad-JTKRQ=PcsB=o7+PuJNVxHwAzkCQ@mail.gmail.com>
 <ZAs+zV0o9ShO7nLT@vingu-book> <02a08042-e7c4-464d-bc20-9ec4ccdab1ff@arm.com>
 <8c093661-7431-00d8-d703-b8f7a7c8e747@arm.com> <CAKfTPtBw9SJxVBcN1qff7jRzE81kXSjbc-rXD6goEBFiXEwbyg@mail.gmail.com>
 <20230314120726.GG1845660@hirez.programming.kicks-ass.net>
 <CAKfTPtBHocw4N-YMHeqfMj78Ro=aF8sJPanxVCN=tM70hr6r8g@mail.gmail.com> <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
In-Reply-To: <20230314171607.GN2017917@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 15 Mar 2023 08:18:26 +0100
Message-ID: <CAKfTPtBurhAxcykDWQHoSZ0aiokgK4jhamdh-F29643cL1jVsw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 18:16, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 14, 2023 at 02:24:37PM +0100, Vincent Guittot wrote:
>
> > > @@ -7632,11 +7646,8 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> > >          * min_vruntime -- the latter is done by enqueue_entity() when placing
> > >          * the task on the new runqueue.
> > >          */
> > > -       if (READ_ONCE(p->__state) == TASK_WAKING) {
> > > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > > -
> > > +       if (READ_ONCE(p->__state) == TASK_WAKING || reset_vruntime(cfs_rq, se))
> >
> > That's somehow what was proposed in one of the previous proposals but
> > we can't call rq_clock_task(rq_of(cfs_rq)) because rq lock might not
> > be hold and rq task clock has not been updated before being used
>
> Argh indeed. I spend a lot of time ensuring we didn't take the old rq
> lock on wakeup -- and then a lot of time cursing about how we don't :-)
>
> Now, if we could rely on the rq-clock being no more than 1 tick behind
> current, this would still be entirely sufficient to catch the long sleep
> case.

We should also take care when loading rq_clock_task that we are not
racing with an update especially for a 32bits system like pelt
last_update_time

>
> Except I suppose that NOHZ can bite us here. If the old CPU is idle, the
> timestamps can be arbitrarily old. Mooo :/

That should not be a real problem because if the cpu is idle and the
rq clock is not updated, the min_vruntime will not move forward so we
are "safe" in regard to the overflow.

That's what was done in the v2 and v3 of this patch


>
>
