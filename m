Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5776EC78D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjDXIBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXIBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:01:49 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F6F11B;
        Mon, 24 Apr 2023 01:01:48 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pqr8r-0002pn-00; Mon, 24 Apr 2023 10:01:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3D49BC021A; Mon, 24 Apr 2023 10:01:24 +0200 (CEST)
Date:   Mon, 24 Apr 2023 10:01:24 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Henry Willard <henry.willard@oracle.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MIPS: Don't clear _PAGE_SPECIAL in _PAGE_CHG_MASK
Message-ID: <20230424080124.GA4889@alpha.franken.de>
References: <20230412212953.388185-1-henry.willard@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412212953.388185-1-henry.willard@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 03:29:53PM -0600, Henry Willard wrote:
> In the special case where
> 
> 	p = mmap(NULL, ALLOC_SIZE, PROT_READ,
>                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 
> is followed by
> 
> 	rc = mprotect(p, ALLOC_SIZE, PROT_NONE);
> 
> the _PAGE_SPECIAL bit in the page tables will be cleared by
> mistake and the later unmapped operations will incorrectly
> modify the struct page for the the zero page. This sequence
> occurs in the madvise05 test of the Linux Test Project
> suite of tests.
> 
> This was discovered while testing an older version of the kernel
> (5.4.17) on a MIPS device. Unfortunately, support for this device
> is not available in newer kernels, so I can't test this with the
> latest Linux kernel code. It looks like the problem exists in
> newer kernels, but I can't verify it. Except for the LTP test,
> this sequence of calls is probably not common.
> 
> Passing it along in the hope it will be useful to someone.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  arch/mips/include/asm/pgtable-bits.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/pgtable-bits.h b/arch/mips/include/asm/pgtable-bits.h
> index 2362842ee2b5..1c576679aa87 100644
> --- a/arch/mips/include/asm/pgtable-bits.h
> +++ b/arch/mips/include/asm/pgtable-bits.h
> @@ -280,6 +280,7 @@ static inline uint64_t pte_to_entrylo(unsigned long pte_val)
>  #define __WRITEABLE	(_PAGE_SILENT_WRITE | _PAGE_WRITE | _PAGE_MODIFIED)
>  
>  #define _PAGE_CHG_MASK	(_PAGE_ACCESSED | _PAGE_MODIFIED |	\
> -			 _PAGE_SOFT_DIRTY | _PFN_MASK | _CACHE_MASK)
> +			 _PAGE_SOFT_DIRTY | _PFN_MASK |   \
> +			 _CACHE_MASK | _PAGE_SPECIAL)
>  
>  #endif /* _ASM_PGTABLE_BITS_H */
> -- 
> 2.31.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
