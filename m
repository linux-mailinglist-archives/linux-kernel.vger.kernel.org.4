Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA510706012
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjEQG33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjEQG30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:29:26 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AEC40DA;
        Tue, 16 May 2023 23:29:23 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:160b:0:640:acd0:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 8A66D5EDA9;
        Wed, 17 May 2023 09:29:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KTVj6G9DgKo0-VFHkceuv;
        Wed, 17 May 2023 09:29:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684304961;
        bh=xU3JDu5Ju9D0Qyix9LXS70BToOVr5oSiC8hyJRWLJ1U=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=Sq+TQqVtSLMxcK19xGbIiyCIY+0Q9NUamC8NFzJmulLXGxFpE2tWYGHbmX7OM9Qps
         N16vozVcylnSBu/TzfyAFxLSXOwtwpCGtyhwmEW7xR5SrHNoIyJgW67UtDM8/VJ3+m
         Z5BWrmbCoZuh/pYl+R9oTdu8Ya4ubqkRDr8BLBGs=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <424735804fa1cfabf3b1d76b4b3dd9162f4338a8.camel@maquefel.me>
Subject: Re: [PATCH 36/43] pwm: ep93xx: drop legacy pinctrl
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 May 2023 12:29:21 +0300
In-Reply-To: <20230517061355.5o2ksfkpupsbpuha@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-37-nikita.shubin@maquefel.me>
         <20230515143222.dlhxcze5254773r4@pengutronix.de>
         <f43addc54fd6bafca831d2f2802cc09c4e5baef9.camel@maquefel.me>
         <20230517061355.5o2ksfkpupsbpuha@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe!

On Wed, 2023-05-17 at 08:13 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nikita,
>=20
> On Tue, May 16, 2023 at 01:43:27PM +0300, Nikita Shubin wrote:
> > On Mon, 2023-05-15 at 16:32 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Apr 24, 2023 at 03:34:52PM +0300, Nikita Shubin wrote:
> > > > diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-
> > > > ep93xx.c
> > > > index 8bfe6cfbb3db..657adb011aeb 100644
> > > > --- a/drivers/pwm/pwm-ep93xx.c
> > > > +++ b/drivers/pwm/pwm-ep93xx.c
> > > > @@ -45,20 +45,6 @@ static inline struct ep93xx_pwm
> > > > *to_ep93xx_pwm(struct pwm_chip *chip)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return container_of=
(chip, struct ep93xx_pwm, chip);
> > > > =C2=A0}
> > > > =C2=A0
> > > > -static int ep93xx_pwm_request(struct pwm_chip *chip, struct
> > > > pwm_device *pwm)
> > > > -{
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_device *=
pdev =3D to_platform_device(chip-
> > > > > dev);
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ep93xx_pwm_acquir=
e_gpio(pdev);
> > >=20
> > > I didn't get the whole series and didn't spot a relevant followup
> > > change
> >=20
> > https://lore.kernel.org/all/20230424123522.18302-1-nikita.shubin@maquef=
el.me/
>=20
> Yeah, I looked there, but didn't find it. Applied the whole series
> now
> and found "ARM: ep93xx: soc: drop defines". A few things I noticed
> while
> doing so:
>=20
> =C2=A0- git am warns about new blank lines at EOF in several patches.
>=20
> =C2=A0- b4 am 20230424123522.18302-1-nikita.shubin@maquefel.me
> =C2=A0=C2=A0 warns about broken DKIM signatures. The copy I got directly =
via Cc
> is
> =C2=A0=C2=A0 OK though. The relevant problem is that your To: header is e=
mpty
> but
> =C2=A0=C2=A0 part of the signed payload + the copy I got via vger.kernel.=
org
> had
> =C2=A0=C2=A0 the To header mangled to
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0To:=C2=A0=C2=A0=C2=A0=C2=
=A0 unlisted-recipients:; (no To-header on input)=20
>=20
> =C2=A0=C2=A0 This results in:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ curl -s
> https://lore.kernel.org/lkml/20230424123522.18302-37-nikita.shubin@maquef=
el.me/raw
> =C2=A0| dkimverify
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0signature verification fa=
iled
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$ curl -s
> https://lore.kernel.org/lkml/20230424123522.18302-37-nikita.shubin@maquef=
el.me/raw
> =C2=A0| sed 's/^To:.*/To:/' | dkimverify=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0signature ok
>=20
> =C2=A0=C2=A0 I don't know who is to blame here (i.e. is an empty To allow=
ed?)
> but
> =C2=A0=C2=A0 I'd recommend to put the people you want to merge the patche=
s into
> =C2=A0=C2=A0 the To header anyhow.
>=20
> > > on lore.k.o, so: I assume ep93xx_pwm_acquire_gpio() and
> > > ep93xx_pwm_release_gpio() will be unused in the end? Do you drop
> > > them?
> > >=20
> > > I assume this series target to be taken via arm-soc (once the
> > > review
> > > feedback is positive)?
>=20
> You didn't reply to that one. Still assuming this to be true, I'll
> mark
> this patch as handled-elsewhere in the PWM patchwork.

Oh sorry about that, yes the current plan is taking the whole series at
once, when acked by.

>=20
> > > I wonder if this change breaks non-dt machine support?
> >=20
> > The aim for the whole series is fully converting to dt, this means
> > platform files will be dropped.
> >=20
> > The v1 series tries not to break anything until platform removal
> > commit, before this commit non-dt version should be compilable and
> > fully functional.
>=20
> OK, the pwm patch looks fine to me,
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> Best regards and thanks for your efforts,
> Uwe
>=20

