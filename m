Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F346D3C32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDCDok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjDCDoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:44:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3B93CE;
        Sun,  2 Apr 2023 20:44:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l184so7536316pgd.11;
        Sun, 02 Apr 2023 20:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680493476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABIEor5TUeJHEYPxHRe9G0HA55UHNeIWMnGb6d3/ufo=;
        b=f0TkVixjbShwJwnR/hrlNRRc9BwBH0b435kvRm7U9rP7IKq5Ia1oZXCXK7uEGvQ18d
         0QRO+414ydA1cOGQgSodGoIGMG0CaO7Iq3oRJvwTV+X3ZZPF0GGMKlaBn+Pi/WXM/31M
         akn+QLbs+rcWP9z5OlnllAVIyu0u1EkVsTwxRCyq55UHkRbDVqDppMLdld4z+dXfBw7v
         opyJ/PoHzEYcgpA/00VuHvryvq4ljWoj0cTodmeNWfIrcq8nPBc25HYGNIj1tsauCoJz
         Ylcqvd2SWYYZrO0GDP6rAE6yn+3bQhdee1JwbKYczl8W5wrD0++tE/OPfhVV6O+p29x/
         osxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680493476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABIEor5TUeJHEYPxHRe9G0HA55UHNeIWMnGb6d3/ufo=;
        b=pjfEU8gwG3Bf6rLiGyxdMH3QDAU4k1uG2wt3x7LsTBq3KWHoFSNQ/d1lKVE9jDLnFt
         TDQJqIE9XXGQ+jeO4kCh/7HuQG2pyuSBEJBffFDedxos8wFWFf7CW/1BPZx+JCPTKa9F
         bx7dg6Hj97zMlpG7fj3tbAhEj5kYM54lAAZ2N8MBdbrJwGQeJEJiedJKWK07AUtMU8/g
         GpKeLp3g+ZIr4DD9XBE+hc4+/wLuDG8CF1GBzyjMrWGvxTPAl3pOy1CDwEh/UFcU4nS7
         jvIdE0uXtqoBJSBB/SzTFUNYOdMbvMxm+GQCwVP17V/ndovSChGxWctRlLSnNha33yGa
         AnQg==
X-Gm-Message-State: AAQBX9dz4BvBgNVHLYqxhhBeYDFRUd8h370mbyZLot03nXjRpdYW7Kml
        RIMHgE+FpaYd/e3FqdbR9ZxuWm1hOjMb6s3OIG0=
X-Google-Smtp-Source: AKy350bWZfPX2SN3YYi/hFG3M2gCBUBYb4wgj6bMZme/ir4hqykgeRQrFyjod1786jAdXSyrywhtwreTcmY1+T2ZsB0=
X-Received: by 2002:a05:6a00:881:b0:62d:dd8d:56ac with SMTP id
 q1-20020a056a00088100b0062ddd8d56acmr5249726pfj.0.1680493476386; Sun, 02 Apr
 2023 20:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230313154132.3684181-1-zyytlz.wz@163.com> <CAAEAJfAjND_Bj9HRBae22eO7cG_Xm=AX93bL+CPEb24-sitWTg@mail.gmail.com>
In-Reply-To: <CAAEAJfAjND_Bj9HRBae22eO7cG_Xm=AX93bL+CPEb24-sitWTg@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 3 Apr 2023 11:44:24 +0800
Message-ID: <CAJedcCyr2DEux=bSU+4Ksgz69ouEHebhmcmoCa2ysYB1YiOaNQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Zheng Wang <zyytlz.wz@163.com>, p.zabel@pengutronix.de,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl
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

Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> =E4=BA=8E2023=E5=B9=B43=E6=
=9C=8831=E6=97=A5=E5=91=A8=E4=BA=94 10:38=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Zheng,
>
> On Mon, Mar 13, 2023 at 12:42=E2=80=AFPM Zheng Wang <zyytlz.wz@163.com> w=
rote:
> >
> > In hantro_probe, vpu->watchdog_work is bound with
> > hantro_watchdog. Then hantro_end_prepare_run may
> > be called to start the work.
> >
> > If we close the file or remove the module which will
> > call hantro_release and hantro_remove to make cleanup,
>
> It's not possible to close the file or remove the module while a watchdog=
 is
> scheduled.
>
> That's because the watchdog is active only during a mem2mem job,
> and the file won't be closed until the job is done.
>
> v4l2_m2m_ctx_release calls v4l2_m2m_cancel_jobw
> which waits until the job is done.
>
> If you can confirm it's possible to remove or close the file
> while a job is running, that would be a driver bug.
>
> Thanks for the patch, but it's not needed.
>

Hi Ezequiel,

Thanks for your detailed analysis. Got it :)

Best regards,
Zheng

> Regards,
> Ezequiel
>
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
> > ---
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
