Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76F6AB435
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 02:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFBMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 20:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjCFBMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 20:12:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5388DBE6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 17:12:41 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PVL8L1x7gzSkgG;
        Mon,  6 Mar 2023 09:09:38 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 6 Mar 2023 09:12:39 +0800
Message-ID: <b3eff456-4c3d-3908-178f-4d9d6d4b23c7@huawei.com>
Date:   Mon, 6 Mar 2023 09:12:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/3] mm/damon/paddr: minor refactor of
 damon_pa_mark_accessed_or_deactivate()
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <damon@lists.linux.dev>
References: <20230303183722.113464-1-sj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230303183722.113464-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/4 2:37, SeongJae Park wrote:
> On Fri, 3 Mar 2023 18:26:33 +0000 SeongJae Park <sj@kernel.org> wrote:
> 
>> On Fri, 3 Mar 2023 16:43:43 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>> Omit one line by unified folio_put(), and make code more clear.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>   mm/damon/paddr.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
>>> index 2ef9db0189ca..6930ebf3667c 100644
>>> --- a/mm/damon/paddr.c
>>> +++ b/mm/damon/paddr.c
>>> @@ -266,17 +266,16 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>>>   		if (!folio)
>>>   			continue;
>>>   
>>> -		if (damos_pa_filter_out(s, folio)) {
>>> -			folio_put(folio);
>>> -			continue;
>>> -		}
>>> +		if (damos_pa_filter_out(s, folio))
>>> +			goto put_folio;
>>>   
>>>   		if (mark_accessed)
>>>   			folio_mark_accessed(folio);
>>>   		else
>>>   			folio_deactivate(folio);
>>> -		folio_put(folio);
>>>   		applied += folio_nr_pages(folio);
>>> +put_folio:
>>> +		folio_put(folio);
>>
>> I think this change is ok, but shouldn't the 'folio_put()' have called before
> 
> s/before/after/
> 
>> 'folio_nr_pages()' anyway?  If so, could we make the change as a separate fix
>> first, and then make this change, so that it can be easily applied to relevant
>> stable kernels?

Yes, seem to previous one.
>>
>>
>> Thanks,
>> SJ
>>
>>>   	}
>>>   	return applied * PAGE_SIZE;
>>>   }
>>> -- 
>>> 2.35.3
>>>
>>>
