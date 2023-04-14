Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696C6E2843
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDNQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjDNQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:26:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1738C26A6;
        Fri, 14 Apr 2023 09:26:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95674648F6;
        Fri, 14 Apr 2023 16:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B58C433D2;
        Fri, 14 Apr 2023 16:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681489568;
        bh=9dGs3TW9SOqFu3PmMFt8oVQybRajp0/o5j5Brj6gn0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3qAa/tCEuOQUzRwfLB0aGf7iU1bf2YL4bclomJmgllHNHUVZqFxLgxPN0hwSBsr2
         6cpRt5bVCm5ItQtZV92nvqQpmEqU2syQzwuxx+Cy+ss4E1JBzJncXuTRVgzChvksm7
         yRqyNUv8VxLZn99sZaTBQ+STa2c+xj2e/1Fvd/d/9l7phb3zYlGxcv5fOtz1cD9al7
         vESoRZA+A25yjhW9kPcijjWuR7QFfSBAyXa9U4Cl25dUG0mHUVVuQhjN0h8eKCuA9C
         nOxX1dIzLW7gm9XRPNGRBzB3/M4lhNUGD3nsNDYq5/8zavX9b/DeqWIbZkAbVrn2ox
         L9DBeg9yxx2Cw==
Date:   Fri, 14 Apr 2023 09:26:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for
 clang-14
Message-ID: <20230414162605.GA2161385@dev-arch.thelio-3990X>
References: <20230414082943.1341757-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414082943.1341757-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 10:29:27AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Unknown -mllvm options don't cause an error to be returned by clang, so
> the cc-option helper adds the unknown hwasan-kernel-mem-intrinsic-prefix=1
> flag to CFLAGS with compilers that are new enough for hwasan but too

Hmmm, how did a change like commit 0e1aa5b62160 ("kcsan: Restrict
supported compilers") work if cc-option does not work with unknown
'-mllvm' flags (or did it)? That definitely seems like a problem, as I
see a few different places where '-mllvm' options are used with
cc-option. I guess I will leave that up to the sanitizer folks to
comment on that further, one small comment below.

> old for this option. This causes a rather unreadable build failure:
> 
> fixdep: error opening file: scripts/mod/.empty.o.d: No such file or directory
> make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:252: scripts/mod/empty.o] Error 2
> fixdep: error opening file: scripts/mod/.devicetable-offsets.s.d: No such file or directory
> make[4]: *** [/home/arnd/arm-soc/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 2
> 
> Add a version check to only allow this option with clang-15, gcc-13
> or later versions.
> 
> Fixes: 51287dcb00cc ("kasan: emit different calls for instrumentable memintrinsics")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> There is probably a better way to do this than to add version checks,
> but I could not figure it out.
> ---
>  scripts/Makefile.kasan | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index c186110ffa20..2cea0592e343 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -69,7 +69,12 @@ CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
>  		$(instrumentation_flags)
>  
>  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> +ifeq ($(call clang-min-version, 150000),y)
>  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> +endif
> +ifeq ($(call gcc-min-version, 130000),y)
> +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> +endif

I do not think you need to duplicate this block, I think

  ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
  endif

would work, as only one of those conditions can be true at a time.

Cheers,
Nathan
