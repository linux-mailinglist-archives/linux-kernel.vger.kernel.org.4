Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BADD6497F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLLCgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiLLCgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:36:52 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65ABC97
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:36:51 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NVlyp5XB3zqSPQ;
        Mon, 12 Dec 2022 10:32:34 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Dec 2022 10:36:49 +0800
Subject: Re: [PATCH -next v2] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221209021525.196276-1-wangkefeng.wang@huawei.com>
 <20221209072801.193221-1-wangkefeng.wang@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <342f4d3f-7347-1615-7d63-cbdef4872629@huawei.com>
Date:   Mon, 12 Dec 2022 10:36:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221209072801.193221-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/9 15:28, Kefeng Wang wrote:
> When the kernel copy a page from ksm_might_need_to_copy(), but runs
> into an uncorrectable error, it will crash since poisoned page is
> consumed by kernel, this is similar to Copy-on-write poison recovery,
> When an error is detected during the page copy, return VM_FAULT_HWPOISON,
> which help us to avoid system crash. Note, memory failure on a KSM
> page will be skipped, but still call memory_failure_queue() to be
> consistent with general memory failure process.

Thanks for your patch.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: fix type error
> 
>  mm/ksm.c      | 8 ++++++--
>  mm/memory.c   | 3 +++
>  mm/swapfile.c | 2 +-
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dd02780c387f..83e2f74ae7da 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2629,8 +2629,12 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  		new_page = NULL;
>  	}
>  	if (new_page) {
> -		copy_user_highpage(new_page, page, address, vma);
> -
> +		if (copy_mc_user_highpage(new_page, page, address, vma)) {
> +			put_page(new_page);
> +			new_page = ERR_PTR(-EHWPOISON);
> +			memory_failure_queue(page_to_pfn(page), 0);
> +			return new_page;
> +		}
>  		SetPageDirty(new_page);
>  		__SetPageUptodate(new_page);
>  		__SetPageLocked(new_page);
> diff --git a/mm/memory.c b/mm/memory.c
> index aad226daf41b..5b2c137dfb2a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3840,6 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		if (unlikely(!page)) {
>  			ret = VM_FAULT_OOM;
>  			goto out_page;
> +		} else if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
> +			ret = VM_FAULT_HWPOISON;
> +			goto out_page;
>  		}
>  		folio = page_folio(page);
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 908a529bca12..d479811bc311 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1767,7 +1767,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  
>  	swapcache = page;
>  	page = ksm_might_need_to_copy(page, vma, addr);
> -	if (unlikely(!page))
> +	if (IS_ERR_OR_NULL(page))

IMHO, it might be better to install a hwpoison entry here. Or later swapoff ops will trigger
the uncorrectable error again?

Thanks,
Miaohe Lin

