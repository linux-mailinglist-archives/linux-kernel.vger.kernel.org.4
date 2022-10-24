Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F392360BC82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJXVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 17:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiJXVuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:50:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724529361
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43E5EB810B2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904DDC433D6;
        Mon, 24 Oct 2022 19:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666641258;
        bh=YRD1nZfisTmk9PSTyU7z/uzZUCz4EyKC3M9eXjeC60s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CIX/yThFQOifJaXu5hz+cLAzi6CJNAd2uQiOiW1RKfqS/dojHTnnSU/J2fSePXOIv
         6i5dKd86qriZMtM+zFM5ljeKztF7uWQCsoE9VoLGqnB9za01PJleHtcOi90+MByHRt
         saRRI0Lev8U6PbD+tEjlGDRUqyRSy2CqrgeADjTlq7MMQhvRSVzL+UPOZmAz92Q1UV
         YNw4e1VcNEG/wj83mnXvq3GLKTFJVC6h2FRXrRpmoFdegPeix1VdU2H1sL1lWtXKHN
         wpdiKHuX9rEROzzR0Up9S6W1lNF5u799zxl11SkMoD+w6T5xgdgU3qA+/U+783QL4E
         V31JoiibZN25A==
Date:   Mon, 24 Oct 2022 20:54:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>, arnd@arndb.de
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v5 2/4] RISC-V: Fix MEMREMAP_WB for systems with Svpbmt
Message-ID: <Y1btZRX/e+c+UDyv@spud>
References: <20221020075846.305576-1-apatel@ventanamicro.com>
 <20221020075846.305576-3-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020075846.305576-3-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:28:44PM +0530, Anup Patel wrote:
> Currently, the memremap() called with MEMREMAP_WB maps memory using
> the generic ioremap() function which breaks on system with Svpbmt
> because memory mapped using _PAGE_IOREMAP page attributes is treated
> as strongly-ordered non-cacheable IO memory.
> 
> To address this, we implement RISC-V specific arch_memremap_wb()
> which maps memory using _PAGE_KERNEL page attributes resulting in
> write-back cacheable mapping on systems with Svpbmt.
> 
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Hey Arnd,
Does this look okay to you now?
Thanks,
Conor.

> ---
>  arch/riscv/include/asm/io.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 92080a227937..42497d487a17 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -135,4 +135,9 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>  
>  #include <asm-generic/io.h>
>  
> +#ifdef CONFIG_MMU
> +#define arch_memremap_wb(addr, size)	\
> +	((__force void *)ioremap_prot((addr), (size), _PAGE_KERNEL))
> +#endif
> +
>  #endif /* _ASM_RISCV_IO_H */
> -- 
> 2.34.1
> 
