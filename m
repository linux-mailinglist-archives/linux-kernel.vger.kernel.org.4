Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0A6B7BD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCMPWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjCMPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:22:06 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC16A071;
        Mon, 13 Mar 2023 08:22:04 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id bd34so7855471pfb.3;
        Mon, 13 Mar 2023 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678720924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTyO/9ZmM0cOmu22LQH6dmHPpqco2vKj6dSQiP5p41s=;
        b=ppZnoxVR5AAfpU/KGZzcxQFGGxNOObkyF8LxhcD8i/ha8cuhaX6Zv6yog6C3mhwHG6
         d0CejPsiVMgr3tpgCLyQrrGm+JHnmcL6uzmOhijtsl5w6PVMS8SyeoE9su81jhk5KKuu
         kuWb/+EVfHLQyw6KoPRSGba96PEXjMbd/73xDgv3wc5BGcAFjiyn11O4vW/Chl3uu8A5
         q3CJp9ZIHxEGFEtE/s/EkFomntEngiceOnxY/piq51O7EZnmMWRqpYIQPnnfdR2VDfw2
         O+LL2PQ8srn3es2Lt/NtyfHRI7eFJNwFyzUa/FsYu9Dq9UQrpby5xeJpNfa4R8cMP0rt
         5FAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTyO/9ZmM0cOmu22LQH6dmHPpqco2vKj6dSQiP5p41s=;
        b=hIOIolu2ea8ZM0kYxO4xAgCv8ogpEjba1GpCvJ1nVvBvt4kXss7O8z1SINJ5ZJYhYQ
         TG7026ulk6JyVljhX9WH/V+y/Zm94ERir6bvgzZfkVbsZTQX2MS3MCfWUnVdS745Pz73
         UT6wTBHwYyikaM35baaPe8arhXvriyhFVYPcr00+N6FKKO87oHYgVglK40bxiEUba+Gx
         T3jf+B30ZLmcG+nAPIL74uduopRDHzdxRw43/l05dmVediQPEtDLNwH42o01ORRpWSIZ
         d8ma9kVz3SsA5g2XzWMyO3wSi8Gilb1uuPtdw6LZafsJeJRCk7Pf24JknTFNookBCgPE
         z3Kw==
X-Gm-Message-State: AO0yUKUUAGZLsoRRW7XxjxMAUNZeAFqC+e3L2cMhSe6ZI+OPhFVgavSa
        kZln/MMqAM/hq10OwilmVTDYYHl0zLPLX3+7i2s=
X-Google-Smtp-Source: AK7set+I6a1Y0f7B4akZS8xTngpVdq0U6WFlHI9NnjzD6BomZZWSD4VR9IDEHPUqTRpPEa+y4/JzdGvAIf7JwIU9pMM=
X-Received: by 2002:a65:6687:0:b0:502:f20a:6e0a with SMTP id
 b7-20020a656687000000b00502f20a6e0amr3733876pgw.0.1678720924097; Mon, 13 Mar
 2023 08:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230307154157.1184826-1-zyytlz.wz@163.com> <43b48f87-2343-5855-e6c2-8f30319687c5@xs4all.nl>
In-Reply-To: <43b48f87-2343-5855-e6c2-8f30319687c5@xs4all.nl>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 13 Mar 2023 23:21:52 +0800
Message-ID: <CAJedcCz_CT9wMexVyt1bH_SPUYV=Lq3V5LY5aus5PYd7hQACTw@mail.gmail.com>
Subject: Re: [PATCH] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Zheng Wang <zyytlz.wz@163.com>, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
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

Hans Verkuil <hverkuil@xs4all.nl> =E4=BA=8E2023=E5=B9=B43=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 23:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On 07/03/2023 16:41, Zheng Wang wrote:
> > In hantro_probe, vpu->watchdog_work is bound with
> > hantro_watchdog. Then hantro_end_prepare_run may
> > be called to start the work.
> >
> > If we close the file or remove the module which will
> > call hantro_release and hantro_remove to make cleanup,
> > there may be a unfinished work. The possible sequence
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
> >  drivers/media/platform/verisilicon/hantro_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/=
media/platform/verisilicon/hantro_drv.c
> > index b0aeedae7b65..80bd856a4da9 100644
> > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > @@ -1099,6 +1099,7 @@ static int hantro_remove(struct platform_device *=
pdev)
> >
> >       v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
> >
> > +     cancel_delayed_work(&vpu->watchdog_work);
>
> Use cancel_delayed_work_sync(): that ensures the code waits for a running
> watchdog function to finish.
>
> Ditto for the other patch.
>

Dear Hans,

Thanks for your advice. Will do in  the next version of patch :)

Best regards,
Zheng

>
> >       media_device_unregister(&vpu->mdev);
> >       hantro_remove_dec_func(vpu);
> >       hantro_remove_enc_func(vpu);
>
