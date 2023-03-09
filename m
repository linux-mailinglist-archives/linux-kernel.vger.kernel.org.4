Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F7A6B258C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCINeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjCINed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:34:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63603BF8F1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:34:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y2so2135788pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Czh5g+XJlf+BVchh0K30h31NIqy2LD+YGrx5e56xzLY=;
        b=PVWMHGukJ5be99PEVSlnag/paW6rc5gUpmw3bNAmqsw45wwL/QE3RA8yvhTbtYxM6b
         Z/yz9Giiwpg3hq5Ri8XD1hN7EJz2tuoHKWbQInW9SoKIH6n6PhkdoH/tejZJVGWTYfiE
         cLmYnKqEKTdUvsueLohV5CERk4iH8iMC2RKPqOf1WfiZrJ7Anxcb4r5vEXTK/KCu4ug3
         S3Nq99qIT2p+2i3ztVyB4dcN5eUN0wn41ZxZq3fwhpe4guzQ9wsJBd3yELmg60ZkXk1k
         gLUqsCUgZCctDKh1J01UK9BrrigMzbg87izmr+8idhZIg94g2bk9v1rrH0ddKAPIhfoi
         23Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368857;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Czh5g+XJlf+BVchh0K30h31NIqy2LD+YGrx5e56xzLY=;
        b=Hg9uzGUQcLbPbGy55mQY2+DJ44duQTIXd3riaVRXZ70xRdDZIp1unpDTb0RHeuwa/A
         Tj71Y6iR1f9TyK/C0S3X2I6oq/jYEBNiDpFmSt+ZJT+av2VeubNt96ohlIHTlTLJ7zb+
         H02LuRj95BvaNmwxphgKciMg5cy05Ewq4VlhWZOnM5nC4w6wthwjwDsB3HdeWqjZYRD3
         NTs+qT7dF7qv89nolJ57VZvH2IBL+CyW40mSr3qjMYgfQ7aw2UpiQ1XER3+nfjr9VVKa
         bHTUcyQ2EJw9nGoTSBjMCBcmakRFnyUtY20zS5jU8h5TgJrT0hIq2hw4JHLT+f+Rsa8+
         iHOA==
X-Gm-Message-State: AO0yUKUIb/Ra3gDEXYHB6Xm4cXsx8QCuBNDwL/Pc7UNvWUcxakvB8fbj
        CcEQXyqaEKIo6z/XDRmgOfC7754Hp2ieqtLcqU/j9g==
X-Google-Smtp-Source: AK7set9vS//GCUcAq6XqUozlsR8T1aEx8IyHle51Pt3SerAFO9XIfsrIsk8MAHgqjuWaA1UAFSVq//nrKNQC1fJc/xw=
X-Received: by 2002:a17:90a:420f:b0:234:13d8:ed5b with SMTP id
 o15-20020a17090a420f00b0023413d8ed5bmr7941950pjg.3.1678368856791; Thu, 09 Mar
 2023 05:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20230306132418.50389-1-zhangqiao22@huawei.com> <20230309130524.GA273121@hirez.programming.kicks-ass.net>
In-Reply-To: <20230309130524.GA273121@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 9 Mar 2023 14:34:05 +0100
Message-ID: <CAKfTPtAf5RrzZRSHtfK+r3QvnFQ-oM3+rJ-z5SB8T4+nUv1aQw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: sanitize vruntime of entity being migrated
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhang Qiao <zhangqiao22@huawei.com>, linux-kernel@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rkagan@amazon.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 at 14:05, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 06, 2023 at 09:24:18PM +0800, Zhang Qiao wrote:
> > Commit 829c1651e9c4 ("sched/fair: sanitize vruntime of
> > entity being placed") fix an overflowing bug, but ignore
> > a case that se->exec_start is reset after a migration.
> >
> > For fixing this case, we reset the vruntime of a long
> > sleeping task in migrate_task_rq_fair().
> >
>
> > @@ -7635,7 +7653,23 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
> >       if (READ_ONCE(p->__state) == TASK_WAKING) {
> >               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> >
> > -             se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> > +             /*
> > +              * We determine whether a task sleeps for long by checking
> > +              * se->exec_start, and if it is, we sanitize its vruntime at
> > +              * place_entity(). However, after a migration, this detection
> > +              * method fails due to se->exec_start being reset.
> > +              *
> > +              * For fixing this case, we add the same check here. For a task
> > +              * which has slept for a long time, its vruntime should be reset
> > +              * to cfs_rq->min_vruntime with a sleep credit. Because waking
> > +              * task's vruntime will be added to cfs_rq->min_vruntime when
> > +              * enqueue, we only need to reset the se->vruntime of waking task
> > +              * to a credit here.
> > +              */
> > +             if (entity_is_long_sleep(se))
> > +                     se->vruntime = -sched_sleeper_credit(se);
> > +             else
> > +                     se->vruntime -= u64_u32_load(cfs_rq->min_vruntime);
> >       }
>
> *groan*, that again...
>
> Can't we simply do:
>
> https://lkml.kernel.org/r/68832dfbb60fda030540b5f4e39c5801942689b1.1648228023.git.tim.c.chen@linux.intel.com

I'm not sure this would help here, exec_start == 0 can be easily
managed in place_entity

The problem stands for task about to be migrated out of taking prev_cpu lock

Then, even if we don't clear exec_start before migrating and keep
current value to be used in place_entity on the new cpu, we can't
compare the rq_clock_task(rq_of(cfs_rq)) of 2 different rqs AFAICT

side note, why do we reset exec_start ? Is it only to make task_hot
returns false ?

>
> ?
