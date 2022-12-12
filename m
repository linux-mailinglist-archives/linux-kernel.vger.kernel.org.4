Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EC649E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiLLLns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiLLLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:43:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50BDEC4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:41:34 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NW0785Sc0zmWfw;
        Mon, 12 Dec 2022 19:40:36 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 19:41:32 +0800
Message-ID: <d7a0165c-39f6-87ce-f2ec-1f670541147a@huawei.com>
Date:   Mon, 12 Dec 2022 19:41:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next v2] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221209021525.196276-1-wangkefeng.wang@huawei.com>
 <20221209072801.193221-1-wangkefeng.wang@huawei.com>
 <342f4d3f-7347-1615-7d63-cbdef4872629@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <342f4d3f-7347-1615-7d63-cbdef4872629@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


On 2022/12/12 10:36, Miaohe Lin wrote:
> On 2022/12/9 15:28, Kefeng Wang wrote:
>> When the kernel copy a page from ksm_might_need_to_copy(), but runs
>> into an uncorrectable error, it will crash since poisoned page is
>> consumed by kernel, this is similar to Copy-on-write poison recovery,
>> When an error is detected during the page copy, return VM_FAULT_HWPOISON,
>> which help us to avoid system crash. Note, memory failure on a KSM
>> page will be skipped, but still call memory_failure_queue() to be
>> consistent with general memory failure process.
...
>   
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 908a529bca12..d479811bc311 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1767,7 +1767,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>   
>   	swapcache = page;
>   	page = ksm_might_need_to_copy(page, vma, addr);
> -	if (unlikely(!page))
> +	if (IS_ERR_OR_NULL(page))
> IMHO, it might be better to install a hwpoison entry here. Or later swapoff ops will trigger
> the uncorrectable error again?
Thanks for you suggestion, will do in v3.
> Thanks,
> Miaohe Lin
>
