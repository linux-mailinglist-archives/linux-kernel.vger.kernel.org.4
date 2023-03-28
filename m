Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEB96CCE05
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC1Xan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjC1Xal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:30:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3D2D54;
        Tue, 28 Mar 2023 16:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680046239; x=1711582239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GzURdOK2jND3Ih2Qz5XB4zGxZl3gEf3JAwlYfOrVtG8=;
  b=QbacBj14TUP8+inCRLpyhEWRn/upJq5U7pOehC2cV4iWKfQzt3KpaPLU
   aRYad74DmcV6ljyoJUUQwovvVXrtoXEECFmbxITYV64aWaQuZWxatAjY0
   D3hDj1JcWJ9ask4Z6qKgE6EKElssJ1JqtSPe63bzRGBifgpw1qMo00Y1I
   hElQozJPWyQYO8vaQH2PECqSTv5iKpK/4KlHRFgS0EGug311ouBycyH4c
   PQPIwSJA3+WurF3AWKlaoz0nqL5NVgbYWMN+s1kICtsotxOGhF4DyFuBB
   dM1lLxzgRZctQB0Nfpn74m+ojvAlR+weKT87zsBxsevHlr4/56NDAy9Gm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324622465"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="324622465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="1013778980"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="1013778980"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 28 Mar 2023 16:30:37 -0700
Date:   Tue, 28 Mar 2023 16:41:19 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 15/24] thermal: intel: hfi: Report the IPC class score
 of a CPU
Message-ID: <20230328234119.GA8958@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-16-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0iidC0LxqpE60J5HHQhvv8iHjMGdxM89-7p-QQE99qVEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iidC0LxqpE60J5HHQhvv8iHjMGdxM89-7p-QQE99qVEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:50:13PM +0200, Rafael J. Wysocki wrote:
> On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > Implement the arch_get_ipcc_score() interface of the scheduler. Use the
> > performance capabilities of the extended Hardware Feedback Interface table
> > as the IPC score.
> >
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  * None
> >
> > Changes since v1:
> >  * Adjusted the returned HFI class (which starts at 0) to match the
> >    scheduler IPCC class (which starts at 1). (PeterZ)
> >  * Used the new interface names.
> > ---
> >  arch/x86/include/asm/topology.h   |  2 ++
> >  drivers/thermal/intel/intel_hfi.c | 27 +++++++++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > index ffcdac3f398f..c4fcd9c3c634 100644
> > --- a/arch/x86/include/asm/topology.h
> > +++ b/arch/x86/include/asm/topology.h
> > @@ -229,8 +229,10 @@ void init_freq_invariance_cppc(void);
> >
> >  #if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
> >  void intel_hfi_update_ipcc(struct task_struct *curr);
> > +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
> >
> >  #define arch_update_ipcc intel_hfi_update_ipcc
> > +#define arch_get_ipcc_score intel_hfi_get_ipcc_score
> >  #endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
> >
> >  #endif /* _ASM_X86_TOPOLOGY_H */
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 530dcf57e06e..fa9b4a678d92 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -206,6 +206,33 @@ void intel_hfi_update_ipcc(struct task_struct *curr)
> >         curr->ipcc = msr.split.classid + 1;
> >  }
> >
> > +unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
> > +{
> > +       unsigned short hfi_class;
> 
> It looks like the variable above is only used to save a subtraction or
> addition of 1 to something going forward.
> 
> > +       int *scores;
> > +
> > +       if (cpu < 0 || cpu >= nr_cpu_ids)
> > +               return -EINVAL;
> > +
> > +       if (ipcc == IPC_CLASS_UNCLASSIFIED)
> > +               return -EINVAL;
> > +
> > +       /*
> > +        * Scheduler IPC classes start at 1. HFI classes start at 0.
> > +        * See note intel_hfi_update_ipcc().
> > +        */
> > +       hfi_class = ipcc - 1;
> > +
> > +       if (hfi_class >= hfi_features.nr_classes)
> 
> Personally, I would do
> 
> if (ipcc >= hfi_features.nr_classes + 1)
> 
> here and ->
> 
> > +               return -EINVAL;
> > +
> > +       scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
> > +       if (!scores)
> > +               return -ENODEV;
> > +
> 
> -> scores[ipcc - 1]

Sure, I can get rid of hfi_class.

> 
> below.
> 
> > +       return READ_ONCE(scores[hfi_class]);
> 
> And why does this need to use READ_ONCE()?

This is the corresponding read of the WRITE_ONCE in patch 13. The CPU
handling the HFI interrupt, very likely a different CPU, updates
scores[hfi_class]. My intention is to let that write to complete before
reading the score here.
> 
> > +}
> > +
> >  static int alloc_hfi_ipcc_scores(void)
> >  {
> >         if (!cpu_feature_enabled(X86_FEATURE_ITD))
> > --
