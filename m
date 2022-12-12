Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43AC64A622
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiLLRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLRpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:45:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D731BE0A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670867146; x=1702403146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCkzJ4K2HE5S3gU9cvzJIXZ+LOdlig3Oj+NPYSxJXRI=;
  b=mN7SwK2XJOM19FQK2S3VfaApyJAO6rVZh47M4+lLToYXWtaNINfrTmrK
   37qVLvS10Y0yCg5MrEFh/T12MZoKDWjick5XTVHSyF52CxWDv6SokBt6z
   h9EFVzydDoJF3uKRGnUA8X47Mli+zcudcNDX+alHvqqu4PY/7mdwRiGn8
   0I8W70U/Ksf39A+oWrP4IZWqOD7lEpRQJ12+2hNZlSgndtvX5yZln5hT5
   EmMKmQ2Op7XI15xMc75whUmge4P+ltRsSOm3VBmemXCSEsWLxAxpIcZX7
   SNq9/YnMDbr7AmFcf1FuMR4HRC0dEKXBC39tLg/oKb2aHfWvgMHvAXWJC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404168928"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="404168928"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 09:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="711765026"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="711765026"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 12 Dec 2022 09:45:38 -0800
Date:   Mon, 12 Dec 2022 09:53:45 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Message-ID: <20221212175345.GA27353@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 06:22:41PM +0100, Dietmar Eggemann wrote:
> On 22/11/2022 21:35, Ricardo Neri wrote:
> > When balancing load between two physical cores, an idle destination CPU can
> > help another core only if all of its SMT siblings are also idle. Otherwise,
> > there is not increase in throughput. It does not matter whether the other
> > core is composed of SMT siblings.
> > 
> > Simply check if there are any tasks running on the local group and the
> > other core has exactly one busy CPU before proceeding. Let
> > find_busiest_group() handle the case of more than one busy CPU. This is
> > true for SMT2, SMT4, SMT8, etc.
> 
> [...]

Thank you very much for your feedback, Dietmar!

> 
> > Changes since v1:
> >  * Reworded commit message and inline comments for clarity.
> >  * Stated that this changeset does not impact STM4 or SMT8.
> > ---
> >  kernel/sched/fair.c | 29 +++++++++--------------------
> >  1 file changed, 9 insertions(+), 20 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e4a0b8bd941c..18c672ff39ef 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8900,12 +8900,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
> >  				    struct sched_group *sg)
> 
> I'm not sure why you change asym_smt_can_pull_tasks() together with
> removing SD_ASYM_PACKING from SMT level (patch 5/7)?

In x86 we have SD_ASYM_PACKING at the MC, CLS* and, before my patches, SMT
sched domains.

> 
> update_sg_lb_stats()
> 
>   ... && env->sd->flags & SD_ASYM_PACKING && .. && sched_asym()
>                                                    ^^^^^^^^^^^^
>     sched_asym()
> 
>       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
>           (group->flags & SD_SHARE_CPUCAPACITY))
>         return asym_smt_can_pull_tasks()
>                ^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> So x86 won't have a sched domain with SD_SHARE_CPUCAPACITY and
> SD_ASYM_PACKING anymore. So sched_asym() would call sched_asym_prefer()
> directly on MC. What do I miss here?

asym_smt_can_pull_tasks() is used above the SMT level *and* when either the
local or sg sched groups are composed of CPUs that are SMT siblings.

In fact, asym_smt_can_pull_tasks() can only be called above the SMT level.
This is because the flags of a sched_group in a sched_domain are equal to
the flags of the child sched_domain. Since SMT is the lowest sched_domain,
its groups' flags are 0.

sched_asym() calls sched_asym_prefer() directly if balancing at the
SMT level and, at higher domains, if the child domain is not SMT.

This meets the requirement of Power7, where SMT siblings have different
priorities; and of x86, where physical cores have different priorities.

Thanks and BR,
Ricardo

* The target of these patches is Intel hybrid processors, on which cluster
  scheduling is disabled - cabdc3a8475b ("sched,x86: Don't use cluster
  topology for x86 hybrid CPUs"). Also, I have not observed topologies in
  which CPUs of the same cluster have different priorities.

  We are also looking into re-enabling cluster scheduling on hybrid
  topologies.
