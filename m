Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7570D314
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 07:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjEWFIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 01:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjEWFIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 01:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B287110;
        Mon, 22 May 2023 22:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 946AA624C8;
        Tue, 23 May 2023 05:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F5C433EF;
        Tue, 23 May 2023 05:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684818498;
        bh=bktkVuNRptN8eDi50t2dVY3avbuxrt/A9qjfM43HWT0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=piHfcIbdzKGO00/pLZFlAgwavsGyFrCTwYxrMWAAtoa/Niw1DeeDBQXBGWkXF5W8c
         S8wDwcvXmPrsVkspQBP7wSqTyEnrs151HtSMiMM248kQ+p2PdiqCK+YeEEwVac60rS
         V17PlWCf7urqin3L2OjYZ7ymKwbLlhHaE8MG5jk/mJYsKiT5lKncKOlVCCOi+t+aP2
         9EDu+16kdRsl4anIwNpyZws5WuNi0dEoqS9Kf7YGERQp47iykKrFQnmuhXhkevvlr7
         CwMoQyotaGg1vvr1QQycmWqB52MzpHcD5wfXB0VYFGj7mMEafVnCqBhcWok1btU1Q2
         Jli4NQkk899HQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-199dd37f0e4so5251486fac.2;
        Mon, 22 May 2023 22:08:17 -0700 (PDT)
X-Gm-Message-State: AC+VfDwZo+DtE1pSdqRDEbuFtKzfBqSr5nhT9jjMF40RWJ+6skOIfZo5
        R1vvLjencX7fgINy/r0IS8+TrO/9hd6jVsfSIN4=
X-Google-Smtp-Source: ACHHUZ6ty4va+cNcopcq9/EMbT2GmDdcfQCbkEFnVL06x9qfTfkDeAPJPafWGrxLv+hmDu8hyeRaPtRF218tBTMBMn0=
X-Received: by 2002:a05:6870:b78c:b0:192:b536:259 with SMTP id
 ed12-20020a056870b78c00b00192b5360259mr5723576oab.19.1684818497249; Mon, 22
 May 2023 22:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-3-masahiroy@kernel.org> <CAKwvOd=B+dKWjxD-K-8btROvywp_Nei=CREeYZdCvKSGuHHJOA@mail.gmail.com>
 <CAMj1kXEYZdsE8A2izGbb4HWYT3a8HN9Ocw=pb3d64Zu0441RgA@mail.gmail.com>
In-Reply-To: <CAMj1kXEYZdsE8A2izGbb4HWYT3a8HN9Ocw=pb3d64Zu0441RgA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 May 2023 14:07:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASFLnB9svCf6QvVPSMyXhHRzv9teAmZqXkTw629=_xo=A@mail.gmail.com>
Message-ID: <CAK7LNASFLnB9svCf6QvVPSMyXhHRzv9teAmZqXkTw629=_xo=A@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] modpost: fix section mismatch message for R_ARM_ABS32
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>
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

On Tue, May 23, 2023 at 6:36=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Mon, 22 May 2023 at 19:56, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > + linux-arm-kernel and some folks who might know another idea.
> >
> > On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > addend_arm_rel() processes R_ARM_ABS32 in a wrong way.
> > >
> > > Here, simple test code.
> > >
> > >   [test code 1]
> > >
> > >     #include <linux/init.h>
> > >
> > >     int __initdata foo;
> > >     int get_foo(int x) { return foo; }
> > >
> > > If you compile it with ARM versatile_defconfig, modpost will show the
> > > symbol name, (unknown).
> > >
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo=
 (section: .text) -> (unknown) (section: .init.data)
> > >
> > > If you compile it for other architectures, modpost will show the corr=
ect
> > > symbol name.
> > >
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo=
 (section: .text) -> foo (section: .init.data)
> > >
> > > For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.
> > >
> > > I just mimicked the code in arch/arm/kernel/module.c.
> > >
> > > However, there is more difficulty for ARM.
> > >
> > > Here, test code.
> > >
> > >   [test code 2]
> > >
> > >     #include <linux/init.h>
> > >
> > >     int __initdata foo;
> > >     int get_foo(int x) { return foo; }
> > >
> > >     int __initdata bar;
> > >     int get_bar(int x) { return bar; }
> > >
> > > With this commit applied, modpost will show the following messages
> > > for ARM versatile_defconfig:
> > >
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo=
 (section: .text) -> foo (section: .init.data)
> > >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_bar=
 (section: .text) -> foo (section: .init.data)
> > >
> > > The reference from 'get_bar' to 'foo' seems wrong.
> > >
> > > I have no solution for this because it is true in assembly level.
> > >
> > > In the following output, relocation at 0x1c is no longer associated
> > > with 'bar'. The two relocation entries point to the same symbol, and
> > > the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.
> > >
>
> These are section relative relocations - this is unusual but not
> incorrect. Normally, you only see this if the symbols in question have
> static linkage.


I noticed this usually happens in reference to 'static',
but on ARM, it happens even without 'static'.
See the [test code 1].


> It does mean that the symbol is not preemptible, which is what makes
> this somewhat surprising.
>
> Generally, you cannot resolve a relocation to a symbol without taking
> the addend into account, so looking up the address of .init.data in
> the symbol table is not quite the right approach here. If anything,
> the symbol should be reported as [.init.data+0x4] in the second case.


In the old days, section mismatch warnings showed
only the referenced section name.

Since [1], modpost started to show the referenced symbol name too.
Modpost did it in the past 17 years.
It sometimes shows a wrong name, but works in most architectures.
Unfortunately, I noticed ARM was an unfortunate case.

Do you suggest removing it entirely?


If (elf->symtab_start + ELF_R_SYM(r.r_info)) has a sensible
symbol name, print it. Otherwise, print only the section name.
Is this what you mean?

That means, we will lose the symbol name info of 'static'
(and even global symbols on ARM)


That is what I wrote in the commit description.

"I am keeping the current logic because it is useful in many architectures,
but the symbol name is not always correct depending on the optimization
of the relocation. I left some comments in find_tosym()."



[1] 93684d3b8062d1cebdeaed398ec6d1f354cb41a9
  "kbuild: include symbol names in section mismatch warnings








--=20
Best Regards
Masahiro Yamada
