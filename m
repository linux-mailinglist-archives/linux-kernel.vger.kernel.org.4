Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF12370DB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbjEWLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjEWLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:36:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246B119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:36:42 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QQXJS5Pk0zLq4g;
        Tue, 23 May 2023 19:33:44 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 19:36:40 +0800
Message-ID: <a97d9a92-4583-4e31-7bb3-884f4be6de93@huawei.com>
Date:   Tue, 23 May 2023 19:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4] memblock: Add flags and nid info in memblock debugfs
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, <rppt@kernel.org>,
        <akpm@linux-foundation.org>, <tsahu@linux.ibm.com>,
        <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230519105321.333-1-ssawgyw@gmail.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230519105321.333-1-ssawgyw@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/19 18:53, Yuwei Guan wrote:
> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when memblock_mark_*() or
> memblock_set_node() is executed on some range, the information in the
> existing debugfs cannot make it clear why the address is not consecutive.
> 
> For example,
> cat /sys/kernel/debug/memblock/memory
>     0: 0x0000000080000000..0x00000000901fffff
>     1: 0x0000000090200000..0x00000000905fffff
>     2: 0x0000000090600000..0x0000000092ffffff
>     3: 0x0000000093000000..0x00000000973fffff
>     4: 0x0000000097400000..0x00000000b71fffff
>     5: 0x00000000c0000000..0x00000000dfffffff
>     6: 0x00000000e2500000..0x00000000f87fffff
>     7: 0x00000000f8800000..0x00000000fa7fffff
>     8: 0x00000000fa800000..0x00000000fd3effff
>     9: 0x00000000fd3f0000..0x00000000fd3fefff
>    10: 0x00000000fd3ff000..0x00000000fd7fffff
>    11: 0x00000000fd800000..0x00000000fd901fff
>    12: 0x00000000fd902000..0x00000000fd909fff
>    13: 0x00000000fd90a000..0x00000000fd90bfff
>    14: 0x00000000fd90c000..0x00000000ffffffff
>    15: 0x0000000880000000..0x0000000affffffff
> 
> So we can add flags and nid to this debugfs.
> 
> For example,
> cat /sys/kernel/debug/memblock/memory
>     0: 0x0000000080000000..0x00000000901fffff    0 NONE
>     1: 0x0000000090200000..0x00000000905fffff    0 NOMAP
>     2: 0x0000000090600000..0x0000000092ffffff    0 NONE
>     3: 0x0000000093000000..0x00000000973fffff    0 NOMAP
>     4: 0x0000000097400000..0x00000000b71fffff    0 NONE
>     5: 0x00000000c0000000..0x00000000dfffffff    0 NONE
>     6: 0x00000000e2500000..0x00000000f87fffff    0 NONE
>     7: 0x00000000f8800000..0x00000000fa7fffff    0 NOMAP
>     8: 0x00000000fa800000..0x00000000fd3effff    0 NONE
>     9: 0x00000000fd3f0000..0x00000000fd3fefff    0 NOMAP
>    10: 0x00000000fd3ff000..0x00000000fd7fffff    0 NONE
>    11: 0x00000000fd800000..0x00000000fd901fff    0 NOMAP
>    12: 0x00000000fd902000..0x00000000fd909fff    0 NONE
>    13: 0x00000000fd90a000..0x00000000fd90bfff    0 NOMAP
>    14: 0x00000000fd90c000..0x00000000ffffffff    0 NONE
>    15: 0x0000000880000000..0x0000000affffffff    0 NONE

It's useful for debug memblock, thanks,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

I also found memblock reserved type's node is always wrong,
from memblock=debug, and read /sys/kernel/debug/memblock/reserved
return bad node info, I will send a patch.

> 
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> ---
> v4:
> - show string value for each memblock flag
> ---
>   mm/memblock.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..10d0ddbeebc1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2136,12 +2136,19 @@ void __init memblock_free_all(void)
>   }
>   
>   #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> +static const char * const flagname[] = {
> +	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> +	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
> +	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> +	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> +};
>   
>   static int memblock_debug_show(struct seq_file *m, void *private)
>   {
>   	struct memblock_type *type = m->private;
>   	struct memblock_region *reg;
> -	int i;
> +	int i, j;
> +	unsigned int count = ARRAY_SIZE(flagname);
>   	phys_addr_t end;
>   
>   	for (i = 0; i < type->cnt; i++) {
> @@ -2149,7 +2156,20 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>   		end = reg->base + reg->size - 1;
>   
>   		seq_printf(m, "%4d: ", i);
> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> +		seq_printf(m, "%pa..%pa ", &reg->base, &end);
> +		seq_printf(m, "%4d ", memblock_get_region_node(reg));
> +		if (reg->flags) {
> +			for (j = 0; j < count; j++) {
> +				if (reg->flags & (1U << j)) {
> +					seq_printf(m, "%s\n", flagname[j]);
> +					break;
> +				}
> +			}
> +			if (j == count)
> +				seq_printf(m, "%s\n", "UNKNOWN");
> +		} else {
> +			seq_printf(m, "%s\n", "NONE");
> +		}
>   	}
>   	return 0;
>   }
