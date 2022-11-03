Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C54617703
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 07:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKCG5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 02:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKCG5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 02:57:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806DA1098;
        Wed,  2 Nov 2022 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ErfX8wwiBaePFzimvdgizpup2CMU7DoVibdJu/pLjAc=; b=AfGvB3py/fwwPQVK03dwMQLLqw
        IRISq2R6gqsier1QmIdBLR8kmkt4eP7eVFxyutJsmaG0lFgSQI0r5/xei/fniWIXtWYNRPCUmQC24
        vRjj9bUzwYKwwtVNTVdvOvVfu4cOuikMZn9VpgsnxffHXTmwsRi2UY2ixlHRlVt7RPskShKG85O6v
        sOtFt2yBMtxpW0ZSiF4AeRdiQEfiifVDJ6bfZdBv3CQW20RKSJ/p4ZIB6z1HxrJ9ybM8heHEm0yBs
        g6Ci/JP4G5UPWqZdWpY7ooo6y32HQx863Rsgrdxo4jKaY6zeXcF+ggXRzD2OXvu21rNPXNggI36gZ
        Lgl6tB5Q==;
Received: from [2601:1c2:d80:3110:e65e:37ff:febd:ee53]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqU9j-00GMHr-Jn; Thu, 03 Nov 2022 06:56:52 +0000
Message-ID: <79dcc638-873c-5ec6-e168-314a7a24eaf1@infradead.org>
Date:   Wed, 2 Nov 2022 23:56:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] sh: init: use OF_EARLY_FLATTREE for early init
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org
References: <20221006234240.7755-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221006234240.7755-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/6/22 16:42, Randy Dunlap wrote:
> When CONFIG_OF_EARLY_FLATTREE and CONFIG_SH_DEVICE_TREE are not set,
> SH3 build fails with a call to early_init_dt_scan(), so in
> arch/sh/kernel/setup.c and arch/sh/kernel/head_32.S, use
> CONFIG_OF_EARLY_FLATTREE instead of CONFIG_OF_FLATTREE.
> 
> Fixes this build error:
> ../arch/sh/kernel/setup.c: In function 'sh_fdt_init':
> ../arch/sh/kernel/setup.c:262:26: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]
>   262 |         if (!dt_virt || !early_init_dt_scan(dt_virt)) {
> 
> Fixes: 03767daa1387 ("sh: fix build regression with CONFIG_OF && !CONFIG_OF_FLATTREE")
> Fixes: eb6b6930a70f ("sh: fix memory corruption of unflattened device tree")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: Rich Felker <dalias@libc.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-sh@vger.kernel.org

Is anyone merging arch/sh/ patches now? or even commenting on them?
Thanks.

> ---
>  arch/sh/kernel/head_32.S |    6 +++---
>  arch/sh/kernel/setup.c   |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -244,7 +244,7 @@ void __init __weak plat_early_device_set
>  {
>  }
>  
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
>  void __ref sh_fdt_init(phys_addr_t dt_phys)
>  {
>  	static int done = 0;
> @@ -326,7 +326,7 @@ void __init setup_arch(char **cmdline_p)
>  	/* Let earlyprintk output early console messages */
>  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
>  
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
>  #ifdef CONFIG_USE_BUILTIN_DTB
>  	unflatten_and_copy_device_tree();
>  #else
> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -64,7 +64,7 @@ ENTRY(_stext)
>  	ldc	r0, r6_bank
>  #endif
>  
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
>  	mov	r4, r12		! Store device tree blob pointer in r12
>  #endif
>  	
> @@ -315,7 +315,7 @@ ENTRY(_stext)
>  10:		
>  #endif
>  
> -#ifdef CONFIG_OF_FLATTREE
> +#ifdef CONFIG_OF_EARLY_FLATTREE
>  	mov.l	8f, r0		! Make flat device tree available early.
>  	jsr	@r0
>  	 mov	r12, r4
> @@ -346,7 +346,7 @@ ENTRY(stack_start)
>  5:	.long	start_kernel
>  6:	.long	cpu_init
>  7:	.long	init_thread_union
> -#if defined(CONFIG_OF_FLATTREE)
> +#if defined(CONFIG_OF_EARLY_FLATTREE)
>  8:	.long	sh_fdt_init
>  #endif
>  

-- 
~Randy
