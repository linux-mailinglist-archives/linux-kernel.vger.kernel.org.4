Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6722D5B95EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIOIG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:06:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77C94EFA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:06:20 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MSqTN2j8pznVJP;
        Thu, 15 Sep 2022 16:03:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 16:06:18 +0800
Subject: Re: [PATCH 09/16] mm/page_alloc: use local variable zone_idx directly
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-10-linmiaohe@huawei.com>
 <YyLV50jxlqq5GKtJ@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <73b9a03a-232e-b327-641f-49bcd2e1bf9b@huawei.com>
Date:   Thu, 15 Sep 2022 16:06:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YyLV50jxlqq5GKtJ@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 15:36, Oscar Salvador wrote:
> On Fri, Sep 09, 2022 at 05:24:44PM +0800, Miaohe Lin wrote:
>> Use local variable zone_idx directly since it holds the exact value of
>> zone_idx(). No functional change intended.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> By the way, zone_idx being "int" should be enough?

Yes, it should be. But zone_idx is used as "unsigned long" around this function,
e.g. __init_zone_device_page expects zone_idx as "unsigned long", so it should be
better to keep it as is ?

> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Many thanks for your review and comment in this series.

Thanks,
Miaohe Lin


> 
>> ---
>>  mm/page_alloc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 94baf33da865..3417232afa45 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6878,7 +6878,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
>>  	unsigned long start = jiffies;
>>  	int nid = pgdat->node_id;
>>  
>> -	if (WARN_ON_ONCE(!pgmap || zone_idx(zone) != ZONE_DEVICE))
>> +	if (WARN_ON_ONCE(!pgmap || zone_idx != ZONE_DEVICE))
>>  		return;
>>  
>>  	/*
>> -- 
>> 2.23.0
>>
> 

