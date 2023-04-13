Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BF6E0AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDMKBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDMKBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:01:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B7393D8;
        Thu, 13 Apr 2023 03:00:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id m18so14371555plx.5;
        Thu, 13 Apr 2023 03:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681380052; x=1683972052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBhnYxxyT1F37VM08w2cTBhHQt0+UFI3RFjaOZbZoGw=;
        b=Iobep5d68kEdEirtKFUC5b/ZGMEbdqUe78Y03yqqAk3bog+Ovps6hvCashm4TiKQeq
         tLdPqWx3e5PEGrO0RXjjX7WPocjnxsetQuu9aBCL0KohGqXhYajqBt3lU5XwaRtoD3hM
         iaCG9CaKrbW92pR/T3fKIQpbV1wC1i1jFHVU67Z7LxQNNkNu5vBAnY0iECdsVf1dmlML
         tmMqewT87TiXdP1yBgYutejUiKp4xtN0cBLb6Ixw6feo7tIQeGNvYjaR7614YRz16NXJ
         j7vbPmqmzz5C2ymUgyqw+HwhltMkIt6B1NuNjLLJYXmLr33puWDPSd9hQ2swRIjKAWxK
         yNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380052; x=1683972052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBhnYxxyT1F37VM08w2cTBhHQt0+UFI3RFjaOZbZoGw=;
        b=iYiT6lYzpj4U2JS0NRhcHWi7zbH02dXw8gtBsi60VEAjuvz9CUH06mLWBI06iWsetz
         72XZYZHOPmPPzQGR6WC4ICJR6AwktUnlHJvpoy3A8W2mr7Pt4ed1O09kEYGFVALuug6x
         j4wCax7ojafOwbUCeYhNnNcgJMkI0ZYQLuAyuRqDNzmublapp1irlboswIWNUoqQXevm
         lC+VuI6ar+kUMyVDofm7MvKIrYjrkqGnoq81I242SBkwpkwYNSQt1OElLW4L6yJGGo/f
         pioOer33+DZjRD8JSNoY4aOPFqq5jRPbsuI4k6m6YTdTRrM0eCBnZvECQCQ2fXYPRTSm
         G0UQ==
X-Gm-Message-State: AAQBX9co7XZDpUEGIW2z7G4WUq7D7elLgIqCiVK1/mVW20hrVfIKAVso
        n4rS1S11o19L/V/LQfwgixu2ek2EwVeHF7/vRN4=
X-Google-Smtp-Source: AKy350ZwS1RKYq1keZGvHBeltyXtSP1+X6M4xTWwtI4iZKd4NhczFLgS+ugRKM/LT6mR/ojp8FP2PyZGeYEZm32eIuY=
X-Received: by 2002:a17:90b:815:b0:246:a1b2:77fe with SMTP id
 bk21-20020a17090b081500b00246a1b277femr2093973pjb.3.1681380052397; Thu, 13
 Apr 2023 03:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230413034942.40831-1-zyytlz.wz@163.com> <078e3a48-acdb-e6e4-8963-84ecf1c1429d@xs4all.nl>
In-Reply-To: <078e3a48-acdb-e6e4-8963-84ecf1c1429d@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 13 Apr 2023 18:00:40 +0800
Message-ID: <CAJedcCzndsT41OqWcuHKmZTeH-Mh9OvaucZ21iKS3si91JO5pw@mail.gmail.com>
Subject: Re: [PATCH v3] media: bttv: fix use after free error due to
 btv->timeout timer
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Zheng Wang <zyytlz.wz@163.com>,
        Deborah Brouwer <deborahbrouwer3563@gmail.com>,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex000young@gmail.com, security@kernel.org, hdanton@sina.com,
        mchehab@kernel.org
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

Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B44=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=9B=9B 17:18=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> Deb Brouwer is working on converting bttv to the vb2 framework, so I want=
 to
> wait for that to finish before taking other bttv patches.
>
> I suspect this is still valid post-vb2 conversion, but I'm not certain.
>
> Regards,
>
>         Hans
>

Hi Hans,

Thank you for your prompt response and for letting me know about the
conversion of BTTV to the vb2 framework by Deb Brouwer.
 I will wait for that to finish before submitting any other BTTV patches.

Best regards,
Zheng


> On 13/04/2023 05:49, Zheng Wang wrote:
> > There may be some a race condition between timer function
> > bttv_irq_timeout and bttv_remove. The timer is setup in
> > probe and there is no timer_delete operation in remove
> > function. When it hit kfree btv, the function might still be
> > invoked, which will cause use after free bug.
> >
> > This bug is found by static analysis, it may be false positive.
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
> > Fixes: 162e6376ac58 ("media: pci: Convert timers to use timer_setup()")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> > v3:
> > - Add Fix label
> > v2:
> > - stop replacing del_timer with del_timer_sync suggested by Hillf Danto=
n
> > ---
> >  drivers/media/pci/bt8xx/bttv-driver.c | 1 +
> >  1 file changed, 1 insertion(+)
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
>
