Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9515E851D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIWVpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWVpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:45:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD513E18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 14:45:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30AB6B80E29
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 21:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75A8C433D6;
        Fri, 23 Sep 2022 21:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663969546;
        bh=QPQtMFO6u2PmeaIikpsa/EjuxmbTB4kLNdGuaZmww34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIq5/7SvMl31k0Ey8jEXzKmzLQjpmUgoDsgglrRObgHhid+N7TERc0fTfQjzJXLa3
         64lL78hQJSBg1fwcJIQ3ScRHNaBpKjNreg4WEPVIWK10rvc1OD5jjziwLhx2AQ9Qrz
         zonMZeJeUKIZm+8ww+0d6tJ3mZ1a2vg0HZsRhwAhdZ6yiJdcnDDmY8JwviSTRaukUJ
         Uq/ThuHEmy4ZRFfDUZc1+EQZlgGRHu7lqlGUUT/kjcwkK0t6L67dcGuJUpw4yVTY3E
         XEn8HZv7bu7Z5bTyHaTumL9y3Z2OOGG38+hKcM78Zm8aXpe+JYzssPgTN8I8RDi6Fy
         RgYmw5RfPrRwg==
Date:   Fri, 23 Sep 2022 22:45:40 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jinyu Tang <tjytimi@163.com>
Cc:     paul.walmsley@sifive.com, ajones@ventanamicro.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        conor.dooley@microchip.com, anup@brainfault.org,
        alexandre.ghiti@canonical.com, guoren@kernel.org,
        akpm@linux-foundation.org, heiko@sntech.de, tongtiangen@huawei.com,
        sunnanyong@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org
Subject: Re: [PATCH v2] riscv: support update_mmu_tlb() for riscv
Message-ID: <Yy4pBHm1fZ3oM/m5@spud>
References: <20220918055940.24726-1-tjytimi@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918055940.24726-1-tjytimi@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jinyu,
Firstly, the "for riscv" in the title is redundant and can be dropped.

On Sun, Sep 18, 2022 at 01:59:40PM +0800, Jinyu Tang wrote:
> Add macro definition to support updata_mmu_tlb() for riscv,
                                       ^
				s/updata/update/

> this function is from commit:7df676974359 ("mm/memory.c:Update
> local TLB if PTE entry exists").

So, and this just may be may lack of knowledge showing, but I don't
really understand _why_ we need this change. Your commit message should
explain why you are making the change rather than just repeating what
you are doing since that is obvious from the diff.

Only MIPS seems to have this define, so your commit message needs to
explain what it is about RISC-V that means we need it when all bar one
arch does not.

Thanks,
Conor.

> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> v1 -> v2: 
> 
> Change the format with the help from Andrew Jones and Conor Dooley.
> 
>  arch/riscv/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..c61ae83aadee 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -418,6 +418,9 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  	local_flush_tlb_page(address);
>  }
>  
> +#define __HAVE_ARCH_UPDATE_MMU_TLB
> +#define update_mmu_tlb update_mmu_cache
> +
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  		unsigned long address, pmd_t *pmdp)
>  {
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
