Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A1A6F8CA2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjEEXHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjEEXHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:07:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6E3598
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328060; x=1714864060;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CxdlYALuIwm8JyKBywdAOVuE4rIPcmX0leYCKwfv6c4=;
  b=hYz+Y34V1zArMM3CRqtpewAhwQIS5KvgDhrGI2YD+BATXCyl7GoCh45t
   sOwh+EbEzT1sYkIeVF6I0SxAWbntKXnuATk8nbAAcSv2BEUKALELtu9R/
   mGHKwFOYOQyL97jquK6U5GE7loSp56iSeur6dRFGiKWB4+cWikX847cL3
   EzsltW3BNWFge2AHqWGdy7dym7seZXzUH9A+70Fl+CDdV8GKsq2+gjAKY
   GNIVHgqv+sizVFOU9ZFhZOgb0pfzG7vyhUWl4K1jsMRxeBEea7eeATpfv
   TIM2kJq8b1OkB9OjIMntfq/4EhKg7OcuJ4Q1cxX1P+n/HYzYWVEC13hVR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="352366436"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="352366436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="821899152"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="821899152"
Received: from rmarepal-mobl3.amr.corp.intel.com (HELO [10.255.231.148]) ([10.255.231.148])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:07:39 -0700
Message-ID: <7c5ad793fe0195f7129156b67a043df18b46d732.camel@linux.intel.com>
Subject: Re: [PATCH 4/6] sched/fair: Skip prefer sibling move between SMT
 group and non-SMT group
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Date:   Fri, 05 May 2023 16:07:39 -0700
In-Reply-To: <20230505132211.GQ83892@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <b20517e3986bfdde8a605afa19d144ec411c7a42.1683156492.git.tim.c.chen@linux.intel.com>
         <20230505132211.GQ83892@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-05-05 at 15:22 +0200, Peter Zijlstra wrote:
> On Thu, May 04, 2023 at 09:09:54AM -0700, Tim Chen wrote:
> > From: Tim C Chen <tim.c.chen@linux.intel.com>
> >=20
> > Do not try to move tasks between non SMT sched group and SMT sched
> > group for "prefer sibling" load balance.
> > Let asym_active_balance_busiest() handle that case properly.
> > Otherwise we could get task bouncing back and forth between
> > the SMT sched group and non SMT sched group.
> >=20
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/fair.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 8a325db34b02..58ef7d529731 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -10411,8 +10411,12 @@ static struct sched_group *find_busiest_group(=
struct lb_env *env)
> >  	/*
> >  	 * Try to move all excess tasks to a sibling domain of the busiest
> >  	 * group's child domain.
> > +	 *
> > +	 * Do not try to move between non smt sched group and smt sched
> > +	 * group. Let asym active balance properly handle that case.
> >  	 */
> >  	if (sds.prefer_sibling && local->group_type =3D=3D group_has_spare &&
> > +	    !asymmetric_groups(sds.busiest, sds.local) &&
> >  	    busiest->sum_nr_running > local->sum_nr_running + 1)
> >  		goto force_balance;
>=20
> This seems to have the hidden assumption that a !SMT core is somehow
> 'less' that an SMT code. Should this not also look at
> sched_asym_prefer() to establush this is so?
>=20
> I mean, imagine I have a regular system and just offline one smt sibling
> for giggles.

I don't quite follow your point as asymmetric_groups() returns false even
one smt sibling is offlined.

Even say sds.busiest has 1 SMT and sds.local has 2 SMT, both sched groups s=
till
have SD_SHARE_CPUCAPACITY flag turned on.  So asymmetric_groups() return
false and the load balancing logic is not changed for regular non-hybrid sy=
stem.

I may be missing something.

Tim
