Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FF560D556
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 22:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiJYUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiJYUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 16:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55AEB97B2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 13:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC2061B7C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 20:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF73C433B5;
        Tue, 25 Oct 2022 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666728986;
        bh=0bWEWXQ9szWygDFpBVqZPWoXaDsF27pFL+H9+4oNG1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKgV6rEKC3v2B7LTzxkBdnXuBTX+XjradRHuXCKxjc5OqK7G6roO4MfPZNykHxDHb
         dhbr8GYimGzP2Nzd4Um4L5xNDcB7URQMwMLhJuGZlbRnuoFZ/ezHH/VLLlylTp+PoA
         Fzr7u2+9JQLkS775of0WBAup9hvxE8+fu+5dVY3DwVX4Lk421FMeLfcbAz7Uf0SYH6
         t0+QeDf2SUGFuL2o/kDesCEtHkvXJ/F01j4G80/e/divq1/2kgBznqv7ltxuEX0/HF
         4hr/zvs5wAN3T1MvhT/vXDl4282pqoAPpgcVjPXA+VUd4rYZo504TwzZ7rN9lqZopv
         I646LQduagBZw==
Date:   Tue, 25 Oct 2022 13:16:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Zach O'Keefe <zokeefe@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: clang: mm/khugepaged.c:1729:7: error: variable 'index' is used
 uninitialized whenever 'if' condition is true
 [-Werror,-Wsometimes-uninitialized]
Message-ID: <Y1hEGOJESbuePox2@dev-arch.thelio-3990X>
References: <CA+G9fYucNpHyqt-24OURGSndrBB0z5crq_X0KZTwqQppw9T6fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYucNpHyqt-24OURGSndrBB0z5crq_X0KZTwqQppw9T6fA@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 01:43:48AM +0530, Naresh Kamboju wrote:
> Following build warning / errors noticed while building x86_64 with clang
> on Linux next-20221025 tag.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Build
> * kernel: 6.1.0-rc2
> * git: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> * git branch: master
> * git commit: 89bf6e28373beef9577fa71f996a5f73a569617c
> * git describe: next-20221025
> * test details:
> https://qa-reports.linaro.org/lkft/linux-next-master-sanity/build/next-20221025
> 
> ## Test Regressions (compared to next-20221024)
> Regressions found on x86_64:
> 
>  - clang-nightly-lkftconfig
>  - clang-12-lkftconfig
>  - clang-14-lkftconfig
>  - clang-13-lkftconfig
>  - clang-14-lkftconfig-kcsan
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build LLVM=1 LLVM_IAS=1
> ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu- 'HOSTCC=sccache clang'
> 'CC=sccache clang'
> mm/khugepaged.c:1729:7: error: variable 'index' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:2063:47: note: uninitialized use occurs here
>         trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem,
>                                                      ^~~~~
> mm/khugepaged.c:1729:3: note: remove the 'if' if its condition is always false
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:1716:6: error: variable 'index' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (result != SCAN_SUCCEED)
>             ^~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:2063:47: note: uninitialized use occurs here
>         trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem,
>                                                      ^~~~~
> mm/khugepaged.c:1716:2: note: remove the 'if' if its condition is always false
>         if (result != SCAN_SUCCEED)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:1705:15: note: initialize the variable 'index' to
> silence this warning
>         pgoff_t index, end = start + HPAGE_PMD_NR;
>                      ^
>                       = 0
> mm/khugepaged.c:1729:7: error: variable 'nr' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:2064:15: note: uninitialized use occurs here
>                 addr, file, nr, result);
>                             ^~
> mm/khugepaged.c:1729:3: note: remove the 'if' if its condition is always false
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:1716:6: error: variable 'nr' is used uninitialized
> whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (result != SCAN_SUCCEED)
>             ^~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:2064:15: note: uninitialized use occurs here
>                 addr, file, nr, result);
>                             ^~
> mm/khugepaged.c:1716:2: note: remove the 'if' if its condition is always false
>         if (result != SCAN_SUCCEED)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/khugepaged.c:1710:8: note: initialize the variable 'nr' to silence
> this warning
>         int nr;
>               ^
>                = 0
> 4 errors generated.
> make[3]: *** [scripts/Makefile.build:250: mm/khugepaged.o] Error 1

I sent
https://lore.kernel.org/20221025173407.3423241-1-nathan@kernel.org/ for
this earlier today.

Cheers,
Nathan
