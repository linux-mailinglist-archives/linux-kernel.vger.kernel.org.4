Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB076E9B14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjDTRtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjDTRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:49:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D2B171D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:49:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v10so1564197wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1682012956; x=1684604956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HygMMU7FbRKQJ608IbHk0GAyqAIHoSgCw6k3WrZTHCI=;
        b=bXQAyHJDnv5sEsvhK91BRfRpm+H+B7gViy+Um+gucyMgtyjtaV8ffpy+lQyZDXJr/p
         zFMRZcf96sNMp1gFEz92bIzQMTLw1gz3R+xOOWTlBoYGu56GWnR7qgmF01B/iFla3kFB
         YLnp8KR5HvXqpVTi9ITQAoKdIEtXz0LNqkLynVnGlJkyIiAt2VFux2SoJB07tzHVW5bb
         /zZtqGIFL8CPEEyOOOOo1R8F3PgBfaul4tWwvV73HqmUry8i/YgPXgINOO/F+v8mmsqK
         W90lGwi01uRFRRhxjl7QFKjREMwFjQJCS/VufoObBpTgIMZKTdQeFr9nczQq8uVk4Q3B
         y0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012956; x=1684604956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HygMMU7FbRKQJ608IbHk0GAyqAIHoSgCw6k3WrZTHCI=;
        b=JXICHo489i20wCRKIqbiQPBlO25ivuWrfuJcCATdROU7/D8ADpRKdCEBIvKB8Y36qf
         uSkfeSxwYv174vKeDWwXQ9x5ZnTGJRLg/DFK8kqU3whCIRXSzRttHhSTmt7mh5PQQEz+
         uhvZUzfLFd+4xsAsaYKOLz0CAWCYh9xADwhOrs/qpHUfcWnkQaY7c+Ukv/tlmiys2tcX
         qr8QXXLrK9lfdrY9LyB5Ifas1iLM4SzkXZjGKr2ty11SmfCA0YpUzmYPECOKziPBNPk/
         8TUfgOXN9dOw0vN/r6yNCtCj8oPTQmtu7GZa3fpk6/SCWwy7gq2qASgWCjzIlt8j+d0O
         wSYQ==
X-Gm-Message-State: AAQBX9f/jsIsjY0Wx1YupOo0p4Q29Jl9rZ8NGdYpSQ/jMjYmTPMT9Qg+
        wz+Mv4UJXjAPSuRWj7KkIO5jYA==
X-Google-Smtp-Source: AKy350blZ3GYKhDZVEmsOYPOSqgy1hiXtX6YasYqYWadxtBpTqAZ5IxKh5/2uT0GzLtXwyr9E6vZYQ==
X-Received: by 2002:a05:600c:2207:b0:3f1:7324:c81d with SMTP id z7-20020a05600c220700b003f17324c81dmr1921451wml.14.1682012956591;
        Thu, 20 Apr 2023 10:49:16 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id d15-20020adfe84f000000b002fb60c7995esm2558244wrn.8.2023.04.20.10.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:49:16 -0700 (PDT)
Date:   Thu, 20 Apr 2023 18:49:12 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Quentin Perret <qperret@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] sched/uclamp: Introduce
 SCHED_FLAG_RESET_UCLAMP_ON_FORK flag
Message-ID: <20230420174912.lma5ytra6rxhssng@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
 <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
 <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
 <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/23 09:25, Saravana Kannan wrote:
> On Thu, Apr 20, 2023 at 6:44 AM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 20 Apr 2023 at 11:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >
> > > On 20/04/2023 03:11, David Dai wrote:
> > > > On Tue, Apr 18, 2023 at 10:18 PM Dietmar Eggemann
> > > > <dietmar.eggemann@arm.com> wrote:
> > > >>
> > > >
> > > > Hi Dietmar, thanks for your time,
> > > >
> > > >> On 16/04/2023 23:34, David Dai wrote:
> > > >>> A userspace service may manage uclamp dynamically for individual tasks and
> > > >>> a child task will unintentionally inherit a pesudo-random uclamp setting.
> > > >>> This could result in the child task being stuck with a static uclamp value
> > > >>
> > > >> Could you explain this with a little bit more detail? Why isn't the
> > > >> child task also managed by the userspace service?
> > > >
> > > > See Qais’ reply that contains more detail on how it’s being used in
> > > > Android. In general, if a dynamic userspace service will adjust uclamp
> > > > on the fly for a given task, but has no knowledge or control over if
> > > > or when a task forks. Depending on the timing of the fork, a child
> > > > task may inherit a very large or a small uclamp_min or uclamp_max
> > > > value. The intent of this patch is to provide more flexibility to the
> > > > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > > > value when spawned while retaining other sched attributes. When
> > > > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > > > for the child but also reset other sched attributes as well.
> > >
> > > OK, in this case, why not just change behavior and always reset the
> > > uclamp values at fork?
> > >
> > > Do we anticipate a use-case in which uclamp inheritance would be required?
> > >
> > > Let's not over-complicate the sched_[sg]etattr() unnecessarily.
> >
> > I was about to ask the same question and I'm aligned with Dietmar.
> > Use RESET_ON_FORK and set all attributes
> 
> That's racy though. If we have an external service (that's only
> responsible for setting uclamp) setting all the attributes, the forked
> thread could also be trying to set some of the attributes. Also, how
> is this external service going to keep track of all the threads being
> forked and set the right attributes for all of them?

I didn't understand what Vincent is suggesting. But based on your response it
seems we are supposed to track all the forks and reset everything. If we can
track all the forks and reset everything, then why use RESET_ON_FORK even or
rely on the kernel do anything actually..

This also smells like a hack.


Cheers

--
Qais Yousef
