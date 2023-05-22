Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170770BBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEVLgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbjEVLgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:36:20 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C946F1;
        Mon, 22 May 2023 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1684755358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0n8l4247LeEWaLKQ0FnSfNM9KwjF8gdrQk1OZZ4VON0=;
        b=vgcIeJ3SYVpE+jcU3BpOIfJQV6mo8nqBt41pXsNvzViL3qMlZQ0sZPJ1saiDlTQfuT4dN9
        RK6OVIflDrt5aZua0j4XeZJTSAF7Eqb1Beyly8LBtIrwXdbaNCT/N3dcJZPxFAV50yQ8n/
        gVjLZTufknvT5paH8YMPKdkWWVXlbQc=
Message-ID: <6b88623e44b2a98a2e5d8d6d2453f92eb1b673ae.camel@crapouillou.net>
Subject: Re: [PATCH v2 1/2] iio/adc: ingenic: Fix channel offsets in buffer
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        linux-mips@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Date:   Mon, 22 May 2023 13:35:56 +0200
In-Reply-To: <CAHp75VdjAxAvmYVW4qgV2i91L31=Ctx4nx_eAe9+pqPFEArD3w@mail.gmail.com>
References: <20230521225901.388455-1-contact@artur-rojek.eu>
         <20230521225901.388455-2-contact@artur-rojek.eu>
         <CAHp75VeLRHwcKQALwnBb-gqVeyxxH=_F40TserRXqo_kbaZzoQ@mail.gmail.com>
         <CAHp75VedgVOA4qTJFeVuabKXBaB=y4Ss0fLu7a7J9GGgWFPqQg@mail.gmail.com>
         <2fc0874ce8a802aeb98e553b15e27fb4d4b75a1c.camel@crapouillou.net>
         <CAHp75VdjAxAvmYVW4qgV2i91L31=Ctx4nx_eAe9+pqPFEArD3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Le lundi 22 mai 2023 =C3=A0 14:05 +0300, Andy Shevchenko a =C3=A9crit=C2=A0=
:
> On Mon, May 22, 2023 at 1:23=E2=80=AFPM Paul Cercueil <paul@crapouillou.n=
et>
> wrote:
> > Le lundi 22 mai 2023 =C3=A0 13:18 +0300, Andy Shevchenko a =C3=A9crit :
> > > On Mon, May 22, 2023 at 1:15=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, May 22, 2023 at 1:59=E2=80=AFAM Artur Rojek
> > > > <contact@artur-rojek.eu> wrote:
>=20
> ...
>=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tdat[6];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 val;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(tdat, 0, ARRAY_SIZE(=
tdat));
> > > >=20
> > > > Yeah, as LKP tells us this should be sizeof() instead of
> > > > ARRAY_SIZE().
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; mask && i < A=
RRAY_SIZE(tdat); mask >>=3D 2)
> > > > > {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (mask & 0x3) {
> > > >=20
> > > > (for the consistency it has to be GENMASK(), but see below)
> > > >=20
> > > > First of all, strictly speaking we should use the full mask
> > > > without
> > > > limiting it to the 0 element in the array (I'm talking about
> > > > active_scan_mask).
> > > >=20
> > > > That said, we may actually use bit operations here in a better
> > > > way,
> > > > i.e.
> > > >=20
> > > > =C2=A0 unsigned long mask =3D active_scan_mask[0] &
> > > > (active_scan_mask[0] -
> > > > 1);
> > > >=20
> > > > =C2=A0 j =3D 0;
> > > > =C2=A0 for_each_set_bit(i, active_scan_mask, ...) {
> > > > =C2=A0=C2=A0=C2=A0 val =3D readl(...);
> > > > =C2=A0=C2=A0=C2=A0 /* Two channels per sample. Demux active. */
> > > > =C2=A0=C2=A0=C2=A0 tdat[j++] =3D val >> (16 * (i % 2));
> > >=20
> > > Alternatively
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 /* Two channels per sample. Demux active. */
> > > =C2=A0=C2=A0=C2=A0=C2=A0 if (i % 2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tdat[j++] =3D upper_16_bits(val)=
;
> > > =C2=A0=C2=A0=C2=A0=C2=A0 else
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tdat[j++] =3D lower_16_bits(val)=
;
> > >=20
> > > which may be better to read.
> >=20
> > It's not if/else though. You would check (i % 2) for the upper 16
> > bits,
> > and (i % 1) for the lower 16 bits. Both can be valid at the same
> > time.
>=20
> Are you sure? Have you looked into the proposed code carefully?

Yes. I co-wrote the original code, I know what it's supposed to do.

>=20
> What probably can be done differently is the read part, that can be
> called once. But looking at it I'm not sure how it's supposed to work
> at all, since the address is always the same. How does the code and
> hardware are in sync with the channels?

It's a FIFO.

Cheers,
-Paul

>=20
> > > > =C2=A0 }
> > > >=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =
=3D readl(adc->base +
> > > > > JZ_ADC_REG_ADTCH);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Tw=
o channels per sample. Demux
> > > > > active.
> > > > > */
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (m=
ask & BIT(0))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tdat[i++] =3D val & 0xffff;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (m=
ask & BIT(1))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tdat[i++] =3D val >> 16;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20

