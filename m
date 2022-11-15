Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F3F62AF9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiKOXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKOXn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:43:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F6531379;
        Tue, 15 Nov 2022 15:43:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 595FDB81B58;
        Tue, 15 Nov 2022 23:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48B2C433D6;
        Tue, 15 Nov 2022 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668555834;
        bh=nHyx5VBKR1ORkS34RAGCTC2XAeY+SuDji/GewtsXumY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbVDWoFVt706qP7k+L3826/Urt+3ZTULCYCAjXz+J6L3HkiENUWMxciuGg6cecvdV
         j0OYO2fL2c7NwpRDML1itrnR7+BwcqEUZy7+mTvHnYFEaowUY8XrkgeUcw6rJ5G6BE
         jqSgqao82WVMdFmcJKv1Sn/7LWj4XPeUvNQwrv8ZdDJax4xi9YKYeHyqHQRn9lu0Wo
         m5TdkFj12KldXeJDaKYd09tjRmX7Ncgr0/8EFfSvEzoMTzbdFCOvdsFohl9WY+PZCL
         thHaYHoumjqwxPrSZm4JzfVEUcnGgRWhjk7VItCEYBV/0HNAXFPTLbmrO6BW1GhmZJ
         JXTbVX9DWCz0Q==
Date:   Wed, 16 Nov 2022 01:43:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     ira.weiny@intel.com, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y3QkNj4AWRSsfFst@kernel.org>
References: <20221115161627.4169428-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115161627.4169428-1-kristen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:16:26AM -0800, Kristen Carlson Accardi wrote:
> kmap_local_page() is the preferred way to create temporary mappings
> when it is feasible, because the mappings are thread-local and
> CPU-local. kmap_local_page() uses per-task maps rather than per-CPU
> maps. This in effect removes the need to preemption in the
> local CPU while kmap is active, and thus vastly reduces overall
> system latency. It is also valid to take pagefaults.
> 
> The use of kmap_atomic() in the SGX code was not an explicit design
> choice to disable page faults or preemption, and there is no compelling
> design reason to using kmap_atomic() vs. kmap_local_page().
> 
> Link: https://lore.kernel.org/linux-sgx/Y0biN3%2FJsZMa0yUr@kernel.org/
> 
> For more information on the use of kmap_local_page() vs.
> kmap_atomic(), please see Documentation/mm/highmem.rst
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
> Changes since V1:
> 
> - Reword commit message to make it more clear why it is preferred
>   to use kmap_local_page() vs. kmap_atomic().
> 
>  arch/x86/kernel/cpu/sgx/encl.c  | 12 ++++++------
>  arch/x86/kernel/cpu/sgx/ioctl.c |  4 ++--
>  arch/x86/kernel/cpu/sgx/main.c  |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 2c258255a629..68f8b18d2278 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -160,8 +160,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  		return ret;
>  
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
> -	pginfo.contents = (unsigned long)kmap_atomic(b.contents);
> -	pcmd_page = kmap_atomic(b.pcmd);
> +	pginfo.contents = (unsigned long)kmap_local_page(b.contents);
> +	pcmd_page = kmap_local_page(b.pcmd);
>  	pginfo.metadata = (unsigned long)pcmd_page + b.pcmd_offset;
>  
>  	if (secs_page)
> @@ -187,8 +187,8 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  	 */
>  	pcmd_page_empty = !memchr_inv(pcmd_page, 0, PAGE_SIZE);
>  
> -	kunmap_atomic(pcmd_page);
> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local(pcmd_page);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	get_page(b.pcmd);
>  	sgx_encl_put_backing(&b);
> @@ -197,10 +197,10 @@ static int __sgx_encl_eldu(struct sgx_encl_page *encl_page,
>  
>  	if (pcmd_page_empty && !reclaimer_writing_to_pcmd(encl, pcmd_first_page)) {
>  		sgx_encl_truncate_backing_page(encl, PFN_DOWN(page_pcmd_off));
> -		pcmd_page = kmap_atomic(b.pcmd);
> +		pcmd_page = kmap_local_page(b.pcmd);
>  		if (memchr_inv(pcmd_page, 0, PAGE_SIZE))
>  			pr_warn("PCMD page not empty after truncate.\n");
> -		kunmap_atomic(pcmd_page);
> +		kunmap_local(pcmd_page);
>  	}
>  
>  	put_page(b.pcmd);
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index ef874828fa6b..03c50f11ad75 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -221,11 +221,11 @@ static int __sgx_encl_add_page(struct sgx_encl *encl,
>  	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
>  	pginfo.addr = encl_page->desc & PAGE_MASK;
>  	pginfo.metadata = (unsigned long)secinfo;
> -	pginfo.contents = (unsigned long)kmap_atomic(src_page);
> +	pginfo.contents = (unsigned long)kmap_local_page(src_page);
>  
>  	ret = __eadd(&pginfo, sgx_get_epc_virt_addr(epc_page));
>  
> -	kunmap_atomic((void *)pginfo.contents);
> +	kunmap_local((void *)pginfo.contents);
>  	put_page(src_page);
>  
>  	return ret ? -EIO : 0;
> diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
> index 0aad028f04d4..e5a37b6e9aa5 100644
> --- a/arch/x86/kernel/cpu/sgx/main.c
> +++ b/arch/x86/kernel/cpu/sgx/main.c
> @@ -165,17 +165,17 @@ static int __sgx_encl_ewb(struct sgx_epc_page *epc_page, void *va_slot,
>  	pginfo.addr = 0;
>  	pginfo.secs = 0;
>  
> -	pginfo.contents = (unsigned long)kmap_atomic(backing->contents);
> -	pginfo.metadata = (unsigned long)kmap_atomic(backing->pcmd) +
> +	pginfo.contents = (unsigned long)kmap_local_page(backing->contents);
> +	pginfo.metadata = (unsigned long)kmap_local_page(backing->pcmd) +
>  			  backing->pcmd_offset;
>  
>  	ret = __ewb(&pginfo, sgx_get_epc_virt_addr(epc_page), va_slot);
>  	set_page_dirty(backing->pcmd);
>  	set_page_dirty(backing->contents);
>  
> -	kunmap_atomic((void *)(unsigned long)(pginfo.metadata -
> +	kunmap_local((void *)(unsigned long)(pginfo.metadata -
>  					      backing->pcmd_offset));
> -	kunmap_atomic((void *)(unsigned long)pginfo.contents);
> +	kunmap_local((void *)(unsigned long)pginfo.contents);
>  
>  	return ret;
>  }
> -- 
> 2.38.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
