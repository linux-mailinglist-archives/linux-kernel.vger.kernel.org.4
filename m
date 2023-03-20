Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E96C109A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCTLTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCTLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:18:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B142C658
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:17:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h31so6359104pgl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679311073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwoggrU4JXZKwsI6koYksXdfAtF/Aj70tZnjPWzW7CM=;
        b=WMVDLA+X6aSuqPX9gVaxGEZje1JZX+kUmNfRH+UeyfeHcf/1SdL77IAexX3PbCvuiq
         a/gz26cFD7nPvtMBpkHcrocdkzxuDgZWfKXjwP5Eq9zK3q1/OHFTVBqX2UC8eI5ZLuwf
         naYM2w8LkLlyoUc+Um5IuZZKNMZRhthGqZmOiH49oSJBm0fVCWYVhc3OZIPEcFGCMESW
         3tCAqm95kzcSXjkpc0If/4dmLv0NA2GigA28axyYj3088vhHmiWMmCqNydBF2hKMrbRA
         q3JCdo9jIrPopjAJbTSUQu8lteBuEavfQ7yqAPnsQ4lkWuVyUGq5OJmgM01A86UGKBWv
         2lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679311073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwoggrU4JXZKwsI6koYksXdfAtF/Aj70tZnjPWzW7CM=;
        b=6MnwVBwT1BXbeXpA/rqQ1nalwp2GaKhjKlcZqs4cJZLUMSqU18i8gU/98rtjez1YtO
         5pUquaxJf20BUosatDyJ8LK036l+tPbqvhYZ0pjUfijOhRCpKyMBeSbM8uRYtTSpCIt9
         JDIGVfWHJnUBaPHcDznCEv4hf3knTGxhUUOIoYDdUYsEbgSqhVjBROLvlSkZwq9Bw0+K
         E1w1exeo8+UOJY6AVtxTGa102joiKA4Q4+oKlJ4ScEbxGVPbyU9kmw/ILtiKpcY8qYIA
         sK+KyUUiAkVyqEKVCNFbbFm8PG+/CCcJvgBMZNVWfNdGZGK1ZDgCPyeJpnfq4V9drxOo
         68ow==
X-Gm-Message-State: AO0yUKWUIZAVNZxoTpzQC7nq4lUijn5wHOzJ0M907RwTx4ROvFiVMhFs
        KBINWuNbLx0iQpmWeHAjmhvTk9VtgFE9pzT5iaBl
X-Google-Smtp-Source: AK7set+rS4kS4c6XYCZD1aImv96xFUG2IzEAO6UXgAZXMTIKsCIDEWVUsTgoNXYQSjjb0MYSSEW8KoOxN4ndHuSQhT0=
X-Received: by 2002:a05:6a00:d69:b0:627:f2fe:9a76 with SMTP id
 n41-20020a056a000d6900b00627f2fe9a76mr1549501pfv.3.1679311072884; Mon, 20 Mar
 2023 04:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-4-xieyongji@bytedance.com>
 <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
 <CACycT3t+n4MXzva7w_yh-iTmzU0M--O4RNXDPxumpY-LmPb6Zg@mail.gmail.com> <CACGkMEuMSo+wjD1tiT8agbbwymXL9Od+ayQWmMKLXd627YWvMg@mail.gmail.com>
In-Reply-To: <CACGkMEuMSo+wjD1tiT8agbbwymXL9Od+ayQWmMKLXd627YWvMg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 20 Mar 2023 19:17:42 +0800
Message-ID: <CACycT3vAui8KgJfuc2=1t+jk=xaV0+apwBdi4TYRafAzS6nAaQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 5:31=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Mar 17, 2023 at 3:45=E2=80=AFPM Yongji Xie <xieyongji@bytedance.c=
om> wrote:
> >
> > On Thu, Mar 16, 2023 at 12:03=E2=80=AFPM Jason Wang <jasowang@redhat.co=
m> wrote:
> > >
> > > On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedan=
ce.com> wrote:
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
> > > >  include/linux/vdpa.h         | 9 +++++++++
> > > >  2 files changed, 13 insertions(+)
> > > >
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_v=
dpa.c
> > > > index f72696b4c1c2..9eee8afabda8 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -282,9 +282,13 @@ static int virtio_vdpa_find_vqs(struct virtio_=
device *vdev, unsigned int nvqs,
> > > >         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device=
(vdev);
> > > >         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> > > >         const struct vdpa_config_ops *ops =3D vdpa->config;
> > > > +       struct irq_affinity default_affd =3D { 0 };
> > > >         struct vdpa_callback cb;
> > > >         int i, err, queue_idx =3D 0;
> > > >
> > > > +       if (ops->set_irq_affinity)
> > > > +               ops->set_irq_affinity(vdpa, desc ? desc : &default_=
affd);
> > > > +
> > > >         for (i =3D 0; i < nvqs; ++i) {
> > > >                 if (!names[i]) {
> > > >                         vqs[i] =3D NULL;
> > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > index d61f369f9cd6..10bd22387276 100644
> > > > --- a/include/linux/vdpa.h
> > > > +++ b/include/linux/vdpa.h
> > > > @@ -259,6 +259,13 @@ struct vdpa_map_file {
> > > >   *                             @vdev: vdpa device
> > > >   *                             @idx: virtqueue index
> > > >   *                             Returns the irq affinity mask
> > > > + * @set_irq_affinity:          Pass the irq affinity hint (best ef=
fort)
> > >
> > > Note that this could easily confuse the users. I wonder if we can
> > > unify it with set_irq_affinity. Looking at vduse's implementation, it
> > > should be possible.
> > >
> >
> > Do you mean unify set_irq_affinity() with set_vq_affinity()? Actually
> > I didn't get how to achieve that. The set_vq_affinity() callback is
> > called by virtio_config_ops.set_vq_affinity() but the set_irq_affinity
> > is called by virtio_config_ops.find_vqs(), I don't know where to call
> > the unified callback.
>
> I meant, can we stick a single per vq affinity config ops then use
> that in virtio-vpda's find_vqs() by something like:
>
> masks =3D create_affinity_masks(dev->vq_num, desc);
> for (i =3D 0; i < dev->vq_num; i++)
>         config->set_vq_affinity()

OK, I see. Will do it in v4.

Thanks,
Yongji
