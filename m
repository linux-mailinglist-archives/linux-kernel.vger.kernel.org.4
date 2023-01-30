Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019DF68034A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 01:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjA3A1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 19:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3A1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 19:27:43 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A521DBBF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 16:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675038461; x=1706574461;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=KzFBc20kahb9wi4J9Tti65MZDEEv3GXOS2/dFTGZ8tc=;
  b=bOxG3y/UbF+E1tWSkdXhlzw1aXzmdU2ywTUMmHhkeurD82XzUax4T2vn
   b9uy0RxEP2to4/FTT3FOIZvYYI+jG5DfTR8q6EcsynC6nA97bISH2/A/L
   xUzWJisyeL6ZpIC/NFsX+IuZYYZEA/s/L2hEDKDx7mrRgEXmAKlCPSU24
   CZH6F6lK0JqV57ZZF4wQS2W9u79Vr8nrwFBqN4/QpWNO2svwjIAeWjA1X
   nI9xxw3CYBwPe8lf/hrQuIMKVKIli/NLZuZIyJjVGo5w8/YBO2kCrNSLe
   eW1xDybYktSJC/FDXq5uYBZ8Ad98bfxBgJtY7ct9aeYYw/Pm1I8k1NI+P
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="392005390"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="392005390"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:27:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="663915024"
X-IronPort-AV: E=Sophos;i="5.97,256,1669104000"; 
   d="scan'208";a="663915024"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:27:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Longlong Xia <xialonglong1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH] mm/swapfile: add cond_resched() in get_swap_pages()
References: <20230128094757.1060525-1-xialonglong1@huawei.com>
        <20230129130320.7e2e4445ecc4b172c61c7b9c@linux-foundation.org>
Date:   Mon, 30 Jan 2023 08:26:41 +0800
In-Reply-To: <20230129130320.7e2e4445ecc4b172c61c7b9c@linux-foundation.org>
        (Andrew Morton's message of "Sun, 29 Jan 2023 13:03:20 -0800")
Message-ID: <87wn54c1fi.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Sat, 28 Jan 2023 09:47:57 +0000 Longlong Xia <xialonglong1@huawei.com> wrote:
>
>> The softlockup still occurs in get_swap_pages() under memory pressure.
>> 64 CPU cores, 64GB memory, and 28 zram devices, the disksize of each
>> zram device is 50MB with same priority as si. Use the stress-ng tool
>> to increase memory pressure, causing the system to oom frequently.
>> 
>> The plist_for_each_entry_safe() loops in get_swap_pages() could reach
>> tens of thousands of times to find available space (extreme case:
>> cond_resched() is not called in scan_swap_map_slots()). Let's add
>> cond_resched() into get_swap_pages() when failed to find available
>> space to avoid softlockup.
>> 
>> ...
>>
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -1100,6 +1100,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>>  			goto check_out;
>>  		pr_debug("scan_swap_map of si %d failed to find offset\n",
>>  			si->type);
>> +		cond_resched();
>>  
>>  		spin_lock(&swap_avail_lock);
>>  nextsi:
>
> This must be pretty rare?  My googling for "scan_swap_map of si %d
> failed to find offset" turns up zero reports, but I guess few people
> enable pr_debug.
>
> I wonder if we should remove that pr_debug().  I mean, it's known that
> this happens, what value does the printk add?

Sounds reasonable to me.  And if we want to debug, we can use bpf too.

> I'm thinking this fix should be backported into -stable kernels.

Best Regards,
Huang, Ying
