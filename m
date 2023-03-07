Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6E6AE6D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjCGQjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:39:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4F093860
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:36:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1DD211FB;
        Tue,  7 Mar 2023 08:37:02 -0800 (PST)
Received: from [10.1.29.181] (C02CF1NRLVDN.cambridge.arm.com [10.1.29.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22B433F67D;
        Tue,  7 Mar 2023 08:36:18 -0800 (PST)
Message-ID: <e26236c5-d4ea-caf3-eeee-5c88a6814ea4@arm.com>
Date:   Tue, 7 Mar 2023 16:36:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 07/60] arm64: ptdump: Discover start of vmemmap region
 at runtime
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-8-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-8-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
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

nit: Do you need the conditional here? Why not just do it unconditionally?

>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>  	return 0;
>  }

