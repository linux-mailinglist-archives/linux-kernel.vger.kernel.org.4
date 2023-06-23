Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F02373BD43
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFWQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjFWQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:53:53 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34938270E;
        Fri, 23 Jun 2023 09:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687539230;
        bh=1+Q3s9+4hIOQJxus01vWM8frh+OlMBNzr2yk8GZvJP8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=m/qvk+H1fM1W6DOe/lEURh0RkeDXaG+/ORWCTn/N1dgVW0f+7LlHYMHS11rWW4m6Q
         clyJpEfABALQMfuAws2j5YeGMw+Y8Zb+3t5FnIuqLPnHtvH2ASNTr9Bzy3X4w2VBpB
         uazawT9ZLZjRoouWe2YqSJDzakE8sTHMraXosIOw=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 38C3865A9C;
        Fri, 23 Jun 2023 12:53:49 -0400 (EDT)
Message-ID: <7502003f530ca03548bad513b70401939eac7f6e.camel@xry111.site>
Subject: Re: [PATCH 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
From:   Xi Ruoyao <xry111@xry111.site>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Date:   Sat, 24 Jun 2023 00:53:47 +0800
In-Reply-To: <CAKwvOdn5e+BzhGzDPnZYEjCuanABJmu5ZZo5x2uwHj4L44m5nA@mail.gmail.com>
References: <20230623134351.1898379-1-kernel@xen0n.name>
         <20230623134351.1898379-8-kernel@xen0n.name>
         <CAKwvOdn5e+BzhGzDPnZYEjCuanABJmu5ZZo5x2uwHj4L44m5nA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-06-23 at 09:39 -0700, Nick Desaulniers wrote:
> On Fri, Jun 23, 2023 at 6:44=E2=80=AFAM WANG Xuerui <kernel@xen0n.name> w=
rote:
> >=20
> > From: WANG Xuerui <git@xen0n.name>
> >=20
> > Now the arch code is mostly ready for LLVM/Clang consumption, it is tim=
e
> > to re-organize the CFLAGS a little to actually enable the LLVM build.
> >=20
> > A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
> > environment; support for the two features are currently blocked by
> > LLVM/Clang, and will come later.
> >=20
> > Signed-off-by: WANG Xuerui <git@xen0n.name>
> > ---
> > =C2=A0arch/loongarch/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++=
+++++---
> > =C2=A0arch/loongarch/vdso/Makefile |=C2=A0 6 +++++-
> > =C2=A02 files changed, 16 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index a27e264bdaa5..efe9b50bd829 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -46,12 +46,18 @@ ld-emul=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =3D $(64bit-emul)
> > =C2=A0cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D -mabi=3Dlp64s
> > =C2=A0endif
> >=20
> > -cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D -G0 -pipe -msoft-float
>=20
> This seems to drop -msoft-float for GCC. Intentional?
>=20
> > -LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D -G0 -static -n -nostdlib
> > +ifndef CONFIG_CC_IS_CLANG
> > +cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=
=3D -G0
> > +LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D -G0
>=20
> Thanks for the patch!
>=20
> I can understand not passing -G0 to clang if clang doesn't understand
> it, but should you be using CONFIG_LD_IS_LLD for LDFLAGS?
>=20
> What does -G0 do?

-G0 is a no-op for now because there is no small bss/data optimization
implemented for LoongArch yet.

/* snip */

> Why would AS_HAS_EXPLICIT_RELOCS be set if -mexplicit-relocs isn't
> supported? Is the kconfig for that broken?

Using GCC 12 (w/o -mexplicit-relocs support) together with Binutils >=3D
2.39 (with explicit relocs support) will cause kernel modules fail to be
loaded (because there will be R_LARCH_ABS_* relocations in the modules
and the module loader does not support them), so we deliberately reject
such a combination at compile time.

I could add R_LARCH_ABS_* implementation into the module loader to make
it work, but Huacai suggested to just declare the combination of GCC 12
and Binutils >=3D 2.39 unsupported.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
