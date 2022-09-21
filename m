Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1E5C048B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiIUQrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiIUQqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:46:14 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A1F114
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:38:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CB046C0002;
        Wed, 21 Sep 2022 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663778290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iggbc7PTRupjH9RV+lN74W+BaarXthDPdvpaDdjkEcA=;
        b=SdMgBCyWQlsKhMPrlMFF6j6kdwbLSEzC/Y99OIKcmw5kKJ86ewT19/AOYKVi+tZTttaBqx
        Ef/wEmZhXAFbq10S4D7iKm8G+3SchaIgQTlNTH22oDgX8Y6l6Zv2hE9wL0epqA5V+UmuVG
        yVsq1XLcVcOKempC12AYAsh3Zc9F+1TOH4b/OgeU/IeYATPjyjDIel95v1Uzta2Y868Eau
        JJRgj1LKLYKoO0VQfCFpnD+HbDjvHVT0+re466xOcywWc5zlqUeeP1jNjmpt6QMynwhnp5
        rF+j9DR9Vxfwd3s8RXZuITRSz5+QRSjqPX23xDmTZRUWSkUVCM+4kNcANfgzVw==
Date:   Wed, 21 Sep 2022 18:38:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Valentin Korenblit" <vkorenblit@sequans.com>,
        "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <20220921183807.241e2518@xps-13>
In-Reply-To: <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
        <20220921104002.226ff3f6@xps-13>
        <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
        <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
        <20220921164720.6bbc56d5@xps-13>
        <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@arndb.de wrote on Wed, 21 Sep 2022 17:49:11 +0200:

> On Wed, Sep 21, 2022, at 4:47 PM, Miquel Raynal wrote:
> >
> > The (erased) context of this thread:
> > https://lore.kernel.org/llvm/202209210641.MziHAbW7-lkp@intel.com/
> >
> > vkorenblit@sequans.com wrote on Wed, 21 Sep 2022 14:27:47 +0200:
> > =20
> >> Hi Miquel,
> >>=20
> >> I see that x86_64 doesn't support readsq/writesq because of
> >> CONFIG_GENERIC_IOMAP (I was building for arm64). However,
> >> __raw_readq/writeq are available and there are a few drivers
> >> using them. =20
> >
> > I would suggest to rather try using [read|write]sq() to get rid
> > of the CONFIG_GENERIC_IOMAP dependency. But it looks like those
> > functions are not defined on 32-bit architectures anyway. So if we want
> > the driver to compile on both arm and aarch64, it will not be enough.
> >
> > In practice, I guess we should never have the 64-bit accessor executed
> > when running on a 32-bit platform thanks to the following conditions:
> >
> >   1885			u8 data_dma_width =3D cdns_ctrl->caps2.data_dma_width;
> >   1886=09
> >   1887			int len_in_words =3D (data_dma_width =3D=3D 4) ? len >> 2 : le=
n >> 3;
> >   1888=09
> >   1889			/* read alingment data */
> >   1890			if (data_dma_width =3D=3D 4)
> >   1891				ioread32_rep(cdns_ctrl->io.virt, buf, len_in_words);
> >   1892			else =20
> >> 1893				ioread64_rep(cdns_ctrl->io.virt, buf, len_in_words); =20
> >
> > So maybe we could have something awful yet simple, like the following
> > within the Cadence driver:
> >
> > #if !CONFIG_64BIT
> > readsq(...) { BUG()? }
> > #endif
> >
> > Arnd, I've seen a couple of similar issues on the mailing lists in the
> > past 5 years but I could not find any working solution, I don't know
> > how all these threads have settled in the end. I thought maybe you
> > would have a better idea than the above hack :) =20
>=20
> There are a lot of different things going on here, so I need
> to unwind a bit:

Thanks for all your feedback!

> - every architecture should provide readsq()/readsl()/readsw()/readsb()
>   these days, regardless of CONFIG_GENERIC_IOMAP. If x86 does
>   not have that, we should fix asm-generic/io.h.

ARM does not seem to define readsq/writesq. Should it be fixed?

> - CONFIG_GENERIC_IOMAP just means an architecture uses the generic
>   ioread32_rep() style wrapper around readsl()/insl(). On most
>   architectures (not x86), insl() is implemented as a wrapper around
>   readsl() itself, so readsl() and ioread32_rep() should be identical.

Ok. But if CONFIG_GENERIC_IOMAP=3Dn (ARM, aarch64, x86_64),
ioread64_rep is then only defined if CONFIG_64BIT. As it is based
on readsq/writesq() and those must be defined (as you said), I don't get
why the *64_rep() helpers are not defined in all cases. Maybe because no
32-bit system _should_ need them? But then compile testing gets more
difficult.

> - For a FIFO, you cannot use readq() but have to use __raw_readq()
>   to get the correct endianness. You cannot use this for an
>   MMIO register with side-effects though, as this needs the byteswap
>   and the barrier in readsl().

I'm not sure about the true definition of "FIFO" as you say. I guess
you just mean reading from a BE device?

In this case I guess we need the barrier+byteswap helpers.

> - On 32-bit architectures, there is no generic way to access a 64-bit
>   MMIO location as you say. However, depending on the device you are
>   accessing, you can replace __raw_readq() with a pair of
>   __raw_readl(), along the lines of
>   include/linux/io-64-nonatomic-{lo-hi,hi-lo}.h

Ah ok, so in the end the per-driver implementation is preferred.

> >> Do you want me to re-implement readsq and writesq in Cadence
> >> driver privately or do you suggest a different (cleaner) approach? =20
> >
> > I would rather prefer to avoid this solution, as anyway I believe there
> > is no "generic" implementation working in all cases, there were a
> > couple of attempts IIRC to bring generic helpers like the above for all
> > architectures, but none of them landed in Linus' tree, probably because
> > it just cannot be made... =20
>=20
> If anyone has a datasheet for the cadence driver, they should be
> able to look up how one can access the FIFO in 8-byte mode using
> 32-bit accesses. I think it's something like

I don't think this is actually what we want. My understanding is
(Valentin, please correct me if I'm wrong):
- on ARM: we will always use 32-bit accesses
- on aarch64: we may use either 32-bit or 64-bit accesses
- on other architectures: we only want to compile test

I believe what Valentin wanted to achieve in the first place, was to
use 64-bit accesses when relevant (otherwise it does not work).

> static inline void cadence_nand_readsq(const volatile void __iomem *addr,
>                void *buffer, unsigned int count)
> {
>         if (count) {
>                 u64 *buf =3D buffer;
>=20
>                 do {
> #ifdef __raw_readq
>                         u64 x =3D __raw_readq(addr);
>                         *buf++ =3D x;
> #else
>                         u32 *buf32 =3D (void *)buf;
>                         buf32[0] =3D __raw_readl(addr + OFF0);
>                         buf32[1] =3D __raw_readl(addr + OFF1);
>                         buf++;
> #endif
>                 } while (--count);
>         }
> }
>=20
> Most likely, OFF0 is zero, while OFF1 is 4 here, but that
> depends on how the FIFO register is implemented.
>=20
>      Arnd


Thanks,
Miqu=C3=A8l
