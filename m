Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE249666B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 07:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjALGX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 01:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjALGXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 01:23:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28B841000;
        Wed, 11 Jan 2023 22:23:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885E9B81DB5;
        Thu, 12 Jan 2023 06:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32714C43396;
        Thu, 12 Jan 2023 06:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673504598;
        bh=/RCNuQr6WRHa66Xb4//C83baWNn3VPnq6QBFQQ6fxZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rbhBN2LmRRXLpW9/3NNvuB7iUq3uIEl/pQK6SM+20c0XxexSes7iXM2/3VEkHsPYm
         PI1qofLpTImTKchrbnBDZ3efPpaF8pNuKqcxDXtx0lvj5U/0rY/2eBISl6dXVbWO8E
         Ys7zZ6N+U3ywD8eLk3lqlHnV9lUSjCkLDpsoHzXr8aPp0+lBoWQ+PZZhi+l0lEH1lx
         osAWkbS2ZhwKnK+3G9xVZxaNtFBohwzJwk/wdJ6zEQh2nifLZX6BPaWWU9GkaFO/xy
         zUoxPG2QKWFVMUeVKXxf+eaLsYpNPO/dhxv4E/Q77tNLN29CfhuK8v+LgVAfHxgOeb
         QZnJrY7w1NurQ==
Received: by mail-oi1-f173.google.com with SMTP id n8so14620574oih.0;
        Wed, 11 Jan 2023 22:23:18 -0800 (PST)
X-Gm-Message-State: AFqh2kr42c5FkiQZv5bdOMMgjSwwAvFekiShpbfK4MIN/cXirFle8cnc
        ExZ6eLwCNQ7MWArZOVY31Jq1i3jhupCknj7Xrm0=
X-Google-Smtp-Source: AMrXdXvuxQPCrcD75or7FJw8XqNZU8LWRTvOMxvIDMZy99+x9b13wEK7RuDEXMYDZzzHOghqdcAe9VGxtcfaZVeAYV8=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr4869285oia.287.1673504597380; Wed, 11
 Jan 2023 22:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-6-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-6-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Jan 2023 15:22:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com>
Message-ID: <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: rust_is_available: normalize version matching
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 5:46 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> In order to match the version string, `sed` is used in a couple
> cases, and `grep` and `head` in a couple others.
>
> Make the script more consistent and easier to understand by
> using the same method, `sed`, for all of them.
>
> This makes the version matching also a bit more strict for
> the changed cases, since the strings `rustc ` and `bindgen `
> will now be required, which should be fine since `rustc`
> complains if one attempts to call it with another program
> name, and `bindgen` uses a hardcoded string.
>
> In addition, clarify why one of the existing `sed` commands
> does not provide an address like the others.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>


Maybe, your purpose is to use sed consistently, but
perhaps you can avoid forking sed if you know the
format of the first line.


BTW, what is missing here is, you do not check if
${RUSTC} is really rustc.


I can fool this script to print
"arithmetic expression: expecting primary: "100000 *  + 100 *  + "



$ make RUSTC=true rustavailable
./scripts/rust_is_available.sh: 19: arithmetic expression: expecting
primary: "100000 *  + 100 *  + "
***
*** Please see Documentation/rust/quick-start.rst for details
*** on how to setup Rust support.
***
make: *** [Makefile:1809: rustavailable] Error 2






scripts/{as,ld}-version.sh tried their best to
parse the line with shell syntax only, and
print "unknown assembler invoked" if the given
tool does not seem to be a supported assembler.







> ---
>  scripts/rust_is_available.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index a86659410e48..99811842b61f 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -66,8 +66,7 @@ fi
>  # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
>  rust_compiler_version=$( \
>         LC_ALL=C "$RUSTC" --version 2>/dev/null \
> -               | head -n 1 \
> -               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> +               | sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_compiler_min_version=$($min_tool_version rustc)
>  rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
> @@ -94,8 +93,7 @@ fi
>  # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
>  rust_bindings_generator_version=$( \
>         LC_ALL=C "$BINDGEN" --version 2>/dev/null \
> -               | head -n 1 \
> -               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> +               | sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_bindings_generator_min_version=$($min_tool_version bindgen)
>  rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
> @@ -139,6 +137,9 @@ fi
>
>  # `bindgen` returned successfully, thus use the output to check that the version
>  # of the `libclang` found by the Rust bindings generator is suitable.
> +#
> +# Unlike other version checks, note that this one does not necessarily appear
> +# in the first line of the output, thus no `sed` address is provided.
>  bindgen_libclang_version=$( \
>         echo "$bindgen_libclang_output" \
>                 | sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
> --
> 2.39.0
>


-- 
Best Regards
Masahiro Yamada
