Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA54662702
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjAIN2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjAIN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:28:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6942413F7C;
        Mon,  9 Jan 2023 05:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673270884; x=1704806884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pI9iCisd3SYnJ2fP9FfubE61ZiDt/emWCk3DGSaK2Q0=;
  b=zI1IvnOIwDm9CDZTGzK45qvYTAayAAfsfXLPCtBXgNhuhtV5fa+VdvUm
   ip5x7j0X/39x1CILz/CMMzZ6H5TOepQZYXFCAPB3JfyQtGjU5EF4KJEfh
   PfFgEgPtz2UEcst/TV3tKbt14kmVCa++UrJaaLiFT2Tx+EkrB65ZW7jKO
   B76Vlk6mWsqKP2H1D171xVr2zAsJcxbYvIZTBESdil6FOAwEWjdhQ5u0P
   FaLZAifk1NTTKcxuWCBbhzwWGL87cVBVh0oo3m3LO21XDPcCcm12KpWfv
   +8mHUx8u5/EOJkBgJ4Daq1cPAOlqSi+fdCsMmISY2yYKLkGoYXUS/WCfi
   g==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="asc'?scan'208";a="131470464"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2023 06:27:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 06:27:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 9 Jan 2023 06:27:53 -0700
Date:   Mon, 9 Jan 2023 13:27:31 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
Message-ID: <Y7wWQ200sdN2rAmX@wendy>
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
 <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
 <9017adf0-acd4-4c43-8aea-3579b214b477@app.fastmail.com>
 <CA+V-a8u6jvR=EDeE3mAbDr6-06NoBJ7mwmi_Y9qVyHT+aC-9rg@mail.gmail.com>
 <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EfZa/VP/6LktfZba"
Content-Disposition: inline
In-Reply-To: <45d6eb0c-cbe3-4a83-aa12-3483638473ae@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--EfZa/VP/6LktfZba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 01:59:12PM +0100, Arnd Bergmann wrote:
> On Mon, Jan 9, 2023, at 13:03, Lad, Prabhakar wrote:
> > On Sun, Jan 8, 2023 at 12:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >> >> > +struct riscv_cache_ops {
> >> >> > +     void (*clean_range)(unsigned long addr, unsigned long size);
> >> >> > +     void (*inv_range)(unsigned long addr, unsigned long size);
> >> >> > +     void (*flush_range)(unsigned long addr, unsigned long size);
> >> >> > +     void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t s=
ize,
> >> >> > +                                           enum dma_data_directi=
on dir,
> >> >> > +                                           enum dma_noncoherent_=
ops ops);
> >> >> > +};
> >> >>
> >> >> I don't quite see how the fourth operation is used here.
> >> >> Are there cache controllers that need something beyond
> >> >> clean/inv/flush?
> >> >>
> >> > This is for platforms that dont follow standard cache operations (li=
ke
> >> > done in patch 5/6) and there drivers decide on the operations
> >> > depending on the ops and dir.
> >>
> >> My feeling is that the set of operations that get called should
> >> not depend on the cache controller but at best the CPU. I tried to
> >> enumerate how zicbom and ax45 differ here, and how that compares
> >> to other architectures:
> >>
> >>                   zicbom      ax45,mips,arc      arm           arm64
> >> fromdevice      clean/flush   inval/inval   inval/inval   clean/inval
> >> todevice        clean/-       clean/-       clean/-       clean/-
> >> bidi            flush/flush   flush/inval   clean/inval   clean/inval

I did a bit of digging on lore for context on why the ops are what they
are..
In v3 of the Zicbom enablement patchset, things looked like:
=66romdevice	inval/inval
todevice	clean/-
bidi		flush/inval

v3:
https://lore.kernel.org/linux-riscv/20220610004308.1903626-3-heiko@sntech.d=
e/

Samuel had some comments about the invals:
https://lore.kernel.org/linux-riscv/342e3c12-ebb0-badf-7d4c-c444a2b842b2@sh=
olland.org/

In v4 it was changed to:
=66romdevice	inval/flush
todevice	clean/-
bidi		flush/flush

v4:
https://lore.kernel.org/linux-riscv/20220619203212.3604485-4-heiko@sntech.d=
e/

Christoph replied to that one, linking the thread belonging to the
commit you pointed out earlier:
https://lore.kernel.org/linux-riscv/20220620061607.GB10485@lst.de/

v5 produced what you have in your table above:
https://lore.kernel.org/linux-riscv/20220629215944.397952-4-heiko@sntech.de/

> >>
> >> So everyone does the same operation for DMA_TO_DEVICE, but
> >> they differ in the DMA_FROM_DEVICE handling, for reasons I
> >> don't quite see:
> >>
> >> Your ax45 code does the same as arc and mips. arm and
> >> arm64 skip invalidating the cache before bidi mappings,
> >> but arm has a FIXME comment about that. arm64 does a
> >> 'clean' instead of 'inval' when mapping a fromdevice
> >> page, which seems valid but slower than necessary.
> >>
> >> Could the zicbom operations be changed to do the same
> >> things as the ax45/mips/arc ones, or are there specific
> >> details in the zicbom spec that require this?
> >>
> > I'll let the RISC-V experts respond here.
>=20
> Adding Christoph Hellwig and Will Deacon to Cc as well.
>=20
> I had another look at the arm64 side, which (like the zicbom
> variant) uses 'clean' on dma_sync_single_for_device(DMA_FROM_DEVICE),
> as that has changed not that long ago, see
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dc50f11c6196f45c92ca48b16a5071615d4ae0572
>=20
> I'm still not sure what the correct set of operations has
> to be, but nothing in that patch description sounds ISA
> or even microarchitecture specific.

Hope the lore archaeology helps jog people's memories...

Conor


--EfZa/VP/6LktfZba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7wWQwAKCRB4tDGHoIJi
0gL7AQDEzebwbDTWywTDxF0JbLupBm3vCX+c0NjvVE0cz+r1qwEAhs7DXHh6uLCR
MEBu78WTgDnKbkFV06kacnxKCzIo8gE=
=RzhW
-----END PGP SIGNATURE-----

--EfZa/VP/6LktfZba--
