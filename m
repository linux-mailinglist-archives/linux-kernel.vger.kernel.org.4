Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB31737D68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjFUIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjFUIWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:22:44 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF03BC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:22:41 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:6284:0:640:826e:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 469455F1ED;
        Wed, 21 Jun 2023 11:22:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id bMdsDaQWniE0-1QR4YBWK;
        Wed, 21 Jun 2023 11:22:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1687335758;
        bh=x+0IfbRP5uhtrIWmzZU5o1znkghAReX8NKQv/Nwp6/g=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=j6iUTGQtCGu5WsNJbA7oFV0XZnq7TlyIsoAp6Z0GJnZHLRFeEkL1mG9NBVLCEl0VD
         H85nzgeFBK8JdBF9LJABGnVeRLeifzcwENwBqYGr5ahx5Vat82OMYMEVopezAD2U7p
         abepGW7dhkD6TgY5cppX3e/jUCp64qoDbgACYFYc=
Authentication-Results: mail-nwsmtp-smtp-production-main-57.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus
 Logic EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     andy.shevchenko@gmail.com
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jun 2023 14:22:37 +0300
In-Reply-To: <ZHudRkB1YcMD_DaQ@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
         <20230601053546.9574-10-nikita.shubin@maquefel.me>
         <ZHudRkB1YcMD_DaQ@surfacebook>
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

Hello Andy!

Agreed to almost, still... :

>=20
> ...
>=20
> > +static struct ep93xx_tcu *ep93xx_tcu;
>=20
> Global?!
> Can it be derived from struct clocksource?
>=20

It's look like a common practice for read_sched_clock, even for most
new drivers. I would like for comment from Daniel or Thomas before
ripping it out.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0irq =3D irq_of_parse_and_map=
(np, 0);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (irq <=3D 0) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0pr_err("ERROR: invalid interrupt number\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
>=20
> Shadowed error in case of negative returned code. Why?

Majority of clocksource drivers shadow it. Same like above.

All other comments applied - thank you!


