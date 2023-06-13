Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE472EEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjFMWQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjFMWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66B10CC;
        Tue, 13 Jun 2023 15:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E87960A5A;
        Tue, 13 Jun 2023 22:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27C1C433C0;
        Tue, 13 Jun 2023 22:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686694582;
        bh=+WIGytSpx4hFIJZtH+suKZCZHkq5JBHItki5+7BFPsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KvuDR5kbBMLh2VXVzw7NO5wtSshJHEiPMI72MOW96V4/U71ZPwOvtZcgx4igXxMM9
         em+vyycTpMJAdlxzRDVkQnWhkW0lpSv1w5OfUlveeKzndjtlhfIAlz6KkyJhYm9vAL
         YeOSX6iUcPzAZQxfDfXnUCMYGVKsXS4ueWqr5sAFUnmWDNkxen775E7afX9ThgAUDG
         /zY+Rb3OkZn0TBkz1JEvYtOijN22lxlf2MhOYND5RFEYMsncR0Ru0UtWG3QgShOTYr
         rTOglNLVYb9iCLUk1lIGArlo4nilYPoAaYiuRtfBAW2VjixrTzTJsPA6zdb5t+Q6uZ
         QAuDp1N4POaTw==
Message-ID: <032f8239-bb82-e20e-e42b-e7a54754298b@kernel.org>
Date:   Tue, 13 Jun 2023 17:16:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/13] nios2: define virtual address space for modules
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
References: <20230601101257.530867-1-rppt@kernel.org>
 <20230601101257.530867-2-rppt@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230601101257.530867-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/23 05:12, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> nios2 uses kmalloc() to implement module_alloc() because CALL26/PCREL26
> cannot reach all of vmalloc address space.
> 
> Define module space as 32MiB below the kernel base and switch nios2 to
> use vmalloc for module allocations.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/nios2/include/asm/pgtable.h |  5 ++++-
>   arch/nios2/kernel/module.c       | 19 ++++---------------
>   2 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 0f5c2564e9f5..0073b289c6a4 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -25,7 +25,10 @@
>   #include <asm-generic/pgtable-nopmd.h>
>   
>   #define VMALLOC_START		CONFIG_NIOS2_KERNEL_MMU_REGION_BASE
> -#define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
> +#define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M - 1)
> +
> +#define MODULES_VADDR		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M)
> +#define MODULES_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
>   
>   struct mm_struct;
>   
> diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
> index 76e0a42d6e36..9c97b7513853 100644
> --- a/arch/nios2/kernel/module.c
> +++ b/arch/nios2/kernel/module.c
> @@ -21,23 +21,12 @@
>   
>   #include <asm/cacheflush.h>
>   
> -/*
> - * Modules should NOT be allocated with kmalloc for (obvious) reasons.
> - * But we do it for now to avoid relocation issues. CALL26/PCREL26 cannot reach
> - * from 0x80000000 (vmalloc area) to 0xc00000000 (kernel) (kmalloc returns
> - * addresses in 0xc0000000)
> - */
>   void *module_alloc(unsigned long size)
>   {
> -	if (size == 0)
> -		return NULL;
> -	return kmalloc(size, GFP_KERNEL);
> -}
> -
> -/* Free memory returned from module_alloc */
> -void module_memfree(void *module_region)
> -{
> -	kfree(module_region);
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +				    GFP_KERNEL, PAGE_KERNEL_EXEC,
> +				    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> +				    __builtin_return_address(0));
>   }
>   
>   int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
