Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3116A33D9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBZUEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZUE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:04:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A122012589;
        Sun, 26 Feb 2023 12:04:26 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id eg37so17585483edb.12;
        Sun, 26 Feb 2023 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqXbRQsxAunV9kKD7VAp1m3i0kKOYXyDIa3h180hvjw=;
        b=MM/VxVgdn+iGLw/Fl/UP4OYazmPGOqYXCaSWStw5HV+g7nlIIlFevlWZhxYBryBRiz
         RD0D2eu56d+2woFNVMxi+IjzFOXVx4ep+GZATIL69a/tOTxvSIcMCRskNKCds+io7OJo
         ph5j0lz3n4C8doU7u781YU6UlKRylwXK+6xTQbkHgkGIjS/s4vguGsyhtxXzhOWUz8pb
         wj0/HMJ5+8t61UZnGPEQnARF+st0hWO8igRTi82O1WBhgY1QTCal/+qsMtN4qdnElOoc
         saJUUtIToY6L//L4TgWchl/amjbn8FkYMqtjMb32RAn8LfrZ9qpGliRCUQt/9X2h43KP
         Jp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pqXbRQsxAunV9kKD7VAp1m3i0kKOYXyDIa3h180hvjw=;
        b=VK7ZlJBhxYbPC+FiJc2DN8ZjnLmtMZi2DLrMqk3/PV3kdlB1JQyLNNypLWVT64MGW8
         Aj+hrMCsGLY8xfTisObmKvE8CQYuQOXuVJELV0ydyb/6fNYhlT0hZ7rdo2WeyS66ADM4
         OD+OppUWBe12R6usueVS93yye1CHlSo8UbQx/KWmz2DBz5Jnr9QzIjJHKyZ3wiF8xPQM
         cdR7ITnoWMXLrcr20taPhd2Yv3GG70gYpqYl8G2Ec1APHOz0IbDy8zNomuiCiA6vNPsa
         eW4DciDtmJbBxM0U9pitvftOXGCKScAjqW6YPAuzQHthiT1ITKFgpHQD+5zk1X25e++R
         +sCQ==
X-Gm-Message-State: AO0yUKW9m6UcA4utsWSutT8UVU02BhZnKjM9/0L3JOsoDJT9z4jzjO44
        ivFxIjn/gcNdTQ4bI3BrwtSxI6Ra+qFpW5VaNEqQOElmu2U=
X-Google-Smtp-Source: AK7set82LZYeVvl8qTq463aYHdrBUQHU6zlmKXM9bz9UDwrcLGlBMlvuwutsk9r1untw2j3S4Hmg6uqNQ3qz9SawP1M=
X-Received: by 2002:a17:906:939a:b0:8b1:7569:b526 with SMTP id
 l26-20020a170906939a00b008b17569b526mr15079550ejx.11.1677441865092; Sun, 26
 Feb 2023 12:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20230226195227.185393-1-idryomov@gmail.com>
In-Reply-To: <20230226195227.185393-1-idryomov@gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sun, 26 Feb 2023 21:04:13 +0100
Message-ID: <CAOi1vP9S_y_vWk8jt=cV-TExEwa+vfM3tSPhYdULZhjrFVY3tw@mail.gmail.com>
Subject: Re: [PATCH] rbd: avoid use-after-free in do_rbd_add() when
 rbd_dev_create() fails
To:     ceph-devel@vger.kernel.org
Cc:     Natalia Petrova <n.petrova@fintech.ru>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 8:52=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> If getting an ID or setting up a work queue in rbd_dev_create() fails,
> use-after-free on rbd_dev->rbd_client, rbd_dev->spec and rbd_dev->opts
> is triggered in do_rbd_add().  The root cause is that the ownership of
> these structures is transfered to rbd_dev prematurely and they all end
> up getting freed when rbd_dev_create() calls rbd_dev_free() prior to
> returning to do_rbd_add().
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE, an
> incomplete patch submitted by Natalia Petrova <n.petrova@fintech.ru>.
>
> Cc: stable@vger.kernel.org
> Fixes: 1643dfa4c2c8 ("rbd: introduce a per-device ordered workqueue")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 04453f4a319c..60aed196a2e5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5292,8 +5292,7 @@ static void rbd_dev_release(struct device *dev)
>                 module_put(THIS_MODULE);
>  }
>
> -static struct rbd_device *__rbd_dev_create(struct rbd_client *rbdc,
> -                                          struct rbd_spec *spec)
> +static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
>  {
>         struct rbd_device *rbd_dev;
>
> @@ -5338,9 +5337,6 @@ static struct rbd_device *__rbd_dev_create(struct r=
bd_client *rbdc,
>         rbd_dev->dev.parent =3D &rbd_root_dev;
>         device_initialize(&rbd_dev->dev);
>
> -       rbd_dev->rbd_client =3D rbdc;
> -       rbd_dev->spec =3D spec;
> -
>         return rbd_dev;
>  }
>
> @@ -5353,12 +5349,10 @@ static struct rbd_device *rbd_dev_create(struct r=
bd_client *rbdc,
>  {
>         struct rbd_device *rbd_dev;
>
> -       rbd_dev =3D __rbd_dev_create(rbdc, spec);
> +       rbd_dev =3D __rbd_dev_create(spec);
>         if (!rbd_dev)
>                 return NULL;
>
> -       rbd_dev->opts =3D opts;
> -
>         /* get an id and fill in device name */
>         rbd_dev->dev_id =3D ida_simple_get(&rbd_dev_id_ida, 0,
>                                          minor_to_rbd_dev_id(1 << MINORBI=
TS),
> @@ -5375,6 +5369,10 @@ static struct rbd_device *rbd_dev_create(struct rb=
d_client *rbdc,
>         /* we have a ref from do_rbd_add() */
>         __module_get(THIS_MODULE);
>
> +       rbd_dev->rbd_client =3D rbdc;
> +       rbd_dev->spec =3D spec;
> +       rbd_dev->opts =3D opts;
> +
>         dout("%s rbd_dev %p dev_id %d\n", __func__, rbd_dev, rbd_dev->dev=
_id);
>         return rbd_dev;
>
> @@ -6736,7 +6734,7 @@ static int rbd_dev_probe_parent(struct rbd_device *=
rbd_dev, int depth)
>                 goto out_err;
>         }
>
> -       parent =3D __rbd_dev_create(rbd_dev->rbd_client, rbd_dev->parent_=
spec);
> +       parent =3D __rbd_dev_create(rbd_dev->parent_spec);
>         if (!parent) {
>                 ret =3D -ENOMEM;
>                 goto out_err;
> @@ -6746,8 +6744,8 @@ static int rbd_dev_probe_parent(struct rbd_device *=
rbd_dev, int depth)
>          * Images related by parent/child relationships always share
>          * rbd_client and spec/parent_spec, so bump their refcounts.
>          */
> -       __rbd_get_client(rbd_dev->rbd_client);
> -       rbd_spec_get(rbd_dev->parent_spec);
> +       parent->rbd_client =3D __rbd_get_client(rbd_dev->rbd_client);
> +       parent->spec =3D rbd_spec_get(rbd_dev->parent_spec);
>
>         __set_bit(RBD_DEV_FLAG_READONLY, &parent->flags);
>
> --
> 2.39.1
>

CCing everyone on the previous thread...
