Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B0B66B754
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjAPGMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjAPGMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:12:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC2C140
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673849355; x=1705385355;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Xsc4GUy7+oLMqhOpp6Kb6Rp92S0nxU9kPRmZIpDv7FY=;
  b=dODE6tJm44G6IzbTlGuTNk1ladB4aaUdCFAlu/2jL6LAC9B4qwuJxWE5
   pHxXUJMkAKpTXk6JYnVB3UuqKFZJKvEVmD6lWRxgETLfbhXoFqIX4897F
   OQGWx44w0rVO6YlFAaMe8gJ1wbGhig1vFim6QYdN6EMIiu18eaqScSYsV
   LUSfhj2Wsrg8DHaEw1/iQaHrMehZ9+J0WLELnMnSVwmdV/ABwqEBR6t00
   eTVwAeCOJ6j7HfNWXk2WK09omKcWEUNh88jlXrIPHWVDfRtXdpowjCMW7
   BiaB9IkQH5/BPiEf1MQAiCM/CbOHfMbiQ8CGUiY0GpK4bcorAtuxE8KPe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312246863"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="312246863"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:09:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="652164748"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="652164748"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 22:09:11 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
References: <20230110075327.590514-1-ying.huang@intel.com>
        <Y74WsWCFGh2wFGji@monkey> <Y782h7t10uRVW0RC@monkey>
        <87a62oy5o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y79tTXgEeuzzqFho@monkey>
        <87ilhcrzkr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y8ChvzGVG5Tm9tQQ@monkey>
        <87bkn3rw8v.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <Y8TUE3h/IJySDn11@casper.infradead.org>
Date:   Mon, 16 Jan 2023 14:05:44 +0800
In-Reply-To: <Y8TUE3h/IJySDn11@casper.infradead.org> (Matthew Wilcox's message
        of "Mon, 16 Jan 2023 04:35:31 +0000")
Message-ID: <87tu0rqaiv.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, Jan 13, 2023 at 10:42:08AM +0800, Huang, Ying wrote:
>> +++ b/mm/migrate.c
>> @@ -1187,10 +1187,13 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	int rc;
>>  	int page_was_mapped = 0;
>>  	struct anon_vma *anon_vma = NULL;
>> +	bool is_lru = !__PageMovable(&src->page);
>>  
>>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>  
>>  	rc = move_to_new_folio(dst, src, mode);
>> +	if (!unlikely(is_lru))
>> +		goto out_unlock_both;
>
> This reads a little awkwardly.  Could it be:
>
> 	if (likely(!is_lru))
>
> ... but honestly, I think the polarity here is wrong.  LRU pages tend to
> outnumber !LRU pages, so shouldn't this be:
>
> 	if (unlikely(!is_lru)) {
>
> just like it is in migrate_folio_unmap()?

Yes.  Thank you very much for pointing this out.  Will fix it for the
next version.

Best Regards,
Huang, Ying
