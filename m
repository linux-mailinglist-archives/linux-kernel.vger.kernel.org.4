Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C756F9898
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjEGNPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjEGNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391059C1;
        Sun,  7 May 2023 06:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A38161BA3;
        Sun,  7 May 2023 13:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EBEC433EF;
        Sun,  7 May 2023 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683465295;
        bh=fYvEHxQMIB0EcK3zgyNt2wrMgeUzXp92rklzMGqAThs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JfBCIRChqqyEAusGtFrq9rrCebvXREKJsHjlPGRJYIdDWeAYwE4IdTxHn7KatpJpC
         ri/mAZnnT86Jjkztls4gwt4V+CgL6q4YE+VVKByuyiT5ucfVRrbZ6Yhtjz5F1P05+9
         F/7jDRLqN0U63FWtV6HnSpaYKq/boUJwZ6+sWY4wxIzZQ4rzz1zhcVZY/8mHfI52Qf
         UvXrQJTsFdvzjx4HYcJHjRFUzPopK0aorrCHmvGCldUWp5oB6Ne8yHm2+7EIXCEq7r
         5RdnE2VxzvyENbofaQrHArLnDIy/Ia35Au1e84/rXoSNLuuMnq/MZW/KB4dreaL9A8
         sKjjoeM6Fadkg==
Date:   Sun, 7 May 2023 14:30:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bu27034: Ensure reset is written
Message-ID: <20230507143049.4407c06e@jic23-huawei>
In-Reply-To: <b8c19793-8650-b997-e868-3efd1e119b9a@gmail.com>
References: <ZFIw/KdApZe1euN8@fedora>
        <20230506192702.57ebf533@jic23-huawei>
        <b8c19793-8650-b997-e868-3efd1e119b9a@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sun, 7 May 2023 12:58:52 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/6/23 21:27, Jonathan Cameron wrote:
> > On Wed, 3 May 2023 13:01:32 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> The reset bit must be always written to the hardware no matter what va=
lue
> >> is in a cache or register. Ensure this by using regmap_write_bits()
> >> instead of the regmap_update_bits(). Furthermore, the RESET bit may be
> >> self-clearing, so mark the SYSTEM_CONTROL register volatile to guarant=
ee
> >> we do also read the right state - should we ever need to read it.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor") =
=20
> >=20
> > This obviously interacts with the regcache update.
> >=20
> > Fun question is whether a register is volatile if it results in all
> > registers (including itself) resetting.  In my view, no it isn't volati=
le.
> > So fixing the regcache stuff as in your other patch is more appropriate=
. =20
>=20
> Hi Jonathan,
>=20
> I think the key thing here is to ensure writing the reset-bit will=20
> always be performed no matter what value is found from cache/hardware. I=
=20
> guess marking the register as volatile is indeed unnecessary, although I=
=20
> don't think it is wrong though, as it underlines we have something=20
> special in this register. However, using the write_bits() instead of=20
> update_bits() is in my opinion very much "the right thing" to do :)

It's a reasonable change, but whether it's fixing a bug is more complex.
If we handle the cache correctly so it always says the bits need writing
then there will be no difference between update_bits() and write_bits().

Meh, better safe than sorry.

Jonathan

>=20
> Yours=C2=B8
> 	-- Matti
>=20
> >=20
> > Jonathan
> >  =20
> >>
> >> ---
> >> Changelog:
> >> v1 =3D> v2:
> >>    - Fix SoB tag
> >>
> >>
> >> I haven't verified if the reset bit is self-clearin as I did temporari=
ly
> >> give away the HW.
> >>
> >> In worst case the bit is not self clearing - but we don't really
> >> get performance penalty even if we set the register volatile because t=
he
> >> SYSTEM_CONTROL register only has the part-ID and the reset fields. The
> >> part-id is only read once at probe.
> >>
> >> ---
> >>   drivers/iio/light/rohm-bu27034.c | 5 ++++-
> >>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm=
-bu27034.c
> >> index 25c9b79574a5..740ebd86b6e5 100644
> >> --- a/drivers/iio/light/rohm-bu27034.c
> >> +++ b/drivers/iio/light/rohm-bu27034.c
> >> @@ -231,6 +231,9 @@ struct bu27034_result {
> >>  =20
> >>   static const struct regmap_range bu27034_volatile_ranges[] =3D {
> >>   	{
> >> +		.range_min =3D BU27034_REG_SYSTEM_CONTROL,
> >> +		.range_max =3D BU27034_REG_SYSTEM_CONTROL,
> >> +	}, {
> >>   		.range_min =3D BU27034_REG_MODE_CONTROL4,
> >>   		.range_max =3D BU27034_REG_MODE_CONTROL4,
> >>   	}, {
> >> @@ -1272,7 +1275,7 @@ static int bu27034_chip_init(struct bu27034_data=
 *data)
> >>   	int ret, sel;
> >>  =20
> >>   	/* Reset */
> >> -	ret =3D regmap_update_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
> >> +	ret =3D regmap_write_bits(data->regmap, BU27034_REG_SYSTEM_CONTROL,
> >>   			   BU27034_MASK_SW_RESET, BU27034_MASK_SW_RESET);
> >>   	if (ret)
> >>   		return dev_err_probe(data->dev, ret, "Sensor reset failed\n");
> >>
> >> base-commit: 7fcbd72176076c44b47e8f68f0223c02c411f420 =20
> >  =20
>=20

