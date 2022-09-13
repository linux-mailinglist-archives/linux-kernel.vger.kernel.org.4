Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DFE5B69AA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 10:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiIMIhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 04:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIMIhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 04:37:31 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBE422CD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:37:29 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 9so12579005ljr.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 01:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=65VDpIBxJ/IKZQ4sgA2HdVbfOJGF8riVXodtuFxvN2I=;
        b=NcQcTEQdSIxnGT43id3CCJUNW0bBEVVOf6Oe3r6DWcG++C4D5HIVsKFaEq4cu/JcLp
         JB2LlFdz8hsZrEk5X5jA0EHeH3KlDzbIgF0Y6TgONg+LaK4KPb0vDiYuyY/5f3Ebd8CK
         mveIOGLWL7LoH0pw1RYgBtvaE6zkaiN2E41bc7p4YWlNOa/La0D2GMi7K3Kh/EEPvsW0
         k8SvDcfq+xb1zr0/Hoa8SQFz0mXT4Nk7UiLQthndRQJTb69iWTBb/tLXqdtPOWC8oeIq
         +0sBG8yPQehkgsFCmcz8rZSNnAdNWb6/XKcLLVMwxwcq2OGxNu7iqbz4k2u4SFCzlhkv
         el+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=65VDpIBxJ/IKZQ4sgA2HdVbfOJGF8riVXodtuFxvN2I=;
        b=XJjv9vEkC/sa44Kpk5Wisch+vInFwZwXCkoCw9F977n20vhsH352dQcn4b0HCYFEk5
         4lEu3ihTXJjcXdIuxgcQ38ioN2jLhzanEHjGtnxdmMfWyafgOb+oAeWb+33u7p3hvEHo
         VpVwFghCrI41FJ0nqgfZgIhR0Yk/zmN4lfcJr/+Q7QjQL5SZGvJ4Mo8HqKU+WfMUN3ZJ
         bTJ3dCRRtV1V2JRYCWbLje6AAg/DZ1bMSN7aapIFsWxFlTGbeKj0gGquh9WGxqqlLfjL
         JsHf/noJ+31Y4yV6dmSC07hzn8maIBtW2sKtR8OYE9odKx3XbnKKiZBulQD1Ko+keP5Y
         7BIw==
X-Gm-Message-State: ACgBeo0Yu9Ch7tRwN0/KXGdWC+rhAbNBwkcf7v8sDzMH+ERnaohgx6ts
        0O2RFwj9i+quo+CVVIBuu42bqf5pSSryutEPKo0mBw==
X-Google-Smtp-Source: AA6agR5wpM4DBqWNV4XJKi8HHjXEZM7cih2CQFYtPcw1Y//GpSmlUqQScPwj92AZSzYsGGROWTfDpBWmNHpOaOQ9yUY=
X-Received: by 2002:a2e:86cf:0:b0:26b:fe50:8c4c with SMTP id
 n15-20020a2e86cf000000b0026bfe508c4cmr3128621ljj.17.1663058247897; Tue, 13
 Sep 2022 01:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-3-vincent.guittot@linaro.org> <294b8903-393f-7242-a887-6ec6d6fc829e@arm.com>
In-Reply-To: <294b8903-393f-7242-a887-6ec6d6fc829e@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 13 Sep 2022 10:37:16 +0200
Message-ID: <CAKfTPtC7V+G6ybu6Bk8=W9TbTm+cL7M6qDT-aww6ZWcBTa87TA@mail.gmail.com>
Subject: Re: [PATCH 2/4] sched/fair: cleanup loop_max and loop_break
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sept 2022 at 10:45, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 25/08/2022 14:27, Vincent Guittot wrote:
> > sched_nr_migrate_break is set to a fix value and never changes so we can
> > replace it by a define SCHED_NR_MIGRATE_BREAK.
> >
> > Also, we adjust SCHED_NR_MIGRATE_BREAK to be aligned with the init value
> > of sysctl_sched_nr_migrate which can be init to different values.
> >
> > Then, use SCHED_NR_MIGRATE_BREAK to init sysctl_sched_nr_migrate.
> >
> > The behavior stays unchanged unless you modify sysctl_sched_nr_migrate
> > trough debugfs.
>
> I don't quite get this sentence. The behavior would potentially change
> if you change sysctl_sched_nr_migrate before this patch too?

the behavior is different if you change the sysctl_sched_nr_migrate.

With this patch, loop_break is now aligned with
sysctl_sched_nr_migrate value which was not the case for
CONFIG_PREEMPT_RT. For the latter, the behavior can change if you
increase sysctl_sched_nr_migrate at runtime because there is now at
least one break whereas it was not the case before as long as
sysctl_sched_nr_migrate stayed below 32

>
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  kernel/sched/core.c  |  6 +-----
> >  kernel/sched/fair.c  | 11 ++++-------
> >  kernel/sched/sched.h |  6 ++++++
> >  3 files changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 64c08993221b..a21e817bdd1c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -142,11 +142,7 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
> >   * Number of tasks to iterate in a single balance run.
> >   * Limited because this is done with IRQs disabled.
> >   */
>
>     ^^^
> Shouldn't this comment be removed as well?
>
> > -#ifdef CONFIG_PREEMPT_RT
> > -const_debug unsigned int sysctl_sched_nr_migrate = 8;
> > -#else
> > -const_debug unsigned int sysctl_sched_nr_migrate = 32;
> > -#endif
> > +const_debug unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
> >
> >  __read_mostly int scheduler_running;
>
> [...]
