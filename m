Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3596CEFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjC2Qzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjC2Qzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:55:37 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C84EC1;
        Wed, 29 Mar 2023 09:55:26 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 15923C70B4;
        Wed, 29 Mar 2023 16:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1680108895; bh=YO3NMfmF8k8c2SMDbtovBtifO5Xf9pUHpYiPdojn0RE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=E3itYqlMkUsCTXNp/xPm73NIKtrRkqc9OUpdY6rWG0LQ6qw1TQm5QQMrI2Zw56uHp
         Su7YzBHDZfEGyfVTnIX3qFIQ5dlidopybq4MJlcU11OugLXcL18azperBZn/amF2k0
         PRlL+Az4+Kw3BcLBtf1JTuEoGsQpLhF3rGsDoKbw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>, ~postmarketos/upstreaming@lists.sr.ht
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH v2 2/2] leds: aw2013: Add vddio regulator
Date:   Wed, 29 Mar 2023 18:54:54 +0200
Message-ID: <2672233.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <ZB1gNJBFeFSdagF1@gerhold.net>
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <ZByp5gzspOVcYyah@duo.ucw.cz> <ZB1gNJBFeFSdagF1@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 24. M=E4rz 2023 09:32:52 CEST Stephan Gerhold wrote:
> Hi Pavel,
>=20
> On Thu, Mar 23, 2023 at 08:35:02PM +0100, Pavel Machek wrote:
> > > Some LEDs controllers are used with external pull-up for the interrupt
> > > line and the I2C lines, so we might need to enable a regulator to bri=
ng
> > > the lines into usable state. Otherwise, this might cause spurious
> > > interrupts and reading from I2C will fail.
> > >=20
> > > Implement support for "vddio-supply" that is enabled by the aw2013
> > > driver
> > > so that the regulator gets enabled when needed.
> > >=20
> > > Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> > >=20
> > > @@ -348,16 +350,20 @@ static int aw2013_probe(struct i2c_client *clie=
nt)
> > >=20
> > >  		goto error;
> > >  =09
> > >  	}
> > >=20
> > > -	chip->vcc_regulator =3D devm_regulator_get(&client->dev, "vcc");
> > > -	ret =3D PTR_ERR_OR_ZERO(chip->vcc_regulator);
> > > -	if (ret) {
> > > +	chip->regulators[0].supply =3D "vcc";
> > > +	chip->regulators[1].supply =3D "vddio";
> > > +	ret =3D devm_regulator_bulk_get(&client->dev,
> > > +				      ARRAY_SIZE(chip->regulators),
> > > +				      chip->regulators);
> > > +	if (ret < 0) {
> > >=20
> > >  		if (ret !=3D -EPROBE_DEFER)
> > >  	=09
> > >  			dev_err(&client->dev,
> > >  		=09
> > >  				"Failed to request regulator: %d\n",=20
ret);
> > >  	=09
> > >  		goto error;
> >=20
> > Won't this cause failures when optional vddio is unavailable?
>=20
> The regulator core should print a warning "supply vddio not found, using
> dummy regulator" but then proceed normally.
>=20
> I think in almost all cases a separate I/O supply should actually exist
> that could be described in the device tree. It was likely just omitted
> because it's always-on or indirectly being enabled by other devices.
> So perhaps having this warning is even a good thing?

Just briefly jumping in, there was some activity adding bus_regulator to th=
e=20
i2c-core a while back, maybe that can be revived instead? For CCI (camera i=
2c)=20
we also need pull-ups and I don't think adding vddio or whatever to all=20
sensors is a good idea long term...

https://lore.kernel.org/lkml/20210527075556.1709140-1-hsinyi@chromium.org/

Regards
Luca

>=20
> Thanks,
> Stephan




