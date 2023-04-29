Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAAC6F2534
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjD2PdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 11:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjD2PdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 11:33:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E336B10E4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EtkcXa4cV02jvPDpEG6V0iUwR+JYuKgWq0nZoc0d0QI=; b=bhYQ2ZaefgZU1JcPDKzi7Ji8Ph
        JzYGM5T+YLzhKiZzaj9aiRLLq0RkD9onwZerei2saZIZn9s6PZopDgGYtPUR95fhjlnoE+OdvU0oY
        5lHqQS5Ci3uSVFI7V9XxZTd84yR4mIJ6wZ2bGwCv9ZuwkZO2lH1BWfLhaMYBsGKJpLedC5/mIDk3R
        cxqiRvUS/uhDXNOh+qR2FM/pXZA8YIUl75hBGiPhDC9gPqTg9kKgRCrrD3hFX5PGHJlvuz3QzEQZd
        g9CL4VAbT9DDJICoQOUaGmsfQQia0TD5mDjXJ8dqZB4gN7QK0XXwiHkAufU1u2M7qdZOA1Sgz3gIu
        UZqCcJyA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1psmYg-00E9d4-2R;
        Sat, 29 Apr 2023 15:32:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDCB0300379;
        Sat, 29 Apr 2023 17:32:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A688241CCBC3; Sat, 29 Apr 2023 17:32:19 +0200 (CEST)
Date:   Sat, 29 Apr 2023 17:32:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
Message-ID: <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
> Hi,
> 
> This is v4 of this series. Previous versions can be found here [1], [2],
> and here [3]. To avoid duplication, I do not include the cover letter of
> the original submission. You can read it in [1].
> 
> This patchset applies cleanly on today's master branch of the tip tree.
> 
> Changes since v3:
> 
> Nobody liked the proposed changes to the setting of prefer_sibling.
> Instead, I tweaked the solution that Dietmar proposed. Now the busiest
> group, not the local group, determines the setting of prefer_sibling.
> 
> Vincent suggested improvements to the logic to decide whether to follow
> asym_packing priorities. Peter suggested to wrap that in a helper function.
> I added sched_use_asym_prio().
> 
> Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
> rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
> does not assume that all child domains have the requested flag.
> 
> Tim found that asym_active_balance() needs to also check for the idle
> states of the SMT siblings of lb_env::dst_cpu. I added such check.
> 
> I wrongly assumed that asym_packing could only be used when the busiest
> group had exactly one busy CPU. This broke asym_packing balancing at the
> DIE domain. I limited this check to balances between cores at the MC
> level.
> 
> As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
> and placed its logic in sched_asym(). Also, sched_asym() uses
> sched_smt_active() to skip checks when not needed.
> 
> I also added a patch from Chen Yu to enable asym_packing balancing in
> Meteor Lake, which has CPUs of different maximum frequency in more than
> one die.

Is the actual topology of Meteor Lake already public? This patch made me
wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,
but I can't remember (one of the raisins why the endless calls are such
a frigging waste of time) and I can't seem to find the answer using
Google either.

> Hopefully, these patches are in sufficiently good shape to be merged?

Changelogs are very sparse towards the end and I had to reverse engineer
some of it which is a shame. But yeah, on a first reading the code looks
mostly ok. Specifically 8-10 had me WTF a bit and only at 11 did it
start to make a little sense. Mostly they utterly fail to answer the
very fundament "why did you do this" question.

Also, you seem to have forgotten to Cc our friends from IBM such that
they might verify you didn't break their Power7 stuff -- or do you have
a Power7 yourself to verify and forgot to mention that?

> Chen Yu (1):
>   x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
>     processors
> 
> Ricardo Neri (11):
>   sched/fair: Move is_core_idle() out of CONFIG_NUMA
>   sched/fair: Only do asym_packing load balancing from fully idle SMT
>     cores
>   sched/fair: Simplify asym_packing logic for SMT cores
>   sched/fair: Let low-priority cores help high-priority busy SMT cores
>   sched/fair: Keep a fully_busy SMT sched group as busiest
>   sched/fair: Use the busiest group to set prefer_sibling
>   sched/fair: Do not even the number of busy CPUs via asym_packing
>   sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
>   sched/topology: Remove SHARED_CHILD from ASYM_PACKING
>   x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
>   x86/sched/itmt: Give all SMT siblings of a core the same priority
> 
>  arch/x86/kernel/itmt.c         |  23 +---
>  arch/x86/kernel/smpboot.c      |   4 +-
>  include/linux/sched/sd_flags.h |   5 +-
>  kernel/sched/fair.c            | 216 +++++++++++++++++----------------
>  kernel/sched/sched.h           |  22 +++-
>  5 files changed, 138 insertions(+), 132 deletions(-)

I'm going to start to queue this and hopefully push out post -rc1 if
nobody objects.
