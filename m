Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5C6C7659
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjCXDoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXDnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:43:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DD1CDC9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 20:43:18 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PjSdh38bJz17Nrg;
        Fri, 24 Mar 2023 11:40:08 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 11:43:13 +0800
Message-ID: <15f4892c-e0dc-ff37-45a8-a1a025c2d929@huawei.com>
Date:   Fri, 24 Mar 2023 11:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: kfence: fix handling discontiguous page
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, <glider@google.com>,
        <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <jannh@google.com>,
        <sjpark@amazon.de>, <muchun.song@linux.dev>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230323025003.94447-1-songmuchun@bytedance.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230323025003.94447-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/23 10:50, Muchun Song wrote:
> The struct pages could be discontiguous when the kfence pool is allocated
> via alloc_contig_pages() with CONFIG_SPARSEMEM and !CONFIG_SPARSEMEM_VMEMMAP.
> So, the iteration should use nth_page().
> 

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/kfence/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index d66092dd187c..1065e0568d05 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -556,7 +556,7 @@ static unsigned long kfence_init_pool(void)
>   	 * enters __slab_free() slow-path.
>   	 */
>   	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -		struct slab *slab = page_slab(&pages[i]);
> +		struct slab *slab = page_slab(nth_page(pages, i));
>   
>   		if (!i || (i % 2))
>   			continue;
> @@ -602,7 +602,7 @@ static unsigned long kfence_init_pool(void)
>   
>   reset_slab:
>   	for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -		struct slab *slab = page_slab(&pages[i]);
> +		struct slab *slab = page_slab(nth_page(pages, i));
>   
>   		if (!i || (i % 2))
>   			continue;
