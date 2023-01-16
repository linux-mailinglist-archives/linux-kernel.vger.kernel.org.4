Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA14066BCF2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjAPLbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjAPLbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:31:51 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688DEB76D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:31:48 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NwV9v6HcQzJqkp;
        Mon, 16 Jan 2023 19:27:31 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:31:43 +0800
Message-ID: <f5d5d474-35b7-3dd3-6d06-be6f8f3e1103@huawei.com>
Date:   Mon, 16 Jan 2023 19:31:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 3/7] mm: memory: convert do_cow_fault to use folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-4-wangkefeng.wang@huawei.com>
 <Y8F6ozvZPPlewmC/@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y8F6ozvZPPlewmC/@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/1/13 23:37, Matthew Wilcox wrote:
> On Thu, Jan 12, 2023 at 04:30:02PM +0800, Kefeng Wang wrote:
>> -	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
>> -	if (!vmf->cow_page)
>> +	cow_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address,
>> +				    false);
>> +	if (!cow_folio)
> 
> I have a patch I've been sitting on that converts vmf->cow_page to be
> a folio.  I think this series is well and truly wrecked at this point,
> so let me go back and dig it out; see if it still makes sense.
> 

For now, as vmf->page and vmf->cow_page used in do_cow_page(), it only 
supports cow on a page, and after converting, the folio still is 0 order,

> I'm a bit unsure about it because maybe we want to allocate
> high(ish)-order folios on COW fault, and if we do, then maybe we want
> to align them in some way with the virtual addresses, or the other
> folios in the VMA.  And then we might want to indicate the precise
> page for this page fault rather than have this page fault be the
> start of a multi-order folio.
> 
This means that if high(ish)-order folios/multi-order folio on cow, it
needs additional jobs and precise page for this pagefault, but for 
order-0, the converting is right but could break/mislead future logical? 
not very clear about this part, but let's wait for your patches.



