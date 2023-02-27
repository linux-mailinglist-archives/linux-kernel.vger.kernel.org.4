Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51F16A3BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB0Hz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Hz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:55:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F71027A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677484526; x=1709020526;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xQsnLwR6WvsW3HYMB5OebnDeFXQGQNEsYlVg6eCzsdo=;
  b=GqX/DlM/h+UK5gHHCJGJzVgBKBn/EtsdCnWFJokG1XATCIwQlc+vzyr7
   MDhk6ZmsuqlHfpct+IEdcT9+kLu7DrayyXLbtkZwEs9CJTr3UrACbTLOp
   sP2+8NjXvZSOCxhV10Y4QtlX7TlHO/gFatpRnhcV6s863GwfMbpkqvzQY
   LO3mgqA1IeBJisatj5TVa6oHLJoF8HU5CygJNDq0mo85oyvDELlSU83sT
   aWI7yJoWwmR2IwaKD9if079IW6s+bYeelhdRu76yvZPCBBinaK3abfjC9
   +etNZ6keMJrvUn4oS5DYgPg2hetbS8aIRknxdMcyTPDmjC9uPJwpjnh+t
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="332525920"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="332525920"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 23:55:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="623478659"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="623478659"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 23:55:20 -0800
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
Date:   Mon, 27 Feb 2023 15:54:13 +0800
In-Reply-To: <8fea74ec-8feb-1709-14f2-cecb63fdc9ed@amd.com> (Bharata B. Rao's
        message of "Fri, 24 Feb 2023 09:06:49 +0530")
Message-ID: <87v8jnbl22.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 17-Feb-23 11:33 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 14-Feb-23 10:25 AM, Bharata B Rao wrote:
>>>> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>>>>> I have a microbenchmark where two sets of threads bound to two 
>>>>>> NUMA nodes access the two different halves of memory which is
>>>>>> initially allocated on the 1st node.
>>>>>>
>>>>>> On a two node Zen4 system, with 64 threads in each set accessing
>>>>>> 8G of memory each from the initial allocation of 16G, I see that
>>>>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>>>>> to complete a fixed number of memory accesses. This could well
>>>>>> be the best case and real workloads/benchmarks may not get this much
>>>>>> uplift, but it does show the potential gain to be had.
>>>>>
>>>>> Can you find a way to show the overhead of the original implementation
>>>>> and your method?  Then we can compare between them?  Because you think
>>>>> the improvement comes from the reduced overhead.
>>>>
>>>> Sure, will measure the overhead.
>>>
>>> I used ftrace function_graph tracer to measure the amount of time (in us)
>>> spent in fault handling and task_work handling in both the methods when
>>> the above mentioned benchmark was running.
>>>
>>> 			Default		IBS
>>> Fault handling		29879668.71	1226770.84
>>> Task work handling	24878.894	10635593.82
>>> Sched switch handling			78159.846
>>>
>>> Total			29904547.6	11940524.51
>> 
>> Thanks!  You have shown the large overhead difference between the
>> original method and your method.  Can you show the number of the pages
>> migrated too?  I think the overhead / page can be a good overhead
>> indicator too.
>> 
>> Can it be translated to the performance improvement?  Per my
>> understanding, the total overhead is small compared with total run time.
>
> I captured some of the numbers that you wanted for two different runs.
> The first case shows the data for a short run (less number of memory access
> iterations) and the second one is for a long run (more number of iterations)
>
> Short-run
> =========
> Time taken or overhead (us) for fault, task_work and sched_switch
> handling
>
> 			Default		IBS
> Fault handling		29017953.99	1196828.67
> Task work handling	10354.40	10356778.53
> Sched switch handling			56572.21
> Total overhead		29028308.39	11610179.41
>
> Benchmark score(us)	194050290	53963650
> numa_pages_migrated	2097256		662755
> Overhead / page		13.84		17.51

From above, the overhead/page is similar.

> Pages migrated per sec	72248.64	57083.95
>
> Default
> -------
> 			Total		Min	Max		Avg
> do_numa_page		29017953.99	0.1	307.63		15.97
> task_numa_work		10354.40	2.86	4573.60		175.50
> Total			29028308.39
>
> IBS
> ---
> 			Total		Min	Max		Avg
> ibs_overflow_handler	1196828.67	0.15	100.28		1.26
> task_ibs_access_work	10356778.53	0.21	10504.14	28.42
> hw_access_sched_in	56572.21	0.15	16.94		1.45
> Total			11610179.41
>
>
> Long-run
> ========
> Time taken or overhead (us) for fault, task_work and sched_switch
> handling
> 			Default		IBS
> Fault handling		27437756.73	901406.37
> Task work handling	1741.66		4902935.32
> Sched switch handling			100590.33
> Total overhead		27439498.38	5904932.02
>
> Benchmark score(us)	306786210.0	153422489.0
> numa_pages_migrated	2097218		1746099
> Overhead / page		13.08		3.38

But from this, the overhead/page is quite different.

One possibility is that there's more "local" hint page faults in the
original implementation, we can check "numa_hint_faults" and
"numa_hint_faults_local" in /proc/vmstat for that.

If

  numa_hint_faults_local / numa_hint_faults

is similar.  For each page migrated, the number of hint page fault is
similar, and the run time for each hint page fault handler is similar
too.  Or I made some mistake in analysis?

> Pages migrated per sec	6836.08		11380.98
>
> Default
> -------
> 			Total		Min	Max		Avg
> do_numa_page		27437756.73	0.08	363.475		15.03
> task_numa_work		1741.66		3.294	1200.71		42.48
> Total			27439498.38
>
> IBS
> ---
> 			Total		Min	Max		Avg
> ibs_overflow_handler	901406.37	0.15	95.51		1.06
> task_ibs_access_work	4902935.32	0.22	11013.68	9.64
> hw_access_sched_in	100590.33	0.14	91.97		1.52
> Total			5904932.02

Thank you very much for detailed data.  Can you provide some analysis
for your data?

Best Regards,
Huang, Ying

