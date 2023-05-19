Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835DD709552
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjESKph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjESKpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A9AE7F;
        Fri, 19 May 2023 03:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6257565676;
        Fri, 19 May 2023 10:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CA5C433D2;
        Fri, 19 May 2023 10:45:27 +0000 (UTC)
Date:   Fri, 19 May 2023 11:45:24 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        jforbes@fedoraproject.org, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: arm64: build/gcc-12-lkftconfig-64k_page_size - error: call
 to '__compiletime_assert_494' declared with attribute error: BUILD_BUG_ON
 failed: (((16 - 3) * (4 - (2)) + 3)-16) > 10
Message-ID: <ZGdTRLWgk2+Jx+rJ@arm.com>
References: <CA+G9fYszL_ccRR+-YUXfm4tzv_bA=can-o-hYhQ+F1HyGY7Mtw@mail.gmail.com>
 <CA+G9fYuoo5OKBj4ymCrM05eEnPEjk6rVX+3=p3+WTW1A5L6Pmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuoo5OKBj4ymCrM05eEnPEjk6rVX+3=p3+WTW1A5L6Pmg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 04:06:35PM +0530, Naresh Kamboju wrote:
> On Wed, 17 May 2023 at 18:56, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Following arm64 builds failed on Linux next-20230517.
> >
> >  - build/gcc-12-lkftconfig-64k_page_size
> >  - build/gcc-11-lkftconfig-64k_page_size
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build log:
> > ======
> > include/asm-generic/div64.h:46:27: warning: conversion from 'long
> > unsigned int' to 'uint32_t' {aka 'unsigned int'} changes value from
> > '4398046511104' to '0' [-Woverflow]
> >    46 |         uint32_t __base = (base);                               \
> >       |                           ^
> > include/linux/math.h:40:44: note: in expansion of macro 'do_div'
> >    40 |         ({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
> >       |                                            ^~~~~~
> > include/linux/math.h:43:9: note: in expansion of macro 'DIV_ROUND_DOWN_ULL'
> >    43 |         DIV_ROUND_DOWN_ULL((unsigned long long)(ll) + (d) - 1, (d))
> >       |         ^~~~~~~~~~~~~~~~~~
> > arch/arm64/kvm/mmu.c:95:22: note: in expansion of macro 'DIV_ROUND_UP_ULL'
> >    95 |                 n += DIV_ROUND_UP_ULL(range, PUD_SIZE);
> >       |                      ^~~~~~~~~~~~~~~~
> > In file included from <command-line>:
> > mm/huge_memory.c: In function 'hugepage_init':
> > include/linux/compiler_types.h:397:45: error: call to
> > '__compiletime_assert_494' declared with attribute error: BUILD_BUG_ON
> > failed: (((16 - 3) * (4 - (2)) + 3)-16) > 10
> >   397 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |                                             ^
> > include/linux/compiler_types.h:378:25: note: in definition of macro
> > '__compiletime_assert'
> >   378 |                         prefix ## suffix();
> >          \
> >       |                         ^~~~~~
> > include/linux/compiler_types.h:397:9: note: in expansion of macro
> > '_compiletime_assert'
> >   397 |         _compiletime_assert(condition, msg,
> > __compiletime_assert_, __COUNTER__)
> >       |         ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro
> > 'compiletime_assert'
> >    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >       |                                     ^~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
> >    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >       |         ^~~~~~~~~~~~~~~~
> > include/linux/bug.h:24:25: note: in expansion of macro 'BUILD_BUG_ON'
> >    24 |                         BUILD_BUG_ON(cond);             \
> >       |                         ^~~~~~~~~~~~
> > mm/huge_memory.c:470:9: note: in expansion of macro 'MAYBE_BUILD_BUG_ON'
> >   470 |         MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER > MAX_ORDER);
> >       |         ^~~~~~~~~~~~~~~~~~
> > make[3]: *** [scripts/Makefile.build:252: mm/huge_memory.o] Error 1
> 
> Linux next 20230517 arm64 64k page size build failed.
> 
>   - CONFIG_ARM64_64K_PAGES=y
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Anders bisected and found the following is the first bad commit.
> 
> commit fd2d1cb8c5454888f67aba4c6218e30106862070
> Author: Catalin Marinas <catalin.marinas@arm.com>
> Date:   Wed May 3 13:33:42 2023 +0100
> 
>     arm64: Make the ARCH_FORCE_MAX_ORDER config input prompt unconditional

We are dropping this commit for now but the problem is still there with
EXPERT enabled.

The problem is that we start with ARCH_FORCE_MAX_ORDER of 10 in
defconfig and we then change the page size to 64K but this value is no
longer valid (only 13 works for this page size).

I'll send a patch dropping the config description entirely, unless there
are some strong requirements to have the ranges back.

-- 
Catalin
