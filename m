Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70696CD0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjC2D1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC2D1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:27:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE3270D;
        Tue, 28 Mar 2023 20:27:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmX735qqJz4whh;
        Wed, 29 Mar 2023 14:27:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1680060467;
        bh=NWEC9L1N6Gkm8hPWtsZhECzqXf6jCt48G2Nqg5hBXvE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SAWjgkM8buDl+QGSlnMNlFfgO8XDbaheTTxegHJeT8I9RxjC69eo0Kqm5o7HhOfVq
         pdBn9kfpreHiPsYCcnDs7VUFT5T5A83HBfyuowLBZ5r3UmbbZmIkUBTXHb8C/zYUTl
         hEO+2u3JYAO36dtGtL+VJUYzZ9mK+Xi5sEx0ybcukCmpGSIjRCWOZe4a8fkVYXmck4
         bDLJ9L25893BDL64x2oUJStfo7XSuIQ5SU0FzQTwRLDJ2/IgX3oTpc0qH07mLM08Tf
         uybEEoCv8kc9mlfe/94vD2n7j+eArEJqBCLtujEMR6lxKa+vMrtKuif6ZsQgKmuXdM
         3m1++1phqhrYg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
        palmer@dabbelt.com, robh+dt@kernel.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        linux-riscv@lists.infradead.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH v3 4/4] of: address: Always use dma_default_coherent for
 default coherency
In-Reply-To: <20230321110813.26808-5-jiaxun.yang@flygoat.com>
References: <20230321110813.26808-1-jiaxun.yang@flygoat.com>
 <20230321110813.26808-5-jiaxun.yang@flygoat.com>
Date:   Wed, 29 Mar 2023 14:27:39 +1100
Message-ID: <877cv0ck44.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiaxun Yang <jiaxun.yang@flygoat.com> writes:
> As for now all arches have dma_default_coherent reflecting default
> DMA coherency for of devices, so there is no need to have a standalone
> config option.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v3: Squash setting ARCH_DMA_DEFAULT_COHERENT into this patch.
> ---
>  arch/powerpc/Kconfig |  2 +-
>  arch/riscv/Kconfig   |  2 +-
>  drivers/of/Kconfig   |  4 ----
>  drivers/of/address.c | 10 +---------
>  4 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 57f5d2f53d06..824e00a1277b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -113,6 +113,7 @@ config PPC
>  	#
>  	select ARCH_32BIT_OFF_T if PPC32
>  	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
> +	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE
>  	select ARCH_HAS_COPY_MC			if PPC64
> @@ -273,7 +274,6 @@ config PPC
>  	select NEED_PER_CPU_PAGE_FIRST_CHUNK	if PPC64
>  	select NEED_SG_DMA_LENGTH
>  	select OF
> -	select OF_DMA_DEFAULT_COHERENT		if !NOT_COHERENT_CACHE
>  	select OF_EARLY_FLATTREE
>  	select OLD_SIGACTION			if PPC32
>  	select OLD_SIGSUSPEND

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
