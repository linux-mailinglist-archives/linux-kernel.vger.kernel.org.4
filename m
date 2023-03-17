Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42826BE1C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 08:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCQHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCQHKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 03:10:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3481A39BA4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:10:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd5so16695341edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 00:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679037019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO/7E7z2vOjsJ4C2pcztUKWGDnDolBCwkV4hnPOL/zc=;
        b=M3lBTBvAkGx2YRvpjBSj65pcLelUbWRCS7Shu16S8ANiepQ67cP/4p+6fvd8AwNqeR
         LDPFxEYnuMcqx+rZVEwr+oIjfo/UZp4HYxrb0IT/KQlxeL2iSfKXASgGPhEVk29ie/Di
         3RlEbmQGWlYjGdraTPrOZE/t2nDB031JWzCwV4EBtjCPx6xZfBAMm/8/U674jY8tmE62
         KcWblB3OhY/dQOkJp86jDaIpnPLY6UTYDBd9uiaGsaibfDQ2sBXcqgOkop4k1IkCdymI
         +XSax3ctcUtTgVILR3riI67+AzkSUfMyzF7cn7Hh7jDZfoxQ5DFX/DBeMYg/SOB2SzzS
         DRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679037019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO/7E7z2vOjsJ4C2pcztUKWGDnDolBCwkV4hnPOL/zc=;
        b=Mq8pkX4s44rWMuZnSbTBtwcr9MQbVv7lakPwYoVcnBD1YmyIZ25qqfzLCkAdhr05M/
         85VRGbD0c7dideS/OCfqeJlSdyVR1+5pd4aO+9iXjExHctU48954ARQjFqgZy9qavxmf
         JWzjwzmAPnw5TY1QqqiU8hnlrzX0ESZaBprfShAj9uEuTGI8cAeS0cqn+syV4JZ9JqZy
         moMTKjoKACIxlNwyNup9DhbmfgjDcV/V4WCQhC45dWzSNSttW2m8cGD546dzOOK0sg71
         tahHSRtG1tHKAahKkyIMxR6LStkJCSgZ7tk7cVN8linTmWU2Be3dUyxkUSpFen6qqSpl
         6Lfw==
X-Gm-Message-State: AO0yUKXnkxzl3hhiFSC9QoPgpfeS16HKGx629u+tcJIqy7TBzYbFOr/k
        qCCWabnmL/Qs4NUrKGGKH/+UJkbo8Bz356PY875z
X-Google-Smtp-Source: AK7set9riBz6lk7CluuYhI4YYNfPsk2TDCBW7w33j2QiBhLVMTuJt28oT2MF3qZ0ZzTgw6oTH9H4fDWVJaWzEDxeZ3w=
X-Received: by 2002:a50:8e41:0:b0:4ac:b832:856c with SMTP id
 1-20020a508e41000000b004acb832856cmr1155208edx.1.1679037019651; Fri, 17 Mar
 2023 00:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-3-xieyongji@bytedance.com>
 <319ece63-ac4f-db05-8a55-65ecad75e437@redhat.com>
In-Reply-To: <319ece63-ac4f-db05-8a55-65ecad75e437@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Fri, 17 Mar 2023 15:10:08 +0800
Message-ID: <CACycT3v7kzJ5f+ENzP6d_Y=wyhL4z1uaSAJH+3keTyquTAKf5A@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] vdpa: Add set/get_vq_affinity callbacks in vdpa_config_ops
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

On Thu, Mar 16, 2023 at 11:27=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
>
> =E5=9C=A8 2023/2/28 17:41, Xie Yongji =E5=86=99=E9=81=93:
> > This introduces set/get_vq_affinity callbacks in
> > vdpa_config_ops to support interrupt affinity
> > management for vdpa device drivers.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > ---
> >   drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
> >   include/linux/vdpa.h         | 13 +++++++++++++
> >   2 files changed, 41 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.=
c
> > index d7f5af62ddaa..f72696b4c1c2 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -337,6 +337,32 @@ static const char *virtio_vdpa_bus_name(struct vir=
tio_device *vdev)
> >       return dev_name(&vdpa->dev);
> >   }
> >
> > +static int virtio_vdpa_set_vq_affinity(struct virtqueue *vq,
> > +                                    const struct cpumask *cpu_mask)
> > +{
> > +     struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vq->v=
dev);
> > +     struct vdpa_device *vdpa =3D vd_dev->vdpa;
> > +     const struct vdpa_config_ops *ops =3D vdpa->config;
> > +     unsigned int index =3D vq->index;
> > +
> > +     if (ops->set_vq_affinity)
> > +             return ops->set_vq_affinity(vdpa, index, cpu_mask);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct cpumask *
> > +virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
> > +{
> > +     struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
> > +     const struct vdpa_config_ops *ops =3D vdpa->config;
> > +
> > +     if (ops->get_vq_affinity)
> > +             return ops->get_vq_affinity(vdpa, index);
> > +
> > +     return NULL;
> > +}
> > +
> >   static const struct virtio_config_ops virtio_vdpa_config_ops =3D {
> >       .get            =3D virtio_vdpa_get,
> >       .set            =3D virtio_vdpa_set,
> > @@ -349,6 +375,8 @@ static const struct virtio_config_ops virtio_vdpa_c=
onfig_ops =3D {
> >       .get_features   =3D virtio_vdpa_get_features,
> >       .finalize_features =3D virtio_vdpa_finalize_features,
> >       .bus_name       =3D virtio_vdpa_bus_name,
> > +     .set_vq_affinity =3D virtio_vdpa_set_vq_affinity,
> > +     .get_vq_affinity =3D virtio_vdpa_get_vq_affinity,
> >   };
> >
> >   static void virtio_vdpa_release_dev(struct device *_d)
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 43f59ef10cc9..d61f369f9cd6 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -250,6 +250,15 @@ struct vdpa_map_file {
> >    *                          @vdev: vdpa device
> >    *                          Returns the iova range supported by
> >    *                          the device.
> > + * @set_vq_affinity:         Set the irq affinity of virtqueue (option=
al)
>
>
> Nit: it's better not mention IRQ here because the virtqueue notification
> is not necessarily backed on IRQ.
>

OK.

Thanks,
Yongji
