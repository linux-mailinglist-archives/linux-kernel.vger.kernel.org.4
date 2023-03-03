Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD036A90A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 06:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCCF4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 00:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCCFzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 00:55:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5B23C76
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677822923; x=1709358923;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=245HDXBIH3JX1687A0ozUC1d6tW/+1nBvtor7qkjtrk=;
  b=O34VS3XZrwk1AJODMQHHGj/YRl4n+Fq9wWLBS0JXWjNCLgaISJ+JZeT+
   bxEnjgipwibNCe0UJL+L0y4t9fkGqvNfo8eVPlvUdMBAvgzkqSQiZgpnK
   s1ZEIzu9FRd9sW5+00W208l2sdIBLDjZiIuCZ0mjlJ33lGrJCgc9WbfXK
   /i1Cf61WqbrMX6eDCnehYpjBCK/0guurhxvySmlv6T66ofdezsCCTclTZ
   ucpPf67Ddsb8xodWFN4/iLFFVXBh3H8l4yk9eQOgNjB/VfziM4Gjs23Nc
   4KWl1zpOimCCto3LbjWxiGGJs+pyHCXHWMfRw7HxO8K/fQU/tRHvI4GPr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="323259336"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="323259336"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 21:55:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="677524874"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="677524874"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 21:55:19 -0800
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
        <87jzzz8tgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <41b47cd7-1ba9-3205-165e-02e8384e7064@amd.com>
Date:   Fri, 03 Mar 2023 13:53:50 +0800
In-Reply-To: <41b47cd7-1ba9-3205-165e-02e8384e7064@amd.com> (Bharata B. Rao's
        message of "Fri, 3 Mar 2023 10:55:54 +0530")
Message-ID: <87356m8jo1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 02-Mar-23 1:40 PM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>>>
>>> Here is the data for the benchmark run:
>>>
>>> Time taken or overhead (us) for fault, task_work and sched_switch
>>> handling
>>>
>>> 				Default		IBS
>>> Fault handling			2875354862	2602455		
>>> Task work handling		139023		24008121
>>> Sched switch handling				37712
>>> Total overhead			2875493885	26648288	
>>>
>>> Default
>>> -------
>>> 			Total		Min	Max		Avg
>>> do_numa_page		2875354862	0.08	392.13		22.11
>>> task_numa_work		139023		0.14	5365.77		532.66
>>> Total			2875493885
>>>
>>> IBS
>>> ---
>>> 			Total		Min	Max		Avg
>>> ibs_overflow_handler	2602455		0.14	103.91		1.29
>>> task_ibs_access_work	24008121	0.17	485.09		37.65
>>> hw_access_sched_in	37712		0.15	287.55		1.35
>>> Total			26648288
>>>
>>>
>>> 				Default		IBS
>>> Benchmark score(us)		160171762.0	40323293.0
>>> numa_pages_migrated		2097220		511791
>>> Overhead per page		1371		52
>>> Pages migrated per sec		13094		12692
>>> numa_hint_faults_local		2820311		140856
>>> numa_hint_faults		38589520	652647
>> 
>> For default, numa_hint_faults >> numa_pages_migrated.  It's hard to be
>> understood.
>
> Most of the migration requests from the numa hint page fault path
> are failing due to failure to isolate the pages.
>
> This is the check in migrate_misplaced_page() from where it returns
> without even trying to do the subsequent migrate_pages() call:
>
>         isolated = numamigrate_isolate_page(pgdat, page);
>         if (!isolated)
>                 goto out;
>
> I will further investigate this.
>
>> I guess that there aren't many shared pages in the
>> benchmark?
>
> I have a version of the benchmark which has a fraction of 
> shared memory between sets of thread in addition to the
> per-set exclusive memory. Here too the same performance
> difference is seen.
>
>> And I guess that the free pages in the target node is enough
>> too?
>
> The benchmark is using 16G totally with 8G being accessed from
> threads on either nodes. There is enough memory on the target
> node to accept the incoming page migration requests.
>
>> 
>>> hint_faults_local/hint_faults	7%		22%
>>>
>>> Here is the summary:
>>>
>>> - In case of IBS, the benchmark completes 75% faster compared to
>>>   the default case. The gain varies based on how many iterations of
>>>   memory accesses we run as part of the benchmark. For 2048 iterations
>>>   of accesses, I have seen a gain of around 50%.
>>> - The overhead of NUMA balancing (as measured by the time taken in
>>>   the fault handling, task_work time handling and sched_switch time
>>>   handling) in the default case is seen to be pretty high compared to
>>>   the IBS case.
>>> - The number of hint-faults in the default case is significantly
>>>   higher than the IBS case.
>>> - The local hint-faults percentage is much better in the IBS
>>>   case compared to the default case.
>>> - As shown in the graphs (in other threads of this mail thread), in
>>>   the default case, the page migrations start a bit slowly while IBS
>>>   case shows steady migrations right from the start.
>>> - I have also shown (via graphs in other threads of this mail thread)
>>>   that in IBS case the benchmark is able to steadily increase
>>>   the access iterations over time, while in the default case, the
>>>   benchmark doesn't do forward progress for a long time after
>>>   an initial increase.
>> 
>> Hard to understand this too.  Pages are migrated to local, but
>> performance doesn't improve.
>
> Migrations start a bit late and too much of time is spent later
> in the run in hint faults and failed migration attempts (due to failure
> to isolate the pages) is probably the reason?
>> 
>>> - Early migrations due to relevant access sampling from IBS,
>>>   is most probably the significant reason for the uplift that IBS
>>>   case gets.
>> 
>> In original kernel, the NUMA page table scanning will delay for a
>> while.  Please check the below comments in task_tick_numa().
>> 
>> 	/*
>> 	 * Using runtime rather than walltime has the dual advantage that
>> 	 * we (mostly) drive the selection from busy threads and that the
>> 	 * task needs to have done some actual work before we bother with
>> 	 * NUMA placement.
>> 	 */
>> 
>> I think this is generally reasonable, while it's not best for this
>> micro-benchmark.
>
> This is in addition to the initial scan delay that we have via
> sysctl_numa_balancing_scan_delay. I have an equivalent of this
> initial delay where the IBS access sampling is not started for
> the task until an initial delay.

What is the memory accessing pattern of the workload?  Uniform random or
something like Gauss distribution?

Anyway, it may take some time for the original method to scan enough
memory space to trigger enough hint page fault.  We can check
numa_pte_updates to check whether enough virtual space has been scanned.

Best Regards,
Huang, Ying
