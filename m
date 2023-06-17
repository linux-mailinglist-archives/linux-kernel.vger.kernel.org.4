Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499CA7342F1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjFQSNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjFQSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751E819A9;
        Sat, 17 Jun 2023 11:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F25BF60A3B;
        Sat, 17 Jun 2023 18:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFBFC433C8;
        Sat, 17 Jun 2023 18:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687025601;
        bh=UGG46jiJltF4eBXxd+Frn0KIaS5+JrvBeE/ODzryDZ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISOmvQ0qwpprpyoMLHwavw1cvuhHjL6ohJNxxsO/lDZFvmwLNt8+b5XA/baClpmdu
         HsTAO/QMHpWrBCvsTAeqBNcyJCGEG05D9md7JvsCKDmkzwl+0nxCkPCCfdxvmLAxoY
         rZHX4jXMp1w2hzh369MMr0/WCFJHDTRE+nxLGi8lrv+Rv4ODTaxSQGNIyH5xzwZmUv
         v9NNnYZfVHQX5SQY7UWP9qWQhta5CtraSrNTO8KFi4ht32adTvlj4r0hg8zZtsUSVw
         f0ltRuCQZJSnc4FzRWsM+49AQqLKCya8voI004sH+F77oVSVDmH54oDn+T6CN/49VC
         TJx2tvTqejZWg==
Date:   Sat, 17 Jun 2023 19:13:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: Simplify using
 devm_clk_get_optional_enabled()
Message-ID: <20230617191314.05f12740@jic23-huawei>
In-Reply-To: <55a46a8cffef60758f0136f389909e307fa1ade4.camel@gmail.com>
References: <7dbe973905f1fdae5d2f5ae5a3b01dd1d6a9925b.1686774340.git.christophe.jaillet@wanadoo.fr>
        <55a46a8cffef60758f0136f389909e307fa1ade4.camel@gmail.com>
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

On Thu, 15 Jun 2023 14:12:57 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-06-14 at 22:26 +0200, Christophe JAILLET wrote:
> > If st->mclk is not NULL, then st->clock_sel is either AD7192_CLK_EXT_MC=
LK2
> > or AD7192_CLK_EXT_MCLK1_2.
> >=20
> > So devm_clk_get_optional_enabled() can be used instead of hand writing =
it.
> > This saves some line of code.
> >=20
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > --- =20
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git but as we are approaching the merge
window I'll be rebasing that on 6.5-rc1 when available.
In meantime pushed out as testing to let 0-day poke at it.

Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/adc/ad7192.c | 16 +---------------
> > =C2=A01 file changed, 1 insertion(+), 15 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 8685e0b58a83..5dcb257ad754 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -972,11 +972,6 @@ static void ad7192_reg_disable(void *reg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regulator_disable(reg);
> > =C2=A0}
> > =C2=A0
> > -static void ad7192_clk_disable(void *clk)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0clk_disable_unprepare(clk);
> > -}
> > -
> > =C2=A0static int ad7192_probe(struct spi_device *spi)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ad7192_state *st;
> > @@ -1044,7 +1039,7 @@ static int ad7192_probe(struct spi_device *spi)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->fclk =3D AD7192_INT=
_FREQ_MHZ;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->mclk =3D devm_clk_get_op=
tional(&spi->dev, "mclk");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->mclk =3D devm_clk_get_op=
tional_enabled(&spi->dev, "mclk");
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(st->mclk))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(st->mclk);
> > =C2=A0
> > @@ -1052,15 +1047,6 @@ static int ad7192_probe(struct spi_device *spi)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (st->clock_sel =3D=
=3D AD7192_CLK_EXT_MCLK1_2 ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->=
clock_sel =3D=3D AD7192_CLK_EXT_MCLK2) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D clk_prepare_enable(st->mclk);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret < 0)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_action_or_reset(&spi->dev, ad7192_clk=
_disable,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->mclk);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (ret)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ret;
> > -
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0st->fclk =3D clk_get_rate(st->mclk);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ad7192_valid_external_frequency(st->fclk)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev_err(&spi->dev, =20
>=20

