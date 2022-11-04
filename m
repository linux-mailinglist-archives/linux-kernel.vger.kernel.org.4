Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD8161968E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiKDMvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiKDMvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80211823
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6B462177
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC7AC433C1;
        Fri,  4 Nov 2022 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667566262;
        bh=jiGK3o0Gv2eoeA5+7Wfk08wEapetiZPf58b7uXbb8OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pL7mTk8F89Yl8cKQ3USab8PnD5gWNSbJPe59wpc6mDAnghO5Mlzkm2buzRwpQnznn
         LY+RQU9wjvHzOffXdRWfhSO2yBpHyh5/8Ju+FMCDgSWBayXPBKlm1Q30wyr3i3dutf
         MlttYKL0FlhOSaiXlhxSCetIkOAuJALHaN3Z3lD6RHrx6jjXt8TJb2qVIaxChKniK4
         Lwac4P4BwJ/gjQ2W8nsNoOfO8DvZDdLOa4wuVA8QEIJqqksq0jQp2S/LC71srWrC67
         cdA3M/PJh+8OwuHV8KYIqznRffsrILVmKM971w5bQWXArXg23+2Z8ErgD/tU7DdBdA
         7XkWq5405Kshg==
Date:   Fri, 4 Nov 2022 12:50:57 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lizhengyu3@huawei.com,
        liaochang1@huawei.com, u.kleine-koenig@pengutronix.de,
        rdunlap@infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
Message-ID: <Y2UKsW8RzuNmEo8r@spud>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 05:56:57PM +0800, Li Huafei wrote:
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

Both of these bits of cleanup seem to echo what's the case on arm64.
Seems reasonable to me..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

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
> -- 
> 2.17.1
> 
