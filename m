Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578AF6A7C43
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjCBILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 03:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCBILO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 03:11:14 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895230286
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 00:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677744672; x=1709280672;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2C5Ik7/fiXySFCOa9/1bcQNlInhbuuMxzpCF3INXVxs=;
  b=TXwyPCHHCtQEx8cWtIth60bo7H0J7VQ9rh/bc8IfccYb4RW8/kKoiAUp
   y4r9Wi2B5pz404PdTGghDXoZqXzbUywGUdMSICCFLj8IG5Yu4TTETu23B
   iz+EmBhSzQe0z5RVmqQ2tdQYA/OS2K+EesWOF/vjHVe6p/Z5UUkXdhZ04
   rbn67rA7X3CWEh1Yd5fgPUaWcyFZJTsSpRK4QOlp0qZYk9OywuEnrIVGC
   9m5rn+W593SC21ohMR807UXqtgoFtGMORYLuEdVYg1mzOZVUixVZdslrz
   bteKxckcT8bPgmAuRVmmbsn5yhG4IsqreWmGI2sg+wtjTMJVgOv8pMbBy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362241752"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="362241752"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:11:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="798736344"
X-IronPort-AV: E=Sophos;i="5.98,227,1673942400"; 
   d="scan'208";a="798736344"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 00:11:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mgorman@suse.de>, <peterz@infradead.org>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
References: <20230208073533.715-1-bharata@amd.com>
        <878rh2b5zt.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com>
        <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1547d291-1512-faae-aba5-0f84c3502be4@amd.com>
        <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com>
        <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com>
        <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com>
Date:   Thu, 02 Mar 2023 16:10:01 +0800
In-Reply-To: <b19e0c22-c80b-7223-6ed7-472502948fa0@amd.com> (Bharata B. Rao's
        message of "Wed, 1 Mar 2023 16:51:25 +0530")
Message-ID: <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 27-Feb-23 1:24 PM, Huang, Ying wrote:
>> Thank you very much for detailed data.  Can you provide some analysis
>> for your data?
>
> The overhead numbers I shared earlier weren't correct as I
> realized that while obtaining those numbers from function_graph
> tracing, the trace buffer was silently getting overrun. I had to
> reduce the number of memory access iterations to ensure that I get
> the full trace buffer. I will be summarizing the findings
> based on this new numbers below.
>
> Just to recap - The microbenchmark is run on an AMD Genoa
> two node system. The benchmark has two set of threads,
> (one affined to each node) accessing two different chunks
> of memory (chunk size 8G) which are initially allocated
> on first node. The benchmark touches each page in the
> chunk iteratively for a fixed number of iterations (384
> in this case given below). The benchmark score is the
> amount of time it takes to complete the specified number
> of accesses.
>
> Here is the data for the benchmark run:
>
> Time taken or overhead (us) for fault, task_work and sched_switch
> handling
>
> 				Default		IBS
> Fault handling			2875354862	2602455		
> Task work handling		139023		24008121
> Sched switch handling				37712
> Total overhead			2875493885	26648288	
>
> Default
> -------
> 			Total		Min	Max		Avg
> do_numa_page		2875354862	0.08	392.13		22.11
> task_numa_work		139023		0.14	5365.77		532.66
> Total			2875493885
>
> IBS
> ---
> 			Total		Min	Max		Avg
> ibs_overflow_handler	2602455		0.14	103.91		1.29
> task_ibs_access_work	24008121	0.17	485.09		37.65
> hw_access_sched_in	37712		0.15	287.55		1.35
> Total			26648288
>
>
> 				Default		IBS
> Benchmark score(us)		160171762.0	40323293.0
> numa_pages_migrated		2097220		511791
> Overhead per page		1371		52
> Pages migrated per sec		13094		12692
> numa_hint_faults_local		2820311		140856
> numa_hint_faults		38589520	652647

For default, numa_hint_faults >> numa_pages_migrated.  It's hard to be
understood.  I guess that there aren't many shared pages in the
benchmark?  And I guess that the free pages in the target node is enough
too?

> hint_faults_local/hint_faults	7%		22%
>
> Here is the summary:
>
> - In case of IBS, the benchmark completes 75% faster compared to
>   the default case. The gain varies based on how many iterations of
>   memory accesses we run as part of the benchmark. For 2048 iterations
>   of accesses, I have seen a gain of around 50%.
> - The overhead of NUMA balancing (as measured by the time taken in
>   the fault handling, task_work time handling and sched_switch time
>   handling) in the default case is seen to be pretty high compared to
>   the IBS case.
> - The number of hint-faults in the default case is significantly
>   higher than the IBS case.
> - The local hint-faults percentage is much better in the IBS
>   case compared to the default case.
> - As shown in the graphs (in other threads of this mail thread), in
>   the default case, the page migrations start a bit slowly while IBS
>   case shows steady migrations right from the start.
> - I have also shown (via graphs in other threads of this mail thread)
>   that in IBS case the benchmark is able to steadily increase
>   the access iterations over time, while in the default case, the
>   benchmark doesn't do forward progress for a long time after
>   an initial increase.

Hard to understand this too.  Pages are migrated to local, but
performance doesn't improve.

> - Early migrations due to relevant access sampling from IBS,
>   is most probably the significant reason for the uplift that IBS
>   case gets.

In original kernel, the NUMA page table scanning will delay for a
while.  Please check the below comments in task_tick_numa().

	/*
	 * Using runtime rather than walltime has the dual advantage that
	 * we (mostly) drive the selection from busy threads and that the
	 * task needs to have done some actual work before we bother with
	 * NUMA placement.
	 */

I think this is generally reasonable, while it's not best for this
micro-benchmark.

Best Regards,
Huang, Ying

> - It is consistently seen that the benchmark in the IBS case manages
>   to complete the specified number of accesses even before the entire
>   chunk of memory gets migrated. The early migrations are offsetting
>   the cost of remote accesses too.
> - In the IBS case, we re-program the IBS counters for the incoming
>   task in the sched_switch path. It is seen that this overhead isn't
>   that significant to slow down the benchmark.
> - One of the differences between the default case and the IBS case
>   is about when the faults-since-last-scan is updated/folded into the
>   historical faults stats and subsequent scan period update. Since we
>   don't have the notion of scanning in IBS, I have a threshold (number
>   of access faults) to determine when to update the historical faults
>   and the IBS sample period. I need to check if quicker migrations
>   could result from this change.
> - Finally, all this is for the above mentioned microbenchmark. The
>   gains on other benchmarks is yet to be evaluated.
>
> Regards,
> Bharata.
