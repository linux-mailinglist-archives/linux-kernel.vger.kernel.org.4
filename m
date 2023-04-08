Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF16DBA11
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDHK0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDHK0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD430B452
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680949499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+B9to8j2Lzj7TcvjD6Ev0dSy316NI/IHJxCACF6SvY=;
        b=fu/Ej+v+WRhPR9Yc92tRKm96J5z19InT4pqW0pIVds5Vxh00Gm4zT+VISpa2ra7ybO2XY+
        Erz4LzapiwbM1t6ZL5Cuoqncre7Qik7453keWbe+QaA2ptfGXBhn1Nh+RsLQGLD8Qe74aS
        5rQMSBo4nZlrhD/1STWZSEZHGP0UOSg=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-HN334CBEN728pp76CDUKIg-1; Sat, 08 Apr 2023 06:24:58 -0400
X-MC-Unique: HN334CBEN728pp76CDUKIg-1
Received: by mail-ua1-f72.google.com with SMTP id l4-20020ab053c4000000b0076cb64e1ed6so4433257uaa.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 03:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680949497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+B9to8j2Lzj7TcvjD6Ev0dSy316NI/IHJxCACF6SvY=;
        b=gzs0sVvBLIwPc/57cg7/DXYYcZ6X1i53EaGOg4GRf4BOngCU3uKfMt3Uf5bPLB9BrF
         vs2X7aFK4hpGK96gLoGkom34wLamOfCwOE0HsjXALPmqeUQkkymJbTsu7+EXzaTSg/+E
         cnzxs0cAsxLRpFFZi/dxWeJ/51VMK2L4DHNjMFCW22Rocod4OphiwQvXhJkgkZTJLMYJ
         hdA7sO/qW+tje5BgmQKHnE1QQTxsMqHUbFhZpL7ufEQ/Wwc65QtouECZdtwAVKaEsAFP
         /ScIccDd8TbIdmEAT3KVfQvO85JIW2On9f72bAgWPGh/tlY5F7xL9o7m1cmwPSJHYyDR
         uenA==
X-Gm-Message-State: AAQBX9fCExItmJokcAFnwnX68ASKiNWy8oi3usmb0xlGwC5w5O30WX4X
        Zwrx5ud0ziTKYMd1rcJC5bnyJPSJyovhod+hV/90t1tmEP50lVoNEDRaIZOmWaoXHwQWLqOJMLV
        oqvL982OT6uLENnMtFP23EzZMgtCuKyw0dji3bro3
X-Received: by 2002:a1f:2a4b:0:b0:43c:2acb:9a60 with SMTP id q72-20020a1f2a4b000000b0043c2acb9a60mr2566282vkq.3.1680949497398;
        Sat, 08 Apr 2023 03:24:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350bcRbIrqbYLXQvhgU1yB25jrUYi60umTA4Aj4dtEtmHkg2stdHgIeAeLt4yqtCa6AkG6OTgIuIzrtdJ+KnT83g=
X-Received: by 2002:a1f:2a4b:0:b0:43c:2acb:9a60 with SMTP id
 q72-20020a1f2a4b000000b0043c2acb9a60mr2566263vkq.3.1680949497089; Sat, 08 Apr
 2023 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230407070517.204676-1-andrea.righi@canonical.com>
In-Reply-To: <20230407070517.204676-1-andrea.righi@canonical.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Sat, 8 Apr 2023 11:24:41 +0100
Message-ID: <CAOgh=FxE_Y3Chr3wCG5QkoPZW5-BjrVCM9moEZGy=xMkv2fKOA@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 at 08:05, Andrea Righi <andrea.righi@canonical.com> wrote:
>
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

Ran this in an Asahi Fedora build to be sure.

Tested-by: Eric Curtin <ecurtin@redhat.com>
Reviewed-by: Eric Curtin <ecurtin@redhat.com>

Is mise le meas/Regards,

Eric Curtin

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
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 4703f652c009..e6f8fa3c9b8d 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -41,8 +41,6 @@ quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko =                                                     \
>         if [ ! -f vmlinux ]; then                                       \
>                 printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> -       elif [ -n "$(CONFIG_RUST)" ] && $(srctree)/scripts/is_rust_module.sh $@; then           \
> -               printf "Skipping BTF generation for %s because it's a Rust module\n" $@ 1>&2; \
>         else                                                            \
>                 LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
>                 $(RESOLVE_BTFIDS) -b vmlinux $@;                        \
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

