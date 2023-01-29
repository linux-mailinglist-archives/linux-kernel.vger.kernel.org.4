Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9767FEA8
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 12:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjA2Ltj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 06:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjA2Lth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 06:49:37 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38D520D10;
        Sun, 29 Jan 2023 03:49:36 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 605B5CD59C;
        Sun, 29 Jan 2023 11:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674992944; bh=+DytX3gjjZuPPIiQNsyksb2H8Iuk01FVUyWItEe4f34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=AWFV76mIjxf9A7AfgNSZhN+k8xt5l2DNlywaRNbOGykObF/hxkcf/9evUNRSvaQYS
         Ov8vw4p8W0KFn2TnPxPE5e2ymENJgHSFxDzOjrY+zccxkc9njbnRIBDwsjDSRWgMQb
         QPtIOT3cnqJkPufWaCCKoyTCIFyJbPf9bCxEfFBs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] media: i2c: ov2685: Make reset gpio optional
Date:   Sun, 29 Jan 2023 12:49:03 +0100
Message-ID: <2543677.Lt9SDvczpP@g550jk>
In-Reply-To: <20230129112249.lf2vb7pthrv4nien@uno.localdomain>
References: <20230129-ov2685-improvements-v1-0-f281bd49399c@z3ntu.xyz>
 <20230129-ov2685-improvements-v1-1-f281bd49399c@z3ntu.xyz>
 <20230129112249.lf2vb7pthrv4nien@uno.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 29. J=E4nner 2023 12:22:49 CET Jacopo Mondi wrote:
> Hi Luca
>=20
> On Sun, Jan 29, 2023 at 10:42:35AM +0100, Luca Weiss wrote:
> > In some setups XSHUTDOWN is connected to DOVDD when it's unused,
> > therefore treat the reset gpio as optional.
>=20
> I don't have a datasheet for this sensor, but OV sensors usually have
> to gpio lines to control powerdown and reset. Datasheets usually
> suggest to hook one of the 2 to DOVDD and control the other from the
> SoC. How is the sensor hooked up in your design ? No gpio lines is
> controlled by the SoC ?

It looks like this sensor only has XSHUTDOWN pin and no extra reset pin.

In my setup there's the normal I2C & CSI & mclk hookups, but the supply lin=
es=20
and shutdown line are all just connected to regulator-fixed, so gpio-
controlled on/off regulators.

>=20
> Another question is if we need to software-reset the sensor if no gpio
> line is hooked up to XSHUTDOWN.

The datasheet mentions it resets itself during power up (so when the suppli=
es=20
are turned on), so I don't think we need to add anything.

Regards
Luca

>=20
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >=20
> >  drivers/media/i2c/ov2685.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/media/i2c/ov2685.c b/drivers/media/i2c/ov2685.c
> > index a3b524f15d89..a422f4c8a2eb 100644
> > --- a/drivers/media/i2c/ov2685.c
> > +++ b/drivers/media/i2c/ov2685.c
> > @@ -734,7 +734,7 @@ static int ov2685_probe(struct i2c_client *client,
> >=20
> >  	if (clk_get_rate(ov2685->xvclk) !=3D OV2685_XVCLK_FREQ)
> >  =09
> >  		dev_warn(dev, "xvclk mismatched, modes are based on=20
24MHz\n");
> >=20
> > -	ov2685->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> > +	ov2685->reset_gpio =3D devm_gpiod_get_optional(dev, "reset",
> > GPIOD_OUT_LOW);>=20
> >  	if (IS_ERR(ov2685->reset_gpio)) {
> >  =09
> >  		dev_err(dev, "Failed to get reset-gpios\n");
> >  		return -EINVAL;
> >=20
> > --
> > 2.39.1




