Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63571635FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiKWNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiKWNcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:32:08 -0500
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACD8FB09
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1669209367; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VgJ7rsfjU0vkSBmmZa0LW45iT+Tnqilgx1INQNmYo8429dTFqritHdkdWjiU33jiWT25bhzHu02W6LnUT0jPLoDof0bnPRpqAeyz28ynCWrlmDBW55vrdyMAUR4hMqXn6NWVGIny3IPd2egwEYpbRrsB1n6YIpvv6jluLEOsXqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1669209367; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UDJV2XySpjIKGCIbE8woRdDrQFpOJvF+DUQItZkefkk=; 
        b=L6coffg38kauvPZAlzGSccLygADXGt3O7vIsN728twyZKNIPw8JOMZSC+mAliEpCPJJDIj0RCi5QY7PMNiuwXhvhnLx4AxvS4J1aqbZiFf1Q3e21eDxeNl/srMTSDm3wfx2+wgV1/uP7vhR0lTEpP1hJI0D1IrM9Jedx+UXmPJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1669209367;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=UDJV2XySpjIKGCIbE8woRdDrQFpOJvF+DUQItZkefkk=;
        b=CQaMyzP7Nt5gKdXrbT9jvzUK5Yrt+pTmEYUbegAPsMLjsU9n4Wwp+2s31TC8sw6r
        SIPFBNmhi9adIqaRInQdEMm41HeJkmlWxM3o2P92zJC8GHt/QAEqAbZoc1BgjAJKN5n
        2O7AiB5EhdRTPIb7LjDB5tJrCERgJCFWJbRiy/9E=
Received: from edelgard.fodlan.icenowy.me (112.94.103.239 [112.94.103.239]) by mx.zohomail.com
        with SMTPS id 1669209364789380.3220861886971; Wed, 23 Nov 2022 05:16:04 -0800 (PST)
Message-ID: <402eb920c5ca84e7d751ec7bd9b7f4f512a66921.camel@icenowy.me>
Subject: Re: [PATCH] irqchip/sifive-plic: drop quirk for two-cell variant
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 23 Nov 2022 21:16:01 +0800
In-Reply-To: <86ilj5oltb.wl-maz@kernel.org>
References: <20221121042026.419383-1-uwu@icenowy.me>
         <86o7syoq4t.wl-maz@kernel.org>
         <16d01eebc1693916fc74e1e75458d6c0f080cf37.camel@icenowy.me>
         <86ilj5oltb.wl-maz@kernel.org>
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

=E5=9C=A8 2022-11-23=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 13:13 +0000=EF=BC=
=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> On Wed, 23 Nov 2022 12:38:56 +0000,
> Icenowy Zheng <uwu@icenowy.me> wrote:
> >=20
> > =E5=9C=A8 2022-11-22=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 17:28 +0000=EF=
=BC=8CMarc Zyngier=E5=86=99=E9=81=93=EF=BC=9A
> > > On Mon, 21 Nov 2022 04:20:26 +0000,
> > > Icenowy Zheng <uwu@icenowy.me> wrote:
> > > >=20
> > > > As the special handling of edge-triggered interrupts are
> > > > defined in
> > > > the
> > > > PLIC spec, we can assume it's not a quirk, but a feature of the
> > > > PLIC
> > > > spec; thus making it a quirk and use quirk-based codepath is
> > > > not so
> > > > necessary.
> > >=20
> > > It *is* necessary.
> > >=20
> > > >=20
> > > > Move to a #interrupt-cells-based practice which will allow both
> > > > device
> > > > trees without interrupt flags and with interrupt flags work for
> > > > all
> > > > compatible strings.
> > >=20
> > > No. You're tying together two unrelated concepts:
> > >=20
> > > - Edges get dropped in some implementations (and only some). You
> > > can
> > > =C2=A0 argue that the architecture allows it, but I see it is an
> > > =C2=A0 implementation bug.
> >=20
> > As the specification allows it, it's not an implementation bug --
> > and
> > for those which do not show this problem, it's possible that it's
> > just
> > all using the same trigger type (e.g. Rocket).
>=20
> What are you against? The fact that this is flagged as a quirk?
> Honestly, I don't care about that. If we can fold all implementations
> into the same scheme, that's fine by me.

Then what should I do?

>=20
> >=20
> > >=20
> > > - The need for expressing additional information in the interrupt
> > > =C2=A0 specifier is not necessarily related to the above. Other
> > > interrupt
> > > =C2=A0 controllers use extra cells to encode the interrupt affinity,
> > > for
> > > =C2=A0 example.
> >=20
> > I think in these situations, if the interrupt controller does not
> > contain any special handling for edge interrupts, we can just
> > describe
> > them as level ones in SW.
>=20
> No, that's utterly wrong. We don't describe an edge as level. Ever.
>=20
> >=20
> > >=20
> > > I want these two things to be kept separate. Otherwise, once we
> > > get
> > > some fancy ACPI support for RISCV (no, please...), we'll have to
> > > redo
> > > the whole thing...
> > >=20
> > > > In addition, this addresses a stable version DT binding
> > > > violation -
> > > > -
> > > > Linux v5.19 comes with "thead,c900-plic" with #interrupt-cells
> > > > defined to
> > > > be 1 instead of 2, this commit will allow DTs that complies to
> > > > Linux
> > > > v5.19 binding work (although no such DT is devliered to the
> > > > public
> > > > now).
> > >=20
> > > *That* is what should get fixed.
> >=20
> > Supporting all stable versions' DT binding is our promise, I think.
>=20
> Absolutely. And I'm asking you to fix it. And only that.

Then what should I do? Mask this as another quirk that is only
applicable to c900-plic?

Sounds more crazy...

>=20
> Thanks,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M.
>=20

