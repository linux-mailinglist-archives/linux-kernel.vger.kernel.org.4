Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3574B3BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjGGPIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGGPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:08:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1711124
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ngymcJKfzUdLyl4Mlcar1YzSoF6nj3bJ0BiZlGdA5fU=; b=OLu3rDIaK4YQsYiz+caXIw/WiX
        W8J+Wa9Osj/y2FOMTD5aXMnjiiHIFujD8xnHa/NaKqDyjORPxCh8s9EMW5CnUCEA51vfYgIsStHBb
        56y6iGv7BU7Meh8GOmlDGloyFD4mQgJytER7IjyDWr1JXYwR65moN6g1pKW7gYoGFPcRr2jOI8t1P
        cAVuUmy51YRwpUHZh9bHN9VpOKOcudpLTYl2+KIV/4L5sje5oxdBa2rpq3XS4A8Qz3Pl2tbsGWkVq
        Cq5+1GUnfbiCHFbVjxpANX9hStYpvNqZKImSDm4axVJV9eZNXG/ZYcDTX0lEh6/i+I/LKsYiQg5mp
        fZ4+zw/A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHn48-004ynX-38;
        Fri, 07 Jul 2023 15:08:13 +0000
Message-ID: <437ac153-620c-2012-7ce3-66442b505972@infradead.org>
Date:   Fri, 7 Jul 2023 08:08:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] module: Ignore RISC-V mapping symbols too
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, mcgrof@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707054007.32591-1-palmer@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230707054007.32591-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/23 22:40, Palmer Dabbelt wrote:
> RISC-V has an extended form of mapping symbols that we use to encode
> the ISA when it changes in the middle of an ELF.  This trips up modpost
> as a build failure, I haven't yet verified it yet but I believe the
> kallsyms difference should result in stacks looking sane again.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> I'm not sure about a fixes here, the breakage comes from a binutils change
> that's pretty much independent from the kernel.
> 
> Plumbing in through the RISC-V-specific switch is also a bit ugly, but I'm not
> sure just dropping everyone's "$"-prefixed symbols is a good idea -- the rest
> of this is sort of half-way arch-specific, though, so maybe that's the way to
> go?  I figure it's easier to delete stuff than add it, though.
> ---
>  include/linux/module_symbol.h | 12 +++++++++++-
>  kernel/module/kallsyms.c      |  8 +++++++-
>  scripts/mod/modpost.c         |  2 +-
>  3 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.h
> index 7ace7ba30203..5b799942b243 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,12 +3,22 @@
>  #define _LINUX_MODULE_SYMBOL_H
>  
>  /* This ignores the intensely annoying "mapping symbols" found in ELF files. */
> -static inline int is_mapping_symbol(const char *str)
> +static inline int is_mapping_symbol(const char *str, int is_riscv)
>  {
>  	if (str[0] == '.' && str[1] == 'L')
>  		return true;
>  	if (str[0] == 'L' && str[1] == '0')
>  		return true;
> +	/*
> +	 * RISC-V defines various special symbols that start with "$".  The
> +	 * mapping symbols, which exist to differentiate between incompatible
> +	 * instruction encodings when disassembling, show up all over the place
> +	 * and are generally not meant to be treated like other symbols.  So
> +	 * just ignore any of the special symbols.
> +	 */
> +	if (is_riscv)
> +		return str[0] == '$';
> +
>  	return str[0] == '$' &&
>  	       (str[1] == 'a' || str[1] == 'd' || str[1] == 't' || str[1] == 'x')
>  	       && (str[2] == '\0' || str[2] == '.');
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index ef73ae7c8909..1e988e542c5d 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -12,6 +12,12 @@
>  #include <linux/bsearch.h>
>  #include "internal.h"
>  
> +#ifdef CONFIG_RISCV
> +#define IS_RISCV 1
> +#else
> +#define IS_RISCV 0
> +#endif
> +
>  /* Lookup exported symbol in given range of kernel_symbols */
>  static const struct kernel_symbol *lookup_exported_symbol(const char *name,
>  							  const struct kernel_symbol *start,
> @@ -289,7 +295,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  		 * and inserted at a whim.
>  		 */
>  		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
> -		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> +		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_RISCV))
>  			continue;
>  
>  		if (thisval <= addr && thisval > bestval) {
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b29b29707f10..7c71429d6502 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *elf, Elf_Sym *sym)
>  
>  	if (!name || !strlen(name))
>  		return 0;
> -	return !is_mapping_symbol(name);
> +	return !is_mapping_symbol(name, elf->hdr->e_machine == EM_RISCV);
>  }
>  
>  /* Look up the nearest symbol based on the section and the address */

-- 
~Randy
