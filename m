Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF96C7AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCXJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjCXJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2333A2366C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679649153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZlQS4mF9DF39LuCMy+j/gzmWPJpejHPdHY+MZDF3ta0=;
        b=Yt6JR7YiA+85EJjJrZSf1sFxWz5kAuqZWuhKeUqfroX+YV39tKW//jI/uuZiEOVeoHxSti
        b+tx1iyItExTu/tJpTOJ3zOU4ndN6DhCUOFKmSYZOWFWGcbrv+atF6j9Ck4yb0djH77qa/
        PAwi6xWvx5awz4YUa/NRYdADudBdMRg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4paEqKS2MXSBj3_JzCMp7w-1; Fri, 24 Mar 2023 05:12:31 -0400
X-MC-Unique: 4paEqKS2MXSBj3_JzCMp7w-1
Received: by mail-wr1-f72.google.com with SMTP id k16-20020adfd230000000b002cfe7555486so91019wrh.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679649150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlQS4mF9DF39LuCMy+j/gzmWPJpejHPdHY+MZDF3ta0=;
        b=VJf4Bd1wEF+lrBM1jBHq+FHJNCJ0N9SRkqeS1jaCCwomiV2Yg66SlXJRRt85XfNgyK
         rQecPFVo5gQS0NbJvQ95iTv4mah201qHiSLu3eu6mMYLaYaKSl+NnTE0IjJUb2N6wkP0
         WHsAGgXTv2fpeiCcFbXlV50IZinHW39opmhXt3UdjYsM8YTR7OCntxxdDGox+WQok+iz
         IEBa2ddtACIP7Oor2Ne31JPS+Y4OsEGPqnfBbcC4W4JTqDIGjVbt+ALoluT7iZb9/ZR9
         eFACkWeXB+U3QUr1OPddSdGQSru6WexSUrONi5gyol5jUtZmSppQa3VLLCpczCWnpIMN
         k8Dw==
X-Gm-Message-State: AO0yUKVQeRDa7LM426kNdJtJgZK1v2LpjMK5AA2Pik18LG2FUgD17KVC
        u6GaIINyz+yDlj5pmFbMyR+K3N4soWauLOnKXV/bvrlSQsnbdKmk9LCR35Pb38Agk8LMMYPWyA7
        rCDcO2NagTC3Xb4dt76Dsxmdo
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id k22-20020a7bc416000000b003eef1a48895mr1552724wmi.24.1679649150186;
        Fri, 24 Mar 2023 02:12:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set9PHxHrqsJ7v2XCZueLpq6LHVNUDvUsvo02wUs4Ag9qTFq7DHLrspMawYKVjo+lFCfmEDKdcg==
X-Received: by 2002:a7b:c416:0:b0:3ee:f1a4:8895 with SMTP id k22-20020a7bc416000000b003eef1a48895mr1552708wmi.24.1679649149840;
        Fri, 24 Mar 2023 02:12:29 -0700 (PDT)
Received: from redhat.com ([2.52.12.190])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c502a00b003edf2ae2432sm4377159wmr.7.2023.03.24.02.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:12:29 -0700 (PDT)
Date:   Fri, 24 Mar 2023 05:12:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xie Yongji <xieyongji@bytedance.com>, tglx@linutronix.de,
        hch@lst.de, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
Message-ID: <20230324051153-mutt-send-email-mst@kernel.org>
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:27:52PM +0800, Jason Wang wrote:
> On Thu, Mar 23, 2023 at 1:31 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > To support interrupt affinity spreading mechanism,
> > this makes use of group_cpus_evenly() to create
> > an irq callback affinity mask for each virtqueue
> > of vdpa device. Then we will unify set_vq_affinity
> > callback to pass the affinity to the vdpa device driver.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> 
> Thinking hard of all the logics, I think I've found something interesting.
> 
> Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries to
> pass irq_affinity to transport specific find_vqs().  This seems a
> layer violation since driver has no knowledge of
> 
> 1) whether or not the callback is based on an IRQ
> 2) whether or not the device is a PCI or not (the details are hided by
> the transport driver)
> 3) how many vectors could be used by a device
> 
> This means the driver can't actually pass a real affinity masks so the
> commit passes a zero irq affinity structure as a hint in fact, so the
> PCI layer can build a default affinity based that groups cpus evenly
> based on the number of MSI-X vectors (the core logic is the
> group_cpus_evenly). I think we should fix this by replacing the
> irq_affinity structure with
> 
> 1) a boolean like auto_cb_spreading
> 
> or
> 
> 2) queue to cpu mapping
> 
> So each transport can do its own logic based on that. Then virtio-vDPA
> can pass that policy to VDUSE where we only need a group_cpus_evenly()
> and avoid duplicating irq_create_affinity_masks()?
> 
> Thanks

I don't really understand what you propose. Care to post a patch?
Also does it have to block this patchset or can it be done on top?

> > ---
> >  drivers/virtio/virtio_vdpa.c | 68 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index f72696b4c1c2..f3826f42b704 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/uuid.h>
> > +#include <linux/group_cpus.h>
> >  #include <linux/virtio.h>
> >  #include <linux/vdpa.h>
> >  #include <linux/virtio_config.h>
> > @@ -272,6 +273,66 @@ static void virtio_vdpa_del_vqs(struct virtio_device *vdev)
> >                 virtio_vdpa_del_vq(vq);
> >  }
> >
> > +static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
> > +{
> > +       affd->nr_sets = 1;
> > +       affd->set_size[0] = affvecs;
> > +}
> > +
> > +static struct cpumask *
> > +create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> > +{
> > +       unsigned int affvecs = 0, curvec, usedvecs, i;
> > +       struct cpumask *masks = NULL;
> > +
> > +       if (nvecs > affd->pre_vectors + affd->post_vectors)
> > +               affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
> > +
> > +       if (!affd->calc_sets)
> > +               affd->calc_sets = default_calc_sets;
> > +
> > +       affd->calc_sets(affd, affvecs);
> > +
> > +       if (!affvecs)
> > +               return NULL;
> > +
> > +       masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
> > +       if (!masks)
> > +               return NULL;
> > +
> > +       /* Fill out vectors at the beginning that don't need affinity */
> > +       for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> > +               cpumask_setall(&masks[curvec]);
> > +
> > +       for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> > +               unsigned int this_vecs = affd->set_size[i];
> > +               int j;
> > +               struct cpumask *result = group_cpus_evenly(this_vecs);
> > +
> > +               if (!result) {
> > +                       kfree(masks);
> > +                       return NULL;
> > +               }
> > +
> > +               for (j = 0; j < this_vecs; j++)
> > +                       cpumask_copy(&masks[curvec + j], &result[j]);
> > +               kfree(result);
> > +
> > +               curvec += this_vecs;
> > +               usedvecs += this_vecs;
> > +       }
> > +
> > +       /* Fill out vectors at the end that don't need affinity */
> > +       if (usedvecs >= affvecs)
> > +               curvec = affd->pre_vectors + affvecs;
> > +       else
> > +               curvec = affd->pre_vectors + usedvecs;
> > +       for (; curvec < nvecs; curvec++)
> > +               cpumask_setall(&masks[curvec]);
> > +
> > +       return masks;
> > +}
> > +
> >  static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >                                 struct virtqueue *vqs[],
> >                                 vq_callback_t *callbacks[],
> > @@ -282,9 +343,15 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> >         const struct vdpa_config_ops *ops = vdpa->config;
> > +       struct irq_affinity default_affd = { 0 };
> > +       struct cpumask *masks;
> >         struct vdpa_callback cb;
> >         int i, err, queue_idx = 0;
> >
> > +       masks = create_affinity_masks(nvqs, desc ? desc : &default_affd);
> > +       if (!masks)
> > +               return -ENOMEM;
> > +
> >         for (i = 0; i < nvqs; ++i) {
> >                 if (!names[i]) {
> >                         vqs[i] = NULL;
> > @@ -298,6 +365,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >                         err = PTR_ERR(vqs[i]);
> >                         goto err_setup_vq;
> >                 }
> > +               ops->set_vq_affinity(vdpa, i, &masks[i]);
> >         }
> >
> >         cb.callback = virtio_vdpa_config_cb;
> > --
> > 2.20.1
> >

