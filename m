Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7424A74ECED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGKLcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGKLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:32:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9547127
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XqgoWL9LCniJF/VVbTLcSycpWfuGM7KgkkgzB8rRFNM=; b=c2aX5ppcvu2VslvkDX3y/gtJph
        mJcJfublX0YhUR1AsTGezG06pQ5iRow76GdWd5hX6jPxDxbTiLBvS610y3wGHxvsmiG+EO2pBv/3w
        BShKT0yw84G12YaJlD1Wseh0pzYQUPLvOMPXy5AkhLW2JYogXMahzwe/wS2lIFcyk83SJjklryquJ
        w2abnEicSATbUBfUOYpdeF36Hl8sYCc3KetHI3T0lT8Np1VcG7IkxwvNwrNYG9xWpRsvytsB0R5Zq
        XII5MnT82Y0Q0R/ew66/VBpIfVwEC7PQdHxKCSlZOb8NwxdVG0hmmMIn9/2olZvv+KnE1j3LY+Ren
        qRHOglRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qJBb7-002NoV-1W;
        Tue, 11 Jul 2023 11:32:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0AF4430036B;
        Tue, 11 Jul 2023 13:31:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0EFC240EBDB4; Tue, 11 Jul 2023 13:31:58 +0200 (CEST)
Date:   Tue, 11 Jul 2023 13:31:58 +0200
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 2/6] sched/topology: Record number of cores in sched
 group
Message-ID: <20230711113158.GJ3062772@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
 <4797e9147143decf561ede6b7658721d05dda4dc.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4797e9147143decf561ede6b7658721d05dda4dc.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 03:40:34PM -0700, Tim Chen wrote:
> On Fri, 2023-07-07 at 15:57 -0700, Tim Chen wrote:
> > From: Tim C Chen <tim.c.chen@linux.intel.com>
> > 
> > When balancing sibling domains that have different number of cores,
> > tasks in respective sibling domain should be proportional to the number
> > of cores in each domain. In preparation of implementing such a policy,
> > record the number of tasks in a scheduling group.
> 
> Caught a typo.  Should be "the number of cores" instead of
> "the number of tasks" in a scheduling group.
> 
> Peter, should I send you another patch with the corrected commit log?

I'll fix it up, already had to fix the patch because due to robot
finding a compile fail for SCHED_SMT=n builds.



> > @@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int cpu)
> >  static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
> >  {
> >  	struct sched_group *sg = sd->groups;
> > +	struct cpumask *mask = sched_domains_tmpmask2;
> >  
> >  	WARN_ON(!sg);
> >  
> >  	do {
> > -		int cpu, max_cpu = -1;
> > +		int cpu, cores = 0, max_cpu = -1;
> >  
> >  		sg->group_weight = cpumask_weight(sched_group_span(sg));
> >  
> > +		cpumask_copy(mask, sched_group_span(sg));
> > +		for_each_cpu(cpu, mask) {
> > +			cores++;
#ifdef CONFIG_SCHED_SMT
> > +			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
#else
			__cpumask_clear_cpu(cpu, mask);
#endif

or something along them lines -- should be in queue.git/sched/core
already.

> > +		}
> > +		sg->cores = cores;
> > +
> >  		if (!(sd->flags & SD_ASYM_PACKING))
> >  			goto next;
> >  
> 
