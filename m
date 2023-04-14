Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EF16E2A72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDNTJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjDNTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:09:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23343F5;
        Fri, 14 Apr 2023 12:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B26C864941;
        Fri, 14 Apr 2023 19:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDBBC433EF;
        Fri, 14 Apr 2023 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681499343;
        bh=8+ul74ZOMPCS9hfly4Btg1dktvKcVkcKPgQLuyGVrSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7NqpW/juNRjpXma8oVlbDfAIehEEZ1EhICsU4T4QzgIg9YAqWTqr3zCyrkth0awX
         pah4hp2eVg06zve9pJ8HqJA8hJnXNdz9tlKqsZLDOLg4w7SMceK07jeTLGOfgg1Vdf
         nglfKUf5VZDs8Zn/achnWXYxrhKlhqk9Wh7WcsExotAz2OeASTQwVe2mivL1P6KFiA
         b+8OgM066vExi1h+E/9BjAY4Eo7gNMBsBolG1GBJ9ep3NG/PY2jW9cTF0ie1rVLfGi
         Tol3SAq1do87ctDPOo8GMIN3gjeer6X2Q7YIeACAPmDWzDE5yBOyZ8on77qLn/NVua
         UmuRaO4JIOPtA==
Date:   Fri, 14 Apr 2023 12:09:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] kasan: remove hwasan-kernel-mem-intrinsic-prefix=1 for
 clang-14
Message-ID: <20230414190900.GA1277152@dev-arch.thelio-3990X>
References: <20230414082943.1341757-1-arnd@kernel.org>
 <20230414162605.GA2161385@dev-arch.thelio-3990X>
 <24ebf857-b70d-4d94-8870-e41b91649dd1@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ebf857-b70d-4d94-8870-e41b91649dd1@app.fastmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 08:53:49PM +0200, Arnd Bergmann wrote:
> On Fri, Apr 14, 2023, at 18:26, Nathan Chancellor wrote:
> > On Fri, Apr 14, 2023 at 10:29:27AM +0200, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> Unknown -mllvm options don't cause an error to be returned by clang, so
> >> the cc-option helper adds the unknown hwasan-kernel-mem-intrinsic-prefix=1
> >> flag to CFLAGS with compilers that are new enough for hwasan but too
> >
> > Hmmm, how did a change like commit 0e1aa5b62160 ("kcsan: Restrict
> > supported compilers") work if cc-option does not work with unknown
> > '-mllvm' flags (or did it)? That definitely seems like a problem, as I
> > see a few different places where '-mllvm' options are used with
> > cc-option. I guess I will leave that up to the sanitizer folks to
> > comment on that further, one small comment below.
> 
> That one adds both "-fsanitize=thread" and "-mllvm
> -tsan-distinguish-volatile=1". If the first one is missing in the
> compiler, neither will be set. If only the second one fails, I assume
> you'd get the same result I see with hwasan-kernel-mem-intrinsic-prefix=1.

I did not look close enough but it turns out that this check is always
true for the versions of clang that the kernel currently supports, so it
could not fail even if '-mllvm' flag checking worked.

$ git grep tsan-distinguish-volatile llvmorg-11.0.0
llvmorg-11.0.0:llvm/lib/Transforms/Instrumentation/ThreadSanitizer.cpp:    "tsan-distinguish-volatile", cl::init(false),
llvmorg-11.0.0:llvm/test/Instrumentation/ThreadSanitizer/volatile.ll:; RUN: opt < %s -tsan -tsan-distinguish-volatile -S | FileCheck %s

At the time of the Linux change though, we did not have a minimum
supported version, so that check was necessary. I wonder if LLVM
regressed with regards to '-mllvm' flag checking at some point...

> >>  # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
> >> +ifeq ($(call clang-min-version, 150000),y)
> >>  CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> >> +endif
> >> +ifeq ($(call gcc-min-version, 130000),y)
> >> +CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> >> +endif
> >
> > I do not think you need to duplicate this block, I think
> >
> >   ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
> >   CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
> >   endif
> >
> > would work, as only one of those conditions can be true at a time.
> 
> Are you sure that clang-min-version evaluates to an empty string
> rather than "n" or something else? I haven't found a documentation
> that says anything about it other than it returning "y" if the condition
> is true.

Yes, see the test-ge and test-gt macros in scripts/Kbuild.include, they
will only ever print the empty string or 'y'.

Cheers,
Nathan
