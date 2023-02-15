Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9356A697CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjBONGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjBONGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:06:35 -0500
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C6838EA5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1676466389;
        bh=la/gxvFeBwR+hympTcN39C8IlB05NbIOEkTkiTkOIik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Faae/TO7zgg3VIqTmyTx1N2B6zwcLHrBChGYbATM5XqI/xHwiTlXqVvUxb3c+avmm
         PWWSaY1n19GZ6EFG9Gtft7JFl57/sjA4Dn+6dKx8e4xuS53rb7aYD8K8Aq731viA3L
         CI1oNweWuyPl89XMQfa+AX83q90oLpsjocyRM7KI=
Received: from [IPv6:240e:358:111b:f00:dc73:854d:832e:3] (unknown [IPv6:240e:358:111b:f00:dc73:854d:832e:3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id DB3AD65926;
        Wed, 15 Feb 2023 08:06:25 -0500 (EST)
Message-ID: <1f2b697ee10ba1b1ea2e2128697e1924d2479d4c.camel@xry111.site>
Subject: Re: "kernel ade access" oops on LoongArch
From:   Xi Ruoyao <xry111@xry111.site>
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jinyang He <hejinyang@loongson.cn>, loongarch@lists.linux.dev,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
Date:   Wed, 15 Feb 2023 21:06:21 +0800
In-Reply-To: <6268f221cfca8b7550ad0673246f09cd439ede05.camel@xry111.site>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
         <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
         <511d385675ea7a846ff791974c6ae7feeeec2589.camel@xry111.site>
         <9a70e89c-0f3b-0660-501e-3292e410cfd8@loongson.cn>
         <5403e5eb-5792-7d6f-df74-ca3fab82ecd5@loongson.cn>
         <818419c03037bda833a5b281588a4b331c34ae8c.camel@xry111.site>
         <74fb1e24-36c0-c642-5bab-3646ba7790df@loongson.cn>
         <21b0e60dac8bedf9e389645ec103aa4241b35f8d.camel@xry111.site>
         <bf0e57db317d7061ecaaf928ce6cf40941b1740c.camel@xry111.site>
         <6268f221cfca8b7550ad0673246f09cd439ede05.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-02-15 at 20:51 +0800, Xi Ruoyao wrote:
> On Wed, 2023-02-15 at 19:52 +0800, Xi Ruoyao wrote:
> > On Wed, 2023-02-15 at 16:35 +0800, Xi Ruoyao wrote:
> > > On Wed, 2023-02-15 at 16:25 +0800, Youling Tang wrote:
> > > > Can you modify the kernel as follows and test it, so as to avoid
> > > > possible relationship with the exception table data link
> > > > position
> > > > and
> > > > alignment rules (or use EXCEPTION_TABLE(12))?
> > > >=20
> > > > --- a/arch/loongarch/kernel/vmlinux.lds.S
> > > > +++ b/arch/loongarch/kernel/vmlinux.lds.S
> > > > @@ -4,7 +4,6 @@
> > > > =C2=A0 #include <asm/thread_info.h>
> > > >=20
> > > > =C2=A0 #define PAGE_SIZE _PAGE_SIZE
> > > > -#define RO_EXCEPTION_TABLE_ALIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 4
> > > >=20
> > > > =C2=A0 /*
> > > > =C2=A0=C2=A0 * Put .bss..swapper_pg_dir as the first thing in .bss.=
 This
> > > > will
> > > > @@ -54,6 +53,8 @@ SECTIONS
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 . =3D ALIGN(PECOFF=
_SEGMENT_ALIGN);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _etext =3D .;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EXCEPTION_TABLE(16)
> > > > +
> > >=20
> > > It seems the kernel refuses to boot after the change, but I'm not
> > > completely sure: I'm 5 km away from the board and operating it via
> > > ssh
> > > so maybe it's a reboot failure or network failure.=C2=A0 I'll report
> > > again in
> > > the evening.
> >=20
> > It was a reboot failure.
> >=20
> > Now it has booted successfully, but the stack trace still shows
> > (during
> > the 25th run of the make test t=3D... command).
>=20
> Ouch, I know what's happening...
>=20
> In the architecture-independent code we have something like
>=20
> extern struct exception_table_entry a[], b[];
> bsearch(a, b - a);
>=20
> According to the C standard, when you write "b - a" where a and b are
> pointers to type T, "b" and "a" must be pointers to elements in the
> same
> array of T.=C2=A0 So the compiler can assume ((uintptr_t)b - (uintptr_t)a=
)
> %
> 12 =3D=3D 0 and optimize "b - a" to something like
>=20
> (((uintptr_t)b - (uintptr_t)a) >> 2) * inv3
>=20
> Here inv3 is the inversion of 3 in the modulo-2**64 integer ring, so
> the
> compiler can avoid an expensive divide instruction.=C2=A0 But in my vmlin=
ux
> ((uintptr_t)b - (uintptr_t)a) is somehow not a multiple of 12:
>=20
> (gdb) p ((uintptr_t)__stop___ex_table - (uintptr_t)__start___ex_table)
> % sizeof(struct exception_table_entry)
> $9 =3D 8
>=20
> So I guess
>=20
> #define RO_EXCEPTION_TABLE_ALIGN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12
>=20
> will work.=C2=A0 I'll take a try...

No, it's not related...

The reason is the "LoongArch: Add vector extensions support" in my local
repo is not same as the version in loongarch-next!  My local version
contains some ".section __ex_table", and the content seems predates the
relative exception table change.

Sorry for wasted you guys an afternoon :(.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
