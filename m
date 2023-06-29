Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA742708
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjF2NKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF2NKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:10:41 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d501])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802AC2D60
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:10:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:a497:0:640:fcbf:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 5AA8C5F186;
        Thu, 29 Jun 2023 16:10:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WANpoa3WqW20-RlclWTAv;
        Thu, 29 Jun 2023 16:10:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1688044233;
        bh=if8XJsQm2fMxTwCzbVNbyTJKRzaYnPHv/zYS+5MnX44=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=Y3z7XniSE24LqosSp/6ckbvUicVly6zS+/ky6FHmuP9a1dzx2n4fCNmGj0klWJGHT
         7VUahasxmSN132C+3EofvB3xp4Tvne/CLfLXTCkoF22Zq265Us9vTru4D4UKWkYMkO
         RFXxEfKLmtJz8ZHlTi1wgSeLjOcBnMIKDqUUdwuQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <d5a5c0bcfecb96ea740337785623ed78a1591622.camel@maquefel.me>
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
Date:   Thu, 29 Jun 2023 19:10:33 +0300
In-Reply-To: <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601053546.9574-10-nikita.shubin@maquefel.me>
         <ZHudRkB1YcMD_DaQ@surfacebook>
         <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
         <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com>
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

Hello Andy!

On Wed, 2023-06-21 at 11:28 +0300, Andy Shevchenko wrote:
> On Wed, Jun 21, 2023 at 11:22=E2=80=AFAM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
>=20
> ...
>=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D irq_of_parse_and_map(=
np, 0);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (irq <=3D 0) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 pr_err("ERROR: invalid interrupt number\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
> > >=20
> > > Shadowed error in case of negative returned code. Why?
> >=20
> > Majority of clocksource drivers shadow it. Same like above.
>=20
> It doesn't mean they are correct or using brand new APIs.

Or may be this because irq_of_parse_and_map can return zero as error,
and returning zero from timer_init means success ?

Please correct me if i am wrong here.=20

>=20
> Can you use fwnode_irq_get() instead?

Will it help ?

From docs:

 * Return: Linux IRQ number on success. Other values are determined
 * according to acpi_irq_get() or of_irq_get() operation.

* of_irq_get()
* Return: Linux IRQ number on success, or 0 on the IRQ mapping failure


> The shadowing is most likely due to nasty =3D0 comparison.

Indeed.


>=20
> Also that ERROR is a bit weird, pr_err() is already on error level.
>=20

Completely agree.

