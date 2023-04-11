Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FCA6DD1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjDKFlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDKFlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:41:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2792D45
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681191619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2MfVoDEeLgaeGehPapEDG88NMDEyPAiMkTlV+QvLe4=;
        b=VZ+eKr61nP7ZhuRfbzJkxdX8OulKRnkCvzZBjiF8j2fSLeCI4mrHMzN/GbDGxRClvLHuek
        VlFYdM3BvP5G8aXtGVCYmGMzyab1p4mIKYTLqxJtOl3+oF9mJBAt7nDN5Oqu9YLa5JKQ5r
        gX6ZTbNW5tBFisHcVXt2oZys0OSPiAk=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-JWq7Z6_1ND-ut9YOIdToRQ-1; Tue, 11 Apr 2023 01:40:18 -0400
X-MC-Unique: JWq7Z6_1ND-ut9YOIdToRQ-1
Received: by mail-oo1-f71.google.com with SMTP id o202-20020a4a2cd3000000b0053b7aa939c3so2298356ooo.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681191618; x=1683783618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2MfVoDEeLgaeGehPapEDG88NMDEyPAiMkTlV+QvLe4=;
        b=ayRhvLMOa6HOMCakeC/k90qt03lvgZSBwKt/RScTUredLENfokCAiKx/F3Kwr16S6t
         2k11IkpD24qYSTQl0Zwd9UXGLDjwr1SS/14N0siP7w4X2f2/fCmHb2O6qbrP2EbFxZOo
         lM6Ilhs0ZSoQOBQtDLq+yRjA3O8plOH0OyByIzgwlZIRQLDst/LCxzR9RmctXycReg87
         /G3ssr6sIZb0HuREvcCZxiCTzW/G05bsbiqiq4E9Jhnvn3wqlYiMGLo/7EFfhbWk3bbe
         xvWxZSremD0AmHLDnA6pjqz6jflIQw/tyFYuGoC1TwjtfOqpC5OEn27n/uhkKseGAv71
         0rnw==
X-Gm-Message-State: AAQBX9eZPfibKPGpKXszaKA93SPUvxQ+DrW+Q8nUXY6P+I2x62sq5nDk
        PT5SiMkSx8h0AM2zWO8WJbUMz+DFfH+cZsV7HejdKUVZY/Af0HNrqxX4NJM5AmZDidT9ZH28EvX
        yk5ZXnsUlJHp6QZHa6/yDjKoxhOoZc/s866lSau+Q
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id 5-20020aca2105000000b0037fab56ff42mr382711oiz.9.1681191617964;
        Mon, 10 Apr 2023 22:40:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350b86Y/QCGjnR1TfO/EgY70echaGQeoEIsSV/BF854H5Sew6uskMivEF98OtO13bWZNWxpr8cuxN3sYgnFz5lyY=
X-Received: by 2002:aca:2105:0:b0:37f:ab56:ff42 with SMTP id
 5-20020aca2105000000b0037fab56ff42mr382703oiz.9.1681191617729; Mon, 10 Apr
 2023 22:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230404131326.44403-1-sgarzare@redhat.com> <20230404131326.44403-3-sgarzare@redhat.com>
In-Reply-To: <20230404131326.44403-3-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 11 Apr 2023 13:40:06 +0800
Message-ID: <CACGkMEsuoZMW==JKd_VeW5TUh=KTZC+vDJWLHQ5hbfncAf387Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] vhost-vdpa: use bind_mm/unbind_mm device callbacks
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        stefanha@redhat.com,
        Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 9:14=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> When the user call VHOST_SET_OWNER ioctl and the vDPA device
> has `use_va` set to true, let's call the bind_mm callback.
> In this way we can bind the device to the user address space
> and directly use the user VA.
>
> The unbind_mm callback is called during the release after
> stopping the device.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>
> Notes:
>     v4:
>     - added new switch after vhost_dev_ioctl() [Jason]
>     v3:
>     - added `case VHOST_SET_OWNER` in vhost_vdpa_unlocked_ioctl() [Jason]
>     v2:
>     - call the new unbind_mm callback during the release [Jason]
>     - avoid to call bind_mm callback after the reset, since the device
>       is not detaching it now during the reset
>
>  drivers/vhost/vdpa.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 7be9d9d8f01c..3824c249612f 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -219,6 +219,28 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
>         return vdpa_reset(vdpa);
>  }
>
> +static long vhost_vdpa_bind_mm(struct vhost_vdpa *v)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +       if (!vdpa->use_va || !ops->bind_mm)
> +               return 0;
> +
> +       return ops->bind_mm(vdpa, v->vdev.mm);
> +}
> +
> +static void vhost_vdpa_unbind_mm(struct vhost_vdpa *v)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +
> +       if (!vdpa->use_va || !ops->unbind_mm)
> +               return;
> +
> +       ops->unbind_mm(vdpa);
> +}
> +
>  static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *ar=
gp)
>  {
>         struct vdpa_device *vdpa =3D v->vdpa;
> @@ -716,6 +738,17 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>                 break;
>         }
>
> +       if (r)
> +               goto out;
> +
> +       switch (cmd) {
> +       case VHOST_SET_OWNER:
> +               r =3D vhost_vdpa_bind_mm(v);
> +               if (r)
> +                       vhost_dev_reset_owner(d, NULL);
> +               break;
> +       }
> +out:
>         mutex_unlock(&d->mutex);
>         return r;
>  }
> @@ -1287,6 +1320,7 @@ static int vhost_vdpa_release(struct inode *inode, =
struct file *filep)
>         vhost_vdpa_clean_irq(v);
>         vhost_vdpa_reset(v);
>         vhost_dev_stop(&v->vdev);
> +       vhost_vdpa_unbind_mm(v);
>         vhost_vdpa_config_put(v);
>         vhost_vdpa_cleanup(v);
>         mutex_unlock(&d->mutex);
> --
> 2.39.2
>

