Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ED56D907B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjDFHdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjDFHdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:33:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC46B2112
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MoneTFHNrHm1CvMkTKFe0BpHprRoUxLmWShJckHDj2I=; b=D6963OF3z0C1n3q4u87jm+NYfK
        WBNoysKn/KLPrVu9EtWRXP3AHuqZBKlwPVYiDKC/vqHVsKVdu4srup98wUTAqEx8/g83uQ4x82j+c
        /mmitR4Z6VpjkAgcHlIggZHKcnE/E91ONLoYXb9wEpGNP6fMsSS7LmpQKRmfnTtWBbbNkdCLMrDAI
        jXu8KUR01AIqcbIAh1t4QjSQxzvtzWrF9veXQk3NqTG0vp7QbyMUKIEbmI53u78sx0MDYSAMdy6Zs
        5hrNxLPHewjYTOhDpQ1cQMq8M/SkV5IRS062GpNqVNkLDQDKDzifnvDlSKVF2/utEfimgSKpVtFgM
        SbfHWKPw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pkK7g-00ASWh-1u;
        Thu, 06 Apr 2023 07:33:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9FAD63000DC;
        Thu,  6 Apr 2023 09:33:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 660D1200BFC2F; Thu,  6 Apr 2023 09:33:30 +0200 (CEST)
Date:   Thu, 6 Apr 2023 09:33:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Dai <davidai@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
Message-ID: <20230406073330.GA386572@hirez.programming.kicks-ass.net>
References: <20230330224348.1006691-1-davidai@google.com>
 <20230330224348.1006691-2-davidai@google.com>
 <20230405081449.GX4253@hirez.programming.kicks-ass.net>
 <CABN1KCLjXpxNak90iowd0iiz9SD8-5n+6S3kEoCKO9NantyXxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABN1KCLjXpxNak90iowd0iiz9SD8-5n+6S3kEoCKO9NantyXxg@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:54:08PM -0700, David Dai wrote:
> On Wed, Apr 5, 2023 at 1:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> 
> Hi Peter,
> 
> Appreciate your time,
> 
> > On Thu, Mar 30, 2023 at 03:43:36PM -0700, David Dai wrote:
> > > @@ -499,6 +509,7 @@ struct sched_avg {
> > >       unsigned long                   load_avg;
> > >       unsigned long                   runnable_avg;
> > >       unsigned long                   util_avg;
> > > +     unsigned long                   util_guest;
> > >       struct util_est                 util_est;
> > >  } ____cacheline_aligned;
> > >
> >
> > Yeah, no... you'll have to make room first.
> >
> 
> I’m not sure what you mean. Do you mean making room by reducing
> another member in the same struct? If so, which member would be a good
> fit to shorten? Or do you mean something else entirely?

Yeah, as you can see below, this structure is completely filling up the
cacheline already so there's no room for another member. I've not looked
at this in detail in a little while so I'm not at all sure what would be
the easiest way to free up space.

Going by the rest of the discusion is seems this is the least of your
problems though.

> > struct sched_avg {
> >         /* typedef u64 -> __u64 */ long long unsigned int     last_update_time;          /*     0     8 */
> >         /* typedef u64 -> __u64 */ long long unsigned int     load_sum;                  /*     8     8 */
> >         /* typedef u64 -> __u64 */ long long unsigned int     runnable_sum;              /*    16     8 */
> >         /* typedef u32 -> __u32 */ unsigned int               util_sum;                  /*    24     4 */
> >         /* typedef u32 -> __u32 */ unsigned int               period_contrib;            /*    28     4 */
> >         long unsigned int          load_avg;                                             /*    32     8 */
> >         long unsigned int          runnable_avg;                                         /*    40     8 */
> >         long unsigned int          util_avg;                                             /*    48     8 */
> >         struct util_est {
> >                 unsigned int       enqueued;                                             /*    56     4 */
> >                 unsigned int       ewma;                                                 /*    60     4 */
> >         } __attribute__((__aligned__(8)))util_est __attribute__((__aligned__(8))); /*    56     8 */
> >
> >         /* size: 64, cachelines: 1, members: 9 */
> >         /* forced alignments: 1 */
> > } __attribute__((__aligned__(64)));
> >
> >
