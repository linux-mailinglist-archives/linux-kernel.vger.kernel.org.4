Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925A76CF923
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC3CbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3CbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:31:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93F4C21;
        Wed, 29 Mar 2023 19:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680143474; x=1711679474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hr7S9nzsJY+w4/cpYEDoHxB1gqpmjEikzuZu6a6JEyk=;
  b=ZJ9+YEkEY3wfusgTRv5iqn4xqKKQZJjXd7UfmpezrU2UD/m8Kxo6hMLD
   /eTZ8pr3MnXsUgtw3WBXrnJdpB7Cr0CdzAV4SDAzJWksVZQgtAkb3Ilds
   5Fp72Mp306T20VNJ7QonLUjx+FX2KPYxtGqf5Knp6M9sZXhDbNW0oP15G
   JTncaboKjzBmsyDZHNSJwwjrpcwmncKK/NU0CvIpTlQFdJqjxQoXpCUVx
   cIHItsUlel84o53EtpgfDhhSCutuINjC1SDGrZP4VNJE8MtBKqyCPeZNO
   0VFz/NAywdBMgbTJarKpGcqzIvVbdMChznI04udBhNxr/HQsi5Rv3Sl2g
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="329541791"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="329541791"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 19:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="828131872"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="828131872"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2023 19:31:12 -0700
Date:   Wed, 29 Mar 2023 19:41:57 -0700
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
Subject: Re: [PATCH v3 21/24] thermal: intel: hfi: Implement model-specific
 checks for task classification
Message-ID: <20230330024157.GD26315@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com>
 <20230329001536.GG8958@ranerica-svr.sc.intel.com>
 <CAJZ5v0iHJrXDU=C0oaf-3DJfatWGj4No_J1rwN6PCpRTZMXqyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iHJrXDU=C0oaf-3DJfatWGj4No_J1rwN6PCpRTZMXqyA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:21:57PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 2:04 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 07:03:08PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > In Alder Lake and Raptor Lake, the result of thread classification is more
> > > > accurate when only one SMT sibling is busy. Classification results for
> > > > class 2 and 3 are always reliable.
> > > >
> > > > To avoid unnecessary migrations, only update the class of a task if it has
> > > > been the same during 4 consecutive user ticks.
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
> > > >  * None
> > > >
> > > > Changes since v1:
> > > >  * Adjusted the result the classification of Intel Thread Director to start
> > > >    at class 1. Class 0 for the scheduler means that the task is
> > > >    unclassified.
> > > >  * Used the new names of the IPC classes members in task_struct.
> > > >  * Reworked helper functions to use sched_smt_siblings_idle() to query
> > > >    the idle state of the SMT siblings of a CPU.
> > > > ---
> > > >  drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
> > > >  1 file changed, 59 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > > index 35d947f47550..fdb53e4cabc1 100644
> > > > --- a/drivers/thermal/intel/intel_hfi.c
> > > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > > @@ -40,6 +40,7 @@
> > > >  #include <linux/workqueue.h>
> > > >
> > > >  #include <asm/msr.h>
> > > > +#include <asm/intel-family.h>
> > > >
> > > >  #include "../thermal_core.h"
> > > >  #include "intel_hfi.h"
> > > > @@ -209,9 +210,64 @@ static int __percpu *hfi_ipcc_scores;
> > > >   */
> > > >  #define HFI_UNCLASSIFIED_DEFAULT 1
> > > >
> > > > +#define CLASS_DEBOUNCER_SKIPS 4
> > > > +
> > > > +/**
> > > > + * debounce_and_update_class() - Process and update a task's classification
> > > > + *
> > > > + * @p:         The task of which the classification will be updated
> > > > + * @new_ipcc:  The new IPC classification
> > > > + *
> > > > + * Update the classification of @p with the new value that hardware provides.
> > > > + * Only update the classification of @p if it has been the same during
> > > > + * CLASS_DEBOUNCER_SKIPS consecutive ticks.
> > > > + */
> > > > +static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
> > > > +{
> > > > +       u16 debounce_skip;
> > > > +
> > > > +       /* The class of @p changed. Only restart the debounce counter. */
> > > > +       if (p->ipcc_tmp != new_ipcc) {
> > > > +               p->ipcc_cntr = 1;
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * The class of @p did not change. Update it if it has been the same
> > > > +        * for CLASS_DEBOUNCER_SKIPS user ticks.
> > > > +        */
> > > > +       debounce_skip = p->ipcc_cntr + 1;
> > > > +       if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
> > > > +               p->ipcc_cntr++;
> > > > +       else
> > > > +               p->ipcc = new_ipcc;
> > > > +
> > > > +out:
> > > > +       p->ipcc_tmp = new_ipcc;
> > > > +}
> > >
> > > Why does the code above belong to the Intel HFI driver?  It doesn't
> > > look like there is anything driver-specific in it.
> >
> > That is a good point. This post-processing is specific to the
> > implementation of IPCC classes using Intel Thread Director.
> 
> Well, the implementation-specific part is the processor model check
> whose only contribution is to say whether or not the classification is
> valid.  The rest appears to be fairly generic to me.

I meant to say that we use Intel Thread Director and the HFI driver to
implement the interfaces defined in patch 2. Other architectures may
implement those interfaces differently.
 
For Intel, we may even need different filters and debouncers for different
models.

> 
> > Maybe a new file called drivers/thermal/intel/intel_itd.c would be better?
> 
> So which part of this code other than the processor model check
> mentioned above is Intel-specific?

debounce_and_update_class() is needed for Intel processors, other
architectures may not need it or have a different solution.
