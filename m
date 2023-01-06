Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7767065FC32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAFHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:38:57 -0500
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252C0B43
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:38:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1672990719; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dumhgiwWnO5896HhtI0bgKFJN7PINS0ZjvMEkcSjaacedaxbIvMWNVE75KRkdB0MJNEWgk5luzmKaqSrY3wiNDRiwnQCPrWSJskUQ23Fl9JxE0qdHA+F2flHklixZfajXE5RJHJWqX43SSv9/rpgBRUhIUVIlJ8yUzg+jyfUXqs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1672990719; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=TioKn5CO8tJoob2wJhuL1JbsftJhJzptZqlgXBEAeJE=; 
        b=G9XKNIOLCc220iEQgGqtOaVhAC1/mgMQKK8ER9AjTEhg4NJTBl04zbVrvudR/B2w5iceAm1+FbjeLeJnaI/jLAfYTiAzKE7ADxiCCP9TORWe4VPQZVpIXIGZ0nL3iheth65Y4nIA30PyJzZZpV5ZycQU4HqkkWiHd+6R6QCuAgc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1672990719;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=TioKn5CO8tJoob2wJhuL1JbsftJhJzptZqlgXBEAeJE=;
        b=fZdYvtD1+TeKBEcaVMLM+wngttu+IXYG5lDFY6FDeBwujMjZDTe9JkEyakehPnV0
        N6joYFh6VX7K/8piO4aisF4u9WJpB1oohZgnMr4ZhNcugxEnh+iQqxZ59z2VwsLKH0H
        f/s1KxG/RRVfyGKojAqkzXac9J2gfZVk5RvqAjsw=
Received: from edelgard.fodlan.icenowy.me (120.85.96.143 [120.85.96.143]) by mx.zohomail.com
        with SMTPS id 1672990717981580.103026584164; Thu, 5 Jan 2023 23:38:37 -0800 (PST)
Message-ID: <fa4342510fdf93f809671239fe1a1df68b378357.camel@icenowy.me>
Subject: Re: [RFC PATCH 2/3] riscv: use VA+PA variant of CMO macros for DMA
 synchorization
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Jan 2023 15:38:33 +0800
In-Reply-To: <2135147.irdbgypaU6@diego>
References: <20230104074146.578485-1-uwu@icenowy.me>
         <CAJF2gTTO3jx8FqMVRmfgkjO02sCVx2SVbe-Sn1uKXojyn8RDaA@mail.gmail.com>
         <bcce507a31662004262fa3bbe911f1b1ff7f27af.camel@icenowy.me>
         <2135147.irdbgypaU6@diego>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-01-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 13:16 +0100=EF=BC=
=8CHeiko St=C3=BCbner=E5=86=99=E9=81=93=EF=BC=9A
> Hi,
>=20
> Am Mittwoch, 4. Januar 2023, 10:27:53 CET schrieb Icenowy Zheng:
> > =E5=9C=A8 2023-01-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 17:24 +0800=EF=
=BC=8CGuo Ren=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, Jan 4, 2023 at 4:59 PM Icenowy Zheng <uwu@icenowy.me>
> > > wrote:
> > > >=20
> > > > =E5=9C=A8 2023-01-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 16:50 +080=
0=EF=BC=8CGuo Ren=E5=86=99=E9=81=93=EF=BC=9A
> > > > > On Wed, Jan 4, 2023 at 3:43 PM Icenowy Zheng <uwu@icenowy.me>
> > > > > wrote:
> > > > > >=20
> > > > > > DMA synchorization is done on PA and the VA is calculated
> > > > > > from
> > > > > > the
> > > > > > PA.
> > > > > >=20
> > > > > > Use the alternative macro variant that takes both VA and PA
> > > > > > as
> > > > > > parameters, thus in case the ISA extension used support PA
> > > > > > directly, the
> > > > > > overhead for re-converting VA to PA can be omitted.
> > > > > >=20
> > > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > > > ---
> > > > > > =C2=A0arch/riscv/mm/dma-noncoherent.c | 8 ++++----
> > > > > > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/arch/riscv/mm/dma-noncoherent.c
> > > > > > b/arch/riscv/mm/dma-
> > > > > > noncoherent.c
> > > > > > index d919efab6eba..a751f4aece62 100644
> > > > > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > > > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > > > > @@ -19,13 +19,13 @@ void
> > > > > > arch_sync_dma_for_device(phys_addr_t
> > > > > > paddr, size_t size,
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (dir) {
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case DMA_TO_DEVICE:
> > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ALT_CMO_OP(clean, vaddr, size,
> > > > > > riscv_cbom_block_size);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ALT_CMO_OP_VPA(clean, vaddr, paddr, size,
> > > > > > riscv_cbom_block_size);
> > > > > ALT_CMO_OP -> ALT_CMO_OP_VPA, is the renaming necessary?
> > > >=20
> > > > I didn't rename the original ALT_CMO_OP, ALT_CMO_OP_VPA is
> > > > something
> > > > new.
> > > The ##_VPA is really strange.
> > >=20
> > > How about:
> > > ALT_CMO_OP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> A=
LT_CMO_OP_VA
> > > ALT_CMO_OP_VPA -> ALT_CMO_OP
> >=20
> > It's thus a much bigger change.
> >=20
> > If you are not fond of _VPA, I can rename it to _VA_PA.
>=20
> before you spend too much time on this, there is currently a parallel
> discussion running about including all the other different vendor-
> specific cache management.
>=20
> See [0] and the thread before that for reference.

The code shown here seems to be only a draft, and not even testable.

>=20
> The consensus seems to be that cache-handling itself is not fast
> anyway,
> and therefore to reduce complexity for the cache handling and move
> non-zicbom cache-handling into a indirect function call that the can
> be
> overridden at runtime.

Well yes I tested this patchset on my LiteX with OpenC906, and it does
not help at all on LiteETH throughtput. So maybe this is only some
theortical gain.

>=20
>=20
> Heiko
>=20
> [0]
> https://lore.kernel.org/all/43aee000-5b89-4d94-98d2-b37b1a18a83e@app.fast=
mail.com/
>=20
>=20

