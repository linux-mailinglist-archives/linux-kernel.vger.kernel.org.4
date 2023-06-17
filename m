Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699B17342E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjFQSK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjFQSKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:10:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88C1736;
        Sat, 17 Jun 2023 11:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5951760B6A;
        Sat, 17 Jun 2023 18:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087AFC433C0;
        Sat, 17 Jun 2023 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687025453;
        bh=+MUxODR25JxS83z5KzVEnmk64ZPPdYw5BmwBRnEkZug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KQ+qvDhZbrqMpK69x38tBJXqGniOYa1aHTkKJ74lnZTxGd8gInXVya1OhDINdqigr
         9VlN4r4kNz1OmbWJ81sCXXanBRteKjaxyqF0QNENKpwdvxpIKdA0EfgbrzoZyVdzxf
         mp+KS5bKbsyQtYpei2gvo38eOMdBDQeRs71L8RkOdcSnBHWLl9q3mUv6K1IV3WLc/O
         zGychfnbi+rhLh+6kvjrRk+Zjhu+eSqo6TqJZgHbSE4KPxDJ93+QMijebn6HlOD7Nb
         xSq6e/WGMI8yRThC4/IhpqRxahs8kBUKqM8KdOZgfX1z35UiMl0L8ynky+uhTr6RsZ
         jN2Lzb3IZwKvA==
Date:   Sat, 17 Jun 2023 19:10:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Alisa Roman <alisa.roman@analog.com>, stable@vger.kernel.org,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7192: Fix ac excitation feature
Message-ID: <20230617191047.51e4852f@jic23-huawei>
In-Reply-To: <b8693c52df5cf520d6994b872bac0768901a0a6d.camel@gmail.com>
References: <20230614155242.160296-1-alisa.roman@analog.com>
        <b8693c52df5cf520d6994b872bac0768901a0a6d.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 13:46:44 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-06-14 at 18:52 +0300, Alisa Roman wrote:
> > AC excitation enable feature exposed to user on AD7192, allowing a bit
> > which should be 0 to be set. This feature is specific only to AD7195. AC
> > excitation attribute moved accordingly.
> >=20
> > In the AD7195 documentation, the AC excitation enable bit is on position
> > 22 in the Configuration register. ACX macro changed to match correct
> > register and bit.
> >=20
> > Note that the fix tag is for the commit that moved the driver out of
> > staging.
> >=20
> > Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
> > Signed-off-by: Alisa Roman <alisa.roman@analog.com>
> > Cc: stable@vger.kernel.org
> > --- =20
>=20
> Hi Alisa,
>=20
> I see you improved the commit message to explain what's going on but you =
should
> have versioned your patches accordingly. Anyways, don't forget to do it n=
ext
> time :). You could also mention the name change AD7192_MODE_ACX ->
> AD7192_CONFIG_ACX even though it's a bit obvious. Anyways:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Hi Alisa,

I've queued this up locally but as we are close to the merge window, my
fixes branch is in the odd state of being ahead of what it's usually based =
on.
As such I won't push it out until post merge window and won't push it out
in the meantime as it would make a mess of linux-next.

For now it's pushed out as fixes-testing so we can get some autobuilder cov=
erage
on it.

Jonathan


>=20
> > =C2=A0drivers/iio/adc/ad7192.c | 16 ++++++++--------
> > =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 8685e0b58a83..7bc3ebfe8081 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -62,7 +62,6 @@
> > =C2=A0#define AD7192_MODE_STA_MASK=C2=A0=C2=A0=C2=A0BIT(20) /* Status R=
egister transmission Mask
> > */
> > =C2=A0#define AD7192_MODE_CLKSRC(x)=C2=A0=C2=A0(((x) & 0x3) << 18) /* C=
lock Source Select */
> > =C2=A0#define AD7192_MODE_SINC3=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(=
15) /* SINC3 Filter Select */
> > -#define AD7192_MODE_ACX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(14) /* AC excitation=
 enable(AD7195
> > only)*/
> > =C2=A0#define AD7192_MODE_ENPAR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(=
13) /* Parity Enable */
> > =C2=A0#define AD7192_MODE_CLKDIV=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(12) /=
* Clock divide by 2 (AD7190/2 only)*/
> > =C2=A0#define AD7192_MODE_SCYCLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(11) /=
* Single cycle conversion */
> > @@ -91,6 +90,7 @@
> > =C2=A0/* Configuration Register Bit Designations (AD7192_REG_CONF) */
> > =C2=A0
> > =C2=A0#define AD7192_CONF_CHOP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0BIT(23) /* CHOP enable */
> > +#define AD7192_CONF_ACX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(22) /* AC excitation=
 enable(AD7195
> > only) */
> > =C2=A0#define AD7192_CONF_REFSEL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(20) /=
* REFIN1/REFIN2 Reference Select */
> > =C2=A0#define AD7192_CONF_CHAN(x)=C2=A0=C2=A0=C2=A0=C2=A0((x) << 8) /* =
Channel select */
> > =C2=A0#define AD7192_CONF_CHAN_MASK=C2=A0=C2=A0(0x7FF << 8) /* Channel =
select mask */
> > @@ -472,7 +472,7 @@ static ssize_t ad7192_show_ac_excitation(struct dev=
ice
> > *dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct iio_dev *indio_d=
ev =3D dev_to_iio_dev(dev);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct ad7192_state *st=
 =3D iio_priv(indio_dev);
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sysfs_emit(buf, "%d\n=
", !!(st->mode & AD7192_MODE_ACX));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return sysfs_emit(buf, "%d\n=
", !!(st->conf & AD7192_CONF_ACX));
> > =C2=A0}
> > =C2=A0
> > =C2=A0static ssize_t ad7192_show_bridge_switch(struct device *dev,
> > @@ -513,13 +513,13 @@ static ssize_t ad7192_set(struct device *dev,
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, s=
t->gpocon);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case AD7192_REG_MODE:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case AD7192_REG_CONF:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (val)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->mo=
de |=3D AD7192_MODE_ACX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->co=
nf |=3D AD7192_CONF_ACX;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->mo=
de &=3D ~AD7192_MODE_ACX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->co=
nf &=3D ~AD7192_CONF_ACX;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> > @@ -579,12 +579,11 @@ static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
> > =C2=A0
> > =C2=A0static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ad7192_show=
_ac_excitation, ad7192_set,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7192_REG_MODE);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD7192_REG_CONF);
> > =C2=A0
> > =C2=A0static struct attribute *ad7192_attributes[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_filter_lo=
w_pass_3db_frequency_available.dev_attr.attr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_bridge_sw=
itch_en.dev_attr.attr,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_ac_excitation_=
en.dev_attr.attr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
> > =C2=A0};
> > =C2=A0
> > @@ -595,6 +594,7 @@ static const struct attribute_group ad7192_attribut=
e_group
> > =3D {
> > =C2=A0static struct attribute *ad7195_attributes[] =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_filter_lo=
w_pass_3db_frequency_available.dev_attr.attr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_bridge_sw=
itch_en.dev_attr.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_ac_excitation_=
en.dev_attr.attr,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL
> > =C2=A0};
> > =C2=A0 =20
>=20

