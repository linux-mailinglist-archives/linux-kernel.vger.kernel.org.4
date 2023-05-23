Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D570D49C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjEWHN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjEWHNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:13:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D48211F;
        Tue, 23 May 2023 00:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7785062FDA;
        Tue, 23 May 2023 07:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36F3C4339C;
        Tue, 23 May 2023 07:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684826000;
        bh=f5z4FLxDPgETOy7aL9gv81CZdcHctDIyTnnjcI7c4f0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hUsQn6aLonY9QrGoN/zY5Fy2gZNRNBSW17CCHjQJRjGNfe1+UtWCrahIqFnZNwuDt
         P1XHTx3D6qacQEP3cu7oPLlUoeTBYY3PVpdmeUER2QxvELZnHYkWE1lU7pcU4EUFIA
         2PHDwNEHGL+nP3lfvl5ltufWbZUawa3YAlogmd+e5+/2BUUD/sfnJ11IlyiVduINSj
         tC8TR1VplD9R73elsuEmug4gjeusw4oP48jMH3pcZib8nsUKhAF7CAfIrny5Ylbsgv
         nxb50lKNX6nCy4D3xxaRgE5IIeanrg8ss/1E/6F2ic6zSxEt2YkmryMjx1jAlGhJIE
         eb8AJtbFuM9iQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so3266667e87.0;
        Tue, 23 May 2023 00:13:20 -0700 (PDT)
X-Gm-Message-State: AC+VfDyKOlrH/9A4QgWUIUIWDdKlKx/3t7+qSfkP37xcol1p86pVT2hH
        k/OHH6gmfon1LrXNw0jBgI0X/qn6j8+TREvtSBU=
X-Google-Smtp-Source: ACHHUZ5PGTufHZh9JgDs5/lwQ2p3AfnnpUDv5F0tTXSLMY6xHuamj5wVGctCTZj6/XjlSNmvF/8oO1zHS2w418fpJQo=
X-Received: by 2002:a2e:9097:0:b0:2a8:d1cd:a04 with SMTP id
 l23-20020a2e9097000000b002a8d1cd0a04mr4353123ljg.48.1684825998766; Tue, 23
 May 2023 00:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-3-masahiroy@kernel.org> <CAKwvOd=B+dKWjxD-K-8btROvywp_Nei=CREeYZdCvKSGuHHJOA@mail.gmail.com>
 <CAMj1kXEYZdsE8A2izGbb4HWYT3a8HN9Ocw=pb3d64Zu0441RgA@mail.gmail.com> <CAK7LNASFLnB9svCf6QvVPSMyXhHRzv9teAmZqXkTw629=_xo=A@mail.gmail.com>
In-Reply-To: <CAK7LNASFLnB9svCf6QvVPSMyXhHRzv9teAmZqXkTw629=_xo=A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 May 2023 09:13:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGuJwDBQakz8aV5TR0Y=KPDMjNcJ0wf=YLrsxB=m35_Kg@mail.gmail.com>
Message-ID: <CAMj1kXGuJwDBQakz8aV5TR0Y=KPDMjNcJ0wf=YLrsxB=m35_Kg@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] modpost: fix section mismatch message for R_ARM_ABS32
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 07:08, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, May 23, 2023 at 6:36=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > On Mon, 22 May 2023 at 19:56, Nick Desaulniers <ndesaulniers@google.com=
> wrote:
> > >
> > > + linux-arm-kernel and some folks who might know another idea.
> > >
> > > On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > addend_arm_rel() processes R_ARM_ABS32 in a wrong way.
> > > >
> > > > Here, simple test code.
> > > >
> > > >   [test code 1]
> > > >
> > > >     #include <linux/init.h>
> > > >
> > > >     int __initdata foo;
> > > >     int get_foo(int x) { return foo; }
> > > >
> > > > If you compile it with ARM versatile_defconfig, modpost will show t=
he
> > > > symbol name, (unknown).
> > > >
> > > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_f=
oo (section: .text) -> (unknown) (section: .init.data)
> > > >
> > > > If you compile it for other architectures, modpost will show the co=
rrect
> > > > symbol name.
> > > >
> > > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_f=
oo (section: .text) -> foo (section: .init.data)
> > > >
> > > > For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value=
.
> > > >
> > > > I just mimicked the code in arch/arm/kernel/module.c.
> > > >
> > > > However, there is more difficulty for ARM.
> > > >
> > > > Here, test code.
> > > >
> > > >   [test code 2]
> > > >
> > > >     #include <linux/init.h>
> > > >
> > > >     int __initdata foo;
> > > >     int get_foo(int x) { return foo; }
> > > >
> > > >     int __initdata bar;
> > > >     int get_bar(int x) { return bar; }
> > > >
> > > > With this commit applied, modpost will show the following messages
> > > > for ARM versatile_defconfig:
> > > >
> > > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_f=
oo (section: .text) -> foo (section: .init.data)
> > > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_b=
ar (section: .text) -> foo (section: .init.data)
> > > >
> > > > The reference from 'get_bar' to 'foo' seems wrong.
> > > >
> > > > I have no solution for this because it is true in assembly level.
> > > >
> > > > In the following output, relocation at 0x1c is no longer associated
> > > > with 'bar'. The two relocation entries point to the same symbol, an=
d
> > > > the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.
> > > >
> >
> > These are section relative relocations - this is unusual but not
> > incorrect. Normally, you only see this if the symbols in question have
> > static linkage.
>
>
> I noticed this usually happens in reference to 'static',
> but on ARM, it happens even without 'static'.
> See the [test code 1].
>
>
> > It does mean that the symbol is not preemptible, which is what makes
> > this somewhat surprising.
> >
> > Generally, you cannot resolve a relocation to a symbol without taking
> > the addend into account, so looking up the address of .init.data in
> > the symbol table is not quite the right approach here. If anything,
> > the symbol should be reported as [.init.data+0x4] in the second case.
>
>
> In the old days, section mismatch warnings showed
> only the referenced section name.
>
> Since [1], modpost started to show the referenced symbol name too.
> Modpost did it in the past 17 years.
> It sometimes shows a wrong name, but works in most architectures.
> Unfortunately, I noticed ARM was an unfortunate case.
>
> Do you suggest removing it entirely?
>

No, not at all. But resolving the symbol should take the addend into
account, and this is essentially what you are doing in your patch.

The point is really that the relocation in question does not refer to
the symbol - it refers to a section+offset that we /think/ corresponds
with a certain symbol. But for example, if the symbol is weak and
another definition exists, the section based relocation will refer to
one version, and a relocation that references the symbol name will
refer to the other version.


>
> If (elf->symtab_start + ELF_R_SYM(r.r_info)) has a sensible
> symbol name, print it. Otherwise, print only the section name.
> Is this what you mean?
>
> That means, we will lose the symbol name info of 'static'
> (and even global symbols on ARM)
>
>
> That is what I wrote in the commit description.
>
> "I am keeping the current logic because it is useful in many architecture=
s,
> but the symbol name is not always correct depending on the optimization
> of the relocation. I left some comments in find_tosym()."
>

Fair enough.
