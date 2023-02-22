Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D330269ED6F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBVDYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBVDYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:24:37 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97B25BA2;
        Tue, 21 Feb 2023 19:24:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id s15so2198651pfg.3;
        Tue, 21 Feb 2023 19:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08RoP9FqZ5LRh0lE+LPot9xk+WOzcbwKxkpm4lLjdlc=;
        b=J44cxmvqm067WA7UFA9kS1tZmSAaasG+U4ZbjNAwHrY1W9mMsMeqgbEl64t5m45NKm
         xuZ9Bk3c0IoCG8J6BdBtjy6q7i4kZ1R4Uv1CnV99NA7neCy8g8apTVBUfW8kKI9SeR+P
         fbcfXNA6gygapF2N/OnZi00vAkahV1Rr/cL2wN+YArzfjkHmUsENEq9XeGZPmKrmwp0Y
         OC7mOum3LzNIzquktPEMVT0vAA37/0PRk+DwzzbeXGHXKHM1TDfOCim+puOwgt7u/jeC
         uycwEenJmAK+UPCDg6DpGQ9gIUM+tbgpwafi4N+WnAXAgKOUXhY4PNS+IvtotiMSQ988
         s0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08RoP9FqZ5LRh0lE+LPot9xk+WOzcbwKxkpm4lLjdlc=;
        b=sQSDaov4wEYVLWdF4E1BDkzIxrgwRdPDLBGjFvhJz97ZH1iJM7Mc1hA2HTlg0SG4xA
         jgEht7I1jtQJHCQ7nuRfTP1Q8fCeltoq3TM4LEm5cJe88MZiQrUchecQ/1BVpfb6uTlj
         Mj95Odp0cqpkLHAJhW8Z/mxRwaKLkayRY91VS+ZKqA31hTkgiW7HUVI7pX1F1Bgp+kmb
         vd0Bq+FKx8AXVbkWeoryzGtIzp86svifsj8jfjwJfQ1cISlPAD52PKlE4QjZRHRTDZ9i
         Pkp5NT9EZ2cIEzoyKC5TPNqCXZewSa7PRm9Kc2yPMCk26Ud2EpVLFrelWDelIVtGGWBG
         VG9Q==
X-Gm-Message-State: AO0yUKU5mhJZqNGRTlxQrgWjBamJ8rqfxztUnCRaJi6Ef5jvtC5juCrE
        HSCcWzZgrW+TNEwuNniWRJ9VZchW/l3VsFPtRZo=
X-Google-Smtp-Source: AK7set94PuZmtKFqRhbuVnTkB5vjgbVsuRgrEOOyKMgWYBsWksN4RamTXAcKDx3zWaAJVDTxIIWOkV5xG6jaTiqQna4=
X-Received: by 2002:a05:6a02:196:b0:4f1:cd3a:3e83 with SMTP id
 bj22-20020a056a02019600b004f1cd3a3e83mr866833pgb.3.1677036274163; Tue, 21 Feb
 2023 19:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20230221094018.19840-1-zyytlz.wz@163.com> <20230221111529.2569-1-hdanton@sina.com>
In-Reply-To: <20230221111529.2569-1-hdanton@sina.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 22 Feb 2023 11:24:21 +0800
Message-ID: <CAJedcCxidOvqdTNp6Tk1ty4meh8htbqEbeOk2yhQhLsOVGRs=Q@mail.gmail.com>
Subject: Re: [PATCH] media: bttv: fix use after free error due to btv->timeout timer
To:     Hillf Danton <hdanton@sina.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hillf Danton <hdanton@sina.com> =E4=BA=8E2023=E5=B9=B42=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Feel free to add info like how this fix was tested.

Hi Hillf,

Sorry for my unclear description. I don't have the device to test. I
learn it from someone else's experience.

> >
> > Fix it by adding del_timer_sync invoking to the remove function.
> >
> > cpu0                cpu1
> >                   bttv_probe
> >                     ->timer_setup
> >                       ->bttv_set_dma
> >                         ->mod_timer;
> > bttv_remove
> >   ->kfree(btv);
> >                   ->bttv_irq_timeout
> >                     ->USE btv
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/media/pci/bt8xx/bttv-driver.c | 1 +
> >  drivers/media/pci/bt8xx/bttv-risc.c   | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/=
bt8xx/bttv-driver.c
> > index d40b537f4e98..24ba5729969d 100644
> > --- a/drivers/media/pci/bt8xx/bttv-driver.c
> > +++ b/drivers/media/pci/bt8xx/bttv-driver.c
> > @@ -4248,6 +4248,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
> >
> >       /* free resources */
> >       free_irq(btv->c.pci->irq,btv);
> > +     del_timer_sync(&btv->timeout);
> >       iounmap(btv->bt848_mmio);
> >       release_mem_region(pci_resource_start(btv->c.pci,0),
> >                          pci_resource_len(btv->c.pci,0));
> > diff --git a/drivers/media/pci/bt8xx/bttv-risc.c b/drivers/media/pci/bt=
8xx/bttv-risc.c
> > index 32fa4a7fe76f..ada469198645 100644
> > --- a/drivers/media/pci/bt8xx/bttv-risc.c
> > +++ b/drivers/media/pci/bt8xx/bttv-risc.c
> > @@ -481,7 +481,7 @@ bttv_set_dma(struct bttv *btv, int override)
> >       if (btv->curr.frame_irq || btv->loop_irq || btv->cvbi) {
> >               mod_timer(&btv->timeout, jiffies+BTTV_TIMEOUT);
> >       } else {
> > -             del_timer(&btv->timeout);
> > +             del_timer_sync(&btv->timeout);
> >       }
> >       btv->main.cpu[RISC_SLOT_LOOP] =3D cpu_to_le32(cmd);
> >
> > --
> > 2.25.1
>
> This patch adds chance for deadlock by replacing del_timer() with del_tim=
er_sync(), right?
>
>         cpu 0                           cpu 2
>         ---                             ---
>         bttv_read()                     bttv_irq_timeout()
>         bttv_reinit_bt848()
>         spin_lock_irqsave(&btv->s_lock,flags);
>
>                                         spin_lock_irqsave(&btv->s_lock,fl=
ags);
>                                         deadlock;
>         btv->errors=3D0;
>         bttv_set_dma(btv,0);
>         del_timer_sync(&btv->timeout);

Yes, it is. Thanks for pointing that out. Could you please give some
advice about the fix?

Best regards,
Zheng
