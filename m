Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75902651AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiLTGcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiLTGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E86910A9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671517885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SZk3qbzZQcmYDjImwMsiBT91DtulhDzTYm0+1LHAV3w=;
        b=IW3qSjbKUr/0Da4mswqkjWfZwuJDCdURgs5e8MZ7+itrnID+qaTjdMQCavlhK++tTB+GQw
        JI/LWnzxpe/n6r+zc4DYmfdBIDtJQq3ZyefqTff+uonb0SCjiAUUHhORos4BzhHQa/L0xv
        3Y2tfIkN2gTkmxIpg7FHPogokrrquT0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-pIp4y_v4MKmf0t36tn7gZA-1; Tue, 20 Dec 2022 01:31:24 -0500
X-MC-Unique: pIp4y_v4MKmf0t36tn7gZA-1
Received: by mail-oo1-f69.google.com with SMTP id v10-20020a4a860a000000b00480b3e2b5afso5247890ooh.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 22:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZk3qbzZQcmYDjImwMsiBT91DtulhDzTYm0+1LHAV3w=;
        b=k30KByGxvT1W1uUxwa6Y+O8TIbgZW3Ug3uPRZs8eprWqzU3+MO+OPAj+GiHhYOaW5w
         fsU6vmsz5/+3gl6Y2flLj5tqaFxppcmam0HrlLpfplBEp0pS2QTNR7sO4kFctR+j6GvF
         Vi+m/eBmMjOMp1wL184fXQKFJqS1n/z2++jq3VXt0yKOsN4vs/AUsytDzPGf5wUvthdE
         RnTnIe27LjI4cqkDOLRuw3jqJRALKvJHkzZWdQI9Yf95YaQNpc3rlrAR6DbXW8q8DRJ8
         pMR2WP/PbY2FtSAVVpOpQ5sQj2D11D2NHX7x+voX41eIAtEZunhWM4nf/ulrtDJL+zC9
         W7ZQ==
X-Gm-Message-State: AFqh2kpTjaeARkuPfkhxrVMTxWl3dnmARm/2+FomZN5wgwsowlXKudPa
        Y/pOjqz/vW0pTKdsn1CwQnmXVcx88ajT1FkVoAieg3qoYEShIeUV4ZcUb7eCBC4YbGbznt19C4+
        OM+TdKSP2nf0air4IKv2cCz8t6lrbdvLbykRjPBVi
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id nw26-20020a056870bb1a00b00144b22a38d3mr1889640oab.280.1671517883497;
        Mon, 19 Dec 2022 22:31:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvKoy5ftThnHdcMKVl2Dp6TYAc0+BDO3DE1yq3+SqZO+4wXy1PGUNILooG1bmd2wIyAmjOtGa3O8sgRPcdrDSk=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr1889637oab.280.1671517883295; Mon, 19
 Dec 2022 22:31:23 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
 <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com> <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
In-Reply-To: <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 20 Dec 2022 14:31:12 +0800
Message-ID: <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com>
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

On Mon, Dec 19, 2022 at 3:12 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > This introduces set_irq_affinity callback in
> > > > > vdpa_config_ops so that vdpa device driver can
> > > > > get the interrupt affinity hint from the virtio
> > > > > device driver. The interrupt affinity hint would
> > > > > be needed by the interrupt affinity spreading
> > > > > mechanism.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > > >  include/linux/vdpa.h         | 8 ++++++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > +       struct irq_affinity default_affd = { 0 };
> > > > >         struct vdpa_callback cb;
> > > > >         int i, err, queue_idx = 0;
> > > > >
> > > > > +       if (ops->set_irq_affinity)
> > > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > > >
> > > > I wonder if we need to do this in vhost-vDPA.
> > >
> > > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
> >
> > If I was not wrong, this tries to set affinity on the host instead of
> > the guest. More below.
> >
>
> Yes, it's host stuff. This is used by the virtio device driver to pass
> the irq affinity hint (tell which irq vectors don't need affinity
> management) to the irq affinity manager. In the VM case, it should
> only be related to the guest's virtio device driver and pci irq
> affinity manager. So I don't get why we need to do this in vhost-vDPA.

It's not necessarily the VM, do we have the same requirement for
userspace (like DPDK) drivers?

Thanks

>
> > >
> > > > Or it's better to have a
> > > > default affinity by the vDPA parent
> > > >
> > >
> > > I think both are OK. But the default value should always be zero, so I
> > > put it in a common place.
> >
> > I think we should either:
> >
> > 1) document the zero default value in vdpa.c
> > 2) set the zero in both vhost-vdpa and virtio-vdpa, or in the vdpa core
> >
>
> Can we only call it in the virtio-vdpa case? Thus the vdpa device
> driver can know whether it needs to do the automatic irq affinity
> management or not. In the vhost-vdpa case, we actually don't need the
> irq affinity management.
>
> Thanks,
> Yongji
>

