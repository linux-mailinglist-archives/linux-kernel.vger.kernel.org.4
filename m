Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC0E5E5767
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 02:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiIVAet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 20:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIVAep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 20:34:45 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C862563D9;
        Wed, 21 Sep 2022 17:34:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n15so5961663wrq.5;
        Wed, 21 Sep 2022 17:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=CAY1Le6iZuq4WCQqQu6cWxVZo31XqaHH/Ihp+V9i8fE=;
        b=ISUiOO8ZXuObKHX8uOtYpsLkLYs3UTINopdD8z74xAsb/7dC7fpmIQGUDDcM/SfKKy
         RSHcv30kyrAv7xTiA2lL0DclbnlxbwmOmDOQ00ahCgzRdpAx4OYFNb40pkq1+/UUAYk8
         sdwnvVZpPEqK/6ub+P2GWIvGfoAM2fjd1Jnu3kCV3g/+18JsBZTJZodbjlpSO208a07K
         8jojv2QcuFHXetQuFoO/x64tCF6Mf9flhbfQ+16xNa1aX0syLmwdTvMzzbiL52Nlda+J
         tSUVWMU7eyv0JcSCw1be9MflIqyqMig1EF/qJ3huqFBJxS3wfGypycqZos1+zGd6gcPh
         spiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CAY1Le6iZuq4WCQqQu6cWxVZo31XqaHH/Ihp+V9i8fE=;
        b=1F/P8kUhcG+pKSYl1XQJYoFHVaIzYwXrej/GhZ7szWN8MmLuRVyrO/2X4638x6q5ba
         l800JJgck2pmuRSFJ/QIyKJwf720dPqlXyI9H3QJFvfFaG1nN4uRnCoMYNxzDjdtJ3HE
         TXgiA/thgVQ6bi0AUqZLd3+/jvCkKXBH1lU4QmZC0F0PI3+rii3ClOc6onBWt9aiRx76
         mE0UsM6eENmU9pDoGPwcXBxWxTVDko0B4GudPLJEew/vrOxtFACtldMWyhycrcultGwc
         VYO5J+ICk14Av9MgFWuMbZLKkBTgBeq6T1IiDwishGY6p5ClWdEMX2jCuFOHW8n2EvOi
         XsYQ==
X-Gm-Message-State: ACrzQf2CoGIgIzf2McdnmsRoREbT+qI7OTxI5DPsvipP64SaZRvi13q4
        5Dbw+E7HaRaN3/1pqLH4gapfC1e6WvgomZD9+cg=
X-Google-Smtp-Source: AMsMyM73thTpBJgLUqh7P9IPsOlGbh/oChjYicta1vc7eihCxCo33TFEHV78aUIM3ojV+3ZGUw+njmrAwxvBZzKrm8w=
X-Received: by 2002:a5d:4302:0:b0:225:5303:39e5 with SMTP id
 h2-20020a5d4302000000b00225530339e5mr351125wrq.380.1663806881537; Wed, 21 Sep
 2022 17:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <1663294501-6377-1-git-send-email-u0084500@gmail.com> <CAJZ5v0gL_U=FwY8W-A2pGSif6wbvyFUL7WQ2jcqHFgT2ucqY6Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0gL_U=FwY8W-A2pGSif6wbvyFUL7WQ2jcqHFgT2ucqY6Q@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 22 Sep 2022 08:34:29 +0800
Message-ID: <CADiBU39-=9n_=Kk_98y-pwJ6nyzGaaDy6SFqfnYJubY9mZ=idg@mail.gmail.com>
Subject: Re: [RFC] PM: core: Add pm_wakeup_pending check in device suspend_noirq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, cy_huang@richtek.com,
        gene_chen@richtek.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2022=E5=B9=B49=E6=9C=8822=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E5=87=8C=E6=99=A82:13=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Fri, Sep 16, 2022 at 4:15 AM cy_huang <u0084500@gmail.com> wrote:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > In 'dpm_suspend_noirq', it will do the sychronized_irq to guarantee all
> > irqs are all done, and then do any wakeup flag set.
> >
> > For some peripherial deivces like as I2C/SPI, to speed up the irq handl=
ing,
> > it may use 'pm_stay_awake' and really handle in another thread context =
like
> > as workqueue.
> >
> > But in mem suspend flow, after 'dpm_suspend_noirq" stage, the next
> > 'pm_wakeup_pending' check will be at 'syscore_suspend'.
> >
> > The checkpoint seems too late and cause I2C/SPI fail during 'noirq' to
> > 'syscore_suspend'
>
> What exactly do you mean by "fail" here?
For the below case
Once the adapter is marked as 'Suspend', any i2c_xfer or spi_xfer will
directly return 'ESHUTDOWN".
There's no real I/O transferred, only the direct returned error code.

>
> >. But some adapter was already be marked as 'suspended'
> > at 'noirq' callback, any I2C/SPI xfer will return the error flag '-ESHU=
TDOWN'.
> >
> > After the code trace, it seems all device callback will do 'pm_wakeup_p=
ending'
> > check, except 'noirq'.
> >
> > This patch is to add 'pm_wakeup_pending' check in 'noirq' sage to preve=
nt this
> > kind of usage.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Hi,
> >
> > Is there any rule to define when I2C/SPI host controller need to mark a=
dapter as
> > 'suspended'?
> >
> > I trace 'drivers/i2c/buses'.It seems there's no common rule, Some are '=
suspend',
> > others may did it at 'suspend_noirq'.
> >
> > ---
> >  drivers/base/power/main.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index c501392..7cd7dc5 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1210,6 +1210,11 @@ static int __device_suspend_noirq(struct device =
*dev, pm_message_t state, bool a
> >         if (async_error)
> >                 goto Complete;
> >
> > +       if (pm_wakeup_pending()) {
> > +               async_error =3D -EBUSY;
> > +               goto Complete;
> > +       }
> > +
> >         if (dev->power.syscore || dev->power.direct_complete)
> >                 goto Complete;
> >
> > --
> > 2.7.4
> >
