Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6A73CEFF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjFYHhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjFYHhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:37:01 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98AE40;
        Sun, 25 Jun 2023 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1687678619;
        bh=0Re/g564sdHKRscoqX6elaqNwLmzRZzXWM8m3RjfBA4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZrSL4wuF02WdCd2oTGqPSmZ639fYSvbgstGnA7Fz+PRF28eSXYIkW0k1XZ+k9Ncn2
         L/o4tvV0hAWtufqTcAOH0EwjUdaiPOt58ueryMMYqNxyWqwVBuBA69jL0VqhYRk0Mm
         SFbJ34AIm+2OW5FJt1fIRdTlTevfGJvlVkqEPjIY=
Received: from [192.168.124.11] (unknown [61.150.43.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 463136592A;
        Sun, 25 Jun 2023 03:36:58 -0400 (EDT)
Message-ID: <5154e8141e2b022b477f2d2658279e94f6b02149.camel@xry111.site>
Subject: Re: [PATCH v2 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
From:   Xi Ruoyao <xry111@xry111.site>
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Date:   Sun, 25 Jun 2023 15:36:56 +0800
In-Reply-To: <cc8c2f2d-b242-7488-3b5a-33828ee38b36@xen0n.name>
References: <20230624184055.3000636-1-kernel@xen0n.name>
         <20230624184055.3000636-8-kernel@xen0n.name>
         <CAAhV-H54bZ5_OSXtcq3B3d4bZj4GBTOf7Z8aA6Jm7uGdKTj_ug@mail.gmail.com>
         <cc8c2f2d-b242-7488-3b5a-33828ee38b36@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-06-25 at 15:16 +0800, WANG Xuerui wrote:
> On 2023/6/25 10:13, Huacai Chen wrote:
> > Hi, Ruoyao,
> >=20
> > On Sun, Jun 25, 2023 at 2:42=E2=80=AFAM WANG Xuerui <kernel@xen0n.name>=
 wrote:
> > >=20
> > > From: WANG Xuerui <git@xen0n.name>
> > >=20
> > > Now the arch code is mostly ready for LLVM/Clang consumption, it is t=
ime
> > > to re-organize the CFLAGS a little to actually enable the LLVM build.
> > >=20
> > > In particular, -mexplicit-relocs and -mdirect-extern-access are not
> > > necessary nor supported on Clang; feature detection via cc-option wou=
ld
> > > not work, because that way the broken combo of "new GNU as + old GCC"
> > > would seem to get "fixed", but actually produce broken kernels.
> > > Explicitly depending on CONFIG_CC_IS_CLANG is thus necessary to not
> > > regress UX for those building their own kernels.
> > >=20
> > > A build with !RELOCATABLE && !MODULE is confirmed working within a QE=
MU
> > > environment; support for the two features are currently blocked on
> > > LLVM/Clang, and will come later.
> > >=20
> > > Signed-off-by: WANG Xuerui <git@xen0n.name>
> > > ---
> > > =C2=A0 arch/loongarch/Makefile | 6 +++++-
> > > =C2=A0 1 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > > index 366771016b99..82c619791a63 100644
> > > --- a/arch/loongarch/Makefile
> > > +++ b/arch/loongarch/Makefile
> > > @@ -51,7 +51,9 @@ LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 +=3D -static -n -nostdlib
> > >=20
> > > =C2=A0 # When the assembler supports explicit relocation hint, we mus=
t use it.
> > > =C2=A0 # GCC may have -mexplicit-relocs off by default if it was buil=
t with an old
> > > -# assembler, so we force it via an option.
> > > +# assembler, so we force it via an option. For LLVM/Clang the desire=
d behavior
> > > +# is the default, and the flag is not supported, so don't pass it if=
 Clang is
> > > +# being used.
> > > =C2=A0 #
> > > =C2=A0 # When the assembler does not supports explicit relocation hin=
t, we can't use
> > > =C2=A0 # it.=C2=A0 Disable it if the compiler supports it.
> > > @@ -61,8 +63,10 @@ LDFLAGS_vmlinux=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +=3D -static -n -nostdlib
> > > =C2=A0 # combination of a "new" assembler and "old" compiler is not s=
upported.=C2=A0 Either
> > > =C2=A0 # upgrade the compiler or downgrade the assembler.
> > > =C2=A0 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> > > +ifndef CONFIG_CC_IS_CLANG
> > > =C2=A0 cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 +=3D -mexplicit-relocs
> > > =C2=A0 KBUILD_CFLAGS_KERNEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 +=3D -mdirect-extern-access
> > > +endif
> > I prefer to drop CONFIG_CC_IS_CLANG and use
> > cflags-y=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +=3D =
$(call cc-option,-mexplicit-relocs)
> > KBUILD_CFLAGS_KERNEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 +=3D $(call cc-option,-mdirect-extern-access)
> >=20
> > Then Patch-6 can be merged in this.
> >=20
> > What's your opinion?
>=20
> FYI: with this approach the build no longer instantly dies with binutils=
=20
> 2.40 + gcc 12.3, but there are also tons of warnings that say the model=
=20
> attribute is being ignored. I checked earlier discussions and this means=
=20
> modules are silently broken at runtime, which is not particularly good UX=
.

We can add

#if defined(MODULE) && !__has_attribute(model)
#  error some fancy error message
#endif

into percpu.h to error out in this case.  It had been in my earlier
drafts of explicit relocs patches, but we dropped it because there was
no such configuration (unless a snapshot of development GCC is used, and
using such a snapshot is never supported IIUC).


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
