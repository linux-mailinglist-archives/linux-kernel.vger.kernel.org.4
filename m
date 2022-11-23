Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55086636051
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiKWNrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiKWNrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:47:13 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B72BB4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:36:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669210562; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Fl6C8NlVzAsWPEBN5Zu5VN9JD+iUmo2wGYPhBFG8JNOkRXAJbNNEsar2nmLxps62oT+7vQ2ZlxCgc0n4PfrJNqo5I5BBULajA2Wg/jG2BhXv0pGC9erZPMHfkTtewtWAyUQosXLRis8oJKA6x3zMQAxvL56wpIh/sAPVNravmkE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669210562; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jmmp9+L79IRqXmKJpYo/LsiNpc9jXUTGtxlroOFT0zw=; 
        b=LLLJMoVGg8/9XWLtI6vy/T0IGhP8DXIhmVGLagmKZCvYUeovQFQgCiVAg+YMwt39juHzzYhk6Pa+91dGZmtHpt86LRgBPrInvxPbAOuKWRV6nJS6FpAFdcansC3bLl5dI1JrLSr6faDTOaiVzopD4OtNQLBGnSz4UROo1S0ht48=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669210562;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=jmmp9+L79IRqXmKJpYo/LsiNpc9jXUTGtxlroOFT0zw=;
        b=G7ZbHoy8kztiB9tz7MtYY2f/s1u7EwcanqDgruvmpxoBvDBg3ZhgWy4pkK8sa5Fx
        oLco6zARtcqHOH8sv2NG4yXD3ine9ELucLsTBAt/fV9WLvGig9T0n1Hyldc2bMaaoog
        4uvoaSN+u/GPhnXGOEFnNW55R9ktzXRgCAvAZ0ZM=
Received: from edelgard.fodlan.icenowy.me (112.94.103.239 [112.94.103.239]) by mx.zohomail.com
        with SMTPS id 1669210561991307.3321068682709; Wed, 23 Nov 2022 05:36:01 -0800 (PST)
Message-ID: <463d5effd271c002fb18fb3b8326321501c18782.camel@icenowy.me>
Subject: Re: [PATCH] irqchip/sifive-plic: drop quirk for two-cell variant
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 23 Nov 2022 21:35:58 +0800
In-Reply-To: <86h6ypol03.wl-maz@kernel.org>
References: <20221121042026.419383-1-uwu@icenowy.me>
         <86o7syoq4t.wl-maz@kernel.org>
         <16d01eebc1693916fc74e1e75458d6c0f080cf37.camel@icenowy.me>
         <86ilj5oltb.wl-maz@kernel.org>
         <402eb920c5ca84e7d751ec7bd9b7f4f512a66921.camel@icenowy.me>
         <86h6ypol03.wl-maz@kernel.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2022-11-23=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 13:31 +0000=EF=BC=
=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 23 Nov 2022 13:16:01 +0000,
> Icenowy Zheng <uwu@icenowy.me> wrote:
> >=20
> > =E5=9C=A8 2022-11-23=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 13:13 +0000=EF=
=BC=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> > > On Wed, 23 Nov 2022 12:38:56 +0000,
> > > Icenowy Zheng <uwu@icenowy.me> wrote:
> > > >=20
> > > > =E5=9C=A8 2022-11-22=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 17:28 +000=
0=EF=BC=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> > > > > On Mon, 21 Nov 2022 04:20:26 +0000,
> > > > > Icenowy Zheng <uwu@icenowy.me> wrote:
> > > > > >=20
> > > > > > As the special handling of edge-triggered interrupts are
> > > > > > defined in
> > > > > > the
> > > > > > PLIC spec, we can assume it's not a quirk, but a feature of
> > > > > > the
> > > > > > PLIC
> > > > > > spec; thus making it a quirk and use quirk-based codepath
> > > > > > is
> > > > > > not so
> > > > > > necessary.
> > > > >=20
> > > > > It *is* necessary.
> > > > >=20
> > > > > >=20
> > > > > > Move to a #interrupt-cells-based practice which will allow
> > > > > > both
> > > > > > device
> > > > > > trees without interrupt flags and with interrupt flags work
> > > > > > for
> > > > > > all
> > > > > > compatible strings.
> > > > >=20
> > > > > No. You're tying together two unrelated concepts:
> > > > >=20
> > > > > - Edges get dropped in some implementations (and only some).
> > > > > You
> > > > > can
> > > > > =C2=A0 argue that the architecture allows it, but I see it is an
> > > > > =C2=A0 implementation bug.
> > > >=20
> > > > As the specification allows it, it's not an implementation bug
> > > > --
> > > > and
> > > > for those which do not show this problem, it's possible that
> > > > it's
> > > > just
> > > > all using the same trigger type (e.g. Rocket).
> > >=20
> > > What are you against? The fact that this is flagged as a quirk?
> > > Honestly, I don't care about that. If we can fold all
> > > implementations
> > > into the same scheme, that's fine by me.
> >=20
> > Then what should I do?
>=20
> Make all edge-triggered interrupts use the edge flow.
>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > - The need for expressing additional information in the
> > > > > interrupt
> > > > > =C2=A0 specifier is not necessarily related to the above. Other
> > > > > interrupt
> > > > > =C2=A0 controllers use extra cells to encode the interrupt
> > > > > affinity,
> > > > > for
> > > > > =C2=A0 example.
> > > >=20
> > > > I think in these situations, if the interrupt controller does
> > > > not
> > > > contain any special handling for edge interrupts, we can just
> > > > describe
> > > > them as level ones in SW.
> > >=20
> > > No, that's utterly wrong. We don't describe an edge as level.
> > > Ever.
> > >=20
> > > >=20
> > > > >=20
> > > > > I want these two things to be kept separate. Otherwise, once
> > > > > we
> > > > > get
> > > > > some fancy ACPI support for RISCV (no, please...), we'll have
> > > > > to
> > > > > redo
> > > > > the whole thing...
> > > > >=20
> > > > > > In addition, this addresses a stable version DT binding
> > > > > > violation -
> > > > > > -
> > > > > > Linux v5.19 comes with "thead,c900-plic" with #interrupt-
> > > > > > cells
> > > > > > defined to
> > > > > > be 1 instead of 2, this commit will allow DTs that complies
> > > > > > to
> > > > > > Linux
> > > > > > v5.19 binding work (although no such DT is devliered to the
> > > > > > public
> > > > > > now).
> > > > >=20
> > > > > *That* is what should get fixed.
> > > >=20
> > > > Supporting all stable versions' DT binding is our promise, I
> > > > think.
> > >=20
> > > Absolutely. And I'm asking you to fix it. And only that.
> >=20
> > Then what should I do? Mask this as another quirk that is only
> > applicable to c900-plic?
>=20
> No. Make interrupts with a single cell use the level flow.

This sounds exactly like what we do in this patch now.

Or, should we keep the quirk, and require both a flag cell containing
IRQ_TYPE_EDGE_RISING and an interrupt controller that matches the quirk
to use the special codepath for edge interrupts?

>=20
> > Sounds more crazy...
>=20
> There is obviously no accounting for taste.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.
>=20

