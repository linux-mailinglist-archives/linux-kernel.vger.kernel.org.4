Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D31651AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiLTGaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiLTGaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA291028
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671517772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzVicSmtTXyJzSoeoDjGd7xBCARhoKZoumXQL8Yoe9E=;
        b=d18l0JUgJJ8Ko6uhcX9DCwWH+uoOSNFcNcbwI4WSK7c7NQTNgodmtXcEHJV2tjIyuKLckn
        xgFkdk9HrurdkwDcXqEs2eQlGb0TBtTs1qi359Ozm9RV6OXit9hCA9v7xEH2aheHt+qoHE
        e5iapTnqwWKdPdSdSkaL/6nwo3Rjl4k=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-225-R3yetJgkMVmHG0vdqbyVcA-1; Tue, 20 Dec 2022 01:29:30 -0500
X-MC-Unique: R3yetJgkMVmHG0vdqbyVcA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-144abfe701dso5186029fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzVicSmtTXyJzSoeoDjGd7xBCARhoKZoumXQL8Yoe9E=;
        b=MiIZ1Z0XKZyyqPBn30PULdpjbMBsN1UQb7WdqVj9KeDBfQkBmm4IB/bBU5pV1c2RxZ
         Gv3ql0J4830MbsdkYGBehH/+7IoXqaFu2XpqtysVwujVUm/qsLPAFoKyGhAxUDZFi7Bv
         IpcRB/1jBWXH2LQ8urH0N56CmriENW0QKgPalf4AkPVU4SL98jZw1r9RfLvopJBqmJ7/
         w6iEs+sec+GwWlkepEptZAHjeYK8MdLpl2QKpO56nJcrOP/N9RaiO7ilELe/7Z5KLREC
         v+l0IXwAaiXASxh0v7Z7NqrZJs9/bfQPpKw6mv/NYpPvxFroAS5SeEaN1hHIkkt+678d
         Wv1Q==
X-Gm-Message-State: ANoB5plAzEd8byRUY1hDICvPjt0HRCbZSEZE7mP5VPjorGGjU49s9+j/
        EmlcRdKzWfDY84JWuKGCDicWJe+oNm0NnE6KcCEROGqDvmz6Rtf+4EiAwvkpv5Bh881fWm2aKie
        Z2OG0YGOnEybz4iE9mmHi8f7F7PrQhnlmIIGjEcf+
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr1114624oab.35.1671517769726;
        Mon, 19 Dec 2022 22:29:29 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7XDhT4Kqn3VliUlOg1lX+MIl+ZQGJw2nP94fJhhFh6xaSPPYK2i99ZSjUkzLPkactll48kTxNV82uaoXotpno=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr1114620oab.35.1671517769547; Mon, 19
 Dec 2022 22:29:29 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com> <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
 <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com>
In-Reply-To: <CACycT3sGf9-zvR_XGEJuPVQhLSp4zsiO1x7RZ5KHBKbE5Deu2Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:29:18 +0800
Message-ID: <CACGkMEuDXytqSWNsx1+GDOSLL0X2Z1fEWWBWT5_nJc-iks9Udw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback affinity
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

On Mon, Dec 19, 2022 at 1:16 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 1:35 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > Add sysfs interface for each vduse virtqueue to
> > > show the affinity and effective affinity for irq
> > > callback.
> > >
> > > And we can also use this interface to change the
> > > effective affinity which must be a subset of the
> > > irq callback affinity mask for the virtqueue. This
> > > might be useful for performance tuning when the irq
> > > callback affinity mask contains more than one CPU.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
> > >  1 file changed, 137 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 6507a78abc9d..c65f84100e30 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -61,6 +61,7 @@ struct vduse_virtqueue {
> > >         int irq_effective_cpu;
> > >         struct cpumask irq_affinity;
> > >         spinlock_t irq_affinity_lock;
> > > +       struct kobject kobj;
> > >  };
> > >
> > >  struct vduse_dev;
> > > @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
> > >         .llseek         = noop_llseek,
> > >  };
> > >
> > > +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> > > +{
> > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> > > +}
> > > +
> > > +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> > > +                                             char *buf)
> > > +{
> > > +       struct cpumask all_mask = CPU_MASK_ALL;
> > > +       const struct cpumask *mask = &all_mask;
> > > +
> > > +       if (vq->irq_effective_cpu != -1)
> > > +               mask = get_cpu_mask(vq->irq_effective_cpu);
> >
> > Shouldn't this be vq->irq_affinity?
> >
>
> This sysfs interface is provided for effective irq affinity rather
> than irq affinity. We created another read-only sysfs interface for
> irq affinity.
>
> > > +
> > > +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> > > +}
> > > +
> > > +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> > > +                                              const char *buf, size_t count)
> > > +{
> > > +       cpumask_var_t new_value;
> > > +       int ret;
> > > +
> > > +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> > > +               return -ENOMEM;
> > > +
> > > +       ret = cpumask_parse(buf, new_value);
> > > +       if (ret)
> > > +               goto free_mask;
> > > +
> > > +       ret = -EINVAL;
> > > +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> > > +               goto free_mask;
> > > +
> > > +       spin_lock(&vq->irq_affinity_lock);
> > > +
> > > +       if (vq->irq_effective_cpu != -1)
> > > +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> > > +
> > > +       vq->irq_effective_cpu = cpumask_first(new_value);
> >
> > Does this mean except for the first cpu, the rest of the mask is unused?
> >
>
> Yes, but the user should always specify a mask that only contains one
> CPU to make it work as expected.

This doesn't seem to be the way that the IRQ affinity{hint} exported
via /sys work. Any reason for doing this?

(E.g we may have the require to limit the IRQ/callback to a NUMA node
instead of a specific cpu)

Thanks

> This sysfs interface is used to
> specify the effective irq affinity rather than irq affinity.
>
> Thanks,
> Yongji
>

