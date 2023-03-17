Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2346BE1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCQHFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCQHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:05:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3BA2B60F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:04:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er8so4955317edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679036683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJOM2yXNGEIMtKGs9RP3i/JbhugRdq7A2NNB1n+HP8k=;
        b=XSIFq3IUqo1ydCOWXSg7cgB81Uaxp3+q80H+5DnuQMtdXGkn9Poo8J66BRMtyWlauS
         8gh60oaPEfXZ8l9Nd9U3yCcsoZW+gJB0BGmbaE600nFp0qYH2sX5dJyVx5RNZvoFzEED
         G8veIF1ox7bRDVEJzaSVZAgG/pChDUKfJgaWci1LB4+DLBTZNjDv66FFZrv8Edd1gS9B
         WTlKmvcRIEPIJ3GA3ZOUh8/2qTXyfWEfZ6A8WvvSb5xJU07SFC9fcuhmlGiUc91zLbVi
         kWvd5aTyPMfdgjmnVhtj/lepGgzSMKh4iie/IiwY2/xwHN77XPG8JBgdUuxkWTRXhYO/
         cQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679036683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJOM2yXNGEIMtKGs9RP3i/JbhugRdq7A2NNB1n+HP8k=;
        b=BE6rx+O+/tF4mazwyD6pS5V7NwrMKpaB4uM6R33GP+nef8y0EgZqnlmsQx/2DyHdOV
         mWPpZeiJIdaroU6/OGu0/sWUOytja+X9fodcdaTBbS5RLw0GRgoIDa8e2YJsEwXH5zJ+
         UROpgTfpeXOEydPeRKY3EC15jdFVWKsZuaGv6a2myQUKeWQywrajlwAKqem0pQY8Tb92
         SHBJXfxS1oQUsAlVgiRyHObbRlsJbDlw6Cec5/XBHF5jsjRUbpRhIu1BupIU647GRYZF
         BS4iKtVrx+cZkp11JMRaegad3h+tamgwvkOesZFmEvaV6pe1ac0CsqAY0I211Bk0pysx
         SPBw==
X-Gm-Message-State: AO0yUKWOSMypoYQemP1mViXgGAot0WKVHFUXz2i9Neet/9UBPomrXkwQ
        7qXNL1D7j0UWxYrqqsbOD8PEBnCdv5Jmrzjo8+ii
X-Google-Smtp-Source: AK7set/1bqw71tLa9afdR9/UlCBwYsQfbA18bbXE96bCIot05T4yhqSLJBe/IcYreRlLNODcq5vspnzkjNQhHub78wQ=
X-Received: by 2002:a17:907:e91:b0:924:32b2:e3d1 with SMTP id
 ho17-20020a1709070e9100b0092432b2e3d1mr7180691ejc.3.1679036683485; Fri, 17
 Mar 2023 00:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-6-xieyongji@bytedance.com>
 <59bdd215-6465-a240-338c-04a3a67a061d@redhat.com>
In-Reply-To: <59bdd215-6465-a240-338c-04a3a67a061d@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 17 Mar 2023 15:04:32 +0800
Message-ID: <CACycT3tv-GZRK0OOec7e40fT=uDMN2cef-PcN-J54RL3ZF6LTQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 5:03=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
>
> =E5=9C=A8 2023/2/28 17:41, Xie Yongji =E5=86=99=E9=81=93:
> > This brings current interrupt affinity spreading mechanism
> > to vduse device. We will make use of group_cpus_evenly()
> > to create an irq callback affinity mask for each virtqueue of
> > vduse device. Then we will spread IRQs between CPUs in the affinity
> > mask, in a round-robin manner, to run the irq callback.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/vdpa/vdpa_user/vduse_dev.c | 130 +++++++++++++++++++++++++++-=
-
> >   1 file changed, 123 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 98359d87a06f..bde28a8692d5 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -23,6 +23,8 @@
> >   #include <linux/nospec.h>
> >   #include <linux/vmalloc.h>
> >   #include <linux/sched/mm.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/group_cpus.h>
> >   #include <uapi/linux/vduse.h>
> >   #include <uapi/linux/vdpa.h>
> >   #include <uapi/linux/virtio_config.h>
> > @@ -41,6 +43,8 @@
> >   #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
> >   #define VDUSE_MSG_DEFAULT_TIMEOUT 30
> >
> > +#define IRQ_UNBOUND -1
> > +
> >   struct vduse_virtqueue {
> >       u16 index;
> >       u16 num_max;
> > @@ -57,6 +61,8 @@ struct vduse_virtqueue {
> >       struct vdpa_callback cb;
> >       struct work_struct inject;
> >       struct work_struct kick;
> > +     int irq_effective_cpu;
> > +     struct cpumask irq_affinity;
> >   };
> >
> >   struct vduse_dev;
> > @@ -128,6 +134,7 @@ static struct class *vduse_class;
> >   static struct cdev vduse_ctrl_cdev;
> >   static struct cdev vduse_cdev;
> >   static struct workqueue_struct *vduse_irq_wq;
> > +static struct workqueue_struct *vduse_irq_bound_wq;
> >
> >   static u32 allowed_device_id[] =3D {
> >       VIRTIO_ID_BLOCK,
> > @@ -708,6 +715,82 @@ static u32 vduse_vdpa_get_generation(struct vdpa_d=
evice *vdpa)
> >       return dev->generation;
> >   }
> >
> > +static void default_calc_sets(struct irq_affinity *affd, unsigned int =
affvecs)
> > +{
> > +     affd->nr_sets =3D 1;
> > +     affd->set_size[0] =3D affvecs;
> > +}
> > +
> > +struct cpumask *
> > +create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> > +{
> > +     unsigned int affvecs =3D 0, curvec, usedvecs, i;
> > +     struct cpumask *masks =3D NULL;
> > +
> > +     if (nvecs > affd->pre_vectors + affd->post_vectors)
> > +             affvecs =3D nvecs - affd->pre_vectors - affd->post_vector=
s;
> > +
> > +     if (!affd->calc_sets)
> > +             affd->calc_sets =3D default_calc_sets;
> > +
> > +     affd->calc_sets(affd, affvecs);
> > +
> > +     if (!affvecs)
> > +             return NULL;
> > +
> > +     masks =3D kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
> > +     if (!masks)
> > +             return NULL;
> > +
> > +     /* Fill out vectors at the beginning that don't need affinity */
> > +     for (curvec =3D 0; curvec < affd->pre_vectors; curvec++)
> > +             cpumask_setall(&masks[curvec]);
> > +
> > +     for (i =3D 0, usedvecs =3D 0; i < affd->nr_sets; i++) {
> > +             unsigned int this_vecs =3D affd->set_size[i];
> > +             int j;
> > +             struct cpumask *result =3D group_cpus_evenly(this_vecs);
> > +
> > +             if (!result) {
> > +                     kfree(masks);
> > +                     return NULL;
> > +             }
> > +
> > +             for (j =3D 0; j < this_vecs; j++)
> > +                     cpumask_copy(&masks[curvec + j], &result[j]);
> > +             kfree(result);
> > +
> > +             curvec +=3D this_vecs;
> > +             usedvecs +=3D this_vecs;
> > +     }
> > +
> > +     /* Fill out vectors at the end that don't need affinity */
> > +     if (usedvecs >=3D affvecs)
> > +             curvec =3D affd->pre_vectors + affvecs;
> > +     else
> > +             curvec =3D affd->pre_vectors + usedvecs;
> > +     for (; curvec < nvecs; curvec++)
> > +             cpumask_setall(&masks[curvec]);
> > +
> > +     return masks;
> > +}
> > +
> > +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> > +                                     struct irq_affinity *desc)
> > +{
> > +     struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > +     struct cpumask *masks;
> > +     int i;
> > +
> > +     masks =3D create_affinity_masks(dev->vq_num, desc);
> > +     if (!masks)
> > +             return;
> > +
> > +     for (i =3D 0; i < dev->vq_num; i++)
> > +             cpumask_copy(&dev->vqs[i]->irq_affinity, &masks[i]);
> > +     kfree(masks);
> > +}
> > +
> >   static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
> >                               unsigned int asid,
> >                               struct vhost_iotlb *iotlb)
> > @@ -758,6 +841,7 @@ static const struct vdpa_config_ops vduse_vdpa_conf=
ig_ops =3D {
> >       .get_config             =3D vduse_vdpa_get_config,
> >       .set_config             =3D vduse_vdpa_set_config,
> >       .get_generation         =3D vduse_vdpa_get_generation,
> > +     .set_irq_affinity       =3D vduse_vdpa_set_irq_affinity,
> >       .reset                  =3D vduse_vdpa_reset,
> >       .set_map                =3D vduse_vdpa_set_map,
> >       .free                   =3D vduse_vdpa_free,
> > @@ -917,7 +1001,8 @@ static void vduse_vq_irq_inject(struct work_struct=
 *work)
> >   }
> >
> >   static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> > -                                 struct work_struct *irq_work)
> > +                                 struct work_struct *irq_work,
> > +                                 int irq_effective_cpu)
> >   {
> >       int ret =3D -EINVAL;
> >
> > @@ -926,7 +1011,11 @@ static int vduse_dev_queue_irq_work(struct vduse_=
dev *dev,
> >               goto unlock;
> >
> >       ret =3D 0;
> > -     queue_work(vduse_irq_wq, irq_work);
> > +     if (irq_effective_cpu =3D=3D IRQ_UNBOUND)
> > +             queue_work(vduse_irq_wq, irq_work);
> > +     else
> > +             queue_work_on(irq_effective_cpu,
> > +                           vduse_irq_bound_wq, irq_work);
> >   unlock:
> >       up_read(&dev->rwsem);
> >
> > @@ -1029,6 +1118,22 @@ static int vduse_dev_reg_umem(struct vduse_dev *=
dev,
> >       return ret;
> >   }
> >
> > +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > +{
> > +     int curr_cpu =3D vq->irq_effective_cpu;
> > +
> > +     while (true) {
> > +             curr_cpu =3D cpumask_next(curr_cpu, &vq->irq_affinity);
> > +             if (cpu_online(curr_cpu))
> > +                     break;
> > +
> > +             if (curr_cpu >=3D nr_cpu_ids)
> > +                     curr_cpu =3D -1;
>
>
> IRQ_UNBOUND?
>

Will fix it.

>
> > +     }
> > +
> > +     vq->irq_effective_cpu =3D curr_cpu;
> > +}
> > +
> >   static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
> >                           unsigned long arg)
> >   {
> > @@ -1111,7 +1216,7 @@ static long vduse_dev_ioctl(struct file *file, un=
signed int cmd,
> >               break;
> >       }
> >       case VDUSE_DEV_INJECT_CONFIG_IRQ:
> > -             ret =3D vduse_dev_queue_irq_work(dev, &dev->inject);
> > +             ret =3D vduse_dev_queue_irq_work(dev, &dev->inject, IRQ_U=
NBOUND);
> >               break;
> >       case VDUSE_VQ_SETUP: {
> >               struct vduse_vq_config config;
> > @@ -1198,7 +1303,10 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                       break;
> >
> >               index =3D array_index_nospec(index, dev->vq_num);
> > -             ret =3D vduse_dev_queue_irq_work(dev, &dev->vqs[index]->i=
nject);
> > +
> > +             vduse_vq_update_effective_cpu(dev->vqs[index]);
> > +             ret =3D vduse_dev_queue_irq_work(dev, &dev->vqs[index]->i=
nject,
> > +                                     dev->vqs[index]->irq_effective_cp=
u);
> >               break;
> >       }
> >       case VDUSE_IOTLB_REG_UMEM: {
> > @@ -1367,10 +1475,12 @@ static int vduse_dev_init_vqs(struct vduse_dev =
*dev, u32 vq_align, u32 vq_num)
> >                       goto err;
> >
> >               dev->vqs[i]->index =3D i;
> > +             dev->vqs[i]->irq_effective_cpu =3D -1;
>
>
> IRQ_UNBOUND?
>

Will fix it.

Thanks,
Yongji
