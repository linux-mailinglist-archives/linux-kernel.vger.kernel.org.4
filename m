Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003967FCA7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 04:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjA2D1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 22:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA2D1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 22:27:02 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F81F5DB
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 19:27:00 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P4Gs85W9wz16Mlw;
        Sun, 29 Jan 2023 11:25:00 +0800 (CST)
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 29 Jan 2023 11:26:58 +0800
Message-ID: <d24ef706-1b34-a7d8-3893-aadb9cf19ddf@huawei.com>
Date:   Sun, 29 Jan 2023 11:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH] mm/migrate: Continue to migrate for small pages
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230129025404.1262745-1-chenwandun@huawei.com>
 <875ycqcad0.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <875ycqcad0.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/29 11:01, Huang, Ying wrote:
> Chen Wandun <chenwandun@huawei.com> writes:
>
>> migrate_hugetlbs returns -ENOMEM when no enough huge page,
>> however maybe there are still free small pages, so continue
>> to migrate for small pages.
> Better to replace "page" with "folio", and "small" with "non-hugetlb".
Will do.
>
>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
>> ---
>>   mm/migrate.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index b971edbf32fc..c9d0d2058036 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1939,7 +1939,12 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>   
>>   	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
>>   				     mode, reason, &stats, &ret_folios);
>> -	if (rc_gather < 0)
>> +	/* Maybe there are free small pages, continue to migrate.
> There may be free non-hugetlb folios available, continue to migrate.
will do
>
>> +	 * Nowdays the only negtive return value of migrate_hugetlbs
>> +	 * is -ENOMEM, keep compatible for coming negtive return
>> +	 * value instead of ignore return value.
> This can be moved to patch description.
will do
thanks for your review.

Best Regards.
Wandun
>
>> +	 */
>> +	if (rc_gather < 0 && rc_gather != -ENOMEM)
>>   		goto out;
>>   again:
>>   	nr_pages = 0;
> Best Regards,
> Huang, Ying
> .

