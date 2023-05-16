Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615AA7046BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEPHnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjEPHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:43:30 -0400
Received: from forward502c.mail.yandex.net (forward502c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d502])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC819BF;
        Tue, 16 May 2023 00:43:29 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2991:0:640:bb47:0])
        by forward502c.mail.yandex.net (Yandex) with ESMTP id 599E75E86E;
        Tue, 16 May 2023 10:43:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id QhVjDJ6W0Sw0-H4JEQEko;
        Tue, 16 May 2023 10:43:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1684223006;
        bh=nUtjqU+sAciBVwsdtymZhriwvo+MARgT/oHALT4Wqfg=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=tN3EdQsdbJxlrlzb1oGCfl2c0C37N5NMv4bJh8IrA7xzD/LEN04Jy1+UHdddBS3Jn
         ppTmPB42gry1MF+dCRrzN2iCGvBpT9zRUbcIjd+ZBGM0d1ujxpnCz+KC2gBuCLf8FU
         UITq7gNTQetanuGHtscUL+fjAWaTnKymS14FDpPQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <f43addc54fd6bafca831d2f2802cc09c4e5baef9.camel@maquefel.me>
Subject: Re: [PATCH 36/43] pwm: ep93xx: drop legacy pinctrl
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 May 2023 13:43:27 +0300
In-Reply-To: <20230515143222.dlhxcze5254773r4@pengutronix.de>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230424123522.18302-37-nikita.shubin@maquefel.me>
         <20230515143222.dlhxcze5254773r4@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe!

On Mon, 2023-05-15 at 16:32 +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Apr 24, 2023 at 03:34:52PM +0300, Nikita Shubin wrote:
> > Drop legacy gpio request/free since we are using
> > pinctrl for this now.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0drivers/pwm/pwm-ep93xx.c | 16 ----------------
> > =C2=A01 file changed, 16 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
> > index 8bfe6cfbb3db..657adb011aeb 100644
> > --- a/drivers/pwm/pwm-ep93xx.c
> > +++ b/drivers/pwm/pwm-ep93xx.c
> > @@ -45,20 +45,6 @@ static inline struct ep93xx_pwm
> > *to_ep93xx_pwm(struct pwm_chip *chip)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return container_of(chi=
p, struct ep93xx_pwm, chip);
> > =C2=A0}
> > =C2=A0
> > -static int ep93xx_pwm_request(struct pwm_chip *chip, struct
> > pwm_device *pwm)
> > -{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct platform_device *pdev=
 =3D to_platform_device(chip-
> > >dev);
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ep93xx_pwm_acquire_gp=
io(pdev);
>=20
> I didn't get the whole series and didn't spot a relevant followup
> change

https://lore.kernel.org/all/20230424123522.18302-1-nikita.shubin@maquefel.m=
e/

> on lore.k.o, so: I assume ep93xx_pwm_acquire_gpio() and
> ep93xx_pwm_release_gpio() will be unused in the end? Do you drop
> them?
>=20
> I assume this series target to be taken via arm-soc (once the review
> feedback is positive)?
>=20
> I wonder if this change breaks non-dt machine support?

The aim for the whole series is fully converting to dt, this means
platform files will be dropped.

The v1 series tries not to break anything until platform removal
commit, before this commit non-dt version should be compilable and
fully functional.

>=20
> Best regards
> Uwe
>=20

