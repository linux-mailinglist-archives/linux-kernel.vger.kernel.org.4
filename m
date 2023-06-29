Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA590742DAE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjF2TXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjF2TWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295143588
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:21:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso274123a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688066508; x=1690658508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQpU/w5GzK92nDH1UECE4YLWrilurcCLTZLjn/+Rv5o=;
        b=PsgxyQVkQYl1/4UjhoFfnv0U3jjzQ+wtwkL4bsjE0JdHr5TBFaFB2vb9n84eZISiCD
         nCcZPTficv4olr/Wg7mZQFDIcBlbZsGZrdSaSSzqt4MhqUWPQ+6C4CxFK+s3PDsWbkob
         HY+4QFX/bK9u8pRqph4trtXPtsZK+NhUNTYEPRJLwE3Dx3GKG6vcR0ad59KKltixQc+d
         ycZ+taJ2LHb9gMzgfxqga0fr/HmK1ZTksg+ZP0gScgfrzbPPi6rWRKjfDQUFLWKFHTo3
         c/7qku2JmabNNfl2eZZDdoBJH6qtuyXyAfT2TJUgZlO891je1nCfsjDQbK2k0FE7EC6X
         JxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688066508; x=1690658508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQpU/w5GzK92nDH1UECE4YLWrilurcCLTZLjn/+Rv5o=;
        b=bjTV1uHlTI69nKNc3FRNflx5hQeLV4RnAjDWawx4RM8UyuqQuxd/FgyRum56qnbAdD
         3DwTqU14LjagrMcUa2j84HgylUgYzXdw53l34vz1MMMzwtcTd+ZSTzlDtNaOQRxZ0ns3
         BQQyAAPtmGvfoBv1Azck9JJ1XJmeNnV79sydtbncI81gd2S8KaLBh+6ANJ3U8w5JAMtS
         vIQrXrsdRTchqFFBAecmitRYnFWhcFmV0DvJCBOwRmbimeP2WQGH+rnfbvlZjGOvz9Y8
         QNzoiZwHOr9QEJbK+EgcC7tQaXbex/eNfg9MWjaCP+EegyyCzFPxkKHmnPXSVhBuuoEV
         QN0g==
X-Gm-Message-State: ABy/qLYAhqCpgmZC5BYJwNfCZvYKtVDJ7JPk2ETFCvUm8YQVqQ6UAbQO
        YlRPxouiryEBHhIKSvaLT8ejDI6qdy1HOJKgIUdIlV3z/9yPNs+V
X-Google-Smtp-Source: APBJJlHmOKkDjcMhH3kzzHvivS330DaDfVk9NV9iX0bxPTiZavL8aw/2XHTS/taitD2L89Lc7ge1H4HpvCBSAWsAGlI=
X-Received: by 2002:a05:6402:321f:b0:51d:9231:b9fa with SMTP id
 g31-20020a056402321f00b0051d9231b9famr91946eda.39.1688066508408; Thu, 29 Jun
 2023 12:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me> <ZHudRkB1YcMD_DaQ@surfacebook>
 <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
 <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com>
 <d5a5c0bcfecb96ea740337785623ed78a1591622.camel@maquefel.me>
 <CAHp75VfxvBXkQJiMYzLByqM_s_eVK4+YSoB-0LALrhZKi0g8wQ@mail.gmail.com> <9a41dd21fdfe3f8b8f6788a1c3822b096162f61b.camel@maquefel.me>
In-Reply-To: <9a41dd21fdfe3f8b8f6788a1c3822b096162f61b.camel@maquefel.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Jun 2023 22:21:12 +0300
Message-ID: <CAHp75VcbyyDyVOADjO4Bb_pSBoVQuvASUuP5gba4gU-vdHxboA@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 5:16=E2=80=AFPM Nikita Shubin <nikita.shubin@maquef=
el.me> wrote:
> On Thu, 2023-06-29 at 16:39 +0300, Andy Shevchenko wrote:
> > On Thu, Jun 29, 2023 at 4:10=E2=80=AFPM Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:
> > > On Wed, 2023-06-21 at 11:28 +0300, Andy Shevchenko wrote:
> > > > On Wed, Jun 21, 2023 at 11:22=E2=80=AFAM Nikita Shubin
> > > > <nikita.shubin@maquefel.me> wrote:

...

> > > > > > > +       irq =3D irq_of_parse_and_map(np, 0);
> > > > > > > +       if (irq <=3D 0) {
> > > > > > > +               pr_err("ERROR: invalid interrupt
> > > > > > > number\n");
> > > > > > > +               ret =3D -EINVAL;
> > > > > >
> > > > > > Shadowed error in case of negative returned code. Why?
> > > > >
> > > > > Majority of clocksource drivers shadow it. Same like above.
> > > >
> > > > It doesn't mean they are correct or using brand new APIs.
> > >
> > > Or may be this because irq_of_parse_and_map can return zero as
> > > error,
> > > and returning zero from timer_init means success ?
> > >
> > > Please correct me if i am wrong here.
> >
> > 0 means no mapped IRQ.
> >
> > > > Can you use fwnode_irq_get() instead?
> > >
> > > Will it help ?
> >
> > Yes, definitely, in two aspects:
> > 1/ it makes code less OF-dependent (helps also OF people to clean up
> > the spread of OF headers and APIs where they are not needed);
> > 2/ it takes care about proper error codes.
> >
>
> Well... every use of fwnode_irq_get in 6.4 looks like:
>
>         err =3D fwnode_irq_get(fwnode, 0);
>         if (err < 0)
>                 return err;
>         if (!err)
>                 return -EINVAL;
>
> So i don't see any special care as it still calls of_irq_get just like
> irq_of_parse_and_map.

Well, this change is not a fix and not going to land v6.4 anyway, have
you checked what's in the v6.5-rc1? I believe it will have
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/comm=
it/?h=3Ddriver-core-next&id=3D39d422555e43379516d4d13f5b7162a3dee6e646,
will we?

> But i am convinced to use the same approach, thank you!

No, please, don't copy the old and ugly variant, use a brand new one.

--=20
With Best Regards,
Andy Shevchenko
