Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4EB6507FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiLSHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 02:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiLSHMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 02:12:45 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F93897
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:12:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id tz12so19251568ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xYTNEE2HIRjcpXCSgTz9dYhsHbo9It0570RIAS4xwa8=;
        b=eBfkans/7tMAdjT3mvZbz8a+AqoeCcUKuN7Z5NejhKvv/ibPlD+eGlYfY/U2cIuyak
         0tryaTppisXq8NZ9nv2W2mPGSVo4Adq6KDOhIwiIrJw+p24fj7naAi5QmmoUXnXGjixS
         Eorpf2mxOKVeJPGecGq0xEwqBL8COYZDJJg5mkvnvXXj3I457ZgMO7GR9nPj0URjkhsr
         zprzcyX603lkIxkS78h3r0WaM9anjKHZK6A2dIRVF/tz0bomK6TMW7Uf2s/kGIDQbL7x
         tdXqv2S6ltnXpl8Zp/IERv5nPxtUE8uhzZU3eQv7estZl30RhiHPwBddtVIObd854XvD
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYTNEE2HIRjcpXCSgTz9dYhsHbo9It0570RIAS4xwa8=;
        b=whbFF04Pjx7pnsOyEGVMr5S60TeW74mx/9KXrJDf94AFqFGPbvchcWZqyBCZpqeZDl
         kT3SC0M6LFTqCTtJm8/n4ELxsbn1xEDyusD2/bR1LqHIrhDfFgxtIKv+qLHEnd0+1iiD
         QJxHfnGmK1smTuP9pK8q7LWSskWIwHIW6qWjSqP9Lk1ZvgDf+J6SaCnOGF0FOt5TYn+b
         Nb8lhkcTsMKxaN9/O5Zy4+UoHPG3u6Cw2CaKkf6XdkHCsCKvvksyQmPfTOa4mYpra/vI
         C59ZTrHfMc7kW9PQjhjrOKEkZtJcMlXA87aoEkiPz3vNPvYGBFBY1U1X90NrYUqDWXml
         zZTw==
X-Gm-Message-State: ANoB5pmK4zeXFB+XTF3xpM4AVj55hgQWu+45fQvp+V78b3JbGe65KpeE
        FdBHYXwbCDY3qvUnskP80kPop3CHu+dNykr4fh5/
X-Google-Smtp-Source: AA0mqf7kmD/ofxsJ9Rc51+d6vXAb/LGDiVEyERnaG9MkOdHSoxKf8sJ2KVR1M6+5DyD6heEjbNJrCATbTenVt0XdwJk=
X-Received: by 2002:a17:906:28db:b0:7c1:4a75:a3a7 with SMTP id
 p27-20020a17090628db00b007c14a75a3a7mr3002513ejd.171.1671433939229; Sun, 18
 Dec 2022 23:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-4-xieyongji@bytedance.com>
 <CACGkMEvYpBz6wdOPFvRveT=0AO=g-nzaeJt3y99oqWDLHUs=qw@mail.gmail.com>
 <CACycT3u237c2jHaYeoPQoXK1eb4FDOJJcc6_21N3m=aBHsDwFg@mail.gmail.com> <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
In-Reply-To: <CACGkMEtoX_jPkJnCB6bx0qkB4pfOAPcSDAdwmd9pL4d8Z3cnEg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 19 Dec 2022 15:12:07 +0800
Message-ID: <CACycT3t1AVyDjZ-HzWPHxfhur=hh9aYW3=Fp7ML8YieBbwDa+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 2:06 PM Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Dec 19, 2022 at 12:39 PM Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Fri, Dec 16, 2022 at 11:58 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This introduces set_irq_affinity callback in
> > > > vdpa_config_ops so that vdpa device driver can
> > > > get the interrupt affinity hint from the virtio
> > > > device driver. The interrupt affinity hint would
> > > > be needed by the interrupt affinity spreading
> > > > mechanism.
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/virtio/virtio_vdpa.c | 4 ++++
> > > >  include/linux/vdpa.h         | 8 ++++++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index 08084b49e5a1..4731e4616ee0 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -275,9 +275,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> > > >         struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vdev);
> > > >         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> > > >         const struct vdpa_config_ops *ops = vdpa->config;
> > > > +       struct irq_affinity default_affd = { 0 };
> > > >         struct vdpa_callback cb;
> > > >         int i, err, queue_idx = 0;
> > > >
> > > > +       if (ops->set_irq_affinity)
> > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> > >
> > > I wonder if we need to do this in vhost-vDPA.
> >
> > I don't get why we need to do this in vhost-vDPA? Should this be done in VM?
>
> If I was not wrong, this tries to set affinity on the host instead of
> the guest. More below.
>

Yes, it's host stuff. This is used by the virtio device driver to pass
the irq affinity hint (tell which irq vectors don't need affinity
management) to the irq affinity manager. In the VM case, it should
only be related to the guest's virtio device driver and pci irq
affinity manager. So I don't get why we need to do this in vhost-vDPA.

> >
> > > Or it's better to have a
> > > default affinity by the vDPA parent
> > >
> >
> > I think both are OK. But the default value should always be zero, so I
> > put it in a common place.
>
> I think we should either:
>
> 1) document the zero default value in vdpa.c
> 2) set the zero in both vhost-vdpa and virtio-vdpa, or in the vdpa core
>

Can we only call it in the virtio-vdpa case? Thus the vdpa device
driver can know whether it needs to do the automatic irq affinity
management or not. In the vhost-vdpa case, we actually don't need the
irq affinity management.

Thanks,
Yongji
