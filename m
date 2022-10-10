Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD95FA0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJJPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJPLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:11:43 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56C33A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:11:42 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 137so4425277iou.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpxL+9O62+3Yi0R3Js9IpvfGVnmYAvOfpk15CMpinYE=;
        b=NlV8I03zPa10d9O79mNHx95juY5CFz3jCISY74cDjVk9Y91MH86cKTElZIHwkmomKi
         0P9aFlc6pMVKy78t05ANHsFRngNwZrYTIoZ975gXk4k/bCmVd+cnZGed+KwegVuNToEq
         tNC7KB3C3MvxtJecc9ZUISq8oigEjthOFUIwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpxL+9O62+3Yi0R3Js9IpvfGVnmYAvOfpk15CMpinYE=;
        b=Amvw+2+OnL+HuK8w9rRROSakU90k7wfNpoN0i7cXphzgt9VXhstKYEweOxATS5MwvA
         qNW6y2n9rvFh9z3bMzWB4MZr4csfr77fPfwL8kH0fV5VFSbdoq4/7OyUlC5mreIu5a/0
         GaiGnvB0U5nIj1Asbd3iMKHBF68Byd+4V60l8KX1rXRzxf36+zHZG4UYW90YTf6SBR/6
         ZEf+y6xAj3M93X9qq8p9ZmDOVwlTtkwoslw9nV6x5HFWNSr4Zipbg8RpxAUleLIGI739
         FFh6BXiWpikzjFBdVPdECaL6tEDA7xaEqQBilW2o7M2xMwO38U8i+4uPqk92s0IxQDRM
         qErA==
X-Gm-Message-State: ACrzQf1WmDcsKU2fqH/XAFfjCtgd4XDCh0Npb+Ndj0zRd5pi/EqKNihO
        w2wsP0KSule+eU7l/Rj8LAGSO1G+tAX1NMK3Iey1Dw==
X-Google-Smtp-Source: AMsMyM4WS7C6MHejAooxG7uxy3LNO3FIWuBynEuNu2r3Fr0BbOnvDRQidjxtDMOWNByRla119AGb+DyKOOqpTsp4ZZM=
X-Received: by 2002:a5e:9e01:0:b0:6a4:f730:624c with SMTP id
 i1-20020a5e9e01000000b006a4f730624cmr8677672ioq.107.1665414701579; Mon, 10
 Oct 2022 08:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <CALUeGD0OP4ZqDFcT10=ih40tGsm9gjjno7NP_Jwd1RxiUJZ0CQ@mail.gmail.com>
 <0BFD3887-60A2-4C74-9D37-49B7B6E64299@joelfernandes.org> <20221010144650.fjwhjdbqqaxz4sow@wubuntu>
In-Reply-To: <20221010144650.fjwhjdbqqaxz4sow@wubuntu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 10 Oct 2022 11:11:31 -0400
Message-ID: <CAEXW_YQBkgpAd0i_gJULYqUsA0f=Bui1oKh0DR47G00stD1XYA@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Youssef Esmat <youssefesmat@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:46 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 10/08/22 11:04, Joel Fernandes wrote:
> >
> >
> > > On Oct 6, 2022, at 3:40 PM, Youssef Esmat <youssefesmat@google.com> w=
rote:
> > >
> > [..]
> > >>
> > >>> Anyway - just trying to explain how I see it and why C is unlikely =
to be
> > >>> taking too much time. I could be wrong. As Youssef said, I think th=
ere's
> > >>> no fundamental problem here.
> > >>
> > >> I know on Android where they use smaller HZ, the large tick causes l=
ots of
> > >> problems for large nice deltas. Example if a highly niced task was t=
o be
> > >> preempted for 1ms, and preempts instead at 3ms, then the less-niced =
task
> > >> will not be so nice (even less nice than it promised to be) any more
> > >> because of the 2ms boost that the higher niced task got. This can le=
ad the
> > >> the sched_latency thrown out of the window. Not adjusting the weight=
s
> > >> properly can potentially make that problem much worse IMO.
> > >
> > > Once C releases the lock it should get adjusted and A will get adjust=
ed
> > > also regardless of tick. At the point we adjust the weights we have
> > > a chance to check for preemption and cause a reschedule.
> >
> > Yes but the lock can be held for potentially long time (and even user s=
pace
> > lock). I=E2=80=99m more comfortable with Peter=E2=80=99s PE patch which=
 seems a more generic
> > solution, than sum of weights if we can get it working. I=E2=80=99m stu=
dying Connor=E2=80=99s
> > patch set now=E2=80=A6
>
> The 2 solutions are equivalent AFAICT.

Possibly. Maybe I am talking about a non-issue then, but I had to be
careful ;-) Maybe both have the issue I was referring to, or they
don't. But in any case, PE seems more organic.

> With summation:
>
>    A    ,    B   ,    C   ,    D
> sleeping, running, running, running
>    -    ,   1/5  ,   3/5  ,   1/5
>
> Where we'll treat A as running but donate its bandwidth to C, the mutex o=
wner.

> With PE:
>
>    A    ,    B   ,    C   ,    D
>  running, running, running, running
>    2/5  ,   1/5  ,   1/5  ,   1/5
>
> Where A will donate its execution context to C, the mutex owner.

Yes. It would also be great if Peter can participate in this thread,
if he has time. Not to nitpick but to be more precise in PE
terminology, you mean "scheduler context". The "execution context" is
not inherited [1]

If p1 is selected to run while still blocked, the lock owner p2 can
run "on its behalf", inheriting p1's scheduler context. Execution
context is not inherited, meaning that e.g. the CPUs where p2 can run
are still determined by its own affinity and not p1's.

[1] https://lore.kernel.org/all/73859883-78c4-1080-7846-e8d644ad397a@redhat=
.com/t/#mdf0146cdf78e48fc5cc515c1a34cdc1d596e0ed8

> In both cases we should end up with the same distribution as if neither A=
 nor
> C ever go to sleep because of holding the mutex.

Hopefully!

> I still can't see how B and D fairness will be impacted as the solution t=
o the
> problem is to never treat a waiter as sleeping and let the owner run for =
more,
> but only within the limit of what the waiter is allowed to run for. AFAIC=
S,
> both solutions maintain this relationship.

True!

 - Joel
