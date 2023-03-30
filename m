Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684816CF951
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjC3Czu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC3Czt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:55:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4B1FCC;
        Wed, 29 Mar 2023 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680144948; x=1711680948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/Zr8RbMTWY/RYua1wovkm1YrdAuIuQRR6z4WQGPYUfM=;
  b=kGVljaRGAjg8tLd7OJKNsmpwb56pomDoDeQpulYg8IoarCNgJJYxLB25
   rB99h1HzFkuUY8+P42sZ/TlZ1EEQ4vci/twa9A3vyrO6w+O/lI8DiRj/a
   ttXsmAVeU9FvRnRQyE+3vKIyMF6mslMhoHoJ8Q/k2hhNCikOoLyMUj+Md
   v79ePcBhgg47RJUw1gxy+bwxJTPDFVve2I5pEYTbojMdPJ4+qPvOr2ZJK
   yUgSZl31LZ2bGcHs75z6OV+kyqWv/+GJFIwEDHo/+fnEHPgoCiKFFer4a
   w1A5C31qZkKVSy2nW/jdB5B3Bw9jgedwhMvgpJtksSu9VWrE78aOr4zNG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339777579"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339777579"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 19:55:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="1014272209"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="1014272209"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2023 19:55:47 -0700
Date:   Wed, 29 Mar 2023 20:06:31 -0700
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
Subject: Re: [PATCH v3 14/24] thermal: intel: hfi: Update the IPC class of
 the current task
Message-ID: <20230330030631.GA27247@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-15-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hGKKPiK86Z5PcG-EEHU7a=3d-4S2miRqNPuwjS1tF0BQ@mail.gmail.com>
 <20230328234149.GB8958@ranerica-svr.sc.intel.com>
 <CAJZ5v0gOqNzpC9kqpBtqP1D2-OLNqWCf=ZYpzu9b0tqFcgBWYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gOqNzpC9kqpBtqP1D2-OLNqWCf=ZYpzu9b0tqFcgBWYQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:13:29PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 1:31 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 06:42:28PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > Use Intel Thread Director classification to update the IPC class of a
> > > > task. Implement the arch_update_ipcc() interface of the scheduler.
> > > >
> > > > Cc: Ben Segall <bsegall@google.com>
> > > > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > > > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > Cc: Len Brown <len.brown@intel.com>
> > > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > > Cc: Mel Gorman <mgorman@suse.de>
> > > > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > > > Cc: Valentin Schneider <vschneid@redhat.com>
> > > > Cc: x86@kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > Changes since v2:
> > > >  * Removed the implementation of arch_has_ipc_classes().
> > > >
> > > > Changes since v1:
> > > >  * Adjusted the result the classification of Intel Thread Director to start
> > > >    at class 1. Class 0 for the scheduler means that the task is
> > > >    unclassified.
> > > >  * Redefined union hfi_thread_feedback_char_msr to ensure all
> > > >    bit-fields are packed. (PeterZ)
> > > >  * Removed CONFIG_INTEL_THREAD_DIRECTOR. (PeterZ)
> > > >  * Shortened the names of the functions that implement IPC classes.
> > > >  * Removed argument smt_siblings_idle from intel_hfi_update_ipcc().
> > > >    (PeterZ)
> > > > ---
> > > >  arch/x86/include/asm/topology.h   |  6 ++++++
> > > >  drivers/thermal/intel/intel_hfi.c | 32 +++++++++++++++++++++++++++++++
> > > >  2 files changed, 38 insertions(+)
> > > >
> > > > diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> > > > index 458c891a8273..ffcdac3f398f 100644
> > > > --- a/arch/x86/include/asm/topology.h
> > > > +++ b/arch/x86/include/asm/topology.h
> > > > @@ -227,4 +227,10 @@ void init_freq_invariance_cppc(void);
> > > >  #define arch_init_invariance_cppc init_freq_invariance_cppc
> > > >  #endif
> > > >
> > > > +#if defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL)
> > > > +void intel_hfi_update_ipcc(struct task_struct *curr);
> > > > +
> > > > +#define arch_update_ipcc intel_hfi_update_ipcc
> > > > +#endif /* defined(CONFIG_IPC_CLASSES) && defined(CONFIG_INTEL_HFI_THERMAL) */
> > > > +
> > > >  #endif /* _ASM_X86_TOPOLOGY_H */
> > > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > > index b06021828892..530dcf57e06e 100644
> > > > --- a/drivers/thermal/intel/intel_hfi.c
> > > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > > @@ -72,6 +72,17 @@ union cpuid6_edx {
> > > >         u32 full;
> > > >  };
> > > >
> > > > +#ifdef CONFIG_IPC_CLASSES
> > > > +union hfi_thread_feedback_char_msr {
> > > > +       struct {
> > > > +               u64     classid : 8;
> > > > +               u64     __reserved : 55;
> > > > +               u64     valid : 1;
> > > > +       } split;
> > > > +       u64 full;
> > > > +};
> > > > +#endif
> > > > +
> > > >  /**
> > > >   * struct hfi_cpu_data - HFI capabilities per CPU
> > > >   * @perf_cap:          Performance capability
> > > > @@ -174,6 +185,27 @@ static struct workqueue_struct *hfi_updates_wq;
> > > >  #ifdef CONFIG_IPC_CLASSES
> > > >  static int __percpu *hfi_ipcc_scores;
> > > >
> > > > +void intel_hfi_update_ipcc(struct task_struct *curr)
> > > > +{
> > > > +       union hfi_thread_feedback_char_msr msr;
> > > > +
> > > > +       /* We should not be here if ITD is not supported. */
> > > > +       if (!cpu_feature_enabled(X86_FEATURE_ITD)) {
> > > > +               pr_warn_once("task classification requested but not supported!");
> > > > +               return;
> > > > +       }
> > > > +
> > > > +       rdmsrl(MSR_IA32_HW_FEEDBACK_CHAR, msr.full);
> > > > +       if (!msr.split.valid)
> > > > +               return;
> > > > +
> > > > +       /*
> > > > +        * 0 is a valid classification for Intel Thread Director. A scheduler
> > > > +        * IPCC class of 0 means that the task is unclassified. Adjust.
> > > > +        */
> > > > +       curr->ipcc = msr.split.classid + 1;
> > > > +}
> > >
> > > Wouldn't it be better to return the adjusted value from this function
> > > and let the caller store it where appropriate?
> > >
> > > It doesn't look like it is necessary to pass the task_struct pointer to it.
> >
> > Judging from this patch alone, yes, it does not make much sense to pass a
> > task_struct as argument. In patch 21, however, this function uses various
> > members of task_struct and makes it more convenient to have it as argument,
> > no?
> 
> I'm not convinced about this, but anyway it is better to combine the
> two patches in such cases IMO.
> 
> The way it is done now confuses things from my perspective.

Right, I structured the patchset to have the additions to task_struct in
separate patches. This made it less clear for intel_hfi.c

Would it be acceptable if I kept void intel_hfi_update_ipcc(struct
task_struct *curr) and added a static function u32 intel_hfi_get_ipcc(void)
to return the hardware classification?

Otherwise, I would need to add three different accessors for task_struct
so that the HFI driver can retrieve the auxiliary members from patch 21.

Thanks and BR,
Ricardo
