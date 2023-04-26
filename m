Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4C96EFA55
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjDZSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjDZSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:53:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7FF7EC0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:53:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f1950f569eso41739255e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682535180; x=1685127180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyz899e+SgJhAlLn7W+cC4n0so0n3eO93aodRTmFgLc=;
        b=v1a4GuyVTXuHXlzLqDZYWa/B4Q3UePj4XuV89jNeFhAWlYY2Miy9ys7BcaEk2SyoBG
         NWOyJXBdYrYqYVzPVhnrjSTa/VUtUIjTywnDg0GtSrJqJ8uLRMNTuM5/MghoInSKHf8W
         FjUW7ftF/PhexjdJ4jVOTT4H48/WD5wCh/8EoZO0j417gDTW1qWW6zLTUwK2JQYLud0x
         zsyQgTBCYDhc33IDwtI+P9tCFNIyzdqTUjKnFN2x1kcKE8kIMG3YhlRHKHBGZvgQyk4W
         C4Bd9lnbMrjHUM3cxVw90MPq2YgQL6H5KkKrELgzzkAgcj0HBQGHt+Z2JBmtHOZrkHrZ
         SA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682535180; x=1685127180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyz899e+SgJhAlLn7W+cC4n0so0n3eO93aodRTmFgLc=;
        b=FxDAXm7BxgsWciHSRmcrTIaiZn8laec5VGeIgbfqIACMWRBCggs33NfHZgXtf1oalI
         UPRYr+vZJWYkTxiFnNf+nnk8jFQJfhdEysgxbTvrP39FmO5fed37UYWbocMQuVG4TyOE
         mrg2ZOzRm46xobH/mR5665C03HQqJ9jaKWn5zrln1C2C5wyXcbegbDVcr6VyTJTdbhoT
         A8+I8W81TUVmmvXI8XtL6XHm1RsQaMAexZcrptf+zRJNUeuYE8wyDANw6Yi28CQlpGtt
         r8/0Lq2feyIp3+ABzsaIuGn86kWIolX7EUTIzsdOBk1Zly31M1aOQ83YmsZ0OY0JcrTN
         xLPw==
X-Gm-Message-State: AAQBX9c4bJc4jD6JlXpUobKJ1sHeXo09OIVLSEwwPsrouU6FaAT/jnnX
        7IxxGzkh5WyULCGH8+ltVOjmkatSpFF1gauWYzVfYA==
X-Google-Smtp-Source: AKy350ZtiEljRNHcOMI/6qG/lYSYiL5i9vY6F7h4V+PLTVCxrmVd3E0R2bhrMxFMiJySjFEPzU3todjbNo00lrxqEb4=
X-Received: by 2002:a05:600c:20f:b0:3f1:8085:910e with SMTP id
 15-20020a05600c020f00b003f18085910emr13706961wmi.9.1682535180196; Wed, 26 Apr
 2023 11:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-4-avagin@google.com>
In-Reply-To: <20230308073201.3102738-4-avagin@google.com>
From:   Andrei Vagin <avagin@google.com>
Date:   Wed, 26 Apr 2023 11:52:49 -0700
Message-ID: <CAEWA0a68dgA_sZVV7YWrrvK1=GkpEW1KcF1FNcmFOkDx+QKxYA@mail.gmail.com>
Subject: Re: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     avagin@gmail.com, brauner@kernel.org, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        mingo@redhat.com, peterz@infradead.org, posk@google.com,
        tycho@tycho.pizza, vincent.guittot@linaro.org, wad@chromium.org,
        yu.c.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 7:43=E2=80=AFAM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> > Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wak=
e
> > up tasks on the current CPU.
>
> > These two helpers are useful when the task needs to make a synchronous =
context
> > switch to another task. In this context, synchronous means it wakes up =
the
> > target task and falls asleep right after that.
>
> > One example of such workloads is seccomp user notifies. This mechanism =
allows
> > the  supervisor process handles system calls on behalf of a target proc=
ess.
> > While the supervisor is handling an intercepted system call, the target=
 process
> > will be blocked in the kernel, waiting for a response to come back.
>
> > On-CPU context switches are much faster than regular ones.
>
> > Signed-off-by: Andrei Vagin <avagin@google.com>
>
> Avoiding cpu switches is very desirable for fuse, I'm working on fuse ove=
r uring
> with per core queues. In my current branch and running a single threaded =
bonnie++
> I get about 9000 creates/s when I bind the process to a core, about 7000 =
creates/s
> when I set SCHED_IDLE for the ring threads and back to 9000 with SCHED_ID=
LE and
> disabling cpu migration in fs/fuse/dev.c request_wait_answer() before goi=
ng into
> the waitq and enabling it back after waking up.
>
> I had reported this a few weeks back
> https://lore.kernel.org/lkml/d0ed1dbd-1b7e-bf98-65c0-7f61dd1a3228@ddn.com=
/
> and had been pointed to your and Prateeks patch series. I'm now going
> through these series. Interesting part is that a few weeks I didn't need
> SCHED_IDLE, just disabling/enabling migration before/after waking up was
> enough.
>
> [...]
>
> > EXPORT_SYMBOL(swake_up_one);
> > diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> > index 133b74730738..47803a0b8d5d 100644
> > --- a/kernel/sched/wait.c
> > +++ b/kernel/sched/wait.c
> > @@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, uns=
igned int mode,
> >  }
> >  EXPORT_SYMBOL(__wake_up);
>
> > +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigne=
d int mode, void *key)
> > +{
> > +     __wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
> > +}
>
> I'm about to test this instead of migrate_disable/migrate_enable, but the=
 symbol needs
> to be exported - any objection to do that right from the beginning in you=
r patch?

I think EXPORT_SYMBOL_GPL should not trigger any objections and it
covers your case, doesn't it?

Thanks,
Andrei
