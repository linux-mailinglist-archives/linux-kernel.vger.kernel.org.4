Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007E6C3599
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjCUPZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjCUPZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:25:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A464FCC0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679412341; x=1710948341;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wUl8q50fX83Pxt0FLNlLN7yvA7n1d6/42RULa+53jro=;
  b=VZ/IsVjkmCSrZmFSiBgEBeRYEpDPoLlSMO0Dn2ua38j2ziMIQzkzV8uH
   ojSdjXuiC3WI4HQD66xKtjFPofahwYICQ6vigbOdbKK1b70T5+SJPRCW2
   P36LCEA00H9NclygYO0GJSh156eYsNPAXUWeHvihdfjmGoVh6vt1Dem/u
   Q5eVlQhuGByat6XXhjiQrUuJJLjCSt9klLtXafEnbzTZ5WdLYatlSCD13
   2XyJgGFSHwKtTlf0U0lKTHwrSUXSRHkX53lZBmw14xaeU/zlBrywMrt1l
   9vz1iz1OE7FzWYas8dk7NYGcQnFvbthAsHGbhbE+YkX3Z6wy9wSd0P9hK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322813316"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="322813316"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="683905778"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="683905778"
Received: from jluqueti-mobl.ger.corp.intel.com ([10.252.63.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 08:25:36 -0700
Date:   Tue, 21 Mar 2023 17:25:33 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Morse <james.morse@arm.com>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: Re: [PATCH v3 17/19] x86/resctrl: Allow overflow/limbo handlers to
 be scheduled on any-but cpu
In-Reply-To: <118d53a6-e292-50a0-dc8f-32c573379ed7@linux.intel.com>
Message-ID: <54165c70-795b-6e6e-aad-4089ddd6dbe5@linux.intel.com>
References: <20230320172620.18254-1-james.morse@arm.com> <20230320172620.18254-18-james.morse@arm.com> <118d53a6-e292-50a0-dc8f-32c573379ed7@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1557823100-1679412340=:1997"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1557823100-1679412340=:1997
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 21 Mar 2023, Ilpo Järvinen wrote:

> On Mon, 20 Mar 2023, James Morse wrote:
> 
> > When a CPU is taken offline resctrl may need to move the overflow or
> > limbo handlers to run on a different CPU.
> > 
> > Once the offline callbacks have been split, cqm_setup_limbo_handler()
> > will be called while the CPU that is going offline is still present
> > in the cpu_mask.
> > 
> > Pass the CPU to exclude to cqm_setup_limbo_handler() and
> > mbm_setup_overflow_handler(). These functions can use a variant of
> > cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
> > need excluding.
> > 
> > Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> > Changes since v2:
> >  * Rephrased a comment to avoid a two letter bad-word. (we)
> >  * Avoid assigning mbm_work_cpu if the domain is going to be free()d
> >  * Added cpumask_any_housekeeping_but(), I dislike the name
> > ---
> >  arch/x86/kernel/cpu/resctrl/core.c     |  8 +++--
> >  arch/x86/kernel/cpu/resctrl/internal.h | 37 ++++++++++++++++++++--
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 43 +++++++++++++++++++++-----
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  6 ++--
> >  include/linux/resctrl.h                |  3 ++
> >  5 files changed, 83 insertions(+), 14 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 8e25ea49372e..aafe4b74587c 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -582,12 +582,16 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> >  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
> >  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> >  			cancel_delayed_work(&d->mbm_over);
> > -			mbm_setup_overflow_handler(d, 0);
> > +			/*
> > +			 * exclude_cpu=-1 as this CPU has already been removed
> > +			 * by cpumask_clear_cpu()d
> > +			 */
> > +			mbm_setup_overflow_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> >  		}
> >  		if (is_llc_occupancy_enabled() && cpu == d->cqm_work_cpu &&
> >  		    has_busy_rmid(r, d)) {
> >  			cancel_delayed_work(&d->cqm_limbo);
> > -			cqm_setup_limbo_handler(d, 0);
> > +			cqm_setup_limbo_handler(d, 0, RESCTRL_PICK_ANY_CPU);
> >  		}
> >  	}
> >  }
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index 3eb5b307b809..47838ba6876e 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -78,6 +78,37 @@ static inline unsigned int cpumask_any_housekeeping(const struct cpumask *mask)
> >  	return cpu;
> >  }
> >  
> > +/**
> > + * cpumask_any_housekeeping_but() - Chose any cpu in @mask, preferring those
> > + *			            that aren't marked nohz_full, excluding
> > + *				    the provided CPU
> > + * @mask:	The mask to pick a CPU from.
> > + * @exclude_cpu:The CPU to avoid picking.
> > + *
> > + * Returns a CPU from @mask, but not @but. If there are houskeeping CPUs that
> > + * don't use nohz_full, these are preferred.
> > + * Returns >= nr_cpu_ids if no CPUs are available.
> > + */
> > +static inline unsigned int
> > +cpumask_any_housekeeping_but(const struct cpumask *mask, int exclude_cpu)
> > +{
> > +	int cpu, hk_cpu;
> > +
> > +	cpu = cpumask_any_but(mask, exclude_cpu);
> > +	if (tick_nohz_full_cpu(cpu)) {
> > +		hk_cpu = cpumask_nth_andnot(0, mask, tick_nohz_full_mask);
> > +		if  (hk_cpu == exclude_cpu) {
> > +			hk_cpu = cpumask_nth_andnot(1, mask,
> > +						    tick_nohz_full_mask);
> 
> I'm left to wonder if it's okay to alter tick_nohz_full_mask in resctrl 
> code??

I suppose it should do instead:
		hk_cpu = cpumask_nth_and(0, mask, tick_nohz_full_mask);
		if (hk_cpu == exclude_cpu)
			hk_cpu = cpumask_next_and(hk_cpu, mask, tick_nohz_full_mask);

-- 
 i.

--8323329-1557823100-1679412340=:1997--
