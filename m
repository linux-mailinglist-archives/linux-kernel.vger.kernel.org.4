Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DC16CB508
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjC1DpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjC1DpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDCCB5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679975066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K3SpR+aNzpuiNbmMwcftC5yQe1ULNEzpRW5A6APnqEo=;
        b=B/2dHuVSrsVykPIpGfIp9UwUS0nN1waTuckWpwZqxbVtcAtbKBjswEm5Zijuh+zhbWPenS
        oUtKBNo8vjeotsPuHYORSJLagkC1qB6apgZ/8p0PVaGbLdFN4M79LjqRzScwSv1cl5Pu4D
        TmW/GynNs/I/F/2R+VCOj0o+kbhDqa4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-N3FmQ9Y5M5C7CK98q4K7cA-1; Mon, 27 Mar 2023 23:44:24 -0400
X-MC-Unique: N3FmQ9Y5M5C7CK98q4K7cA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-17ef7cce3afso4692351fac.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3SpR+aNzpuiNbmMwcftC5yQe1ULNEzpRW5A6APnqEo=;
        b=8Ie1FcK4Qv3XyifrAKONpFiQTJcIR9eBZ3Sh05NqqnRPNK7BoUQenogl+mk6v1aRsu
         S12Az/Wm+KyVZu5f20dCFQdUL886lfL73EFJwRiRYo+KB07FM44zbd35uoe37H2Gi8sA
         PDCI08ZZWIWOW+gU6hUequSv8IGAXCwPjyQgkgg2id399pqotvZrLSDz5XnujF4caVvJ
         OXqYXN40SPE5WYEmTd9wnb9oMTcjPGhoW++PLYBslgfmpmHHb0ItYWuyDmcZ+CXrC2A3
         /xffIpHJswvYd/Jw3xGKbKdxd3t8fn8zexgUF/H+JPRPo2io4FkOeC05kJnRM6nyS7LB
         /d5Q==
X-Gm-Message-State: AAQBX9dRApIjSxTYxDfW1rsld3LkoZsdmhBI/6zHHCrrbHGji6B1Jnvn
        uVQeqT1LeIYAVdo/ynwe7Oi8T55wJS8gfUeO2ZMTE0tZLe/LpPHBlWoxaKXpk1RGvOprYsaFehH
        Vf9dZe978T7IC0WGm0GteBiAT6Vq3bo6jnhpUIt6RJ73YgpsGFQE=
X-Received: by 2002:a05:6871:e45:b0:17f:1723:fc82 with SMTP id vk5-20020a0568710e4500b0017f1723fc82mr2377666oab.9.1679975063868;
        Mon, 27 Mar 2023 20:44:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350brujMRUUxkyu24A854U8qKZyIcDBnAYu48ahVC6qc1K9jGInh2B+qzbASymn1ZBNhTY1XcgR2pBmCW5imGtKY=
X-Received: by 2002:a05:6871:e45:b0:17f:1723:fc82 with SMTP id
 vk5-20020a0568710e4500b0017f1723fc82mr2377659oab.9.1679975063629; Mon, 27 Mar
 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230323053043.35-1-xieyongji@bytedance.com> <20230323053043.35-4-xieyongji@bytedance.com>
 <CACGkMEtH0=vr6JQrqWFZqf4p8bcgeKCr4ipqdBc9nv-st3Pfiw@mail.gmail.com>
 <CACycT3sm1P2qDQTNKp+RLmyd84+v8xwErf_g1SXqiaJDQO8LNg@mail.gmail.com>
 <CACGkMEvhXQ9ve4DQnmVu4hRRbCWM3oesR-=KaLisuyJ4-tyQxg@mail.gmail.com> <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
In-Reply-To: <CACycT3uYbnrQDDbFmwdww8ukMU1t9RsAuutHsFT-UzK9_Mc=Kg@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 28 Mar 2023 11:44:12 +0800
Message-ID: <CACGkMEtRU3qeMazJ2j3u_RC1bUga75Oix0jRJeUJBUF=8QJMgQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] virtio-vdpa: Support interrupt affinity
 spreading mechanism
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:33=E2=80=AFAM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
>
> On Tue, Mar 28, 2023 at 11:14=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Tue, Mar 28, 2023 at 11:03=E2=80=AFAM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > >
> > > On Fri, Mar 24, 2023 at 2:28=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Thu, Mar 23, 2023 at 1:31=E2=80=AFPM Xie Yongji <xieyongji@byted=
ance.com> wrote:
> > > > >
> > > > > To support interrupt affinity spreading mechanism,
> > > > > this makes use of group_cpus_evenly() to create
> > > > > an irq callback affinity mask for each virtqueue
> > > > > of vdpa device. Then we will unify set_vq_affinity
> > > > > callback to pass the affinity to the vdpa device driver.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > >
> > > > Thinking hard of all the logics, I think I've found something inter=
esting.
> > > >
> > > > Commit ad71473d9c437 ("virtio_blk: use virtio IRQ affinity") tries =
to
> > > > pass irq_affinity to transport specific find_vqs().  This seems a
> > > > layer violation since driver has no knowledge of
> > > >
> > > > 1) whether or not the callback is based on an IRQ
> > > > 2) whether or not the device is a PCI or not (the details are hided=
 by
> > > > the transport driver)
> > > > 3) how many vectors could be used by a device
> > > >
> > > > This means the driver can't actually pass a real affinity masks so =
the
> > > > commit passes a zero irq affinity structure as a hint in fact, so t=
he
> > > > PCI layer can build a default affinity based that groups cpus evenl=
y
> > > > based on the number of MSI-X vectors (the core logic is the
> > > > group_cpus_evenly). I think we should fix this by replacing the
> > > > irq_affinity structure with
> > > >
> > > > 1) a boolean like auto_cb_spreading
> > > >
> > > > or
> > > >
> > > > 2) queue to cpu mapping
> > > >
> > >
> > > But only the driver knows which queues are used in the control path
> > > which don't need the automatic irq affinity assignment.
> >
> > Is this knowledge awarded by the transport driver now?
> >
>
> This knowledge is awarded by the device driver rather than the transport =
driver.
>
> E.g. virtio-scsi uses:
>
>     struct irq_affinity desc =3D { .pre_vectors =3D 2 }; // vq0 is contro=
l
> queue, vq1 is event queue

Ok, but it only works as a hint, it's not a real affinity. As replied,
we can pass an array of boolean in this case then transport driver
knows it doesn't need to use automatic affinity for the first two
queues.

>
> > E.g virtio-blk uses:
> >
> >         struct irq_affinity desc =3D { 0, };
> >
> > Atleast we can tell the transport driver which vq requires automatic
> > irq affinity.
> >
>
> I think that is what the current implementation does.
>
> > > So I think the
> > > irq_affinity structure can only be created by device drivers and
> > > passed to the virtio-pci/virtio-vdpa driver.
> >
> > This could be not easy since the driver doesn't even know how many
> > interrupts will be used by the transport driver, so it can't built the
> > actual affinity structure.
> >
>
> The actual affinity mask is built by the transport driver,

For PCI yes, it talks directly to the IRQ subsystems.

> device
> driver only passes a hint on which queues don't need the automatic irq
> affinity assignment.

But not for virtio-vDPA since the IRQ needs to be dealt with by the
parent driver. For our case, it's the VDUSE where it doesn't need IRQ
at all, a queue to cpu mapping is sufficient.

Thanks

>
> Thanks,
> Yongji
>

