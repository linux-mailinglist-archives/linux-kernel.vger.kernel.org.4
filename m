Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB027203CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbjFBNwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjFBNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EC1BC;
        Fri,  2 Jun 2023 06:52:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BAC263A95;
        Fri,  2 Jun 2023 13:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E15CC4339E;
        Fri,  2 Jun 2023 13:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685713934;
        bh=l9HG5P8Qd6Wr+3LEYGkZIQIMQcfaIEmBnIRnSUKc62s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qMpxihOBFcD/U/TFoX9KUlVMY5WVHnctv9snGxSa5c3kNqaATlaF5OsSD18GdYidh
         kfB/9L8OEkdHKcCOsOtp+FL5oVLk2V+Hhk/z3Do9O7z2Pr60Q3lfNqnMZKDGV5bq3t
         kD/lJeW2KxV2+PL/62dFmijptDIn8DkGLFxbVSEAg4sfKy/Oeu0wSl6oW8PpZv2KMv
         KnkAQiBb+W5TmnfQTBluk2NTAnYLxaBLrUbasu7za7Vc9eXz+SUk4Jglf+aPi8jyK8
         /kr7aSru1TX7hj3dK5DhiYHUVFPN1q1Igv2K0xY3QrRdWEV4UuhnWVU8YGUU3SeBbh
         fS14dOrhQcIaA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-557ca32515eso1447374eaf.3;
        Fri, 02 Jun 2023 06:52:14 -0700 (PDT)
X-Gm-Message-State: AC+VfDwfnjQi2UyFMZSZTCcc/fEzQ74yyc/HGYmi02y7PNqxTZU3t9Vk
        +k0L96UualEyC0Q7tgIz8yfB8C6aYy6RxnXs2e0=
X-Google-Smtp-Source: ACHHUZ4XW1RTGMMcWueed48obinkZDyxW4RgCtMqLtJY0uApavZQW1+6jMgG025ituWzJBpmO7OGrstbidgCRSSUW9g=
X-Received: by 2002:a4a:52d1:0:b0:555:6518:7043 with SMTP id
 d200-20020a4a52d1000000b0055565187043mr7791498oob.3.1685713933831; Fri, 02
 Jun 2023 06:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-11-masahiroy@kernel.org> <CAKwvOdmZmtu4j11s3VKgcoK7riu=+QmXpcw1GuvG9vf-A=EWrQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmZmtu4j11s3VKgcoK7riu=+QmXpcw1GuvG9vf-A=EWrQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 2 Jun 2023 22:51:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRW0YXfgq5Tf_ZcHGUAoUgc8G7KPawdZOcCusnoYKj=g@mail.gmail.com>
Message-ID: <CAK7LNATRW0YXfgq5Tf_ZcHGUAoUgc8G7KPawdZOcCusnoYKj=g@mail.gmail.com>
Subject: Re: [PATCH v6 10/20] kbuild: generate KSYMTAB entries by modpost
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 2:51=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Commit 7b4537199a4a ("kbuild: link symbol CRCs at final link, removing
> > CONFIG_MODULE_REL_CRCS") made modpost output CRCs in the same way
> > whether the EXPORT_SYMBOL() is placed in *.c or *.S.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Patch LGTM, but two questions, below.
>
> > diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.=
c
> > index 9b62a9d352b3..0b3a82aedbfa 100644
> > --- a/arch/um/os-Linux/user_syms.c
> > +++ b/arch/um/os-Linux/user_syms.c
> > @@ -38,10 +38,15 @@ EXPORT_SYMBOL(vsyscall_end);
> >  #endif
> >
> >  /* Export symbols used by GCC for the stack protector. */
> > -extern void __stack_smash_handler(void *) __attribute__((weak));
> > +/*
> > + * REVISIT:
> > + *   ARCH=3Dum cannot enable CONFIG_STACKPROTECTOR because
> > + *   'select HAVE_STACKPROTECTOR' is missing. Is this already broken?
>
> ^ Is there something better we can do here?
>
> Maybe this code should be deleted first?

Yes, we can delete the lines first.


>
> > diff --git a/include/asm-generic/export.h b/include/asm-generic/export.=
h
> > index 5e4b1f2369d2..0ae9f38a904c 100644
> > --- a/include/asm-generic/export.h
> > +++ b/include/asm-generic/export.h
> > @@ -3,86 +3,12 @@
> >  #define __ASM_GENERIC_EXPORT_H
> >
> >  /*
> > - * This comment block is used by fixdep. Please do not remove.
>
> ^ Sounds ominous. What are the implications of removing this comment bloc=
k?

The same comment existed in <linux/export.h> and <asm-generic/export.h>
because they were independent from each other.


This commit changes <asm-generic/export.h> to a wrapper of <linux/export.h>=
.
So, the comment in <linux/export.h> triggers rebuilding when
CONFIG_MODVERSIONS is toggled.






--=20
Best Regards
Masahiro Yamada
