Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9998A69761F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 07:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjBOGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 01:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBOGIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 01:08:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E42B09C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676441315; x=1707977315;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=uhnKNKKFJt0NMaYqOVx/5gRShImdArXlDjR6bBGJCDM=;
  b=d+KfucoejpzxVpuRwVhdggAvqUHwzDBd1VB7IGop/xhURl6fmtUmibkO
   o8FqdRq4LNNHodiLQ0KDJGCRcNVJC32yCZEbtdajuU1/GDIho60AV17Fq
   5LGG4ntkO3EBGXSvrwrwE8T+CTDUmAb6xbm13UL2D18Lb/NS3JHHl8HCz
   DQZakJoHHHFUEiO9eIIyjr1df5KUr5x/AbhN4lhaayRtWyNEmGQoajkkU
   IZe0AM4EosVfK+xzPrFglDrYGK/WitUfzW5MuPWeSlvSsVtOqII435/q5
   8dQGXJ6lIK6l5A/CinlCkioUCEeECt/MDCD9V8jZOWW0EgCyZct0B9kGx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="331356650"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="331356650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:08:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="701906552"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="701906552"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 22:08:31 -0800
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
Date:   Wed, 15 Feb 2023 14:07:42 +0800
In-Reply-To: <1547d291-1512-faae-aba5-0f84c3502be4@amd.com> (Bharata B. Rao's
        message of "Tue, 14 Feb 2023 10:25:16 +0530")
Message-ID: <87lekz8nrl.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On 13-Feb-23 12:00 PM, Huang, Ying wrote:
>>> I have a microbenchmark where two sets of threads bound to two 
>>> NUMA nodes access the two different halves of memory which is
>>> initially allocated on the 1st node.
>>>
>>> On a two node Zen4 system, with 64 threads in each set accessing
>>> 8G of memory each from the initial allocation of 16G, I see that
>>> IBS driven NUMA balancing (i,e., this patchset) takes 50% less time
>>> to complete a fixed number of memory accesses. This could well
>>> be the best case and real workloads/benchmarks may not get this much
>>> uplift, but it does show the potential gain to be had.
>> 
>> Can you find a way to show the overhead of the original implementation
>> and your method?  Then we can compare between them?  Because you think
>> the improvement comes from the reduced overhead.
>
> Sure, will measure the overhead.
>
>> 
>> I also have interest in the pages migration throughput per second during
>> the test, because I suspect your method can migrate pages faster.
>
> I have some data on pages migrated over time for the benchmark I mentioned
> above.
>
>                                                                                 
>                                 Pages migrated vs Time(s)                       
>     2500000 +---------------------------------------------------------------+   
>             |       +       +       +       +       +       +       +       |   
>             |                                               Default ******* |   
>             |                                                   IBS ####### |   
>             |                                                               |   
>             |                                   ****************************|   
>             |                                  *                            |   
>     2000000 |-+                               *                           +-|   
>             |                                *                              |   
>             |                              **                               |   
>  P          |                             *  ##                             |   
>  a          |                            *###                               |   
>  g          |                          **#                                  |   
>  e  1500000 |-+                       *##                                 +-|   
>  s          |                        ##                                     |   
>             |                       #                                       |   
>  m          |                      #                                        |   
>  i          |                    *#                                         |   
>  g          |                   *#                                          |   
>  r          |                  ##                                           |   
>  a  1000000 |-+               #                                           +-|   
>  t          |                #                                              |   
>  e          |               #*                                              |   
>  d          |              #*                                               |   
>             |             # *                                               |   
>             |            # *                                                |   
>      500000 |-+         #  *                                              +-|   
>             |          #  *                                                 |   
>             |         #   *                                                 |   
>             |        #   *                                                  |   
>             |      ##    *                                                  |   
>             |     #     *                                                   |   
>             |    #  +  *    +       +       +       +       +       +       |   
>           0 +---------------------------------------------------------------+   
>             0       20      40      60      80     100     120     140     160  
>                                         Time (s)                                
>
> So acting upon the relevant accesses early enough seem to result in
> pages migrating faster in the beginning.

One way to prove this is to output the benchmark performance
periodically.  So we can find how the benchmark score change over time.

Best Regards,
Huang, Ying

> Here is the actual data in case the above ascii graph gets jumbled up:
>
> numa_pages_migrated vs time in seconds
> ======================================
>
> Time	Default		IBS
> ---------------------------
> 5	2639		511
> 10	2639		17724
> 15	2699		134632
> 20	2699		253485
> 25	2699		386296
> 30	159805		524651
> 35	450678		667622
> 40	741762		811603
> 45	971848		950691
> 50	1108475		1084537
> 55	1246229		1215265
> 60	1385920		1336521
> 65	1508354		1446950
> 70	1624068		1544890
> 75	1739311		1629162
> 80	1854639		1700068
> 85	1979906		1759025
> 90	2099857		<end>
> 95	2099857
> 100	2099857
> 105	2099859
> 110	2099859
> 115	2099859
> 120	2099859
> 125	2099859
> 130	2099859
> 135	2099859
> 140	2099859
> 145	2099859
> 150	2099859
> 155	2099859
> 160	2099859
>
> Regards,
> Bharata.
