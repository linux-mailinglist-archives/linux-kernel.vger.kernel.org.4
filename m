Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F67733745
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbjFPRPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbjFPRP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FC1BE5;
        Fri, 16 Jun 2023 10:15:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C330361068;
        Fri, 16 Jun 2023 17:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D09C433C8;
        Fri, 16 Jun 2023 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686935725;
        bh=/VL01QYY7k4A6oFIyDQG3r7k5eNpUcuOFid8YHIpOd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYoufRFDo+E/odEtRu1zRiFoYcIZs0lNxZB19pJToqNsk73235HZUwSCKtTfuRrt+
         MiafpE60TbIXDAM+MdnMen9/GZM1ruY866AmTq02c5x04poWFvJbhO/ooo71M7vYlT
         eh+5jSVb8l8bq5g1d6XFX96e0QrNwNeSdXeaqosOXxwNEtZPZGKYzQzcJcsd4ml5Ai
         AW18Qt78TXYbvUS6HUA2S92A0m2sxbUSyhlzTzbFBcNLnVwBXb3DIhbEsDgzQOmie8
         oYGZUTFF6QXHB46t5BlFLpiIVcG37ruXxyPPog6sqbdL39z/q8Cqvxz7gDzf8WxWLO
         PrcPlstaqf09g==
Date:   Fri, 16 Jun 2023 10:15:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 09/11] kbuild: rust_is_available: handle failures
 calling `$RUSTC`/`$BINDGEN`
Message-ID: <20230616171522.GH3474164@dev-arch.thelio-3990X>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-10-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616001631.463536-10-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:16:29AM +0200, Miguel Ojeda wrote:
> The script already checks if `$RUSTC` and `$BINDGEN` exists via
> `command`, but the environment variables may point to a
> non-executable file, or the programs may fail for some other reason.
> While the script successfully exits with a failure as it should,
> the error given can be quite confusing depending on the shell and
> the behavior of its `command`. For instance, with `dash`:
> 
>     $ RUSTC=./mm BINDGEN=bindgen CC=clang scripts/rust_is_available.sh
>     scripts/rust_is_available.sh: 19: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
> 
> Thus detect failure exit codes when calling `$RUSTC` and `$BINDGEN` and
> print a better message, in a similar way to what we do when extracting
> the `libclang` version found by `bindgen`.
> 
> Link: https://lore.kernel.org/rust-for-linux/CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/rust_is_available.sh | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index b7e0781fdea9..da8296cd9b8d 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -81,8 +81,20 @@ fi
>  # Check that the Rust compiler version is suitable.
>  #
>  # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
> +rust_compiler_output=$( \
> +	LC_ALL=C "$RUSTC" --version 2>/dev/null
> +) || rust_compiler_code=$?
> +if [ -n "$rust_compiler_code" ]; then
> +	echo >&2 "***"
> +	echo >&2 "*** Running '$RUSTC' to check the Rust compiler version failed with"
> +	echo >&2 "*** code $rust_compiler_code. See output and docs below for details:"
> +	echo >&2 "***"
> +	echo >&2 "$rust_compiler_output"
> +	echo >&2 "***"
> +	exit 1
> +fi
>  rust_compiler_version=$( \
> -	LC_ALL=C "$RUSTC" --version 2>/dev/null \
> +	echo "$rust_compiler_output" \
>  		| sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_compiler_min_version=$($min_tool_version rustc)
> @@ -108,8 +120,20 @@ fi
>  # Check that the Rust bindings generator is suitable.
>  #
>  # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
> +rust_bindings_generator_output=$( \
> +	LC_ALL=C "$BINDGEN" --version 2>/dev/null
> +) || rust_bindings_generator_code=$?
> +if [ -n "$rust_bindings_generator_code" ]; then
> +	echo >&2 "***"
> +	echo >&2 "*** Running '$BINDGEN' to check the Rust bindings generator version failed with"
> +	echo >&2 "*** code $rust_bindings_generator_code. See output and docs below for details:"
> +	echo >&2 "***"
> +	echo >&2 "$rust_bindings_generator_output"
> +	echo >&2 "***"
> +	exit 1
> +fi
>  rust_bindings_generator_version=$( \
> -	LC_ALL=C "$BINDGEN" --version 2>/dev/null \
> +	echo "$rust_bindings_generator_output" \
>  		| sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_bindings_generator_min_version=$($min_tool_version bindgen)
> -- 
> 2.41.0
> 
