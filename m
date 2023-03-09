Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E016B1A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 04:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCID6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 22:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCID61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 22:58:27 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C255053;
        Wed,  8 Mar 2023 19:58:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s17so312207pgv.4;
        Wed, 08 Mar 2023 19:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678334306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmCxRJAwty6b/2EGqOb1mSmCTea85Ex1MqYRon3VirM=;
        b=PQDsKeYQ0FvqjtrJ3LGUtbdrCu24FAps1LQEeOwYDV8sGffspl6yyyTZOmEchFlbh2
         pIYHlHModyAUY/FhgFVS9CE2IGvayNNTTyFUNOIulUs/tcU1cQh3L0zn/IyHLTZk+jUu
         +hN5UQT9TXT3YJGM+rJS1AKQZz8VVc1czsHUUgro/Zy3FTx6aqTVg+FSYqfi+u9fkPpu
         NCT8kV8cxDnPkvsP6LgO/ce8h94VU/7g5q2PbbEoiiuxWzld3qTNoivoZblLOc/sCwXP
         SnzzdoP7NquhUF62FHpyqQFtbaMZoIGx3DbERxiYuQq26Yb+FB5Zpr9Gvaopjt6p4hCW
         jDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678334306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmCxRJAwty6b/2EGqOb1mSmCTea85Ex1MqYRon3VirM=;
        b=bOmdI0A5bg+fhM7SsvolxS9BonBAiLTwc+nD/tiEosqSvwMtq9taMjt9QmOQQVZ2ZN
         ofBftxBRrh5jb1GMkLZTlxupofmNrAiHm6vjzq/JFUK3+CduvdePAHRlyHdfnpbZ9usl
         JqxUm2d7H4NiswwTFKddX3ex6xGWedxsAeguadufBEPfpkkEnpvVeW0zaSTJ/wHylKvO
         ZvvQeTYOKbb9PWr5hQ/qDb8Go+WuKDw33KjQSeoWNZOu5+LidCWmcJySOny7eip1eGaS
         nM+3hiClqhEElzrIe5uM7tleji24msfk/SDiQlMuYJSlclMRy/6exRWxjXKyb9fpSNFC
         mh8A==
X-Gm-Message-State: AO0yUKWC/HPd/ZkZFvPCdzsDI3MgatCVPOemgdWD/ahsKOccyqwX6xms
        dkmfw+70aJvQ4zVKlWniwEGg+9YBjiiA0U8wsz53o61WeZZ40rSR
X-Google-Smtp-Source: AK7set/euvZgnXAe7GlvSz/eRYCPls6/DK2w/wRld8xz6VWJXHmDQ7EO0SQsPXGR2mZDG+XiOx06YqhJdxG3dqPep1c=
X-Received: by 2002:a63:8c17:0:b0:503:7be0:ea51 with SMTP id
 m23-20020a638c17000000b005037be0ea51mr7172255pgd.9.1678334305713; Wed, 08 Mar
 2023 19:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20230302093715.811758-1-zyytlz.wz@163.com> <d27127a1-2572-4ad4-b69c-8a6f53384009@roeck-us.net>
In-Reply-To: <d27127a1-2572-4ad4-b69c-8a6f53384009@roeck-us.net>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Thu, 9 Mar 2023 11:58:12 +0800
Message-ID: <CAJedcCxYQYmORfnqcdudFKwy9hhU=mZh_d9MM7x+37ies2S-MA@mail.gmail.com>
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to uncanceled work
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zheng Wang <zyytlz.wz@163.com>, mchehab@kernel.org,
        bin.liu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, 1395428693sheep@gmail.com,
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

Hi,

Thanks for your reply. I think you're right. I don't know if there is
other method to stop new work from enqueing. Could you please give me
some advice about the fix?

Regards,
Zheng

Guenter Roeck <linux@roeck-us.net> =E4=BA=8E2023=E5=B9=B43=E6=9C=889=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Mar 02, 2023 at 05:37:15PM +0800, Zheng Wang wrote:
> > In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> > mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> > and mtk_jpeg_enc_device_run may be called to start the
> > work.
> > If we remove the module which will call mtk_jpeg_remove
> > to make cleanup, there may be a unfinished work. The
> > possible sequence is as follows, which will cause a
> > typical UAF bug.
> >
> > Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> >
> > CPU0                  CPU1
> >
> >                     |mtk_jpeg_job_timeout_work
> > mtk_jpeg_remove     |
> >   v4l2_m2m_release  |
> >     kfree(m2m_dev); |
> >                     |
> >                     | v4l2_m2m_get_curr_priv
> >                     |   m2m_dev->curr_ctx //use
> >
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > index 969516a940ba..364513e7897e 100644
> > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > @@ -1793,7 +1793,7 @@ static int mtk_jpeg_probe(struct platform_device =
*pdev)
> >  static int mtk_jpeg_remove(struct platform_device *pdev)
> >  {
> >       struct mtk_jpeg_dev *jpeg =3D platform_get_drvdata(pdev);
> > -
> > +     cancel_delayed_work(&jpeg->job_timeout_work);
>
> The empty line is needed (coding style). Also, this doesn't cancel
> the worker if it is already running. This should probably be
> cancel_delayed_work_sync(). Even then the question is if it is
> possible that new work is queued before the device is unregistered.
>
> Guenter
>
> >       pm_runtime_disable(&pdev->dev);
> >       video_unregister_device(jpeg->vdev);
> >       v4l2_m2m_release(jpeg->m2m_dev);
> > --
> > 2.25.1
> >
