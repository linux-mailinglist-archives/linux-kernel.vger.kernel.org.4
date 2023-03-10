Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56526B4CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjCJQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCJQ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:28:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B47512B3D1;
        Fri, 10 Mar 2023 08:25:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so9576745pjb.5;
        Fri, 10 Mar 2023 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678465518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZckrDh0gNUjjPnxw6spU9sZzJ4TszybOgyApFqlu7U=;
        b=LU7+073O6w5U52IXebrmCaUh8hNcAo33J7HqB2q3WawBCue6VU6yp37Nhdezu/MJVR
         mFoN8iEGpgvqjEW5JzJoCvOygDMtWyJ+YS0Uu1kErjxxzoZfIv70As1YtIE7qrOMkk3z
         MrRTe9X2DpYdJWvypqemJtZZND4CLT+CDYg9nKkTDo7ZY42sN2sWEULZVdJ3n+ntbzH3
         hvZdf72swe/0aPELOy2Q3e1VmNSAZUSBNl/I6dAV0f2K1dTN9eu4VTNsCh52EsNHYfdA
         37fwk6WgYAiGIsmYc+G2FH66YnAUFvxQMN+r1AGIou6Tjnt6asN1Pls9HpR95mJDnvub
         xT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678465518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZckrDh0gNUjjPnxw6spU9sZzJ4TszybOgyApFqlu7U=;
        b=iSul0KhNgkruVz4fhm1HvETtkCKdWrtfVHKEUXse9f9vRCpbKC4V0oiysH2utkypwV
         suZfHK4xcpCMUOOT3Ynk6VNbdSxuME9d+beq8YkmCPrUbVrSxYpu4oVxW4eug4ta+q1I
         GgcFHVLbi4Bi5q8XRapw+EeWQRJUiiWtoZUDfMTLJvc9JwYkYB06T+tO+w3LY7kxQa5w
         VkBEqnPMdLEm2sT1v70qtBqNF42fTrqzs8EipdsPFrlvnZIXSyujI7jFBQ5SsDhHr1RS
         SRNnyyJxMV+rQ4zaUtjAlCIC0PGtlBBzj0XG14BcZXIZGjOANUxOAHOcCsWqxC3u3f/p
         /ctA==
X-Gm-Message-State: AO0yUKVViP214yzZdXOdXLR9XEaG0US1+rLIYJOi+FSTRoLoE5ECaIvC
        YI2z5Dq1BkXcvtBVj+82tdN2jweLQ7bKBMvsnMr4/I6nRquf6dCK
X-Google-Smtp-Source: AK7set8+qo+SOVmBxISEqgS/Jk5ePIN5CsE2VCL/n6TBHX+YlJnKbNcENSGjcwXTAzOWa9HHRyjL/Yqa5pVjBiagi6A=
X-Received: by 2002:a17:903:25d2:b0:19a:ec61:98d4 with SMTP id
 jc18-20020a17090325d200b0019aec6198d4mr9940965plb.0.1678465518660; Fri, 10
 Mar 2023 08:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20230309174728.233732-1-zyytlz.wz@163.com> <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
In-Reply-To: <e5b1ee16-796e-43fe-b703-3ce06aed364d@mercury.local>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sat, 11 Mar 2023 00:25:06 +0800
Message-ID: <CAJedcCzBWAHf=MQMDtL2bpCmCAyZGeeUyE1jFUgchXjRBZrC-g@mail.gmail.com>
Subject: Re: [PATCH] power: supply: bq24190: Fix use after free bug in
 bq24190_remove due to race condition
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com
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
=E6=9C=8810=E6=97=A5=E5=91=A8=E4=BA=94 07:40=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, Mar 10, 2023 at 01:47:28AM +0800, Zheng Wang wrote:
> > In bq24190_probe, &bdi->input_current_limit_work is bound
> > with bq24190_input_current_limit_work. When external power
> > changed, it will call bq24190_charger_external_power_changed
> >  to start the work.
> >
> > If we remove the module which will call bq24190_remove to make
> > cleanup, there may be a unfinished work. The possible
> > sequence is as follows:
> >
> > CPU0                  CPUc1
> >
> >                     |bq24190_input_current_limit_work
> > bq24190_remove      |
> > power_supply_unregister  |
> > device_unregister   |
> > power_supply_dev_release|
> > kfree(psy)          |
> >                     |
> >                     | power_supply_get_property_from_supplier
> >                     |   //use
> >
> > Fix it by finishing the work before cleanup in the bq24190_remove
> >
> > Fixes: 97774672573a ("power_supply: Initialize changed_work before call=
ing device_add")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
>
> Thanks, queued to fixes branch.
>
Very glad to hear that. Thanks  for your effort.

Best regards,
Zheng

>
> >  drivers/power/supply/bq24190_charger.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/sup=
ply/bq24190_charger.c
> > index be34b9848450..de67b985f0a9 100644
> > --- a/drivers/power/supply/bq24190_charger.c
> > +++ b/drivers/power/supply/bq24190_charger.c
> > @@ -1906,6 +1906,7 @@ static void bq24190_remove(struct i2c_client *cli=
ent)
> >       struct bq24190_dev_info *bdi =3D i2c_get_clientdata(client);
> >       int error;
> >
> > +     cancel_delayed_work_sync(&bdi->input_current_limit_work);
> >       error =3D pm_runtime_resume_and_get(bdi->dev);
> >       if (error < 0)
> >               dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", error);
> > --
> > 2.25.1
> >
