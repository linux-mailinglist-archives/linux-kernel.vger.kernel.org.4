Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DC6F16F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345789AbjD1LpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345945AbjD1Lo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:44:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A315BB9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:44:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2f58125b957so8913077f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1682682287; x=1685274287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P6/aX0pjGA8oLPAxpT7Bqo52a3vTQjbKWU5jNN+quzY=;
        b=W6ekVWa/voyYFiTISBGqQaPat0XKYjXTPt7fq//3DlKxX7yzojKMe8fo2PEQR2pTmu
         JWSx14Yc0QwPOll3HgWyrh3IGdhdfg2vSJg4dUW2VAZIJeD11vQs+mCX5kLvUOsEJZGL
         ZFdmfSNyMobPiBnHfM9HOTXEoNUSo+wbqB+2+QCx1zXLh+80D5fyYKrHgYbPf/1+57yL
         wuSojJ98wVyNGLZPbfuCrXv9CqPxiP2jLC0bzlRTvSZEn5ODnWADsgk1sYq44AG175tq
         n2tWFXWxp3/qfY/s4qP/YuaN57H2fZfvvTZHhsfZRqhd8QARrTOpfsW5x6K150uebBEo
         P5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682682287; x=1685274287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P6/aX0pjGA8oLPAxpT7Bqo52a3vTQjbKWU5jNN+quzY=;
        b=RVneAWd35rWjNnPkCDpvvuazqveFh45w7JcqrJFDgcLhLEqnR/8ozKqMmmtW8j9Fz9
         tdfD4kKkfdnRKe4AG2vaB5grMietb92nbUtNMy3dsyLJFd8d+GrlzCZB0/M1Zt6JOUOz
         FK4sCPUSA+ie8HtZVlBZZ3iI4wgkstm8LJNuQ4jRs53HH3J41KfRRtSFaywvcyMg6Mn6
         s8G00cGEDENXr2TVSybGiubNAQYiRKto0MMZGNFpYNDxWXDGO2KiimxImULehWpDcHMf
         oE+gNdPmRGxVWfnuhUMIC1gA8vPmornJUOZimFYHYOwVeoaprGttLwz1TTCHWsBoV+yN
         Qo5g==
X-Gm-Message-State: AC+VfDyEvofaPAN1e28smouiGEQA7+D6vG1bKrfPJEaENNor1a2jEjOU
        jyNH52GaxUwwJZwCrwp7yrmU/w==
X-Google-Smtp-Source: ACHHUZ77CPCQHF82m6DipVHfW8UJyt3V7Sm0wNB1KRDFwqe06bAM3vbltx9G564IPBCVS4jIk/Fnhw==
X-Received: by 2002:a5d:4444:0:b0:2ef:b3e6:8293 with SMTP id x4-20020a5d4444000000b002efb3e68293mr3574166wrr.9.1682682287202;
        Fri, 28 Apr 2023 04:44:47 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d48ca000000b003047dc162f7sm11622477wrs.67.2023.04.28.04.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 04:44:46 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:44:42 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
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
Message-ID: <20230428114442.t2blsllmgntooayy@airbuntu>
References: <20230416213406.2966521-1-davidai@google.com>
 <d83950c4-7458-aeea-f341-327c163704a8@arm.com>
 <CABN1KC+_HDi_i2zzpZVbqiUP5-QB9YrE5wzLqr==_wOemaCXzA@mail.gmail.com>
 <bf8f21be-7249-fc27-9704-211d0f5a12b1@arm.com>
 <CAKfTPtAgkyE1xntn-4u9o8DFhH9iGq54c-QXYr0cE+zvoPx9Gw@mail.gmail.com>
 <CAGETcx-suryHeB3wpaTSZBiw6+VwA7pe=GnrbtizSVj+C9Smtg@mail.gmail.com>
 <CAKfTPtAfLqzwbCdd25HCFykBDhBQs9g7Mr6=X56nKYOOPnEdNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAfLqzwbCdd25HCFykBDhBQs9g7Mr6=X56nKYOOPnEdNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

Sorry for the late response.

On 04/21/23 17:10, Vincent Guittot wrote:
> On Thu, 20 Apr 2023 at 18:26, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 6:44 AM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 20 Apr 2023 at 11:37, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >
> > > > On 20/04/2023 03:11, David Dai wrote:
> > > > > On Tue, Apr 18, 2023 at 10:18 PM Dietmar Eggemann
> > > > > <dietmar.eggemann@arm.com> wrote:
> > > > >>
> > > > >
> > > > > Hi Dietmar, thanks for your time,
> > > > >
> > > > >> On 16/04/2023 23:34, David Dai wrote:
> > > > >>> A userspace service may manage uclamp dynamically for individual tasks and
> > > > >>> a child task will unintentionally inherit a pesudo-random uclamp setting.
> > > > >>> This could result in the child task being stuck with a static uclamp value
> > > > >>
> > > > >> Could you explain this with a little bit more detail? Why isn't the
> > > > >> child task also managed by the userspace service?
> > > > >
> > > > > See Qais’ reply that contains more detail on how it’s being used in
> > > > > Android. In general, if a dynamic userspace service will adjust uclamp
> > > > > on the fly for a given task, but has no knowledge or control over if
> > > > > or when a task forks. Depending on the timing of the fork, a child
> > > > > task may inherit a very large or a small uclamp_min or uclamp_max
> > > > > value. The intent of this patch is to provide more flexibility to the
> > > > > uclamp APIs such that child tasks do not get stuck with a poor uclamp
> > > > > value when spawned while retaining other sched attributes. When
> > > > > RESET_ON_FORK is set on the parent task, it will reset uclamp values
> > > > > for the child but also reset other sched attributes as well.
> > > >
> > > > OK, in this case, why not just change behavior and always reset the
> > > > uclamp values at fork?
> > > >
> > > > Do we anticipate a use-case in which uclamp inheritance would be required?
> > > >
> > > > Let's not over-complicate the sched_[sg]etattr() unnecessarily.
> > >
> > > I was about to ask the same question and I'm aligned with Dietmar.
> > > Use RESET_ON_FORK and set all attributes
> >
> > That's racy though. If we have an external service (that's only
> > responsible for setting uclamp) setting all the attributes, the forked
> > thread could also be trying to set some of the attributes. Also, how
> > is this external service going to keep track of all the threads being
> > forked and set the right attributes for all of them?
> 
> My assumption was that you didn't use RESET_ON_FORK because there were
> other attributes that you wanted to keep from parent but it doesn't

Correct.

> seem to be the case so use RESET_ON_FORK and if needed the forked
> thread will set its other attributes

Hmm, it seems you think it's the parent who's trying to control the fork for
the child. But the situation we're in is different.

ADPF is a shared library/middleware/system service that provides higher level
API to manage the performance requirements for a group of tasks. They provide
a set of PIDs and a deadline, then continuously tell it how long they took to
finish their work. ADPF uses this info to manipulate uclamp_min dynamically on
their behalf so they finish their work in time. Explaining it very simply and
briefly here. It should make using uclamp_max easier too (though we are not
there yet) since the most efficient point is platform specific and the
middleware can help abstract this better in a portable way.

The problem is these tasks can be RT and/or can have their priorities/nice
values set by something else. But what we want is to make sure that we control
uclamp values only for the PIDs we were asked to manage, and anything forked
must have their uclamp values reset, but not the rest as this is outside of
this service available context. It gets delegated to handle performance hints
only and make using uclamp easier and generic. But this should not interfere
with policy and priority management done outside of its scope.

Apps that manage their own uclamp values wouldn't need this. But if we are to
build a smart middleware that provides a consistent and easier to use higher
level APIs, which is what we have here, we need this selective reset on fork.

Does this explain the problem better?

Note we noticed because we saw problems here. So we are not trying to be
theoretically cautious.


Thanks!

--
Qais Yousef
