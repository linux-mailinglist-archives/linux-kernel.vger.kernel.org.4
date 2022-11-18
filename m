Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7E662FF68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKRVgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKRVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:36:03 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123AA3177
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:36:02 -0800 (PST)
Date:   Fri, 18 Nov 2022 21:35:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1668807358; x=1669066558;
        bh=pJNx7ZnlloAIzR3yB2yGQaGebDKuZEQyHZ8pRqv1kDw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=b2qCuWmRkoB5W1UQ7IPpk0U3I8c7VvCJ4D2+UxqyUEh54ahOLCplBQBnfwy1uuomy
         M5SUQd+oGXYcK8HS+xnBWhVA7jmfn2jKQMKDYAVS1K1+d2OdUpupNtE4lekIi6Za90
         QKJMgdsXN9rm9RUv53BLYEYXCPrZQR2U6Cbbg0BrMNLQZmQ7EO/gawObydr6aQRAJc
         0Q0YQmjRW79WnuvHmdwZB4maiP87VZhLtrznC4P0pBCBapiJ7ccXtnpAzvxprZ82A7
         Th0yfqSCAu3IZP+WlRrvnLLtB91rsTgPXcIV1t8Kp4jZOExxzHjEvVfqsE1k57oaQk
         5P6F9J+9v52RA==
To:     Masahiro Yamada <masahiroy@kernel.org>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] kbuild: warn objects shared among multiple modules
Message-ID: <20221118212839.148107-1-alobakin@pm.me>
In-Reply-To: <20221118191551.66448-2-masahiroy@kernel.org>
References: <20221118191551.66448-1-masahiroy@kernel.org> <20221118191551.66448-2-masahiroy@kernel.org>
Feedback-ID: 22809121:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 19 Nov 2022 04:15:51 +0900

> If an object is shared among multiple modules, amd some of them are
> configured as 'm', but the others as 'y', the shared object is built
> as modular, then linked to the modules and vmlinux. This is a potential
> issue because the expected CFLAGS are different between modules and
> builtins.
>
> Commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")
> reported that this could be even more fatal in some cases such as
> Clang LTO.
>
> That commit fixed lib/zlib/zstd_{compress,decompress}, but there are
> still more instances of breakage.
>
> This commit adds a W=3D1 warning for shared objects, so that the kbuild
> test robot, which provides build tests with W=3D1, will avoid a new
> breakage slipping in.
>
> Quick compile tests on v6.1-rc4 detected the following:

For the series:

Reviewed-and-tested-by: Alexander Lobakin <alobakin@pm.me>

[...]

> Once all the warnings are fixed, it can become an error irrespective of
> W=3D option.

BTW I've fixed most of these (the ones that get build on typical
x86_64 distroconfig) during my local tests, basing off your WIP
tree. I could send a series if you wish.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Add drivers/block/rnbd/Makefile for commit log
>
>  scripts/Makefile.build | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 37cf88d076e8..799df12b53f3 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -222,6 +222,10 @@ endif
>
>  cmd_check_local_export =3D $(srctree)/scripts/check-local-export $@
>
> +ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
> +cmd_warn_shared_object =3D $(if $(word 2, $(modname-multi)),$(warning $(=
kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
> +endif
> +
>  define rule_cc_o_c
>  =09$(call cmd_and_fixdep,cc_o_c)
>  =09$(call cmd,gen_ksymdeps)
> @@ -231,6 +235,7 @@ define rule_cc_o_c
>  =09$(call cmd,gen_objtooldep)
>  =09$(call cmd,gen_symversions_c)
>  =09$(call cmd,record_mcount)
> +=09$(call cmd,warn_shared_object)
>  endef
>
>  define rule_as_o_S
> @@ -239,6 +244,7 @@ define rule_as_o_S
>  =09$(call cmd,check_local_export)
>  =09$(call cmd,gen_objtooldep)
>  =09$(call cmd,gen_symversions_S)
> +=09$(call cmd,warn_shared_object)
>  endef
>
>  # Built-in and composite module parts
> --
> 2.34.1

Thanks,
Olek

