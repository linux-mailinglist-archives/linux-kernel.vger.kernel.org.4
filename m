Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB3745858
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGCJ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGCJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:29:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA0C196
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:29:18 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QvgX853mnzMqHY;
        Mon,  3 Jul 2023 17:26:00 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 17:29:13 +0800
Message-ID: <860b4135-2d00-6864-df3f-e04689ec12e2@huawei.com>
Date:   Mon, 3 Jul 2023 17:29:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] mm/memory: convert do_page_mkwrite() to use folios
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)
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

On 2023/7/3 13:58, Sidhartha Kumar wrote:

> Saves one implicit call to compound_head();
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   mm/memory.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 21fab27272092..098fac2f5efc0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2932,7 +2932,7 @@ static gfp_t __get_fault_gfp_mask(struct vm_area_struct *vma)
>   static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>   {
>   	vm_fault_t ret;
> -	struct page *page = vmf->page;
> +	struct folio *folio = page_folio(vmf->page);
>   	unsigned int old_flags = vmf->flags;
>   
>   	vmf->flags = FAULT_FLAG_WRITE|FAULT_FLAG_MKWRITE;
> @@ -2947,14 +2947,14 @@ static vm_fault_t do_page_mkwrite(struct vm_fault *vmf)
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
>   		return ret;
>   	if (unlikely(!(ret & VM_FAULT_LOCKED))) {
> -		lock_page(page);
> -		if (!page->mapping) {
> -			unlock_page(page);
> +		folio_lock(folio);
> +		if (!folio_mapping(folio)) {

Could page->mapping be directly converted to folio->mapping?

Thanks,
Peng

> +			folio_unlock(folio);
>   			return 0; /* retry */
>   		}
>   		ret |= VM_FAULT_LOCKED;
>   	} else
> -		VM_BUG_ON_PAGE(!PageLocked(page), page);
> +		VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>   	return ret;
>   }
>   
