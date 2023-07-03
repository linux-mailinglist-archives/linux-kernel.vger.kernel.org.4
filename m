Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B6745859
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjGCJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGCJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:29:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB61B4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:29:34 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QvgXy5x6TztQTf;
        Mon,  3 Jul 2023 17:26:42 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 17:29:31 +0800
Message-ID: <fdce21be-81a9-8eb4-9b06-daaab287f6f6@huawei.com>
Date:   Mon, 3 Jul 2023 17:29:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/4] mm/memory: convert wp_page_shared() to use folios
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-2-sidhartha.kumar@oracle.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230703055850.227169-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

> Saves five implicit calls to compound_head().
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: ZhangPeng <zhangpeng362@huawei.com>

> ---
>   mm/memory.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 098fac2f5efc0..93480e846ace6 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3286,8 +3286,9 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	vm_fault_t ret = 0;
> +	struct folio *folio = page_folio(vmf->page);
>   
> -	get_page(vmf->page);
> +	folio_get(folio);
>   
>   	if (vma->vm_ops && vma->vm_ops->page_mkwrite) {
>   		vm_fault_t tmp;
> @@ -3296,21 +3297,21 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>   		tmp = do_page_mkwrite(vmf);
>   		if (unlikely(!tmp || (tmp &
>   				      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> -			put_page(vmf->page);
> +			folio_put(folio);
>   			return tmp;
>   		}
>   		tmp = finish_mkwrite_fault(vmf);
>   		if (unlikely(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE))) {
> -			unlock_page(vmf->page);
> -			put_page(vmf->page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>   			return tmp;
>   		}
>   	} else {
>   		wp_page_reuse(vmf);
> -		lock_page(vmf->page);
> +		folio_lock(folio);
>   	}
>   	ret |= fault_dirty_shared_page(vmf);
> -	put_page(vmf->page);
> +	folio_put(folio);
>   
>   	return ret;
>   }
