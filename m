Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031646BE20A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCQHpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCQHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:45:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222F6B972
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:44:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so16933171edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679039098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cITCa799qe2upMd6k42Jvo+4kyqcYEmXBxO50VP6e5U=;
        b=SxSQQQBT3US8XPh1SIVcHcPCBSuKk6EDjDZuSqaeF6m0bV5+OrFgdbAKcaSq4kuhx6
         mV/u5HCZMk3CQHzCnHXXzTk7lESHWYEuXBzRnaUVWmM7Jn3ksW02J14ugo0TIce6EvBx
         3mPVGq70JVAwW6ndtxBwsV+rf0oSajbAFiMnS82yrKwo7w5MmA4oAAGRQCZ8ilIep3IZ
         PSZL0L4jQr9dAZMEK05Uy+SvAoDxwWK7jma0bLYVppa49HueG9yjg0Sg3eSqOlf+EJfD
         9mvTsS53iSQvsCn0hQ/YkcB+05QRn5gmiCmGIr1pmJjxI8Ompc7g9dKxfR6uIsBOGMQC
         SlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679039098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cITCa799qe2upMd6k42Jvo+4kyqcYEmXBxO50VP6e5U=;
        b=OO2m4IGl1POmmS4CepgJsR9LpNG4yt0njQR58KrrKT7FzffN9A+NdX7mOwqYoY0Pxn
         zzH6BRbBypaLRK1dRCPP+pGyCU2eUq3oh2Ot8ibV1mVTPsXWVs2nDyB3M7Drqosbr7r9
         +YHYustGGyLf2cqhOPjaF76HpBRZyoHQ0f6mCzdYRHzXR3vFhkl1T212Fs8sPEJHp9va
         2XWH1ZaOy7mfBVHtawLVlp99rialLfhrvrOhEoK3kovKdgctC6ATBcSTiFpW+QbUfCDC
         1GNLYn18ecPnKrz6bhbXctbq6Y5mFH128S9rfOUJ9MmHJV/6GnKf31YoSLHjXGrdqYR3
         fP+A==
X-Gm-Message-State: AO0yUKWi4BZIgjE1oI6cTs3BX/BjkdXoX5dUb/TvmUZtET3BOR0cyBjO
        TMO1Fo7L5xDs5y9KDnMM+VRw5exHXdDdaRiCW/Ea
X-Google-Smtp-Source: AK7set95AE0ngSBO0F64mVK0HvU2T/rpVDtPx07gAxiWkQXf5RqevHZSfF+26UPahbPtdxHKX58DfpFBJ4j0/W/kMmU=
X-Received: by 2002:a17:907:971d:b0:92e:a234:110a with SMTP id
 jg29-20020a170907971d00b0092ea234110amr5213493ejc.3.1679039098192; Fri, 17
 Mar 2023 00:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-4-xieyongji@bytedance.com>
 <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
In-Reply-To: <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 17 Mar 2023 15:44:47 +0800
Message-ID: <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
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

On Thu, Mar 16, 2023 at 12:03=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance.c=
om> wrote:
> >
> > This introduces set_irq_affinity callback in
> > vdpa_config_ops so that vdpa device driver can
> > get the interrupt affinity hint from the virtio
> > device driver. The interrupt affinity hint would
> > be needed by the interrupt affinity spreading
> > mechanism.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/virtio/virtio_vdpa.c | 4 ++++
> >  include/linux/vdpa.h         | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.=
c
> > index f72696b4c1c2..9eee8afabda8 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -282,9 +282,13 @@ static int virtio_vdpa_find_vqs(struct virtio_devi=
ce *vdev, unsigned int nvqs,
> >         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vde=
v);
> >         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > +       struct irq_affinity default_affd =3D { 0 };
> >         struct vdpa_callback cb;
> >         int i, err, queue_idx =3D 0;
> >
> > +       if (ops->set_irq_affinity)
> > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd=
);
> > +
> >         for (i =3D 0; i < nvqs; ++i) {
> >                 if (!names[i]) {
> >                         vqs[i] =3D NULL;
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index d61f369f9cd6..10bd22387276 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -259,6 +259,13 @@ struct vdpa_map_file {
> >   *                             @vdev: vdpa device
> >   *                             @idx: virtqueue index
> >   *                             Returns the irq affinity mask
> > + * @set_irq_affinity:          Pass the irq affinity hint (best effort=
)
>
> Note that this could easily confuse the users. I wonder if we can
> unify it with set_irq_affinity. Looking at vduse's implementation, it
> should be possible.
>

Do you mean unify set_irq_affinity() with set_vq_affinity()? Actually
I didn't get how to achieve that. The set_vq_affinity() callback is
called by virtio_config_ops.set_vq_affinity() but the set_irq_affinity
is called by virtio_config_ops.find_vqs(), I don't know where to call
the unified callback.

Thanks,
Yongji
