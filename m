Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AAD6B6D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 03:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCMCub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 22:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCMCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 22:50:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493C226C12;
        Sun, 12 Mar 2023 19:50:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id n16so617332pfa.12;
        Sun, 12 Mar 2023 19:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678675827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEJiBD6642oVl+6mAIFfZT/xfi0W0Ya0AiErP2hj2K8=;
        b=FVKaKrZpDKYkWmKT2ozGMApI91pd3npAhjwSwjae8I44NPekjPyL735yXK4SasRrOZ
         n7EjL65PpzRBlqdkfXq8mgOQ2j31niKeDKMswAH1ff9HRb1pwlAwc0paReFsEHwZa3nW
         r2BrSOZWVPcI1An4asZl1ZV687kWlSP9K4lP9o17ZLw0Bu/pzrFxTD/JoLGiU8xoKJ6j
         0FParhbTZeQW2fKBDq9+HxkqOieFM1hxr2pVaQAp7BmFZojjiKHXGv9/0/i61mbnUIHS
         ghRVjr9uDWm/0U4LQ5GdfOWNihbAULdt2lCohEU5TouINH5WGzrC81Y/jXuR1wjJyLkd
         wX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678675827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEJiBD6642oVl+6mAIFfZT/xfi0W0Ya0AiErP2hj2K8=;
        b=K66i2+0M/eYnz1HptGm+Mk2vmVbdypSQQ9jwDdydEUO234gTDs6ZlEQgNSndkrtfqu
         L3icqjW7cVgpguuoCHNkQz1SG+UyH6FYrfJttRnHiGoH850LSzNyV90LY+0RM3rjiJnO
         oHYnoPIxKxu39f3aUBDAduySjRTFMWXLbRXqNIWveh1cpzaZDWKGUMFDNF1vuol9/qSK
         QwfGQbxarBhS1W/xBc1tjs1eKTUC0WcgzUO99hbH0ItcKOTmVf+me2VShlq9oq+fmSjB
         GzHIauUZtAF1+rdw1A1ySLTdc1Tw1EOvHZZVD5c7S/AeqkqSPCJdxelJMdVOamWo7Kl6
         hJHQ==
X-Gm-Message-State: AO0yUKXdqgDi6a2OXZF3i69fbkCahhOWZATG/dIiczZgebJSKhzVcGz4
        GaPn7AOq6ynNvjIqLp6GMapzKHemKOb9Hfg7BqU=
X-Google-Smtp-Source: AK7set8meipIL6umyzbSl8gsXRy1PGeQkPKr9Y3WkCZOIykoI2Lhq787xsZeG38PloN/Jcak0tsXaRABSJI7Mej3HPI=
X-Received: by 2002:a62:86c5:0:b0:5e9:57b1:5bda with SMTP id
 x188-20020a6286c5000000b005e957b15bdamr12359243pfd.3.1678675826473; Sun, 12
 Mar 2023 19:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230311174650.3979517-1-zyytlz.wz@163.com> <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
In-Reply-To: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 10:50:13 +0800
Message-ID: <CAJedcCy7-pNmHFC1VinXWUwvzh4cQ1yi4CSSEjgdfB1iidyjQw@mail.gmail.com>
Subject: Re: [PATCH v2] power: supply: da9150: Fix use after free bug in
 da9150_charger_remove due to race condition
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, njavali@marvell.com,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
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
=E6=9C=8813=E6=97=A5=E5=91=A8=E4=B8=80 06:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Sun, Mar 12, 2023 at 01:46:50AM +0800, Zheng Wang wrote:
> > In da9150_charger_probe, &charger->otg_work is bound with
> > da9150_charger_otg_work. da9150_charger_otg_ncb may be
> > called to start the work.
> >
> > If we remove the module which will call da9150_charger_remove
> > to make cleanup, there may be a unfinished work. The possible
> > sequence is as follows:
> >
> > Fix it by canceling the work before cleanup in the da9150_charger_remov=
e
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
> >
> > Fixes: c1a281e34dae ("power: Add support for DA9150 Charger")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v2:
> > - fix wrong description in commit message and mov cancel_work_sync
> > after usb_unregister_notifier suggested by Sebastian Reichel
> > ---
>
> Thanks, queued to power-supply's fixes branch. Please make sure you
> send your patches to the correct destination next time (linux-scsi
> should be linux-pm).

Thanks for your effort. I'll keep that in mind :)

Best regards,
Zheng

>
> >  drivers/power/supply/da9150-charger.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supp=
ly/da9150-charger.c
> > index 14da5c595dd9..a87aeaea38e1 100644
> > --- a/drivers/power/supply/da9150-charger.c
> > +++ b/drivers/power/supply/da9150-charger.c
> > @@ -657,6 +657,7 @@ static int da9150_charger_remove(struct platform_de=
vice *pdev)
> >
> >       if (!IS_ERR_OR_NULL(charger->usb_phy))
> >               usb_unregister_notifier(charger->usb_phy, &charger->otg_n=
b);
> > +     cancel_work_sync(&charger->otg_work);
> >
> >       power_supply_unregister(charger->battery);
> >       power_supply_unregister(charger->usb);
> > --
> > 2.25.1
> >
