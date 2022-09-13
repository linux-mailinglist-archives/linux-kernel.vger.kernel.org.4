Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4687E5B685C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiIMHEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIMHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:04:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E0FF44
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:04:38 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MRZ9h4JQ0zkWpy;
        Tue, 13 Sep 2022 15:00:40 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 15:04:36 +0800
Subject: Re: [PATCH 12/16] mm/page_alloc: use helper macro SZ_1{K,M}
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
CC:     <akpm@linux-foundation.org>, <osalvador@suse.de>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-13-linmiaohe@huawei.com>
 <f83025e2-d516-72f2-7053-4c5f9626dcf0@redhat.com>
 <YxuXtL83Z9NPj5uR@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <eb1a4170-34e2-2db7-26a1-448e06f3a58b@huawei.com>
Date:   Tue, 13 Sep 2022 15:04:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YxuXtL83Z9NPj5uR@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/10 3:44, Matthew Wilcox wrote:
> On Fri, Sep 09, 2022 at 01:34:52PM +0200, David Hildenbrand wrote:
>> On 09.09.22 11:24, Miaohe Lin wrote:
>>> @@ -9055,7 +9055,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>>>   		/* It isn't necessary when PAGE_SIZE >= 1MB */
>>
>> Huh, how could we ever have that. Smells like dead code.
>>
>>>   		if (PAGE_SHIFT < 20)
>>
>> What about adjusting that as well? The it exactly matches the comment
>>
>> if (PAGE_SIZE >= SZ_1M)

Looks good. Will do it in next version.

>>
>>> -			numentries = round_up(numentries, (1<<20)/PAGE_SIZE);
>>> +			numentries = round_up(numentries, SZ_1M / PAGE_SIZE);
> 
> The git history provides some clues here.  See a7e833182a92.
> But we do have an architecture which has ...
> 
> #ifdef CONFIG_PAGE_SIZE_1MB
> #define PAGE_SHIFT 20
> #define HEXAGON_L1_PTE_SIZE __HVM_PDE_S_1MB
> #endif
> 
> I don't think it's an especially common config.

Maybe commit a7e833182a92 fixed a theoretical bug. But IMHO, it might be better to keep the code even
if no architecture defines PAGE_SIZE >= 1MB. These codes would be eliminated at compiling time. And
once there're architectures with PAGE_SIZE >= 1MB, we still work. Any thoughts? Thanks both.

Thanks,
Miaohe Lin

