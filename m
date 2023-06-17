Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A267773436F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjFQUHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjFQUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6796BB2;
        Sat, 17 Jun 2023 13:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0028E60B2C;
        Sat, 17 Jun 2023 20:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF954C433C8;
        Sat, 17 Jun 2023 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687032431;
        bh=akUaIhagBcheMMLkG/7LBKRbSkqRUijdxyGkrwPVDr0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bAxpYRUC4lZprbJCp81S5RRf0u2D0S1f/fMGvnVAB+zygd2WT7pmA6APGe1teSDqt
         XKPOD1zUbhMFLrLZanvb8Anbj367cMyHZ92M+00ps0ejbMK1adQl1ov6Y9blEfAI/T
         vvR0WL0vy8HYnoeb0pwaeeGtxSA3kgRViMzYuoR2BK9LBjTryJ8wOdQSPIsBhhJXCu
         G5NbyXdphy1Af85mGhOKuk7Y82Iw8kzxVtJzP64Jh3PdNn4Qj3HZYmaxH2mXMDVHxL
         oCalc+H6WNnnLieSWTcbsmgexXfq33St9mvgv4/4MnEu6zQ80N0bX6RXJTSAvWkwd0
         Z0q7ZwLgz7CFA==
Date:   Sat, 17 Jun 2023 21:06:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Leonard =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs
 GPADC
Message-ID: <20230617210658.43d5b787@jic23-huawei>
In-Reply-To: <CALHCpMgxNwz197qgiEueV9Y26LN7BBfYSGBHy6J4gOTFpiVUtw@mail.gmail.com>
References: <20230615205540.1803975-1-bigunclemax@gmail.com>
        <20230615205540.1803975-2-bigunclemax@gmail.com>
        <20230617144855.0388c4ff@jic23-huawei>
        <CALHCpMgxNwz197qgiEueV9Y26LN7BBfYSGBHy6J4gOTFpiVUtw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023 21:52:12 +0300
Maxim Kiselev <bigunclemax@gmail.com> wrote:

> =D1=81=D0=B1, 17 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 16:49, J=
onathan Cameron <jic23@kernel.org>:
> >
> > On Thu, 15 Jun 2023 23:55:20 +0300
> > Maksim Kiselev <bigunclemax@gmail.com> wrote:
> > =20
> > > The General Purpose ADC (GPADC) can convert the external signal into
> > > a certain proportion of digital value, to realize the measurement of
> > > analog signal, which can be applied to power detection and key detect=
ion.
> > >
> > > Theoretically, this ADC can support up to 16 channels. All SoCs below
> > > contain this GPADC IP. The only difference between them is the number
> > > of available channels:
> > >
> > >  T113 - 1 channel
> > >  D1   - 2 channels
> > >  R329 - 4 channels
> > >  T507 - 4 channels
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > > ---
> > >  drivers/iio/adc/Kconfig            |  10 ++
> > >  drivers/iio/adc/Makefile           |   1 +
> > >  drivers/iio/adc/sun20i-gpadc-iio.c | 276 +++++++++++++++++++++++++++=
++
> > >  3 files changed, 287 insertions(+)
> > >  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index eb2b09ef5d5b..deff7ae704ce 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -1123,6 +1123,16 @@ config SUN4I_GPADC
> > >         To compile this driver as a module, choose M here: the module=
 will be
> > >         called sun4i-gpadc-iio.
> > >
> > > +config SUN20I_GPADC
> > > +     tristate "Support for the Allwinner SoCs GPADC" =20
> > I applied this and started a build test before noticing that this Kconf=
ig description
> > is very vague and matches the one for the existing 4i driver... =20
>=20
> Indeed. I must have forgotten to change this line when copying from sun4i=
...
>=20
> > The 'Support for the' bit also isn't appropriate for what you see in ma=
ke menuconfig
> > menu etc.   Please come up with something descriptive. Maybe
> > "sun20i and similar SoC GPADC"?
> >
> > Bonus points if you change the text for the 4i at the same time to be
> > more meaningful. I clearly missed that in review a long time ago! =20
>=20
> Should I do this in a separate patch?
Yes please.

Thanks,

Jonathan


