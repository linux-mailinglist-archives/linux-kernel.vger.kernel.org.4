Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7896B4DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCJQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCJQ4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:56:43 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB1F13480C;
        Fri, 10 Mar 2023 08:54:14 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z11so4044588pfh.4;
        Fri, 10 Mar 2023 08:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhj/T2JAbAb2Xd/ZH/KpcyXn4Xm3/uzp1Viq6gN5yfg=;
        b=kEmv3bahZ4kT7Bgitz3YOaRHAH3HUSL/SOaTq6y72fEeUVYNtU9MpgEoznR4JDsXYO
         WA3uNxWfsBZvev0fWhNeDT0IsnU+I1ozxM4NMjN/LWBZtSRjo4wS9SeAGjntOy4phe8a
         CXpAcECfi3v2cixNZC6KTmInGF0KP1jQ/IL7wysfLAY20B2yHsO3Vv3gaz6sxe1UpzCp
         ySUQcN66Gs/2CvwkiNVQML6jTtFxn2PEAQH/b/Y3niB26Uvef4gUXScT3/+O9zTeEZAE
         NK9ASCULKgAhViXZzLhxJKD46AOLt6XnflnMUBqlt3JLsFgi8QVK+dTn806g+gDZjT7y
         3Hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhj/T2JAbAb2Xd/ZH/KpcyXn4Xm3/uzp1Viq6gN5yfg=;
        b=iWyPTgSkLvIgbBWjSQxQcRTG7SKIZmrQesLsjzB7caEdnQVuGrd3Cxkctqi6lgC0vL
         qfif57yzNZNlD3ap6w682P7FaMcBLzXj4UtIa/99pEwUuSrdSjy3LLxd44jNhrq/zrIj
         G7g1sCPBnR5NFl9KVlHvWKbAqM8AhNJsZGV/x5SfFanEujlEVOVHehDz9lY+bdca8A4Z
         63MnHltDhgcWWfGzWO+S94NlkBL/J5GdzWufxppsh73qqbjG85V4rSnxErlamjjm+zF8
         stqa9k0aPEy85PoUVSih3cpHkizN1iY9Mo0LP0E1mTOSf+JKko4bnkvfwiMcVCGfgxnO
         TPbg==
X-Gm-Message-State: AO0yUKUdvJwANBQy6VeerSw0IFD9EbIirnkBkF5xJcLH5/74iSancKlv
        F0YdQchDnOhtwUkfjJ2GIpzL05zsuTGN4n6gh01jWetGe+GgRhnf
X-Google-Smtp-Source: AK7set8F8jqzFxLwkszNRCT8C9n9XrJBNqQp31z8CnpW1a20zVP3ANGrXKND50vZp0yf2IrXA/GIlPZnuAIUAC7/xDI=
X-Received: by 2002:a63:b003:0:b0:503:91ff:8dd8 with SMTP id
 h3-20020a63b003000000b0050391ff8dd8mr9119275pgf.4.1678467253430; Fri, 10 Mar
 2023 08:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20230310084007.1403388-1-zyytlz.wz@163.com> <329d128b-5436-44ad-89a3-75d82a7a11ec@roeck-us.net>
In-Reply-To: <329d128b-5436-44ad-89a3-75d82a7a11ec@roeck-us.net>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 11 Mar 2023 00:54:01 +0800
Message-ID: <CAJedcCwC+hVK+55eA-Mpwcr24oJxw+7WhA+RFU+36QpKgA_Ggw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (xgene) Fix use after free bug in
 xgene_hwmon_remove due to race condition
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zheng Wang <zyytlz.wz@163.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Guenter Roeck <linux@roeck-us.net> =E4=BA=8E2023=E5=B9=B43=E6=9C=8811=E6=97=
=A5=E5=91=A8=E5=85=AD 00:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 10, 2023 at 04:40:07PM +0800, Zheng Wang wrote:
> > In xgene_hwmon_probe, &ctx->workq is bound with
> > xgene_hwmon_evt_work. Then it will be started.
> >
> > If we remove the driver which will call
> > xgene_hwmon_remove to make cleanup, there may
> > be a unfinished work.
> >
> > The possiblesequence is as follows:
> >
> > Fix it by finishing the work before cleanup in the
> > xgene_hwmon_remove
> >
> > CPU0                  CPU1
> >
> >                     |xgene_hwmon_evt_work
> > xgene_hwmon_remove   |
> > kfifo_free(&ctx->async_msg_fifo);|
> >                     |
> >                     |kfifo_out_spinlocked
> >                     |//use &ctx->async_msg_fifo
> > Fixes: 2ca492e22cb7 ("hwmon: (xgene) Fix crash when alarm occurs before=
 driver probe")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>
> Applied.
>
Thanks for your effort.

Best regards,
Zheng
>
> > ---
> >  drivers/hwmon/xgene-hwmon.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
> > index 5cde837bfd09..d1abea49f01b 100644
> > --- a/drivers/hwmon/xgene-hwmon.c
> > +++ b/drivers/hwmon/xgene-hwmon.c
> > @@ -761,6 +761,7 @@ static int xgene_hwmon_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct xgene_hwmon_dev *ctx =3D platform_get_drvdata(pdev);
> >
> > +     cancel_work_sync(&ctx->workq);
> >       hwmon_device_unregister(ctx->hwmon_dev);
> >       kfifo_free(&ctx->async_msg_fifo);
> >       if (acpi_disabled)
