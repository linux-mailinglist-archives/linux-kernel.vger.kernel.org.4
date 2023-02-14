Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD9696919
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjBNQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjBNQRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:17:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBB14487;
        Tue, 14 Feb 2023 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HQWT0UEujdRQnf0AFB/1J+vl+szo2swZATL+M3tZN50=; b=GOd04eRWg0mkRtf+5F1z7VE59x
        hwOr6d/MK4+PyuUdYXLalP6iKpIw+WwCpgPm/QP43Gfn5m2JTXY3O70LcCVhlXEqWMNZh2lamTbzp
        iKjtkgbBTAdRd9q3YKJRgeIHYah46vsWatow3rJWib7OwPFlvfow2NCMG/NSBcGZ+oX1tqXzLiFdW
        uN4HsZPGsMOqHSDvqZ4OhuPYmnZufpOHc93gtAujOU5nEIWzT8pq6E1SP7Im0pRsocfc+IPlNMc1W
        kuqK5KoFO/lbEKVF2Vx1qdOoBEHMtFtcbEQr0XfdErt8jUV2bnj3t6tzlI3Gy1iZ7ZAx2FYN3Mqwj
        oOoKQGnQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRxz6-006dOw-P6; Tue, 14 Feb 2023 16:16:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1DC5300750;
        Tue, 14 Feb 2023 11:18:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92A2720D16AB9; Tue, 14 Feb 2023 11:18:13 +0100 (CET)
Date:   Tue, 14 Feb 2023 11:18:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jakub Jelinek <jakub@redhat.com>,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH -tip v3] kasan: Emit different calls for instrumentable
 memintrinsics
Message-ID: <Y+tf5ZOR5J92wSsw@hirez.programming.kicks-ass.net>
References: <20230213201334.1494626-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213201334.1494626-1-elver@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 09:13:35PM +0100, Marco Elver wrote:
> Clang 15 will provide an option to prefix calls to memcpy/memset/memmove
> with __asan_ in instrumented functions: https://reviews.llvm.org/D122724
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

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
> v3:
> * Resend with actual fix.
> 
> v2:
> * Use asan-kernel-mem-intrinsic-prefix=1, so that once GCC supports the
>   param, it also works there (it needs the =1).
> 
> The Fixes tag is just there to show the dependency, and that people
> shouldn't apply this patch without 69d4c0d32186.
> ---
>  scripts/Makefile.kasan | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index b9e94c5e7097..3b35a88af60d 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -38,6 +38,13 @@ endif
>  
>  CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
>  
> +ifdef CONFIG_GENERIC_ENTRY
> +# Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
> +# instead. With compilers that don't support this option, compiler-inserted
> +# memintrinsics won't be checked by KASAN.
> +CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
> +endif
> +
>  endif # CONFIG_KASAN_GENERIC
>  
>  ifdef CONFIG_KASAN_SW_TAGS
> -- 
> 2.39.1.581.gbfd45094c4-goog
> 
