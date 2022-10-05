Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101C5F5D61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 01:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJEXxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 19:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJEXxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 19:53:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357886834
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665014011; x=1696550011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y8G0HgLt0BP++iDvodCxnez7sIDU3Ki7f33eNAKKvh4=;
  b=TvyNHQDI1lLRASMeceUTPdaXdx86RbNVDAjhsF+N6wZ+2PYr0b6MF5X1
   KlaTmr70dkq7bg8EKuoF/DXT/bAaQA9jCtCE3uUi4i4r2Z9iFuK6tTSu7
   SJnDcmC2bzum2mo0nJ0gsH8CmtYHyqW5U1FNbYQkIvkYnszUAh4ccyL7n
   n3C0fuxbTlYefg1jf2mNlrDiWorQsjXpTcjjhAS2Vde5mOw5X4TcSeh/a
   yE1FFTGmEgCuPzR5xbkCIvn2DT1dkBEZ5Au5yZBYhBw/t2QY5tCG2eh0B
   ihGeOHddzG7UW7uN+oGml1bwkstzyHXYf8hKDoa3pjLhIsmMWmnBo+lH8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304882063"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="304882063"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 16:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="749954529"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="749954529"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2022 16:53:31 -0700
Date:   Wed, 5 Oct 2022 16:59:59 -0700
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
Subject: Re: [RFC PATCH 15/23] thermal: intel: hfi: Report per-cpu
 class-specific performance scores
Message-ID: <20221005235959.GB29251@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-16-ricardo.neri-calderon@linux.intel.com>
 <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLlk8NL5qkOOxzX@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:59:15PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:57PM -0700, Ricardo Neri wrote:
> > Support the arch_get_task_class_score() interface of the scheduler. Use the
> > data that Intel Thread Director provides to inform the scheduler the
> > performance of a class of tasks when placed on a given CPU.
> > 
> 
> > +static void get_one_hfi_cap(struct hfi_instance *hfi_instance, s16 index,
> > +			    struct hfi_cpu_data *hfi_caps, int class)
> > +{
> > +	struct hfi_cpu_data *caps;
> > +
> > +	/* Find the capabilities of @cpu */
> > +	caps = hfi_instance->data + index * hfi_features.cpu_stride +
> > +	       class * hfi_features.class_stride;
> > +	memcpy(hfi_caps, caps, sizeof(*hfi_caps));
> > +}
> > +
> > +int intel_hfi_get_task_class_score(int class, int cpu)
> > +{
> > +	struct hfi_cpu_info *info = &per_cpu(hfi_cpu_info, cpu);
> > +	struct hfi_instance *instance;
> > +	struct hfi_cpu_data caps;
> > +	unsigned long flags;
> > +	int cap;
> > +
> > +	if (cpu < 0 || cpu >= nr_cpu_ids)
> > +		return -EINVAL;
> > +
> > +	if (class == TASK_CLASS_UNCLASSIFIED)
> > +		return -EINVAL;
> > +
> > +	if (class >= (int)hfi_features.nr_classes)
> > +		return -EINVAL;
> > +
> > +	instance = info->hfi_instance;
> > +	if (!instance)
> > +		return -ENOENT;
> > +
> > +	raw_spin_lock_irqsave(&instance->table_lock, flags);
> > +	get_one_hfi_cap(instance, info->index, &caps, class);
> > +	cap = caps.perf_cap;
> > +	raw_spin_unlock_irqrestore(&instance->table_lock, flags);
> > +
> > +	return cap;
> > +}
> 
> Does any of that data actually ever change? Isn't the class score fixed
> per CPU type?

Yes, data can change. The Intel SDM Vol 3 Section 14.6.7 states that the
table can be updated during runtime.

Thanks and BR,
Ricardo
