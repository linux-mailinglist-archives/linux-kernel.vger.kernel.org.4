Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A84A692A66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBJWoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjBJWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:44:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B37E3F2;
        Fri, 10 Feb 2023 14:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BE70B8260D;
        Fri, 10 Feb 2023 22:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E3C433D2;
        Fri, 10 Feb 2023 22:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676069037;
        bh=zfoCu+DLwH+qReMvNt6SYCZVd2e58+w8lcZugKYW3vA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=jGC2Y4FicguQMW9kNnLKEmyoEm8SQgmheil3MkViwcKzTKkoSnTXCJETQRHpVaSDx
         NYq1tPVHLqbAvWULRYaK/D7efAN+NuIpuYX+hyTdGmFQWJw7OqQMrvVPMuCoU5GnkQ
         QMufl4J1e0NRv+lnZGPbtyYV5p6YGWDDxBMK99Rj+xX+lgo5TVlocSKUnEJ61afSug
         I+gSzEFkgzrsKovEEC9CBOySnQ4tR7YGCPhJMXoaqPLUianixmM4cCLs2KAqB/0z2R
         WHhXrKanYyXp9M6DUqZualcvgXLLXJxDWQVtimx+A19nFnRWiZWwaz700qDNqa1j38
         yi8ss94Iw7zKQ==
Date:   Fri, 10 Feb 2023 14:43:56 -0800
From:   Kees Cook <kees@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
CC:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
User-Agent: K-9 Mail for Android
In-Reply-To: <20230210215141.108958-1-andrea.righi@canonical.com>
References: <20230210215141.108958-1-andrea.righi@canonical.com>
Message-ID: <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On February 10, 2023 1:51:41 PM PST, Andrea Righi <andrea=2Erighi@canonical=
=2Ecom> wrote:
>With CONFIG_INIT_STACK_ALL_ZERO enabled, bindgen passes
>-ftrivial-auto-var-init=3Dzero to clang, that triggers the following
>error:
>
> error: '-ftrivial-auto-var-init=3Dzero' hasn't been enabled; enable it a=
t your own peril for benchmarking purpose only with '-enable-trivial-auto-v=
ar-init-zero-knowing-it-will-be-removed-from-clang'
>
>However, this additional option that is currently required by clang is
>going to be removed in the future (as the name of the option suggests),
>likely with clang-17=2E
>
>So, make sure bindgen is using this extra option if the major version of
>the libclang used by bindgen is < 17=2E
>
>In this way we can enable CONFIG_INIT_STACK_ALL_ZERO with CONFIG_RUST
>without triggering any build error=2E
>
>Link: https://github=2Ecom/llvm/llvm-project/issues/44842
>Signed-off-by: Andrea Righi <andrea=2Erighi@canonical=2Ecom>
>---
>
>Changes in v2:
> - check the version of libclang used by bindgen to determine if we need
>   to pass the additional clang option
>
> rust/Makefile | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/rust/Makefile b/rust/Makefile
>index ff70c4c916f8=2E=2Ec77d7ce96a85 100644
>--- a/rust/Makefile
>+++ b/rust/Makefile
>@@ -269,6 +269,19 @@ BINDGEN_TARGET		:=3D $(BINDGEN_TARGET_$(SRCARCH))
> # some configurations, with new GCC versions, etc=2E
> bindgen_extra_c_flags =3D -w --target=3D$(BINDGEN_TARGET)
>=20
>+# Auto variable zero-initialization requires an additional special optio=
n with
>+# clang that is going to be removed sometimes in the future (likely in
>+# clang-17), so make sure to pass this option only if clang supports it
>+# (libclang major version < 17)=2E
>+#
>+# https://github=2Ecom/llvm/llvm-project/issues/44842
>+ifdef CONFIG_INIT_STACK_ALL_ZERO
>+libclang_maj_ver=3D$(shell $(BINDGEN) $(srctree)/scripts/rust_is_availab=
le_bindgen_libclang=2Eh 2>&1 | sed -ne 's/=2E*clang version \([0-9]*\)=2E*/=
\1/p')
>+ifeq ($(shell expr $(libclang_maj_ver) \< 17), 1)
>+bindgen_extra_c_flags +=3D -enable-trivial-auto-var-init-zero-knowing-it=
-will-be-removed-from-clang
>+endif
>+endif

This logic already exists in the top-level Makefile=2E How does -ftrivial-=
auto-var-init=3Dzero make it into bindgen_c_flags normally? (I=2Ee=2E why d=
oes the legacy -enable=2E=2E=2E option not?)

>+
> bindgen_c_flags =3D $(filter-out $(bindgen_skip_c_flags), $(c_flags)) \
> 	$(bindgen_extra_c_flags)
> endif


--=20
Kees Cook
