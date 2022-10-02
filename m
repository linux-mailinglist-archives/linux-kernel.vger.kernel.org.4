Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79045F2299
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJBK2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJBK2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:28:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8782251E;
        Sun,  2 Oct 2022 03:28:01 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0F3701C0016; Sun,  2 Oct 2022 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1664706479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvZgthEJP+YUFpM1NKQE14RzS8WRZddp0iBihRnoGqg=;
        b=V0PLPr9cI8oYbw626i1labAMiQpwPOehBW4npn4Ks8qh2PqeIonA7pr4I1yK5tfbyX5coh
        nSbWv6wxI3KJs1SkRYPCq3u2Xke4Bq88QRGzhu8zKKNEh41U0+LzLbU8DF5ASX+WJC7NYO
        i75BVmMDiTP9tkixOnA6pfEu0RMMAWg=
Date:   Sun, 2 Oct 2022 12:26:59 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     DTML <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-leds@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] ARM: dts: mstar: unitv2: Wire up LEDs
Message-ID: <20211202191904.GA3286@duo.ucw.cz>
References: <20210923065500.2284347-1-daniel@0x0f.com>
 <20210923065500.2284347-8-daniel@0x0f.com>
 <20211130185558.GD30113@duo.ucw.cz>
 <CAFr9PX=TFBGSbZV+hHB4SO5LLmxPXHGXub4RTR36g6yDi5o0kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Content-Disposition: inline
In-Reply-To: <CAFr9PX=TFBGSbZV+hHB4SO5LLmxPXHGXub4RTR36g6yDi5o0kg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Add the red and white leds present on the unitv2.
> >
> > Thanks for cc-ing me.
> >
> > > @@ -18,6 +20,18 @@ aliases {
> > >       chosen {
> > >               stdout-path =3D "serial0:115200n8";
> > >       };
> > > +
> > > +     leds {
> > > +             compatible =3D "gpio-leds";
> > > +             led-white {
> > > +                     gpios =3D <&gpio SSD20XD_GPIO_GPIO0 GPIO_ACTIVE=
_LOW>;
> > > +                     linux,default-trigger =3D "activity";
> > > +             };
> > > +             led-red {
> > > +                     gpios =3D <&gpio SSD20XD_GPIO_GPIO1 GPIO_ACTIVE=
_LOW>;
> > > +                     linux,default-trigger =3D "heartbeat";
> > > +             };
> > > +     };
> >
> > How do these look in userspace (ls /sys/class/leds)?
>=20
> >From what I remember the above results in /sys/class/leds/red and
> /sys/class/leds/white.
> I'll check though. Is there something wrong with that? :)

Yes.

LEDs are supposed to be named device:color:function. Did manufacturer
somehow label them? See also Documentation/leds/well-known-leds.txt .

> >Should the first one be disk-activity?
>=20
> Good question. My personal preference was for some sort of load
> indicator as it helped me when debugging. That's why I have heartbeat
> and activity. An "I'm alive signal" and some indication of how much is
> going on.
> I'm not sure if disk-activity is too useful with these devices as they
> usually have everything in a very small rootfs and don't do lots of
> disk io because they have pretty small SPI NAND flash for local
> storage. Also there isn't anything in mainline that'll trigger the
> disk-activity trigger at the moment.
> As "activity" isn't documented in the bindings and I don't think I got
> an answer from Rob about it, maybe I'll just drop the trigger for now.

CPU activity is fine, too, but we want that option documented as you
did later in the series.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYzlncwAKCRAw5/Bqldv6
8jMfAJ9RmK1MaZ/5/NvDAf0Gj+2v5pstGgCeKVzf6/js5whdZv0zuxE/m2iZ1Rg=
=T9CO
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
