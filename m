Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D065651AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiLTGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiLTGdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:33:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642656142
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671517948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6Z7EO57bf3vC7QJ473McXF6jeTHHBAdGwLsa49M35I=;
        b=WQqXz8MwmkPOppZ6u6se6b4He/rvCG6CFuIo0vlK30Hz2GSt+CU9/aFKXINVyKh5Q5JwWK
        +32czqEz3ntl80/smbcWIE/aUvRXjOcPHU9zaCZcgV0Glx2UsVuVtVWDtNcSXnwxFA9nKz
        g624F1TSu5xHwf2m9ETJ9y4LrtJyHU8=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-b2LxKc8HPRWhHNcixdJjZw-1; Tue, 20 Dec 2022 01:32:27 -0500
X-MC-Unique: b2LxKc8HPRWhHNcixdJjZw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1447ffe6046so5160071fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6Z7EO57bf3vC7QJ473McXF6jeTHHBAdGwLsa49M35I=;
        b=w90BTMD0DWYbOepjhlseGx3W5WeZtA0v8TuIWCm/UXjjxcNbPLxhG9qCBONfoVzev9
         K2vDJ6SDcu8dfY1lJZNM8IYwUWbL/4JVVHiVfnF8BLrA8z9B/WLD7tB7dTNPoWCooOQE
         egQww/J3lPSrHza5zcJ3DXBH+4+A5BLWsOZ07i4OCEqWh0s7m1vV2NVBG6FwtePY3fBf
         QVak1RLBWztzVNSFGH17UcQDhJSPahedh6FWwOXu1PxSRpuLBG+05Byx9S/WmjK6iidU
         LvpqkDcvXNYCMFEzTiV1Ql4Ac+YX4YUCwXOmV0loLmm3tKtoZey6mAv0S0jVeyXi9pJJ
         6mxw==
X-Gm-Message-State: ANoB5pnmSRV7ZPE1O9pfcfijnueORwWjCBAq5mKa7LqokCsY8LnP67yn
        fI7/7iFJ1k79GnwLh+ZV8PzUROLrdXMdeJX2pfzgQc/1LSWhRw1K0+BpoxZXQpIGPSfCiEMXEpf
        JoLDdPYWQis3BwKJ84kIqPg49oyzziQ2v3Mk3N+f0
X-Received: by 2002:a05:6808:9b0:b0:35c:303d:fe37 with SMTP id e16-20020a05680809b000b0035c303dfe37mr815060oig.35.1671517946184;
        Mon, 19 Dec 2022 22:32:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6O8kKBLs/Zg9r7I75zBRxziZNso13xp/D7qM4wHnsDLFUHGNeAKcDTWJ0wXqNqaUKzZpAGbB0GD/k3tgBINsw=
X-Received: by 2002:a05:6808:9b0:b0:35c:303d:fe37 with SMTP id
 e16-20020a05680809b000b0035c303dfe37mr815059oig.35.1671517945980; Mon, 19 Dec
 2022 22:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205085846.741-1-xieyongji@bytedance.com>
 <CACGkMEuhYO3neFmxwiBp8C0QTaa+Mb13kken+RZ9QuruMct6tA@mail.gmail.com> <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com>
In-Reply-To: <CACycT3vu0_xCG7SvdP-zkZkuOGdudx2apOwi3CZ4MOFSe-XAFg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:32:14 +0800
Message-ID: <CACGkMEs9nD--8y-dKsv23OK6G7LAC5dLDRRT8sKA5dUrAo0QbQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] vduse: Support automatic irq callback affinity
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 12:56 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 1:30 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:59 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This brings current interrupt affinity spreading mechanism
> > > to vduse device. We will make use of irq_create_affinity_masks()
> > > to create an irq callback affinity mask for each virtqueue of
> > > vduse device. Then we will choose the CPU which has the lowest
> > > number of interrupt allocated in the affinity mask to run the
> > > irq callback.
> >
> > This seems a balance mechanism but it might not be the semantic of the
> > affinity or any reason we need to do this? I guess we should use at
> > least round-robin in this case.
> >
>
> Here we try to follow the pci interrupt management mechanism. In VM
> cases, the interrupt should always be triggered to one specific CPU
> rather than to each CPU in turn.

If I was not wrong, when using MSI, most arch allows not only the
cpuid as the destination but policy like rr and low priority first.

Thanks

>
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 50 ++++++++++++++++++++++++++++++
> > >  1 file changed, 50 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index d126f3e32a20..90c2896039d9 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -23,6 +23,7 @@
> > >  #include <linux/nospec.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/sched/mm.h>
> > > +#include <linux/interrupt.h>
> > >  #include <uapi/linux/vduse.h>
> > >  #include <uapi/linux/vdpa.h>
> > >  #include <uapi/linux/virtio_config.h>
> > > @@ -58,6 +59,8 @@ struct vduse_virtqueue {
> > >         struct work_struct inject;
> > >         struct work_struct kick;
> > >         int irq_effective_cpu;
> > > +       struct cpumask irq_affinity;
> > > +       spinlock_t irq_affinity_lock;
> >
> > Ok, I'd suggest to squash this into patch 5 to make it more easier to
> > be reviewed.
> >
>
> OK.
>
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -123,6 +126,7 @@ struct vduse_control {
> > >
> > >  static DEFINE_MUTEX(vduse_lock);
> > >  static DEFINE_IDR(vduse_idr);
> > > +static DEFINE_PER_CPU(unsigned long, vduse_allocated_irq);
> > >
> > >  static dev_t vduse_major;
> > >  static struct class *vduse_class;
> > > @@ -710,6 +714,49 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> > >         return dev->generation;
> > >  }
> > >
> > > +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> > > +{
> > > +       unsigned int cpu, best_cpu;
> > > +       unsigned long allocated, allocated_min = UINT_MAX;
> > > +
> > > +       spin_lock(&vq->irq_affinity_lock);
> > > +
> > > +       best_cpu = vq->irq_effective_cpu;
> > > +       if (best_cpu != -1)
> > > +               per_cpu(vduse_allocated_irq, best_cpu) -= 1;
> > > +
> > > +       for_each_cpu(cpu, &vq->irq_affinity) {
> > > +               allocated = per_cpu(vduse_allocated_irq, cpu);
> > > +               if (!cpu_online(cpu) || allocated >= allocated_min)
> > > +                       continue;
> > > +
> > > +               best_cpu = cpu;
> > > +               allocated_min = allocated;
> > > +       }
> > > +       vq->irq_effective_cpu = best_cpu;
> > > +       per_cpu(vduse_allocated_irq, best_cpu) += 1;
> > > +
> > > +       spin_unlock(&vq->irq_affinity_lock);
> > > +}
> > > +
> > > +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> > > +                                       struct irq_affinity *desc)
> > > +{
> > > +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> > > +       struct irq_affinity_desc *affd = NULL;
> > > +       int i;
> > > +
> > > +       affd = irq_create_affinity_masks(dev->vq_num, desc);
> > > +       if (!affd)
> >
> > Let's add a comment on the vdpa config ops to say set_irq_affinity()
> > is best effort.
> >
>
> OK.
>
> Thanks,
> Yongji
>

