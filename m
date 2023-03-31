Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9196D1CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjCaJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjCaJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:38:47 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9CC1F78C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:38:26 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PnwDV1MH4zrVZj;
        Fri, 31 Mar 2023 17:37:14 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 17:38:23 +0800
Message-ID: <4ada1fa1-4d03-50bb-dfd7-5f0d1b08cbfd@huawei.com>
Date:   Fri, 31 Mar 2023 17:38:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 1/6] userfaultfd: convert mfill_atomic_pte_copy() to
 use a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-2-zhangpeng362@huawei.com>
 <765d450c-2ff6-1420-b94f-528d56bffee4@oracle.com>
 <ZCXOv9rz8GCrpbMk@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZCXOv9rz8GCrpbMk@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 2:02, Matthew Wilcox wrote:

> On Thu, Mar 30, 2023 at 10:02:52AM -0700, Sidhartha Kumar wrote:
>> On 3/30/23 6:40 AM, Peng Zhang wrote:
>>> From: ZhangPeng <zhangpeng362@huawei.com>
>>>
>>> Call vma_alloc_folio() directly instead of alloc_page_vma(). Add an
>>> assertion that this is a single-page folio and removes several calls to
>>> compound_head().
> There's no added assertion in this patch any more, so I'd drop that
> part of the description.

Thanks. I'll update this description.

>>>    	if (!*pagep) {
>>>    		ret = -ENOMEM;
>>> -		page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, dst_vma, dst_addr);
>>> -		if (!page)
>>> +		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma, dst_addr, false);
>>> +		if (!folio)
>>>    			goto out;
>>> -		page_kaddr = kmap_local_page(page);
>>> +		page_kaddr = kmap_local_folio(folio, 0);
>> Should this variable name be kept as page_kaddr or should it be changed to
>> something like folio_kaddr? kmap_local_folio() returns page_address(), so
>> maybe page_kaddr is better.
> I'd just call it 'kaddr'.  Or 'addr'.

Agreed. I'll change page_kaddr to kaddr.

Thanks for your review.

Best Regards,
Peng

