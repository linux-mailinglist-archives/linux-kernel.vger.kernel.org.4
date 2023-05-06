Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012C86F8D0A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEFAIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjEFAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:08:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B446A41
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 17:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kfouKqifwfLU/fnGvsNmjf5j86ymKkHEurgeg0D3djY=; b=jD/PGhWF+MopHUzZCAmBl5jADh
        Th4Ps0MGfcgL/FMbqVjKjKg2KNoK56gTxClNdRvwShVti7Wtr1XOmuZPkQ1iv5dObsMMGzGhlz2DD
        NGlHaaKXzZrdTMSlNLSgUw3fI3lSge3nO4032uswOAdIXiwul2NRNcFTEOhvMjs2KahbrkXNzh4QD
        WqEshVcKSemAwmCYKTD9JL3YNLY+3R2QhadKAfqsrzhiQSuwoo6k6M2L8NS7KRWbo89tBi1mzYNbi
        0jxeLTXPxLXJqbwBfNXnQU+PNTsS1eJ/Lkg786jSbsRlM45IyiUfxTBj4GxjGkyDo2lAMTwRxUy0k
        0z6/QUlw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pv5TG-003PTy-1U;
        Sat, 06 May 2023 00:08:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27379306028;
        Sat,  6 May 2023 02:08:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F40FD23937D99; Sat,  6 May 2023 02:08:15 +0200 (CEST)
Date:   Sat, 6 May 2023 02:08:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH 4/6] sched/fair: Skip prefer sibling move between SMT
 group and non-SMT group
Message-ID: <20230506000815.GA1824020@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
 <20230505132211.GQ83892@hirez.programming.kicks-ass.net>
 <7c5ad793fe0195f7129156b67a043df18b46d732.camel@linux.intel.com>
 <20230505233836.GB1821641@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505233836.GB1821641@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 01:38:36AM +0200, Peter Zijlstra wrote:
> On Fri, May 05, 2023 at 04:07:39PM -0700, Tim Chen wrote:
> > On Fri, 2023-05-05 at 15:22 +0200, Peter Zijlstra wrote:
> > > On Thu, May 04, 2023 at 09:09:54AM -0700, Tim Chen wrote:
> > > > From: Tim C Chen <tim.c.chen@linux.intel.com>
> > > > 
> > > > Do not try to move tasks between non SMT sched group and SMT sched
> > > > group for "prefer sibling" load balance.
> > > > Let asym_active_balance_busiest() handle that case properly.
> > > > Otherwise we could get task bouncing back and forth between
> > > > the SMT sched group and non SMT sched group.
> > > > 
> > > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > > ---
> > > >  kernel/sched/fair.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index 8a325db34b02..58ef7d529731 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > > >  	/*
> > > >  	 * Try to move all excess tasks to a sibling domain of the busiest
> > > >  	 * group's child domain.
> > > > +	 *
> > > > +	 * Do not try to move between non smt sched group and smt sched
> > > > +	 * group. Let asym active balance properly handle that case.
> > > >  	 */
> > > >  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> > > > +	    !asymmetric_groups(sds.busiest, sds.local) &&
> > > >  	    busiest->sum_nr_running > local->sum_nr_running + 1)
> > > >  		goto force_balance;
> > > 
> > > This seems to have the hidden assumption that a !SMT core is somehow
> > > 'less' that an SMT code. Should this not also look at
> > > sched_asym_prefer() to establush this is so?
> > > 
> > > I mean, imagine I have a regular system and just offline one smt sibling
> > > for giggles.
> > 
> > I don't quite follow your point as asymmetric_groups() returns false even
> > one smt sibling is offlined.
> > 
> > Even say sds.busiest has 1 SMT and sds.local has 2 SMT, both sched groups still
> > have SD_SHARE_CPUCAPACITY flag turned on.  So asymmetric_groups() return
> > false and the load balancing logic is not changed for regular non-hybrid system.
> > 
> > I may be missing something.
> 
> What's the difference between the two cases? That is, if the remaining
> sibling will have SD_SHARE_CPUCAPACIY from the degenerate SMT domain
> that's been reaped, then why doesn't the same thing apply to the atoms
> in the hybrid muck?
> 
> Those two cases *should* be identical, both cases you have cores with
> and cores without SMT.

On my alderlake:

[  202.222019] CPU0 attaching sched-domain(s):
[  202.222509]  domain-0: span=0-1 level=SMT
[  202.222707]   groups: 0:{ span=0 }, 1:{ span=1 }
[  202.222945]   domain-1: span=0-23 level=MC
[  202.223148]    groups: 0:{ span=0-1 cap=2048 }, 2:{ span=2-3 cap=2048 }, 4:{ span=4-5 cap=2048 }, 6:{ span=6-7 cap=2048 }, 8:{ span=8-9 cap=2048 }, 10:{ span=10-11 cap=2048 },12:{ span=12-13 cap=2048 }, 14:{ span=14-15 cap=2048 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }, 23:{ span=23 }
...
[  202.249979] CPU23 attaching sched-domain(s):
[  202.250127]  domain-0: span=0-23 level=MC
[  202.250198]   groups: 23:{ span=23 }, 0:{ span=0-1 cap=2048 }, 2:{ span=2-3 cap=2048 }, 4:{ span=4-5 cap=2048 }, 6:{ span=6-7 cap=2048 }, 8:{ span=8-9 cap=2048 }, 10:{ span=10-11 cap=2048 }, 12:{ span=12-13 cap=2048 }, 14:{ span=14-15 cap=2048 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }

$ echo 0 > /sys/devices/system/cpu/cpu1/online
[  251.213848] CPU0 attaching sched-domain(s):
[  251.214376]  domain-0: span=0,2-23 level=MC
[  251.214580]   groups: 0:{ span=0 }, 2:{ span=2-3 cap=2048 }, 4:{ span=4-5 cap=2048 }, 6:{ span=6-7 cap=2048 }, 8:{ span=8-9 cap=2048 }, 10:{ span=10-11 cap=2048 }, 12:{ span=12-13 cap=2048 }, 14:{ span=14-15 cap=2048 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }, 23:{ span=23 }
...
[  251.239511] CPU23 attaching sched-domain(s):
[  251.239656]  domain-0: span=0,2-23 level=MC
[  251.239727]   groups: 23:{ span=23 }, 0:{ span=0 }, 2:{ span=2-3 cap=2048 }, 4:{ span=4-5 cap=2048 }, 6:{ span=6-7 cap=2048 }, 8:{ span=8-9 cap=2048 }, 10:{ span=10-11 cap=2048 }, 12:{ span=12-13 cap=2048 }, 14:{ span=14-15 cap=2048 }, 16:{ span=16 }, 17:{ span=17 }, 18:{ span=18 }, 19:{ span=19 }, 20:{ span=20 }, 21:{ span=21 }, 22:{ span=22 }

$ cat /debug/sched/domains/cpu0/domain0/groups_flags

$ cat /debug/sched/domains/cpu23/domain0/groups_flags


IOW, neither the big core with SMT with one sibling offline, nor the
little core with no SMT on at all have the relevant flags set on their
domain0 groups.



---
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 98bfc0f4ec94..e408b2889186 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -427,6 +427,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 #undef SDM
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
+	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
 }
 
 void update_sched_domain_debugfs(void)
