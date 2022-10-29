Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDBD6122C6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJ2MHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJ2MHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C1517E0A;
        Sat, 29 Oct 2022 05:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD2F60302;
        Sat, 29 Oct 2022 12:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63D7C433C1;
        Sat, 29 Oct 2022 12:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667045251;
        bh=rZBl8vPaW6vF47o4StNTRLw3qNIIbu2NPnD0TsE5sN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SgxkkNam5AGLJrhX48p9t6smutgOCQsAQoBZkcLdjwOHOQKNsKdTaanxzuObnVMVs
         JbGxWBHeMr9wxyuAkLSfltGy+5h4PUQvEME9Q80zJIeu/I7mJxP5YmedOYhBqGswuK
         6PlaiNkey3eolCTpbuRyei5zcq9tDrGEBlJ7fWggYobvwsMkgHlkEmaVfsxLBWeEEz
         jf1rNC38TQPe7Z+CyxNn3+r5/Cvd0xHkRKMEMwT8uMp10fbx2TvSWnqLXH77hZTjwa
         zxRB/pHy2OPTMcfMu27kXACU1yvi7DytCObaigMTJHCRSRU4MsQYVOMU6gXhTDfZ4z
         EpQ8Te2E+RqPw==
Date:   Sat, 29 Oct 2022 13:19:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221029131925.2f24f91c@jic23-huawei>
In-Reply-To: <CO1PR11MB4835CE4FCA85B0108CABF37A96319@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20221024165658.181340-1-rajat.khandelwal@linux.intel.com>
        <20221024112829.GA2807876@roeck-us.net>
        <CO1PR11MB483509CDD93AFA3176C42080962E9@CO1PR11MB4835.namprd11.prod.outlook.com>
        <20221024183148.GA3170088@roeck-us.net>
        <CO1PR11MB4835CE4FCA85B0108CABF37A96319@CO1PR11MB4835.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 05:40:36 +0000
"Khandelwal, Rajat" <rajat.khandelwal@intel.com> wrote:

> Hi Guenter,
> Thanks for the acknowledgement and your comments.=20
>=20
> >That is your use case. I don't know how IIO drivers are normally impleme=
nted, but I would expect a generic driver. In this case, I would expect >us=
erspace to decide what it wants to with the data and not let the kernel dri=
ver discard most of it. =20
> So, essentially, this driver is not discarding but there is no way to get=
 to the recent most reading without popping all the values
> before it. Call it a device limitation? Hence, if FIFO contains more than=
 1 reading, there is no other way than to pop out all
> the values before the recent most to get there.
>=20
> > What does that have to do with interrupts ? Anything connected to the g=
pio pin would trigger a reading. =20
> Yes that=E2=80=99s correct. However, I intend to give out all readings in=
 the FIFO through a defined user space attribute so that user can check all
> the triggered conversions instead of popping out and only reading the mos=
t recent one.=20

Don't invent new ABI - use the buffered interface in IIO as all the other d=
evices with Fifos do.
Fine not doing that in first version of the driver however and just reporti=
ng most
recent value.

> I am thinking of doing this via ACPI GPIO interrupt which stores values i=
n a kernel data structure whenever triggered and a user space
> attribute printing out all of them.=20

This is all handled by standard IIO driver interfaces.  Just look for anoth=
er
device with a fifo - there are lots of them.

>=20
> > It seems to me that this would warrant an explanation in the driver.
> >500ms seems hard to believe. =20
> Yes, I proofread the spec many times to give a reasoning behind this. All=
 I could find is this in the datasheet:
> Response Time TA =3D +0=C2=B0C to +50=C2=B0C Unmounted, 63% (Note 2) 0.5s
> I assumed this response time would be the one which gives the maximum amo=
unt of time to respond. Your comments are also welcome.
>=20
> >If reading MAX30208_FIFO_OVF_CNTR returns a value > 0, it is used as dat=
a_count. That does not seem correct. The data sheet says if >MAX30208_FIFO_=
OVF_CNTR is !=3D 0, data_count is 32. Maybe the datasheet is wrong all over=
 the place, but at least in this case that seems very >unlikely. =20
> I think you are confusing data_count with "data counter". So, overflow co=
unter becomes active only when there are about 32 readings left in the FIFO=
 to read. Now, in this situation, if I trigger temperature conversion 'x' (=
x<32) more times, I would want to pop out only (x-1) value to read the most=
 recent one, right?, and not 32 readings. So the fact that data counter get=
s stuck at the value of '32' is correct but what we want is the number of r=
eadings to pop to get the most recent one and if overflow counter is >0, th=
e number is indicated by the overflow counter itself.=20
>=20
> Inviting Jonathan and Guenter for further speculations and to comment on =
v6.
>=20
> Thanks
> Rajat
>=20
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Tuesday, October 25, 2022 12:02 AM
> To: Khandelwal, Rajat <rajat.khandelwal@intel.com>
> Cc: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>; jic23@kernel.org=
; lars@metafoo.de; linux-kernel@vger.kernel.org; linux-iio@vger.kernel.org;=
 jdelvare@suse.com; linux-hwmon@vger.kernel.org
> Subject: Re: [PATCH v5] iio: temperature: Add driver support for Maxim MA=
X30208
>=20
> On Mon, Oct 24, 2022 at 05:11:17PM +0000, Khandelwal, Rajat wrote:
> > Hi Guenter,
> > Thanks for the acknowledgement.
> >  =20
> > >Agreed; the sensor doesn't seem to be very useful for traditional=20
> > >hardware monitoring. The driver better resides in IIO. =20
> > Cool! I didn't know the categorical reasoning behind this but since=20
> > this is accepted in IIO, I don't have to do anything more. =20
>=20
> Huh. There is no "categorical" reasoning. Call it a gut feeling.
> I can not imagine anyone using this chip for hardware monitoring, and pre=
sumably you have an IIO use case or you would not have implemented an IIO d=
river.
>=20
> >  =20
> > >I don't understand why readings are discarded. Why trigger multiple=20
> > >readings just to discard all but the last one ? I thought iio would=20
> > >be expected to return all values. =20
> > Ok. The plan is to trigger temperature conversion on the GPIO input als=
o.
> > The user can trigger as many times the temperature conversion he wants=
=20
> > (I accept unnecessary), which will keep the FIFO increasing (without=20
> > reading converted values) but the driver should be resilient to all=20
> > the erroneous zones. Also, when the user does really make a syscall to =
read the temperature, it definitely should be the last converted reading. =
=20
>=20
> That is your use case. I don't know how IIO drivers are normally implemen=
ted, but I would expect a generic driver. In this case, I would expect user=
space to decide what it wants to with the data and not let the kernel drive=
r discard most of it.
>=20
> >  =20
> > >This is really pointless. The register has only one bit to set.
> > >Just write that bit; reading the register before that is pointless. =20
> > I think the register also has some bits which are reserved. Hence,=20
> > rather than to make a number for specifically the value keeping those=20
> > bits the same, I read whatever is there and only store the required one.
> >  =20
> I personally would not accept that kind of code, but that is just me.
>=20
> > >Also, the code assumes that one of the gpio input registers would be=20
> > >used to trigger temperature readings. Why trigger another one if this=
=20
> > >is indeed the case ? Triggering a temperature reading should only be=20
> > >necessary if there is no data in the fifo. =20
> > GPIO input triggering is yet not implemented as I would have to work=20
> > on ACPI interrupts and I have written the driver for now to get it incl=
uded in Linux.
> > There are 2 ways - via GPIO and making a syscall. I agree that=20
> > temperature reading should be necessary only when there is no data in=20
> > FIFO but since we intend to keep GPIO as a trigger point, user can=20
> > keep triggering conversions and not reading them out. (As pointed above=
, driver should be resilient to all erroneous zones). =20
>=20
> What does that have to do with interrupts ? Anything connected to the gpi=
o pin would trigger a reading.
>=20
> >  =20
> > >The datasheet says that it can take up to 50 ms to report a result.
> > >10 retries with 50ms wait each time seems overkill. =20
> > That's correct. But, the response time can be up to 500 ms. Also,=20
> > while debugging I had put timestamps which when analyzed, indicated tha=
t time may go beyond 50 ms.
> >  =20
>=20
> It seems to me that this would warrant an explanation in the driver.
> 500ms seems hard to believe.
>=20
> > >And why use usleep_range() here
> > >but msleep() above ? =20
> > I am sorry about that. I have converted usleep_range into msleep (2 pla=
ces).=20
> >  =20
> > >This is wrong. It uses the overflow counter as data counter if it is=20
> > >!=3D 0. The overflow counter counts the number of overflows, not the=20
> > >number of entries in the fifo. =20
> > So there is no such thing as 'overflow counter'. The point is if the=20
> > overflow counter has =20
>=20
> Interesting statement. MAX30208_FIFO_OVF_CNTR very much sounds like overf=
low counter to me, and the datasheet suggests the same.
>=20
> > even one word, I use the data count equal to the overflow counter=20
> > value. However, if it has zero, then use the number of words in actual =
FIFO.
> > This logic is just used to count how many values to pop to get the most=
 recent reading.
> >  =20
>=20
> The code is
>=20
> +       ret =3D i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_=
CNTR);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "Error reading reg FIFO overf=
low counter\n");
> +               goto unlock;
> +       } else if (!ret) {
> +               ret =3D i2c_smbus_read_byte_data(data->client,
> +                                              MAX30208_FIFO_DATA_CNTR);
> +               if (ret < 0) {
> +                       dev_err(&data->client->dev, "Error reading reg FI=
FO data counter\n");
> +                       goto unlock;
> +               }
> +       }
> +
> +       data_count =3D ret;
>=20
> If reading MAX30208_FIFO_OVF_CNTR returns a value > 0, it is used as data=
_count. That does not seem correct. The data sheet says if MAX30208_FIFO_OV=
F_CNTR is !=3D 0, data_count is 32. Maybe the datasheet is wrong all over t=
he place, but at least in this case that seems very unlikely.
>=20
> > > data_count is declared as u8 and will never be < 0. =20
> > Data count can never be <0 as only first few bits of the 8 bits are use=
d in the register.=20
> >  =20
> 	u8 data_count;
> ...
> 	data_count =3D i2c_smbus_read_byte_data(data->client,
>                                               MAX30208_FIFO_DATA_CNTR);
>         if (data_count < 0) {
>=20
> Really ? Static analyzers will have a field day with this code.
>=20
> Anyway, I don't really care much about this code, so I'll let Jonathan ta=
ke it from here. I just wanted to share my observations.
>=20
> Thanks,
> Guenter

