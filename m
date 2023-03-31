Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A556D15B0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCaCio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCaCim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:38:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CE5CDD1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:38:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b6so1568610ljr.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112; t=1680230318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnjJbCFJ84xSw6+b+YYcpjgJUgGf7WAv7FcMkr2usx4=;
        b=mKGdDFJCcNtHk6Tmk3hrqlX+z+CDnpVSXLIsUXdBK3RDTeH65Z3Nz8troQzRChNX/9
         Ns8vSOnfC+Li8gfKlROPPj0QLVI5dYjfohmLos/AOrFCipBn4LOezDujZr2Azw09xY7/
         S/LZt3QwX5HV454c6o0UXsJRdEU/c/W2Mhc0S+oW8p7JmV6Axt/qCRpurhotBDpcC3GY
         phiRJfHgzA0riXKI44yGM7KiqhsViRMVCp5XIN2jA74Do0fEHlEX0Hw3bANQcRGHk0O2
         8ekr7LSfEdER1scE+qkwOMZ8OiF3lf38IiYjKENYUft2zQYajIdhCQVklDFrXol/5dyn
         XQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680230318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnjJbCFJ84xSw6+b+YYcpjgJUgGf7WAv7FcMkr2usx4=;
        b=XHXYA1ak3kS0996AOKQaWL9892YtmKT9CWxr7Lk7nGGPJBrgJVLXQKCTiWgG8wg6x9
         HKxajzP9ESx3K12sClzyubk2aaRmDS32zktOeDs1GUEWN2APaOeoceoV1MYQ40F4n3i5
         F/L88qXNtOn4S0Iz2PVDtYiHQYHyn9+m6hL6bykk0gzbvV6bzHD2OGHnrdRoBdOUZAb7
         VEjWEKKhcfgi4foieUzRMoDznWgZ5HLMZKWg9gO97IP42DCY/2pVe9TTl4fc4AJ/s5so
         G1wndM23fb7cwcpUWGBIQgh1hvEbuHN6UK8XLluDN4t4t9fASv+++/uy5DvvCLrqAJnx
         AWKg==
X-Gm-Message-State: AAQBX9d/AFK2EZDJZZauSMVsyPX1JRKSqqVuyDMOPiWmc3WsGCbpUnrE
        PZfXfYwAeBLuzITTQqAe8dde+BvRRwQo/fOE5mc5gg==
X-Google-Smtp-Source: AKy350bRKZHNRV7Itzh8Oh1f8CZmHVlPGbkbKOlllyOEVc3Yf4lEzadXN7Cw5QbSnxAwFXkd4e6vqT8qeEfB2+/0OVM=
X-Received: by 2002:a2e:6a0d:0:b0:295:93eb:e790 with SMTP id
 f13-20020a2e6a0d000000b0029593ebe790mr7879693ljc.5.1680230317918; Thu, 30 Mar
 2023 19:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230313154132.3684181-1-zyytlz.wz@163.com>
In-Reply-To: <20230313154132.3684181-1-zyytlz.wz@163.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 30 Mar 2023 23:38:25 -0300
Message-ID: <CAAEAJfAjND_Bj9HRBae22eO7cG_Xm=AX93bL+CPEb24-sitWTg@mail.gmail.com>
Subject: Re: [PATCH v3] media: hantro: fix use after free bug in hantro_remove
 due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        hverkuil@xs4all.nl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

On Mon, Mar 13, 2023 at 12:42=E2=80=AFPM Zheng Wang <zyytlz.wz@163.com> wro=
te:
>
> In hantro_probe, vpu->watchdog_work is bound with
> hantro_watchdog. Then hantro_end_prepare_run may
> be called to start the work.
>
> If we close the file or remove the module which will
> call hantro_release and hantro_remove to make cleanup,

It's not possible to close the file or remove the module while a watchdog i=
s
scheduled.

That's because the watchdog is active only during a mem2mem job,
and the file won't be closed until the job is done.

v4l2_m2m_ctx_release calls v4l2_m2m_cancel_jobw
which waits until the job is done.

If you can confirm it's possible to remove or close the file
while a job is running, that would be a driver bug.

Thanks for the patch, but it's not needed.

Regards,
Ezequiel

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
> ---
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
