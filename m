Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495916AB7E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCFIEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCFIEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:04:09 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D38A54
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:03:44 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VdCw8xX_1678089820;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdCw8xX_1678089820)
          by smtp.aliyun-inc.com;
          Mon, 06 Mar 2023 16:03:41 +0800
Message-ID: <ca2bb7fb-5cae-e399-f8a9-3a5d0fa913f0@linux.alibaba.com>
Date:   Mon, 6 Mar 2023 16:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] mm/page_alloc: avoid high-order page allocation warn with
 __GFP_NOFAIL
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20230305053035.1911-1-hsiangkao@linux.alibaba.com>
 <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZAWbjIJCarmxGa8k@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/6 15:51, Michal Hocko wrote:
> [Cc couple of more people recently involved with vmalloc code]
> 
> On Sun 05-03-23 13:30:35, Gao Xiang wrote:
>> My knowledge of this is somewhat limited, however, since vmalloc already
>> supported __GFP_NOFAIL in commit 9376130c390a ("mm/vmalloc: add
>> support for __GFP_NOFAIL").  __GFP_NOFAIL could trigger the following
>> stack and allocate high-order pages when CONFIG_HAVE_ARCH_HUGE_VMALLOC
>> is enabled:
>>
>>   __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
>>   alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
>>   vm_area_alloc_pages mm/vmalloc.c:2989 [inline]
>>
>>   __vmalloc_area_node mm/vmalloc.c:3057 [inline]
>>   __vmalloc_node_range+0x978/0x13c0 mm/vmalloc.c:3227
>>   kvmalloc_node+0x156/0x1a0 mm/util.c:606
>>   kvmalloc include/linux/slab.h:737 [inline]
>>   kvmalloc_array include/linux/slab.h:755 [inline]
>>   kvcalloc include/linux/slab.h:760 [inline]
>>   (codebase: Linux 6.2-rc2)
>>
>> Don't warn such cases since high-order pages with __GFP_NOFAIL is
>> somewhat legel.
> 
> OK, this is definitely a bug and it seems my 9376130c390a was
> incomplete because it hasn't covered the high order case. Not sure how
> that happened but removing the warning is not the right thing to do
> here. The higher order allocation is an optimization rather than a must.
> So it is perfectly fine to fail that allocation and retry rather than
> go into a very expensive and potentially impossible higher order
> allocation that must not fail.
> 
> The proper fix should look like this unless I am missing something. I
> would appreciate another pair of eyes on this because I am not fully
> familiar with the high order optimization part much.

I'm fine with the fix. Although I'm not familiar with such vmalloc
allocation, I thought about this possibility as well.

The original issue was:
https://lore.kernel.org/r/0000000000007796bd05f1852ec2@google.com

which I used kvcalloc with __GFP_NOFAIL but it warned, and I made
a fix (which now seems wrong) to use kcalloc() but it now warns
the same:
https://lore.kernel.org/r/00000000000072eb6505f376dd4b@google.com

And I then realized it's a bug in kvmalloc() with __GFP_NOFAIL...

Thanks,
Gao Xiang

> 
> Thanks!
> ---
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ef910bf349e1..a8aa2765618a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2883,6 +2883,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   		unsigned int order, unsigned int nr_pages, struct page **pages)
>   {
>   	unsigned int nr_allocated = 0;
> +	gfp_t alloc_gfp = gfp;
> +	bool nofail = false;
>   	struct page *page;
>   	int i;
>   
> @@ -2931,20 +2933,30 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>   			if (nr != nr_pages_request)
>   				break;
>   		}
> +	} else {
> +		alloc_gfp &= ~__GFP_NOFAIL;
> +		nofail = true;
>   	}
>   
>   	/* High-order pages or fallback path if "bulk" fails. */
> -
>   	while (nr_allocated < nr_pages) {
>   		if (fatal_signal_pending(current))
>   			break;
>   
>   		if (nid == NUMA_NO_NODE)
> -			page = alloc_pages(gfp, order);
> +			page = alloc_pages(alloc_gfp, order);
>   		else
> -			page = alloc_pages_node(nid, gfp, order);
> -		if (unlikely(!page))
> -			break;
> +			page = alloc_pages_node(nid, alloc_gfp, order);
> +		if (unlikely(!page)) {
> +			if (!nofail)
> +				break;
> +
> +			/* fall back to the zero order allocations */
> +			alloc_gfp |= __GFP_NOFAIL;
> +			order = 0;
> +			continue;
> +		}
> +
>   		/*
>   		 * Higher order allocations must be able to be treated as
>   		 * indepdenent small pages by callers (as they can with
