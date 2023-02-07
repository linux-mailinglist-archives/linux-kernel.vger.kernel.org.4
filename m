Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE5668DE46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjBGQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGQxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:53:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE8E65BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:53:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C8C5B81A1F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 16:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B818C4339B;
        Tue,  7 Feb 2023 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675788831;
        bh=XuTCGHDp71Maj5LPFP6Q/D0zLoJ9M2HqT+7H2wIqnvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGclJ/DqVAGjovIJ9hLph5/0eo+QXyrPNtMVOmmyhU/iTM76j4MTHDjAGJIiJRCr6
         2LbXUulAGSEj4UZhd1wq9FliysnhQxkImn+y6Xi9CjXIf7U9gvkKTn/5MMwxsONTD7
         I2jdy/HEwpKybpSEWLVBkt2zzgv7LHUA2QTum0n3YgEuxD4KwyzrrFPPcyqLH0A3nA
         nTT+CDj8l61w+cpEjedO/m475M40gmWccgXpJlKakNMprEfbes8voZ5EF+lxRCvH+S
         BqtuatyfKafip2JI+S9Zpk9JKIbYUIBrWR/XcajcT6XUTDhInIn70quYCmmZEoXTq7
         a1DmDU1hK+G0g==
Date:   Tue, 7 Feb 2023 09:53:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/vdso: Fake 32bit VDSO build on 64bit compile for
 vgetcpu.
Message-ID: <Y+KCHOkrumS1I/Th@dev-arch.thelio-3990X>
References: <202302071338.m7nBGR5i-lkp@intel.com>
 <Y+IsCWQdXEr8d9Vy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+IsCWQdXEr8d9Vy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 11:46:33AM +0100, Sebastian Andrzej Siewior wrote:
> The 64bit register constrains in __arch_hweight64() can not be
> fulfilled in a 32bit build. The function is only declared, not used
> within vclock_gettime.c and gcc does not care. LLVM complains and
> aborts.
> 
> Move the "fake a 32 bit kernel configuration" bits from vclock_gettime.c
> into a common header file. Use this from vclock_gettime.c and vgetcpu.c.
> 
> Fixes: 92d33063c081a ("x86/vdso: Provide getcpu for x86-32.")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you so much for the fix! Boris inquired why this happens with
clang and I wrote a little blurb here if that is helpful at all:

https://lore.kernel.org/Y+J+UQ1vAKr6RHuH@dev-arch.thelio-3990X/

Regardless, this works for me.

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/entry/vdso/vdso32/fake_32bit_build.h | 25 +++++++++++++++++
>  arch/x86/entry/vdso/vdso32/vclock_gettime.c   | 27 +------------------
>  arch/x86/entry/vdso/vdso32/vgetcpu.c          |  1 +
>  3 files changed, 27 insertions(+), 26 deletions(-)
>  create mode 100644 arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> 
> diff --git a/arch/x86/entry/vdso/vdso32/fake_32bit_build.h b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> new file mode 100644
> index 0000000000000..db1b15f686e32
> --- /dev/null
> +++ b/arch/x86/entry/vdso/vdso32/fake_32bit_build.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifdef CONFIG_X86_64
> +
> +/*
> + * in case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
> + * configuration
> + */
> +#undef CONFIG_64BIT
> +#undef CONFIG_X86_64
> +#undef CONFIG_COMPAT
> +#undef CONFIG_PGTABLE_LEVELS
> +#undef CONFIG_ILLEGAL_POINTER_VALUE
> +#undef CONFIG_SPARSEMEM_VMEMMAP
> +#undef CONFIG_NR_CPUS
> +#undef CONFIG_PARAVIRT_XXL
> +
> +#define CONFIG_X86_32 1
> +#define CONFIG_PGTABLE_LEVELS 2
> +#define CONFIG_PAGE_OFFSET 0
> +#define CONFIG_ILLEGAL_POINTER_VALUE 0
> +#define CONFIG_NR_CPUS 1
> +
> +#define BUILD_VDSO32_64
> +
> +#endif
> diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> index 283ed9d004267..86981decfea83 100644
> --- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> @@ -1,29 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define BUILD_VDSO32
> -
> -#ifdef CONFIG_X86_64
> -
> -/*
> - * in case of a 32 bit VDSO for a 64 bit kernel fake a 32 bit kernel
> - * configuration
> - */
> -#undef CONFIG_64BIT
> -#undef CONFIG_X86_64
> -#undef CONFIG_COMPAT
> -#undef CONFIG_PGTABLE_LEVELS
> -#undef CONFIG_ILLEGAL_POINTER_VALUE
> -#undef CONFIG_SPARSEMEM_VMEMMAP
> -#undef CONFIG_NR_CPUS
> -#undef CONFIG_PARAVIRT_XXL
> -
> -#define CONFIG_X86_32 1
> -#define CONFIG_PGTABLE_LEVELS 2
> -#define CONFIG_PAGE_OFFSET 0
> -#define CONFIG_ILLEGAL_POINTER_VALUE 0
> -#define CONFIG_NR_CPUS 1
> -
> -#define BUILD_VDSO32_64
> -
> -#endif
> -
> +#include "fake_32bit_build.h"
>  #include "../vclock_gettime.c"
> diff --git a/arch/x86/entry/vdso/vdso32/vgetcpu.c b/arch/x86/entry/vdso/vdso32/vgetcpu.c
> index b777f84ffae9b..3a9791f5e9989 100644
> --- a/arch/x86/entry/vdso/vdso32/vgetcpu.c
> +++ b/arch/x86/entry/vdso/vdso32/vgetcpu.c
> @@ -1,2 +1,3 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include "fake_32bit_build.h"
>  #include "../vgetcpu.c"
> -- 
> 2.39.1
> 
