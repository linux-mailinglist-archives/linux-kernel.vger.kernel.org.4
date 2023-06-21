Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FC17378B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 03:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjFUB1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 21:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFUB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 21:27:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97551704
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 18:27:08 -0700 (PDT)
X-QQ-mid: bizesmtp63t1687310814ty8pix4r
Received: from [192.168.1.114] ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 09:26:53 +0800 (CST)
X-QQ-SSF: 00200000000000B08000000A0000000
X-QQ-FEAT: znfcQSa1hKaphX350nGOTNuHWnb39C+cuKND1Ce9M0euz/1bpohNjg7MZf8nb
        CHL08hB1IsAvVuoxtO+DnKvApuUJS9sOB0k99THHxdXITDOJRnJBVYbbQYEiFkLH6rkq0sh
        eotVMCAcz3eFafyVP8ToMu3ysmA/ZMLGc7w4uDHKPvTF4bUmNtO7pCdzD6FUaJlLyKiKq4r
        tlDD/pa0dx8Uot2ZEANVimAMtzy6dwdtR35G2k6hGF99+FFPMomEkmdKXSEVdAYCAOu0LtX
        xgdnM4o6nBjYZUhIwgEuIo1BaqscSzC6ZtYFhOOtJg351578Pj7e7m7uuGC7Mpk5rjKh1oq
        dySH72t4LKAwtLgYIQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10387666406691491953
Message-ID: <D2FEDA5AF06E62A9+9447e466-27d2-c815-8530-6e487ddc7275@tinylab.org>
Date:   Wed, 21 Jun 2023 09:26:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] riscv: move memblock_allow_resize() after linear
 mapping is ready
To:     Woody Zhang <woodylab@foxmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org
References: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
From:   Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <tencent_FBB94CE615C5CCE7701CD39C15CCE0EE9706@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/14 21:19, Woody Zhang 写道:
> The initial memblock metadata is accessed from kernel image mapping. The
> regions arrays need to "reallocated" from memblock and accessed through
> linear mapping to cover more memblock regions. So the resizing should
> not be allowed until linear mapping is ready. Note that there are
> memblock allocations when building linear mapping.
> 
> This patch is similar to 24cc61d8cb5a ("arm64: memblock: don't permit
> memblock resizing until linear mapping is up").
> 
> In following log, many memblock regions are reserved before
> create_linear_mapping_page_table(). And then it triggered reallocation
> of memblock.reserved.regions and memcpy the old array in kernel image
> mapping to the new array in linear mapping which caused a page fault.
> 
> [    0.000000] memblock_reserve: [0x00000000bf01f000-0x00000000bf01ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf021000-0x00000000bf021fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf023000-0x00000000bf023fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf025000-0x00000000bf025fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf027000-0x00000000bf027fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf029000-0x00000000bf029fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf02b000-0x00000000bf02bfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf02d000-0x00000000bf02dfff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf02f000-0x00000000bf02ffff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] memblock_reserve: [0x00000000bf030000-0x00000000bf030fff] early_init_fdt_scan_reserved_mem+0x28c/0x2c6
> [    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008007ffff (512 KiB) map non-reusable mmode_resv0@80000000
> [    0.000000] memblock_reserve: [0x00000000bf000000-0x00000000bf001fed] paging_init+0x19a/0x5ae
> [    0.000000] memblock_phys_alloc_range: 4096 bytes align=0x1000 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_pmd_fixmap+0x14/0x1c
> [    0.000000] memblock_reserve: [0x000000017ffff000-0x000000017fffffff] memblock_alloc_range_nid+0xb8/0x128
> [    0.000000] memblock: reserved is doubled to 256 at [0x000000017fffd000-0x000000017fffe7ff]
> [    0.000000] Unable to handle kernel paging request at virtual address ff600000ffffd000
> [    0.000000] Oops [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.4.0-rc1-00011-g99a670b2069c #66
> [    0.000000] Hardware name: riscv-virtio,qemu (DT)
> [    0.000000] epc : __memcpy+0x60/0xf8
> [    0.000000]  ra : memblock_double_array+0x192/0x248
> [    0.000000] epc : ffffffff8081d214 ra : ffffffff80a3dfc0 sp : ffffffff81403bd0
> [    0.000000]  gp : ffffffff814fbb38 tp : ffffffff8140dac0 t0 : 0000000001600000
> [    0.000000]  t1 : 0000000000000000 t2 : 000000008f001000 s0 : ffffffff81403c60
> [    0.000000]  s1 : ffffffff80c0bc98 a0 : ff600000ffffd000 a1 : ffffffff80c0bcd8
> [    0.000000]  a2 : 0000000000000c00 a3 : ffffffff80c0c8d8 a4 : 0000000080000000
> [    0.000000]  a5 : 0000000000080000 a6 : 0000000000000000 a7 : 0000000080200000
> [    0.000000]  s2 : ff600000ffffd000 s3 : 0000000000002000 s4 : 0000000000000c00
> [    0.000000]  s5 : ffffffff80c0bc60 s6 : ffffffff80c0bcc8 s7 : 0000000000000000
> [    0.000000]  s8 : ffffffff814fd0a8 s9 : 000000017fffe7ff s10: 0000000000000000
> [    0.000000]  s11: 0000000000001000 t3 : 0000000000001000 t4 : 0000000000000000
> [    0.000000]  t5 : 000000008f003000 t6 : ff600000ffffd000
> [    0.000000] status: 0000000200000100 badaddr: ff600000ffffd000 cause: 000000000000000f
> [    0.000000] [<ffffffff8081d214>] __memcpy+0x60/0xf8
> [    0.000000] [<ffffffff80a3e1a2>] memblock_add_range.isra.14+0x12c/0x162
> [    0.000000] [<ffffffff80a3e36a>] memblock_reserve+0x6e/0x8c
> [    0.000000] [<ffffffff80a123fc>] memblock_alloc_range_nid+0xb8/0x128
> [    0.000000] [<ffffffff80a1256a>] memblock_phys_alloc_range+0x5e/0x6a
> [    0.000000] [<ffffffff80a04732>] alloc_pmd_fixmap+0x14/0x1c
> [    0.000000] [<ffffffff80a0475a>] alloc_p4d_fixmap+0xc/0x14
> [    0.000000] [<ffffffff80a04a36>] create_pgd_mapping+0x98/0x17c
> [    0.000000] [<ffffffff80a04e9e>] create_linear_mapping_range.constprop.10+0xe4/0x112
> [    0.000000] [<ffffffff80a05bb8>] paging_init+0x3ec/0x5ae
> [    0.000000] [<ffffffff80a03354>] setup_arch+0xb2/0x576
> [    0.000000] [<ffffffff80a00726>] start_kernel+0x72/0x57e
> [    0.000000] Code: b303 0285 b383 0305 be03 0385 be83 0405 bf03 0485 (b023) 00ef
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> ---
> Changes in v3:
>   - Add panic log for the bug case.
>   - Move memblock_allow_resize to paging_init per suggestions from Alex and
>     Song Shuai.
> 
> Changes in v2:
>   - Refine commit log
> ---
>   arch/riscv/mm/init.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4fa420faa780..1306149aad57 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -267,7 +267,6 @@ static void __init setup_bootmem(void)
>   	dma_contiguous_reserve(dma32_phys_limit);
>   	if (IS_ENABLED(CONFIG_64BIT))
>   		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> -	memblock_allow_resize();
>   }
>   
>   #ifdef CONFIG_MMU
> @@ -1370,6 +1369,9 @@ void __init paging_init(void)
>   {
>   	setup_bootmem();
>   	setup_vm_final();
> +
> +	/* Depend on that Linear Mapping is ready */
> +	memblock_allow_resize();
>   }
>   
>   void __init misc_mem_init(void)

Tested-by: Song Shuai <songshuaishuai@tinylab.org>

-- 
Thanks
Song Shuai

