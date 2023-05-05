Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180DF6F8CD4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjEEXjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjEEXjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:39:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22C4EE1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OtxxnW9p2nerlXGh0d+JG1ehfydOLVNIdu+32Zh+/84=; b=foM67Q/bK3dp3031L+6kA925fD
        JQu1meEpFCKkAK5Nrx1P9gtmfQd8V0PzXF8oFO1f5qlOACKjsmCsXx3irqDi5l/UXO+UH5cyEO8dL
        cj7rBGh9r96KFIwyTuyijJOgB+UwfwsySuxPXYGtb/cUyt/SQqFylKWFOBKqDlYcEpNfNMDagbs+W
        d4TuXKqKs+KMvUpIUXb7g4+RldkZ5tXiezKOt1a55eKDYsImXuYFSG+hLX9CiH7aIHThy2TixEzEk
        Dz6Ae2O4k3sMp7+7F5jNWJXWAXH+ajhtAwdoasdzW17BCGKNxvjfBJiqmn6UOVNDmSr1+5U9X3Zzd
        IsQJFwRQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pv50Z-003P3L-34;
        Fri, 05 May 2023 23:38:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC0C93060E5;
        Sat,  6 May 2023 01:38:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3CB423C5C32C; Sat,  6 May 2023 01:38:36 +0200 (CEST)
Date:   Sat, 6 May 2023 01:38:36 +0200
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
Message-ID: <20230505233836.GB1821641@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
 <20230505132211.GQ83892@hirez.programming.kicks-ass.net>
 <7c5ad793fe0195f7129156b67a043df18b46d732.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c5ad793fe0195f7129156b67a043df18b46d732.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 04:07:39PM -0700, Tim Chen wrote:
> On Fri, 2023-05-05 at 15:22 +0200, Peter Zijlstra wrote:
> > On Thu, May 04, 2023 at 09:09:54AM -0700, Tim Chen wrote:
> > > From: Tim C Chen <tim.c.chen@linux.intel.com>
> > > 
> > > Do not try to move tasks between non SMT sched group and SMT sched
> > > group for "prefer sibling" load balance.
> > > Let asym_active_balance_busiest() handle that case properly.
> > > Otherwise we could get task bouncing back and forth between
> > > the SMT sched group and non SMT sched group.
> > > 
> > > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > > ---
> > >  kernel/sched/fair.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 8a325db34b02..58ef7d529731 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
> > >  	/*
> > >  	 * Try to move all excess tasks to a sibling domain of the busiest
> > >  	 * group's child domain.
> > > +	 *
> > > +	 * Do not try to move between non smt sched group and smt sched
> > > +	 * group. Let asym active balance properly handle that case.
> > >  	 */
> > >  	if (sds.prefer_sibling && local->group_type == group_has_spare &&
> > > +	    !asymmetric_groups(sds.busiest, sds.local) &&
> > >  	    busiest->sum_nr_running > local->sum_nr_running + 1)
> > >  		goto force_balance;
> > 
> > This seems to have the hidden assumption that a !SMT core is somehow
> > 'less' that an SMT code. Should this not also look at
> > sched_asym_prefer() to establush this is so?
> > 
> > I mean, imagine I have a regular system and just offline one smt sibling
> > for giggles.
> 
> I don't quite follow your point as asymmetric_groups() returns false even
> one smt sibling is offlined.
> 
> Even say sds.busiest has 1 SMT and sds.local has 2 SMT, both sched groups still
> have SD_SHARE_CPUCAPACITY flag turned on.  So asymmetric_groups() return
> false and the load balancing logic is not changed for regular non-hybrid system.
> 
> I may be missing something.

What's the difference between the two cases? That is, if the remaining
sibling will have SD_SHARE_CPUCAPACIY from the degenerate SMT domain
that's been reaped, then why doesn't the same thing apply to the atoms
in the hybrid muck?

Those two cases *should* be identical, both cases you have cores with
and cores without SMT.
