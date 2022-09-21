Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761D85C0413
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiIUQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiIUQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:26:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D65262D5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:09:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAF11F91;
        Wed, 21 Sep 2022 09:08:45 -0700 (PDT)
Received: from wubuntu (unknown [10.57.50.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07EA3F5A1;
        Wed, 21 Sep 2022 09:08:35 -0700 (PDT)
Date:   Wed, 21 Sep 2022 17:08:34 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 0/8]  Add latency priority for CFS class
Message-ID: <20220921160834.4a2s3733vlr4rqfh@wubuntu>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220916080305.29574-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

On 09/16/22 10:02, Vincent Guittot wrote:
> This patchset restarts the work about adding a latency priority to describe
> the latency tolerance of cfs tasks.
> 
> The patches [1-4] have been done by Parth:
> https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> 
> I have just rebased and moved the set of latency priority outside the
> priority update. I have removed the reviewed tag because the patches
> are 2 years old.
> 
> The patch [5] uses latency nice priority to define a latency offset
> and then to decide if a cfs task can preempt the current running task. The
> patch gives some tests results with cyclictests and hackbench to highlight
> the benefit of latency priority for short interactive task or
> long intensive tasks.
> 
> Patch [6] adds the support of latency_offset to task group by adding a
> cpu.latency field. There were discussions for the last version about
> using a real unit for the field so I decided to expose directly the
> latency offset which reflects the time up to which we can preempt when the
> value is negative, or up to which we can defer the preemption when the
> value is positive.
> The range is [-sysctl_sched_latency:sysctl_sched_latency]
> 
> Patch [7] makes sched_core taking into account the latency offset.
> 
> Patch [8] adds a rb tree to cover some corner cases where the latency
> sensitive task is preempted by high priority task (RT/DL) or fails to
> preempt them. This patch ensures that tasks will have at least a
> slice of sched_min_granularity in priority at wakeup. The patch gives
> results to show the benefit in addition to patch 5
> 
> I have also backported the patchset on a dragonboard RB3 with an android
> mainline kernel based on v5.18 for a quick test. I have used
> the TouchLatency app which is part of AOSP and described to be very good
> test to highlight jitter and jank frame sources of a system [1].
> In addition to the app, I have added some short running tasks waking-up
> regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
> without overloading it (and disabling EAS). The 1st results shows that the
> patchset helps to reduce the missed deadline frames from 5% to less than
> 0.1% when the cpu.latency of task group are set.
> 
> [1] https://source.android.com/docs/core/debug/eval_perf#touchlatency

One thing that still confuses me is whether this proposal is supposed to be the
only consumer of this interface or we still expect other users to be able to
use this hint to optimize other sources of latency in the scheduler? Last
discussion [1] raised issues on the interface and I haven't seen any
discussions on the suitability of the interface to enable future consumers.

I might have missed something. What's the current state on this?


[1] https://lwn.net/Articles/820659/


Thanks

--
Qais Yousef
