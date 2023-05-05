Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B96F8C5C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjEEW3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjEEW3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:29:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132F3A8C
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683325787; x=1714861787;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c0YS8vTZgsrzaHrzBqnFzwVcvyopEYeXoxZZAV6NuT8=;
  b=dR3uwRKNz7UoKhxQaNBetjHNxPlj7B9sXKjX3Cl2AfdH5kfiy3C81Cnj
   mnO7he3CfSQpyLu46zVf3v/0BUEWOkrOQTOJx5gulEqJs8YxRZbObgTA3
   /MiyruDjA+mB0P1uMzQ2pqTtFpzEUOKsVKTGIL7mSdhoOjKZd1VaWjgMT
   iH5yTSdUNynSTbzbs88l0fRYIRAtIXfo1hDA8lEOsxBgbMJxA0Aw6iqnc
   RkDdcpz1NDuv7Qsb1HaVJng5CFAk+tcszjJ4duF3jFfGwqYE7dhTHCHCm
   gEd8lsIm7PZHJZ2FyAnAb/RVi0IJu5Q/I9eNhKW+8BgK+UF6QZMU/esC0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="329663055"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="329663055"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="675276234"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="675276234"
Received: from rmarepal-mobl3.amr.corp.intel.com (HELO [10.255.231.148]) ([10.255.231.148])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 15:29:46 -0700
Message-ID: <e21f2ca92490d9efd8f8fad0679d05ef08a52147.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] sched/fair: Check whether active load balance is
 needed in busiest group
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
Date:   Fri, 05 May 2023 15:29:45 -0700
In-Reply-To: <20230505121631.GF4253@hirez.programming.kicks-ass.net>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
         <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
         <20230505121631.GF4253@hirez.programming.kicks-ass.net>
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

On Fri, 2023-05-05 at 14:16 +0200, Peter Zijlstra wrote:
>=20
> > +static inline bool asym_active_balance_busiest(struct lb_env *env, str=
uct sd_lb_stats *sds)
> > +{
> > +	/*
> > +	 * Don't balance to a group without spare capacity.
> > +	 *
> > +	 * Skip non asymmetric sched group balancing. That check
> > +	 * is handled by code path handling imbalanced load between
> > +	 * similar groups.
> > +	 */
> > +	if (env->idle =3D=3D CPU_NOT_IDLE ||
> > +	    sds->local_stat.group_type !=3D group_has_spare ||
> > +	    !asymmetric_groups(sds->local, sds->busiest))
> > +		return false;
> > +
> > +	/*
> > +	 * For SMT source group, pull when there are two or more
> > +	 * tasks over-utilizing a core.
> > +	 */
> > +	if (sds->busiest->flags & SD_SHARE_CPUCAPACITY &&
> > +	    sds->busiest_stat.sum_h_nr_running > 1)
> > +		return true;
> > +
> > +	return false;
> > +}
>=20
> This all seems to be mixing two 'asymmetric' things in the 'asym'
> namespace :/ One being the SD_ASYM_PACKING and then the above SMT/no-SMT
> core thing.

Yeah, I am kind of abusing the "asymmetric" word.  However, the above
code does try to set things up for the aysm_active_balance() code
later. Any suggestion on better names for "asymmetric_groups()" and
and "asym_active_balance_busiest()"?=C2=A0

Perhaps "hybrid_groups()" and "hybrid_active_balance_busiest()"?

>=20
> > +
> >  /**
> >   * calculate_imbalance - Calculate the amount of imbalance present wit=
hin the
> >   *			 groups of a given sched_domain during load balance.
> > @@ -10164,6 +10200,12 @@ static inline void calculate_imbalance(struct =
lb_env *env, struct sd_lb_stats *s
> >  			return;
> >  		}
> > =20
> > +		if (asym_active_balance_busiest(env, sds)) {
> > +			env->migration_type =3D migrate_task;
> > +			env->imbalance =3D 1;
> > +			return;
> > +		}
> > +
> >  		if (busiest->group_weight =3D=3D 1 || sds->prefer_sibling) {
> >  			unsigned int nr_diff =3D busiest->sum_nr_running;
> >  			/*
> > @@ -10371,6 +10413,9 @@ static struct sched_group *find_busiest_group(s=
truct lb_env *env)
> >  			 */
> >  			goto out_balanced;
> > =20
> > +		if (asym_active_balance_busiest(env, &sds))
> > +			goto force_balance;
> > +
> >  		if (busiest->group_weight > 1 &&
> >  		    local->idle_cpus <=3D (busiest->idle_cpus + 1))
> >  			/*
>=20
> All the cases here have a nice (CodingStyle busting) comment, perhaps
> add the missing {} when hou add the comment?

Sure, will add a comment here.

Tim

