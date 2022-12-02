Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3177E6408DE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiLBO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbiLBO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:59:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B596E255A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:59:55 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c7so1748241pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVn9fYReGWeklGU9GMj6LqOCAyq6HzvsmE8l0X+UGY4=;
        b=F4eIwSBlqT7o9RkATux/IYaxbq0p8cPog7/J3bPOef3vAZpOQnwSWarC+9qILgQEIl
         WEGxrNIRpMqZMGueMF9aiU2aR0KcfpclsAVf31iMwBVNL4KypWt25KrwHeGz0NUnXFMf
         LujR/fL8L9M0RB3yn/VF2M2xNXTflu1tnb+OL4BqS9gH3My9p3ew+miEleDXg2m1YRK/
         2OPE/SEq0MENOCn28ef9yWGizFu2289AeVed9hx2/gJ+jPcoRNpCKwkpbHel6g4Ay7+q
         /hjYw5fb8r+65IsHigcYPTehjvtNk2D82sOfsuilcqNJ4J5Ckmg0Ly+2hsuWH6vr77Of
         VagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVn9fYReGWeklGU9GMj6LqOCAyq6HzvsmE8l0X+UGY4=;
        b=N2GojiTVsPhNP50ZpQpZTXzcMumoUyLIAaxsSJ4d7YSUm7YLGJFNy6zNhTJb4yyKFh
         fPGEMmvGAnunrRO57h3JFWaDz7Qt9weXMPgzR/aT1tCpAqhJEj0RRixqSGoseDmyBsIi
         kbllwUhIpOTx0qWuQ9m6k70fGEyg5z3BbvFZ4NikcGTZ43Lqo4CRRYSXQactm1n8398B
         1aY9gtdHTsP465Oj0Ns6OlO7Gx3vKjZ79xBz863HTKrgh7qZ5DTe5LaGiwsBlBL7ltb7
         GadF9O0MDK6KQjJKBphYaIif7IE8w2y2ilOERIBxrgtEZY7ZLHgsEP4X98mYRoSFlQp1
         d+xg==
X-Gm-Message-State: ANoB5pkzgX30Iv5c9afkl7ZKuX4S1X26dfOtbpH5LV87FWJ9tAfmeqgy
        j8C6SnezgBaLsKn17/wxvPIx/g==
X-Google-Smtp-Source: AA0mqf7+D9ptufQt6gtLv8VJWJ4Nyf0vHGoTCmcVlBRCz5hA+ZEj1frb5fsoCB3Aw8UmjpV8QROTrQ==
X-Received: by 2002:a63:fb46:0:b0:478:1c87:7fcb with SMTP id w6-20020a63fb46000000b004781c877fcbmr21990948pgj.330.1669993194175;
        Fri, 02 Dec 2022 06:59:54 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78f22000000b0053e62b6fd22sm5186907pfr.126.2022.12.02.06.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 06:59:53 -0800 (PST)
Date:   Fri, 02 Dec 2022 06:59:53 -0800 (PST)
X-Google-Original-Date: Fri, 02 Dec 2022 06:59:52 PST (-0800)
Subject:     Re: [PATCH]     Implement ioremap_prot support (v2)
In-Reply-To: <20221202083356.169176-1-jiangjianwen@uniontech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alexandre.ghiti@canonical.com, geert@linux-m68k.org,
        panqinglin2020@iscas.ac.cn, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiangjianwen@uniontech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jiangjianwen@uniontech.com
Message-ID: <mhng-5118b440-6182-41c4-81d2-a369336ee8e3@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Dec 2022 00:33:56 PST (-0800), jiangjianwen@uniontech.com wrote:
>     Feature ioremap_prot only needs an implementation of pte_pgprot on riscv.
>     That macro is similar to the same one on platform loongarch, mips and sh.
>     We just need:
>     1. replace _PFN_MASK with _PAGE_PFN_MASK in pte_gpprot;
>     2. add "select HAVE_IOREMAP_PROT" into arch/riscv/Kconfig;
>     3. add "depends on MMU" into drivers/fpga/Kconfig to fix the building error "undefined reference to generic_access_phys".

That third one should be its own patch, it's not really related to the 
RISC-V bits.

>
>     Signed-off-by: Jianwen Jiang <jiangjianwen@uniontech.com>
> ---
>  arch/riscv/Kconfig            | 1 +
>  arch/riscv/include/asm/page.h | 2 ++
>  drivers/fpga/Kconfig          | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fa78595a6089..5ed2c7361040 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -95,6 +95,7 @@ config RISCV
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
> +	select HAVE_IOREMAP_PROT
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KPROBES if !XIP_KERNEL
>  	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index ac70b0fd9a9a..cb08a4911d60 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -84,6 +84,8 @@ typedef struct page *pgtable_t;
>  #define __pgd(x)	((pgd_t) { (x) })
>  #define __pgprot(x)	((pgprot_t) { (x) })
>
> +#define pte_pgprot(x)  __pgprot(pte_val(x) & ~_PAGE_PFN_MASK)
> +
>  #ifdef CONFIG_64BIT
>  #define PTE_FMT "%016lx"
>  #else
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index bbe0a7cabb75..0493272b8bff 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -5,6 +5,7 @@
>
>  menuconfig FPGA
>  	tristate "FPGA Configuration Framework"
> +	depends on MMU
>  	help
>  	  Say Y here if you want support for configuring FPGAs from the
>  	  kernel.  The FPGA framework adds an FPGA manager class and FPGA
