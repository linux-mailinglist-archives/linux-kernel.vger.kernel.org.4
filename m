Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F975738171
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjFUKL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFUKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:11:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B491BE5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:10:51 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-519c0ad1223so7091747a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1687342249; x=1689934249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+gXJsHBZudacT2OdDw1EMT2gr0zO7PzQir6flBd7a4=;
        b=SZ4IOF7guQNWDFS+/+I2pSiHxbetwx7cuBVSLOEsFQ/IvnzHEui5wb4kHwPhH9JJVv
         zfXP1wiQEWcBKH8qyKz4x1Da1UpA/L3KPTFdDVzb7SavQy+r4h5rmZK3fmDiTM0AiOEI
         QtOZSWcTvdLMgqWVk/mRzZC6V9AD6PRdZCRMVu2/8gVd/XzUmr+/WHt2rSGpIa/yQKw8
         mA1gKulD66bM/vDDvRhghKELNyvMSAjI/vCoMQgu//jQKHR+gJcMQBtmIeeetFh92Zg5
         DeftUjFWzGD35+4n7iGH7fGiYkfB9Xjl5Z/REyAj1fir3EVmd/JGU5Xw2AIZtqJVyV2r
         tm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342249; x=1689934249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+gXJsHBZudacT2OdDw1EMT2gr0zO7PzQir6flBd7a4=;
        b=e20KKLncWfpFCROf65o8Au1zkPcYx40raZwDjuDxBDggdjVIYdsyv75iCXLxLdnAyr
         jsRTLbdEbNCcXzfeoRqDHqJ7QAoCnow02n6JYGFGqcMZ4fnDDwpIc7i2QBhrqavRwGca
         go2ovjhrglQ301KhHuz5AzGlmnFIgP++E7IqUJQEoBmFgBmuJX0Z6MJBoVAHaDA5ROTh
         rlEipJBFBw9fssRXifVo7kpfoDXvecbJyB8RhDpeR2a2W2AtUaW26a4zlCBmcN5J6zJW
         K07N3JVaYfKMvYSezTean5sPoUs1tcu6duOfmHzIxF9hqpN3Zl5aP81ddsHNzACFKopU
         eWRQ==
X-Gm-Message-State: AC+VfDw9pD27VDAjwsYni/XowzGzluawSKemQsMHvcUT6IKvgOxv62ki
        i6biClQ57l19v6KFb0UgpDp/IsmXpmESNMY/0cA4fw==
X-Google-Smtp-Source: ACHHUZ6h7FiMpjQd28y2aHh27nxyL+AYw1iK1IG92bFay3+ZwbW+HwcFS9OE0OEjgnlmR1aAvC6dJzEoZv0SvQV44+0=
X-Received: by 2002:aa7:de06:0:b0:51b:d4f4:4805 with SMTP id
 h6-20020aa7de06000000b0051bd4f44805mr2115205edv.27.1687342249458; Wed, 21 Jun
 2023 03:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230620180129.645646-5-gregkh@linuxfoundation.org>
In-Reply-To: <20230620180129.645646-5-gregkh@linuxfoundation.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 21 Jun 2023 12:10:38 +0200
Message-ID: <CAMGffEm1FJpA5B9iyiieeRVYu=Te+wanauaVBBfx2YFZUozGEw@mail.gmail.com>
Subject: Re: [PATCH 1/4] block/rnbd: make all 'class' structures const
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 8:01=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Ivan Orlov <ivan.orlov0322@gmail.com>
>
> Now that the driver core allows for struct class to be in read-only
> memory, making all 'class' structures to be declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at load time.
>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
lgtm.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 20 +++++++++++---------
>  drivers/block/rnbd/rnbd-srv-sysfs.c | 22 ++++++++++++----------
>  2 files changed, 23 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnb=
d-clt-sysfs.c
> index 8c6087949794..e84abac04f4f 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -24,7 +24,9 @@
>  #include "rnbd-clt.h"
>
>  static struct device *rnbd_dev;
> -static struct class *rnbd_dev_class;
> +static const struct class rnbd_dev_class =3D {
> +       .name =3D "rnbd_client",
> +};
>  static struct kobject *rnbd_devs_kobj;
>
>  enum {
> @@ -646,11 +648,11 @@ int rnbd_clt_create_sysfs_files(void)
>  {
>         int err;
>
> -       rnbd_dev_class =3D class_create("rnbd-client");
> -       if (IS_ERR(rnbd_dev_class))
> -               return PTR_ERR(rnbd_dev_class);
> +       err =3D class_register(&rnbd_dev_class);
> +       if (err)
> +               return err;
>
> -       rnbd_dev =3D device_create_with_groups(rnbd_dev_class, NULL,
> +       rnbd_dev =3D device_create_with_groups(&rnbd_dev_class, NULL,
>                                               MKDEV(0, 0), NULL,
>                                               default_attr_groups, "ctl")=
;
>         if (IS_ERR(rnbd_dev)) {
> @@ -666,9 +668,9 @@ int rnbd_clt_create_sysfs_files(void)
>         return 0;
>
>  dev_destroy:
> -       device_destroy(rnbd_dev_class, MKDEV(0, 0));
> +       device_destroy(&rnbd_dev_class, MKDEV(0, 0));
>  cls_destroy:
> -       class_destroy(rnbd_dev_class);
> +       class_unregister(&rnbd_dev_class);
>
>         return err;
>  }
> @@ -678,6 +680,6 @@ void rnbd_clt_destroy_sysfs_files(void)
>         sysfs_remove_group(&rnbd_dev->kobj, &default_attr_group);
>         kobject_del(rnbd_devs_kobj);
>         kobject_put(rnbd_devs_kobj);
> -       device_destroy(rnbd_dev_class, MKDEV(0, 0));
> -       class_destroy(rnbd_dev_class);
> +       device_destroy(&rnbd_dev_class, MKDEV(0, 0));
> +       class_unregister(&rnbd_dev_class);
>  }
> diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnb=
d-srv-sysfs.c
> index d5d9267e1fa5..5e69c0112e23 100644
> --- a/drivers/block/rnbd/rnbd-srv-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> @@ -20,7 +20,9 @@
>  #include "rnbd-srv.h"
>
>  static struct device *rnbd_dev;
> -static struct class *rnbd_dev_class;
> +static const struct class rnbd_dev_class =3D {
> +       .name =3D "rnbd-server",
> +};
>  static struct kobject *rnbd_devs_kobj;
>
>  static void rnbd_srv_dev_release(struct kobject *kobj)
> @@ -215,12 +217,12 @@ int rnbd_srv_create_sysfs_files(void)
>  {
>         int err;
>
> -       rnbd_dev_class =3D class_create("rnbd-server");
> -       if (IS_ERR(rnbd_dev_class))
> -               return PTR_ERR(rnbd_dev_class);
> +       err =3D class_register(&rnbd_dev_class);
> +       if (err)
> +               return err;
>
> -       rnbd_dev =3D device_create(rnbd_dev_class, NULL,
> -                                 MKDEV(0, 0), NULL, "ctl");
> +       rnbd_dev =3D device_create(&rnbd_dev_class, NULL,
> +                                MKDEV(0, 0), NULL, "ctl");
>         if (IS_ERR(rnbd_dev)) {
>                 err =3D PTR_ERR(rnbd_dev);
>                 goto cls_destroy;
> @@ -234,9 +236,9 @@ int rnbd_srv_create_sysfs_files(void)
>         return 0;
>
>  dev_destroy:
> -       device_destroy(rnbd_dev_class, MKDEV(0, 0));
> +       device_destroy(&rnbd_dev_class, MKDEV(0, 0));
>  cls_destroy:
> -       class_destroy(rnbd_dev_class);
> +       class_unregister(&rnbd_dev_class);
>
>         return err;
>  }
> @@ -245,6 +247,6 @@ void rnbd_srv_destroy_sysfs_files(void)
>  {
>         kobject_del(rnbd_devs_kobj);
>         kobject_put(rnbd_devs_kobj);
> -       device_destroy(rnbd_dev_class, MKDEV(0, 0));
> -       class_destroy(rnbd_dev_class);
> +       device_destroy(&rnbd_dev_class, MKDEV(0, 0));
> +       class_unregister(&rnbd_dev_class);
>  }
> --
> 2.41.0
>
