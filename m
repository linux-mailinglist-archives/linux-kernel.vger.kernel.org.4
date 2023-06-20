Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C64736311
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjFTFQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTFQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:16:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD08110D7;
        Mon, 19 Jun 2023 22:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7121960FBB;
        Tue, 20 Jun 2023 05:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC1EC433C0;
        Tue, 20 Jun 2023 05:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687238201;
        bh=hzpaa3iGkGe9xtkcsnYk+Um0tqxkVjDTyjZm8EOU0Os=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OQx/8INO9GEPdUH3BI8erf6zQ9q4FihvaiEzWpSyC6i//qpAbEAYcW5jze8qcuSIo
         cReVt2JMp8KbSAlKMT7vzYzat8HB61aqay4Ei4Ft4o++q9oIyaIEt0mCeGC1LlmXCL
         g9AqkfPJdpGqYQcUJEPMJD8RTn6py4/BOr6bwPSh0YF28we0KZWAODkuEmQSNjMUhS
         VohJkux7BF2mEpBj8yK71BVkGdZ1vbObE2jy/pI51DNkUMJpkaAl+UOsfG7teYJJuh
         OlYa3/aIPSNurQ3eurJezaMmkkeofnLbxhnpiuo4wtNx/LFpm3WEweIQ+/6RyQn9kf
         Hudmn8djwc6Sg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5607a462bb7so849930eaf.3;
        Mon, 19 Jun 2023 22:16:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDzmKuQanDWECRyfrF8JcAi/pA/qu87u9mNfE2ceWMsPn6za0ckc
        SGrU6rc+9yPvnAy6q+5jm7jiqvkPHRCcAOkntb4=
X-Google-Smtp-Source: ACHHUZ5UPUAVUe7wK3MR/2HPSQYplZtvZ60obrm6pHMoETfd92DeaSbpzYdzMWQq9rjcCHB8xH4OWgnaU9Y2B/o5NoM=
X-Received: by 2002:a4a:ba1a:0:b0:560:8d95:55f4 with SMTP id
 b26-20020a4aba1a000000b005608d9555f4mr790814oop.4.1687238201141; Mon, 19 Jun
 2023 22:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230616001631.463536-1-ojeda@kernel.org> <20230616001631.463536-9-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-9-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 20 Jun 2023 14:16:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASOsLzYMOU90JXSfEjsMaxCq8pOOsVzDfq2nSS_B8K9qQ@mail.gmail.com>
Message-ID: <CAK7LNASOsLzYMOU90JXSfEjsMaxCq8pOOsVzDfq2nSS_B8K9qQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] kbuild: rust_is_available: normalize version matching
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



Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




> ---
>  scripts/rust_is_available.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 810691af66eb..b7e0781fdea9 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -83,8 +83,7 @@ fi
>  # Non-stable and distributions' versions may have a version suffix, e.g.=
 `-dev`.
>  rust_compiler_version=3D$( \
>         LC_ALL=3DC "$RUSTC" --version 2>/dev/null \
> -               | head -n 1 \
> -               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> +               | sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_compiler_min_version=3D$($min_tool_version rustc)
>  rust_compiler_cversion=3D$(get_canonical_version $rust_compiler_version)
> @@ -111,8 +110,7 @@ fi
>  # Non-stable and distributions' versions may have a version suffix, e.g.=
 `-dev`.
>  rust_bindings_generator_version=3D$( \
>         LC_ALL=3DC "$BINDGEN" --version 2>/dev/null \
> -               | head -n 1 \
> -               | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
> +               | sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
>  )
>  rust_bindings_generator_min_version=3D$($min_tool_version bindgen)
>  rust_bindings_generator_cversion=3D$(get_canonical_version $rust_binding=
s_generator_version)
> @@ -155,6 +153,9 @@ fi
>
>  # `bindgen` returned successfully, thus use the output to check that the=
 version
>  # of the `libclang` found by the Rust bindings generator is suitable.
> +#
> +# Unlike other version checks, note that this one does not necessarily a=
ppear
> +# in the first line of the output, thus no `sed` address is provided.
>  bindgen_libclang_version=3D$( \
>         echo "$bindgen_libclang_output" \
>                 | sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\=
1:p'
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
