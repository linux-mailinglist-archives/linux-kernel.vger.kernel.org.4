Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2386CF900
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjC3CFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC3CFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:05:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCF1BC;
        Wed, 29 Mar 2023 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680141911; x=1711677911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zDLHnp7f6/gRaeT/OTofMpHjg3g6plw+5DJPulgggY4=;
  b=bzqbj0XXO0I+qiE1xWttr1xWMmFCEEmfXQi0cLQ2Xn6xX++S9nSeHOut
   jc1bfldzeuUdsKA4057ji8iGdZyKBTWtV5u6Sqt2XejSfynWHIFGaZpQP
   4Pyzu0IQTb8TlRVVRpYO7kQEMaeBSRMuwh5aETnqCM3gr2hVn9aguV/My
   XF0npGWKLOOHPl9WNU94mtup496qIy/+SRfGfR6lGqHKlNOQKlhWJYdV7
   GzGhtp4x7987CSB7WbNFdPs1+2bYmbJmUUJ2nVFoluloII3q2/RJP3SAu
   Hqi3B/WKbPEBf4TkZA9xi1pxC2BuZSLj+5wcWEJSOEky5V9NhXcHhQHOT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368825508"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368825508"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 19:05:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="828125258"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="828125258"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2023 19:05:10 -0700
Date:   Wed, 29 Mar 2023 19:15:54 -0700
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
Message-ID: <20230330021554.GC26315@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-14-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hooaHtM8=KCx6XYZjPFh66kVBSbPTX4GwiMTgovxoVzg@mail.gmail.com>
 <20230328234315.GD8958@ranerica-svr.sc.intel.com>
 <CAJZ5v0iUg+BBfTkXfkc5X2SFm1icekYOU2Ow+5_4riJjs1v43A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iUg+BBfTkXfkc5X2SFm1icekYOU2Ow+5_4riJjs1v43A@mail.gmail.com>
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

On Wed, Mar 29, 2023 at 02:08:30PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 1:32 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 06:37:32PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> > > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > >
> > > > The scheduler reads the IPCC scores when balancing load. These reads can
> > > > be quite frequent. Hardware can also update the HFI table frequently.
> > > > Concurrent access may cause a lot of lock contention. It gets worse as the
> > > > number of CPUs increases.
> > > >
> > > > Instead, create separate per-CPU IPCC scores that the scheduler can read
> > > > without the HFI table lock.
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
> > > > Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > > > ---
> > > > Changes since v2:
> > > >  * Only create these per-CPU variables when Intel Thread Director is
> > > >    supported.
> > > >
> > > > Changes since v1:
> > > >  * Added this patch.
> > > > ---
> > > >  drivers/thermal/intel/intel_hfi.c | 46 +++++++++++++++++++++++++++++++
> > > >  1 file changed, 46 insertions(+)
> > > >
> > > > diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> > > > index 2527ae3836c7..b06021828892 100644
> > > > --- a/drivers/thermal/intel/intel_hfi.c
> > > > +++ b/drivers/thermal/intel/intel_hfi.c
> > > > @@ -29,6 +29,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/math.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/percpu.h>
> > > >  #include <linux/percpu-defs.h>
> > > >  #include <linux/printk.h>
> > > >  #include <linux/processor.h>
> > > > @@ -170,6 +171,43 @@ static struct workqueue_struct *hfi_updates_wq;
> > > >  #define HFI_UPDATE_INTERVAL            HZ
> > > >  #define HFI_MAX_THERM_NOTIFY_COUNT     16
> > > >
> > > > +#ifdef CONFIG_IPC_CLASSES
> > >
> > > It would be good to provide a (concise) description of this variable.
> > >
> > > > +static int __percpu *hfi_ipcc_scores;
> >
> > Do you mean hfi_ipcc_scores or CONFIG_IPC_CLASSES?
> 
> hfi_ipcc_scores (as the latter is not a variable).

I thought so. Thank you for clarifying.
