Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09233747B45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGEBoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGEBoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:44:02 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85199DD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 18:44:01 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qwj9d3f83zqTV4;
        Wed,  5 Jul 2023 09:43:33 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 09:43:58 +0800
Subject: Re: [PATCH] mm: page_alloc: avoid false page outside zone error info
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230704111823.940331-1-linmiaohe@huawei.com>
 <ZKQM2lg7524dIAQl@casper.infradead.org>
 <feb41501-163a-58d6-1996-8d6ebc9d800e@huawei.com>
 <20230704093819.48443ca7789043a640c8a07a@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ef553b86-dd65-e64c-8c2e-fb4a5451e7c4@huawei.com>
Date:   Wed, 5 Jul 2023 09:43:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230704093819.48443ca7789043a640c8a07a@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/5 0:38, Andrew Morton wrote:
> On Tue, 4 Jul 2023 20:36:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2023/7/4 20:13, Matthew Wilcox wrote:
>>> On Tue, Jul 04, 2023 at 07:18:23PM +0800, Miaohe Lin wrote:
>>>> @@ -470,6 +470,8 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
>>>>  		sp = zone->spanned_pages;
>>>>  		if (!zone_spans_pfn(zone, pfn))
>>>>  			ret = 1;
>>>> +		else
>>>> +			ret = 0;
>>>
>>> Surely 'ret = zone_spans_pfn(zone, pfn);' ?
>>
>> Do you mean 'ret = !zone_spans_pfn(zone, pfn);'?  This format looks fine to me.
>>
>>>
>>> Also, did you spot this by inspection or do you have a test-case or bug
>>> report?  Should this have a Fixes: tag?
>>
>> This is from code inspection. The race window should be really small thus hard to trigger
>> in real world. And yes, it seems Fixes tag is a really ancient commit:
>>
>> 	Fixes: bdc8cb984576 ("[PATCH] memory hotplug locking: zone span seqlock")
>>
> 
> Thanks.  I updated the changelog:
> 
> : If pfn is outside zone boundaries in the first round, ret will be set to
> : 1.  But if pfn is changed to inside the zone boundaries in zone span
> : seqretry path, ret is still set to 1 leading to false page outside zone
> : error info.
> : 
> : This is from code inspection.  The race window should be really small thus
> : hard to trigger in real world.
> : 
> : Link: https://lkml.kernel.org/r/20230704111823.940331-1-linmiaohe@huawei.com
> : Fixes: bdc8cb984576 ("[PATCH] memory hotplug locking: zone span seqlock")
> 
> and I made the change suggested by Matthew:
> 
> --- a/mm/page_alloc.c~mm-page_alloc-avoid-false-page-outside-zone-error-info-fix
> +++ a/mm/page_alloc.c
> @@ -468,10 +468,7 @@ static int page_outside_zone_boundaries(
>  		seq = zone_span_seqbegin(zone);
>  		start_pfn = zone->zone_start_pfn;
>  		sp = zone->spanned_pages;
> -		if (!zone_spans_pfn(zone, pfn))
> -			ret = 1;
> -		else
> -			ret = 0;
> +		ret = !zone_spans_pfn(zone, pfn);
>  	} while (zone_span_seqretry(zone, seq));

These changes look good to me. Thanks for doing this.

