Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56083631854
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKUByr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 20:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKUByp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 20:54:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146825CA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 17:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668995682; x=1700531682;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QpFKF7fDLr8Ams9bU7P3h3OfOCC05+T00uayr9oKtx8=;
  b=FNk6xaxPoo/30Tky+RsHbz09HEq8kv4DIzWlG6qqv6QJb/zcubz7hjoH
   5a+ScE1x3HvX/cz1wNWCn+ffuNcMDSkgt16qjjf6kDP2+R7aycz6CL05B
   jjcRtPojXwPO3Ru+UeoP/qgrkMaYXtu1utAIoo0IElRxXZcY4jJiUR9+h
   rNNA9YkU4MSNXI77mQQB5sr/hwisPVhCSfNonxM8H5t3M8Mn1GUF7Dspo
   KrWbJEfyLBapBkH+8e9HT4XIkt/IirfHZDsCMWO8znleBAkTmn0/xGC28
   unnQGCABZMt6QLCqafgmKnNHAwe6TbNrp95DkUOOvDIyd60OlUgZvdsp9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="300997848"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="300997848"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 17:54:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="746716085"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="746716085"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 17:54:35 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chen Wandun <chenwandun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     <hugh@veritas.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, <xialonglong1@huawei.com>
Subject: Re: [RFC PATCH] swapfile: fix soft lockup in scan_swap_map_slots
References: <20221118133850.3360369-1-chenwandun@huawei.com>
        <20221118132741.aaf6f9081b5a1018cc9a5402@linux-foundation.org>
Date:   Mon, 21 Nov 2022 09:53:35 +0800
In-Reply-To: <20221118132741.aaf6f9081b5a1018cc9a5402@linux-foundation.org>
        (Andrew Morton's message of "Fri, 18 Nov 2022 13:27:41 -0800")
Message-ID: <87ilj9ul7k.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 18 Nov 2022 21:38:50 +0800 Chen Wandun <chenwandun@huawei.com> wrote:
>
>> A soft lockup occur in scan free swap slot by constructing
>> huge memory pressure.
>> The test scenario is: 64 CPU cores, 64GB memory, and 28
>> zram devices, the disksize of each zram device is 50MB.
>> 
>> LATENCY_LIMIT is used to prevent soft lockup in function
>> scan_swap_map_slots, but the real loop number would more
>> than LATENCY_LIMIT because of "goto checks and goto scan"
>> repeatly without decrease of latency limit.
>> 
>> In order to fix it, move decrease latency_ration code in advance.
>> 
>> There is also a suspicious place that will cause soft lockup in
>> function get_swap_pages, in this function, the "goto start_over"
>> may result in continuous scanning of swap partition, if there is
>> no cond_sched in scan_swap_map_slots, it would cause soft lockup
>> (I am not sure about this).
>> 
>> ...
>>
>
> Looks sensible.

Yes.  LGTM.

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -972,23 +972,23 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>  scan:
>>  	spin_unlock(&si->lock);
>>  	while (++offset <= READ_ONCE(si->highest_bit)) {
>> -		if (swap_offset_available_and_locked(si, offset))
>> -			goto checks;
>>  		if (unlikely(--latency_ration < 0)) {
>>  			cond_resched();
>>  			latency_ration = LATENCY_LIMIT;
>>  			scanned_many = true;
>>  		}
>> +		if (swap_offset_available_and_locked(si, offset))
>> +			goto checks;
>>  	}
>>  	offset = si->lowest_bit;
>>  	while (offset < scan_base) {
>> -		if (swap_offset_available_and_locked(si, offset))
>> -			goto checks;
>>  		if (unlikely(--latency_ration < 0)) {
>>  			cond_resched();
>>  			latency_ration = LATENCY_LIMIT;
>>  			scanned_many = true;
>>  		}
>> +		if (swap_offset_available_and_locked(si, offset))
>> +			goto checks;
>>  		offset++;
>>  	}
>>  	spin_lock(&si->lock);
>
> But this does somewhat alter the `scanned_many' logic.  We'll now set
> 'scanned_many` earlier.  What are the effects of this?
>
> The ed43af10975eef7e changelog outlines tests which could be performed
> to ensure we aren't regressing from this.

Per my understanding, this will not influence `scanned_many` logic
much.  Because `scanned_many` flag will be set just a little earlier
(one less slot).

Best Regards,
Huang, Ying
