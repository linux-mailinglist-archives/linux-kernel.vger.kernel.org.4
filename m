Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382C16AAB96
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 18:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCDR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 12:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 12:26:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130B811148;
        Sat,  4 Mar 2023 09:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C628DB802C4;
        Sat,  4 Mar 2023 17:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A240C433EF;
        Sat,  4 Mar 2023 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677950783;
        bh=KPYwvzh5duXtSKstrTopOnZQQL4PKi7YUvW2PwfHDEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VesKVDDG2Tt1VV0/GQYKX9RWeYtV+5JXy3PYJgH9l4fdo+JR1Z3egSBZhKQBqqrrW
         RDE4JDNzgBP4ht90X/Ls0dAMb/WAOm/MvOQxPcTKZYT2ihoOkCyxAKPncY09D+pH1T
         T4Ax37OttA/ZLVulGLojHolIIiC4cQCrUWFuiYsND0chRKmU8iuAoPwCwgcFD2+ck7
         fz6KBKdHNVWi6p/Li6BmQthlvi+G0kTjJYXiO9H/nuibWwh2lfKr4OMudz4pS4vIy0
         RMTSgpJ4aAlQxS3rIR3/+BzZPRiNQ22UZjQcOY58kQY6jvTePiPcGOgFvqr+3UhWMG
         ZmtuFkGGllNpw==
Date:   Sat, 4 Mar 2023 17:26:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add TI ADS1100 and ADS1000
Message-ID: <20230304172618.37f448d0@jic23-huawei>
In-Reply-To: <ZACxUpzCtlrMehrA@smile.fi.intel.com>
References: <20230228063151.17598-1-mike.looijmans@topic.nl>
        <20230228063151.17598-2-mike.looijmans@topic.nl>
        <Y/9vez/fzLD5dRVF@smile.fi.intel.com>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.0685d97e-4a28-499e-a9e3-3bafec126832@emailsignatures365.codetwo.com>
        <a2ba706f-888b-0a72-03a5-cbf761dfaf19@topic.nl>
        <ZACxUpzCtlrMehrA@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 16:23:14 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Mar 02, 2023 at 08:49:22AM +0100, Mike Looijmans wrote:
> > On 01-03-2023 16:30, Andy Shevchenko wrote: =20
> > > On Tue, Feb 28, 2023 at 07:31:51AM +0100, Mike Looijmans wrote: =20
>=20
> ...
>=20
> > > > +	/* Shift result to compensate for bit resolution vs. sample rate =
*/
> > > > +	value <<=3D 16 - ads1100_data_bits(data);
> > > > +	*val =3D sign_extend32(value, 15); =20
> > > Why not simply
> > >=20
> > > 	*val =3D sign_extend32(value, ads1100_data_bits(data) - 1);
> > >=20
> > > ? =20
> >=20
> > As discussed with=C2=A0 Jonathan Cameron, the register is right-justifi=
ed and the
> > number of bits depend on the data rate. Rather than having the "scale"
> > change when the sample rate changes, we chose to adjust the sample resu=
lt so
> > it's always left-justified. =20
>=20
> Hmm... OK, but it adds unneeded code I think.

There isn't a way to do it in one go that I can think of.
The first statement is multiplying the value by a power of 2, not just sign=
 extending it.
You could sign extend first then shift to do the multiply, but ends up same=
 amount
of code.

It does look a bit like a weird open coded sign extension though so I can s=
ee where
the confusion came from!

>=20
> ...
>=20
> > > > +	for (i =3D 0; i < 4; i++) {
> > > > +		if (BIT(i) =3D=3D gain) { =20
> > > ffs()/__ffs() (look at the documentation for the difference and use p=
roper one). =20
> >=20
> > Thought of it, but I'd rather have it return EINVAL for attempting to s=
et
> > the analog gain to "7" (0nly 1,2,4,8 allowed). =20
>=20
> I'm not sure what you are implying.
>=20
> You have open coded something that has already to be a function which on =
some
> architectures become a single assembly instruction.
>=20
> That said, drop your for-loop if-cond and use one of the proposed directl=
y.
> Then you may compare the result to what ever you want to be a limit and r=
eturn
> whatever error code you want to

Agreed, could do it with appropriate ffs() followed by if (BIT(i) !=3D gain=
) return -EINVAL;

