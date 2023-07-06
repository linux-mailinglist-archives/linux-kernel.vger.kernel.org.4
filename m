Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7374A782
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 01:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGFXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 19:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGFXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 19:21:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E281BC2;
        Thu,  6 Jul 2023 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688685669; x=1720221669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rqo4/mzDhwixmzcArpHEGMwlYvMUYX2HImjE8L0uFxA=;
  b=LGId1x4syL7WNb2j6mPGF43kkJ7NO5qk2qOBu0foAo+sdfjFRhU7xLcA
   73KOeVoRqhEFaAeqc8xpDXLklrrtJKVGb6GKEck+/3V+HhoupPTb14Dff
   wOPKdDN4v+G5gLWZcB7zILTi6EVi8K6L3NuTEZSjaq6GqWXo6gIDv/A21
   QtGY7tBP81DNi86xtWS45Lg1rX9lXV5WSo17I1/ilAzf2RIrOyo4A5VmY
   mbXS05K50ff4/uvrQrxaaE6lAsuK5eZlXQhTNWKv+pf+BZx1liprh5D/h
   lwxUAF6RTyvg8G0/rXdVsj8dKzr6DWxgsOhApY5ZjyqOZw1RA7MKyKOYe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363787012"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363787012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="697030983"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="697030983"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2023 16:21:07 -0700
Date:   Thu, 6 Jul 2023 16:23:51 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH v4 14/24] thermal: intel: hfi: Store per-CPU IPCC scores
Message-ID: <20230706232350.GB12259@ranerica-svr.sc.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
 <20230613042422.5344-15-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hRCJTwcZm2ZCzA3sZZce-FBU9-zaApsDqJ_3oE=qAmKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hRCJTwcZm2ZCzA3sZZce-FBU9-zaApsDqJ_3oE=qAmKg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 08:53:31PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 13, 2023 at 6:23 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The scheduler reads the IPCC scores when balancing load. These reads can
> > occur frequently and originate from many CPUs. Hardware may also
> > occasionally update the HFI table. Controlling access with locks would
> > cause contention.
> >
> > Cache the IPCC scores in separate per-CPU variables that the scheduler can
> > use. Use a seqcount to synchronize memory accesses to these cached values.
> > This eliminates the need for locks, as the sequence counter provides the
> > memory ordering required to prevent the use of stale data.
> >
> > The HFI delayed workqueue guarantees that only one CPU writes the cached
> > IPCC scores. The frequency of updates is low (every CONFIG_HZ jiffies or
> > less), and the number of writes per update is in the order of tens. Writes
> > should not starve reads.
> >
> > Only cache IPCC scores in this changeset. A subsequent changeset will
> > use these scores.
> >
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Perry Yuan <Perry.Yuan@amd.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v3:
> >  * As Rafael requested, I reworked the memory ordering of the cached IPCC
> >    scores. I selected a seqcount as is less expensive than a memory
> >    barrier, which is not necessary anyways.
> >  * Made alloc_hfi_ipcc_scores() return -ENOMEM on allocation failure.
> >    (Rafael)
> >  * Added a comment to describe hfi_ipcc_scores. (Rafael)
> >
> > Changes since v2:
> >  * Only create these per-CPU variables when Intel Thread Director is
> >    supported.
> >
> > Changes since v1:
> >  * Added this patch.
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 66 +++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 20ee4264dcd4..d822ed0bb5c1 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -29,9 +29,11 @@
> >  #include <linux/kernel.h>
> >  #include <linux/math.h>
> >  #include <linux/mutex.h>
> > +#include <linux/percpu.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/processor.h>
> > +#include <linux/seqlock.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/string.h>
> > @@ -180,6 +182,62 @@ static struct workqueue_struct *hfi_updates_wq;
> >  #define HFI_UPDATE_INTERVAL            HZ
> >  #define HFI_MAX_THERM_NOTIFY_COUNT     16
> >
> > +/* A cache of the HFI perf capabilities for lockless access. */
> > +static int __percpu *hfi_ipcc_scores;
> > +/* Sequence counter for hfi_ipcc_scores */
> > +static seqcount_t hfi_ipcc_seqcount = SEQCNT_ZERO(hfi_ipcc_seqcount);
> > +
> > +static int alloc_hfi_ipcc_scores(void)
> > +{
> > +       if (!cpu_feature_enabled(X86_FEATURE_ITD))
> > +               return 0;
> > +
> > +       hfi_ipcc_scores = __alloc_percpu(sizeof(*hfi_ipcc_scores) *
> > +                                        hfi_features.nr_classes,
> > +                                        sizeof(*hfi_ipcc_scores));
> > +
> > +       return hfi_ipcc_scores ? 0 : -ENOMEM;
> > +}
> 
> This doesn't need to return an int.  It could be a bool function
> returning !!hfi_ipcc_scores (or false for the feature missing case).

Sure Rafael, I can make this change.

> 
> Apart from this minor thing, the patch looks reasonable to me.

Thank you for your review!
