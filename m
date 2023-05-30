Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B5E716CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjE3Sz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjE3SzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:55:17 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C1102
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685472916; x=1717008916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u10ZnlSerg/CGRanwO7hyufpJ+ugNruAR/D+4L2bQtg=;
  b=UlWTYu6BqcEJGksg5ks0ubum5+skvAbebk5cund6DQJqSTfkE4xkTQuN
   t//sC2lxFne7Zr2BCiGGP1btkMz1lddNZAgUx9B0HgEL5/NH/j2VcfYAt
   uysc5Nr8rmlSKO/edfZTOwCNkiA2G+hQoWoNZyfId+mxUQOe1NvGOyIsG
   0QvqXNqEBTAGHhrmsFVNnxDIF/ANyTRQFYag3MuRgoCOB2nrldGUrl3cT
   P4hQZvxsaPXgO1RYNks2eQxHXJzeYOSGYxzFF42+QoYrTZkSnWKGw+Dd4
   Qwuz6tIAkrWpmQ5DhQKMIUSi5uc+feH5j/Zpghupp3Z3UE4pCF95//BQz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353858168"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353858168"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 11:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="656983702"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="656983702"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.140.233])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 11:55:15 -0700
Date:   Tue, 30 May 2023 11:55:14 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/sev: Move sev_setup_arch() to mem_encrypt.c
Message-ID: <ZHZGkulyli8MvXRR@aschofie-mobl2>
References: <20230530121728.28854-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530121728.28854-1-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 03:17:28PM +0300, Alexander Shishkin wrote:
> Since commit 4d96f9109109b ("x86/sev: Replace occurrences of
> sev_active() with cc_platform_has()"), the SWIOTLB bounce buffer size
> adjustment and restricted virtio memory setting also inadvertently apply
> to TDX, which just happens to be what we want.

Hi Alexander,

Can you offer more context on how this inadvertently applies?

One bit below...


> 
> To reflect this, move the corresponding code to generic mem_encrypt.c.
> No functional changes intended.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h | 11 ++++++++--
>  arch/x86/kernel/setup.c            |  2 +-
>  arch/x86/mm/mem_encrypt.c          | 34 ++++++++++++++++++++++++++++++
>  arch/x86/mm/mem_encrypt_amd.c      | 34 ------------------------------
>  4 files changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index b7126701574c..4283063c1e1c 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -37,7 +37,6 @@ void __init sme_map_bootdata(char *real_mode_data);
>  void __init sme_unmap_bootdata(char *real_mode_data);
>  
>  void __init sme_early_init(void);
> -void __init sev_setup_arch(void);
>  
>  void __init sme_encrypt_kernel(struct boot_params *bp);
>  void __init sme_enable(struct boot_params *bp);
> @@ -67,7 +66,6 @@ static inline void __init sme_map_bootdata(char *real_mode_data) { }
>  static inline void __init sme_unmap_bootdata(char *real_mode_data) { }
>  
>  static inline void __init sme_early_init(void) { }
> -static inline void __init sev_setup_arch(void) { }
>  
>  static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
>  static inline void __init sme_enable(struct boot_params *bp) { }
> @@ -92,6 +90,15 @@ void __init mem_encrypt_init(void);
>  
>  void add_encrypt_protection_map(void);
>  
> +#ifdef CONFIG_X86_MEM_ENCRYPT
> +
> +void __init mem_encrypt_setup_arch(void);
> +
> +#else	/* !CONFIG_X86_MEM_ENCRYPT */
> +
> +static inline void __init mem_encrypt_setup_arch(void) { }
> +
> +#endif	/* CONFIG_X86_MEM_ENCRYPT */
>  /*
>   * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
>   * writing to or comparing values from the cr3 register.  Having the
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 16babff771bd..e2aa1d5b37a9 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1121,7 +1121,7 @@ void __init setup_arch(char **cmdline_p)
>  	 * Needs to run after memblock setup because it needs the physical
>  	 * memory size.
>  	 */
> -	sev_setup_arch();
> +	mem_encrypt_setup_arch();
>  
>  	efi_fake_memmap();
>  	efi_find_mirror();
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 9f27e14e185f..c290c55b632b 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -12,6 +12,7 @@
>  #include <linux/swiotlb.h>
>  #include <linux/cc_platform.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/virtio_anchor.h>

It looks like this #include can be removed from mem_encrypt_amd.c 

Alison

>  
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
> @@ -86,3 +87,36 @@ void __init mem_encrypt_init(void)
>  
>  	print_mem_encrypt_feature_info();
>  }
> +
> +void __init mem_encrypt_setup_arch(void)
> +{
> +	phys_addr_t total_mem = memblock_phys_mem_size();
> +	unsigned long size;
> +
> +	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> +		return;
> +
> +	/*
> +	 * For SEV and TDX, all DMA has to occur via shared/unencrypted pages.
> +	 * Kernel uses SWIOTLB to make this happen without changing device
> +	 * drivers. However, depending on the workload being run, the
> +	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> +	 * run out of buffers for DMA, resulting in I/O errors and/or
> +	 * performance degradation especially with high I/O workloads.
> +	 *
> +	 * Adjust the default size of SWIOTLB using a percentage of guest
> +	 * memory for SWIOTLB buffers. Also, as the SWIOTLB bounce buffer
> +	 * memory is allocated from low memory, ensure that the adjusted size
> +	 * is within the limits of low available memory.
> +	 *
> +	 * The percentage of guest memory used here for SWIOTLB buffers
> +	 * is more of an approximation of the static adjustment which
> +	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> +	 */
> +	size = total_mem * 6 / 100;
> +	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> +	swiotlb_adjust_size(size);
> +
> +	/* Set restricted memory access for virtio. */
> +	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> +}
> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index e0b51c09109f..3b95e6fdf160 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -215,40 +215,6 @@ void __init sme_map_bootdata(char *real_mode_data)
>  	__sme_early_map_unmap_mem(__va(cmdline_paddr), COMMAND_LINE_SIZE, true);
>  }
>  
> -void __init sev_setup_arch(void)
> -{
> -	phys_addr_t total_mem = memblock_phys_mem_size();
> -	unsigned long size;
> -
> -	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		return;
> -
> -	/*
> -	 * For SEV, all DMA has to occur via shared/unencrypted pages.
> -	 * SEV uses SWIOTLB to make this happen without changing device
> -	 * drivers. However, depending on the workload being run, the
> -	 * default 64MB of SWIOTLB may not be enough and SWIOTLB may
> -	 * run out of buffers for DMA, resulting in I/O errors and/or
> -	 * performance degradation especially with high I/O workloads.
> -	 *
> -	 * Adjust the default size of SWIOTLB for SEV guests using
> -	 * a percentage of guest memory for SWIOTLB buffers.
> -	 * Also, as the SWIOTLB bounce buffer memory is allocated
> -	 * from low memory, ensure that the adjusted size is within
> -	 * the limits of low available memory.
> -	 *
> -	 * The percentage of guest memory used here for SWIOTLB buffers
> -	 * is more of an approximation of the static adjustment which
> -	 * 64MB for <1G, and ~128M to 256M for 1G-to-4G, i.e., the 6%
> -	 */
> -	size = total_mem * 6 / 100;
> -	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
> -	swiotlb_adjust_size(size);
> -
> -	/* Set restricted memory access for virtio. */
> -	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
> -}
> -
>  static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
>  {
>  	unsigned long pfn = 0;
> -- 
> 2.39.2
> 
