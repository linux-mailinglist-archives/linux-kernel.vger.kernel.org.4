Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C406F5B98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 17:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjECPz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 11:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjECPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 11:55:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EE065B9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 08:55:50 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1aae90f5ebcso232585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683129350; x=1685721350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzf+7747a/zpx6MU5OX1OCMDb3i6d994EroAWrMJ6KI=;
        b=F1KjJK0rLgfZNiiv+lhmkG7RCinDGodaNK4gjdGgJKgV/6JpisxE+bCNKmQ8FG8NyD
         ZDj6CUJKYY1sDNx2FbBekA8pr6aaaO3Nx6coZ0hA3fK6rwPwZakpuNgc+W3wLxWCWKb7
         ZrA/m9E7q/RfpfT4EDoOfrN35ocDCwWXZkODeIAcmw3ZKJlh5L01x2GBowlAQBsyw8T0
         IG0KMEQ1l/O1yNsF23dq4XM2FYa9MoBDa7jCWeq3tzm9hpu4ww9V3s8FEgDuajVXXzgi
         /XPtffQdTmW+rrgu6yewovh8gxLMyHzw4YJhEdy3ULQH2rtDpC9hPfDgAbZuZ5vHYw4n
         /A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683129350; x=1685721350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zzf+7747a/zpx6MU5OX1OCMDb3i6d994EroAWrMJ6KI=;
        b=KYZqUONoXXEcx5onLKljbWw57ypCUgU51rNvQYQtFxWOKuF0SV1YJVq5KTnkzDkYT5
         IO+1rn9RHXjSKnGVH4lOYoktGaWQfZ4Q5yjW1qbf1NSp1CSG/PVJKKNZ6ota2+u5TXdH
         TOuNK6bIhma8Q+HABDdRhxuBoaA62N47pmye2rLVdr2gat8F5rWJXo7s9RzQ9ZDx5coC
         jWXiOhOtlh3dwY88Y2L7UFhgJy+IxL12w/HLN01EZMvje7Q0QBaa6KlSR5YHYCQE53lN
         LoN98kUbBZZcQJncPRnnuCgicPTj/qfeKbGqisIYlPpoHSI1sL3g7cEJtSbZhNFgj3bL
         M/WA==
X-Gm-Message-State: AC+VfDxLELMQOtCOQtbK09H1TFhdXzGySC4Uxz3rFJxUvfHC6gd1zARn
        bdl4BJ6VQPSx7SG0nJ5KJyeeiXvHqOoimDGWbtetm4DLqsxfbR1Ksq+ADQ==
X-Google-Smtp-Source: ACHHUZ5GnQZQuZMHaK19pDt8dDlmDEKbnjeFFpOjyC+vYuo7ghTFsejOidcHtRpA4bE8k7QPbIi/R4yi4B38if8fZCQ=
X-Received: by 2002:a17:903:2804:b0:1a6:d776:9628 with SMTP id
 kp4-20020a170903280400b001a6d7769628mr212021plb.19.1683129349854; Wed, 03 May
 2023 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230416213406.2966521-1-davidai@google.com> <20230419175414.ycnlaperdkjxgypx@airbuntu>
 <20230428115755.7uklfd4fmpoee4dp@airbuntu> <CAGETcx9xjLzQ2b3FraPsmG=w6=4pYU-tzW-na0Fd5qyrU+C+Yw@mail.gmail.com>
 <20230503132943.sz22x4zlln4xagjj@airbuntu>
In-Reply-To: <20230503132943.sz22x4zlln4xagjj@airbuntu>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 May 2023 08:55:13 -0700
Message-ID: <CAGETcx9RnVwz3fO2U4x-CkZcMoECee9kUXb_vm0kDK9kXLXapQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce SCHED_FLAG_RESET_UCLAMP_ON_FORK
 flag
To:     Qais Yousef <qyousef@layalina.io>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 6:29=E2=80=AFAM Qais Yousef <qyousef@layalina.io> wr=
ote:
>
> On 04/28/23 11:12, Saravana Kannan wrote:
> > On Fri, Apr 28, 2023 at 4:57=E2=80=AFAM Qais Yousef <qyousef@layalina.i=
o> wrote:
> > >
> > > On 04/19/23 18:54, Qais Yousef wrote:
> > >
> > > [...]
> > >
> > > > I was considering to have something a bit more generic that allows =
selecting
> > > > which attributes to reset.
> > > >
> > > > For example a syscall with SCHED_FLAG_RESET_ON_FORK_SEL combined wi=
th
> > > > SCHED_FLAG_UCLAMP_MIN/MAX will only reset those. This should make i=
t extensible
> > > > if we have other similar use cases in the future. The downside it *=
might*
> > > > require to be done in a separate syscall to the one that sets these=
 parameter.
> > > > But it should be done once.
> > > >
> > > > Maybe there's a better interface, but I think it makes sense to do =
it in a way
> > > > that we won't have to do this again. Would be good to hear from mai=
ntainers
> > > > first before you take my word for it ;-)
> > >
> > > Actually I think we can do a better and simpler generic interface. We=
 don't
> > > need a new flag. We can just add a new parameter for what to reset on=
 fork.
> > > When this value is 0 (which it should be by default), it means reset
> > > everything.
> >
> > Isn't he default NOT to reset everything?
>
> The default when the RESET_ON_FORK flag is set. This field will not be us=
ed
> otherwise. Like what happens for the other params.
>
> >
> > > // pseudo code
> > >
> > > #define RESET_ON_FORK_ALL       0
> > > #define RESET_ON_FORK_POLICY    BIT(1) // implies resetting priority
> > > #define RESET_ON_FORK_PRIORITY  BIT(2)
> > > #define RESET_ON_FORK_UCLAMP    BIT(3)
> > >
> > > struct sched_attr {
> > >         ...
> > >         __u64 sched_reset_on_fork_flags;
> > > };
> > >
> >
> > Also, honestly I think this is over designing for a hypothetical. We
>
> latency_nice is coming next and most likely to require something similar.=
 It's
> not hypothetical nor over designing. I think it's worthwhile spending tim=
e to
> plan for the future. More interfaces are confusing to the end users. And =
glibc
> already complained about evolution of sched_setattr, that's why we don't =
have
> a wrapper there yet (beside none of us pushed that hard to resolve the co=
ncerns
> due to lack of bandwidth).

My comment about over designing/hypothetical is about the "running out
of bits" concern you are trying to solve. Totally agree that we'll
likely need finer reset control and never disagreed with that. But we
can add those as we go to the existing flag field instead of
introducing a new one.

> https://public-inbox.org/libc-alpha/87va826rsb.fsf@mid.deneb.enyo.de/
>
> (this thread reminded me linux-api must be CCed)
>
> And there has been various discussions of the need of higher level
> wrappers/libraries that exposes simpler interface to app developers. So I=
'm
> actually expecting this to repeat. I think that was at LPC by Len Brown. =
I can
> find this thread on libc mailing list.
>
> https://public-inbox.org/libc-alpha/CAMe9rOpUh1pjfEUqf_hNxce8ZX=3D4mg6W=
=3Dn+BbdZSNFHLi7wtkw@mail.gmail.com/
>
> These QoS hints might imply manipulating nice values and I can see ending=
 up
> with a similar situation where we need to reset nice on fork without rese=
tting
> other params.
>
> Generally I don't think we should restrict users to self-managed model.
> A delegated model does make sense, and the latter implies the need for fi=
ner
> control on what to reset.
>
> There's rtkit by the way which already an example of a delegating model t=
o
> enable creating RT tasks by non privileged users.
>
> Should rtkit force resetting uclamp when on fork? I think it's a grey are=
a and
> I learn towards it shouldn't.

Nothing to say to any of the stuff above because I didn't disagree on
this in the first place.

> > have approximately 53 unused bits. By the time we run out of those,
> > we'd have added at least 20-50 more fields. At that point, we can
> > always add a flags2 field if we need it. I like David's patch as is --
> > it's clear and simple. Add a flag for explicitly what we are trying to
> > do and extend as needed.
>
> Fair enough. As I said if the maintainers are okay with current proposal,=
 no
> objection from my side. Based on my experience I didn't expect them to be=
. And
> I do think a generic solution is not really complicated and is the better
> option. You can consider this as a backup plan ;-)

I think the fact I could misunderstand the API and you had to explain
it makes it a bit more complicated (agree, not a lot) over just using
the existing bits. And I think that's what the maintainers are pushing
back on (in addition to even having finer reset control).

-Saravana
