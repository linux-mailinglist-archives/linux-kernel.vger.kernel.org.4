Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900065F11C4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiI3Sp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiI3SpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:45:24 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47682847
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:45:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h194so3960499iof.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=V/8OUi0y2zSRQAEmELr/gTFzFq0lf1RWO1Nn86ycirE=;
        b=UtZmlD/YI/sJppVq5AupJRBR9eUUmwdYaPtUsu8DV0OprRaadWaYrVUUKGw8WT/5wt
         qqg44JWSy+0kpicyUoVeCMv4gXiHEDY2G4/gIdiOImBmlCMVk+NMxFhI5yM8dbU8l9UW
         5fy5J7fwvgcCi/t7+sPxDszis6TnC0yWTVltY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=V/8OUi0y2zSRQAEmELr/gTFzFq0lf1RWO1Nn86ycirE=;
        b=GpvvqdSF2FTBBKHqc9NVVoFzGJMgreuMnS4y0ZKzL5YbdzR+H9Xb97+4VSXFBaEUmZ
         t9dtx9GKQStvSGRh3CDO8OoTnLvvoVgRQx4DnsiqsZMQLtw1NQnc7YdVFCAeRPHEDS4U
         kfgoos0rKGwoRFg4IkTIHyRKdW9MXzf3A5sQ25MFfIuhgFzpcJuR9S2ZmFujB0uji7wh
         uAznAKG61J7TIfk6PVI1NYYw+waPXyJpYnEOjMPuSwsYaElZ/s9okZMheARr10ChwQfD
         N3tu146Uj9HssxVsALkZfJfw40ktF2hZoTqJP6hw72+CnYY47jSPwbTeDuYHQJkOZcQO
         vVuA==
X-Gm-Message-State: ACrzQf05RG7kj5hhC0xWDByE+TV66tcMowzKbIfkt0F2klmQfQoBmUXT
        oPUmf9kM3w2dPFgqVI4U6QjKrjZ0TCX9dQQy722D4w==
X-Google-Smtp-Source: AMsMyM6xyAGY7/byl92L73EZ75Fh79XD36tNz3G38k6wCW2rRIAYU4yoDaeorrfEagoW2fnCi+RkUEscK3OE6D7ojSU=
X-Received: by 2002:a05:6638:19:b0:35a:52a2:dfbe with SMTP id
 z25-20020a056638001900b0035a52a2dfbemr5052875jao.213.1664563522097; Fri, 30
 Sep 2022 11:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <cb6c406e-1431-fcfd-ef82-87259760ead9@joelfernandes.org>
 <20220930134931.mpopdvri4xuponw2@wubuntu> <CALUeGD0yEimCRS2TQfZTUD2kwamyTZwM9Y9D7C=Xsd9t9mWsaw@mail.gmail.com>
 <a4a7a4de-c58d-d667-a4b3-0f7bfb2b09f1@joelfernandes.org> <CALUeGD21QY+-6oLUztdecg5C8AX9xToxpGpxx5M5D9VnhSkVMg@mail.gmail.com>
In-Reply-To: <CALUeGD21QY+-6oLUztdecg5C8AX9xToxpGpxx5M5D9VnhSkVMg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 30 Sep 2022 14:45:10 -0400
Message-ID: <CAEXW_YQQ=CfQEOkXK-VFJtZTdY=_TsWz=Ndgg_BgJumFHJktkQ@mail.gmail.com>
Subject: Re: Sum of weights idea for CFS PI
To:     Youssef Esmat <youssefesmat@google.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, bristot@redhat.com,
        clark.williams@gmail.com, bigeasy@linutronix.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 2:10 PM Youssef Esmat <youssefesmat@google.com> wrote:
[..]
> > > Hi Everyone!
> >
> > Hi Youssef,
> >
> > (Youssef is new to LKML though in no way new to OS or software development. I
> > gave him the usual 'dont-top-post' chat already - fyi).
> >
> > > I am not sure we should care about A's sleeping pattern. The case we
> > > care about is when A is running or wants to run but can't because it
> > > is blocked on C. In that case C should get the weight of A as if A was
> > > running.
> >
> > Just to clarify - Youssef did mean sum of weights of different things in the
> > chain, and not just weights (he confirmed on chat that that's what he meant).
> >
>
> Yeah thanks for clarifying, I meant that C should get the sum of
> weights as if A was running (3/5 in your example) since in this
> segment of time A would have been running if it was not blocked on the
> lock. I think it's safe to ignore the average and just use the sum of

For the onlooker, we are talking about the classical case of priority
inversion involving 3 tasks A, B and C which can be expanded to a
chain of tasks. Highest prio A blocks on a lock that lowest prio C
holds, while an unrelated medium prio B blocks C (or reduces progress
of it as in the case of CFS).

On the note of "A would have been running if it was not blocked on the
lock". I think that would be an assumption - we don't know if A would
be running. We only know the past, not the future. A could very well
make an I/O request for example. Hence there could be a need to use
A's past utilization, right?

thanks,

 - Joel
