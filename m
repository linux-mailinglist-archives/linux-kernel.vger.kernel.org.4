Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0553E7407DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjF1B4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 21:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjF1B4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:56:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460422111
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:56:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QrPkp6pbxzlWKQ;
        Wed, 28 Jun 2023 09:53:54 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 09:56:38 +0800
Subject: Re: [PATCH] mm: memory-failure: fix unexpected return value in
 soft_offline_page()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230627112808.1275241-1-linmiaohe@huawei.com>
 <20230627123046.ef7e791208214bbfecd71e42@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dc6f687f-926f-effd-338f-32edc7508479@huawei.com>
Date:   Wed, 28 Jun 2023 09:56:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230627123046.ef7e791208214bbfecd71e42@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2023/6/28 3:30, Andrew Morton wrote:
> On Tue, 27 Jun 2023 19:28:08 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> When page_handle_poison() fails to handle the hugepage or free page in
>> retry path, soft_offline_page() will return 0 while -EBUSY is expected
>> in this case.
> 
> What are the user visible effects of the bug?

The user will think soft_offline_page succeeds while it failed in fact. So user
will not try again later in this case.

> 
>> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
>>
>> ...
>>
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2737,10 +2737,13 @@ int soft_offline_page(unsigned long pfn, int flags)
>>  	if (ret > 0) {
>>  		ret = soft_offline_in_use_page(page);
>>  	} else if (ret == 0) {
>> -		if (!page_handle_poison(page, true, false) && try_again) {
>> -			try_again = false;
>> -			flags &= ~MF_COUNT_INCREASED;
>> -			goto retry;
>> +		if (!page_handle_poison(page, true, false)) {
>> +			if (try_again) {
>> +				try_again = false;
>> +				flags &= ~MF_COUNT_INCREASED;
>> +				goto retry;
>> +			}
>> +			ret = -EBUSY;
>>  		}
>>  	}
> .
> 

