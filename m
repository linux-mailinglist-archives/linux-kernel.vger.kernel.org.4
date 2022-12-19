Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42C665076E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiLSGHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLSGHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:07:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B58138AC
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671429994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XigryfQRFtsWdEbkv6Wm3U8owFw61u6BpVpPnZJFRMg=;
        b=STicuWCAKSvKT7SQljLnXiSoa1CKP8N9din1CJNCwfKmWzNRqet6S1NnzUN6PQeZu/zVj2
        HnNBVqzUT4z+Q3dViUAZRHEr5WvIB0U9n51Ya+9tOPLFsBwtsX/7z95nxvn+SASxyiH4L4
        BrTua0h/jlNyJUJh6aWdpLIjy/+NPfw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-84-2Kg8Yhp_PY-b6C39NGOFXQ-1; Mon, 19 Dec 2022 01:06:32 -0500
X-MC-Unique: 2Kg8Yhp_PY-b6C39NGOFXQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-143d68edfa1so3756835fac.11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 22:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XigryfQRFtsWdEbkv6Wm3U8owFw61u6BpVpPnZJFRMg=;
        b=Fq/BybhFCoRCJJ6+aXIm1qdVo+kIP62Ks24NUXQoMt9fVbRv1UY8CgtZC5SmC/fEvp
         vZUlnCnMnwpIOLTxjOxVPs5vp23OL8C7V1hndLLdq1fdgx9NaO7+3xQilhIz7XJWMTWI
         S7iz4R/nvmBFrKrAEr8JmkZoyjzBdxsF6eunYLcZU5TR6Bu+coOKJEN2xVCdVsu0gV6t
         8kW4p1sGd+IzSdvIs+xviycXxu+KXm3vG/yPkLkilTRZN5PXB2vmFVxZ4rhdB9UhKuzm
         Y4Ws0JXXV1XjWxg8zprhHRHo6dGUry8lzq6wfURYuOh6tK5c1o9/WJYSlqep5fFbhLL2
         tEPg==
X-Gm-Message-State: AFqh2koKMK60B3rz/W066IIlO+7gxOkdSXm8shGQj3dLfeG5oOPiNDb0
        Xv0k6/kYflXc0dOp2I8YJwoLqdUJifr/GrpirojTkFeqX3SdL4pY9IWpoa//OVQpaB/FVLAxd1C
        JK5PXP3fx0gvbJduMtFBl4zWVCfGwkiQv7wT1B+4M
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id nw26-20020a056870bb1a00b00144b22a38d3mr1559330oab.280.1671429991542;
        Sun, 18 Dec 2022 22:06:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtEMJgS1ChBokfoPuf9NBXHkuhyfDrZNuIeENNBw3Xhfy0B/3jRCocYKgxZ7bMQ6hn9bzIu5zP6t5dKWvNJIIo=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1559328oab.280.1671429991369; Sun, 18
 Dec 2022 22:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com> <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
In-Reply-To: <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 19 Dec 2022 14:06:20 +0800
Message-ID: <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
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

On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > >
> > > This introduces set_irq_affinity callback in
> > > vdpa_config_ops so that vdpa device driver can
> > > get the interrupt affinity hint from the virtio
> > > device driver. The interrupt affinity hint would
> > > be needed by the interrupt affinity spreading
> > > mechanism.
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > >  include/linux/vdpa.h         | 8 ++++++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > index 08084b49e5a1..4731e4616ee0 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > +       struct irq_affinity default_affd = { 0 };
> > >         struct vdpa_callback cb;
> > >         int i, err, queue_idx = 0;
> > >
> > > +       if (ops->set_irq_affinity)
> > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> >
> > I wonder if we need to do this in vhost-vDPA.
>
> I don't get why we need to do this in vhost-vDPA? Should this be done in VM?

If I was not wrong, this tries to set affinity on the host instead of
the guest. More below.

>
> > Or it's better to have a
> > default affinity by the vDPA parent
> >
>
> I think both are OK. But the default value should always be zero, so I
> put it in a common place.

I think we should either:

1) document the zero default value in vdpa.c
2) set the zero in both vhost-vdpa and virtio-vdpa, or in the vdpa core

>
> > (Looking at virtio-pci, it doesn't do something like this).
> >
>
> Yes, but we did something like this in the pci layer:
> pci_alloc_irq_vectors_affinity().

Ok.

Thanks

>
> Thanks,
> Yongji
>

