Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6054F68DE2A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBGQqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjBGQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:46:10 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B94E2D61
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:46:06 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so3318134wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=organization:user-agent:in-reply-to:content-disposition
         :mime-version:references:mail-followup-to:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFe7KbGPSeSiCrhFu3zhIymixh3OVejotXYjmmT4LpA=;
        b=pVJKa+Yw9c5Pb2oJDDnL+KJnajwqE9JCncKUBKdlTPQbi+loPjnTw0NC/vW5VRabHS
         uhEYYN69TfSKNdSdICYnxGem6ZISvDI7GVQFzVlF303lVIcIvRac/U7XEj/k4D2ien3V
         neKvUuxk63Yeoz+3TtA/+z67qyqop4d7sUXcAUERKpCSPXiyDe8JirWjaONALMvyXkH6
         yv6MkgMJ/ZbnpaGnS9dQmHynUafAhdzqRp+9+aS6W8GjURGUbkkPKqThKiXfrRUuK/ta
         o9f+1Phth7eIIujb787d15Aqfb1q1MdC9xxUuI44jTHX70+fWioghW0hDaQDfOzhVEVY
         oYVg==
X-Gm-Message-State: AO0yUKVPHfDqfKFRFSsmfxqIx92Q0O4efaNrCDukFv06RnvLEvdnGVK+
        Infa3s+pZxB1KG8gJktJ43xJ9+MZBEmiDn2mbbDWPg==
X-Google-Smtp-Source: AK7set8IQRTQ5/BGaLtaTu+sYMcnNDZr8Z6VT4BBBa0DxPnIF8+SzZ7cxDlQ5DGsPVF0zKnkYP9LnQ==
X-Received: by 2002:a05:600c:4b1b:b0:3d9:f836:3728 with SMTP id i27-20020a05600c4b1b00b003d9f8363728mr3707950wmp.11.1675788364490;
        Tue, 07 Feb 2023 08:46:04 -0800 (PST)
Received: from fedora (p549440c4.dip0.t-ipconnect.de. [84.148.64.196])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c198800b003dff870ce0esm9043123wmq.2.2023.02.07.08.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:46:04 -0800 (PST)
Date:   Tue, 7 Feb 2023 17:45:59 +0100
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
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
Message-ID: <Y+KAR/Jxz4U30qST@fedora>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <202302071338.m7nBGR5i-lkp@intel.com>
 <Y+IsCWQdXEr8d9Vy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+IsCWQdXEr8d9Vy@linutronix.de>
User-Agent: Mutt
Organization: Familie Tometzki
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sebastian,
Linux Kernel build 6.2.0rc7 was successfully with clang-17.

Many Thanks
Damian Tometzki


On Tue, 07. Feb 11:46, Sebastian Andrzej Siewior wrote:
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
