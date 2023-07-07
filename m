Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0673074B9A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGGWlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjGGWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:41:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C82684
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9SbVTk+LNTBxoLThJ67eA8KRw/oJMiqxVh5LsFdQDWo=; b=hvjsFz3VzVIsRj4w3CYdGg22Hu
        DBX18iPtBuhcrbBACMIdScLSMXBCEWQTLSaCyo7K34mkKQdSinlJes/DYKkUneTjemDIYb92iP/Wu
        vG8JNncl3DuqsFnwwPnLBvAwtu27BVM7Nwo/Iv8WSTaqmMWdpPk22XT/xK2AgSp5xoROvUa3cvE0p
        U093LjuItCOfT+MO/CSQX5KXI4zahDYUbhKGs1gnsLOrFabPd491CHUsjkmjFPmQF1QhuA8/VjlOB
        1BTSPSjkxt/Pee6v78I7XEbQd/QoCizA2cF8OMSOrhZ+l89I6rJvOLfiOsb30as9yDC13MzwC7yUr
        aRuDvYxw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHu8r-005qd2-2p;
        Fri, 07 Jul 2023 22:41:33 +0000
Message-ID: <67dabd7d-5c3a-2016-a59a-4a0717e478dc@infradead.org>
Date:   Fri, 7 Jul 2023 15:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] module: Ignore RISC-V mapping symbols too
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>, mcgrof@kernel.org,
        thomas@t-8ch.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230707160051.2305-2-palmer@rivosinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230707160051.2305-2-palmer@rivosinc.com>
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



On 7/7/23 09:00, Palmer Dabbelt wrote:
> RISC-V has an extended form of mapping symbols that we use to encode
> the ISA when it changes in the middle of an ELF.  This trips up modpost
> as a build failure, I haven't yet verified it yet but I believe the
> kallsyms difference should result in stacks looking sane again.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/all/9d9e2902-5489-4bf0-d9cb-556c8e5d71c2@infradead.org/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Changes since v1 <20230707054007.32591-1-palmer@rivosinc.com/>:
> 
> * Drop the unnecessary IS_RISCV define and just inline it.
> ---
>  include/linux/module_symbol.h | 12 +++++++++++-
>  kernel/module/kallsyms.c      |  2 +-
>  scripts/mod/modpost.c         |  2 +-
>  3 files changed, 13 insertions(+), 3 deletions(-)
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
> index ef73ae7c8909..78a1ffc399d9 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module *mod,
>  		 * and inserted at a whim.
>  		 */
>  		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
> -		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
> +		    is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), IS_ENABLED(CONFIG_RISCV)))
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
