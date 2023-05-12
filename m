Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8638B7010BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 23:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbjELVM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 17:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjELVMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 17:12:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609E527D;
        Fri, 12 May 2023 14:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F2C4658DA;
        Fri, 12 May 2023 21:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4CCC433D2;
        Fri, 12 May 2023 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683925741;
        bh=Zoj1leKNOORoojkAdze7x3n08l6XVgteqFUXTKCFCkc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M3ZtWdAK1MMtAD8FNsEZczJdw+XPnyFzJ1mypAWweZjCxH9XkbPgy6oQYKemtNBbb
         d+BpEanzSAj6HUjWFaa5N3fe7pykepCAXllNCDKkyOgB07pbN99sLNDtnTYi+Z168p
         NEKtvHnuX9+85HyvhOoYNw6e1vlxJKFweH7tVCUc=
Date:   Fri, 12 May 2023 14:08:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        paulmck@kernel.org, bp@suse.de, peterz@infradead.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        thunder.leizhen@huawei.com, ardb@kernel.org, bhe@redhat.com,
        anshuman.khandual@arm.com, song.bao.hua@hisilicon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] dma-contiguous: support per-numa CMA for all
 architectures
Message-Id: <20230512140859.641222bd40cfa4b1ee591cc6@linux-foundation.org>
In-Reply-To: <20230512094210.141540-1-yajun.deng@linux.dev>
References: <20230512094210.141540-1-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 17:42:10 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> In the commit b7176c261cdb ("dma-contiguous: provide the ability to
> reserve per-numa CMA"), Barry adds DMA_PERNUMA_CMA for ARM64.
> 
> But this feature is architecture independent, so support per-numa CMA
> for all architectures, and enable it by default if NUMA.
> 
> ...
>
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -168,12 +168,6 @@ static inline void dma_free_contiguous(struct device *dev, struct page *page,
>  }
>  #endif /* CONFIG_DMA_CMA*/
>  
> -#ifdef CONFIG_DMA_PERNUMA_CMA
> -void dma_pernuma_cma_reserve(void);
> -#else
> -static inline void dma_pernuma_cma_reserve(void) { }

It would be a little nicer to retain this line.

> -#endif /* CONFIG_DMA_PERNUMA_CMA */
> -
>  #ifdef CONFIG_DMA_DECLARE_COHERENT
>  int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
>  		dma_addr_t device_addr, size_t size);
>
> ...
>
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -128,7 +128,7 @@ static inline __maybe_unused phys_addr_t cma_early_percent_memory(void)
>  #endif
>  
>  #ifdef CONFIG_DMA_PERNUMA_CMA
> -void __init dma_pernuma_cma_reserve(void)
> +static void __init dma_pernuma_cma_reserve(void)
>  {
>  	int nid;
>  
> @@ -153,6 +153,10 @@ void __init dma_pernuma_cma_reserve(void)
>  			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
>  	}
>  }
> +#else
> +static inline void __init dma_pernuma_cma_reserve(void)
> +{
> +}
>  #endif

And to not add this function?
