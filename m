Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B405D6B72DB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCMJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCMJnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:43:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F41D318
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:43:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x22so1969780wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1678700588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxxClasutQ5PqW8TvU53BWsXOs7xcuC+RTlUJtJP2sQ=;
        b=h3TDpuYDAZfdPTrBvLxzsaXRKlJ9Q2jh2tNMraEiLGXymopAzOnui7kQZzxhmFXH8J
         QUQb19c/7fWEfIxTecp+uIIBJrB4l2pT6kLWe6Lcaz/zDH8THjKLVjJbb0HtACHBiMfZ
         sPAK1rVIqSfxNdNUlxieZptHZPSRh3jCXGTJG6+12nVcrQ1MA8olf1I7EQKV61Jo7m1N
         Mme6I5sKzEsCzXwBaISzU8LY/lW8feJ9hfbB39JCJdGmp102x/WISLrY9w13owNvQOuD
         TixAk0UX6bQnuIMDAOivDU2sfb/YGuYJrrDmJj+peefVIY6wb/UtTVcpuXxE849Hpfgn
         NcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxxClasutQ5PqW8TvU53BWsXOs7xcuC+RTlUJtJP2sQ=;
        b=3RkIizy/oqcZiHOK40iqDgaDR5kcvwOZquxe3G0k/mZ0LnZzLb4JzQXrTa1fJEILAC
         H40WcYTnuJJzq6mRlWVPHwe1gPw57FdBeB18+f01ecpAMJKnGCrytgTqMhQ3eR1gvRmE
         0Ta6x1RXd7gv940IiEIqISVToRo4MrXMTAc18Zndx9IpvCxvndmZah7LYnrMNWaTpPn7
         NZDV/59SgV/JBA7uIGEgF1CNxHmcFHpObYBX5BhtlHT3FsQFLiJWhIRrtD2Q2z50lAzf
         K618Ql0VR/ndZw3RMM4aSPUYEVF8/eDrBQolxrHg2HQaSZL0ktpUjnkTGu0boXMZVzce
         dxkQ==
X-Gm-Message-State: AO0yUKVoBFOvqpVjcvKFDScOeFoBkUfZoa6aqblJgvLJK6ZlEeHXuyzA
        rf7p95C1VGSS8tUIJzlk2a25Bw==
X-Google-Smtp-Source: AK7set/gu2v5+Z4pvLuyJomxbp4JRixpfwOaaAR1zN7y2b+8QDashQHnd4D6nxFOJYocB2azbkFjxw==
X-Received: by 2002:a05:600c:4ed4:b0:3ed:26c1:8e5a with SMTP id g20-20020a05600c4ed400b003ed26c18e5amr1294483wmq.10.1678700588496;
        Mon, 13 Mar 2023 02:43:08 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c444700b003e204fdb160sm9192391wmn.3.2023.03.13.02.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:43:08 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:43:06 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v7 3/4] arm64: Make use of memblock_isolate_memory for
 the linear mapping
Message-ID: <20230313094306.6kslmrdixuw75iqf@orel>
References: <20230310094539.764357-1-alexghiti@rivosinc.com>
 <20230310094539.764357-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310094539.764357-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:45:38AM +0100, Alexandre Ghiti wrote:
> In order to isolate the kernel text mapping, we used some sort of hack
> to isolate the kernel text range which consisted in marking this region
> as not mappable with memblock_mark_nomap. Simply use the newly introduced
> memblock_isolate_memory function which does exactly the same but does not
> uselessly mark the region as not mappable.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 6f9d8898a025..408dc852805c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -552,7 +552,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	 * So temporarily mark them as NOMAP to skip mappings in
>  	 * the following for-loop
>  	 */

The comment above doesn't apply anymore.

> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> +	memblock_isolate_memory(kernel_start, kernel_end - kernel_start);
>  
>  #ifdef CONFIG_KEXEC_CORE
>  	if (crash_mem_map) {
> @@ -568,6 +568,7 @@ static void __init map_mem(pgd_t *pgdp)
>  	for_each_mem_range(i, &start, &end) {
>  		if (start >= end)
>  			break;
> +

Mark nomap is also used for the crash kernel. Does the new API not work
for it?

Thanks,
drew

>  		/*
>  		 * The linear map must allow allocation tags reading/writing
>  		 * if MTE is present. Otherwise, it has the same attributes as
> @@ -589,7 +590,6 @@ static void __init map_mem(pgd_t *pgdp)
>  	 */
>  	__map_memblock(pgdp, kernel_start, kernel_end,
>  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  
>  	/*
>  	 * Use page-level mappings here so that we can shrink the region
> -- 
> 2.37.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
