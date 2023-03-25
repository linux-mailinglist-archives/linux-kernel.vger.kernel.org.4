Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB26C8FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCYRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjCYRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:51:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5A3E061;
        Sat, 25 Mar 2023 10:51:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C409B80765;
        Sat, 25 Mar 2023 17:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958F1C433D2;
        Sat, 25 Mar 2023 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679766662;
        bh=A0ZEryuZcCUzo64iHVo2sKnsKBltVNrothHprfklDdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z7/EWci+Rz6krYV0id8wzgsM6Xx4Ky6R6DPbJhLcw4ajbKdMeOX82+0/Ozl2rjQRd
         gG8PNrjoT8V3vcjkp9Bi9/k6j6U2Ye0JRHAjoFhnyu2XDvcFy8mkfJsU48Z195FrHk
         5HlfXGweGFP3tnkTii3fTSS+JFOmExAGP8N7/7c7zDJ7oVM3p0v0lY5qx/QRl8gjNp
         jdlFly73KURmfgb0XrPVVeffqsqZlLO61cNIL02lMYRr6QlyUbTU0RSzzPbkhfvYx8
         WshXA29eW65wym7FSvRX+xA7lLAxnD+RwoMsZn7rqWBK0owUiDqFSOae04ynbApJrW
         oQt9K4kjN4Jtg==
Date:   Sat, 25 Mar 2023 18:06:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <Marius.Cristea@microchip.com>
Cc:     <devicetree@vger.kernel.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for pac193x
Message-ID: <20230325180604.2bee86c2@jic23-huawei>
In-Reply-To: <0e6ed004f296cd0a756711d5576d8a6d8129cbc0.camel@microchip.com>
References: <20230220123232.413029-1-marius.cristea@microchip.com>
        <20230220123232.413029-3-marius.cristea@microchip.com>
        <20230225192701.79df7fd0@jic23-huawei>
        <807dc4f8d30f6b20a81e64ef4ae72fb9741e16a3.camel@microchip.com>
        <20230312164255.13f444b2@jic23-huawei>
        <0e6ed004f296cd0a756711d5576d8a6d8129cbc0.camel@microchip.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 15:15:18 +0000
<Marius.Cristea@microchip.com> wrote:

> On Sun, 2023-03-12 at 16:42 +0000, Jonathan Cameron wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >  =20
> > >  =20
> > > >=20
> > > >=20
> > > >  =20
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 len +=3D sprintf(buf, "%u\n", chip_info=
->shunts[target]);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return len;
> > > > > +}
> > > > > +
> > > > > +static ssize_t channel_name_show(struct device *dev, =20
> > > >=20
> > > > Looks like per channel label support provided by the read_label
> > > > iio_info callback.
> > > >  =20
> > >=20
> > > I was trying to use the read_label iio_info callback but I end it
> > > up
> > > into a sysfs error related to duplicated labels. =20
> >=20
> > That's interesting.=C2=A0 Can you provide more info on that. I'd like to
> > understand why that's happening to you.
> >  =20
>=20
> I have add the ".read_label" and the function asociated with it to the
> driver but here is the error:
>=20
> root@sama5d27-wlsom1-ek-sd:~/work/pac193x# insmod pac1934.ko
> pac193x 1-001c: :pac193x_prep_iio_channels: Channel 2 active
> pac193x 1-001c: :pac193x_prep_iio_channels: Channel 3 active
> pac193x 1-001c: :pac193x_prep_iio_channels: Channel 4 active
> iio iio:device1: tried to double register : in_voltage2_label
> pac193x 1-001c: Failed to register sysfs interfaces
> iio iio:device1: error -EBUSY: Can't register IIO device
> pac193x: probe of 1-001c failed with error -16
>=20

There can only be one registered iio_chan_spec entry for a given
group of direction, type, channel, modifier (channel and modifier can
be optional). This comes from inherent design restrictions of the
events.  Now I think what has happened here is that you are
registering both _VBUS_CHANNEL and _VBUS_AVG channel with the
same index. You can't do that.  Whilst you don't currently have events,
if they come along later there will be no way to distinguish those
two.

So either roll them into one iio_chan_spec, or give them different
index values.

>=20
>=20
> Here are the list of files in case I don't use read_label (only
> physical channels 2 to 4 are available):
>=20
> root@sama5d27-wlsom1-ek-sd:~/work/pac193x# ls
> /sys/bus/iio/devices/iio\:device1/
> channel_name_2        in_current4_mean_raw  in_power2_raw        =20
> in_voltage2_scale     power
> channel_name_3        in_current4_raw       in_power2_scale      =20
> in_voltage3_mean_raw  reset_accumulators
> channel_name_4        in_current4_scale     in_power3_raw        =20
> in_voltage3_raw       sampling_frequency_available
> in_current2_mean_raw  in_energy2_raw        in_power3_scale      =20
> in_voltage3_scale     shunt_value_2
> in_current2_raw       in_energy2_scale      in_power4_raw        =20
> in_voltage4_mean_raw  shunt_value_3
> in_current2_scale     in_energy3_raw        in_power4_scale      =20
> in_voltage4_raw       shunt_value_4
> in_current3_mean_raw  in_energy3_scale      in_sampling_frequency=20
> in_voltage4_scale     subsystem
> in_current3_raw       in_energy4_raw        in_voltage2_mean_raw   name
> uevent
> in_current3_scale     in_energy4_scale      in_voltage2_raw      =20
> of_node               waiting_for_supplier
>=20
>=20
>=20
> > >=20
> > > Also I'm not sure if this read_label will help me in the end. What
> > > I
> > > was aiming to obtain here with the "channel_name_show" and the
> > > custom
> > > IIO attribute was to have "an umbrella" name/label for multiple IIO
> > > channels. For example on physical "channel 1" we will measure the
> > > voltage, the current and the power because all of those IIO
> > > channels
> > > will point to one board power supply (like VDD, VIO, V_GPU, V_DDR,
> > > etc). =20
> >=20
> > That should be possible with read_label as it's free form text.
> > Perhaps I'm missing why that doesn't provide enough information for
> > what
> > you need.
> >  =20
> > >  =20
>=20
> It seems it does more that I need. My concern is that the read_label
> will do a label for all available channels (like _raw or scale_ will
> do) and I want to  have just up to a maximum of 4 labels each one will
> cover the multiple entries (e.g.: channel_name_2 will be a umbrela
> "label" for:
> in_power2_raw         in_voltage2_scale  in_power2_scale       =20
> in_current2_mean_raw  in_energy2_raw     shunt_value_2
> in_current2_raw       in_energy2_scale   in_current2_scale    =20
> in_voltage2_mean_raw  in_voltage2_raw

Whilst it might not be ideal, label is standard ABI that normal code
is going to know how to use.  channel_name_2 is custom ABI that only
code written against this one driver will use.

So go with the label version and don't worry about the duplication.

The association you are building between channel indexes is also unique
to this driver, so you should not rely on that as generic code will not
know that all the things numbered 2 refer to a particular set of inputs.

If each channel has a _label and those match, that association is explicit.

Channel numbers shouldn't really mean anything on their own.

>=20
> > >=20
> > >=20
> > >=20
> > >  =20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_attribute *attr,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *buf)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D dev_to_ii=
o_dev(dev);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct pac193x_chip_info *chip_info =3D
> > > > > iio_priv(indio_dev);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int len =3D 0;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int target =3D (int)(attr->attr.name[st=
rlen(attr- =20
> > > > > >attr.name) - =20
> > > > > 1] - '0') - 1;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 len +=3D sprintf(buf, "%s\n", chip_info=
- =20
> > > > > > channel_names[target]); =20
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return len;
> > > > > +}
> > > > > +
> > > > > +static ssize_t shunt_value_store(struct device *dev, =20
> > > >=20
> > > > Shunt values aren't normally dynamic.=C2=A0 Why do you need to write
> > > > it
> > > > from
> > > > userspace? I'd expect that to come from firmware.
> > > >=20
> > > > If it's needed the ext_info framework might be a better fit than
> > > > direct implementation of the attribute. =20
> > >=20
> > >=20
> > > Yes, usually the shunt aren't normally dynamic, but what I'm aiming
> > > to
> > > get here is to let the user to overwrite the value after a
> > > calibration
> > > of the system. This will improve the accuracy of the reading even
> > > in
> > > the case the shunts are not of high precision ones. =20
> >=20
> > I'll go with maybe on this.=C2=A0 Perhaps not a feature for the initial
> > version of the driver, but one that is better to discuss in a follow
> > up thread along with details of the expected calibration process etc. =
=20
> > >  =20
>=20
> Calibration process could be easly be done. Just think that we have a
> linux board that measure some dinamic load that uses a connector. The
> load could be easily changed by the user with a "calibrated" load, read
> the measurement do the math expected versus read values and update the
> shunt value. Those values needs to be stored by the user somewhere to
> be reused after a reboot. After the board is calibrated a "normal" load
> could pluged in (one example is to monitor the charge/discharge current
> of a battery).

OK. I'd still advise postponing control of this.  It's unusual and likely
to delay / distract from review of the rest of the driver.

Jonathan


