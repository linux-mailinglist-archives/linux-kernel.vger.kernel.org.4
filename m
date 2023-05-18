Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60FD707DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjERKMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjERKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:12:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B1AA1BD2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 03:12:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D75171FB;
        Thu, 18 May 2023 03:12:45 -0700 (PDT)
Received: from [10.163.70.177] (unknown [10.163.70.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD65A3F793;
        Thu, 18 May 2023 03:11:58 -0700 (PDT)
Message-ID: <ab37a497-3caa-1313-90a8-328cfe99c8d3@arm.com>
Date:   Thu, 18 May 2023 15:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] memblock: Add flags and nid info in memblock debugfs
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, tsahu@linux.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230518091431.299-1-ssawgyw@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230518091431.299-1-ssawgyw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 14:44, Yuwei Guan wrote:
> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when memblock_mark_*() or
> memblock_set_node() is executed on some range, the information in the
> existing debugfs cannot make it clear why the address is not consecutive.
> 
> For example,
> cat /sys/kernel/debug/memblock/memory
>    0: 0x0000000080000000..0x00000000901fffff
>    1: 0x0000000090200000..0x00000000905fffff
>    2: 0x0000000090600000..0x0000000092ffffff
>    3: 0x0000000093000000..0x00000000973fffff
>    4: 0x0000000097400000..0x00000000b71fffff
>    5: 0x00000000c0000000..0x00000000dfffffff
>    6: 0x00000000e2500000..0x00000000f87fffff
>    7: 0x00000000f8800000..0x00000000fa7fffff
>    8: 0x00000000fa800000..0x00000000fd3effff
>    9: 0x00000000fd3f0000..0x00000000fd3fefff
>   10: 0x00000000fd3ff000..0x00000000fd7fffff
>   11: 0x00000000fd800000..0x00000000fd901fff
>   12: 0x00000000fd902000..0x00000000fd909fff
>   13: 0x00000000fd90a000..0x00000000fd90bfff
>   14: 0x00000000fd90c000..0x00000000ffffffff
>   15: 0x0000000880000000..0x0000000affffffff
> 
> So we can add flags and nid to this debugfs.
> 
> For example,
> cat /sys/kernel/debug/memblock/memory
>    0: 0x0000000080000000..0x00000000901fffff     NONE    0
>    1: 0x0000000090200000..0x00000000905fffff    NOMAP    0
>    2: 0x0000000090600000..0x0000000092ffffff     NONE    0
>    3: 0x0000000093000000..0x00000000973fffff    NOMAP    0
>    4: 0x0000000097400000..0x00000000b71fffff     NONE    0
>    5: 0x00000000c0000000..0x00000000dfffffff     NONE    0
>    6: 0x00000000e2500000..0x00000000f87fffff     NONE    0
>    7: 0x00000000f8800000..0x00000000fa7fffff    NOMAP    0
>    8: 0x00000000fa800000..0x00000000fd3effff     NONE    0
>    9: 0x00000000fd3f0000..0x00000000fd3fefff    NOMAP    0
>   10: 0x00000000fd3ff000..0x00000000fd7fffff     NONE    0
>   11: 0x00000000fd800000..0x00000000fd901fff    NOMAP    0
>   12: 0x00000000fd902000..0x00000000fd909fff     NONE    0
>   13: 0x00000000fd90a000..0x00000000fd90bfff    NOMAP    0
>   14: 0x00000000fd90c000..0x00000000ffffffff     NONE    0
>   15: 0x0000000880000000..0x0000000affffffff     NONE    0

Although, Mike had suggested to keep these flags print last, above
format looks good as well.

> 
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> ---
> v3:
> - show string value for each memblock flag
> ---
>  mm/memblock.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..5fba53f98b2d 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2143,13 +2143,23 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	struct memblock_region *reg;
>  	int i;
>  	phys_addr_t end;
> +	static const char flagname[BITS_PER_LONG][8] = {
> +		[0 ... (BITS_PER_LONG-1)] = "?",

Minor nit -

Although checkpatch does not complain, should there be spaces between
the operator and operands e.g (BITS_PER_LONG - 1).

> +
> +		[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> +		[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
> +		[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> +		[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> +	};

Also, BITS_PER_LONG sized array is really required here ? as there are
just four available memblock flags.

>  
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
>  
>  		seq_printf(m, "%4d: ", i);
> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> +		seq_printf(m, "%pa..%pa ", &reg->base, &end);
> +		seq_printf(m, "%8s ", reg->flags ? flagname[ilog2(reg->flags)] : "NONE");
> +		seq_printf(m, "%4d\n", memblock_get_region_node(reg));
>  	}
>  	return 0;
>  }
