Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD8A5F62E1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJFIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiJFIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:38:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2A95AD5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FWnh2nRUzUZJtkd+A+vEExHBGPHX7Dn2QYhmXJ60jW8=; b=PHUILb2jzd4OgU4iB2UTeoJEG1
        7TbV874gV3PDTHVOx3Loff2ZOvwxN+qU/zLvHXoDySBGhZmIDhYtV4/ItH8y6YkD4dWQHrXyAvCE8
        dwCJBU7uraB5qGi7sgTnf0E4a7WTue/jmRpv4ubJQ9Y2GGNcEVMv1jCtA/ZAHfyyBZMsqES7iXtyD
        EHKf+iFM1vpizuZPZiYWehPyV+qy+UhUNYJelg81cmRKIVpNcrnNYLqP4QZQumcynds3vW0SNItOF
        4ZkKlO0azDiyL0KPAVXgiOZaY1bCrAAF//dHnTuVazBaKmomBECVGEfP+nGtkVQkQ9WSxkGfds1EB
        9h/Lm1Ww==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ogMOC-0010Tj-Mm; Thu, 06 Oct 2022 08:37:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8C7E33001D6;
        Thu,  6 Oct 2022 10:37:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 73AAB201FC2CE; Thu,  6 Oct 2022 10:37:52 +0200 (CEST)
Date:   Thu, 6 Oct 2022 10:37:52 +0200
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 09/23] sched/fair: Use task-class performance score
 to pick the busiest group
Message-ID: <Yz6T4OslXxKdAlM/@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-10-ricardo.neri-calderon@linux.intel.com>
 <YzLYDPU+upHeUG65@hirez.programming.kicks-ass.net>
 <20221005233841.GA29251@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005233841.GA29251@ranerica-svr.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 04:38:41PM -0700, Ricardo Neri wrote:
> On Tue, Sep 27, 2022 at 01:01:32PM +0200, Peter Zijlstra wrote:
> > On Fri, Sep 09, 2022 at 04:11:51PM -0700, Ricardo Neri wrote:

> > > @@ -9049,6 +9111,12 @@ static bool update_sd_pick_busiest(struct lb_env *env,
> > >  		/* Prefer to move from lowest priority CPU's work */
> > >  		if (sched_asym_prefer(sg->asym_prefer_cpu, sds->busiest->asym_prefer_cpu))
> > >  			return false;
> > > +
> > > +		/* @sg and @sds::busiest have the same priority. */
> > > +		if (sched_asym_class_pick(sds->busiest, sg, &sds->busiest_stat, sgs))
> > > +			return false;
> > > +
> > > +		/* @sg has lower priority than @sds::busiest. */
> > >  		break;
> > >  
> > >  	case group_misfit_task:
> > 
> > So why does only this one instance of asym_prefer() require tie
> > breaking?
> 
> This is the only place in which two sched groups with running tasks and of
> equal priority are compared.
> 
> In all other places sched_asym_prefer() is used to compare the destination
> CPU with others. Since asym_packing is done only when the destination CPU is
> idle, there is no need to break this tie.

That would make for a fine comment, no? Because as presented one is left
wondering, why if asym_prefer() needs tie breaking, only this one site
needs it.

> > And while looking through this, I must ask about the comment that goes
> > with sched_set_itmt_core_prio() vs the sg->asym_prefer_cpu assignment in
> > init_sched_groups_capacity(), what-up ?!
> 
> Are you referring to this comment?
> 
> 	"No need to rebuild sched domain after updating
> 	 the CPU priorities. The sched domains have no
> 	 dependency on CPU priorities"
> 
> If yes, then it looks wrong to me. Sched domains are rebuilt after updating
> priorities.

Right.
