Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C47362EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFTFAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjFTE74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C43E2;
        Mon, 19 Jun 2023 21:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 383BF60FA4;
        Tue, 20 Jun 2023 04:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE2FC433C8;
        Tue, 20 Jun 2023 04:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687237194;
        bh=uVrcvEWzbHKx2kIdsdGpoiYhBsvKk5Y5rcbq20JBwzw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f7cY/uQ4i4aoojP8StpCzjj/pVEBw10ErcqKL7gsmtNyWKEc7QUclWS2SFWpGqKNI
         LZXAoZRx0mOGM23/pc5Iq0fbBS2B9f5IfUdUavtyih+p3hZ+V84VnBOu6f48bvJ8Hy
         /Hfsy39OeNTJ2v8rQkWbGvCaH5qzQj8Bt9j50Cqr7KLIokz+Jq4BkMABKP5kiNm3n/
         4X9oEsVPHAELlEZTfEhrPwmGwq2U2BIlXVtgA361N3hNYCAsctcgRwGWFdT4LAh3Gx
         oCHE+UqUXEfuhpGPs/ztd4HnHNGXRZlPnT6d41JFNUgcgthmm9/+nXx1DmNyEt66U6
         6ezXqy7T6V/zA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5607a03eff7so850408eaf.0;
        Mon, 19 Jun 2023 21:59:54 -0700 (PDT)
X-Gm-Message-State: AC+VfDz4+DYLf9eDNchJ4H6RuBmTojZ52bfVQCE/GRvYubWIOZqS3vsx
        Oy//HIlvp+3ZKJHiCQdm+nD6i5eryPogzcKxsbw=
X-Google-Smtp-Source: ACHHUZ7WJQN6LmDaWYeNXV+vap/lm6Wm0tVxAs3sutK/kP5IIUMvoNjUYnzoIf8rjMdQ7zl9/kmYsloZI7dvRKToQ6E=
X-Received: by 2002:a05:6808:16a6:b0:39e:c615:949f with SMTP id
 bb38-20020a05680816a600b0039ec615949fmr8837818oib.24.1687237193895; Mon, 19
 Jun 2023 21:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org> <20230616001631.463536-7-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-7-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 13:59:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzJpDuAE+0TbAOW4D1fH3ghVGFy3-a=AjqJRT-+bwD=A@mail.gmail.com>
Message-ID: <CAK7LNASzJpDuAE+0TbAOW4D1fH3ghVGFy3-a=AjqJRT-+bwD=A@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] kbuild: rust_is_available: check that
 environment variables are set
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 9:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Sometimes [1] users may attempt to setup the Rust support by
> checking what Kbuild does and they end up finding out about
> `scripts/rust_is_available.sh`. Inevitably, they run the script
> directly, but unless they setup the required variables,
> the result of the script is not meaningful.
>
> We could add some defaults to the variables, but that could be
> confusing for those that may override the defaults (compared
> to their kernel builds), and `$CC` would not be a simple default
> in any case.
>
> Therefore, instead, explicitly check whether the expected variables
> are set (`$RUSTC`, `$BINDGEN` and `$CC`). If not, print an explanation
> about the fact that the script is meant to be called from Kbuild,
> since that is the most likely cause for the variables not being set.
>
> Link: https://lore.kernel.org/oe-kbuild-all/Y6r4mXz5NS0+HVXo@zn.tnic/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/rust_is_available.sh | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 1bdff4472cbe..7e0368babe64 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -28,11 +28,40 @@ print_docs_reference()
>         echo >&2 "***"
>  }
>
> +# Print an explanation about the fact that the script is meant to be cal=
led from Kbuild.
> +print_kbuild_explanation()
> +{
> +       echo >&2 "***"
> +       echo >&2 "*** This script is intended to be called from Kbuild."
> +       echo >&2 "*** Please use the 'rustavailable' target to call it in=
stead."
> +       echo >&2 "*** Otherwise, the results may not be meaningful."
> +       exit 1
> +}
> +
>  # If the script fails for any reason, or if there was any warning, then
>  # print a reference to the documentation on exit.
>  warning=3D0
>  trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; =
fi' EXIT
>
> +# Check that the expected environment variables are set.
> +if [ -z "${RUSTC+x}" ]; then
> +       echo >&2 "***"
> +       echo >&2 "*** Environment variable 'RUSTC' is not set."
> +       print_kbuild_explanation
> +fi


So, you want to check whether RUSTC is set or unset.
(that is, you allow a case where RUSTC is set, but empty.
It will eventually fail with a different error message anyway.)




$ ./scripts/rust_is_available.sh
***
*** Environment variable 'RUSTC' is not set.
***
*** This script is intended to be called from Kbuild.
*** Please use the 'rustavailable' target to call it instead.
*** Otherwise, the results may not be meaningful.
***
*** Please see Documentation/rust/quick-start.rst for details
*** on how to set up the Rust support.
***

$ RUSTC=3D BINDGEN=3D CC=3D ./scripts/rust_is_available.sh
***
*** Rust compiler '' could not be found.
***
***
*** Please see Documentation/rust/quick-start.rst for details
*** on how to set up the Rust support.
***



I would rather check whether RUSTC is empty or not
with simpler code.


if [ -z "${RUSTC}" ]; then
         ...
fi





> +
> +if [ -z "${BINDGEN+x}" ]; then
> +       echo >&2 "***"
> +       echo >&2 "*** Environment variable 'BINDGEN' is not set."
> +       print_kbuild_explanation
> +fi
> +
> +if [ -z "${CC+x}" ]; then
> +       echo >&2 "***"
> +       echo >&2 "*** Environment variable 'CC' is not set."
> +       print_kbuild_explanation
> +fi
> +
>  # Check that the Rust compiler exists.
>  if ! command -v "$RUSTC" >/dev/null; then
>         echo >&2 "***"
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
