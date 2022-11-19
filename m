Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11683630C5F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiKSGKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiKSGKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:10:41 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F693CF7;
        Fri, 18 Nov 2022 22:10:38 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2AJ6AFtX020437;
        Sat, 19 Nov 2022 15:10:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2AJ6AFtX020437
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668838216;
        bh=hw+7QfHms6qg0bK0VXx5PywoCJxCHZ+mTJrxNjSJVz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vNab5eOVQ5LmrgNQqePwKMQ0jUfu8K/ULgd0oPIRIRNYnm7JvcKY/lT4uKWd8apGR
         anL3uC0NaYSU2eDsOLRXBdViLYI89WXkYZlV+TX6id4CwQcLEn/PTeOwM7RQ/jSwxg
         bD9WWzh6bRYHN8gETcKvq/tQLGMxqnarvaP6+SWiKhUKreTHkrBbD/4PtMj6uZF4BA
         t5yCh/FPZmjb5hfGlvR5sf7Qqw4B8YuEUxcME6d5D6tvfvwStFQFImEHUE8IWHBr/S
         6H7WYv9+vzG8IK9ubYghO/Cpkhk/DAkg2b0xNLwdACu0Y5UFGhiQks8AR3xffdFQav
         d1RmsGa/+qkeg==
X-Nifty-SrcIP: [209.85.167.172]
Received: by mail-oi1-f172.google.com with SMTP id q83so7593256oib.10;
        Fri, 18 Nov 2022 22:10:16 -0800 (PST)
X-Gm-Message-State: ANoB5plLRKr10caOt2Go4XvkciM0N+hF+gFJePIlgZp5WLYcqWxkz8qo
        SXFDCgrM9+VGzjyoKc4zkZS32uvxwP0FqQfOjwY=
X-Google-Smtp-Source: AA0mqf7Gxcw/Ku+ARk9QSSHzr/mwjFvUoDEN0nKTpykLNiAvoZ2wQ3JfjlemkGVxhg24LpSIw2n9iVjgMEji+B8QikA=
X-Received: by 2002:aca:1c06:0:b0:354:28ae:23b3 with SMTP id
 c6-20020aca1c06000000b0035428ae23b3mr4994580oic.287.1668838215020; Fri, 18
 Nov 2022 22:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20221118191551.66448-1-masahiroy@kernel.org> <20221118191551.66448-2-masahiroy@kernel.org>
 <20221118212839.148107-1-alobakin@pm.me>
In-Reply-To: <20221118212839.148107-1-alobakin@pm.me>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 19 Nov 2022 15:09:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROPTVO6B2+4pQ-hkx3=3annhtVL7ebaOjE_YX3Cf3p1w@mail.gmail.com>
Message-ID: <CAK7LNAROPTVO6B2+4pQ-hkx3=3annhtVL7ebaOjE_YX3Cf3p1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kbuild: warn objects shared among multiple modules
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 6:36 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Masahiro Yamada <masahiroy@kernel.org>
> Date: Sat, 19 Nov 2022 04:15:51 +0900
>
> > If an object is shared among multiple modules, amd some of them are
> > configured as 'm', but the others as 'y', the shared object is built
> > as modular, then linked to the modules and vmlinux. This is a potential
> > issue because the expected CFLAGS are different between modules and
> > builtins.
> >
> > Commit 637a642f5ca5 ("zstd: Fixing mixed module-builtin objects")
> > reported that this could be even more fatal in some cases such as
> > Clang LTO.
> >
> > That commit fixed lib/zlib/zstd_{compress,decompress}, but there are
> > still more instances of breakage.
> >
> > This commit adds a W=1 warning for shared objects, so that the kbuild
> > test robot, which provides build tests with W=1, will avoid a new
> > breakage slipping in.
> >
> > Quick compile tests on v6.1-rc4 detected the following:
>
> For the series:
>
> Reviewed-and-tested-by: Alexander Lobakin <alobakin@pm.me>
>
> [...]
>
> > Once all the warnings are fixed, it can become an error irrespective of
> > W= option.
>
> BTW I've fixed most of these (the ones that get build on typical
> x86_64 distroconfig) during my local tests, basing off your WIP
> tree. I could send a series if you wish.


Yes, thanks for the help.




>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Add drivers/block/rnbd/Makefile for commit log
> >
> >  scripts/Makefile.build | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 37cf88d076e8..799df12b53f3 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -222,6 +222,10 @@ endif
> >
> >  cmd_check_local_export = $(srctree)/scripts/check-local-export $@
> >
> > +ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
> > +cmd_warn_shared_object = $(if $(word 2, $(modname-multi)),$(warning $(kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
> > +endif
> > +
> >  define rule_cc_o_c
> >       $(call cmd_and_fixdep,cc_o_c)
> >       $(call cmd,gen_ksymdeps)
> > @@ -231,6 +235,7 @@ define rule_cc_o_c
> >       $(call cmd,gen_objtooldep)
> >       $(call cmd,gen_symversions_c)
> >       $(call cmd,record_mcount)
> > +     $(call cmd,warn_shared_object)
> >  endef
> >
> >  define rule_as_o_S
> > @@ -239,6 +244,7 @@ define rule_as_o_S
> >       $(call cmd,check_local_export)
> >       $(call cmd,gen_objtooldep)
> >       $(call cmd,gen_symversions_S)
> > +     $(call cmd,warn_shared_object)
> >  endef
> >
> >  # Built-in and composite module parts
> > --
> > 2.34.1
>
> Thanks,
> Olek
>


-- 
Best Regards
Masahiro Yamada
