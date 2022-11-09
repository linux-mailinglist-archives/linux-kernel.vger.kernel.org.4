Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79311622760
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiKIJpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKIJpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:45:08 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BAB22BE4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:45:06 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n12so45072033eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7BBB8xDOLrGj/n4axVE8aotQ6PZ5hPRMhS37GmQebc=;
        b=F3rkkRm3j93Q8U75DVkZplGIZM1Qb4y4/V9UgyDd6ptsi2lOEtjbMQ28O9BVGB+9Kh
         xMJOU6odQp9x90Uj9rqWswE2TWmdc/roHyEBMNTWBhqPpKPwHDuth/1v3U8vYwqt24II
         4gYJVrCZ0qnJRbWBb3RKXT3H3/ewZkBUSV80505yz4cZQKi0GzFN52vW8+772lnoGgXk
         AFzOdDmK0ksZwUDH+gZsWDdapGtdqbMRao5VXnqHsJsedca35SWwhmKKNigQIHXcuDns
         7mVEpvPvMsjCufsPz9xKshKpiNsVxml8Tz6tXH2787XbQCh8poI4koFVYwDLXh2o1Ldy
         wr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7BBB8xDOLrGj/n4axVE8aotQ6PZ5hPRMhS37GmQebc=;
        b=ezeyvHTBDYiCyhw6e+euOcqj+ANpWwraC9kdALYr3edIK2IEVgP2UfQn6x/dQ23Owp
         lju2TtpFKSxQ40+pax6c5F+kdL2pMJlGEThDJdHf4y6uAyTX9MBnhL3KioJBPkQv4oHD
         6Y32abrHUM9D6KfeDR5wX6r2qzXc9Fi9Hh/2RRT8bN2wEEhHFtxg0+stOzb7UqR3V6xi
         hjLqeyVp/XGFxX/5UZC7iJKrORw39czE2/zSPQPDN2k6lELPjLCBzj8xkViF8fgRd4bS
         2Ataq2stcnqAo2OysU2Ogqq+Yu44OQd4LBES9CQW/C/GY6JSy4w5vIbizmCyNlAwOUSF
         2qbg==
X-Gm-Message-State: ACrzQf1qnlkjsDmjQJpe5DEoAjKBBsZmGj7QJbIj7rgA3qyCEdMB9KK3
        g2CSYdBMvu4p11i6SuZpqPYi8g==
X-Google-Smtp-Source: AMsMyM67nR588kSiTkXHLgYbNV6kCB/3fTnqmrT3/NO+XYHDzfWGjLpLtL5jjixuBm7zx7+6Xr3Tfg==
X-Received: by 2002:a17:907:1c10:b0:791:a716:5089 with SMTP id nc16-20020a1709071c1000b00791a7165089mr56502644ejc.672.1667987105057;
        Wed, 09 Nov 2022 01:45:05 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id i28-20020a1709067a5c00b007add62dafbasm5712541ejo.157.2022.11.09.01.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 01:45:04 -0800 (PST)
Date:   Wed, 9 Nov 2022 10:45:03 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     guoren@kernel.org
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V2] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <20221109094503.he4ihaow7axjseuj@kamzik>
References: <20221109054056.3618089-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109054056.3618089-1-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 12:40:56AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> After use_asid_allocator is enabled, the userspace application will
> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> Then set_mm_asid would cause the user space application to get a stale
> value by stale TLB entry, but set_mm_noasid is okay.
> 
> Here is the symptom of the bug:
> unhandled signal 11 code 0x1 (coredump)
>    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
>    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> (gdb) i r s0
> s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> (gdb) x /2x 0x3fd6d92490
> 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> The core dump file shows that register s0 is wrong, but the value in
> memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> in TLB and got a wrong result from an incorrect physical address.
> 
> When the task ran on CPU0, which loaded/speculative-loaded the value of
> address(0x3fd6d92490), then the first version of the mapping entry was
> PTWed into CPU0's TLB.
> When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
> asid), it happened to write a value on the address (0x3fd6d92490). It
> caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> ptep_get_and_clear & flush_tlb_page.
> The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> switch_mm. So we only flushed the CPU1 TLB and set the second version
> mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
> still used a stale TLB mapping entry which contained a wrong target
> physical address. It raised a bug when the task happened to read that
> value.
> 
> The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
> which could prevent losing pieces of stuff during TLB flush.
> 
> Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Anup Patel <apatel@ventanamicro.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> Changes in v2:
>  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
>    test robot <lkp@intel.com>)
>  - Keep cpumask_clear_cpu for noasid
> ---
>  arch/riscv/mm/context.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..f58e4b211595 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -317,7 +317,11 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	 */
>  	cpu = smp_processor_id();
>  
> -	cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +#ifdef CONFIG_MMU
> +	if (!static_branch_unlikely(&use_asid_allocator))
> +#endif

That's not very pretty. Can't we just do the following, instead?

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..ace419761e31 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -16,10 +16,11 @@
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>

-#ifdef CONFIG_MMU

 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);

+#ifdef CONFIG_MMU
+
 static unsigned long asid_bits;
 static unsigned long num_asids;
 static unsigned long asid_mask;


Thanks,
drew

> +		cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +
>  	cpumask_set_cpu(cpu, mm_cpumask(next));
>  
>  	set_mm(next, cpu);
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
