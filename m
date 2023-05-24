Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7807170ECC7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 06:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239084AbjEXE7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 00:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbjEXE7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 00:59:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05A9718D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 21:59:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC4DD1042;
        Tue, 23 May 2023 22:00:26 -0700 (PDT)
Received: from [10.163.72.91] (unknown [10.163.72.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E456B3F840;
        Tue, 23 May 2023 21:59:38 -0700 (PDT)
Message-ID: <03cdccc3-8b8a-d972-bbad-d60966e59ca9@arm.com>
Date:   Wed, 24 May 2023 10:29:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] memblock: update numa node of memblk reserved type
Content-Language: en-US
To:     20230519105321.333-1-ssawgyw@gmail.com,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, tsahu@linux.ibm.com,
        ssawgyw@gmail.com, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230523115708.195597-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/23/23 17:27, Kefeng Wang wrote:
> The numa node of memblk reserved type is wrong, it could update
> according to the numa node information from memblk memory type,
> let's fix it.

Indeed it's wrong at present and can be verified from sysfs file
(/sys/kernel/debug/memblock/reserved) accessed in user space.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/memblock.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index a50447d970ef..45a0781cda31 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1922,6 +1922,28 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
>  	return memblock.current_limit;
>  }
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
>  static void __init_memblock memblock_dump(struct memblock_type *type)
>  {
>  	phys_addr_t base, end, size;
> @@ -1955,6 +1977,7 @@ static void __init_memblock __memblock_dump_all(void)
>  		&memblock.memory.total_size,
>  		&memblock.reserved.total_size);
>  
> +	memblock_reserved_update_node();

__memblock_dump_all() gets called only when memblock_debug is enabled.
This helper should be called directly inside memblock_dump_all() right
at the beginning, regardless of memblock_debug.

diff --git a/mm/memblock.c b/mm/memblock.c
index 804fae92d56f..008c4e86d7f3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1954,7 +1954,6 @@ static void __init_memblock __memblock_dump_all(void)
                &memblock.memory.total_size,
                &memblock.reserved.total_size);
 
-       memblock_reserved_update_node();
        memblock_dump(&memblock.memory);
        memblock_dump(&memblock.reserved);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -1964,6 +1963,8 @@ static void __init_memblock __memblock_dump_all(void)
 
 void __init_memblock memblock_dump_all(void)
 {
+       memblock_reserved_update_node();
+
        if (memblock_debug)
                __memblock_dump_all();
 }

>  	memblock_dump(&memblock.memory);
>  	memblock_dump(&memblock.reserved);
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> @@ -2196,6 +2219,8 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	unsigned int count = ARRAY_SIZE(flagname);
>  	phys_addr_t end;
>  
> +	memblock_reserved_update_node();
> +

This is redundant, should be dropped. Reserved memblock ranges need not
be scanned, each time the sysfs file is accessed from user space.

>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
