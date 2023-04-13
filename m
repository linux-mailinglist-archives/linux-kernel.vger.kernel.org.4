Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BEA6E0FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjDMOOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjDMOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:14:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42742D4E;
        Thu, 13 Apr 2023 07:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FFC563EFF;
        Thu, 13 Apr 2023 14:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A3DC433EF;
        Thu, 13 Apr 2023 14:14:37 +0000 (UTC)
Date:   Thu, 13 Apr 2023 15:14:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v5 1/4] kasan: Emit different calls for instrumentable
 memintrinsics
Message-ID: <ZDgOSp30Ec00u8wP@arm.com>
References: <20230224085942.1791837-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224085942.1791837-1-elver@google.com>
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, Feb 24, 2023 at 09:59:39AM +0100, Marco Elver wrote:
> Clang 15 provides an option to prefix memcpy/memset/memmove calls with
> __asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724
> 
> GCC will add support in future:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777
> 
> Use it to regain KASAN instrumentation of memcpy/memset/memmove on
> architectures that require noinstr to be really free from instrumented
> mem*() functions (all GENERIC_ENTRY architectures).
> 
> Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
[...]
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index b9e94c5e7097..fa9f836f8039 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -38,6 +38,11 @@ endif
>  
>  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
>  
> +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> +# instead. With compilers that don't support this option, compiler-inserted
> +# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
> +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
> +
>  endif # CONFIG_KASAN_GENERIC
>  
>  ifdef CONFIG_KASAN_SW_TAGS
> @@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>  		$(call cc-param,hwasan-inline-all-checks=0) \
>  		$(instrumentation_flags)
>  
> +# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)

This patch breaks the arm64 kernel builds with KASAN_SW_TAGS enabled and
clang prior to version 15. Those prior clang versions don't like the
'-mllvm -hwasan-kernel-mem-intrinsic-prefix=1' option, end up printing
the help text instead of generating the object.

Do we need some combination of cc-option and cc-param? Or at least
disable this instrumentation if earlier clang versions are used.

It's already in mainline as commit
51287dcb00cc715c27bf6a6b4dbd431621c5b65a.

Thanks.

-- 
Catalin
