Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E36B4CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjCJQ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjCJQ2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:28:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401712A167;
        Fri, 10 Mar 2023 08:24:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so10375193pjb.3;
        Fri, 10 Mar 2023 08:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgoQlOpy4b0B8nZEaFVrMLHwu8XAr3moy3RuUVCTb+U=;
        b=f9wLgtG3MTPeNDZlgCrh06fw/uLN3mr+fBgfLcSanP1SmhPI+KLxCwwdDxkL2v2P3s
         lyLa/RNZG4SOhylUZydLb6Esv5HBs57trvRj3yBWSvPyA5zX+ft+XlGxy62315JQur1b
         R2ETtKASVPtFV1BClXj6y/grX74G5wgws7TKVGiJOu+G/B5C9eYNdGSsg7J0gxqmMAxx
         4hN/rluhNRqnvYXwQ/Qes7uUALbCLjMhAEg2kfA4bFtzMYESbf+mQZXsCEspbn7FvwBM
         Of2jjlO1vrsIJw+4S8ehevrHl4A5IDcHiI8JPMeADjhk2O94DU6h4WwKQYPmTuSdwV+U
         pdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgoQlOpy4b0B8nZEaFVrMLHwu8XAr3moy3RuUVCTb+U=;
        b=tjP2T32k4+5l1736Xj1qj2JshxTEc95jSHSK/yGLmWB9ABRA/hb7CoxzfecchcJ7lo
         e2BxXem6DqI+57FV4Mnp2zvn98kmuH8FsCu0Hv9Cg0IneKxQ8qh1darCB+Xx8+iIsIij
         Jv5Y5wQh4r2MngHVoChXQY7T6bHCla6aX8N9KSASi1PDiysZs1qrcRf0p9nXrmVXv7B+
         2uOxpxLuOJZJEk0Hra/WV90Qnaw+i1aW3xGZv7Zj57QHKmYvFHOKI8yDT3YAcneBQJKc
         O735Mj2YGDIU36FuoArL5SLQet+vCd/5DHfm6/tRYIDFFzO6zxDVr4fZ90QEGi+HbKrb
         9Wmg==
X-Gm-Message-State: AO0yUKUf4pltAWggkqioycmLIbRKOA1dwExoTfIiYNCeuft06DcqGZuq
        EABtPq5KcS+VssNGv+BbSn4HgoRPKTHKRqp+U3Q=
X-Google-Smtp-Source: AK7set+zisO5NUbf2wsvJwCJJmhHGGvYu2ER1SV1tgaoWCyvbfT/kZuk+GzHUaAB8z+UjhcA+6WXkQ/56ySAK06S1Co=
X-Received: by 2002:a17:902:ef92:b0:19a:8259:c754 with SMTP id
 iz18-20020a170902ef9200b0019a8259c754mr9776611plb.0.1678465470776; Fri, 10
 Mar 2023 08:24:30 -0800 (PST)
MIME-Version: 1.0
References: <20230309181036.262674-1-zyytlz.wz@163.com> <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
In-Reply-To: <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 11 Mar 2023 00:24:18 +0800
Message-ID: <CAJedcCwt7agR8Y76Rsj5d9HK2oYJZi_QGh11v97L31QR+RDZ+A@mail.gmail.com>
Subject: Re: [PATCH] power: supply: da9150: Fix use after free bug in
 da9150_charger_remove due to race condition
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, support.opensource@diasemi.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
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

Sebastian Reichel <sebastian.reichel@collabora.com> =E4=BA=8E2023=E5=B9=B43=
=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 07:39=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, Mar 10, 2023 at 02:10:36AM +0800, Zheng Wang wrote:
> > In da9150_charger_probe, &charger->otg_work is bound with
> > da9150_charger_otg_work. da9150_charger_otg_ncb may be
> > called to start the work.
> >
> > If we remove the module which will call da9150_charger_remove
> >  to make cleanup, there may be a unfinished work. The possible
> >   sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>
> mtk_jpeg_remove?

Sorry that's mistake. I will correct it in the next version of patch.

>
> >
> > CPU0                  CPUc1
> >
> >                     |da9150_charger_otg_work
> > da9150_charger_remove      |
> > power_supply_unregister  |
> > device_unregister   |
> > power_supply_dev_release|
> > kfree(psy)          |
> >                     |
> >                     |         power_supply_changed(charger->usb);
> >                     |   //use
> > Fixes: c1a281e34dae ("power: Add support for DA9150 Charger")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
>
> Looks correct to me, but the cancel_work_sync should happen after
> usb_unregister_notifier(), otherwise there is still a race
> condition.

Yes, I agree that. Thanks for pointing that out. Will do in the next path.

Best regards,
Zheng

>
> >  drivers/power/supply/da9150-charger.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supp=
ly/da9150-charger.c
> > index 14da5c595dd9..41b68f2f6ed8 100644
> > --- a/drivers/power/supply/da9150-charger.c
> > +++ b/drivers/power/supply/da9150-charger.c
> > @@ -642,6 +642,7 @@ static int da9150_charger_remove(struct platform_de=
vice *pdev)
> >       struct da9150_charger *charger =3D platform_get_drvdata(pdev);
> >       int irq;
> >
> > +     cancel_work_sync(&charger->otg_work);
> >       /* Make sure IRQs are released before unregistering power supplie=
s */
> >       irq =3D platform_get_irq_byname(pdev, "CHG_VBUS");
> >       free_irq(irq, charger);
> > --
> > 2.25.1
> >
