Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E066E114B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjDMPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDMPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:38:52 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259E1712;
        Thu, 13 Apr 2023 08:38:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id az2so741059pgb.11;
        Thu, 13 Apr 2023 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681400330; x=1683992330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59frgasnmq9NimzS/UOjzhA/IREWt1W+yRUKs3C2aWc=;
        b=h3E71BUTuttYr47xowM1MYGFL3EvRvKlLYCgsDg/GVORmslcypP6EuDapgqBvh5Dra
         wtU9vzigSVySkUoGGtPGEAqzc03LGloX34k4oxrt3bSgsEbVci4TOAfpSGS+2FT5+zEq
         XEZORjtUIB1IsMGkKwmxyQYW2j7lelkFM7w0rgdt43DQOr+LXxcNsyKqbejMWkkc1My7
         AoIY025i96B15wwi3Haw8KxlUgSuC8nPPyoTjjOUSCvDnR7Bc4gvC+VpdCnea9vupiDg
         6pUadE78/RiROHJBbCt7gBmiwNdx7lOtdsIXIt6Pl6i2rMzi6BeVgkNT/nt4LU3LE6zt
         WHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681400330; x=1683992330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59frgasnmq9NimzS/UOjzhA/IREWt1W+yRUKs3C2aWc=;
        b=ZEUv8ePBQf9RRo7VWaH0vXxBWFXUhCAR9+fvmDkOQldeSwca++y2p+n5WAKhfgtOqB
         h0MiI+hwt/Rcz3HC8IlYC3JpwQC0GJ2JXowbGRiLBz/oUsGF1f6Y244sgxdvvSnrA71r
         q9okGnR4kyG2I+5hG7nhwnbWV9O2rML2j8OZOwxG7ULmrzzSX+pb1mlrs5iln7tZuo5S
         ktf8Hk0JSIF1i8oBMTyVavg6PVRbpXxPaJdZM3tvNWNL4oVw6ll61bp0LAqbsu7Wdgjx
         Hi+O7qNPvFIhjemNvVWevBKEOmh/cBBnXxZyHBVDlV5wRG9N1LPjTreNgUYOw+RNy4Q5
         ppvQ==
X-Gm-Message-State: AAQBX9fqMcwEjNjdHDgVaRgaCJAKTJ4XAZV9sFe5qrHCDPzHypequBhM
        xJXYwELdVsuGMCTqBUyt6E/k3LOj19I4C4WPOpI=
X-Google-Smtp-Source: AKy350aq2r5zlbCRGOUUKIcCY9+IVKIrDAWdtWKrsRfbLuGY94W9mNfCBDbZpDEeY+BwPhBDsWdtDla28akqyUGsvTA=
X-Received: by 2002:a65:67d9:0:b0:51b:4755:ba69 with SMTP id
 b25-20020a6567d9000000b0051b4755ba69mr652169pgs.9.1681400330400; Thu, 13 Apr
 2023 08:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230413074926.239605-1-zyytlz.wz@163.com> <TYBPR01MB5341FED435E5533E4B60B10CD8989@TYBPR01MB5341.jpnprd01.prod.outlook.com>
In-Reply-To: <TYBPR01MB5341FED435E5533E4B60B10CD8989@TYBPR01MB5341.jpnprd01.prod.outlook.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 23:38:38 +0800
Message-ID: <CAJedcCzGe7AwP4te_dO2_42SSkmPCxGraowtD=YED4Pd5BTaNA@mail.gmail.com>
Subject: Re: [RESEND PATCH] usb: renesas_usbhs: Fix use after free bug in
 usbhs_remove due to race condition
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>
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

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8813=E6=97=A5=E5=91=A8=E5=9B=9B 20:19=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> > From: Zheng Wang, Sent: Thursday, April 13, 2023 4:49 PM
> >
> > In usbhs_probe, &priv->notify_hotplug_work is bound with
> > usbhsc_notify_hotplug. It will be started then.
> >
> > If we remove the driver which will call usbhs_remove
> >   to make cleanup, there may be a unfinished work.
> >
> > The possible sequence is as follows:
> >
> > Fix it by finishing the work before cleanup in the usbhs_remove
> >
> > CPU0                  CPU1
> >
> >                     |usbhsc_notify_hotplug
> > usbhs_remove         |
> > usbhs_mod_remove     |
> > usbhs_mod_gadget_remove|
> > kfree(gpriv);       |
> >                     |usbhsc_hotplug
> >                     |usbhs_mod_call start
> >                     |usbhsg_start
> >                     |usbhsg_try_start
> >                     |//use gpriv
>
> Thank you for the patch!
>
> You should adjust the figure like followings because Greg mentioned it on=
 other patch [1].

Thanks for your advice. Will apply in the next.

Best regards,
Zheng

> -----
> CPU0                      CPU1
>
>                         | usbhsc_notify_hotplug
> usbhs_remove            |
> usbhs_mod_remove        |
> usbhs_mod_gadget_remove |
> kfree(gpriv);           |
>                         | usbhsc_hotplug
>                         | usbhs_mod_call start
>                         | usbhsg_start
>                         | usbhsg_try_start
>                         | //use gpriv
> -----
>
> [1]
> https://lore.kernel.org/lkml/ZBNCam0XjWehrF3c@kroah.com/
>
> Best regards,
> Yoshihiro Shimoda
>
> > Fixes: bc57381e6347 ("usb: renesas_usbhs: use delayed_work instead of w=
ork_struct")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/usb/renesas_usbhs/common.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_u=
sbhs/common.c
> > index 96f3939a65e2..17a0987ef4f5 100644
> > --- a/drivers/usb/renesas_usbhs/common.c
> > +++ b/drivers/usb/renesas_usbhs/common.c
> > @@ -768,6 +768,7 @@ static int usbhs_remove(struct platform_device *pde=
v)
> >
> >       dev_dbg(&pdev->dev, "usb remove\n");
> >
> > +     cancel_delayed_work_sync(&priv->notify_hotplug_work);
> >       /* power off */
> >       if (!usbhs_get_dparam(priv, runtime_pwctrl))
> >               usbhsc_power_ctrl(priv, 0);
> > --
> > 2.25.1
>
