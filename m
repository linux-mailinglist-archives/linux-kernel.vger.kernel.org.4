Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB75731628
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjFOLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245690AbjFOLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:08:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660932949
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yHhf+pwYcrB870Px3tQk7D1TN4Q5uiybtqpuy7UVtik=; b=vNvjQhEpFM9f7js2jgzkreDgMr
        lyCwv+K2r5MbGTaOcEteP9LLa42LQe6GdO9QJw1Xdpxk7VnILR/pwuFeBbE7sulIxe4T5JQHqznO3
        QxDoJmUCAGqSbuL7cDMe3JEmFccz14Lz69G6OidYcr2EAEtMhXL2RTwCtAmR6Y0lIs0ggrcOlVEnZ
        nPLNVOs0tpJxiAK/608+kDKkwPJmXMdrbgmLRMbHWcVyiy9kZkXiXP6HaQmMsmptmFvgf8UbmoE0Z
        K49TdFA0OT9UE5vVOZZ/hbOuPfAaNZNn7VWQmgv2m+YZSHEasovjheVaGmw5jNRZJjo6shSuH1IXP
        YhNxQA7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9kpC-007Yq4-6N; Thu, 15 Jun 2023 11:07:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 68A6E300188;
        Thu, 15 Jun 2023 13:07:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23F2A241717C0; Thu, 15 Jun 2023 13:07:30 +0200 (CEST)
Date:   Thu, 15 Jun 2023 13:07:30 +0200
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
Subject: Re: [Patch v2 3/6] sched/fair: Implement prefer sibling imbalance
 calculation between asymmetric groups
Message-ID: <20230615110730.GA1693932@hirez.programming.kicks-ass.net>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
 <ef2400ea29f0e00aed1e2d75c1a352e63349059e.1686263351.git.tim.c.chen@linux.intel.com>
 <20230612120528.GL4253@hirez.programming.kicks-ass.net>
 <321a474bfa562164a56f504144d6b33eb2f7acbd.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321a474bfa562164a56f504144d6b33eb2f7acbd.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 10:46:36AM -0700, Tim Chen wrote:
> On Mon, 2023-06-12 at 14:05 +0200, Peter Zijlstra wrote:

> > > +		/* Limit tasks moved from preferred group, don't leave cores idle */
> > > +		limit = busiest->sum_nr_running;
> > > +		lsub_positive(&limit, ncores_busiest);
> > > +		if (imbalance > limit)
> > > +			imbalance = limit;
> > 
> > How does this affect the server parts that have larger than single core
> > turbo domains?
> 
> Are you thinking about the case where the local group is completely empty
> so there's turbo headroom and we should move at least one task, even though
> CPU in busiest group has higher priority?

Something along those lines, I didn't think it through, just wondered
about the wisdom of piling everything in the highest priority 'domain',
which would depress the turbo range.

Rjw said that on modern client the frequency domains are per-core, but
that on server parts they are still wider -- or something long those
lines. So it might make sense to consider some of that.

> In other words, are you suggesting we should add
> 
> 		if (imbalance == 0 && busiest->sum_nr_running > 0 &&
> 			local->sum_nr_running == 0)
> 			imbalance = 1;

I didn't get that far; and I don't think we have the right topology
information on the servers to even begin considering the effects of the
turbo-range, so perhaps it all doesn't matter.

Just wanted to raise the point for consideration.

Because as-is, the policy of piling extra on the preferred group doesn't
immediately make sense. IIRC the whole ITMT preferred core is mostly
about an extra turbo bin, but if you pile on, the headroom evaporates --
you'll never turbo that high anymore and special casing it doesn't make
sense.

So perhaps I'm not saying more code, but less code is better here.

Dunno, is any of this measurable either way around?

> > > +
> > > +		goto out;
> > > +	}
> > > +
> > > +	/* Take advantage of resource in an empty sched group */
> > > +	if (imbalance == 0 && local->sum_nr_running == 0 &&
> > > +	    busiest->sum_nr_running > 1)
> > > +		imbalance = 1;
> > > +out:
> > > +	return imbalance << 1;
> > > +}
> > 
> > 
> > But basically you have:
> > 
> >         LcBn - BcLn
> >   imb = -----------
> >            LcBc
> > 
> > Which makes sense, except you then return:
> > 
> >   imb * 2
> > 
> > which then made me wonder about rounding.
> > 
> > Do we want to to add (LcBc -1) or (LcBc/2) to resp. ceil() or round()
> > the thing before division? Because currently it uses floor().
> > 
> > If you evaludate it like:
> > 
> > 
> >         2 * (LcBn - BcLn)
> >   imb = -----------------
> >               LcBc
> > 
> > The result is different from what you have now.
> 
> If I do the rounding after multiplying imb by two (call it imb_new),
> the difference with imb I am returning now (call it imb_old)
> will be at most 1.  Note that imb_old returned is always a multiple of 2.
> 
> I will be using imb in calculate_imbalance() and divide it
> by 2 there to get the number tasks to move from busiest group.
> So when there is a difference of 1 between imb_old and imb_new,
> the difference will be trimmed off after the division of 2.
> 
> We will get the same number of tasks to move with either
> imb_old or imb_new in calculate_imbalance() so the two
> computations will arrive at the same result eventually.
> 
> > 
> > What actual behaviour is desired in these low imbalance cases? and can
> > you write a comment as to why we do as we do etc..?
> 
> I do not keep imb as 
> 
>            2 * (LcBn - BcLn)
>    imb = -----------------
>                LcBc
> 
> as it is easier to leave out the factor of 2
> in the middle of sibling_imblalance() computation
> so I can directly interpret imb as the number
> of tasks to move, and add the factor of two
> when I actually need to return the imbalance.
> 
> Would you like me to add this reasoning in the comments?

So if we want a multiple of 2, leaving that multiplication off makes
sense, but I'm not sure I got the argument for or against the rounding.

floor() gets us 1 task to move when there is at least a whole task's
worth of imbalance, but less than 2.

round() would get us 1 task to move when there's at least half a task's
worth of imbalance but less than 1.5.

ceil() will migrate on any imbalance, however small -- which will result
in ping-pong I suppose, so let's disregard that.

The difference, with the multiplcation later, is 0 or 2.

Does the round() still result in ping-pong?
