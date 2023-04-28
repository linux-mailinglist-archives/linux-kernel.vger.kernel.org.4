Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8D6F1685
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjD1L1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjD1L1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:27:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B0CD26BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:27:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72C67C14;
        Fri, 28 Apr 2023 04:28:22 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 341A83F64C;
        Fri, 28 Apr 2023 04:27:37 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:27:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 07/60] arm64: ptdump: Discover start of vmemmap region
 at runtime
Message-ID: <ZEutpu5NKRcuZvTf@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-8-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-8-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:29PM +0100, Ard Biesheuvel wrote:
> We will soon reclaim the part of the vmemmap region that covers VA space
> that is not addressable by the hardware. To avoid confusion, ensure that
> the 'vmemmap start' marker points at the start of the region that is
> actually being used for the struct page array, rather than the start of
> the region we set aside for it at build time.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/ptdump.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 910b35f02280cbdb..8f37d6d8b5216473 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -37,6 +37,7 @@ enum address_markers_idx {
>  	MODULES_END_NR,
>  	VMALLOC_START_NR,
>  	VMALLOC_END_NR,
> +	VMEMMAP_START_NR,
>  };
>  
>  static struct addr_marker address_markers[] = {
> @@ -386,6 +387,10 @@ static int __init ptdump_init(void)
>  #endif
>  	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
>  	ptdump_initialize();
> +	if (vabits_actual < VA_BITS) {
> +		address_markers[VMEMMAP_START_NR].start_address =
> +			(unsigned long)virt_to_page(_PAGE_OFFSET(vabits_actual));
> +	}

As Ryan suggested, I think it'd be worth doing this unconditionally, to keep
this simple.

Mark.

>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>  	return 0;
>  }
> -- 
> 2.39.2
> 
> 
