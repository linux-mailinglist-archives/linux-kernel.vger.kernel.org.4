Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42DB710B46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbjEYLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjEYLmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:42:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D91B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:42:03 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRmHs5KcbzqSTH;
        Thu, 25 May 2023 19:37:29 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 19:42:00 +0800
Message-ID: <49933f51-a17e-8eef-7539-10759a6fa3e2@huawei.com>
Date:   Thu, 25 May 2023 19:42:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] memblock: update numa node of memblk reserved type
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>, <ssawgyw@gmail.com>
References: <20230525115742.124190-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230525115742.124190-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore it, send wrong patch...

On 2023/5/25 19:57, Kefeng Wang wrote:
> The numa node of memblk reserved type is always wrong when check
> memblock_dump_all() or sysfs file (/sys/kernel/debug/memblock/reserved),
> no one use reserved type's node except the two debug interfaces,
> but uncorrect value is bad as the above interfaces are visible for
> user. Let's fix it according to the numa node information from memblk
> memory type by adding a memblock_reserved_update_node(), note, it will
> be called twice since memblock_reserve could still be called after
> memblock_dump_all(), or the sysfs file read may get some wrong value.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - update changelog, explain why update reserved node info twice
> - move memblock_reserved_update_node() from sysfs read into
>    memblock_init_debugfs()
> 
>   mm/memblock.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c5c80d9bcea3..50dd12958e60 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1899,6 +1899,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
>   	return memblock.current_limit;
>   }
>   
> +static void __init_memblock memblock_reserved_update_node(void)
> +{
> +	struct memblock_region *rgn;
> +	phys_addr_t base, end, size;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_NUMA))
> +		return;
> +
> +	for_each_mem_region(rgn) {
> +		base = rgn->base;
> +		size = rgn->size;
> +		end = base + size - 1;
> +
> +		ret = memblock_set_node(base, size, &memblock.reserved,
> +					memblock_get_region_node(rgn));
> +		if (ret)
> +			pr_err("memblock: Failed to update reserved [%pa-%pa] node",
> +			       &base, &end);
> +	}
> +}
> +
>   static void __init_memblock memblock_dump(struct memblock_type *type)
>   {
>   	phys_addr_t base, end, size;
> @@ -1932,6 +1954,7 @@ static void __init_memblock __memblock_dump_all(void)
>   		&memblock.memory.total_size,
>   		&memblock.reserved.total_size);
>   
> +	memblock_reserved_update_node();
>   	memblock_dump(&memblock.memory);
>   	memblock_dump(&memblock.reserved);
>   #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> @@ -2209,6 +2232,7 @@ static int __init memblock_init_debugfs(void)
>   	debugfs_create_file("physmem", 0444, root, &physmem,
>   			    &memblock_debug_fops);
>   #endif
> +	memblock_reserved_update_node();
>   
>   	return 0;
>   }
