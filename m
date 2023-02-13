Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6890693CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBMDfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBMDfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:35:13 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B5CC01
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 19:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676259312; x=1707795312;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=TdVcZ17rKF87bG8fcEMj5OWJBgzqMGvqBdznTrAWTSQ=;
  b=m4p5taEXZsuDEVPv+ftdB4TkZxFVl2ksG3YF+ffiy8hFP+a6dsduVH2y
   Lo1eEwIynZIJEKnsWyWB8KwfYpdGedSvV7J9nCgWhD+R46AmqLaiJcdAD
   DQg+MEFmjqjrq40lpBAg/6NpeDKkXiNcqQENr6SX9KfkdCZ8BvdcMQxDp
   Nu9/UeyXu3B48xxBGJ2xdG8FyKETp9bGtPA4Cy4cvugRg+f9D4o8vWM9u
   e+zBSj4yIyAtZj8K8fHGe8RSNvqgawiTRLIbW4rjuMyTiG4yfdR4tPwWR
   CyZ7/LA8ARbcw6aALl+noFkt+BdiqpFUPBvqwtOZ+zBI3uVktIGpyrfS2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="332937215"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="332937215"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:35:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="668668649"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="668668649"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:35:07 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <mgorman@suse.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <akpm@linux-foundation.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <yue.li@memverge.com>,
        <Ravikumar.Bangoria@amd.com>
Subject: Re: [RFC PATCH 0/5] Memory access profiler(IBS) driven NUMA balancing
References: <20230208073533.715-1-bharata@amd.com>
        <Y+Pj+9bbBbHpf6xM@hirez.programming.kicks-ass.net>
        <a0127c3c-22c9-ac46-1e9f-200978fec392@amd.com>
        <87cz6eb7e6.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3c811078-c869-452a-8e2d-ebe720d21691@amd.com>
Date:   Mon, 13 Feb 2023 11:34:19 +0800
In-Reply-To: <3c811078-c869-452a-8e2d-ebe720d21691@amd.com> (Bharata B. Rao's
        message of "Mon, 13 Feb 2023 08:53:55 +0530")
Message-ID: <874jrqb5ms.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 2/13/2023 8:26 AM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 2/8/2023 11:33 PM, Peter Zijlstra wrote:
>>>> On Wed, Feb 08, 2023 at 01:05:28PM +0530, Bharata B Rao wrote:
>>>>
>>>>
>>>>> - Hardware provided access information could be very useful for driving
>>>>>   hot page promotion in tiered memory systems. Need to check if this
>>>>>   requires different tuning/heuristics apart from what NUMA balancing
>>>>>   already does.
>>>>
>>>> I think Huang Ying looked at that from the Intel POV and I think the
>>>> conclusion was that it doesn't really work out. What you need is
>>>> frequency information, but the PMU doesn't really give you that. You
>>>> need to process a *ton* of PMU data in-kernel.
>>>
>>> What I am doing here is to feed the access data into NUMA balancing which
>>> already has the logic to aggregate that at task and numa group level and
>>> decide if that access is actionable in terms of migrating the page. In this
>>> context, I am not sure about the frequency information that you and Dave
>>> are mentioning. AFAIU, existing NUMA balancing takes care of taking
>>> action, IBS becomes an alternative source of access information to NUMA
>>> hint faults.
>> 
>> We do need frequency information to determine whether a page is hot
>> enough to be migrated to the fast memory (promotion).  What PMU provided
>> is just "recently" accessed pages, not "frequently" accessed pages.  For
>> current NUMA balancing implementation, please check
>> NUMA_BALANCING_MEMORY_TIERING in should_numa_migrate_memory().  In
>> general, it estimates the page access frequency via measuring the
>> latency between page table scanning and page fault, the shorter the
>> latency, the higher the frequency.  This isn't perfect, but provides a
>> starting point.  You need to consider how to get frequency information
>> via PMU.  For example, you may count access number for each page, aging
>> them periodically, and get hot threshold via some statistics.
>
> For the tiered memory hot page promotion case of NUMA balancing, we will
> have to maintain frequency information in software when such information
> isn't available from the hardware.

Yes.  It's challenging to calculate frequency information.  Please
consider how to do that.

Best Regards,
Huang, Ying
