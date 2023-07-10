Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23D474CFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjGJIcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGJIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:32:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E118B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 01:32:30 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qzy0X2LTXz1FDnC;
        Mon, 10 Jul 2023 16:31:56 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 16:32:27 +0800
Subject: Re: [PATCH 8/8] mm: memory-failure: fix race window when trying to
 get hugetlb folio
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230708085744.3599311-1-linmiaohe@huawei.com>
 <20230708085744.3599311-9-linmiaohe@huawei.com>
 <20230710075812.GH1686200@ik1-406-35019.vs.sakura.ne.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <74acb109-76cc-3990-c770-8330e343ef54@huawei.com>
Date:   Mon, 10 Jul 2023 16:32:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230710075812.GH1686200@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/10 15:58, Naoya Horiguchi wrote:
> On Sat, Jul 08, 2023 at 04:57:44PM +0800, Miaohe Lin wrote:
>> page_folio() is fetched before calling get_hwpoison_hugetlb_folio()
>> without hugetlb_lock being held. So hugetlb page could be demoted
>> before get_hwpoison_hugetlb_folio() holding hugetlb_lock but after
>> page_folio() is fetched. So get_hwpoison_hugetlb_folio() will hold
>> unexpected extra refcnt of hugetlb folio while leaving demoted page
>> un-refcnted.
> 
> Very nice, thank you for finding the issue.
> 
>>
>> Fixes: 25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 76d88d27cdbe..066bf57f2d22 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1388,8 +1388,14 @@ static int __get_hwpoison_page(struct page *page, unsigned long flags)
>>  	bool hugetlb = false;
>>  
>>  	ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
>> -	if (hugetlb)
>> -		return ret;
>> +	if (hugetlb) {
>> +		if (folio == page_folio(page))
>> +			return ret;
> 
> Some short comment about the race against demotion here is helpful.

Does the below comment makes sense to you?

"
  Make sure hugetlb demotion did not happen from under us.
"

> 
> Anyway, the patch looks good to me.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Many thanks for your review and comment, Naoya.

