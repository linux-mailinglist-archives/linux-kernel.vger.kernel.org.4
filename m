Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98E6620158
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 22:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiKGVka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 16:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKGVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 16:40:28 -0500
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1A327CFD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 13:40:26 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 21C5A41200;
        Mon,  7 Nov 2022 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :from:from:references:content-language:subject:subject
        :user-agent:mime-version:date:date:message-id:received:received
        :received:received; s=mta-01; t=1667857222; x=1669671623; bh=esC
        ycxrxvZxM5Pm8Ikehw6aoj6hzkD7c5GQWfXbXSNI=; b=SnrTOZE/hAkiqhNhe/8
        zC5CBOXk+n5d9doal91SEURgpbzKMZ4f7GzTT1rcOPDqSg2CmhPfN9VWNOKeaw1E
        qRxvKsA57Ze0ThAJH+KuH/8VltvA4I73AOTYr++3oMJU1chjoar5uhUoR9dSfA4k
        n96iTB9CnNh4dHcG8n4CNLAo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n8uoBLs-ZLt2; Tue,  8 Nov 2022 00:40:22 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4B5A2411FB;
        Tue,  8 Nov 2022 00:40:20 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 8 Nov 2022 00:40:21 +0300
Received: from [10.199.21.212] (10.199.21.212) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 8 Nov 2022
 00:40:20 +0300
Message-ID: <497c057d-4e7d-0dcb-fd4c-2c7ef6efb573@yadro.com>
Date:   Tue, 8 Nov 2022 00:40:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1] riscv: fix reserved memory setup
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        "Anup Patel" <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        "Nick Kossifidis" <mick@ics.forth.gr>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>
References: <20221107151524.3941467-1-conor.dooley@microchip.com>
From:   Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <20221107151524.3941467-1-conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.21.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07.11.2022 18:15, Conor Dooley wrote:
> «Внимание! Данное письмо от внешнего адресата!»
> 
> Currently, RISC-V sets up reserved memory using the "early" copy of the
> device tree. As a result, when trying to get a reserved memory region
> using of_reserved_mem_lookup(), the pointer to reserved memory regions
> is using the early, pre-virtual-memory address which causes a kernel
> panic when trying to use the buffer's name:
> 
>   Unable to handle kernel paging request at virtual address 00000000401c31ac
>   Oops [#1]
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc1-00001-g0d9d6953d834 #1
>   Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
>   epc : string+0x4a/0xea
>    ra : vsnprintf+0x1e4/0x336
>   epc : ffffffff80335ea0 ra : ffffffff80338936 sp : ffffffff81203be0
>    gp : ffffffff812e0a98 tp : ffffffff8120de40 t0 : 0000000000000000
>    t1 : ffffffff81203e28 t2 : 7265736572203a46 s0 : ffffffff81203c20
>    s1 : ffffffff81203e28 a0 : ffffffff81203d22 a1 : 0000000000000000
>    a2 : ffffffff81203d08 a3 : 0000000081203d21 a4 : ffffffffffffffff
>    a5 : 00000000401c31ac a6 : ffff0a00ffffff04 a7 : ffffffffffffffff
>    s2 : ffffffff81203d08 s3 : ffffffff81203d00 s4 : 0000000000000008
>    s5 : ffffffff000000ff s6 : 0000000000ffffff s7 : 00000000ffffff00
>    s8 : ffffffff80d9821a s9 : ffffffff81203d22 s10: 0000000000000002
>    s11: ffffffff80d9821c t3 : ffffffff812f3617 t4 : ffffffff812f3617
>    t5 : ffffffff812f3618 t6 : ffffffff81203d08
>   status: 0000000200000100 badaddr: 00000000401c31ac cause: 000000000000000d
>   [<ffffffff80338936>] vsnprintf+0x1e4/0x336
>   [<ffffffff80055ae2>] vprintk_store+0xf6/0x344
>   [<ffffffff80055d86>] vprintk_emit+0x56/0x192
>   [<ffffffff80055ed8>] vprintk_default+0x16/0x1e
>   [<ffffffff800563d2>] vprintk+0x72/0x80
>   [<ffffffff806813b2>] _printk+0x36/0x50
>   [<ffffffff8068af48>] print_reserved_mem+0x1c/0x24
>   [<ffffffff808057ec>] paging_init+0x528/0x5bc
>   [<ffffffff808031ae>] setup_arch+0xd0/0x592
>   [<ffffffff8080070e>] start_kernel+0x82/0x73c
> 
> early_init_fdt_scan_reserved_mem() takes no arguments as it operates on
> initial_boot_params, which is populated by early_init_dt_verify(). On
> RISC-V, early_init_dt_verify() is called twice. Once, directly, in
> setup_arch() if CONFIG_BUILTIN_DTB is not enabled and once indirectly,
> very early in the boot process, by parse_dtb() when it calls
> early_init_dt_scan_nodes().
> 
> This first call uses dtb_early_va to set initial_boot_params, which is
> not usable later in the boot process when
> early_init_fdt_scan_reserved_mem() is called. On arm64 for example, the
> corresponding call to early_init_dt_scan_nodes() uses fixmap addresses
> and doesn't suffer the same fate.

Thank you for looking into this!

As I wrote earlier, I ran into this issue too, while working on a 
remoteproc driver for our RISC-V-based SoC.

The proposed patch fixes the bug for me and seems to have no problematic 
side-effects. So:

Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>

> 
> Move early_init_fdt_scan_reserved_mem() further along the boot sequence,
> after the direct call to early_init_dt_verify() in setup_arch() so that
> the names use the correct virtual memory addresses. The above supposed
> that CONFIG_BUILTIN_DTB was not set, but should work equally in the case
> where it is - unflatted_and_copy_device_tree() also updates
> initial_boot_params.
> 
> Reported-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Link: https://lore.kernel.org/linux-riscv/f8e67f82-103d-156c-deb0-d6d6e2756f5e@microchip.com/
> Fixes: 922b0375fc93 ("riscv: Fix memblock reservation for device tree blob")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   arch/riscv/kernel/setup.c | 1 +
>   arch/riscv/mm/init.c      | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index ad76bb59b059..67ec1fadcfe2 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -283,6 +283,7 @@ void __init setup_arch(char **cmdline_p)
>          else
>                  pr_err("No DTB found in kernel mappings\n");
>   #endif
> +       early_init_fdt_scan_reserved_mem();
>          misc_mem_init();
> 
>          init_resources();
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b56a0a75533f..50a1b6edd491 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -262,7 +262,6 @@ static void __init setup_bootmem(void)
>                          memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
>          }
> 
> -       early_init_fdt_scan_reserved_mem();
>          dma_contiguous_reserve(dma32_phys_limit);
>          if (IS_ENABLED(CONFIG_64BIT))
>                  hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> --
> 2.38.0
> 

