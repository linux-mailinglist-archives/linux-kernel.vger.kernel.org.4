Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25C56F1682
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjD1LZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 07:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjD1LZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:25:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D325226B1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 04:25:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A003EC14;
        Fri, 28 Apr 2023 04:26:14 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3364F3F64C;
        Fri, 28 Apr 2023 04:25:29 -0700 (PDT)
Date:   Fri, 28 Apr 2023 12:25:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 06/60] arm64: ptdump: Allow VMALLOC_END to be defined
 at boot
Message-ID: <ZEutJgvkrs1QLiQX@FVFF77S0Q05N>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307140522.2311461-7-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 03:04:28PM +0100, Ard Biesheuvel wrote:
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

While it'd be a bit more verbose, I reckon it'd be worth making all of this
dynamically initialized. That would naturally handle things which are not
compile-time constant, and it'd keep all the values in one place, so it's
easier to keep the start/end/name/whatever in sync.

Something like:

| enum address_markers_idx {
| 	MARKER_LINEAR_START,
| 	MARKER_LINEAR_END,
| #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
| 	MARKER_KASAN_START,
| 	MARKER_KASAN_END,
| #endif
| 	MARKER_FOO_START,
| 	MARKER_FOO_END,
| 	MARKER_BAR_START,
| 	MARKER_BAR_END,
| 	MARKER_SENTINEL,
| };
| 
| static __ro_after_init struct addr_marker address_markers[] {
| 	[MARKER_SENTINEL] = {
| 		.start_address = 0,
|		.name = NULL,
| 	}
| };
| 
| static int __init ptdump_init(void)
| {
| 	address_markers[MARKER_LINEAR_START] = (struct addr_marker) {
| 		.start_address = [...],
| 		.name = "Linear mapping start",
| 	};
| 	address_markers[MARKER_LINEAR_END] = (struct addr_marker) {
| 		.start_address = [...],
| 		.name = "Linear mapping end",
| 	};
| 
| #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
| 	address_markers[MARKER_LINEAR_START] = (struct addr_marker) {
| 		.start_adddress = [...],
| 		.name = "KASAN shadow start",
| 	};
| 	address_markers[MARKER_LINEAR_START] = (struct addr_marker) {
| 		.start_adddress = [...],
| 		.name = "KASAN shadow end",
| 	};
| #endif
| 
| 	[...]
|
|  	ptdump_initialize();
|  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
|  	return 0;
| };

Thanks,
Mark.

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
> @@ -379,6 +384,7 @@ static int __init ptdump_init(void)
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  	address_markers[KASAN_START_NR].start_address = KASAN_SHADOW_START;
>  #endif
> +	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
>  	ptdump_initialize();
>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>  	return 0;
> -- 
> 2.39.2
> 
> 
