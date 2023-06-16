Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCB73372A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346001AbjFPRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFPRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:07:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E571BE3;
        Fri, 16 Jun 2023 10:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E0263F10;
        Fri, 16 Jun 2023 17:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16526C433C0;
        Fri, 16 Jun 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686935259;
        bh=gmKQ0AURAJf8qyf6k8o+TXk5I0Kft2zeZCsgp/H5lno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nx/Yo4ox0Jdf1B1O9v1eEYjSe1cMbRXurqE8t2Ulm+hIGL3/hJDTZ0E7JcrA0LmEG
         UI5YLgBWIcxCbtgVQzXyGIWUgXF7BiuQuTQTdGiyXQccDnSf6mzGfKItLmm/LreT2h
         6Qc/DhWSksf3S6U6xP2sJZV1Gkw1y+qFuEeZVVt/8VfqKGSqHo+uhXfv6UQb4vIoEZ
         SoZPWMhVl60br4GrYepYeALYVq0xQPbXP4uWyvqI1hei1IMYJh8SxWnixTYuucCdOU
         y31whtpfWAgv4kaEGTUTCv4jWuUvj1cSoK6u8ym4F9u8EbM+ElY25rYufICs09ph1a
         Mc5aWZYnqdjtQ==
Date:   Fri, 16 Jun 2023 10:07:36 -0700
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Finn Behrens <fin@nyantec.com>
Subject: Re: [PATCH v2 04/11] kbuild: rust_is_available: print docs reference
Message-ID: <20230616170736.GC3474164@dev-arch.thelio-3990X>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-5-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616001631.463536-5-ojeda@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:16:24AM +0200, Miguel Ojeda wrote:
> People trying out the Rust support in the kernel may get
> warnings and errors from `scripts/rust_is_available.sh`
> from the `rustavailable` target or the build step.
> 
> Some of those users may be following the Quick Start guide,
> but others may not (likely those getting warnings from
> the build step instead of the target).
> 
> While the messages are fairly clear on what the problem is,
> it may not be clear how to solve the particular issue,
> especially for those not aware of the documentation.
> 
> We could add all sorts of details on the script for each one,
> but it is better to point users to the documentation instead,
> where it is easily readable in different formats. It also
> avoids duplication.
> 
> Thus add a reference to the documentation whenever the script
> fails or there is at least a warning.
> 
> Reviewed-by: Finn Behrens <fin@nyantec.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/rust_is_available.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 0c9be438e4cd..6b8131d5b547 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -19,6 +19,20 @@ get_canonical_version()
>  	echo $((100000 * $1 + 100 * $2 + $3))
>  }
>  
> +# Print a reference to the Quick Start guide in the documentation.
> +print_docs_reference()
> +{
> +	echo >&2 "***"
> +	echo >&2 "*** Please see Documentation/rust/quick-start.rst for details"
> +	echo >&2 "*** on how to set up the Rust support."
> +	echo >&2 "***"
> +}
> +
> +# If the script fails for any reason, or if there was any warning, then
> +# print a reference to the documentation on exit.
> +warning=0
> +trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; fi' EXIT
> +
>  # Check that the Rust compiler exists.
>  if ! command -v "$RUSTC" >/dev/null; then
>  	echo >&2 "***"
> @@ -60,6 +74,7 @@ if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
>  	echo >&2 "***   Your version:     $rust_compiler_version"
>  	echo >&2 "***   Expected version: $rust_compiler_min_version"
>  	echo >&2 "***"
> +	warning=1
>  fi
>  
>  # Check that the Rust bindings generator is suitable.
> @@ -87,6 +102,7 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
>  	echo >&2 "***   Your version:     $rust_bindings_generator_version"
>  	echo >&2 "***   Expected version: $rust_bindings_generator_min_version"
>  	echo >&2 "***"
> +	warning=1
>  fi
>  
>  # Check that the `libclang` used by the Rust bindings generator is suitable.
> @@ -126,6 +142,7 @@ if [ "$cc_name" = Clang ]; then
>  		echo >&2 "***   libclang version: $bindgen_libclang_version"
>  		echo >&2 "***   Clang version:    $clang_version"
>  		echo >&2 "***"
> +		warning=1
>  	fi
>  fi
>  
> -- 
> 2.41.0
> 
