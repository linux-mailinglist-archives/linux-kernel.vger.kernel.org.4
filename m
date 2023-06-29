Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40CB74278D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjF2NkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjF2Nj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 09:39:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BF9E72
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:39:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so835957a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688045996; x=1690637996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAb2qc50QSgKTFPb8asa69yU5CajCxT0KNO3XuPxDPY=;
        b=seMchDwOJbqHygqfbhjvgY6zDaScUTNRxVMu/9mAyvW6b42bFIcLzIXNyo9+eKrY3X
         rkQGc3UjZVrSYJZp5UkuECuFdz3uFxnBD4wjYAMk+l9XvT9PnltDdWb3es1ZCXie0VSW
         g2+wneFn8BnS4Oc86rxaCZ0B2zJqcyS0Wiv0HXZgMHG6QIGCyUMjYPESK6RMISeZ9YDk
         gQqTgqolkqBBUJMnNoqvqD8Y/tYTb0mNPLq2uD1z2e6sT8ZX8fdCSSDbVvh8mMUANtfU
         I2AV3BG7HTp8uceA2okpB3Y7rQCdD4Q1Xcnsm9/VmA/0W78YFrvj8ZQ8/022thh3AJ61
         /n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688045996; x=1690637996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAb2qc50QSgKTFPb8asa69yU5CajCxT0KNO3XuPxDPY=;
        b=CvANBcAqDPCz4BEfMq/woEtRzdYQd7aRLg9dlssDGGDSC+u28/gZnuUG82uBAsAzo5
         SFK/3WMOi4l+cGe4MpgSJ/sCbjdgMtBNtR5LzgbBZrEMBxoZlBCW5Lt+sAUa1GE0u/8S
         rpw6w2P/yupJ9OHtqN/u1ddM6ujZdgGNZUvx0PKXg6HnwNdS6RCcdM90K8b/z1PBNqpe
         67HdoMMwKRdERhsX/FhlJKLGaT9CQL9e8tGFYFyWuUO53gflwhlXJGd7Kn8jhIItTZq1
         4Medchd+h6ZAO+R0u++Ap2g9wxQg175gzASswxGwaMuVejlBLyVtESUBb0+WdHRNwUE8
         Y8Ug==
X-Gm-Message-State: AC+VfDxdv4hQLKIoFNLfQgMJith8SCzP+4y/+Qg4Yagjvio8wj77tkph
        qOKefGV69RKRhg5gBqgNKtsyIMteotHnMdS8+I8=
X-Google-Smtp-Source: ACHHUZ7Zj8Vnh7WhSL4aUXhu0xe2otoicHEWjsgVsRQOzZnvhOpEpPHM8lQKplyxt2S8tbGSxmePSXxGrO5G6+5o3Dw=
X-Received: by 2002:a05:6402:1206:b0:51d:8a12:d267 with SMTP id
 c6-20020a056402120600b0051d8a12d267mr10404875edw.3.1688045995567; Thu, 29 Jun
 2023 06:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me> <ZHudRkB1YcMD_DaQ@surfacebook>
 <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
 <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com> <d5a5c0bcfecb96ea740337785623ed78a1591622.camel@maquefel.me>
In-Reply-To: <d5a5c0bcfecb96ea740337785623ed78a1591622.camel@maquefel.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Jun 2023 16:39:19 +0300
Message-ID: <CAHp75VfxvBXkQJiMYzLByqM_s_eVK4+YSoB-0LALrhZKi0g8wQ@mail.gmail.com>
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 4:10=E2=80=AFPM Nikita Shubin <nikita.shubin@maquef=
el.me> wrote:
> On Wed, 2023-06-21 at 11:28 +0300, Andy Shevchenko wrote:
> > On Wed, Jun 21, 2023 at 11:22=E2=80=AFAM Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:

...

> > > > > +       irq =3D irq_of_parse_and_map(np, 0);
> > > > > +       if (irq <=3D 0) {
> > > > > +               pr_err("ERROR: invalid interrupt number\n");
> > > > > +               ret =3D -EINVAL;
> > > >
> > > > Shadowed error in case of negative returned code. Why?
> > >
> > > Majority of clocksource drivers shadow it. Same like above.
> >
> > It doesn't mean they are correct or using brand new APIs.
>
> Or may be this because irq_of_parse_and_map can return zero as error,
> and returning zero from timer_init means success ?
>
> Please correct me if i am wrong here.

0 means no mapped IRQ.

> > Can you use fwnode_irq_get() instead?
>
> Will it help ?

Yes, definitely, in two aspects:
1/ it makes code less OF-dependent (helps also OF people to clean up
the spread of OF headers and APIs where they are not needed);
2/ it takes care about proper error codes.

--=20
With Best Regards,
Andy Shevchenko
