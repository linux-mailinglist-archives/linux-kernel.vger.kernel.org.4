Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E2066BC7B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAPLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAPLJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:09:55 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004D6A6B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:09:24 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NwTlL2DT2zJrx8;
        Mon, 16 Jan 2023 19:07:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:09:20 +0800
Message-ID: <6f1c8530-621c-c018-780f-60beb9054a7b@huawei.com>
Date:   Mon, 16 Jan 2023 19:09:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 1/7] mm: huge_memory: make
 __do_huge_pmd_anonymous_page() to take a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-2-wangkefeng.wang@huawei.com>
 <Y8Fp4UBvO/i8/PYf@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y8Fp4UBvO/i8/PYf@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/13 22:25, Matthew Wilcox wrote:
> On Thu, Jan 12, 2023 at 04:30:00PM +0800, Kefeng Wang wrote:
>> Let's __do_huge_pmd_anonymous_page() take a folio and convert related
>> functions to use folios.
> 
> No, this is actively wrong!  Andrew, please drop this patch.
> 
> If we want to support folio sizes larger than PMD size (and I think we
> do), we need to be able to specify precisely which page in the folio
> is to be stored at this PTE.  The *interface* must remain struct page.
> We can convert from page to folio within the function, but we *MUST NOT*
> go the other way.

Got it,

> 
>>   static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -			struct page *page, gfp_t gfp)
>> +			struct folio *folio, gfp_t gfp)
>>   {
>>   	struct vm_area_struct *vma = vmf->vma;
>> +	struct page *page = &folio->page;
> 
> ... ie this is bad and wrong.
> 
>> @@ -834,7 +835,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>   		count_vm_event(THP_FAULT_FALLBACK);
>>   		return VM_FAULT_FALLBACK;
>>   	}
>> -	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
>> +	return __do_huge_pmd_anonymous_page(vmf, folio, gfp);
>>   }
>>   
>>   static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> 
> A reasonable person might ask "But Matthew, you allocated a folio here,
> then you're converting back to a struct page to call
> __do_huge_pmd_anonymous_page() so isn't this a sensible patch?"

and this is why I change the parameter from page to folio(no need to go 
back and forth between page and folio),
> 
> And I would say "still no".  This is a question of interfaces, and
> even though __do_huge_pmd_anonymous_page() is static and has precisely
> one caller today that always allocates a folio of precisely PMD size,
> I suspect it will need to be more visible in the future and the
> conversion of the interface from page to folio misleads people.
ok, will keep page for __do_huge_pmd_anonymous_page().
> 
