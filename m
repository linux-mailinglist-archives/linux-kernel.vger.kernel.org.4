Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3145BAF75
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIPOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIPOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:36:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095B5E576
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663339018; x=1694875018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZlAjlfeBNZZSlxWShJFmoeJQqe7c1A1u25E9Xs0GJTY=;
  b=L1soIoNZzN+L+3hBuJoQHWHPywwnNJ0JemwoBook8B1Tb750TqtUIzqh
   wMlj7WGNQaYSAmD395yZLVgg+wuqCk1FLF4zPR4rDKLPBvGOIOjnCpxob
   EachzwfOWMn0vowTwHGvGvQRRV3yiDd55NfH557DXiqFgTx+TE7Tw6Rn/
   NQMvmOGuY3bxAwtm2t1MgnDJq7iIHOcDAO2GGfWVU7q5E8SdHZErUNQ/s
   XUxLH+tJ5gHEuhbYzzNrUgGRvEbWRcCrT2Fa6mTIbceraR2BEcMUC4D8U
   Fmpq9GQy3LdZq004m4R9qsCrJDb/t5Zwd3lCg7i7tYw9ZcXeHibsC0Awp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="385294607"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="385294607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 07:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743359336"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 07:36:57 -0700
Date:   Fri, 16 Sep 2022 07:42:52 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [RFC PATCH 06/23] sched/core: Update the classification of the
 current task
Message-ID: <20220916144251.GB29395@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-7-ricardo.neri-calderon@linux.intel.com>
 <YyHavf3rHNLOWF8Z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyHavf3rHNLOWF8Z@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:44:29PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:48PM -0700, Ricardo Neri wrote:
> 
> > +	if (sched_task_classes_enabled() && user_tick)
> > +		arch_update_task_class(curr, is_core_idle(cpu));
> 
> This evaluates is_core_idle() even if the hardware improves.

Yes, this is true. Do you think it would make sense to expose is_core_idle()
outside the scheduler? In this manner, only hardware that needs it would
call it.

Thanks and BR,
Ricardo
> 
