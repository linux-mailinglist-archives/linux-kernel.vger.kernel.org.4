Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A494170503A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjEPOKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjEPOKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:10:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B121FFB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5178E61AE3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:10:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28D1C433D2;
        Tue, 16 May 2023 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246244;
        bh=Q9L0gBwr5anX6aiKuTQMF/HoFlVlaybar5O5KDWeGrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSU5se7YLUS8gvDtMGkvcVU5FRvcfEhX1mFJ+bO+g32YeGMFtKLANG5lgGoQJuMiu
         RAJF/Kz2Kg85KeCVY4RbtZCCRkF4d4rntWD6+mOHz1KoxWexgZKDEMnnnnM3xZmUxB
         ky5dViOEBv6TxV8a+5fzY7JjUrS1ySZXty/iKPMDPhtBxJLHtExuTG2i6afjAgkbq5
         nq5ZnnlwzeLpp9hq59Wrj+nBszWir1NrV8VHFtvF9MEVRKGcyUgMoGaWWduxgfOPas
         +uz5syuzfQ58CrgXOFK9i3uW6rC2rrk4qO5eEl7HY8TOTuhI47YvvSlTgMmRJt6ThZ
         Q/u9abuJkTRlg==
Date:   Tue, 16 May 2023 07:10:33 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     Yuwei Guan <ssawgyw@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Add flags and nid info in memblock debugfs
Message-ID: <20230516141033.GA4967@kernel.org>
References: <20230516020645.160-1-ssawgyw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516020645.160-1-ssawgyw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2023 at 10:06:45AM +0800, Yuwei Guan wrote:
> Currently, the memblock debugfs can display the count of memblock_type and
> the base and end of the reg. However, when the following scenario occurs,
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
> cnt     flags   base..end
> 0:      0x0     0x0000000080000000..0x00000000901fffff
> 1:      0x4     0x0000000090200000..0x00000000905fffff
> 2:      0x0     0x0000000090600000..0x0000000092ffffff
> 3:      0x4     0x0000000093000000..0x00000000973fffff
> 4:      0x0     0x0000000097400000..0x00000000b71fffff
> 5:      0x0     0x00000000c0000000..0x00000000dfffffff
> 6:      0x0     0x00000000e2500000..0x00000000f87fffff
> 7:      0x4     0x00000000f8800000..0x00000000fa7fffff
> 8:      0x0     0x00000000fa800000..0x00000000fd3effff
> 9:      0x4     0x00000000fd3f0000..0x00000000fd3fefff
> 10:     0x0     0x00000000fd3ff000..0x00000000fd7fffff
> 11:     0x4     0x00000000fd800000..0x00000000fd901fff
> 12:     0x0     0x00000000fd902000..0x00000000fd909fff
> 13:     0x4     0x00000000fd90a000..0x00000000fd90bfff
> 14:     0x0     0x00000000fd90c000..0x00000000ffffffff
> 15:     0x0     0x0000000880000000..0x0000000affffffff
> 
> Signed-off-by: Yuwei Guan <ssawgyw@gmail.com>
> ---
>  mm/memblock.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 45f198750be9..34230b258e21 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2045,11 +2045,21 @@ static int memblock_debug_show(struct seq_file *m, void *private)
>  	int i;
>  	phys_addr_t end;
>  
> +#ifdef CONFIG_NUMA
> +	seq_puts(m, "cnt\tflags\tnid\tbase..end\n");
> +#else
> +	seq_puts(m, "cnt\tflags\tbase..end\n");
> +#endif
> +
>  	for (i = 0; i < type->cnt; i++) {
>  		reg = &type->regions[i];
>  		end = reg->base + reg->size - 1;
>  
> -		seq_printf(m, "%4d: ", i);
> +		seq_printf(m, "%d:\t", i);
> +		seq_printf(m, "0x%x\t", reg->flags);
> +#ifdef CONFIG_NUMA
> +		seq_printf(m, "0x%x\t", reg->nid);
> +#endif

Please add flags and node information after the ranges and print node for
UMA case as well. I'd prefer to have zeros in debugfs rather than ifdefs
here. Just use memblock_get_region_node() instead of r->nid.

>  		seq_printf(m, "%pa..%pa\n", &reg->base, &end);
>  	}
>  	return 0;
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.
