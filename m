Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB36109CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ1Frk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJ1Fri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:47:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E4219898A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666936058; x=1698472058;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cXm77466EiN7lwIV5G1+cqSsH01WFY4+oxX/pQE11fc=;
  b=DSsecvohF3kMy3dzpA3+7HixJYmJ2GKuWL+c1tptdoh/vsLSH0ou72Yc
   8WsYSfZPMEyRhFvQJ2aIi7LXZ+4V1J+D9jnAjW4W3gFh+BAv4KZLuDJp4
   704WSdPNDZ3JC79Dp21wPBFm7ZDaqHHalaorfxcNJpUCjSTdnuVfFUXOD
   ngLiqhW7X/mRZpr6X7HEXVM4fRWC3evhvtI/hNRhJPPKFSNI8TkyXLjXf
   5GXDPYJsnGrGJxa8gCR2aejOS5CVUGXOag//kthAJp9/QL215Ok+o7s9+
   K34ki8fWebLGpAUHpxYU6IsoV990cboIIqdtXQsc5TO1MrBWvjp3DPR6A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="310113398"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="310113398"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 22:47:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="721936241"
X-IronPort-AV: E=Sophos;i="5.95,220,1661842800"; 
   d="scan'208";a="721936241"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 22:47:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <20221027065925.476955-1-ying.huang@intel.com>
        <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
        <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
Date:   Fri, 28 Oct 2022 13:46:47 +0800
In-Reply-To: <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com> (Aneesh
        Kumar K. V.'s message of "Fri, 28 Oct 2022 10:35:44 +0530")
Message-ID: <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:

> On 10/28/22 8:33 AM, Huang, Ying wrote:
>> Hi, Aneesh,
>> 
>> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> On 10/27/22 12:29 PM, Huang Ying wrote:
>>>> We need some way to override the system default memory tiers.  For
>>>> the example system as follows,
>>>>
>>>> type		abstract distance
>>>> ----		-----------------
>>>> HBM		300
>>>> DRAM		1000
>>>> CXL_MEM		5000
>>>> PMEM		5100
>>>>
>>>> Given the memory tier chunk size is 100, the default memory tiers
>>>> could be,
>>>>
>>>> tier		abstract distance	types
>>>>                 range
>>>> ----		-----------------       -----
>>>> 3		300-400			HBM
>>>> 10		1000-1100		DRAM
>>>> 50		5000-5100		CXL_MEM
>>>> 51		5100-5200		PMEM
>>>>
>>>> If we want to group CXL MEM and PMEM into one tier, we have 2 choices.
>>>>
>>>> 1) Override the abstract distance of CXL_MEM or PMEM.  For example, if
>>>> we change the abstract distance of PMEM to 5050, the memory tiers
>>>> become,
>>>>
>>>> tier		abstract distance	types
>>>>                 range
>>>> ----		-----------------       -----
>>>> 3		300-400			HBM
>>>> 10		1000-1100		DRAM
>>>> 50		5000-5100		CXL_MEM, PMEM
>>>>
>>>> 2) Override the memory tier chunk size.  For example, if we change the
>>>> memory tier chunk size to 200, the memory tiers become,
>>>>
>>>> tier		abstract distance	types
>>>>                 range
>>>> ----		-----------------       -----
>>>> 1		200-400			HBM
>>>> 5		1000-1200		DRAM
>>>> 25		5000-5200		CXL_MEM, PMEM
>>>>
>>>> But after some thoughts, I think choice 2) may be not good.  The
>>>> problem is that even if 2 abstract distances are almost same, they may
>>>> be put in 2 tier if they sit in the different sides of the tier
>>>> boundary.  For example, if the abstract distance of CXL_MEM is 4990,
>>>> while the abstract distance of PMEM is 5010.  Although the difference
>>>> of the abstract distances is only 20, CXL_MEM and PMEM will put in
>>>> different tiers if the tier chunk size is 50, 100, 200, 250, 500, ....
>>>> This makes choice 2) hard to be used, it may become tricky to find out
>>>> the appropriate tier chunk size that satisfying all requirements.
>>>>
>>>
>>> Shouldn't we wait for gaining experience w.r.t how we would end up
>>> mapping devices with different latencies and bandwidth before tuning these values? 
>> 
>> Just want to discuss the overall design.
>> 
>>>> So I suggest to abandon choice 2) and use choice 1) only.  This makes
>>>> the overall design and user space interface to be simpler and easier
>>>> to be used.  The overall design of the abstract distance could be,
>>>>
>>>> 1. Use decimal for abstract distance and its chunk size.  This makes
>>>>    them more user friendly.
>>>>
>>>> 2. Make the tier chunk size as small as possible.  For example, 10.
>>>>    This will put different memory types in one memory tier only if their
>>>>    performance is almost same by default.  And we will not provide the
>>>>    interface to override the chunk size.
>>>>
>>>
>>> this could also mean we can end up with lots of memory tiers with relative
>>> smaller performance difference between them. Again it depends how HMAT
>>> attributes will be used to map to abstract distance.
>> 
>> Per my understanding, there will not be many memory types in a system.
>> So, there will not be many memory tiers too.  In most systems, there are
>> only 2 or 3 memory tiers in the system, for example, HBM, DRAM, CXL,
>> etc. 
>
> So we don't need the chunk size to be 10 because we don't forsee us needing
> to group devices into that many tiers. 

I suggest to use small chunk size to avoid to group 2 memory
types into one memory tier accidently.

>> Do you know systems with many memory types?  The basic idea is to
>> put different memory types in different memory tiers by default.  If
>> users want to group them, they can do that via overriding the abstract
>> distance of some memory type.
>> 
>
> with small chunk size and depending on how we are going to derive abstract distance,
> I am wondering whether we would end up with lots of memory tiers with no 
> real value. Hence my suggestion to wait making a change like this till we have
> code that map HMAT/CDAT attributes to abstract distance. 

Per my understanding, the NUMA nodes of the same memory type/tier will
have the exact same latency and bandwidth in HMAT/CDAT for the CPU in
the same socket.

If my understanding were correct, you think the latency / bandwidth of
these NUMA nodes will near each other, but may be different.

Even if the latency / bandwidth of these NUMA nodes isn't exactly same,
we should deal with that in memory types instead of memory tiers.
There's only one abstract distance for each memory type.

So, I still believe we will not have many memory tiers with my proposal.

I don't care too much about the exact number, but want to discuss some
general design choice,

a) Avoid to group multiple memory types into one memory tier by default
   at most times.

b) Abandon customizing abstract distance chunk size.

Best Regards,
Huang, Ying

>
>>>
>>>> 3. Make the abstract distance of normal DRAM large enough.  For
>>>>    example, 1000, then 100 tiers can be defined below DRAM, this is
>>>>    more than enough in practice.
>>>
>>> Why 100? Will we really have that many tiers below/faster than DRAM? As of now 
>>> I see only HBM below it.
>> 
>> Yes.  100 is more than enough.  We just want to avoid to group different
>> memory types by default.
>> 
>> Best Regards,
>> Huang, Ying
>> 
