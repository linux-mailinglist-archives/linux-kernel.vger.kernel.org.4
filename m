Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5294E74A4A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjGFUFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFUFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:05:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3801BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:05:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so595303b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688673906; x=1691265906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hnkU1J21cgPCgfLbbAiAIZoNsBwKuuCf1YF0BIHy7Ic=;
        b=eNkKpcswikHAy4YnPlzhh32csWj8/a/27/eR1UxF2vYAWa8hB6W/3fdoQc00EhktTV
         7b+GdZfAunRDt1cZ6WS7aiEdFi6GBV5Cwqn9YAnHNoQ1s8vyPQ9SiYCKuv7duiMYdAA4
         nYtb+/IoFRwm4GJxBlDvPrPkPJgVhhpR1yPcH3NSeUwpY00m6JQaEEhdPV5HDy7tPRum
         SdwGtXG+nqLn8GZcPVxlCisgFOIhhyPW4wJED/NbREPqEJ7jpPTD93ONATzIGzj5YQnz
         k5NXVtNCvXVZvG5uDyu+FVZgo1uTxht9VBF2FO3ehBuOaNGYUvhzMnRzCTsm6K8NZxKj
         7KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688673906; x=1691265906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnkU1J21cgPCgfLbbAiAIZoNsBwKuuCf1YF0BIHy7Ic=;
        b=jJZea3UyJVZ8vBu5nW4iBS1PUz4SJa1pWdzBydpnID9YYW2w/DOv7JapMK/xBeJkZR
         6IFrlwjW8TwowkuDPcsF1GOLe4N3le+wvN+LSm2dvm5XMUAgtnnkEbZOAsQADyFQQxLD
         WGkgVKYeN46B6OjPUcdlqYdxWND10wwffx7URQOgujFh7HzdJXsNG0q304Mln8Q0Tetu
         b+QSe06IyVtejNPIkb2UMCpRFJtF/v75o5Cglqc/+iPXBKVWBr5kX70WLet/TSHvQqEe
         2g95R3lMSyxrFEFp10B3XhnJSvmCeXl5ft+tcHMFDEHgEuyWZMDzVdM6Yp5dCioBkpQe
         2RIA==
X-Gm-Message-State: ABy/qLa+z3K9EEp6NGDF545x2wBLES/wGNcmQciEulFRAFxAL4mHJo+O
        mmwz1DxEoFWqQYb5I5oDcu0rfE60g8A73wwOluk=
X-Google-Smtp-Source: APBJJlFpjlMvFOnYLsjkx91j6F39vUvc1Z+HSSxEZ0f/QUWe6J10GWMr9dc4Pp2hWjDQ2G4iYEZtfA==
X-Received: by 2002:a05:6a00:1796:b0:66c:6766:7373 with SMTP id s22-20020a056a00179600b0066c67667373mr3206720pfg.23.1688673906529;
        Thu, 06 Jul 2023 13:05:06 -0700 (PDT)
Received: from ghost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b0064aea45b040sm1622325pfa.168.2023.07.06.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:05:06 -0700 (PDT)
Date:   Thu, 6 Jul 2023 13:05:04 -0700
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] RISC-V: Add T-Head 0.7.1 vector extension to hwprobe
Message-ID: <ZKcecLVQ61P886R/@ghost>
References: <20230705-thead_vendor_extensions-v1-0-ad6915349c4d@rivosinc.com>
 <20230705-thead_vendor_extensions-v1-2-ad6915349c4d@rivosinc.com>
 <2286282.ElGaqSPkdT@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2286282.ElGaqSPkdT@basile.remlab.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 07:32:36PM +0300, Rémi Denis-Courmont wrote:
> Le torstaina 6. heinäkuuta 2023, 6.30.18 EEST Charlie Jenkins a écrit :
> > Using vendor extensions in hwprobe, add the ability to query if the
> > 0.7.1 vector extension is available. It is determined to be available
> > only if the kernel is compiled with vector support, and the user is
> > using the c906.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/Kconfig.vendor                       | 11 +++++++++++
> >  arch/riscv/include/asm/extensions.h             | 16 ++++++++++++++++
> >  arch/riscv/kernel/sys_riscv.c                   | 20 ++++++++++++++++++++
> >  arch/riscv/vendor_extensions/Makefile           |  2 ++
> >  arch/riscv/vendor_extensions/thead/Makefile     |  8 ++++++++
> >  arch/riscv/vendor_extensions/thead/extensions.c | 24
> > ++++++++++++++++++++++++ 6 files changed, 81 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.vendor b/arch/riscv/Kconfig.vendor
> > index 213ac3e6fed5..b8b9d15153eb 100644
> > --- a/arch/riscv/Kconfig.vendor
> > +++ b/arch/riscv/Kconfig.vendor
> > @@ -1,3 +1,14 @@
> >  menu "Vendor extensions selection"
> > 
> > +config VENDOR_EXTENSIONS_THEAD
> > +	bool "T-HEAD vendor extensions"
> > +	depends on RISCV_ALTERNATIVE
> > +	default n
> > +	help
> > +	  All T-HEAD vendor extensions Kconfig depend on this Kconfig. 
> Disabling
> > +	  this Kconfig will disable all T-HEAD vendor extensions. Please say 
> "Y"
> > +	  here if your platform uses T-HEAD vendor extensions.
> > +
> > +	  Otherwise, please say "N" here to avoid unnecessary overhead.
> > +
> >  endmenu # "Vendor extensions selection"
> > diff --git a/arch/riscv/include/asm/extensions.h
> > b/arch/riscv/include/asm/extensions.h new file mode 100644
> > index 000000000000..27ce294a3d65
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/extensions.h
> > @@ -0,0 +1,16 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 by Rivos Inc.
> > + */
> > +#ifndef __ASM_EXTENSIONS_H
> > +#define __ASM_EXTENSIONS_H
> > +
> > +#include <asm/hwprobe.h>
> > +#include <linux/cpumask.h>
> > +
> > +#define THEAD_ISA_EXT0 (RISCV_HWPROBE_VENDOR_EXTENSION_SPACE)
> > +#define THEAD_ISA_EXT0_V0_7_1 (1 << 0)
> > +
> > +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> > +		  const struct cpumask *cpus);
> > +#endif
> > diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> > index 2351a5f7b8b1..58b12eaeaf46 100644
> > --- a/arch/riscv/kernel/sys_riscv.c
> > +++ b/arch/riscv/kernel/sys_riscv.c
> > @@ -13,6 +13,7 @@
> >  #include <asm/vector.h>
> >  #include <asm/switch_to.h>
> >  #include <asm/uaccess.h>
> > +#include <asm/extensions.h>
> >  #include <asm/unistd.h>
> >  #include <asm-generic/mman-common.h>
> >  #include <vdso/vsyscall.h>
> > @@ -192,6 +193,25 @@ static int hwprobe_vendor(__u64 mvendorid, struct
> > riscv_hwprobe *pair, const struct cpumask *cpus)
> >  {
> >  	switch (mvendorid) {
> > +#ifdef CONFIG_VENDOR_EXTENSIONS_THEAD
> > +	case THEAD_VENDOR_ID:
> > +		struct riscv_hwprobe marchid = {
> > +			.key = RISCV_HWPROBE_KEY_MARCHID,
> > +			.value = 0
> > +		};
> > +		struct riscv_hwprobe mimpid = {
> > +			.key = RISCV_HWPROBE_KEY_MIMPID,
> > +			.value = 0
> > +		};
> > +
> > +		hwprobe_arch_id(&marchid, cpus);
> > +		hwprobe_arch_id(&mimpid, cpus);
> > +		if (marchid.value != -1ULL && mimpid.value != -1ULL)
> > +			hwprobe_thead(marchid.value, mimpid.value, 
> pair, cpus);
> > +		else
> > +			return -1;
> > +		break;
> > +#endif
> >  	default:
> >  		return -1;
> >  	}
> > diff --git a/arch/riscv/vendor_extensions/Makefile
> > b/arch/riscv/vendor_extensions/Makefile index e815895e9372..38c3e80469fd
> > 100644
> > --- a/arch/riscv/vendor_extensions/Makefile
> > +++ b/arch/riscv/vendor_extensions/Makefile
> > @@ -1,3 +1,5 @@
> >  ifdef CONFIG_RELOCATABLE
> >  KBUILD_CFLAGS += -fno-pie
> >  endif
> > +
> > +obj-$(CONFIG_VENDOR_EXTENSIONS_THEAD) += thead/
> > diff --git a/arch/riscv/vendor_extensions/thead/Makefile
> > b/arch/riscv/vendor_extensions/thead/Makefile new file mode 100644
> > index 000000000000..7cf43c629b66
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/thead/Makefile
> > @@ -0,0 +1,8 @@
> > +ifdef CONFIG_FTRACE
> > +CFLAGS_REMOVE_extensions.o = $(CC_FLAGS_FTRACE)
> > +endif
> > +ifdef CONFIG_KASAN
> > +KASAN_SANITIZE_extensions.o := n
> > +endif
> > +
> > +obj-y += extensions.o
> > diff --git a/arch/riscv/vendor_extensions/thead/extensions.c
> > b/arch/riscv/vendor_extensions/thead/extensions.c new file mode 100644
> > index 000000000000..a177501bc99c
> > --- /dev/null
> > +++ b/arch/riscv/vendor_extensions/thead/extensions.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 by Rivos Inc.
> > + */
> > +
> > +#include <asm/extensions.h>
> > +
> > +int hwprobe_thead(__u64 marchid, __u64 mimpid, struct riscv_hwprobe *pair,
> > +		  const struct cpumask *cpus)
> > +{
> > +	pair->value = 0;
> > +	switch (pair->key) {
> > +	case THEAD_ISA_EXT0:
> > +#ifdef CONFIG_RISCV_ISA_V
> > +		if (marchid == 0 && mimpid == 0)
> > +			pair->value |= THEAD_ISA_EXT0_V0_7_1;
> 
> I'm not sure I follow the code, but exposing an extension to userspace that 
> the kernel does not handle is a bad idea. AFAIK, the initialisation and 
> context switching code must be in place first.
> 
> And I don't suppose that this can *simply* piggy-back on the existing RVV 
> 1.0.0 support, because user-space  assumes 1.0.0-compliant behaviour if the 
> existing vector flag is set in hwprobe().
> 
> Indeed, I recall somebody else posted a recent patchset ostensibly with the 
> same goal that was a lot more involved than this.
> 
The main goal of this patch was to get vendor extensions tied into
hwprobe. I selected this vector extension to start with, but it looks
like it is more complicated than I had anticipated.
> > +#endif
> > +		break;
> > +	default:
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> -- 
> 雷米‧德尼-库尔蒙
> http://www.remlab.net/
> 
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
