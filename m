Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC2464CE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239144AbiLNQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNQvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:51:09 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74646E0C4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671036664; x=1702572664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZSrYxyJvHyYBAqXImstH98UkvPe6TpC/eppsxaUN28c=;
  b=mj+le5ZMRwcs5BT9UiPBp8jyt3Tfj4NWsixVIefyJuOQty5y1JFyQHqw
   jryks4kMYJdqdPscXNsJbiYofIHeAt2g/z0Hpeu2W2pHtJwn184YSikhN
   6cR+jq/Sbw9ZqOHV4WZPnHL/amGEWHzCEo0d4X8aE7T4ae3CUUOwvV87S
   9f6aHUB6He0Zj25TESRu7K2kwJlmiOu7Jx6LgEzj0Qr5lB8KrGlOYL2at
   6qqeJRy3fgcueeEE0WA1sbokY/1ny2fwfMJyG9vht858lzu1qNUcMJ5Rq
   CsDtdxMhzqZbg8Bt7avtfavZnGuPMddyTHIarfLrWFYGyk8jFfID+2y+L
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="318496058"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="318496058"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 08:50:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="977897378"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="977897378"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2022 08:50:48 -0800
Date:   Wed, 14 Dec 2022 08:59:00 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [PATCH v2 5/7] x86/sched: Remove SD_ASYM_PACKING from the "SMT"
 domain
Message-ID: <20221214165900.GA972@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-6-ricardo.neri-calderon@linux.intel.com>
 <Y5IKuJTjE6Pjrw9I@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5IKuJTjE6Pjrw9I@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 04:03:04PM +0000, Ionela Voinescu wrote:
> Hi Ricardo,

Hi Ionela,

Thank you very much for your feedback!

> 
> On Tuesday 22 Nov 2022 at 12:35:30 (-0800), Ricardo Neri wrote:
> > There is no difference between any of the SMT siblings of a physical core.
> > asym_packing load balancing is not needed among siblings.
> > 
> > When balancing load among physical cores, the scheduler now considers the
> > state of the siblings when checking the priority of a CPU.
> > 
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v1:
> >  * Introduced this patch.
> > ---
> >  arch/x86/kernel/smpboot.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> > index 3f3ea0287f69..c3de98224cb4 100644
> > --- a/arch/x86/kernel/smpboot.c
> > +++ b/arch/x86/kernel/smpboot.c
> > @@ -545,7 +545,7 @@ static int x86_core_flags(void)
> >  #ifdef CONFIG_SCHED_SMT
> >  static int x86_smt_flags(void)
> >  {
> > -	return cpu_smt_flags() | x86_sched_itmt_flags();
> > +	return cpu_smt_flags();
> 
> Based on:
> 
> kernel/sched/topology.c:
> sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
> rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
> 
> and described at:
> 
> include/linux/sched/sd_flags.h:
> /*
>  * Place busy tasks earlier in the domain
>  *
>  * SHARED_CHILD: Usually set on the SMT level. Technically could be set further
>  *               up, but currently assumed to be set from the base domain
>  *               upwards (see update_top_cache_domain()).
>  * NEEDS_GROUPS: Load balancing flag.
>  */
> SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 
> doesn't your change result in sd_asym_packing being NULL?

Yes. This is a good catch. Thanks!

> 
> The SD_ASYM_PACKING flag requires all children of a domain to have it set
> as well. So having SMT not setting the flag, while CLUSTER and MC having
> set the flag would result in a broken topology, right?

I'd say that highest_flag_domain(..., flag) requires all children to have
`flag`, but clearly the comment you quote allows for SD_ASYM_PACKING to
be located in upper domains.

Perhaps this can be fixed with a variant of highest_flag_domain() that do
not require all children to have the flag?

Thanks and BR,
Ricardo
