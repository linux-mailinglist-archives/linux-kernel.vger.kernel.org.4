Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB616B92AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjCNMHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCNMG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:06:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF553A1026
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:06:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id br6so1525942lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1678795559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiwpJTGyHZGzBTJ6bO/L3VPi9zr8P9+edvack9f3BcY=;
        b=oXKjUL3PN99TsGJfkkVW3ZjQMXxMvzk7uxSKoqFKjsZRbIj3gPJC7lry1kjKyok5ek
         TR+sxblfDrQzDAcRUYb8XyPFJSVm9ENzaV5W0OGfMx7MWAMtGjADzQvZKrVo7IhVHMZ8
         WssTu6DLR+8eHQ0fZGVx6FyaCm0p3fAZJ5gH+aSJVZAfGCNGvd29jsx5muLmJHhmQ1nd
         DfVFtURAFjzBsH8RJzM5QKnHG6Jd1N4+2Ld5tzwnmTvjFvss1snC7xRjc0qbwJfTi4ST
         KBJskFmfg0JxzFlm53ZCOjvBR8KHfDiXc2LYxTjwQ2Iwr1YNiwdUqAu+qXWHaZNhvgGu
         L7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiwpJTGyHZGzBTJ6bO/L3VPi9zr8P9+edvack9f3BcY=;
        b=n7y4DFH8TzgNAqYbyMVFaRdMGk9UIYKvVrxMmapx/jqCSXX9fVJxiVb/ofvGa+XHLJ
         fzrjirZRkyX8KuhBLcDo1aO4kcp0omnLsVkRWIZhMMiTUJMlf1DER++7tV611Uq2+TdT
         NSrf82I9O3a5TtDhyjvVyIUiCqX8iU/nL/w7BvmspmygmQnNhPDGbk35UiYF8MKhDear
         4P3W2djQ8EV9p7MvIhFyuc0+ZVmWaFfpj5CxYwOpbNJClkVkZ1AhDuNmeZrAf662O05u
         mwUD5yZGKQnSDYXV3zyYnUFX5LjAA7PMl/JlebRptseAPwsEHCZXP14ISv1laJrrqqK2
         eh4g==
X-Gm-Message-State: AO0yUKUW6S1ZGmv0qpdA/RvEANAbcee7Uy8lXP3E+NxoE+DWgX4T8pmG
        KHa4KvYrZShBCGJPgRVMBRPXlQmgt0bG9m2SbaCSjw==
X-Google-Smtp-Source: AK7set+xYCmAbdBdcQCNI7sIm82/tx9Sa1F3IEC5x1caHOueNOUHQCBW9vh55B4Cx5WeoEW5qFU+x10x7qPdCufrpck=
X-Received: by 2002:a05:6512:502:b0:4db:38ba:618d with SMTP id
 o2-20020a056512050200b004db38ba618dmr642772lfb.12.1678795559024; Tue, 14 Mar
 2023 05:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230313154856.3691660-1-zyytlz.wz@163.com>
In-Reply-To: <20230313154856.3691660-1-zyytlz.wz@163.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 14 Mar 2023 09:05:47 -0300
Message-ID: <CAAEAJfAtwguO-EpbCLkdOBu96U9mD+mq4PxBLsLAVZLuhC6Mtw@mail.gmail.com>
Subject: Re: [PATCH v4] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng, Hans,

On Mon, Mar 13, 2023 at 12:49=E2=80=AFPM Zheng Wang <zyytlz.wz@163.com> wro=
te:
>
> In hantro_probe, vpu->watchdog_work is bound with
> hantro_watchdog. Then hantro_end_prepare_run may
> be called to start the work.
>
> If we close the file or remove the module which will
> call hantro_release and hantro_remove to make cleanup,
> there may be an unfinished work. The possible sequence
> is as follows, which will cause a typical UAF bug.
>
> The same thing will happen in hantro_release, and use
> ctx after freeing it.
>
> Fix it by canceling the work before cleanup in hantro_release.
>
> CPU0                  CPU1
>
>                     |hantro_watchdog
> hantro_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
>
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Fixes: 932a9317ac49 ("media: hantro: Add helpers to prepare/finish a run"=
)

Thanks for the patch.

Give me a few days to take a closer look.

Thanks,
Ezequiel

> ---
> v4:
> - add Fixes label to help with the fix
>
> v3:
> - use cancel_delayed_work_sync instead of cancel_delayed_work and add it =
to
> hantro_release suggested by Hans Verkuil
>
> v2:
> - move the cancel-work-related code to hantro_remove suggested by Hans Ve=
rkuil
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index b0aeedae7b65..86a4c0fa8c7d 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -597,6 +597,7 @@ static int hantro_release(struct file *filp)
>         struct hantro_ctx *ctx =3D
>                 container_of(filp->private_data, struct hantro_ctx, fh);
>
> +       cancel_delayed_work_sync(&ctx->dev->watchdog_work);
>         /*
>          * No need for extra locking because this was the last reference
>          * to this file.
> @@ -1099,6 +1100,7 @@ static int hantro_remove(struct platform_device *pd=
ev)
>
>         v4l2_info(&vpu->v4l2_dev, "Removing %s\n", pdev->name);
>
> +       cancel_delayed_work_sync(&vpu->watchdog_work);
>         media_device_unregister(&vpu->mdev);
>         hantro_remove_dec_func(vpu);
>         hantro_remove_enc_func(vpu);
> --
> 2.25.1
>
