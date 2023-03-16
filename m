Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1E6BD4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCPQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjCPQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:05:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3955B6232B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:05:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6105B82214
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3393CC433EF;
        Thu, 16 Mar 2023 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982725;
        bh=wCjMzefZYuq8Xl/D934vkQjE/JUkIvDeFrgX4FHEZYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5XSWADrmTpAMmvxGsW/DVhOtBXey98Ad5sM7CNzp1/Y0ouOgenv1MpbGlY7BrAMx
         hp4PcaPGukGHin0W7lOB5rkOjlJmUiTXXmjtReh7O0c4Q3vzY+XJoeNwXC9/UksaaF
         +jpg9Gj7dU22mxU6PjDnJZzSHANcrmbjHS8PmNQwgF+eqhBCKXsd41ChuMA1tuuu4Y
         Vxn9FYOiXQdyPyRFiVvQqHbWSJDce4NtHsxn/SYmqSyB6h+HU7ZPuTQ4U6wGzE3q7g
         6iV+XmzAxq9OyEVg+1zXHD4SZnXL84voHgzdDHS3pApkE6dvysdNt8emEcHzKN6J8u
         +CniMVLh7o9EQ==
Date:   Thu, 16 Mar 2023 09:05:23 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] kfence, kcsan: avoid passing -g for tests
Message-ID: <20230316160523.GA90073@dev-arch.thelio-3990X>
References: <20230316155104.594662-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316155104.594662-1-elver@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:51:04PM +0100, Marco Elver wrote:
> Nathan reported that when building with GNU as and a version of clang
> that defaults to DWARF5:
> 
>   $ make -skj"$(nproc)" ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- \
> 			LLVM=1 LLVM_IAS=0 O=build \
> 			mrproper allmodconfig mm/kfence/kfence_test.o
>   /tmp/kfence_test-08a0a0.s: Assembler messages:
>   /tmp/kfence_test-08a0a0.s:14627: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14628: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14632: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14633: Error: non-constant .uleb128 is not supported
>   /tmp/kfence_test-08a0a0.s:14639: Error: non-constant .uleb128 is not supported
>   ...
> 
> This is because `-g` defaults to the compiler debug info default. If the
> assembler does not support some of the directives used, the above errors
> occur. To fix, remove the explicit passing of `-g`.
> 
> All these tests want is that stack traces print valid function names,
> and debug info is not required for that. I currently cannot recall why I
> added the explicit `-g`.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>

Thanks for the quick patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/kcsan/Makefile | 2 +-
>  mm/kfence/Makefile    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
> index 8cf70f068d92..a45f3dfc8d14 100644
> --- a/kernel/kcsan/Makefile
> +++ b/kernel/kcsan/Makefile
> @@ -16,6 +16,6 @@ obj-y := core.o debugfs.o report.o
>  KCSAN_INSTRUMENT_BARRIERS_selftest.o := y
>  obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
>  
> -CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
> +CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -fno-omit-frame-pointer
>  CFLAGS_kcsan_test.o += $(DISABLE_STRUCTLEAK_PLUGIN)
>  obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
> diff --git a/mm/kfence/Makefile b/mm/kfence/Makefile
> index 0bb95728a784..2de2a58d11a1 100644
> --- a/mm/kfence/Makefile
> +++ b/mm/kfence/Makefile
> @@ -2,5 +2,5 @@
>  
>  obj-y := core.o report.o
>  
> -CFLAGS_kfence_test.o := -g -fno-omit-frame-pointer -fno-optimize-sibling-calls
> +CFLAGS_kfence_test.o := -fno-omit-frame-pointer -fno-optimize-sibling-calls
>  obj-$(CONFIG_KFENCE_KUNIT_TEST) += kfence_test.o
> -- 
> 2.40.0.rc1.284.g88254d51c5-goog
> 
