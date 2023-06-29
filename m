Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7174281E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjF2ORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjF2OQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:16:19 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6483A98
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:16:16 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c2a:210:0:640:45a:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id 5FF965E928;
        Thu, 29 Jun 2023 17:16:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id CGOPvJ4DXuQ0-V5jV4mQQ;
        Thu, 29 Jun 2023 17:16:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1688048173;
        bh=ZFsWfVhNr0HGJy7+gq20H4yScbZMVlH24Hc8HOxfmJk=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=rmXZRomhtPvf0eem/8wie+zJ9IYhu16QjcUGZtii0Gz8IeoMWUFpEyPE2c/2/XGIU
         t1XNby6YrwsR4Ou3kE05Q/79zdyBQ0AJk76CgccE/f4/XAF/7vnbIpaaXBc/bTXrIH
         pG9ltuExcokvxTRsO0g/m7ORB4FZUP19OlGwBmAs=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <9a41dd21fdfe3f8b8f6788a1c3822b096162f61b.camel@maquefel.me>
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus
 Logic EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 20:16:13 +0300
In-Reply-To: <CAHp75VfxvBXkQJiMYzLByqM_s_eVK4+YSoB-0LALrhZKi0g8wQ@mail.gmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601053546.9574-10-nikita.shubin@maquefel.me>
         <ZHudRkB1YcMD_DaQ@surfacebook>
         <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
         <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com>
         <d5a5c0bcfecb96ea740337785623ed78a1591622.camel@maquefel.me>
         <CAHp75VfxvBXkQJiMYzLByqM_s_eVK4+YSoB-0LALrhZKi0g8wQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-29 at 16:39 +0300, Andy Shevchenko wrote:
> On Thu, Jun 29, 2023 at 4:10=E2=80=AFPM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> > On Wed, 2023-06-21 at 11:28 +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 21, 2023 at 11:22=E2=80=AFAM Nikita Shubin
> > > <nikita.shubin@maquefel.me> wrote:
>=20
> ...
>=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D irq_of_parse_and_=
map(np, 0);
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (irq <=3D 0) {
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 pr_err("ERROR: invalid interrupt
> > > > > > number\n");
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
> > > > >=20
> > > > > Shadowed error in case of negative returned code. Why?
> > > >=20
> > > > Majority of clocksource drivers shadow it. Same like above.
> > >=20
> > > It doesn't mean they are correct or using brand new APIs.
> >=20
> > Or may be this because irq_of_parse_and_map can return zero as
> > error,
> > and returning zero from timer_init means success ?
> >=20
> > Please correct me if i am wrong here.
>=20
> 0 means no mapped IRQ.
>=20
> > > Can you use fwnode_irq_get() instead?
> >=20
> > Will it help ?
>=20
> Yes, definitely, in two aspects:
> 1/ it makes code less OF-dependent (helps also OF people to clean up
> the spread of OF headers and APIs where they are not needed);
> 2/ it takes care about proper error codes.
>=20

Well... every use of fwnode_irq_get in 6.4 looks like:

	err =3D fwnode_irq_get(fwnode, 0);
	if (err < 0)
		return err;
	if (!err)
		return -EINVAL;

So i don't see any special care as it still calls of_irq_get just like
irq_of_parse_and_map.

But i am convinced to use the same approach, thank you!




