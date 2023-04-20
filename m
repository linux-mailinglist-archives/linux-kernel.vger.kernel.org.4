Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063466E95F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDTNjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjDTNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:38:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B4B72BC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:38:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id eo4-20020a05600c82c400b003f05a99a841so1140190wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1681997917; x=1684589917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I86fOqTdPfylzaIxvA3BjzzASE44ZIcFNmmTwZZqPrw=;
        b=TlCEO14jZWY4AhJUFom4csBWhQmTYU8Kgq+FbMoRKNvw1syInfxOscG1p95qoAH8pm
         OCrpzM3BvwU4Zzwg/+OQuA+lkvnQW/5H4QynQogsvGQ80HPCcMsdFapGhhhX/W80t/ii
         m5gGWy6ovvfY/yrtl6uLlNISwcqeo2zfWvXKRMfm/suHtL0jy12eLF0iM7mkckaAkJEZ
         w49kRPX8FIaMfq0rV0crVoKP4Ut1CgklBYgxe4cDgsj41LnXakimps81C+RR5z21pqkq
         FvpnWXNAFTQgRLObovCErEBBGl+jF1zR73ZgVuRh4Mbypr+XrWpOW42zzT9TLXahtWdn
         GGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681997917; x=1684589917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I86fOqTdPfylzaIxvA3BjzzASE44ZIcFNmmTwZZqPrw=;
        b=KPbr4kpNQlkl96uExQjQzJxOza5qhHYEvTHr/gLcLmVcDxRpEmbl9iLSeuEcx9mk47
         hF9vT2N5wwn/tgmDGzHrxGPLuNor0s6nqqYnT4fqfbHDkJxB1VAPVaZh7qizQLSZMQzl
         xWqf02nC/Q/SYhE5BD5+P0r0lYA0lS49gRJY1/DyDCe5MtNxS6+NvbezpQ1lPd2p5YEQ
         BRlkonc5cy7ysi2PxFsfEbGScEl/Pr9C0ziqJNzvnf55K8t78CAA7eNl9N4lM/MjIZwE
         UcQ/TG7xpy9VYQ20Pz5YRUP63AeLNUMfSBKLDqddo0kzH5Ews2L8LdZg5zDgVBp9VpJ1
         qYtg==
X-Gm-Message-State: AAQBX9dGgRTd+JdbTGRp9kVBIZ6pjkZgAtymA1M3+b4nxE1dckSIYJZc
        4fV5GtZOuHj0d6EU/+vY9KzS+g==
X-Google-Smtp-Source: AKy350Y906zKhghL9lKc4oQbHZfo/lfR3EoSEnNJnhvp6BnIKQ80hBoi+rX5/wdCg9ez86meuTS8Gw==
X-Received: by 2002:a7b:cb1a:0:b0:3eb:29fe:f922 with SMTP id u26-20020a7bcb1a000000b003eb29fef922mr1273375wmj.29.1681997917596;
        Thu, 20 Apr 2023 06:38:37 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c378300b003ef5f77901dsm2012888wmr.45.2023.04.20.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:38:37 -0700 (PDT)
Date:   Thu, 20 Apr 2023 14:38:32 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Saravana Kannan <saravanak@google.com>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230420133832.nmaojwd4oxc3io5f@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <20230419175414.ycnlaperdkjxgypx@airbuntu>
 <CAGETcx8tnPgL0ekMKHvAs30NwsEzWZuCoF_BgUyMk7iJPuSGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx8tnPgL0ekMKHvAs30NwsEzWZuCoF_BgUyMk7iJPuSGhw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/23 15:49, Saravana Kannan wrote:
> On Wed, Apr 19, 2023 at 10:54 AM Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Hi David!
> >
> > On 04/16/23 14:34, David Dai wrote:
> > > A userspace service may manage uclamp dynamically for individual tasks and
> > > a child task will unintentionally inherit a pesudo-random uclamp setting.
> > > This could result in the child task being stuck with a static uclamp value
> > > that results in poor performance or poor power.
> > >
> > > Using SCHED_FLAG_RESET_ON_FORK is too coarse for this usecase and will
> > > reset other useful scheduler attributes. Adding a
> > > SCHED_FLAG_RESET_UCLAMP_ON_FORK will allow userspace to have finer control
> > > over scheduler attributes of child processes.
> >
> > Thanks a lot for the patch. This has a been a known limitation for a while but
> > didn't manage to find the time to push anything yet.
> >
> > ADPF (Android Dynamic Performance Framework) exposes APIs to manage performance
> > for a set of pids [1]. Only these tasks belong to the session and any forked
> > tasked is expected to have its uclamp values reset. But as you pointed out, the
> > current RESET_ON_FORK resets everything, but we don't want that as these
> > attributes don't belong to ADPF to decide whether they should be reset too or
> > not. And not resetting them means we can end up with tasks inheriting random
> > uclamp values unintentionally. We can't tell these tasks not to fork anything.
> > If the forked tasks are expected to be part of the session, then their pids
> > must be added explicitly.
> >
> > [1] https://developer.android.com/reference/android/os/PerformanceHintManager#createHintSession(int%5B%5D,%20long)
> >
> > >
> > > Cc: Qais Yousef <qyousef@google.com>
> > > Cc: Quentin Perret <qperret@google.com>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: David Dai <davidai@google.com>
> > > ---
> > >  include/linux/sched.h            | 3 +++
> > >  include/uapi/linux/sched.h       | 4 +++-
> > >  kernel/sched/core.c              | 6 +++++-
> > >  tools/include/uapi/linux/sched.h | 4 +++-
> > >  4 files changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 63d242164b1a..b1676b9381f9 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -885,6 +885,9 @@ struct task_struct {
> > >       unsigned                        sched_reset_on_fork:1;
> >
> > nit: can't we convert to a flag and re-use?
> >
> > >       unsigned                        sched_contributes_to_load:1;
> > >       unsigned                        sched_migrated:1;
> > > +#ifdef CONFIG_UCLAMP_TASK
> > > +     unsigned                        sched_reset_uclamp_on_fork:1;
> > > +#endif
> > >
> > >       /* Force alignment to the next boundary: */
> > >       unsigned                        :0;
> > > diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
> > > index 3bac0a8ceab2..7515106e1f1a 100644
> > > --- a/include/uapi/linux/sched.h
> > > +++ b/include/uapi/linux/sched.h
> > > @@ -132,12 +132,14 @@ struct clone_args {
> > >  #define SCHED_FLAG_KEEP_PARAMS               0x10
> > >  #define SCHED_FLAG_UTIL_CLAMP_MIN    0x20
> > >  #define SCHED_FLAG_UTIL_CLAMP_MAX    0x40
> > > +#define SCHED_FLAG_RESET_UCLAMP_ON_FORK      0x80
> > >
> > >  #define SCHED_FLAG_KEEP_ALL  (SCHED_FLAG_KEEP_POLICY | \
> > >                                SCHED_FLAG_KEEP_PARAMS)
> > >
> > >  #define SCHED_FLAG_UTIL_CLAMP        (SCHED_FLAG_UTIL_CLAMP_MIN | \
> > > -                              SCHED_FLAG_UTIL_CLAMP_MAX)
> > > +                              SCHED_FLAG_UTIL_CLAMP_MAX | \
> > > +                              SCHED_FLAG_RESET_UCLAMP_ON_FORK)
> >
> > I was considering to have something a bit more generic that allows selecting
> > which attributes to reset.
> >
> > For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined with
> > SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make it extensible
> > if we have other similar use cases in the future. The downside it *might*
> > require to be done in a separate syscall to the one that sets these parameter.
> > But it should be done once.
> 
> In addition to the downside you mentioned, I'm not a huge fan of this
> suggestion since the meaning of the SCHED_FLAG_RESET_ON_FORK_SEL flag
> changes based on what other flags or attrs are set. I'd rather we have
> explicit flags.

The concern is that these flags are limited resources. latency_nice hopefully
is coming and I don't see uclamp is an exception to warrant its own unique
reset flag. Do you think we should never ever face similar exception again?

> 
> SCHED_FLAG_RESET_ON_FORK_SEL makes it harder to maintain the userspace
> code/makes it easy to accidentally introduce bugs. For example, a
> syscall could be setting UCLAMP_MIN and RESET_ON_FORK_SEL. Someone
> else might come and change the call to also set a nice value but not
> remember to split it up into two calls. Whereas with an explicit flag
> like David's proposal, we won't hit such an issue.

I think this mode of failure exists today and not new. You'll have to remember
to set the right flag to keep policy etc otherwise you can end up with
accidental effect.

That was the first suggestion comes to mind, it could be done another ways
I suppose.

> Also, we'll need to have separate flags internally to track what needs
> to be reset on fork vs not. So we really aren't saving anything by
> adding RESET_ON_FORK_SEL.

I don't get you here. Do you mean in kernel or userspace we'll have to track?
I persume the former. It's just setting a flag in reset_on_fork variable.
I don't see the problem.

If preserving the flag space is not a concern, then yeah potentially this is
okay. Though in principle I think it doesn't make sense to continue to add new
flag for every potential similar exception. History tends to repeat itself.
I'm okay with keeping it simple if the maintainers don't share the concern
about the flag space.

user_check_sched_setscheduler() prevents none privileged users from clearing
reset_on_fork. Shouldn't we do the same?

Also we should make sure to clear it after the fork. Like is done for
reset_on_fork.


Cheers

--
Qais Yousef
