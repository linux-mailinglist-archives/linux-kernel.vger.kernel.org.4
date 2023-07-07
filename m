Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256BC74AAF1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGGGG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGGGGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:06:24 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019B183
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 23:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1688709980; bh=aqrod6vM4sEPjl4JBQgL6DNpjvHEpvtdJNSsM28V3nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPzdB3qUPiU/rHl7MGbdtvaOHGUzJctTZIh6MlOFqoacFVfGVpxb71/CEfHKyFipa
         dn+DEl005a5kV9Hs/PUHwpTTRSoldnMsSKGjD4DNGX0j9J6we/OwXWQrCnjidmVplk
         mop6sYaHxRW/6ARPuUWjPHMEy224tDy1cv9mXE8g=
Date:   Fri, 7 Jul 2023 08:06:19 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     mcgrof@kernel.org, rdunlap@infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: Ignore RISC-V mapping symbols too
Message-ID: <3e905882-7f96-4fc0-aecf-6054ed00372e@t-8ch.de>
References: <20230707054007.32591-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707054007.32591-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-06 22:40:01-0700, Palmer Dabbelt wrote:
> RISC-V has an extended form of mapping symbols that we use to encode
> the ISA when it changes in the middle of an ELF.  This trips up modpost
> as a build failure, I haven't yet verified it yet but I believe the
> kallsyms difference should result in stacks looking sane again.

> [..]

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

IS_BUILTIN(CONFIG_RISCV) or IS_ENABLED(CONFIG_RISCV) ?

>  			continue;
>  
>  		if (thisval <= addr && thisval > bestval) {

> [..]
