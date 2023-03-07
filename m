Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263E6AE7DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCGREM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCGRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:03:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D65A93105
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:59:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9882611FB;
        Tue,  7 Mar 2023 08:59:34 -0800 (PST)
Received: from [10.1.29.181] (C02CF1NRLVDN.cambridge.arm.com [10.1.29.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F7BE3F67D;
        Tue,  7 Mar 2023 08:58:49 -0800 (PST)
Message-ID: <448139c7-bef0-3ddc-388c-db793a37d55e@arm.com>
Date:   Tue, 7 Mar 2023 16:58:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 06/60] arm64: ptdump: Allow VMALLOC_END to be defined
 at boot
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-7-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-7-ardb@kernel.org>
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
> Extend the existing pattern for populating ptdump marker entries at
> boot, and add handling of VMALLOC_END, which will cease to be a compile
> time constant for configurations that support 52-bit virtual addressing.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/ptdump.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 76d28056bd14920a..910b35f02280cbdb 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -31,7 +31,12 @@ enum address_markers_idx {
>  	PAGE_END_NR,
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  	KASAN_START_NR,
> +	KASAN_END_NR,
>  #endif
> +	MODULES_NR,
> +	MODULES_END_NR,
> +	VMALLOC_START_NR,
> +	VMALLOC_END_NR,
>  };
>  
>  static struct addr_marker address_markers[] = {
> @@ -44,7 +49,7 @@ static struct addr_marker address_markers[] = {
>  	{ MODULES_VADDR,		"Modules start" },
>  	{ MODULES_END,			"Modules end" },
>  	{ VMALLOC_START,		"vmalloc() area" },
> -	{ VMALLOC_END,			"vmalloc() end" },
> +	{ 0,				"vmalloc() end" },
>  	{ VMEMMAP_START,		"vmemmap start" },
>  	{ VMEMMAP_START + VMEMMAP_SIZE,	"vmemmap end" },
>  	{ PCI_IO_START,			"PCI I/O start" },

With all the VA layout changes, and the addition of 52-bit PA/VA for 4KB and
16KB pages, Documentation/arm64/memory.rst now looks very wrong. Suggest
updating it to reflect reality?



> @@ -379,6 +384,7 @@ static int __init ptdump_init(void)
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
>  #endif
> +	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
>  	ptdump_initialize();
>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>  	return 0;

