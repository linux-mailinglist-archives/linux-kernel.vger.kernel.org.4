Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB7A6BAB74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCOJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjCOJCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:02:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5F74DDD;
        Wed, 15 Mar 2023 02:02:34 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id rj10so7500655pjb.4;
        Wed, 15 Mar 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678870954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CEcDEmXoRVWl82ME6fHeckhCMMz/JzH8Qe2yY0Hg9w=;
        b=JVEmSIMaQANB8xk77I+aEsBYyJy8eUt9ONydenSb6zd28LvVN+c1ukvfhKyZtHk34C
         6aEfo27NkX9f9ZsbyOLMYI7uSenfECx59QVpnEzlF4rCTXD1dCpa4hxcZTrgWXoy57zI
         Wf/EZjtDyG93VU7YbbLoZG5PBS3l8VFaa0FSmGCePCy/Hztw4Cfu264NqNot3ETrAETA
         vNIgUVXYLCZfruN1qzjkSttec6SdFwts56hNPqZgcC5GMd37umrdrUI2XwRLAVzakSaI
         aibKpept9EuTe/ADkIXrBDyPThVdOAp11/kCVMvCFUfZWIgMj6x+nCxgm446W8UamVgs
         zYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CEcDEmXoRVWl82ME6fHeckhCMMz/JzH8Qe2yY0Hg9w=;
        b=HO5GVAs9SwToP/hVa+dbUyBcfmEy6TIMNAKaGjZoENPy6Fr9Xrl291B3x/5ng914Hg
         3dF3/mmX9uMafBZLqS+dXmIng7sBb1K7EI6vPGy/cNpg54oF9Umvvwb+T6M9yzvOcrR+
         tSTQfKfnhlECRbP29aUI944QD6BJGZE9fXdabslO2GTWsjBSCTL4CT/hJzxH2mODGL4y
         pqOWcn537EoRPVmkTXMzTk3PlRoRJemLcAcYClPuzKBWRr+Ys2U5k1a3gapYVu82zpHe
         B+pIx96INV8witvL01mWmbj7rc3ptnQDHw2OcSBY4lwVP5YJZXjZDVvr99dV+C7mhN77
         IIyQ==
X-Gm-Message-State: AO0yUKXpoS5Uk2bkIt591+ON6ILEJcDT7uI/F+nJRDwQ5xv7EwpYJJtL
        Y3mfJnVw1MGhHcLfZzQT5nQzBusVMnqv31SlrTc=
X-Google-Smtp-Source: AK7set/wrbW0WOs81wp7/aYaD0/sSyDQBhq/b/bFgLbMDJLvM9oaPVrZIgoGdl+L5ysV8rV433iVAg2AX2WW/cj0cfw=
X-Received: by 2002:a17:90b:3794:b0:23d:360:8771 with SMTP id
 mz20-20020a17090b379400b0023d03608771mr3435547pjb.9.1678870954142; Wed, 15
 Mar 2023 02:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230313154856.3691660-1-zyytlz.wz@163.com> <CAAEAJfAtwguO-EpbCLkdOBu96U9mD+mq4PxBLsLAVZLuhC6Mtw@mail.gmail.com>
In-Reply-To: <CAAEAJfAtwguO-EpbCLkdOBu96U9mD+mq4PxBLsLAVZLuhC6Mtw@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 15 Mar 2023 17:02:22 +0800
Message-ID: <CAJedcCxn7nOVJMJ2U9Q-PL9M2cnKgJ_YqN801zfLyz-7TeFh1Q@mail.gmail.com>
Subject: Re: [PATCH v4] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Zheng Wang <zyytlz.wz@163.com>, p.zabel@pengutronix.de,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl
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

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=8814=E6=97=A5=E5=91=A8=E4=BA=8C 20:05=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng, Hans,
>
> On Mon, Mar 13, 2023 at 12:49=E2=80=AFPM Zheng Wang <zyytlz.wz@163.com> w=
rote:
> >
> > In hantro_probe, vpu->watchdog_work is bound with
> > hantro_watchdog. Then hantro_end_prepare_run may
> > be called to start the work.
> >
> > If we close the file or remove the module which will
> > call hantro_release and hantro_remove to make cleanup,
> > there may be an unfinished work. The possible sequence
> > is as follows, which will cause a typical UAF bug.
> >
> > The same thing will happen in hantro_release, and use
> > ctx after freeing it.
> >
> > Fix it by canceling the work before cleanup in hantro_release.
> >
> > CPU0                  CPU1
> >
> >                     |hantro_watchdog
> > hantro_remove     |
> >   v4l2_m2m_release  |
> >     kfree(m2m_dev); |
> >                     |
> >                     | v4l2_m2m_get_curr_priv
> >                     |   m2m_dev->curr_ctx //use
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Fixes: 932a9317ac49 ("media: hantro: Add helpers to prepare/finish a ru=
n")
>
> Thanks for the patch.
>
> Give me a few days to take a closer look.
>

Thanks for your reply. Hope you have a nice day :)

Best regards,
Zheng

> Thanks,
> Ezequiel
>
> > ---
> > v4:
> > - add Fixes label to help with the fix
> >
> > v3:
> > - use cancel_delayed_work_sync instead of cancel_delayed_work and add i=
t to
> > hantro_release suggested by Hans Verkuil
> >
> > v2:
> > - move the cancel-work-related code to hantro_remove suggested by Hans =
Verkuil
> > ---
> >  drivers/media/platform/verisilicon/hantro_drv.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/=
media/platform/verisilicon/hantro_drv.c
> > index b0aeedae7b65..86a4c0fa8c7d 100644
> > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > @@ -597,6 +597,7 @@ static int hantro_release(struct file *filp)
> >         struct hantro_ctx *ctx =3D
> >                 container_of(filp->private_data, struct hantro_ctx, fh)=
;
> >
> > +       cancel_delayed_work_sync(&ctx->dev->watchdog_work);
> >         /*
> >          * No need for extra locking because this was the last referenc=
e
> >          * to this file.
> > @@ -1099,6 +1100,7 @@ static int hantro_remove(struct platform_device *=
pdev)
> >
> >         v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
> >
> > +       cancel_delayed_work_sync(&vpu->watchdog_work);
> >         media_device_unregister(&vpu->mdev);
> >         hantro_remove_dec_func(vpu);
> >         hantro_remove_enc_func(vpu);
> > --
> > 2.25.1
> >
