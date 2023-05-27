Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16644713405
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjE0Kcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjE0Kcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D3210A
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:32:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E12EE60A28
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9329AC433EF;
        Sat, 27 May 2023 10:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183564;
        bh=dZMArKxP+hfUf5rC1dPqtfwwexQWV16dB2UKVfY1icU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltrf6ZIRLZS/+qei3MCLojOf30hqfmkXcGenQJCW4RGGbwNJQVolarYoHQRCHYJoQ
         B9vnj6FYa9D2ItKHPxa3ydYe0xbBnQc0fpwEj8zduc4dY6L76vUlQHNppv5EHrRgTi
         zIG1bY5CMPtL0BCfQMfSx/WXBgyxs3gXq8g6kblg47fH85QVxflNCVAUGKvN6ppTwh
         0DG3ziBUErQZ/KHHc219fCSOKsumpDKZmkBRtlKKIx+m+gldvu8WTKd42+2PJNYiNG
         m5xLyjPzfq0pOnOx+vbBV26H8zXaTm1/WrAYhUdDwG4RGdfDZjNWeqAmR0s3aRzpsR
         yc2p2WVoIvzDA==
Date:   Sat, 27 May 2023 13:32:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tsahu@linux.ibm.com,
        anshuman.khandual@arm.com, ssawgyw@gmail.com
Subject: Re: [PATCH -next v2] memblock: unify memblock dump and debugfs show
Message-ID: <20230527103222.GF4967@kernel.org>
References: <20230526120505.123693-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526120505.123693-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Fri, May 26, 2023 at 08:05:05PM +0800, Kefeng Wang wrote:
> There are two interfaces to show the memblock information, memblock_dump_all()
> and /sys/kernel/debug/memblock/, but the content is displayed separately,
> let's unify them in case of more different changes over time.
 
I don't see much value in this unifications, especially as it must change
the format of one of the dumps. Although these are not ABIs, keeping the
existing formats seems more important to me that having a single dump
function.

> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2:
> - fix wrong count since we add MEMBLOCK_MAX_UNKNOWN
> - drop __initdata_memblock for flagname
> 
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 80 ++++++++++++++++++++--------------------
>  2 files changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index f82ee3fac1cd..d68826e8c97b 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -47,6 +47,7 @@ enum memblock_flags {
>  	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
>  	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
>  	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
> +	MEMBLOCK_MAX_UNKNOWN	= 0x10,	/* unknow flags */
>  };
>  
>  /**
> diff --git a/mm/memblock.c b/mm/memblock.c
> index c5c80d9bcea3..04eb7c665026 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1899,16 +1899,35 @@ phys_addr_t __init_memblock memblock_get_current_limit(void)
>  	return memblock.current_limit;
>  }
>  
> -static void __init_memblock memblock_dump(struct memblock_type *type)
> +#define memblock_printf(m, to_dmesg, fmt, args...)		\
> +({								\
> +	if (to_dmesg)						\
> +		pr_info(fmt, ##args);				\
> +	else							\
> +		seq_printf(m, fmt, ##args);			\
> +})
> +
> +static const char * const flagname[] = {
> +	[ilog2(MEMBLOCK_HOTPLUG)]		= "HOTPLUG",
> +	[ilog2(MEMBLOCK_MIRROR)]		= "MIRROR",
> +	[ilog2(MEMBLOCK_NOMAP)]			= "NOMAP",
> +	[ilog2(MEMBLOCK_DRIVER_MANAGED)]	= "DRV_MNG",
> +	[ilog2(MEMBLOCK_MAX_UNKNOWN)]		= "UNKNOWN",
> +};
> +
> +static void __init_memblock memblock_dump(struct memblock_type *type,
> +					  struct seq_file *m, bool to_dmesg)
>  {
> +	unsigned count = ARRAY_SIZE(flagname) - 1;
>  	phys_addr_t base, end, size;
>  	enum memblock_flags flags;
> -	int idx;
>  	struct memblock_region *rgn;
> +	int idx, i;
>  
> -	pr_info(" %s.cnt  = 0x%lx\n", type->name, type->cnt);
> +	memblock_printf(m, to_dmesg, " %s.cnt  = 0x%lx\n", type->name, type->cnt);
>  
>  	for_each_memblock_type(idx, type, rgn) {
> +		const char *fp = "NONE";
>  		char nid_buf[32] = "";
>  
>  		base = rgn->base;
> @@ -1920,8 +1939,19 @@ static void __init_memblock memblock_dump(struct memblock_type *type)
>  			snprintf(nid_buf, sizeof(nid_buf), " on node %d",
>  				 memblock_get_region_node(rgn));
>  #endif
> -		pr_info(" %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %#x\n",
> -			type->name, idx, &base, &end, &size, nid_buf, flags);
> +		if (flags) {
> +			fp = flagname[count];
> +
> +			for (i = 0; i < count; i++) {
> +				if (flags & (1U << i)) {
> +					fp = flagname[i];
> +					break;
> +				}
> +			}
> +		}
> +
> +		memblock_printf(m, to_dmesg, " %s[%#x]\t[%pa-%pa], %pa bytes%s flags: %s\n",
> +			type->name, idx, &base, &end, &size, nid_buf, fp);
>  	}
>  }
>  
> @@ -1932,10 +1962,10 @@ static void __init_memblock __memblock_dump_all(void)
>  		&memblock.memory.total_size,
>  		&memblock.reserved.total_size);
>  
> -	memblock_dump(&memblock.memory);
> -	memblock_dump(&memblock.reserved);
> +	memblock_dump(&memblock.memory, NULL, true);
> +	memblock_dump(&memblock.reserved, NULL, true);
>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> -	memblock_dump(&physmem);
> +	memblock_dump(&physmem, NULL, true);
>  #endif
>  }
>  
> @@ -2158,41 +2188,13 @@ void __init memblock_free_all(void)
>  }
>  
>  #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> -static const char * const flagname[] = {
> -	[ilog2(MEMBLOCK_HOTPLUG)] = "HOTPLUG",
> -	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
> -	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
> -	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
> -};
>  
>  static int memblock_debug_show(struct seq_file *m, void *private)
>  {
>  	struct memblock_type *type = m->private;
> -	struct memblock_region *reg;
> -	int i, j;
> -	unsigned int count = ARRAY_SIZE(flagname);
> -	phys_addr_t end;
> -
> -	for (i = 0; i < type->cnt; i++) {
> -		reg = &type->regions[i];
> -		end = reg->base + reg->size - 1;
> -
> -		seq_printf(m, "%4d: ", i);
> -		seq_printf(m, "%pa..%pa ", &reg->base, &end);
> -		seq_printf(m, "%4d ", memblock_get_region_node(reg));
> -		if (reg->flags) {
> -			for (j = 0; j < count; j++) {
> -				if (reg->flags & (1U << j)) {
> -					seq_printf(m, "%s\n", flagname[j]);
> -					break;
> -				}
> -			}
> -			if (j == count)
> -				seq_printf(m, "%s\n", "UNKNOWN");
> -		} else {
> -			seq_printf(m, "%s\n", "NONE");
> -		}
> -	}
> +
> +	memblock_dump(type, m, false);
> +
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(memblock_debug);
> -- 
> 2.35.3
> 

-- 
Sincerely yours,
Mike.
