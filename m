Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC96924B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjBJRj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjBJRjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:39:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656127BFDC;
        Fri, 10 Feb 2023 09:39:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FC561E4F;
        Fri, 10 Feb 2023 17:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102FC433EF;
        Fri, 10 Feb 2023 17:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676050770;
        bh=kiy2JiN2biw1ATOIFFLZuY+hz6dWKYNT6+5fl2JtzAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvkqdS/s0ZzVDElBVxJvXMgBEuwCJU1JDYZrEG5eE4Orc4oMfbDYzFWd7BU/zSCNn
         stkVs6qBmtqAuFtOUc98jCF58fnXRU4PPAIXMRgl1IyYbxAjOS7rVzt0cIdcrXz2Uv
         CGKn4Az9g/HfjBuEekre7sTRwM1FGcfSBhJk777YNRaIkXT2GT0x2m/TDRciQgKF1n
         szBTirfQ6IozKu8/5Ket22iu1FWwqs5cD9a/uBST7O7GfouoVdJojVxxs7m9aWx/uL
         /wEkMxD3Y/k0TBOLmkJuggcSO/NWayUHqQvR3EgaLV7SCf8gwNfhZr/B3uB9LN9/6L
         OpQXdVzO7V+bw==
Date:   Fri, 10 Feb 2023 10:39:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: allow to use INIT_STACK_ALL_ZERO
Message-ID: <Y+aBT8AD9RXde24X@dev-arch.thelio-3990X>
References: <20230210172203.101331-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210172203.101331-1-andrea.righi@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 06:22:03PM +0100, Andrea Righi wrote:
> With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen is passing
> -ftrivial-auto-var-init=zero to clang, that triggers the following:
> 
>   error: '-ftrivial-auto-var-init=zero' hasn't been enabled; enable it at your own peril for benchmarking purpose only with '-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang'
> 
> This flag should be dropped in clang-17, but at the moment it seems more
> reasonable to add it to the bindgen CFLAGS to prevent the error above.
> 
> In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
> without triggering any build error.
> 
> Link: https://reviews.llvm.org/D125142
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

If this went via the kbuild tree, would we be able to use
$(CC_AUTO_VAR_INIT_ZERO_ENABLER)?

https://git.kernel.org/masahiroy/linux-kbuild/c/4e3feaad6ff8a7a57e3bf3308a93c93e3a2e17a6

Although, I suppose this could be a problem if the version of clang
being used to build the kernel does not support this flag while the
version of libclang in bindgen requires it?

> ---
>  rust/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index ff70c4c916f8..5e26db07a1dc 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -267,7 +267,8 @@ BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  # All warnings are inhibited since GCC builds are very experimental,
>  # many GCC warnings are not supported by Clang, they may only appear in
>  # some configurations, with new GCC versions, etc.
> -bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET)
> +bindgen_extra_c_flags = -w --target=$(BINDGEN_TARGET) \
> +			-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
>  
>  bindgen_c_flags = $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
>  	$(bindgen_extra_c_flags)
> -- 
> 2.37.2
> 
