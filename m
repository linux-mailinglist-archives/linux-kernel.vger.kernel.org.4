Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08250652BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiLUDVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLUDVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:21:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9861FCEB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671592833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EcW/ZVp4YYgciJ7BFnCTvXG9mJ4eyjo2xCwkenfL2F4=;
        b=JZ/mtVfY2AN2a35t37UMPNYiviXahAZwn0zYpzmK6OkcjQqL5xP5G4U5Cf7Xjqt9ldaHE+
        jkTiZyVrj6Oa0nRF9CeGiNlmXOaiJnbWvogmebh2Ms6UvNZoKzL/An/L4/Rp5F7rNS9KkM
        rpNVITPLt/N55c4R+r80/x/M1tVVGcw=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-124-B-vIGYlcNfmIcGgBldr9aw-1; Tue, 20 Dec 2022 22:20:32 -0500
X-MC-Unique: B-vIGYlcNfmIcGgBldr9aw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1441544a0e5so6266508fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcW/ZVp4YYgciJ7BFnCTvXG9mJ4eyjo2xCwkenfL2F4=;
        b=B8PMC9OG7UQ/bvFIEaxTyLl4jC8dFnhErCr72N7Jr4fQ79fhsz28kMjYKcPa1qcUFP
         9rJOQIMOJo6gL3iHBbT6f9bnO7RjGmxJ6NgR4TgSyTmqd+cfce0Qs+YYu8aa1XAkC21d
         7hvCETds+ozqz3jXccD7RDAFtZ314Y/5RFdZjmj8M2OjYfLroFzxu4akSKo1sNFnpB5P
         kpGSb9trJxxfa4rFbPs/2i5xsHlufj53b2Ajm1l+0P65ojdN4OLhhDGer07xkjQEbxpY
         UyWLYK4rPtzuguvrEXgKWsJQ+1k15XitpXvzZf8iWXi7Bm6spXl4sroANccfoeZrDOa2
         eFjw==
X-Gm-Message-State: AFqh2kqE+hv/+/0S+TuTkujZ4/DE/4X+D5cJR0KyNCsQsquqMeewNCzu
        9tDT4cOGB/7X+SC7QoQU4QOsAL/cOxiTBKoaDzjUN+ZrftmvxTxP3jTe+BzsUBi5B9EnyijlAWs
        jGPvEFKMRrGelNl37QFSY30gjwyeII0dpuVjI2bRe
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id 17-20020aca1111000000b0035e7a427ab5mr11206oir.280.1671592831684;
        Tue, 20 Dec 2022 19:20:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOxGS1RwYuR3X0E7axAQcQe8M4mP2vAHYvXCHnKF7f+yeLTSx8haGOu/8+MQFm4fxS9ZnxKRzdLU+AK2EWdTU=
X-Received: by 2002:aca:1111:0:b0:35e:7a42:7ab5 with SMTP id
 17-20020aca1111000000b0035e7a427ab5mr11202oir.280.1671592831507; Tue, 20 Dec
 2022 19:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com>
 <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
 <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
 <CACGkMEvXTsWbXUgz+sJPiwas9vV2X8rW6w27oQWivcRveoxCKg@mail.gmail.com> <CACycT3vP42dpq5NXFJ-Qua=MKsW9visq+mykS7H6i9gUcqo4NQ@mail.gmail.com>
In-Reply-To: <CACycT3vP42dpq5NXFJ-Qua=MKsW9visq+mykS7H6i9gUcqo4NQ@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Dec 2022 11:20:20 +0800
Message-ID: <CACGkMEvMCqvFwWYOd1U2Z8YXBkxSHK9QX8fWVLdU6oo9WWNRZQ@mail.gmail.com>
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

On Tue, Dec 20, 2022 at 6:14 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 20, 2022 at 2:31 PM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Dec 19, 2022 at 3:12 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > > > >
> > > > > > > This introduces set_irq_affinity callback in
> > > > > > > vdpa_config_ops so that vdpa device driver can
> > > > > > > get the interrupt affinity hint from the virtio
> > > > > > > device driver. The interrupt affinity hint would
> > > > > > > be needed by the interrupt affinity spreading
> > > > > > > mechanism.
> > > > > > >
> > > > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > > > > ---
> > > > > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > > > > >  include/linux/vdpa.h         | 8 ++++++++
> > > > > > >  2 files changed, 12 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > > > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > > > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > > > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > > > > +       struct irq_affinity default_affd = { 0 };
> > > > > > >         struct vdpa_callback cb;
> > > > > > >         int i, err, queue_idx = 0;
> > > > > > >
> > > > > > > +       if (ops->set_irq_affinity)
> > > > > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > > > > >
> > > > > > I wonder if we need to do this in vhost-vDPA.
> > > > >
> > > > > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
> > > >
> > > > If I was not wrong, this tries to set affinity on the host instead of
> > > > the guest. More below.
> > > >
> > >
> > > Yes, it's host stuff. This is used by the virtio device driver to pass
> > > the irq affinity hint (tell which irq vectors don't need affinity
> > > management) to the irq affinity manager. In the VM case, it should
> > > only be related to the guest's virtio device driver and pci irq
> > > affinity manager. So I don't get why we need to do this in vhost-vDPA.
> >
> > It's not necessarily the VM, do we have the same requirement for
> > userspace (like DPDK) drivers?
> >
>
> IIUC the vhost-vdpa's irq callback just signals the eventfd. I didn't
> see how to use the irq affinity hint in vdpa device driver. The real
> irq callback should be called in DPDK internally.

I agree.

Thanks

>
> Thanks,
> Yongji
>

