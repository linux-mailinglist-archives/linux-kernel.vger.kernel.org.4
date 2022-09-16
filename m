Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635FA5BAF92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIPOpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiIPOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:45:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F78B25584
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663339507; x=1694875507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SXd2l5thJXCMKOjXOfvXBk2+NDGX/BmG6374W08qMuU=;
  b=dpbHBoHDOD5rV3W9BMnW3mj8f5vnBeu335vRqeu948eJVGBFJYf9ct0g
   qyE1Uw5W6FNHss+3aF559GCe+1tCvtSdaoL1LJ3KIpcDlA7mL619O6bjZ
   Np6eOWIFPGlepRc3EUs+759Mix0j2MwxfwBzZHiosskK0zwBbD5pPsS/+
   WfKMnDsKnVZd5Qzbbc9FPPcd6fJPNseZOPkYULflCUF/0iPQoTnMyOlkA
   2NdynjQpALfV8nLq1C1rxdDmP431dxpPHMVSEC5wEMGwWHXLvO7rU32ey
   WC4x+uBz1ANXODApUGh/gFKf7MrpPfhzN81ntlkoMGOMtiNuidDWtP2XQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362967456"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362967456"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743360945"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 07:45:06 -0700
Date:   Fri, 16 Sep 2022 07:51:01 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 06/23] sched/core: Update the classification of the
 current task
Message-ID: <20220916145100.GC29395@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220910072120.2651-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910072120.2651-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 03:21:20PM +0800, Hillf Danton wrote:
> On 9 Sep 2022 16:11:48 -0700 Ricardo Neri <ricardo.neri-calderon@linux.intel.com> wrote:
> > @@ -5445,6 +5445,9 @@ void scheduler_tick(bool user_tick)
> >  	unsigned long thermal_pressure;
> >  	u64 resched_latency;
> >  
> > +	if (sched_task_classes_enabled() && user_tick)
> > +		arch_update_task_class(curr, is_core_idle(cpu));
> > +
> >  	arch_scale_freq_tick();
> >  	sched_clock_tick();
> 
Thank you very much for your feedback Hillf!

> Given user_tick == true, core is not idle regardless of SMT.
> IOW I doubt is_core_idle() helps here.

Perhaps is_core_idle() is a bad name? The second argument of arch_update_
task_class() is smt_siblings_idle. is_core_idle() gives us the answer
we want.

is_core_idle() only checks the siblings of @cpu. It explicitly skips itself
from the checks of idle state. We are only interested in the idle state of
the siblings.

Am I missing anything?

Thanks and BR,
Ricardo
