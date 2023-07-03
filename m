Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75174585B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjGCJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:29:49 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE75D196
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:29:47 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qvgc16Hsnz1HCqn;
        Mon,  3 Jul 2023 17:29:21 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 17:29:44 +0800
Message-ID: <f013967d-e83a-573f-76e4-08cc5fed29cf@huawei.com>
Date:   Mon, 3 Jul 2023 17:29:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 3/4] mm/memory: convert do_shared_fault() to folios
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-3-sidhartha.kumar@oracle.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230703055850.227169-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/3 13:58, Sidhartha Kumar wrote:

> Saves three implicit calls to compound_head().
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: ZhangPeng <zhangpeng362@huawei.com>

> ---
>   mm/memory.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 93480e846ace6..33bf13431974c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4594,6 +4594,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	vm_fault_t ret, tmp;
> +	struct folio *folio = page_folio(vmf->page);
>   
>   	ret = __do_fault(vmf);
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> @@ -4604,11 +4605,11 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>   	 * about to become writable
>   	 */
>   	if (vma->vm_ops->page_mkwrite) {
> -		unlock_page(vmf->page);
> +		folio_unlock(folio);
>   		tmp = do_page_mkwrite(vmf);
>   		if (unlikely(!tmp ||
>   				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
> -			put_page(vmf->page);
> +			folio_put(folio);
>   			return tmp;
>   		}
>   	}
> @@ -4616,8 +4617,8 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>   	ret |= finish_fault(vmf);
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
>   					VM_FAULT_RETRY))) {
> -		unlock_page(vmf->page);
> -		put_page(vmf->page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>   		return ret;
>   	}
>   
