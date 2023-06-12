Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180BE72B50D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjFLBIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLBIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:08:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6D12D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 18:08:47 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QfYQY1B0qzLq8l;
        Mon, 12 Jun 2023 09:05:41 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 09:08:44 +0800
Message-ID: <6a72d06d-4570-864c-ee3f-12edd9458f03@huawei.com>
Date:   Mon, 12 Jun 2023 09:08:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] mm: kill [add|del]_page_to_lru_list()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230609013901.79250-1-wangkefeng.wang@huawei.com>
 <ZINe7xJPI3s6HJG4@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZINe7xJPI3s6HJG4@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/10 1:18, Matthew Wilcox wrote:
> On Fri, Jun 09, 2023 at 09:39:01AM +0800, Kefeng Wang wrote:
>> Directly call lruvec_del_folio(), and drop unused page interfaces.
> 
> Convert isolate_migratepages_block() to actually use folios and
> then we can kill the interfaces.
> 
>> +++ b/mm/compaction.c
>> @@ -1145,7 +1145,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			low_pfn += compound_nr(page) - 1;
>>   
>>   		/* Successfully isolated */
>> -		del_page_from_lru_list(page, lruvec);
>> +		lruvec_del_folio(lruvec, page_folio(page));
> 
> This kind of thing is not encouraged.  It's just churn and gets in
> the way of actual conversions.

Sure, thanks for your suggestion, will convert 
isolate_migratepages_block() firstly.
> 
