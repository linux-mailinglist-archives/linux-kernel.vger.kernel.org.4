Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC35E602D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIVKtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVKtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:49:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2974CD1E7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:49:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8E31ED1;
        Thu, 22 Sep 2022 03:49:15 -0700 (PDT)
Received: from wubuntu (FVFF764EQ05P.cambridge.arm.com [10.1.27.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866793F73B;
        Thu, 22 Sep 2022 03:49:06 -0700 (PDT)
Date:   Thu, 22 Sep 2022 11:49:05 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <20220922104905.gsif5wtd5w356ghq@wubuntu>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org>
 <20220921155521.qb3jb74nbjoenau6@airbuntu>
 <YytAa9a8DSyuJWhT@slm.duckdns.org>
 <CAKfTPtBCUu80dpGneyhsZneTtcqcm3DrVVoqv6rH60oX_vEz+Q@mail.gmail.com>
 <YytF7MoZxeZ6tpCM@slm.duckdns.org>
 <CAKfTPtD1P0oTf6drOW9XwVnQ8MsCihs0rV6j+L2HV93JP-U9Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD1P0oTf6drOW9XwVnQ8MsCihs0rV6j+L2HV93JP-U9Lg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/22 08:40, Vincent Guittot wrote:
> On Wed, 21 Sept 2022 at 19:12, Tejun Heo <tj@kernel.org> wrote:
> >
> > On Wed, Sep 21, 2022 at 07:02:57PM +0200, Vincent Guittot wrote:
> > > > One option could be just using the same mapping as cpu.weight so that 100
> > > > maps to neutral, 10000 maps close to -20, 1 maps close to 19. It isn't great
> > > > that the value can't be interpreted in any intuitive way (e.g. a time
> > > > duration based interface would be a lot easier to grok even if it still is
> > > > best effort) but if that's what the per-task interface is gonna be, it'd be
> > > > best to keep cgroup interface in line.
> > >
> > > I would prefer a signed range like the [-1000:1000] as the behavior is
> > > different for sensitive and non sensitive task unlike the cpu.weight
> > > which is reflect that a bigger value get more
> >
> > How about just sticking with .nice?
> 
> Looks good to me. I will just implement the cpu.latency.nice

+1

Keeping both interfaces exposing the same thing would make the most sense IMHO.

Though it begs the question, how the per-task and cgroup interface should
interact?

For example, one of the proposed use cases was to use this knob to control how
hard we search for the best cpu in the load balancer (IIRC). If a task sets
latency_nice to -19, but it is attached to a cgroup that has cpu.latency.nice
to 20. How should the new consumer (load balancer) interpret the effective
value for the task?

IIUC, current use case doesn't care about effective value as it considers the
group and the task as separate entities. But other paths like above wouldn't
see this separation and would want to know which of the 2 to consider.

We should update Documentation/admin-guide/cgroup-v2.rst with these details for
cpu.latency.nice.


Thanks!

--
Qais Yousef
