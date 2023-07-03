Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0379974585D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGCJaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGCJ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:29:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBD1E59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:29:57 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QvgbW6H8kzTm8F;
        Mon,  3 Jul 2023 17:28:55 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 17:29:54 +0800
Message-ID: <4128bc10-5110-983c-192f-afe8b856b329@huawei.com>
Date:   Mon, 3 Jul 2023 17:29:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] mm/memory: convert do_read_fault() to use folios
Content-Language: en-US
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>
References: <20230703055850.227169-1-sidhartha.kumar@oracle.com>
 <20230703055850.227169-4-sidhartha.kumar@oracle.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230703055850.227169-4-sidhartha.kumar@oracle.com>
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

> Saves one implicit call to compound_head()
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: ZhangPeng <zhangpeng362@huawei.com>

> ---
>   mm/memory.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 33bf13431974c..b97c66df4adac 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4528,6 +4528,7 @@ static inline bool should_fault_around(struct vm_fault *vmf)
>   static vm_fault_t do_read_fault(struct vm_fault *vmf)
>   {
>   	vm_fault_t ret = 0;
> +	struct folio *folio = page_folio(vmf->page);
>   
>   	/*
>   	 * Let's call ->map_pages() first and use ->fault() as fallback
> @@ -4545,9 +4546,9 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
>   		return ret;
>   
>   	ret |= finish_fault(vmf);
> -	unlock_page(vmf->page);
> +	folio_unlock(folio);
>   	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
> -		put_page(vmf->page);
> +		folio_put(folio);
>   	return ret;
>   }
>   
