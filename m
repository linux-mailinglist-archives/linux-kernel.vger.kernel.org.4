Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C9C663DD7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAJKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjAJKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:16:54 -0500
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 02:16:39 PST
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9E141D76;
        Tue, 10 Jan 2023 02:16:39 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4Nrmtq4LVhz9t7Z;
        Tue, 10 Jan 2023 11:16:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1673345795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IUg8Et5IkHA9DdwmBM0zPxl4bj+zRYsG0exsYo0MV0=;
        b=poeGSm+lgAhdQHYBpqCTYPAZ8w3Pb1lDmlitQO9C27MYchgg2SQJ3E9SDkQ40CbNWEs/X0
        6W3/S+e0MyKAb90i1y9+sWmuQQ74/RjmHjFv41hneE7Zmg9GgQUznfyt9lopyESrZxJhxl
        3R2RPETiIW87xD05Qn8+PWMvMT2CZ3kdP3f321XrHPEkD74PKH3t7v8zW7YUwuK9szOqtb
        VoBXflXAqp1h8eunk9/zUEYOnj3I3V3OuushZ4cI/d7HjUHeWPFaOtqZQ/2ol3P/kv5d5p
        24CHzCuW4jBdcHnWpK1xo1cOHq9Khe8m49T+tAMijQnYAsqct393gaItk/jDVA==
From:   Finn Behrens <fin@nyantec.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH 2/6] kbuild: rust_is_available: print docs reference
Date:   Tue, 10 Jan 2023 11:16:33 +0100
Message-ID: <1E542F5E-220F-4061-BC71-F37C76616F34@nyantec.com>
In-Reply-To: <20230109204520.539080-2-ojeda@kernel.org>
References: <20230109204520.539080-1-ojeda@kernel.org>
 <20230109204520.539080-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4Nrmtq4LVhz9t7Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2023, at 21:45, Miguel Ojeda wrote:

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
As I always use my systems rustc/bindgen, I always get the warning, which=
 already clutters the build output a bit. But I see why it is helpful, so=
 not a fan, but this patch is reasonable.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Finn Behrens <fin@nyantec.com>

Regards,
Finn
> ---
> Note that is based on top of patch "kbuild: rust: remove -v
> option of scripts/rust_is_available.sh" applied on v6.2-rc3:
> https://lore.kernel.org/rust-for-linux/20230109061436.3146442-1-masahir=
oy@kernel.org/
>
>  scripts/rust_is_available.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.s=
h
> index eaeafebf8572..c907cf881c2c 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -21,6 +21,20 @@ get_canonical_version()
>  	echo $((100000 * $1 + 100 * $2 + $3))
>  }
>
> +# Print a reference to the setup guide in the documentation.
> +print_docs_reference()
> +{
> +	echo >&2 "***"
> +	echo >&2 "*** Please see Documentation/rust/quick-start.rst for detai=
ls"
> +	echo >&2 "*** on how to setup Rust support."
> +	echo >&2 "***"
> +}
> +
> +# If the script fails for any reason, or if there was any warning, the=
n
> +# print a reference to the documentation on exit.
> +warning=3D0
> +trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference=
; fi' EXIT
> +
>  # Check that the Rust compiler exists.
>  if ! command -v "$RUSTC" >/dev/null; then
>  	echo >&2 "***"
> @@ -62,6 +76,7 @@ if [ "$rust_compiler_cversion" -gt "$rust_compiler_mi=
n_cversion" ]; then
>  	echo >&2 "***   Your version:     $rust_compiler_version"
>  	echo >&2 "***   Expected version: $rust_compiler_min_version"
>  	echo >&2 "***"
> +	warning=3D1
>  fi
>
>  # Check that the Rust bindings generator is suitable.
> @@ -89,6 +104,7 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_=
bindings_generator_min_cvers
>  	echo >&2 "***   Your version:     $rust_bindings_generator_version"
>  	echo >&2 "***   Expected version: $rust_bindings_generator_min_versio=
n"
>  	echo >&2 "***"
> +	warning=3D1
>  fi
>
>  # Check that the `libclang` used by the Rust bindings generator is sui=
table.
> @@ -128,6 +144,7 @@ if [ "$cc_name" =3D Clang ]; then
>  		echo >&2 "***   libclang version: $bindgen_libclang_version"
>  		echo >&2 "***   Clang version:    $clang_version"
>  		echo >&2 "***"
> +		warning=3D1
>  	fi
>  fi
>
> -- =

> 2.39.0
