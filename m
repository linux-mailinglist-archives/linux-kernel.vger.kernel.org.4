Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF36DB8E2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDHEmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDHEme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:42:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44CBB8E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 21:42:32 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PtjHB4F8FzrZ6v;
        Sat,  8 Apr 2023 12:41:10 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 8 Apr 2023 12:42:28 +0800
Message-ID: <7a127da3-9a53-962c-1096-562a03e39864@huawei.com>
Date:   Sat, 8 Apr 2023 12:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <sidhartha.kumar@oracle.com>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-2-zhangpeng362@huawei.com>
 <20230406213127.GB14244@monkey>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230406213127.GB14244@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 5:31, Mike Kravetz wrote:

> On 03/31/23 17:39, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Call vma_alloc_folio() directly instead of alloc_page_vma() and convert
>> page_kaddr to kaddr in mfill_atomic_pte_copy(). Removes several calls to
>> compound_head().
>>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/userfaultfd.c | 33 +++++++++++++++++----------------
>>   1 file changed, 17 insertions(+), 16 deletions(-)
> Looks good,
>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>
>>   	} else {
>> -		page = *pagep;
>> +		folio = page_folio(*pagep);
>> +		VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>   		*pagep = NULL;
>>   	}
> However, I am still unsure about the reason for adding the VM_BUG_ON_FOLIO
> here.

VM_BUG_ON_FOLIO was added to ensure that folio is a single-page folio.
However, the folio corresponding to the foliop is always a single-page
folio. We just don't need this check. I'll drop VM_BUG_ON_FOLIO.

Thanks for your review.

Best Regards,
Peng

