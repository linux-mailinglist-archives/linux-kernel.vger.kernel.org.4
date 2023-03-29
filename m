Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024726CCE77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 02:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjC2AE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 20:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjC2AE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 20:04:56 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE21A2;
        Tue, 28 Mar 2023 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680048295; x=1711584295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yRvu8GhEdtw5dS1b4qEk1Wt2dMUKhKDgF3IxIuzb0+g=;
  b=Kxn7z/xkKOo+Frct8SiNxvpeEeE3CGYb8hptViEtxKCVOYlSUO+hzocY
   dAv+4cAE3Rt77d+FewLMkf77SjLOBg8xJXZAhUniKiIxFv/+se9rHfCGm
   8LOGYR8i3L3qx4I0++IzNI+UBT/aSzfEVlfkqVXpMG7Gbam3s64YDlN7w
   RuNAl4DNfDyJM+UoSLs3dUIffQcYO/KIsRk0tI8Yx3qdbGs0QvJwT2Jqy
   I1HXdU08T7yIb4VnfmUVHHTYLKnq6yDgBP4MrAYeDXwPUM2+yex1n1FWh
   NyeSrT47FLDjTJULwsMhek43gUi2I4cqoBq+ptSnsIncQHQ4aBXSyqnQj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="427005709"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="427005709"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 17:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686618348"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="686618348"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2023 17:04:54 -0700
Date:   Tue, 28 Mar 2023 17:15:36 -0700
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
Message-ID: <20230329001536.GG8958@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-22-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hxKg_u4GKMkdGEp-JbvnymEtxSZT7fB2kbhWoQFSK1fw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 07:03:08PM +0200, Rafael J. Wysocki wrote:
> On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In Alder Lake and Raptor Lake, the result of thread classification is more
> > accurate when only one SMT sibling is busy. Classification results for
> > class 2 and 3 are always reliable.
> >
> > To avoid unnecessary migrations, only update the class of a task if it has
> > been the same during 4 consecutive user ticks.
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
> >  * Adjusted the result the classification of Intel Thread Director to start
> >    at class 1. Class 0 for the scheduler means that the task is
> >    unclassified.
> >  * Used the new names of the IPC classes members in task_struct.
> >  * Reworked helper functions to use sched_smt_siblings_idle() to query
> >    the idle state of the SMT siblings of a CPU.
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 60 ++++++++++++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 35d947f47550..fdb53e4cabc1 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -40,6 +40,7 @@
> >  #include <linux/workqueue.h>
> >
> >  #include <asm/msr.h>
> > +#include <asm/intel-family.h>
> >
> >  #include "../thermal_core.h"
> >  #include "intel_hfi.h"
> > @@ -209,9 +210,64 @@ static int __percpu *hfi_ipcc_scores;
> >   */
> >  #define HFI_UNCLASSIFIED_DEFAULT 1
> >
> > +#define CLASS_DEBOUNCER_SKIPS 4
> > +
> > +/**
> > + * debounce_and_update_class() - Process and update a task's classification
> > + *
> > + * @p:         The task of which the classification will be updated
> > + * @new_ipcc:  The new IPC classification
> > + *
> > + * Update the classification of @p with the new value that hardware provides.
> > + * Only update the classification of @p if it has been the same during
> > + * CLASS_DEBOUNCER_SKIPS consecutive ticks.
> > + */
> > +static void debounce_and_update_class(struct task_struct *p, u8 new_ipcc)
> > +{
> > +       u16 debounce_skip;
> > +
> > +       /* The class of @p changed. Only restart the debounce counter. */
> > +       if (p->ipcc_tmp != new_ipcc) {
> > +               p->ipcc_cntr = 1;
> > +               goto out;
> > +       }
> > +
> > +       /*
> > +        * The class of @p did not change. Update it if it has been the same
> > +        * for CLASS_DEBOUNCER_SKIPS user ticks.
> > +        */
> > +       debounce_skip = p->ipcc_cntr + 1;
> > +       if (debounce_skip < CLASS_DEBOUNCER_SKIPS)
> > +               p->ipcc_cntr++;
> > +       else
> > +               p->ipcc = new_ipcc;
> > +
> > +out:
> > +       p->ipcc_tmp = new_ipcc;
> > +}
> 
> Why does the code above belong to the Intel HFI driver?  It doesn't
> look like there is anything driver-specific in it.

That is a good point. This post-processing is specific to the
implementation of IPCC classes using Intel Thread Director.

Maybe a new file called drivers/thermal/intel/intel_itd.c would be better?
