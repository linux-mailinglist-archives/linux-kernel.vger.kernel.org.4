Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADA6C0D58
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjCTJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjCTJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9DE126F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679304702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZX3eaTeGESwliREyoFlZikVNeBe1KovW4PqQ67m4Eo=;
        b=AW5ZzyIQT75Beg/4k7R25dVMaBoNx+X94PWcstRcwTnLAcghGwBeLmuYcFKyUYZO0S5RaE
        JRyQpBWANCfn09mxLdOtaqNYDBubXT8GA0Zl6aTkNYv/Jgmb4pcTYdxOrulduoZQx5fmzo
        bNON5VfaKyAZWEXXSNl3BjL0HTocNmE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-EscVreDyOX-Paj8lqvXnwg-1; Mon, 20 Mar 2023 05:31:40 -0400
X-MC-Unique: EscVreDyOX-Paj8lqvXnwg-1
Received: by mail-ot1-f70.google.com with SMTP id j18-20020a9d7392000000b0069f087dd4d5so2688518otk.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 02:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679304700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZX3eaTeGESwliREyoFlZikVNeBe1KovW4PqQ67m4Eo=;
        b=27q5oH62TVNNvdx8AdPfpZNljNGVQv209xJfpYKe8fMnVh7+DLq9N0Pn3uVDPO6sUJ
         1t3q662SJuTskiUzqwwXHnIXGVt5nqLbwDtNnZYgccMZTRSKmZqbU03ruiue46h/sT5z
         3l7w9m8ebah/3m46xc1RrqZLWyNtQVdX8GnoGeUWdv87Ej17VdtTv/GUF5F1IPNqZ9yV
         OWZshu7ykV8zjhXq17Bayqco2r3rMUyZx/WdZKOhGrYIhGU7qlZzr9EAHxDnKJZuy/gz
         zD7qT9+ZIxsJ98EvSm7Tn5kBFDzoA1pR/OxjRnCX11DUQWzqOvov2+co9PTF0PxF28sF
         P6ww==
X-Gm-Message-State: AO0yUKWIkXve41eFq+vdt6iKEPLbB3LKVK42AA5V/CsxBTDi2y9S1fXl
        gRSdJnfidO/ZwLWYlKs8bp60WUj6wajYAzOuNXx12zJb1KEldkWtunwJrokwKtlzdKhYiWC1jVf
        Fi82VzgoFgL212pqBLamthh1qmND0r6oSAFT+oU5E
X-Received: by 2002:a05:6870:13d1:b0:17a:d3d2:dc75 with SMTP id 17-20020a05687013d100b0017ad3d2dc75mr1627755oat.3.1679304700243;
        Mon, 20 Mar 2023 02:31:40 -0700 (PDT)
X-Google-Smtp-Source: AK7set/AzSlQ1b+GDVzES3em9nxy5zseXTLWqkB/LLpnFsI/CCnMLxmsP3+gER2yMh5adqsgAxzYfOQku/yQeDGq+48=
X-Received: by 2002:a05:6870:13d1:b0:17a:d3d2:dc75 with SMTP id
 17-20020a05687013d100b0017ad3d2dc75mr1627748oat.3.1679304700009; Mon, 20 Mar
 2023 02:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-4-xieyongji@bytedance.com>
 <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com> <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com>
In-Reply-To: <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 20 Mar 2023 17:31:29 +0800
Message-ID: <CACGkMEuMSo+wjD1tiT8agbbwymXL9Od+ayQWmMKLXd627YWvMg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Mar 17, 2023 at 3:45=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com=
> wrote:
>
> On Thu, Mar 16, 2023 at 12:03=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance=
.com> wrote:
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
> > >  include/linux/vdpa.h         | 9 +++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdp=
a.c
> > > index f72696b4c1c2..9eee8afabda8 100644
> > > --- a/drivers/virtio/virtio_vdpa.c
> > > +++ b/drivers/virtio/virtio_vdpa.c
> > > @@ -282,9 +282,13 @@ static int virtio_vdpa_find_vqs(struct virtio_de=
vice *vdev, unsigned int nvqs,
> > >         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(v=
dev);
> > >         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > > +       struct irq_affinity default_affd =3D { 0 };
> > >         struct vdpa_callback cb;
> > >         int i, err, queue_idx =3D 0;
> > >
> > > +       if (ops->set_irq_affinity)
> > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_af=
fd);
> > > +
> > >         for (i =3D 0; i < nvqs; ++i) {
> > >                 if (!names[i]) {
> > >                         vqs[i] =3D NULL;
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index d61f369f9cd6..10bd22387276 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -259,6 +259,13 @@ struct vdpa_map_file {
> > >   *                             @vdev: vdpa device
> > >   *                             @idx: virtqueue index
> > >   *                             Returns the irq affinity mask
> > > + * @set_irq_affinity:          Pass the irq affinity hint (best effo=
rt)
> >
> > Note that this could easily confuse the users. I wonder if we can
> > unify it with set_irq_affinity. Looking at vduse's implementation, it
> > should be possible.
> >
>
> Do you mean unify set_irq_affinity() with set_vq_affinity()? Actually
> I didn't get how to achieve that. The set_vq_affinity() callback is
> called by virtio_config_ops.set_vq_affinity() but the set_irq_affinity
> is called by virtio_config_ops.find_vqs(), I don't know where to call
> the unified callback.

I meant, can we stick a single per vq affinity config ops then use
that in virtio-vpda's find_vqs() by something like:

masks =3D create_affinity_masks(dev->vq_num, desc);
for (i =3D 0; i < dev->vq_num; i++)
        config->set_vq_affinity()
...

?

Thanks

>
> Thanks,
> Yongji
>

