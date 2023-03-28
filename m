Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0F6CCE11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjC1Xcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjC1Xcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:32:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2A30DF;
        Tue, 28 Mar 2023 16:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680046354; x=1711582354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=65+WMaPElJKf9SNcQ16+Oq5u9xg/a+0lddaQlgc/yiA=;
  b=eTh40jqfHx30j68zG8mf5sx4hSkPMJvP0hhXPxgkdEHNJooEixRTcni/
   +fBVn7EnjA9ozc4orrS17LG6UzN3D2TmGMhBB2Z/CNIzP+CItIwlLt9Xi
   NYLjfA0uxzfqXVH8Yl0HyOjtd9giedWgwdv28bzX0Wz/ldrws6/1anMr8
   URPLnCax3YDJB5eze7q5p4A6xmle1QcnNHT7u5NnwQj/ZbZTWM56tghAI
   fsmTzUpjVW8gisXsKvkOuQp1gAGrhyjPSe7JZeXcSRHwLlkxd5Jtt/IXW
   yDi7BGOzbfn7HfCreFvqATb5fBa8wYoGGciPSybqKYlHQ5lHt7oQtvyHt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="338227780"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="338227780"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="686609531"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="686609531"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 28 Mar 2023 16:32:33 -0700
Date:   Tue, 28 Mar 2023 16:43:15 -0700
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
Subject: Re: [PATCH v3 13/24] thermal: intel: hfi: Store per-CPU IPCC scores
Message-ID: <20230328234315.GD8958@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hooaHtM8=KCx6XYZjPFh66kVBSbPTX4GwiMTgovxoVzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hooaHtM8=KCx6XYZjPFh66kVBSbPTX4GwiMTgovxoVzg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:37:32PM +0200, Rafael J. Wysocki wrote:
> On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The scheduler reads the IPCC scores when balancing load. These reads can
> > be quite frequent. Hardware can also update the HFI table frequently.
> > Concurrent access may cause a lot of lock contention. It gets worse as the
> > number of CPUs increases.
> >
> > Instead, create separate per-CPU IPCC scores that the scheduler can read
> > without the HFI table lock.
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
> > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  * Only create these per-CPU variables when Intel Thread Director is
> >    supported.
> >
> > Changes since v1:
> >  * Added this patch.
> > ---
> >  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > index 2527ae3836c7..b06021828892 100644
> > --- a/drivers/thermal/intel/intel_hfi.c
> > +++ b/drivers/thermal/intel/intel_hfi.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/math.h>
> >  #include <linux/mutex.h>
> > +#include <linux/percpu.h>
> >  #include <linux/percpu-defs.h>
> >  #include <linux/printk.h>
> >  #include <linux/processor.h>
> > @@ -170,6 +171,43 @@ static struct workqueue_struct *hfi_updates_wq;
> >  #define HFI_UPDATE_INTERVAL            HZ
> >  #define HFI_MAX_THERM_NOTIFY_COUNT     16
> >
> > +#ifdef CONFIG_IPC_CLASSES
> 
> It would be good to provide a (concise) description of this variable.
> 
> > +static int __percpu *hfi_ipcc_scores;

Do you mean hfi_ipcc_scores or CONFIG_IPC_CLASSES?

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
> > +       return !hfi_ipcc_scores;
> 
> I would do
> 
> if (!hfi_ipcc_scores)
>         return -ENOMEM;
> 
> return 0;
> 
> Or make the function return bool.

Sure, I can make this function return -ENOMEM.

> 
> > +}
> > +
> > +static void set_hfi_ipcc_score(void *caps, int cpu)
> > +{
> > +       int i, *hfi_class;
> > +
> > +       if (!cpu_feature_enabled(X86_FEATURE_ITD))
> > +               return;
> > +
> > +       hfi_class = per_cpu_ptr(hfi_ipcc_scores, cpu);
> > +
> > +       for (i = 0;  i < hfi_features.nr_classes; i++) {
> > +               struct hfi_cpu_data *class_caps;
> > +
> > +               class_caps = caps + i * hfi_features.class_stride;
> > +               WRITE_ONCE(hfi_class[i], class_caps->perf_cap);
> 
> As it stands, it is unclear why WRITE_ONCE() is needed here.

The CPU handling the HFI interrupt will update all the per-CPU IPCC
scores. My intention is to ensure that a WRITE of a given IPCC score
is completed before another CPU READs an IPCC score. The corresponding
READ_ONCE happens in patch 15.
