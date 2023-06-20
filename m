Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFE7362B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjFTEld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTEla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:41:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0001D10C8;
        Mon, 19 Jun 2023 21:41:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8811E60FB6;
        Tue, 20 Jun 2023 04:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDC0C433C9;
        Tue, 20 Jun 2023 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687236087;
        bh=/tNS/QGR44nW36zshBiU7IiaxE+ykcQcF4Z0lFSXucQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fhi4PMPDDVROsI6GO5TEwBwwIkMegERJHu37VzUaipq80PVe1amXKO3e3warDe5yV
         3rh7xLu+Y8XM3zAVaepeathtsIfDavAcGr2Noh+C3XTdaoEwyZzERrBEgBPHPKUB8V
         tmw3T2YsLKN/nLV+cqDcLiTFUb5SxYFhiXaiaM5qzBLcTbDqg+fj42Fv+IxQ9rx+YK
         kGrBzKpb8Vg+JTL46TNfldBk0fpsCy5p0G86aKdKHsuOY/fDUx6xM4gZkwQtr8d0Bl
         851yPqrqsw3pVmkoz+Lfj/9KmeEw1vfRUM96dc3pZ5PY6NqHtx+MZ4jDC5+TX4KM2i
         t0jUjyoIJPckg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-55e4b840858so1209618eaf.1;
        Mon, 19 Jun 2023 21:41:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDzqUzMM7FXTNAVBFZmJglLMGkoqjtBjnz8u+PTOcOaIlY+m4Sjp
        JVQKuSTCA0R8pMqnUVDoqLaYX7PWa4/TOwnj9o8=
X-Google-Smtp-Source: ACHHUZ4rhVjsVwtS8VJ2pgphBj1N7Hrk6R8ryMDWtFyaVPm2XkqPwXT+sLBvZ7vqc6fXhEfeqob/iRQyPzJfD2JPpc4=
X-Received: by 2002:a05:6808:1524:b0:39e:c806:5889 with SMTP id
 u36-20020a056808152400b0039ec8065889mr8808160oiw.28.1687236087177; Mon, 19
 Jun 2023 21:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org> <20230616001631.463536-6-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-6-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 13:40:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQc0oSA5wtb3J2PYXPy2WsL1ZDBE6vip1qXhDOS+-QjMA@mail.gmail.com>
Message-ID: <CAK7LNAQc0oSA5wtb3J2PYXPy2WsL1ZDBE6vip1qXhDOS+-QjMA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] kbuild: rust_is_available: add check for
 `bindgen` invocation
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>,
        Alexandru Radovici <msg4alex@gmail.com>,
        Matthew Leach <dev@mattleach.net>
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
> `scripts/rust_is_available.sh` calls `bindgen` with a special
> header in order to check whether the `libclang` version in use
> is suitable.
>
> However, the invocation itself may fail if, for instance, `bindgen`
> cannot locate `libclang`. This is fine for Kconfig (since the
> script will still fail and therefore disable Rust as it should),
> but it is pretty confusing for users of the `rustavailable` target
> given the error will be unrelated:
>
>     ./scripts/rust_is_available.sh: 21: arithmetic expression: expecting =
primary: "100000 *  + 100 *  + "
>     make: *** [Makefile:1816: rustavailable] Error 2
>
> Instead, run the `bindgen` invocation independently in a previous
> step, saving its output and return code. If it fails, then show
> the user a proper error message. Otherwise, continue as usual
> with the saved output.
>
> Since the previous patch we show a reference to the docs, and
> the docs now explain how `bindgen` looks for `libclang`,
> thus the error message can leverage the documentation, avoiding
> duplication here (and making users aware of the setup guide in
> the documentation).
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi=
6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
> Reported-by: Fran=C3=A7ois Valenduc <francoisvalenduc@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/934
> Reported-by: Alexandru Radovici <msg4alex@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/pull/921
> Reported-by: Matthew Leach <dev@mattleach.net>
> Closes: https://lore.kernel.org/rust-for-linux/20230507084116.1099067-1-d=
ev@mattleach.net/
> Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




>  scripts/rust_is_available.sh | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 6b8131d5b547..1bdff4472cbe 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -106,8 +106,28 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_=
bindings_generator_min_cvers
>  fi
>
>  # Check that the `libclang` used by the Rust bindings generator is suita=
ble.
> +#
> +# In order to do that, first invoke `bindgen` to get the `libclang` vers=
ion
> +# found by `bindgen`. This step may already fail if, for instance, `libc=
lang`
> +# is not found, thus inform the user in such a case.
> +bindgen_libclang_output=3D$( \
> +       LC_ALL=3DC "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_lib=
clang.h 2>&1 >/dev/null


Nit.

To avoid shellcheck warnings, you can quote as follows:

"$(dirname "$0")/rust_is_available_bindgen_libclang.h"


You can do shellcheck scanning to avoid new warnings.

(Of course, 02/11 intentionally unquote $CC, though)



> +) || bindgen_libclang_code=3D$?
> +if [ -n "$bindgen_libclang_code" ]; then
> +       echo >&2 "***"
> +       echo >&2 "*** Running '$BINDGEN' to check the libclang version (u=
sed by the Rust"
> +       echo >&2 "*** bindings generator) failed with code $bindgen_libcl=
ang_code. This may be caused by"
> +       echo >&2 "*** a failure to locate libclang. See output and docs b=
elow for details:"
> +       echo >&2 "***"
> +       echo >&2 "$bindgen_libclang_output"
> +       echo >&2 "***"
> +       exit 1
> +fi
> +
> +# `bindgen` returned successfully, thus use the output to check that the=
 version
> +# of the `libclang` found by the Rust bindings generator is suitable.
>  bindgen_libclang_version=3D$( \
> -       LC_ALL=3DC "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_lib=
clang.h 2>&1 >/dev/null \
> +       echo "$bindgen_libclang_output" \
>                 | grep -F 'clang version ' \
>                 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
>                 | head -n 1 \
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
