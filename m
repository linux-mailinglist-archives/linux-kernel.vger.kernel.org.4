Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A96C77DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjCXG27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXG25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F272D71
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679639285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qeXjSRfLwdb188nYRp/OaR/THnDSMW2kUowSqcUnpsU=;
        b=BXrWQLHqNVEp5AZBUMAvLv7Slm8zRyUG54Y7N3W94++8VbAif8EgWmjZPspIjkwQ2xEiSo
        hjqsvfTbGwuwAL3w+31vGMMHIkT59lx5KT8j7d3i/WRYVgKQM2Ah6nZTpMEbwcgZlo+lra
        sP4e6bIRPDuJuHRYVECVQvFGsR683Ng=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-hQCW3TsBOdCnkxladtF1ow-1; Fri, 24 Mar 2023 02:28:04 -0400
X-MC-Unique: hQCW3TsBOdCnkxladtF1ow-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17a03f26ff8so480714fac.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeXjSRfLwdb188nYRp/OaR/THnDSMW2kUowSqcUnpsU=;
        b=tDXIteBgTeyKG6ps1Du46muk3MwBirsFyE5Y0QrBHemSjHRTJb1O8TaSKmRjth/fU/
         /1pg/1m7rGy9De6NRnOj+NsJ7gujaSyvamZH10voj3GBIsCM+3Tf/c+oglwAIytVx754
         87FCmmsEjAQHHsR8qksB7Ml9tzaKVmFNjZkkTeuXU7q3VHTdsZ5twp5wkESEQSavlH0z
         iYCCNdkDv8tYEhNaOteYRJXJq5wK8x/5j8AYoMjdafriz+aY+jbuh57YWWnSFSiMbJuo
         lglubaDBsBiKIpLvlk+lHwIClFnVwmX26uaYOBFXu9btRNa2dOtdQ5vzobz185S75JAR
         xVOA==
X-Gm-Message-State: AO0yUKVxojXdqLptwCxyhazZyF6978Ukg/qoyt8Pp4L3o53aHyuuk0Dl
        TaCPzikEApOl1V3z46htZECJE7v1GMB9PqlinucTPeQyZ7xMSBDHYP9YjRCGiZm9CyF6wghMQXR
        v+h8C+c9GwDPax3iBr8ShQKAowIuwEItsMJbMzlV1
X-Received: by 2002:a9d:67d8:0:b0:69f:229:ce72 with SMTP id c24-20020a9d67d8000000b0069f0229ce72mr730086otn.2.1679639283479;
        Thu, 23 Mar 2023 23:28:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set/zNwGCo/4/80XEpIM9DnWdRGQX0nNE6byaeqSilTsY7EeCq2IfuWvaX/hDv/JoJjxxWKANx/x9oE3B2Q4WmeI=
X-Received: by 2002:a9d:67d8:0:b0:69f:229:ce72 with SMTP id
 c24-20020a9d67d8000000b0069f0229ce72mr730078otn.2.1679639283227; Thu, 23 Mar
 2023 23:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
In-Reply-To: <20230323053043.35-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 24 Mar 2023 14:27:52 +0800
Message-ID: <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@bytedance.com=
> wrote:
>
> To support interrupt affinity spreading mechanism,
> this makes use of group_cpus_evenly() to create
> an irq callback affinity mask for each virtqueue
> of vdpa device. Then we will unify set_vq_affinity
> callback to pass the affinity to the vdpa device driver.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Thinking hard of all the logics, I think I've found something interesting.

Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
pass irq_affinity to transport specific find_vqs().  This seems a
layer violation since driver has no knowledge of

1) whether or not the callback is based on an IRQ
2) whether or not the device is a PCI or not (the details are hided by
the transport driver)
3) how many vectors could be used by a device

This means the driver can't actually pass a real affinity masks so the
commit passes a zero irq affinity structure as a hint in fact, so the
PCI layer can build a default affinity based that groups cpus evenly
based on the number of MSI-X vectors (the core logic is the
group_cpus_evenly). I think we should fix this by replacing the
irq_affinity structure with

1) a boolean like auto_cb_spreading

or

2) queue to cpu mapping

So each transport can do its own logic based on that. Then virtio-vDPA
can pass that policy to VDUSE where we only need a group_cpus_evenly()
and avoid duplicating irq_create_affinity_masks()?

Thanks

> ---
>  drivers/virtio/virtio_vdpa.c | 68 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f72696b4c1c2..f3826f42b704 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
>  #include <linux/uuid.h>
> +#include <linux/group_cpus.h>
>  #include <linux/virtio.h>
>  #include <linux/vdpa.h>
>  #include <linux/virtio_config.h>
> @@ -272,6 +273,66 @@ static void virtio_vdpa_del_vqs(struct virtio_device=
 *vdev)
>                 virtio_vdpa_del_vq(vq);
>  }
>
> +static void default_calc_sets(struct irq_affinity *affd, unsigned int af=
fvecs)
> +{
> +       affd->nr_sets =3D 1;
> +       affd->set_size[0] =3D affvecs;
> +}
> +
> +static struct cpumask *
> +create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> +{
> +       unsigned int affvecs =3D 0, curvec, usedvecs, i;
> +       struct cpumask *masks =3D NULL;
> +
> +       if (nvecs > affd->pre_vectors + affd->post_vectors)
> +               affvecs =3D nvecs - affd->pre_vectors - affd->post_vector=
s;
> +
> +       if (!affd->calc_sets)
> +               affd->calc_sets =3D default_calc_sets;
> +
> +       affd->calc_sets(affd, affvecs);
> +
> +       if (!affvecs)
> +               return NULL;
> +
> +       masks =3D kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
> +       if (!masks)
> +               return NULL;
> +
> +       /* Fill out vectors at the beginning that don't need affinity */
> +       for (curvec =3D 0; curvec < affd->pre_vectors; curvec++)
> +               cpumask_setall(&masks[curvec]);
> +
> +       for (i =3D 0, usedvecs =3D 0; i < affd->nr_sets; i++) {
> +               unsigned int this_vecs =3D affd->set_size[i];
> +               int j;
> +               struct cpumask *result =3D group_cpus_evenly(this_vecs);
> +
> +               if (!result) {
> +                       kfree(masks);
> +                       return NULL;
> +               }
> +
> +               for (j =3D 0; j < this_vecs; j++)
> +                       cpumask_copy(&masks[curvec + j], &result[j]);
> +               kfree(result);
> +
> +               curvec +=3D this_vecs;
> +               usedvecs +=3D this_vecs;
> +       }
> +
> +       /* Fill out vectors at the end that don't need affinity */
> +       if (usedvecs >=3D affvecs)
> +               curvec =3D affd->pre_vectors + affvecs;
> +       else
> +               curvec =3D affd->pre_vectors + usedvecs;
> +       for (; curvec < nvecs; curvec++)
> +               cpumask_setall(&masks[curvec]);
> +
> +       return masks;
> +}
> +
>  static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int=
 nvqs,
>                                 struct virtqueue *vqs[],
>                                 vq_callback_t *callbacks[],
> @@ -282,9 +343,15 @@ static int virtio_vdpa_find_vqs(struct virtio_device=
 *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev)=
;
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> +       struct irq_affinity default_affd =3D { 0 };
> +       struct cpumask *masks;
>         struct vdpa_callback cb;
>         int i, err, queue_idx =3D 0;
>
> +       masks =3D create_affinity_masks(nvqs, desc ? desc : &default_affd=
);
> +       if (!masks)
> +               return -ENOMEM;
> +
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
>                         vqs[i] =3D NULL;
> @@ -298,6 +365,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device =
*vdev, unsigned int nvqs,
>                         err =3D PTR_ERR(vqs[i]);
>                         goto err_setup_vq;
>                 }
> +               ops->set_vq_affinity(vdpa, i, &masks[i]);
>         }
>
>         cb.callback =3D virtio_vdpa_config_cb;
> --
> 2.20.1
>

