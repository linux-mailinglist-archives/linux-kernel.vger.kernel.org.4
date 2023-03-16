Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C056BCAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCPJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCPJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C621A06
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678959049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu9LuzlUExdZmSdDNar6TeB+0bukdqYe3ZDHoEtXKpo=;
        b=Iq2qwNh/iIi9t5OUA45YA+qBiaNSakSaVSyCCkscwm1sMdK8fMmTfSPzVGUPHUmX1Vc0mP
        iQKaye/bezCjrV/MFS9qbmqHeWrxsuotTbND9PDEOuMOUiBs6qAHHGVK1yZo+0ptoP5WVu
        nyMeCIo8KGsqja9iiyEzmQodBkOOtEg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-9ucfyd_uOt28hE0YAR2QZg-1; Thu, 16 Mar 2023 05:30:48 -0400
X-MC-Unique: 9ucfyd_uOt28hE0YAR2QZg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-17abb9d4b67so883382fac.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zu9LuzlUExdZmSdDNar6TeB+0bukdqYe3ZDHoEtXKpo=;
        b=O1IdNIsaobNtSVmFvXHPK7BXJz4yApNVHTRv67iuts6m2gmMbBfU5TfFH6a6kZ31nz
         218EH6+znQokC8DEt22ZbqNFxIoIKgwOb27ppkFqMyQ1WGCNDhw1MremnWdJIQpRIJYL
         EFeXr3xkdLVwk1iYhCRTd9q9xhvWTTwnzYYlBliRI2tAYXF0RsGHK1h5dd/IcumCmFx2
         LGcsGrqbUr4euxH5FSm2l+ps6CKCNvi39zuZJ40jWvSgl4sBVOfLgOB17ESKurp01R4Y
         GXA1/S4OfbEFURuFFDK0dzcxOqOVckhpM/ga1YMPwFbjx6QvIdyxd4qUHB9YqJELXqrf
         wS1w==
X-Gm-Message-State: AO0yUKWi1DMfOfmiZhAKqPVFi7jcnKL1JHgOILJhQMrq2Eq9sBzyT6QW
        xQrHGrdCJcscuwzK8A3DZJDgFWUCSm8NZR9Xwq3I0Poo6M7sv4+ZRouurF0TYFfqnHlqOz+tUhh
        cg6Y7lAx+sefYy6b05zzvWg/Csxhqaog8IY2Xe8Gk
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id sf21-20020a056871231500b00177c2fb8cecmr5522606oab.9.1678959047665;
        Thu, 16 Mar 2023 02:30:47 -0700 (PDT)
X-Google-Smtp-Source: AK7set/MybTeH6VqAhE6xW1v6MuEEwFvUz7vDxe6JlWA6itRvqzS2b2MeUvZgRHhXHPLtM8/IAiqnOcLk9frG3LphUI=
X-Received: by 2002:a05:6871:2315:b0:177:c2fb:8cec with SMTP id
 sf21-20020a056871231500b00177c2fb8cecmr5522601oab.9.1678959047461; Thu, 16
 Mar 2023 02:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-10-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-10-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Mar 2023 17:30:36 +0800
Message-ID: <CACGkMEsaeAJbTzx0M3DJzt=dwWyWvX79L1tapfZ1O-AKyG73Mw@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] vduse: Signal interrupt's eventfd directly in
 vhost-vdpa case
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance.com=
> wrote:
>
> Now the vdpa callback will associate an eventfd in
> vhost-vdpa case.

I'd suggest avoiding mentioning drivers since vDPA parents should not
know which vDPA driver is bound.

We could say "signal vq trigger eventfd directly if possible"?

With those tweaked.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> For performance reasons, VDUSE can
> signal it directly during irq injection.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 869cc7860d82..56f3c2480c2a 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -461,6 +461,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>                 spin_lock(&vq->irq_lock);
>                 vq->cb.callback =3D NULL;
>                 vq->cb.private =3D NULL;
> +               vq->cb.irq_ctx =3D NULL;
>                 spin_unlock(&vq->irq_lock);
>                 flush_work(&vq->inject);
>                 flush_work(&vq->kick);
> @@ -526,6 +527,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *=
vdpa, u16 idx,
>         spin_lock(&vq->irq_lock);
>         vq->cb.callback =3D cb->callback;
>         vq->cb.private =3D cb->private;
> +       vq->cb.irq_ctx =3D cb->irq_ctx;
>         spin_unlock(&vq->irq_lock);
>  }
>
> @@ -1020,6 +1022,20 @@ static void vduse_vq_irq_inject(struct work_struct=
 *work)
>         spin_unlock_irq(&vq->irq_lock);
>  }
>
> +static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
> +{
> +       bool signal =3D false;
> +
> +       spin_lock_irq(&vq->irq_lock);
> +       if (vq->ready && vq->cb.irq_ctx) {
> +               eventfd_signal(vq->cb.irq_ctx, 1);
> +               signal =3D true;
> +       }
> +       spin_unlock_irq(&vq->irq_lock);
> +
> +       return signal;
> +}
> +
>  static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>                                     struct work_struct *irq_work,
>                                     int irq_effective_cpu)
> @@ -1322,11 +1338,14 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
>                 if (index >=3D dev->vq_num)
>                         break;
>
> +               ret =3D 0;
>                 index =3D array_index_nospec(index, dev->vq_num);
> -
> -               vduse_vq_update_effective_cpu(dev->vqs[index]);
> -               ret =3D vduse_dev_queue_irq_work(dev, &dev->vqs[index]->i=
nject,
> -                                       dev->vqs[index]->irq_effective_cp=
u);
> +               if (!vduse_vq_signal_irqfd(dev->vqs[index])) {
> +                       vduse_vq_update_effective_cpu(dev->vqs[index]);
> +                       ret =3D vduse_dev_queue_irq_work(dev,
> +                                               &dev->vqs[index]->inject,
> +                                               dev->vqs[index]->irq_effe=
ctive_cpu);
> +               }
>                 break;
>         }
>         case VDUSE_IOTLB_REG_UMEM: {
> --
> 2.20.1
>

