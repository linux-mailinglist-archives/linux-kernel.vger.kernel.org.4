Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B06F2A00
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 19:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjD3R1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 13:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjD3R12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 13:27:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C642709;
        Sun, 30 Apr 2023 10:27:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDAC60D3E;
        Sun, 30 Apr 2023 17:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B225EC433EF;
        Sun, 30 Apr 2023 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682875645;
        bh=kvkv3Q8LokOkPPhq/+uPMJwHGQ4nK0o0pS8Uc1X116A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=czqo36l1nuHq6+yudCtCBSV0bxYO3nn8e7XVrvZpbdn491CGek2nIbw9uLev8wLGb
         dFtfnJEsF48B/pFmjmNcRQG6Yu3sfbcTdSjnK3SDwFv69y9EWwfG4HlP33ENtaQmsI
         LyB7cLe46jBvgSMq6NfbaVC8JHlX9/HztGRetYVKJSNB5kFJugHvjiH0KDCuSIXI7v
         C2y2QaPwgNrZzVJ3+L5OMjVqpmjGZ5xSgQZD4AA4sIqRLfi8I5Mqwqok4IY9IgqWIo
         Lsz7qiiI0P4LXAfr1QFvRRKxDcjuVjC6QEC//cu3aPsHOLrgAS3SXAjsGvC3PnzE/f
         8DBS5VA47zQ6Q==
Date:   Sun, 30 Apr 2023 18:43:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Masahiro Honda <honda@mechatrax.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Fix IRQ issue by setting IRQ_DISABLE_UNLAZY flag
Message-ID: <20230430184311.7443e1d7@jic23-huawei>
In-Reply-To: <b6a96cca17832219042c90baec2442b1a5bad7b7.camel@gmail.com>
References: <20230420102316.757-1-honda@mechatrax.com>
        <20230423121528.259d3cd4@jic23-huawei>
        <b6a96cca17832219042c90baec2442b1a5bad7b7.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 11:09:34 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Jonathan,
>=20
> On Sun, 2023-04-23 at 12:15 +0100, Jonathan Cameron wrote:
> > On Thu, 20 Apr 2023 19:23:16 +0900
> > Masahiro Honda <honda@mechatrax.com> wrote:
> >  =20
> > > The Sigma-Delta ADCs supported by this driver can use SDO as an inter=
rupt
> > > line to indicate the completion of a conversion. However, some devices
> > > cannot properly detect the completion of a conversion by an interrupt.
> > > This is for the reason mentioned in the following commit.
> > >=20
> > > commit e9849777d0e2 ("genirq: Add flag to force mask in
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable_irq[_nosy=
nc]()")
> > >=20
> > > A read operation is performed by an extra interrupt before the comple=
tion
> > > of a conversion. This patch fixes the issue by setting IRQ_DISABLE_UN=
LAZY
> > > flag.
> > >=20
> > > Signed-off-by: Masahiro Honda <honda@mechatrax.com>
> > > ---
> > > v3:
> > > =C2=A0- Remove the Kconfig option.
> > > v2:
> > > https://lore.kernel.org/linux-iio/20230414102744.150-1-honda@mechatra=
x.com/
> > > =C2=A0- Rework commit message.
> > > =C2=A0- Add a new entry in the Kconfig.
> > > =C2=A0- Call irq_clear_status_flags(irq, IRQ_DISABLE_UNLAZY) when fre=
eing the
> > > IRQ.
> > > v1:
> > > https://lore.kernel.org/linux-iio/20230306044737.862-1-honda@mechatra=
x.com/
> > >=20
> > > =C2=A0drivers/iio/adc/ad_sigma_delta.c | 25 ++++++++++++++++++++-----
> > > =C2=A01 file changed, 20 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad_sigma_delta.c
> > > b/drivers/iio/adc/ad_sigma_delta.c
> > > index d8570f620..215ecbedb 100644
> > > --- a/drivers/iio/adc/ad_sigma_delta.c
> > > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > > @@ -565,6 +565,14 @@ int ad_sd_validate_trigger(struct iio_dev *indio=
_dev,
> > > struct iio_trigger *trig)
> > > =C2=A0}
> > > =C2=A0EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA=
);
> > > =C2=A0
> > > +static void ad_sd_free_irq(void *sd)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ad_sigma_delta *sig=
ma_delta =3D sd;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq_clear_status_flags(sig=
ma_delta->spi->irq, IRQ_DISABLE_UNLAZY);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_irq(sigma_delta->spi-=
>irq, sigma_delta);
> > > +} =20
> >=20
> > Don't fuse the two operations unwinding like this.=C2=A0 Just register =
a callback
> > that only
> > does the irq_clear_status_flags immediately after setting them.=C2=A0 T=
hen leave =20
>=20
> I was the one to propose fusing them together because I thought that we c=
ould
> have issues by clearing the flag after calling free_irq(). After looking =
again
> at the IRQ code, I can see that it is not up to free_irq() to free the al=
located
> irq_descs (that might only happen when unmapping the virq) which means we=
 should
> be fine doing the normal way.

Ah. I'd missed the ordering.  If that had been valid (and I think you are c=
orrect
that it is not required) then a comment to make that clear would be necessa=
ry.

Usual case of: When doing something non obvious with ordering, say why.

>=20
> That said, looking at the only users that care to clear this flag, it loo=
ks like
> they do it before calling free_irq(). Hence, I'm not sure if there's anyt=
hing
> subtle going on. In fact, looking at this line:
>=20
> https://elixir.bootlin.com/linux/latest/source/kernel/irq/manage.c#L1909
>=20
> I'm not so sure we actually need to clear the flag as for these devices, =
we
> should only have one consumer/action per IRQ. Anyways, probably for corre=
ctness
> we should still explicitly clear it?

Good question...  Looks to me like a driver shouldn't be clearing this flag
itself, but it's probably harmless in most cases.

I'd drop the clear of the status flag, perhaps adding a comment that
the irq core does it for us.

Jonathan


>=20
> - Nuno S=C3=A1
>=20

