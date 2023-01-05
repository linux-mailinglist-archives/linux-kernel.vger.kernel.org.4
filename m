Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2B465F68A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjAEWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAEWOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:14:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3CFD07;
        Thu,  5 Jan 2023 14:14:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BA4FB81BFA;
        Thu,  5 Jan 2023 22:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46326C433D2;
        Thu,  5 Jan 2023 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672956840;
        bh=Z4eOuR/y0KdIFBiLFGkqOAfGHfUV0LGrmKrUyXhuSV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlelhkEsD3B8WqyKGrMXIm8RCLl1yfMt2vGBhC6/cVb4OMXRRtrjPJAhXhcxi2ISf
         oN+R7lcR+jEJnjCg31rTpKG8cDWlunogBxAVOiIF9fVnKL+bJPmUq3Z5V/aYErMbRS
         8T+4kYUm94xf2UDnHZIQ7ZLN0OGh0iiiunTjyiWnvdV962DxZZUgdechk0jMNcf4AH
         OoSpoYtRYoN5l7QFYlw8htQGW9WGgMaUQck1X13q8RmnZw+t7x2PJ6+qOWHsyEPloF
         FAzPsZrkStxLEWFdk7EB0OHqSlihf/yROoiqlw2wYo4f8t/j4DavEIhiSgTDCLz9h2
         bm2smTqzvhP8g==
Date:   Thu, 5 Jan 2023 16:14:05 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] memremap: Replace 0-length array with flexible array
Message-ID: <Y7dLrdOETjg/+XKq@work>
References: <20230105220151.never.343-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105220151.never.343-kees@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is the same patch:

https://lore.kernel.org/linux-hardening/YxKO%2FjY1x0xTpl4r@work/

It's actually in linux-next.

--
Gustavo

On Thu, Jan 05, 2023 at 02:01:53PM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:
> 
> In file included from include/asm-generic/memory_model.h:5,
>                  from arch/x86/include/asm/page.h:86,
>                  from arch/x86/include/asm/thread_info.h:12,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:9,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:56,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:7,
>                  from include/linux/mm.h:7,
>                  from mm/sparse-vmemmap.c:21:
> In function 'reuse_compound_section',
>     inlined from 'vmemmap_populate_compound_pages' at mm/sparse-vmemmap.c:407:6,
>     inlined from '__populate_section_memmap' at mm/sparse-vmemmap.c:463:7:
> mm/sparse-vmemmap.c:376:39: warning: array subscript <unknown> is outside array bounds of 'struct range[0]' [-Warray-bounds=]
>   376 |                 PHYS_PFN(pgmap->ranges[pgmap->nr_range].start);
>       |                          ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> include/linux/pfn.h:22:43: note: in definition of macro 'PHYS_PFN'
>    22 | #define PHYS_PFN(x)     ((unsigned long)((x) >> PAGE_SHIFT))
>       |                                           ^
> In file included from include/linux/mm.h:31:
> include/linux/memremap.h: In function '__populate_section_memmap':
> include/linux/memremap.h:138:30: note: while referencing 'ranges'
>   138 |                 struct range ranges[0];
>       |                              ^~~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alex Sierra <alex.sierra@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/memremap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 7fcaf3180a5b..1314d9c5f05b 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -135,7 +135,7 @@ struct dev_pagemap {
>  	int nr_range;
>  	union {
>  		struct range range;
> -		struct range ranges[0];
> +		DECLARE_FLEX_ARRAY(struct range, ranges);
>  	};
>  };
>  
> -- 
> 2.34.1
> 
