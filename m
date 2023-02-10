Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4578691702
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjBJDGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjBJDGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:06:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCE95B83
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 19:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675998407; x=1707534407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CJkMTgzIddNgRRg5mVzE1/GqVRRbH37QlNxA7GWPhDM=;
  b=Qt+TlrpPsUR1o5Bp6CDv9153TcOsui1iAy4fPTzeSXTRsYCa92pmwvtR
   RMB4jaoKI0bKz6Yq/xEoFzXuztisrnwGOETnZO1GlxJ3h41HZ0TAgAdb6
   RFHDwnCor9+v9/DifcQ37tP0ON/uRLy6ev7FNVzSaAAIKK5q2LCUyscZz
   yYOfhiTRNsczxWAElS66/Z7qBNRmJnB5SOESj3iJRl/enXl1Xw+QYx3p1
   AcgER8e7n8kBryctadoNTG2gDcGkeZZibme/+VZ+9uWjQBgs8J8QQee1L
   4RuJ55sZkmQVyqlUfghosmpGTkDq1ymABxqTRlatLKoKykKiM6lfv0Nw4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="310687392"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="310687392"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 19:06:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="736587573"
X-IronPort-AV: E=Sophos;i="5.97,285,1669104000"; 
   d="scan'208";a="736587573"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP; 09 Feb 2023 19:06:45 -0800
Date:   Thu, 9 Feb 2023 19:16:29 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     "Chen, Tim C" <tim.c.chen@intel.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Brown, Len" <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Message-ID: <20230210031629.GC6166@ranerica-svr.sc.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+TyUZg86LYhtWeJ@chenyu5-mobl1>
 <DM6PR11MB4107F95164772B40B92F66A6DCD99@DM6PR11MB4107.namprd11.prod.outlook.com>
 <fb63369b2fc686730adefb6800eae4877e62e3b6.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb63369b2fc686730adefb6800eae4877e62e3b6.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 03:05:03PM -0800, Tim Chen wrote:
> On Thu, 2023-02-09 at 20:00 +0000, Chen, Tim C wrote:
> > > >  static inline void update_sd_lb_stats(struct lb_env *env, struct
> > > > sd_lb_stats *sds)  {
> > > > -       struct sched_domain *child = env->sd->child;
> > > >         struct sched_group *sg = env->sd->groups;
> > > >         struct sg_lb_stats *local = &sds->local_stat;
> > > >         struct sg_lb_stats tmp_sgs;
> > > > @@ -10045,9 +10044,11 @@ static inline void
> > > > update_sd_lb_stats(struct
> > > lb_env *env, struct sd_lb_stats *sd
> > > >                 sg = sg->next;
> > > >         } while (sg != env->sd->groups);
> > > > 
> > > > -       /* Tag domain that child domain prefers tasks go to
> > > > siblings first */
> > > > -       sds->prefer_sibling = child && child->flags &
> > > > SD_PREFER_SIBLING;
> > > > -
> > > > +       /*
> > > > +        * Tag domain that @env::sd prefers to spread excess
> > > > tasks among
> > > > +        * sibling sched groups.
> > > > +        */
> > > > +       sds->prefer_sibling = env->sd->flags & SD_PREFER_SIBLING;
> > > > 
> > > This does help fix the issue that non-SMT core fails to pull task
> > > from busy SMT-
> > > cores.
> > > And it also semantically changes the definination of prefer
> > > sibling. Do we also
> > > need to change this:
> > >        if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
> > >                sd->child->flags &= ~SD_PREFER_SIBLING; might be:
> > >        if ((sd->flags & SD_ASYM_CPUCAPACITY))
> > >                sd->flags &= ~SD_PREFER_SIBLING;
> > > 
> > 
> > Yu,
> > 
> > I think you are talking about the code in sd_init() 
> > where SD_PREFER_SIBLING is first set
> > to "ON" and updated depending on SD_ASYM_CPUCAPACITY.  The intention
> > of the code
> > is if there are cpus in the scheduler domain that have differing cpu
> > capacities,
> > we do not want to do spreading among the child groups in the sched
> > domain.
> > So the flag is turned off in the child group level and not the parent
> > level. But with your above
> > change, the parent's flag is turned off, leaving the child level flag
> > on. 
> > This moves the level where spreading happens (SD_PREFER_SIBLING on) 
> > up one level which is undesired (see table below).

But my patch moves the level at which we act on prefer_sibling: it now
checks the SD_PREFER_SIBLING flag at the current level, not its child.
Thus, removing SD_PREFER_SIBLING from a level with SD_ASYM_CPUCAPACITY
prevents spreading among CPUs of different CPU capacity, no?

Thanks and BR,
Ricardo
