Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12D061E846
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 02:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiKGBaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 20:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiKGBaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 20:30:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004672BC5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 17:30:11 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N5D8m0dV2zpSsn;
        Mon,  7 Nov 2022 09:26:32 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 09:30:09 +0800
Message-ID: <3b34d898-4690-c774-e92f-69796f9f5d37@huawei.com>
Date:   Mon, 7 Nov 2022 09:30:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
To:     Li Huafei <lihuafei1@huawei.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <lizhengyu3@huawei.com>, <u.kleine-koenig@pengutronix.de>,
        <rdunlap@infradead.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/4 17:56, Li Huafei 写道:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> In elf_kexec_load(), a buffer is allocated via kvmalloc() to store fdt.
> While it's not freed back to system when kexec kernel is reloaded or
> unloaded.  Then memory leak is caused.  Fix it by introducing riscv
> specific function arch_kimage_file_post_load_cleanup(), and freeing the
> buffer there.
> 
> Fixes: 6261586e0c91 ("RISC-V: Add kexec_file support")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  arch/riscv/include/asm/kexec.h |  5 +++++
>  arch/riscv/kernel/elf_kexec.c  | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index eee260e8ab30..2b56769cb530 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -39,6 +39,7 @@ crash_setup_regs(struct pt_regs *newregs,
>  #define ARCH_HAS_KIMAGE_ARCH
>  
>  struct kimage_arch {
> +	void *fdt; /* For CONFIG_KEXEC_FILE */
>  	unsigned long fdt_addr;
>  };
>  
> @@ -62,6 +63,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     const Elf_Shdr *relsec,
>  				     const Elf_Shdr *symtab);
>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
> +
> +struct kimage;
> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>  #endif
>  
>  #endif
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index 0cb94992c15b..ff30fcb43f47 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -21,6 +21,14 @@
>  #include <linux/memblock.h>
>  #include <asm/setup.h>
>  
> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
> +{
> +	kvfree(image->arch.fdt);
> +	image->arch.fdt = NULL;
> +
> +	return kexec_image_post_load_cleanup_default(image);
> +}

Good catch,LGTM

Reviewed-by: Liao Chang <liaochang1@huawei.com>

> +
>  static int riscv_kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>  				struct kexec_elf_info *elf_info, unsigned long old_pbase,
>  				unsigned long new_pbase)
> @@ -298,6 +306,8 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>  		pr_err("Error add DTB kbuf ret=%d\n", ret);
>  		goto out_free_fdt;
>  	}
> +	/* Cache the fdt buffer address for memory cleanup */
> +	image->arch.fdt = fdt;
>  	pr_notice("Loaded device tree at 0x%lx\n", kbuf.mem);
>  	goto out;
>  

-- 
BR,
Liao, Chang
