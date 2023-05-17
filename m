Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54D705FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjEQGHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjEQGHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:07:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B67D196
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:07:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E5DE1FB;
        Tue, 16 May 2023 23:08:16 -0700 (PDT)
Received: from [10.163.70.237] (unknown [10.163.70.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CFC03F663;
        Tue, 16 May 2023 23:07:29 -0700 (PDT)
Message-ID: <52fa3a4f-5467-7b68-334c-4280d3925b39@arm.com>
Date:   Wed, 17 May 2023 11:37:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] memblock: Add flags and nid info in memblock debugfs
Content-Language: en-US
To:     Yuwei Guan <ssawgyw@gmail.com>, rppt@kernel.org,
        akpm@linux-foundation.org, tsahu@linux.ibm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517025747.230-1-ssawgyw@gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230517025747.230-1-ssawgyw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 08:27, Yuwei Guan wrote:
> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when the following scenario occurs,

scenarios where the memblock flags or nid varies inside a single PA range ?
I guess the commit message description here can be improved to accommodate
such details.

> the information in the existing debugfs cannot make it clear why the
> address is not consecutive.
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
> cnt     base..end       flags   nid

These markers ^^^ are not aligned properly, and also might not be
required as well.

> 0:      0x0000000080000000..0x00000000901fffff  0x0     0x0
> 1:      0x0000000090200000..0x00000000905fffff  0x4     0x0
> 2:      0x0000000090600000..0x0000000092ffffff  0x0     0x0
> 3:      0x0000000093000000..0x00000000973fffff  0x4     0x0
> 4:      0x0000000097400000..0x00000000b71fffff  0x0     0x0
> 5:      0x00000000c0000000..0x00000000dfffffff  0x0     0x0
> 6:      0x00000000e2500000..0x00000000f87fffff  0x0     0x0
> 7:      0x00000000f8800000..0x00000000fa7fffff  0x4     0x0
> 8:      0x00000000fa800000..0x00000000fd3effff  0x0     0x0
> 9:      0x00000000fd3f0000..0x00000000fd3fefff  0x4     0x0
> 10:     0x00000000fd3ff000..0x00000000fd7fffff  0x0     0x0
> 11:     0x00000000fd800000..0x00000000fd901fff  0x4     0x0
> 12:     0x00000000fd902000..0x00000000fd909fff  0x0     0x0
> 13:     0x00000000fd90a000..0x00000000fd90bfff  0x4     0x0
> 14:     0x00000000fd90c000..0x00000000ffffffff  0x0     0x0
> 15:     0x0000000880000000..0x0000000affffffff  0x0     0x0
> 
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> Reviewed-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  mm/memblock.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..b36fb6b31e0f 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2144,12 +2144,16 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	int i;
>  	phys_addr_t end;
>  
> +	seq_puts(m, "cnt\tbase..end\tflags\tnid\n");

Please drop this.

> +
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
>  
> -		seq_printf(m, "%4d: ", i);
> -		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
> +		seq_printf(m, "%d:\t", i);

Why drop the existing %4d formatting qualifier ?

> +		seq_printf(m, "%pa..%pa\t", &reg->base, &end);
> +		seq_printf(m, "0x%x\t", reg->flags);

Should there be ORed string values for each memblock flag ?

enum memblock_flags {
        MEMBLOCK_NONE           = 0x0,  /* No special request */
        MEMBLOCK_HOTPLUG        = 0x1,  /* hotpluggable region */
        MEMBLOCK_MIRROR         = 0x2,  /* mirrored region */
        MEMBLOCK_NOMAP          = 0x4,  /* don't add to kernel direct mapping */
        MEMBLOCK_DRIVER_MANAGED = 0x8,  /* always detected via a driver */
};

Something like NN | HT | MR | NM | DM ?

> +		seq_printf(m, "0x%x\n", memblock_get_region_node(reg));
>  	}
>  	return 0;
>  }
