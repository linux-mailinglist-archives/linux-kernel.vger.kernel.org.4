Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04196DB21B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDGRx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDGRxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFCBBAB;
        Fri,  7 Apr 2023 10:53:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9760A61224;
        Fri,  7 Apr 2023 17:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44C8C433EF;
        Fri,  7 Apr 2023 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680890001;
        bh=WDnPJrUPigMG4kgGFxEWGDX8QIBiZEaMWytf2/KBaNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jhp47INhV14wk/HBh87pOS4Egghqrpl9vNTbseUTx+J0gIw3blwBF7wOey8f6748o
         7Gpb8iJv62wr4dbl6aJi8G+3/edYS8dUXpHLHuxGw/kXra0sWHMzsMq/9O1UBi0P25
         /qXAiHyk48fo3bYM/oNaRoTZVgA4WI1dRKSMWgrW+2bev8bAKA7K36UPaQ+t8HULD6
         6ef1tI7wSW5/jwc1GsCoZspNMLYfiC8Ssbq6Q8eVEGcsiuCKd0ZeW0PtNq/S7xlVFc
         ipd0EXrUi1FN4aEkENO0MV1hrQK06wICo08ApLocQhgN/nR9bRDSLJU7PXFrEGiCsQ
         DwdjEIgR5zk0g==
Date:   Fri, 7 Apr 2023 10:53:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Eric Curtin <ecurtin@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
Message-ID: <20230407175318.GA1018455@dev-arch.thelio-3990X>
References: <20230407070517.204676-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407070517.204676-1-andrea.righi@canonical.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:05:17AM +0200, Andrea Righi wrote:
> Commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> introduced the constraint "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE"
> to enable RUST.
> 
> With this constraint we don't need is_rust_module.sh anymore, because
> 'pahole --lang_exclude=rust' already has the capability to exclude Rust
> CUs. If pahole isn't recent enough (< 1.24) to support --lang_exclude,
> then DEBUG_INFO_BTF can't be enabled with RUST and is_rust_module.sh
> isn't used as well.
> 
> In any case is_rust_module.sh is obsolete and we can just drop it.
> 
> Link: https://lore.kernel.org/lkml/Y+p2xKIN6TJnQinK@righiandr-XPS-13-7390/
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  rust/macros/module.rs     |  2 +-
>  scripts/Makefile.modfinal |  2 --
>  scripts/is_rust_module.sh | 16 ----------------
>  3 files changed, 1 insertion(+), 19 deletions(-)
>  delete mode 100755 scripts/is_rust_module.sh
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..608406f33a70 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -179,7 +179,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>              /// Used by the printing macros, e.g. [`info!`].
>              const __LOG_PREFIX: &[u8] = b\"{name}\\0\";
>  
> -            /// The \"Rust loadable module\" mark, for `scripts/is_rust_module.sh`.
> +            /// The \"Rust loadable module\" mark.
>              //
>              // This may be best done another way later on, e.g. as a new modinfo
>              // key or a new section. For the moment, keep it simple.

It seems like this whole section can be dropped? I only see
__IS_RUST_MODULE used in scripts/is_rust_module.sh, as the comment
states.

> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
x> index 4703f652c009..e6f8fa3c9b8d 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -41,8 +41,6 @@ quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
>  	if [ ! -f vmlinux ]; then					\
>  		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> -	elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then 		\
> -		printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
>  	else								\
>  		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
>  		$(RESOLVE_BTFIDS) -b vmlinux $@; 			\
> diff --git a/scripts/is_rust_module.sh b/scripts/is_rust_module.sh
> deleted file mode 100755
> index 28b3831a7593..000000000000
> --- a/scripts/is_rust_module.sh
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# is_rust_module.sh module.ko
> -#
> -# Returns `0` if `module.ko` is a Rust module, `1` otherwise.
> -
> -set -e
> -
> -# Using the `16_` prefix ensures other symbols with the same substring
> -# are not picked up (even if it would be unlikely). The last part is
> -# used just in case LLVM decides to use the `.` suffix.
> -#
> -# In the future, checking for the `.comment` section may be another
> -# option, see https://github.com/rust-lang/rust/pull/97550.
> -${NM} "$*" | grep -qE '^[0-9a-fA-F]+ r _R[^[:space:]]+16___IS_RUST_MODULE[^[:space:]]*$'
> -- 
> 2.39.2
> 
