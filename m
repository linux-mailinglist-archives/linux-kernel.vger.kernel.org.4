Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD864201E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 23:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiLDWuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 17:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiLDWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 17:50:17 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971FCFAC4;
        Sun,  4 Dec 2022 14:50:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so15932867lfc.8;
        Sun, 04 Dec 2022 14:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60KRWbfLpgb9ykw8m3+leQoSYUWkACl+x4S1nlYbkmM=;
        b=p8DvGEoipdmOFLlZibH0ymdIRuNVTVsGM4sZoybpffizTogdsFzbMA7LQmilBP961P
         heValp+vHjVs6/lu47qD9koaPd3KK2Ku0BVlzzf8N7tr7Yg6rRGHasWpR+M6ot8EKOn+
         uLq+kCxFUNcQFWz19NiTBR5zmM4SWIwEQ7uRMsvZfr18FAPXC6BNdvWdvz9wH2dY5zmf
         WHlNg+OzzyLs82c2m2x7LZlJt3555Z0tCVTnbLkqKiOQFwIqUDVIEVoVdW0RmdG6msVh
         mGieZ4rCfn9aMClRi0mufTKAVBJLblauvAdDo+PgjT2+iwTJh0eexty62gN/JmxdaXaG
         r+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60KRWbfLpgb9ykw8m3+leQoSYUWkACl+x4S1nlYbkmM=;
        b=yRtRuGOgCs/b7C9NiHmFR/wMAkI8oKYLxRpLLhjj12LbuPgu0Zms4zPCSXMEtcYOkD
         Ij0d6WpGglZ9qTTk9URo3zacCn1WufZq6ivBckkw6ghF6LOc+TKANylq0cmPxxrsRp5f
         yW8P3sPq7W2L6ECjSvm5BnuOMHfY8o9wtR01s6DJrcuaBuu+EdG/f57DcYj4Nmb/kpw4
         SYQpveoonaDbYIdFTIdKB+wLOVvlF68GW+PxVmDUtxPX2uD9qdtrLLDJL78BflTcVPgr
         PS6KcWzrNfYFEPaKTuKMyQaO87LPyVGRWY4Lf3wxcYeFJAefVlga/o5Qa6nFXvSNve68
         oIxw==
X-Gm-Message-State: ANoB5pnYM9PqhZ8+ioCZ94hsWFSJ2k1wJHo8rOHSoB8cTqhwQcHv6kw2
        zUTUepofyhvNcJ6/Xd6yhTiZHPJRNm6nmrkv/OR9UDV+49TZ2w==
X-Google-Smtp-Source: AA0mqf572VcBiZfDwMAXsXUb+FnpjqJPk5nHRZPRqkD1kBIHbvd5Mt3lwCc/xbWp/s4EwtD5Obucp/iEhiV4bfNOoWQ=
X-Received: by 2002:a05:6512:4014:b0:4a2:3cf6:985e with SMTP id
 br20-20020a056512401400b004a23cf6985emr19782556lfb.29.1670194211285; Sun, 04
 Dec 2022 14:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20221204-compiler-builtin-v1-0-0730c7e573d5@garyguo.net>
In-Reply-To: <20221204-compiler-builtin-v1-0-0730c7e573d5@garyguo.net>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Sun, 4 Dec 2022 17:49:59 -0500
Message-ID: <CAFRnB2UO+H3kbkn9L61Mu-g2Z4K=rLJ3STwEKPNUG1R0VWzTmQ@mail.gmail.com>
Subject: Re: [PATCH] rust: make compiler-builtin stubs non-global
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you add a comment to compiler_builtins.rs reminding people that if
they add an additional intrinsic, they may also need to add it to
redirect-intrinsics in the Makefile?

Alex

On Sun, Dec 4, 2022 at 5:44 PM Gary Guo <gary@garyguo.net> wrote:
>
> Currently we define a number of stubs for compiler-builtin intrinsics
> that compiled libcore generates. The defined stubs are weak so they will
> not conflict with genuine implementation of these intrinsics, but their
> effect is global and will cause non-libcore code that accidently
> generate these intrinsics calls compile and bug on runtime.
>
> Instead of defining a stub that can affect all code, this patch uses
> objcopy's `--redefine-sym` flag to redirect these calls (from libcore
> only) to a prefixed version (e.g. redirect `__multi3` to `__rust_multi3`)=
,
> so we can define panciking stubs that are only visible to libcore.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
> This patch was previous discussed on GitHub.
>
> Link: https://github.com/Rust-for-Linux/linux/pull/779
>
> To: Miguel Ojeda <ojeda@kernel.org>
> To: Alex Gaynor <alex.gaynor@gmail.com>
> To: Wedson Almeida Filho <wedsonaf@gmail.com>
> To: Boqun Feng <boqun.feng@gmail.com>
> To: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: rust-for-linux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  rust/Makefile             | 14 ++++++++++++++
>  rust/compiler_builtins.rs |  2 +-
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index ff70c4c916f8..aed6f7eca36f 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -359,8 +359,22 @@ rust-analyzer:
>         $(Q)$(srctree)/scripts/generate_rust_analyzer.py $(srctree) $(obj=
tree) \
>                 $(RUST_LIB_SRC) > $(objtree)/rust-project.json
>
> +redirect-intrinsics =3D \
> +       __eqsf2 __gesf2 __lesf2 __nesf2 __unordsf2 \
> +       __unorddf2 \
> +       __muloti4 __multi3 \
> +       __udivmodti4 __udivti3 __umodti3
> +
> +ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
> +       # These intrinsics are defined for ARM64 and RISCV64
> +       redirect-intrinsics +=3D \
> +               __ashrti3 \
> +               __ashlti3 __lshrti3
> +endif
> +
>  $(obj)/core.o: private skip_clippy =3D 1
>  $(obj)/core.o: private skip_flags =3D -Dunreachable_pub
> +$(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intrin=
sics),--redefine-sym $(sym)=3D__rust$(sym))
>  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
>  $(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs $(obj)/target.json FORCE
>         $(call if_changed_dep,rustc_library)
> diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
> index f8f39a3e6855..1f05f93f2187 100644
> --- a/rust/compiler_builtins.rs
> +++ b/rust/compiler_builtins.rs
> @@ -28,7 +28,7 @@ macro_rules! define_panicking_intrinsics(
>      ($reason: tt, { $($ident: ident, )* }) =3D> {
>          $(
>              #[doc(hidden)]
> -            #[no_mangle]
> +            #[export_name =3D concat!("__rust", stringify!($ident))]
>              pub extern "C" fn $ident() {
>                  panic!($reason);
>              }
>
> ---
> base-commit: b9ecf9b9ac5969d7b7ea786ce5c76e24246df2c5
> change-id: 20221204-compiler-builtin-bb03aa6c4400
>
> Best regards,
> --
> Gary Guo <gary@garyguo.net>



--=20
All that is necessary for evil to succeed is for good people to do nothing.
