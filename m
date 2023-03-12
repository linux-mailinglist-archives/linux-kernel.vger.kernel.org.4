Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF39A6B6855
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCLQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCLQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF133C7B7;
        Sun, 12 Mar 2023 09:42:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9453F60F70;
        Sun, 12 Mar 2023 16:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95577C433EF;
        Sun, 12 Mar 2023 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678639369;
        bh=j+1l53CGW5jpoXO3iQkjOW1JD5aTXiz5LKWx3VCILmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=srcg4p6jQmhgQb3eijmYYWoEk20qT9kCf1rNlI5KI808t6G7nGzzlOfgBrjXbn7Do
         rdrAX76aKrCjDGYAnPcemjlH6t+RC2cBdsWofzbNA6aS+Yz3WmAnrhPVc+NjOjh/KV
         /y1XXHbEmmhfdkkAc+sbsHIiTNIaW6mxzVPLBdFZd9BjghZQK37DuCRvgeAxMOolYt
         sCAz5f/aU7G/C5Dgxqyv043S7gL7cgZZceuVmz0tHIcDzSkSaOwGv5uLqV30yQdlHo
         XqQ5ClRHOR1nBQCy6YARJLuTuSibTDuuILDRE/kVqbjaOG8fwkQRF1ERNPuQZKWmQy
         QmbjaQk9HfZjg==
Date:   Sun, 12 Mar 2023 16:42:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <20230312164255.13f444b2@jic23-huawei>
In-Reply-To: <807dc4f8d30f6b20a81e64ef4ae72fb9741e16a3.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-3-marius.cristea@microchip.com>
        <20230225192701.79df7fd0@jic23-huawei>
        <807dc4f8d30f6b20a81e64ef4ae72fb9741e16a3.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> >=20
> >=20
> >  =20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 len +=3D sprintf(buf, "%u\n", chip_info->sh=
unts[target]);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return len;
> > > +}
> > > +
> > > +static ssize_t channel_name_show(struct device *dev, =20
> >=20
> > Looks like per channel label support provided by the read_label
> > iio_info callback.
> >  =20
>=20
> I was trying to use the read_label iio_info callback but I end it up
> into a sysfs error related to duplicated labels.

That's interesting.  Can you provide more info on that. I'd like to
understand why that's happening to you.

>=20
> Also I'm not sure if this read_label will help me in the end. What I
> was aiming to obtain here with the "channel_name_show" and the custom
> IIO attribute was to have "an umbrella" name/label for multiple IIO
> channels. For example on physical "channel 1" we will measure the
> voltage, the current and the power because all of those IIO channels
> will point to one board power supply (like VDD, VIO, V_GPU, V_DDR,
> etc).

That should be possible with read_label as it's free form text.
Perhaps I'm missing why that doesn't provide enough information for what
you need.

>=20
>=20
>=20
>=20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D dev_to_iio_de=
v(dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct pac193x_chip_info *chip_info =3D iio=
_priv(indio_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int len =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int target =3D (int)(attr->attr.name[strlen=
(attr->attr.name) -
> > > 1] - '0') - 1;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 len +=3D sprintf(buf, "%s\n", chip_info- =20
> > > >channel_names[target]); =20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return len;
> > > +}
> > > +
> > > +static ssize_t shunt_value_store(struct device *dev, =20
> >=20
> > Shunt values aren't normally dynamic.=C2=A0 Why do you need to write it
> > from
> > userspace? I'd expect that to come from firmware.
> >=20
> > If it's needed the ext_info framework might be a better fit than
> > direct implementation of the attribute. =20
>=20
>=20
> Yes, usually the shunt aren't normally dynamic, but what I'm aiming to
> get here is to let the user to overwrite the value after a calibration
> of the system. This will improve the accuracy of the reading even in
> the case the shunts are not of high precision ones.

I'll go with maybe on this.  Perhaps not a feature for the initial
version of the driver, but one that is better to discuss in a follow
up thread along with details of the expected calibration process etc.

>=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PAC193X_VPOWER_=
4_ADDR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D chip_info- =20
> > > >chip_reg_data.vpower[channel]; =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case IIO_ENERGY:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->addres=
s) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PAC193X_VPOWER_=
ACC_1_ADDR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PAC193X_VPOWER_=
ACC_2_ADDR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PAC193X_VPOWER_=
ACC_3_ADDR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PAC193X_VPOWER_=
ACC_4_ADDR:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * expresses the 64 bit energy value
> > > as a 32 bit integer part and
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 32 bits (representing 8 digits)
> > > fractional value =20
> >=20
> > I'm lost.=C2=A0 So it's a 64 bit value?
> > We have IIO_VAL_INT_64. Does that not work here?
> >  =20
>=20
> Yes, we have the IIO_VAL_INT_64 and it will work here. The "issue" was
> that the IIO_VAL_INT_64 is not available before kernel v6.0 and we
> already release something to customers supporting Linux kernel v4.7 and
> v5.15. Also our latest release of Linux4Sam is based on the Linux
> kernel v5.15 (we are working to have a release based on v6.1).
>=20
> Maybe I'm totally wrong here but my idea was to have something "more
> generic" that could be easily backported to an older kernel and to
> change this to IIO_VAL_INT_64 later.=20

As a general rule, we don't do this because it stops us from ever
improving things like this.  If you need IIO_VAL_INT_64 on
an older kernel then backport that as well.  Or provide a backported
version of your driver doing something different from upstream version.


>=20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 curr_energy =3D chip_info- =20
> > > >chip_reg_data.energy_sec_acc[channel]; =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int_part =3D div_s64_rem(curr_energy,
> > > 100000000, &rem);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* rescale reminder to be printed as
> > > "nano" value */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 rem =3D rem * 10;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D int_part;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D rem;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT_PLUS_NANO;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_AVERAGE_RAW: =20
> >=20
> > I'd forgotten we had this ABI and had to look up the docs.=C2=A0=C2=A0 =
Hmm.
> > It's a bit clunky but I guess
> > still useful in this case.=C2=A0 Longer term we should think about how =
to
> > describe that and how it
> > is different from oversampling. The problem with oversampling is it
> > affects the main channel
> > so we can't easily associate both an averaged value=C2=A0 and a raw one
> > like you have here.
> >=20
> > Given lots of other changes requested and early in this kernel cycle,
> > perhaps it will make sense to revisit
> > this question at a later version of this patch (or maybe just leave
> > it alone as too hard
> > to do better!) =20
>=20
>=20
> Here I was trying to map the IIO ABI to the PAC internal registers. We
> have some hardware registers that will do an average for us. Usually
> with oversampling someone could increase the bit number of the
> measurement, the average is just the sum of the numbers divided by how
> many numbers are and it can eliminate some noise out of the
> measurements.
>=20
>=20
> Here the device has registers that will keep the current values (and
> will calculate the power based on those values) and also some average
> measurements registers (keeping the same precision) that could help the
> user to identifies trends.

Understood. It was similar hardware that lead to this ABI existing
in the first place.  Whilst you are right that the purpose is somewhat
different.  In some cases oversampling in hardware doesn't increase the
bit depth and ends up looking much the same as an average.

>=20
>=20
> >  =20
>=20
>=20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ctrl_reg =3D PAC193X_CRTL_SAMPLE_RATE_SET(chip_info- =20
> > > >crt_samp_spd_bitfield) | =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PAC193X_CHAN_ALERT_E=
N;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ret =3D pac193x_i2c_write_byte(client,
> > > PAC193X_CTRL_REG, ctrl_reg);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&client->dev=
, "%s - can't update
> > > sample rate\n", __func__);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip_info->sample_ra=
te_value =3D old_samp_rate;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&chip_i=
nfo->lock); =20
> >=20
> > Fun thing about i2c bus write failures. You have no idea what failed.
> > The value might be
> > the old value or the new one after the failed write... So normally we
> > don't bother too much if our values are
> > out of sync. and that leads to easier unwinding.=C2=A0 However, if you
> > want to keep this as it
> > is then that's fine.
> >  =20
>=20
>=20
> I would like to keep it, maybe there are some corner cases when it will
> help debugging (good to know in case of intermittent issues)

I'm fine seeing the error print, but unless you succesfully hammer back in
the old value with a new write, you have no guarantee of what the device
thinks the value is.


> >=20
> >=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int revision,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int function)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_buffer buffer =3D {ACPI_ALLOCAT=
E_BUFFER, NULL};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 union acpi_object args[PAC193X_ACPI_ARG_COU=
NT];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_object_list args_list;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uuid_t uuid;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 uuid_parse(PAC193X_DSM_UUID, &uuid);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[0].type =3D ACPI_TYPE_BUFFER;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[0].buffer.length =3D sizeof(struct pac=
193x_uuid_format);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[0].buffer.pointer =3D (u8 *)&uuid;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[1].type =3D ACPI_TYPE_INTEGER;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[1].integer.value =3D revision;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[2].type =3D ACPI_TYPE_INTEGER;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[2].integer.value =3D function;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[3].type =3D ACPI_TYPE_PACKAGE;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args[3].package.count =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args_list.count =3D PAC193X_ACPI_ARG_COUNT;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 args_list.pointer =3D &args[0];
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 status =3D acpi_evaluate_object(handle, "_D=
SM", &args_list,
> > > &buffer);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_FAILURE(status)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 kfree(buffer.pointer);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return buffer.pointer;
> > > +}
> > > +
> > > +static char *pac193x_acpi_get_acpi_match_entry(acpi_handle handle)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 acpi_status status;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 union acpi_object *name_object;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_buffer buffer =3D {ACPI_ALLOCAT=
E_BUFFER, NULL};
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 status =3D acpi_evaluate_object(handle, "_H=
ID", NULL, &buffer);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 name_object =3D buffer.pointer;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return name_object->string.pointer;
> > > +}
> > > +
> > > +static const char *pac193x_match_acpi_device(struct i2c_client
> > > *client,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pac193x_chip_info
> > > *chip_info)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 char *name;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 acpi_handle handle;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 union acpi_object *rez;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 unsigned short bi_dir_mask;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int idx, i;
> > > + =20
> >=20
> > Any docs for the ACPI stuff?
> > It looks plausible, but an example DSDT blob would make it easier to
> > review.
> >  =20
>=20
> Here we have:
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Applicatio=
nNotes/ApplicationNotes/PAC193X-Integration-Notes-for-Microsoft-Windows-10-=
and-Windows-11-Driver-Support-DS00002534.pdf
Yikes that's a long file name ;)  Exactly what I was looking for. Thanks.

Please add that link to the driver somewhere.  + ignore the inevitable
checkpatch warning on line length.

>=20
>=20
> >=20
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * count how many channels are enabled=
 and store
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * this information within the driver =
data
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 cnt =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 chip_info->chip_reg_data.num_enabled_channe=
ls =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 while (cnt < chip_info->phys_channels) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (chip_info->active_channels[cnt])
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chip_info- =20
> > > >chip_reg_data.num_enabled_channels++; =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 cnt++;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read whatever information was gathe=
red before the driver
> > > was loaded
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * establish which channels are enable=
d/disabled and then
> > > establish the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * information retrieval mode (using S=
KIP or no). =20
> >=20
> > It's unusual to have a driver carry on with existing values.=C2=A0 Much
> > more common
> > to either have it reset the device (to known default state) or write
> > all the
> > registers if such a reset doesn't exist.
> >=20
> > One reason for that flow is that we really don't trust other software
> > :)
> > Another is that often we don't know if the device had any power until
> > we turned it
> > on.=C2=A0 So it's much easier to review code where we control all the
> > state.
> >=20
> > If there is a strong reason for carrying on with existing settings
> > please add
> > comments here and something to the patch description to point out
> > this unusual
> > behaviour.
> >  =20
>=20
> There are some customers asking to measure the total power exchanged
> from the power-up of the system (like if you are spending a lot of time
> into the bootloader and drain the battery).

Ok. Add a comment on that.


>=20
>=20
>=20
>=20
> >=20
> >=20
> >=20
> >  =20
> > > shunt_value_store, 0);
> > > +static IIO_DEVICE_ATTR(shunt_value_2, 0644, shunt_value_show,
> > > shunt_value_store, 0);
> > > +static IIO_DEVICE_ATTR(shunt_value_3, 0644, shunt_value_show,
> > > shunt_value_store, 0);
> > > +static IIO_DEVICE_ATTR(shunt_value_4, 0644, shunt_value_show,
> > > shunt_value_store, 0);
> > > +
> > > +static IIO_DEVICE_ATTR(channel_name_1, 0444, channel_name_show,
> > > NULL, 0);
> > > +static IIO_DEVICE_ATTR(channel_name_2, 0444, channel_name_show,
> > > NULL, 0);
> > > +static IIO_DEVICE_ATTR(channel_name_3, 0444, channel_name_show,
> > > NULL, 0);
> > > +static IIO_DEVICE_ATTR(channel_name_4, 0444, channel_name_show,
> > > NULL, 0);
> > > +
> > > +static IIO_DEVICE_ATTR(reset_accumulators, 0200, NULL,
> > > reset_accumulators_store, 0);
> > > +
> > > +static struct attribute *pac193x_all_attributes[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 PAC193X_DEV_ATTR(shunt_value_1), =20
> >=20
> > These all need ABI documentation so that we can easily review what
> > they do.
> > Documenation/ABI/testing/sysfs-bus-iio-pac1931
> > Note that if they overlap with ABI used elsewhere we may need to move
> > it to a more
> > generic place (there can't be two lots of docs for the same ABI
> > element)
> >  =20
>=20
> I will add comments into the code. The "shunt_value_show" will print
> the shunt value used to calculate current and power.
I'd prefer handling shut calibration as a future patch because it needs
some thought and discussion + may delay the rest of the driver.  Without th=
at
ability to tweak it I'm not sure it provides value to be able to read
it now.  =20

> The "channel_name_show" is the name of the device channel used to
> easily identify what we are measuring (V_DDR, V_GPU, V_IO, etc) and
> it's an "umbrella" for multiple IIO measurements (voltage, current and
> power)

As above. I'd like to think a bit more on this one.

>=20
> "reset_accumulators" will help the user to reinitialize the power on
> all channels.

This sounds like the rare case where the ENABLE IIO ABI may fit.
We use that for things like step counters that also accumulate over
time.  If we can use that, I'd prefer it to custom ABI.

>=20
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!indio_dev) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_err_probe(&indio_dev->dev, PTR_ERR(indio_dev),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "Can't allocate iio device\n");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -ENOMEM;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 chip_info =3D iio_priv(indio_dev);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 i2c_set_clientdata(client, indio_dev); =20
> >=20
> > Assuming you follow suggestion to go fully devm managed handling of
> > remove, I don't htink
> > you will need this.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 chip_info->client =3D client;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 memset(&chip_info->chip_reg_data, 0, sizeof=
(chip_info- =20
> > > >chip_reg_data)); =20
> >=20
> > The iio_priv space is allocated with kzalloc so no need to zero here.
> >  =20
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_HANDLE(&client->dev)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pac193x_get_variant(chip_info); =20
> >=20
> > Why is this ACPI specific? =20
>=20
> Not really. I will change it to work in both cases.
>=20
> >=20
> > If you can query the variant from the hardware, that is the right
> > thing to use
> > for all registration types.=C2=A0 It can be helpful to call out if there
> > is
> > a mismatch though with a warning print, so comparing the result of
> > the i2c call with the data is fine.
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 dev_id =3D id->driver_data;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* store the type of chip */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip_info->chip_variant =3D dev_id;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* get the maximum number of channels for the given
> > > chip id */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 chip_info->phys_channels =3D
> > > pac193x_chip_config[dev_id].phys_channels;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * load default settings - all channel=
s disabled,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uni directional flow, default shunt=
 values =20
> >=20
> > The concept of a default shunt value bothers me a little if this is
> > an external resistor.=C2=A0 How is there in any real sense a default?
> > Can we just fail if it's not provided - or wrap the default up for
> > just ACPI case where I guess there might be firmware that doesn't
> > specify it? =20
>=20
> I'm doing some math with that resistor later in code and I was just
> making sure that I will not divide by 0, but indeed I could just exit
> in case the value is not correctly set.

Exit is best thing to do I think.

Jonathan

>=20
> >  =20
>=20
> Thanks,
> Marius
>=20

