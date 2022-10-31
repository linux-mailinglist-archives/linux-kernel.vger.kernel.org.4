Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFC4612EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 02:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJaBep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 21:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJaBen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 21:34:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10E75FAA
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667180080; x=1698716080;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Pr/aS2rdynHUpdhyMcCOSJRgj/kU8LUfG/+C6yMaxzY=;
  b=kdqi4hOPqwjPNaJu6GVXvakGYEl4JOFLcqshLFcCtKXs2edZKdParquT
   jDBE9geByYamXR9xv1BErENhh/xOb9XdaIFm7OLBOMS43mm7IC66YI1Xo
   9MJCo3O8J2gMfw8D7fvjAQZpKpSllDCAp75EbNIV7vEFB75sCbmgtCkZW
   o5kcnvxmogL0lDt5ia9/OSTUk3qINEKYDq9hOq7BQ7kQ/HsN5YGXdvi3M
   O7b0dC6fq1D7eABlcoQIbfmMexM2Bf82yN0pseCSabyKDERnSfdMFYNUu
   ZnZk3p474EKYTkRjgEwH4UmIKXMjGvDTX9Hfr9Ok70s4UrseatUVy58Vr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="288510727"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="288510727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:34:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="696832417"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="696832417"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 18:34:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Michal Hocko" <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
References: <20221027065925.476955-1-ying.huang@intel.com>
        <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
        <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
        <8735b8jy9k.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <0d938c9f-c810-b10a-e489-c2b312475c52@amd.com>
        <87tu3oibyr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com>
Date:   Mon, 31 Oct 2022 09:33:49 +0800
In-Reply-To: <07912a0d-eb91-a6ef-2b9d-74593805f29e@amd.com> (Bharata B. Rao's
        message of "Fri, 28 Oct 2022 19:23:33 +0530")
Message-ID: <87leowepz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharata B Rao <bharata@amd.com> writes:

> On 10/28/2022 2:03 PM, Huang, Ying wrote:
>> Bharata B Rao <bharata@amd.com> writes:
>> 
>>> On 10/28/2022 11:16 AM, Huang, Ying wrote:
>>>> If my understanding were correct, you think the latency / bandwidth of
>>>> these NUMA nodes will near each other, but may be different.
>>>>
>>>> Even if the latency / bandwidth of these NUMA nodes isn't exactly same,
>>>> we should deal with that in memory types instead of memory tiers.
>>>> There's only one abstract distance for each memory type.
>>>>
>>>> So, I still believe we will not have many memory tiers with my proposal.
>>>>
>>>> I don't care too much about the exact number, but want to discuss some
>>>> general design choice,
>>>>
>>>> a) Avoid to group multiple memory types into one memory tier by default
>>>>    at most times.
>>>
>>> Do you expect the abstract distances of two different types to be
>>> close enough in real life (like you showed in your example with
>>> CXL - 5000 and PMEM - 5100) that they will get assigned into same tier
>>> most times?
>>>
>>> Are you foreseeing that abstract distance that get mapped by sources
>>> like HMAT would run into this issue?
>> 
>> Only if we set abstract distance chunk size large.  So, I think that
>> it's better to set chunk size as small as possible to avoid potential
>> issue.  What is the downside to set the chunk size small?
>
> I don't see anything in particular. However
>
> - With just two memory types (default_dram_type and dax_slowmem_type
> with adistance values of 576 and 576*5 respectively) defined currently,
> - With no interface yet to set/change adistance value of a memory type,
> - With no defined way to convert the performance characteristics info
> (bw and latency) from sources like HMAT into a adistance value,
>
> I find it a bit difficult to see how a chunk size of 10 against the
> existing 128 could be more useful.

OK.  Maybe we pay too much attention to specific number.  My target
isn't to push this specific RFC into kernel.  I just want to discuss the
design choices with community.

My basic idea is NOT to group memory types into memory tiers via
customizing abstract distance chunk size.  Because that's hard to be
used and implemented.  So far, it appears that nobody objects this.

Then, it's even better to avoid to adjust abstract chunk size in kernel
as much as possible.  This will make the life of the user space
tools/scripts easier.  One solution is to define more than enough
possible tiers under DRAM (we have unlimited number of tiers above
DRAM).

In the upstream implementation, 4 tiers are possible below DRAM.  That's
enough for now.  But in the long run, it may be better to define more.
100 possible tiers below DRAM may be too extreme.  How about define the
abstract distance of DRAM to be 1050 and chunk size to be 100.  Then we
will have 10 possible tiers below DRAM.  That may be more than enough
even in the long run?

Again, the specific number isn't so important for me.  So please suggest
your number if necessary.

Best Regards,
Huang, Ying
