Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332EB6C8153
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjCXPfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjCXPfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:35:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB98A1ADF6;
        Fri, 24 Mar 2023 08:35:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1962919pjz.1;
        Fri, 24 Mar 2023 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679672112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uioeUW0b5QfjzsCcQLCYz9oQ5uQ4Sn5bsToPRxmO2s=;
        b=D6KxP1oArJBJV2Y65xV8DroR8s9jDS60ScwNt9HIijqtklBCb1N+fbYuWUn/nKvwXS
         rBW8xktv8HDDH/KrSyQrPgFMJru8YCUAlCigoy4HRYHrJOhJ5MRbbCQSD5gX7GN6EaXz
         xWRG4T0sc0Wy3QFRnFZW9u6IGx+IjSMVPf5ASwg2CcXTdkhj2DFN8/oCu+COido8mqUR
         uK/Hn+xut7BCvLN1Bu9UWMW2sGKuGn1JnGup+BbMF+/VylMR51pue2Blokpi2wuoKRoI
         AC/PiLnRKpA2JnymMy7bQeurM8oZkkPuyhm1I4kBuD8aj0sZ4ZrDpuxmGJexAGal8GP3
         pJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uioeUW0b5QfjzsCcQLCYz9oQ5uQ4Sn5bsToPRxmO2s=;
        b=cOwmu+ntUdKf1sd7bSEhj9PfAdgt8eXPrau5JjLWITePqR3tp1Id1WggtSI4fYAv+q
         Hr007tPQor3sAmEmnHYrEDC3dS5Z62YYe6TJwhcBH/09FR3ahGAGzx4bSIb1c3Bhinbc
         kl9HdWeclFqRzmwO1P4DdTUFZFGXk/7vHe6YtQ08wh0FwxRQv62XFJR+XLK+p4lo7XgR
         JSqE806Qv5BjNhLOhzknKS65unAGkdK+CiWTaeIX68O7SC3XLl+3WVY2YqdeMJyzg+Q7
         PIfa9SzTEf9D1GWDRy6HkyLOAnRK36KcMEZgkel5+5EnrnBwa6P6v4G5eIFZrpIk4smd
         xcPw==
X-Gm-Message-State: AAQBX9cVyKGAYdr6p9zgrGw+E9eQ7pzeVqR82wbbGgZX7XHTXhNWWMxK
        ZOx1NBf/0g4tldgo4neBX4lV9FlOqKfyiBJtSzgfcNfnmnkQ0CU6
X-Google-Smtp-Source: AKy350Y1MR+BaIB7nk22Q/ip4wTWcomWFt/7dkSX8lPQbvnLmG6x9trv2/5KZXGzHqJKzbl9G3EpL5MjX7mkZ3N4eHY=
X-Received: by 2002:a17:902:ecd2:b0:1a2:278d:1824 with SMTP id
 a18-20020a170902ecd200b001a2278d1824mr123343plh.12.1679672112173; Fri, 24 Mar
 2023 08:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230310070039.1288927-1-zyytlz.wz@163.com> <ZBx8S0tSz/Ot+xw7@kroah.com>
In-Reply-To: <ZBx8S0tSz/Ot+xw7@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Fri, 24 Mar 2023 23:34:59 +0800
Message-ID: <CAJedcCznj8Ve7GOJxopG6X9eDXfi8MMKr+BtTZK7D1xDf0PaBQ@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: udc: Fix use after free bug in
 udc_plat_remove due to race condition
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=BA=94 00:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 10, 2023 at 03:00:39PM +0800, Zheng Wang wrote:
> > In udc_plat_probe, &udc->drd_work is bound with
> > udc_drd_work. udc_drd_work may be called by
> > usbd_connect_notify to start the work.
> >
> > Besides, there is a invoking chain:
> > udc_plat_probe
> > ->udc_probe
> > ->usb_add_gadget_udc_release
> > ->usb_add_gadget
> >
> > It will add a new gadget to the udc class driver
> >  list. In usb_add_gadget, it uses usb_udc_release
> >  as its release function, which will kfree(udc)
> >  to when destroying the gadget.
> >
> > If we remove the module which will call udc_plat_remove
> >   to make cleanup, there may be a unfinished work.
> > The possible sequence is as follows:
> >
> > Fix it by finishing the work before cleanup in the udc_plat_remove
> >
> > Fixes: 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys UDC Platform drive=
r")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/usb/gadget/udc/snps_udc_plat.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadge=
t/udc/snps_udc_plat.c
> > index 8bbb89c80348..6228e178cc0a 100644
> > --- a/drivers/usb/gadget/udc/snps_udc_plat.c
> > +++ b/drivers/usb/gadget/udc/snps_udc_plat.c
> > @@ -230,6 +230,7 @@ static int udc_plat_remove(struct platform_device *=
pdev)
> >       struct udc *dev;
> >
> >       dev =3D platform_get_drvdata(pdev);
> > +     cancel_delayed_work_sync(&dev->drd_work);
> >
> >       usb_del_gadget_udc(&dev->gadget);
> >       /* gadget driver must not be registered */
> > --
> > 2.25.1
> >
>
> Please test this to verify that it actually works.
>

Hi,

Sorry for my late reply. I will try to simulate a device in qemu to test.

Best regards,
Zheng

> thanks,
>
> greg k-h
