Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFB69A579
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 07:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBQGEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 01:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQGEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 01:04:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660A8DBDF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676613871; x=1708149871;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PCiBbKw+u9zZUj5AzZfQc/GM0HnW2Q2nldtRPRAHYoo=;
  b=LzIgRrA0dz+MllSoL7muWF+lzfTCCK4EzjAYgGRkVxa7EnM9ozv8A081
   mA2jd/vTpdZF0t1NTii092OyMV33Bg2oWbpWwTEm5++j/hHPS18NFIstC
   TBCj5SYg7m4mXXqnpt4pIpPXY7pHndr5Y/+YikOupd7ToUvQsjRF9K/u7
   1JCY4KSZpjNJq1qXCr0t7G5XzErLvYu/DxlFTio+w2z1hlfyu75uGQP1N
   wLrULRIa/zVqh2kh2t6FTkR/gKh7+wDjE82bsB8ZQnPg07ewOTjpQ6+cH
   qLpaOWRS2K3Ssq1QxExsEwsxgzEmuSqV3UtQv1azq3VLunThpvUUcaqK2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359365336"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="359365336"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:04:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="739152232"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="739152232"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 22:04:28 -0800
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
Date:   Fri, 17 Feb 2023 14:03:32 +0800
In-Reply-To: <c3e79d2e-97da-726e-bcaa-0258e3ddfafe@amd.com> (Bharata B. Rao's
        message of "Thu, 16 Feb 2023 14:11:20 +0530")
Message-ID: <87zg9c7rrf.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 14-Feb-23 10:25 AM, Bharata B Rao wrote:
>> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>>> I have a microbenchmark where two sets of threads bound to two 
>>>> NUMA nodes access the two different halves of memory which is
>>>> initially allocated on the 1st node.
>>>>
>>>> On a two node Zen4 system, with 64 threads in each set accessing
>>>> 8G of memory each from the initial allocation of 16G, I see that
>>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>>> to complete a fixed number of memory accesses. This could well
>>>> be the best case and real workloads/benchmarks may not get this much
>>>> uplift, but it does show the potential gain to be had.
>>>
>>> Can you find a way to show the overhead of the original implementation
>>> and your method?  Then we can compare between them?  Because you think
>>> the improvement comes from the reduced overhead.
>> 
>> Sure, will measure the overhead.
>
> I used ftrace function_graph tracer to measure the amount of time (in us)
> spent in fault handling and task_work handling in both the methods when
> the above mentioned benchmark was running.
>
> 			Default		IBS
> Fault handling		29879668.71	1226770.84
> Task work handling	24878.894	10635593.82
> Sched switch handling			78159.846
>
> Total			29904547.6	11940524.51

Thanks!  You have shown the large overhead difference between the
original method and your method.  Can you show the number of the pages
migrated too?  I think the overhead / page can be a good overhead
indicator too.

Can it be translated to the performance improvement?  Per my
understanding, the total overhead is small compared with total run time.

Best Regards,
Huang, Ying

> In the default case, the fault handling duration is measured
> by tracing do_numa_page() and the task_work duration is tracked
> by task_numa_work().
>
> In the IBS case, the fault handling is tracked by the NMI handler
> ibs_overflow_handler(), the task_work is tracked by task_ibs_access_work()
> and sched switch time overhead is tracked by hw_access_sched_in(). Note
> that in IBS case, not much is done in NMI handler but bulk of the work
> (page migration etc) happens in task_work context unlike the default case.
>
> The breakup in numbers is given below:
>
> Default
> =======
> 			Duration	Min	Max		Avg
> do_numa_page		29879668.71	0.08	317.166		17.16
> task_numa_work		24878.894	0.2	3424.19		388.73
> Total			29904547.6
>
> IBS
> ===
> 			Duration	Min	Max		Avg
> ibs_overflow_handler	1226770.84	0.15	104.918		1.26
> task_ibs_access_work	10635593.82	0.21	398.428		29.81
> hw_access_sched_in	78159.846	0.15	247.922		1.29
> Total			11940524.51
>
> Regards,
> Bharata.
