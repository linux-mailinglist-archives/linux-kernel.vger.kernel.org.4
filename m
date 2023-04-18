Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775C6E60EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjDRMNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjDRMNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:13:38 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052DAAD15
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:13:17 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-760f29073b4so43146539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681819996; x=1684411996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3C41xG4p1BHPpadBDL6pJd1psfwz5yd3WchMAQj7wTI=;
        b=Jyi6R/m83VokG9frSymybQC2AFMBTwvKU6IH5SFWbNjoMUuihDbL0fvrWRHM6fEqgd
         I2k47/ZF5tI1vrJWYWIykz1ylPVltQkexdvlSPDZYCgJnZzCaMTDv7BxcRoGrWxVeAzB
         HDEKS/SmuA/bzYbFywmTHTLYu8W2uNraQzCUNzjqcdhps8XlbmuhEWVF3zrVq5oHHMaC
         +SI/TmqjkiRknqu/hej1YElkV7TId33p5MBVP/dLCVBDfuW/ppoMS6k9YE+/lVByu+gu
         S+ge3LbP56WzvGvqntgCTFsEfFQPT0BnuVAhHl3ukFLSOdNN02OFZZkKWZ+k5KMAcq6r
         rDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819996; x=1684411996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3C41xG4p1BHPpadBDL6pJd1psfwz5yd3WchMAQj7wTI=;
        b=UDrUWtsdBsbdYY4PWxh1nPZNyKIYkR4S+h9xmscJOBHwiM8gy6TwWXufLnOrXsHlGn
         1SN9ss6ltYVFkxE9JtanLkcHJ9NL/3C51oWKUn7BFxJmxSiD5Fbp+/QwpJYdUnzZb8rf
         Q+aPK0J0RHZyShCjlMuT92P72S2S9NDJ7dlZD9uLVN0Q6/glT22MALoYE0/tfESSun22
         nHywkeUj6vxNe6ltrI+v9YcqQX5X+4kQ7qpa/FKFJmgWsRUuAVFG6vZtDmXnPbycIf/m
         ycYxV22wU6QjSuGhTqsGqLX3DESX6zxBB0P9tTt/tUdeUzxtCKbcZe9XQdClk+c4B00x
         Dn3Q==
X-Gm-Message-State: AAQBX9cuad1dtORhOmF61KvKzVjEATS7PvjjpicUAsa5vhabwQRX1kPA
        S/eEaay8E3pi/4xGJM/zFyf4FIbATomBWz8yK+i33Q==
X-Google-Smtp-Source: AKy350ZfZvWa02fGm9TNYBrnOE+KkUawW1Q+TjXvWWE0Le8UwLNHTJEKGZCr3PzZ4WA37tJhHE1QeuNMJWiiACAZIic=
X-Received: by 2002:a6b:6e06:0:b0:762:7e58:8d38 with SMTP id
 d6-20020a6b6e06000000b007627e588d38mr1759080ioh.10.1681819995595; Tue, 18 Apr
 2023 05:13:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230224085942.1791837-1-elver@google.com> <ZDgOSp30Ec00u8wP@arm.com>
In-Reply-To: <ZDgOSp30Ec00u8wP@arm.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 14:12:39 +0200
Message-ID: <CANpmjNMNNc8yizJE8T1+Xrg1rGm+EbBuqybF9j1YE9miqdtasA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] kasan: Emit different calls for instrumentable memintrinsics
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 at 16:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Marco,
>
> On Fri, Feb 24, 2023 at 09:59:39AM +0100, Marco Elver wrote:
> > Clang 15 provides an option to prefix memcpy/memset/memmove calls with
> > __asan_/__hwasan_ in instrumented functions: https://reviews.llvm.org/D122724
> >
> > GCC will add support in future:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108777
> >
> > Use it to regain KASAN instrumentation of memcpy/memset/memmove on
> > architectures that require noinstr to be really free from instrumented
> > mem*() functions (all GENERIC_ENTRY architectures).
> >
> > Fixes: 69d4c0d32186 ("entry, kasan, x86: Disallow overriding mem*() functions")
> > Signed-off-by: Marco Elver <elver@google.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> [...]
> > diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> > index b9e94c5e7097..fa9f836f8039 100644
> > --- a/scripts/Makefile.kasan
> > +++ b/scripts/Makefile.kasan
> > @@ -38,6 +38,11 @@ endif
> >
> >  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
> >
> > +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> > +# instead. With compilers that don't support this option, compiler-inserted
> > +# memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
> > +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
> > +
> >  endif # CONFIG_KASAN_GENERIC
> >
> >  ifdef CONFIG_KASAN_SW_TAGS
> > @@ -54,6 +59,9 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> >               $(call cc-param,hwasan-inline-all-checks=0) \
> >               $(instrumentation_flags)
> >
> > +# Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> > +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
>
> This patch breaks the arm64 kernel builds with KASAN_SW_TAGS enabled and
> clang prior to version 15. Those prior clang versions don't like the
> '-mllvm -hwasan-kernel-mem-intrinsic-prefix=1' option, end up printing
> the help text instead of generating the object.
>
> Do we need some combination of cc-option and cc-param? Or at least
> disable this instrumentation if earlier clang versions are used.
>
> It's already in mainline as commit
> 51287dcb00cc715c27bf6a6b4dbd431621c5b65a.

Arnd posted a patch, but the reason why a workaround is needed is
quite unfortunate:
https://lore.kernel.org/all/CANpmjNMwYosrvqh4ogDO8rgn+SeDHM2b-shD21wTypm_6MMe=g@mail.gmail.com/

Clang apparently interprets unknown options that start with "-h..",
i.e. "-mllvm -h..." as a request to print help text, which has exit
code 0. So this is only a problem for hwasan options.
