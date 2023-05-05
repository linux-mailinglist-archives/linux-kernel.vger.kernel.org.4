Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BECF6F8CE1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjEEXpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjEEXpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:45:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20995FD9
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3ivfYN9NFn5Ur3KwxVm0BlzaXOloF+5cCvdC28BiwI4=; b=W1rNGpt1ik2K6PIZZMqij1tv9L
        mCvK5ahfCpGV6XL7aKQln5qDUx7Qdmol/yrkd5fEs9mq5QOBXOshL7j7F3p2MVXssTxWOw9iIJYI3
        LcRqqCqcCpiAnfi88cqhUl9oZqJKD9lMgmdKaSmhDd4C7fXNF4YoYhs0/cm90hpd9kkk7CL7RNtGE
        G58h8vpqR5iH5DpkOwh6P5N57JboVnp2nK0hyl7pBehjinCo80XmwMPxKChlR06Id9zN0oCaU3CdV
        EfuHk4Qozju77oivwjy5W1JDNGXi+d1smK6tHyk5/Bs6IH50SKzxjRj4RNBj1SBKs2LlhVJTlnrQU
        I/fb3tXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pv56g-00BzAc-C2; Fri, 05 May 2023 23:44:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D7A430022D;
        Sat,  6 May 2023 01:44:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0E3E23C5C32C; Sat,  6 May 2023 01:44:56 +0200 (CEST)
Date:   Sat, 6 May 2023 01:44:56 +0200
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
Subject: Re: [PATCH 2/6] sched/fair: Check whether active load balance is
 needed in busiest group
Message-ID: <20230505234456.GC1821641@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
 <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
 <20230505121631.GF4253@hirez.programming.kicks-ass.net>
 <e21f2ca92490d9efd8f8fad0679d05ef08a52147.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e21f2ca92490d9efd8f8fad0679d05ef08a52147.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 03:29:45PM -0700, Tim Chen wrote:
> On Fri, 2023-05-05 at 14:16 +0200, Peter Zijlstra wrote:
> > 
> > > +static inline bool asym_active_balance_busiest(struct lb_env *env, struct sd_lb_stats *sds)
> > > +{
> > > +	/*
> > > +	 * Don't balance to a group without spare capacity.
> > > +	 *
> > > +	 * Skip non asymmetric sched group balancing. That check
> > > +	 * is handled by code path handling imbalanced load between
> > > +	 * similar groups.
> > > +	 */
> > > +	if (env->idle == CPU_NOT_IDLE ||
> > > +	    sds->local_stat.group_type != group_has_spare ||
> > > +	    !asymmetric_groups(sds->local, sds->busiest))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * For SMT source group, pull when there are two or more
> > > +	 * tasks over-utilizing a core.
> > > +	 */
> > > +	if (sds->busiest->flags & SD_SHARE_CPUCAPACITY &&
> > > +	    sds->busiest_stat.sum_h_nr_running > 1)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > 
> > This all seems to be mixing two 'asymmetric' things in the 'asym'
> > namespace :/ One being the SD_ASYM_PACKING and then the above SMT/no-SMT
> > core thing.
> 
> Yeah, I am kind of abusing the "asymmetric" word.  However, the above
> code does try to set things up for the aysm_active_balance() code
> later. Any suggestion on better names for "asymmetric_groups()" and
> and "asym_active_balance_busiest()"? 
> 
> Perhaps "hybrid_groups()" and "hybrid_active_balance_busiest()"?

As per the other subthread; I really don't think this whole SMT vs
non-SMT should be in any way shape or form be related to hybrid.
Offlining siblings should really get you the same topology.

(and if that currently is not the case, that should be fixed)

(and also; we should probably add group_flags to
 /debug/sched/domains/cpuN/domainM/ so we can actually see what's what,
 because this seems to be a bit of a blind spot).

That also suggests the hybrid naming suggestion is not a very good one.

And I'll blame it being nearly 2am for not being able to come up with a
good suggestion, but I'm thinking it ought to have SMT in the name
somehow.
