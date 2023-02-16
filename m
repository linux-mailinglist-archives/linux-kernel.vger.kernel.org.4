Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC83699246
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBPKxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBPKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:53:40 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E010F7EFD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:53:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VboRNRC_1676544813;
Received: from 30.97.48.85(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VboRNRC_1676544813)
          by smtp.aliyun-inc.com;
          Thu, 16 Feb 2023 18:53:34 +0800
Message-ID: <af96ecf7-3039-784d-c276-5fc6b72611c4@linux.alibaba.com>
Date:   Thu, 16 Feb 2023 18:53:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: return nothing from
 do_migrate_range()
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230215230300.61125-1-sj@kernel.org>
 <20230215230300.61125-2-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230215230300.61125-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 7:02 AM, SeongJae Park wrote:
> Return value mechanism of do_migrate_range() is not very simple, while
> no caller of the function checks the return value.  Make the function
> return nothing to be more simple.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/memory_hotplug.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bcb0dc41c2f2..6c615ba1a5c7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1620,8 +1620,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>   	return 0;
>   }
>   
> -static int
> -do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
> +static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   {
>   	unsigned long pfn;
>   	struct page *page, *head;
> @@ -1721,8 +1720,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>   			putback_movable_pages(&source);
>   		}
>   	}
> -
> -	return ret;

Nit: while we are at it, can we also remove the "TODO" comment in 
offline_pages()?

ret = scan_movable_pages(pfn, end_pfn, &pfn);
if (!ret) {
	/*
	 * TODO: fatal migration failures should bail
	 * out
	 */
	do_migrate_range(pfn, end_pfn);
}

With David's comments:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
