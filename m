Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F526B643B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCLJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ABC2A9BB;
        Sun, 12 Mar 2023 01:35:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB1360E99;
        Sun, 12 Mar 2023 09:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ED8C433D2;
        Sun, 12 Mar 2023 09:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678613745;
        bh=FGfHyiCN0aXermKd8RTGCSgYZKL3rHsRsRTObZ041wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNdJn3zmkTmCNxGecjiwtvRHJj7oJCaSwKIpuW/qFtGgP7A45tHhzqfSv7PPJa38z
         KOQfUaRtfPZiFIVGpCfrsgXPfly7uYS4W06tmOSccRNuhxcRdqb5WiII42K8WNEgwg
         AjlCgSYSIHOOd7Vwcdi5H7rf0YNayRqHbIB7VShpX8VC/EjTHEtkYhWNP0AoL6mrvv
         XbfOgwo3T1XW1oQsmew9LoAvIPxNbjZM1qFbMHStoJSzJ3kLoBgUFrCTXRTHs7ws7T
         XSpl+DgyE34JTayrOcRfPYTMBQxDxt/lfqhTKT5hE8ZSBaYDxXUiJxZgT/HQTqaa+X
         3hp+zCPkrv3Fg==
Date:   Sun, 12 Mar 2023 11:35:29 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 2/4] mm: Introduce memblock_isolate_memory
Message-ID: <ZA2c4X+acRLHKV38@kernel.org>
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
 <20230310094539.764357-3-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310094539.764357-3-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Fri, Mar 10, 2023 at 10:45:37AM +0100, Alexandre Ghiti wrote:
> This function allows to split a region in memblock.memory and will be
> useful when setting up the linear mapping with STRICT_KERNEL_RWX: it
> allows to isolate the kernel text/rodata and then avoid to map those
> regions with a PUD/P4D/PGD.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  include/linux/memblock.h |  1 +
>  mm/memblock.c            | 22 +++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 50ad19662a32..2f7ef97c0da7 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -125,6 +125,7 @@ int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
>  int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
>  int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
> +int memblock_isolate_memory(phys_addr_t base, phys_addr_t size);
>  
>  void memblock_free_all(void);
>  void memblock_free(void *ptr, size_t size);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 25fd0626a9e7..d8cf1c9eccf0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -753,7 +753,8 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  	int idx;
>  	struct memblock_region *rgn;
>  
> -	*start_rgn = *end_rgn = 0;
> +	if (start_rgn && end_rgn)
> +		*start_rgn = *end_rgn = 0;

Generally, it's possible that either start_rgn or end_rgn will be a valid
pointer and this should be handled here and below.

My preference, though would be to leave memblock_isolate_range() as is and
have unused start_rgn and end_rgn in memblock_isolate_memory().

>  
>  	if (!size)
>  		return 0;
> @@ -795,6 +796,9 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  					       memblock_get_region_node(rgn),
>  					       rgn->flags);
>  		} else {
> +			if (!end_rgn || !start_rgn)
> +				continue;
> +
>  			/* @rgn is fully contained, record it */
>  			if (!*end_rgn)
>  				*start_rgn = idx;
> @@ -805,6 +809,22 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
>  	return 0;
>  }
>  
> +/**
> + * memblock_isolate_memory - isolate given range from memblock.memory

I think it'd better to use "... range in memblock.memory"

> + * @base: base of range to isolate
> + * @size: size of range to isolate
> + *
> + * Call memblock_isolate_range on memblock.memory to isolate the given range.

Please elaborate that isolate means that the range does not share regions
with other ranges.

> + *
> + * Return:
> + * 0 on success, -errno on failure.
> + */
> +
> +int __init_memblock memblock_isolate_memory(phys_addr_t base, phys_addr_t size)
> +{
> +	return memblock_isolate_range(&memblock.memory, base, size, NULL, NULL);
> +}
> +
>  static int __init_memblock memblock_remove_range(struct memblock_type *type,
>  					  phys_addr_t base, phys_addr_t size)
>  {
> -- 
> 2.37.2
> 

-- 
Sincerely yours,
Mike.
