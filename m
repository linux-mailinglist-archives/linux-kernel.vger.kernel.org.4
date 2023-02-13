Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFB694D89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjBMQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBMQ53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:57:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005A1DBB7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:57:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A06BACE1C32
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 16:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B47C4339C;
        Mon, 13 Feb 2023 16:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307438;
        bh=ef21h0MzKbePTAgMmCqsteVlUArbe4r01a+6XKMdXIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I7lvMHaI8QA86U3B12poWtqC4oevr297M5WJcVJ0TnLjkHetcquXI9u9aOFB706/a
         sE0uBXUmjlXueH1R9QNWRaFuPd4FeMSW228GKkBdkhZKKS9+Jv6wkNQ6GzTsgjaj+i
         a/vUGbyCfpVFmw3jnhlUmpOm7bx3z6lpW+0eM52Urw7j52FSx0vfVcFYQkRBGs/IPD
         yy/5eUlNucMqgWE8uQCtqAKVnAU1kOtgdtqoAH5GodI4BumKxvkkafQ2NbGVWwnCST
         JrCIQE+Yrxv5P/i6SOdZwj6dN7B5+/JAqsKvDBhMwxA+ehSVynjqFPybfQadwLoZAK
         9xmX+jDzVA4mg==
Date:   Tue, 14 Feb 2023 00:46:47 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>,
        Christoph Muellner <christoph.muellner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Fix early alternative patching
Message-ID: <Y+ppd3YEM0BB6O5l@xhacker>
References: <20230212021534.59121-1-samuel@sholland.org>
 <20230212021534.59121-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230212021534.59121-2-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 08:15:32PM -0600, Samuel Holland wrote:
> Now that the text to patch is located using a relative offset from the
> alternative entry, the text address should be computed without applying
> the kernel mapping offset, both before and after VM setup.

Good catch!
> 
> Fixes: 8d23e94a4433 ("riscv: switch to relative alternative entries")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
>  arch/riscv/errata/thead/errata.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index c0bea5c94128..1dd90a5f86f0 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -102,9 +102,7 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>  
>  			/* On vm-alternatives, the mmu isn't running yet */
>  			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -				memcpy((void *)__pa_symbol(oldptr),
> -				       (void *)__pa_symbol(altptr),
> -				       alt->alt_len);
> +				memcpy(oldptr, altptr, alt->alt_len);
>  			else
>  				patch_text_nosync(oldptr, altptr, alt->alt_len);
>  		}
> -- 
> 2.37.4
> 
