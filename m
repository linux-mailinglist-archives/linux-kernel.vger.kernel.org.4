Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3500693E57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjBMGbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBMGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:31:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE08E042
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676269912; x=1707805912;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tico6HTkgBXy26etUgH3HgWqEVLIHc9gyZPN+ynMOls=;
  b=XJT04FD2nvbdJrNjVRSNgNskKj3glHCn4oMnx04Lkg2K3CnvciPuQtO4
   J3fuAA66xMGLCc3tUTjogNADHEqWQFf+iPJtlOfZZDvnIr3pbiZJBpr6a
   0q9pL8HqlfiMGeMDt9NOx5e//yMMTCs93Nv9LdUoWLt/W6+Z7R1l5cEGx
   QQu3/wjH1QdH5oGHFBV57Xmjiw/n1AcDMTFw0qD1DnKxLAJlcIQ9a6HV6
   j0M3uy5AxggucQ9nDL2jYhhwvXNHtzje8ZXee4Mm8AkIx8kEgDdLy0hLR
   CNjNGvQdRfpbxI6zl9fiuGEVB0PNtQPc6Zwsyv+Xl3eUQDmGkmV2hhM7B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="329449574"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="329449574"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 22:31:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="757454965"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="757454965"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 22:31:48 -0800
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
Date:   Mon, 13 Feb 2023 14:30:53 +0800
In-Reply-To: <72b6ec8b-f141-3807-d7f2-f853b0f0b76c@amd.com> (Bharata B. Rao's
        message of "Mon, 13 Feb 2023 11:22:12 +0530")
Message-ID: <87zg9i9iw2.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 2/13/2023 8:56 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> Hi,
>>>
>>> Some hardware platforms can provide information about memory accesses
>>> that can be used to do optimal page and task placement on NUMA
>>> systems. AMD processors have a hardware facility called Instruction-
>>> Based Sampling (IBS) that can be used to gather specific metrics
>>> related to instruction fetch and execution activity. This facility
>>> can be used to perform memory access profiling based on statistical
>>> sampling.
>>>
>>> This RFC is a proof-of-concept implementation where the access
>>> information obtained from the hardware is used to drive NUMA balancing.
>>> With this it is no longer necessary to scan the address space and
>>> introduce NUMA hint faults to build task-to-page association. Hence
>>> the approach taken here is to replace the address space scanning plus
>>> hint faults with the access information provided by the hardware.
>> 
>> You method can avoid the address space scanning, but cannot avoid memory
>> access fault in fact.  PMU will raise NMI and then task_work to process
>> the sampled memory accesses.  The overhead depends on the frequency of
>> the memory access sampling.  Please measure the overhead of your method
>> in details.
>
> Yes, the address space scanning is avoided. I will measure the overhead
> of hint fault vs NMI handling path. The actual processing of the access
> from task_work context is pretty much similar to the stats processing
> from hint faults. As you note the overhead depends on the frequency of
> sampling. In this current approach, the sampling period is per-task
> and it varies based on the same logic that NUMA balancing uses to
> vary the scan period.
>
>> 
>>> The access samples obtained from hardware are fed to NUMA balancing
>>> as fault-equivalents. The rest of the NUMA balancing logic that
>>> collects/aggregates the shared/private/local/remote faults and does
>>> pages/task migrations based on the faults is retained except that
>>> accesses replace faults.
>>>
>>> This early implementation is an attempt to get a working solution
>>> only and as such a lot of TODOs exist:
>>>
>>> - Perf uses IBS and we are using the same IBS for access profiling here.
>>>   There needs to be a proper way to make the use mutually exclusive.
>>> - Is tying this up with NUMA balancing a reasonable approach or
>>>   should we look at a completely new approach?
>>> - When accesses replace faults in NUMA balancing, a few things have
>>>   to be tuned differently. All such decision points need to be
>>>   identified and appropriate tuning needs to be done.
>>> - Hardware provided access information could be very useful for driving
>>>   hot page promotion in tiered memory systems. Need to check if this
>>>   requires different tuning/heuristics apart from what NUMA balancing
>>>   already does.
>>> - Some of the values used to program the IBS counters like the sampling
>>>   period etc may not be the optimal or ideal values. The sample period
>>>   adjustment follows the same logic as scan period modification which
>>>   may not be ideal. More experimentation is required to fine-tune all
>>>   these aspects.
>>> - Currently I am acting (i,e., attempt to migrate a page) on each sampled
>>>   access. Need to check if it makes sense to delay it and do batched page
>>>   migration.
>> 
>> You current implementation is tied with AMD IBS.  You will need a
>> architecture/vendor independent framework for upstreaming.
>
> I have tried to keep it vendor and arch neutral as far
> as possible, will re-look into this of course to make the
> interfaces more robust and useful.
>
> I have defined a static key (hw_access_hints=false) which will be
> set only by the platform driver when it detects the hardware
> capability to provide memory access information. NUMA balancing
> code skips the address space scanning when it sees this capability.
> The platform driver (access fault handler) will call into the NUMA
> balancing API with linear and physical address information of the
> accessed sample. Hence any equivalent hardware functionality could
> plug into this scheme in its current form. There are checks for this
> static key in the NUMA balancing logic at a few points to decide if
> it should work based on access faults or hint faults.
>
>> 
>> BTW: can IBS sampling memory writing too?  Or just memory reading?
>
> IBS can tag both store and load operations.

Thanks for your information!

>> 
>>> This RFC is mainly about showing how hardware provided access
>>> information could be used for NUMA balancing but I have run a
>>> few basic benchmarks from mmtests to check if this is any severe
>>> regression/overhead to any of those. Some benchmarks show some
>>> improvement, some show no significant change and a few regress.
>>> I am hopeful that with more appropriate tuning there is scope for
>>> futher improvement here especially for workloads for which NUMA
>>> matters.
>> 
>> What's your expected improvement of the PMU based NUMA balancing?  It
>> should come from reduced overhead?  higher accuracy?  Quicker response?
>> I think that it may be better to prove that with appropriate statistics
>> for at least one workload.
>
> Just to clarify, unlike PEBS, IBS works independently of PMU.

Good to known this, Thanks!

> I believe the improvement will come from reduced overhead due to
> sampling of relevant accesses only.
>
> I have a microbenchmark where two sets of threads bound to two 
> NUMA nodes access the two different halves of memory which is
> initially allocated on the 1st node.
>
> On a two node Zen4 system, with 64 threads in each set accessing
> 8G of memory each from the initial allocation of 16G, I see that
> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
> to complete a fixed number of memory accesses. This could well
> be the best case and real workloads/benchmarks may not get this much
> uplift, but it does show the potential gain to be had.

Can you find a way to show the overhead of the original implementation
and your method?  Then we can compare between them?  Because you think
the improvement comes from the reduced overhead.

I also have interest in the pages migration throughput per second during
the test, because I suspect your method can migrate pages faster.

Best Regards,
Huang, Ying
