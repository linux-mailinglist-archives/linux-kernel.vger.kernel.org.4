Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246836BC511
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 05:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCPEDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 00:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCPEDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 00:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55FEA4B3B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 21:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678939373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3NgIc+ak/M8tTVwg+nTzbx40rNW8uHJV2Ocv/hWrBM4=;
        b=BkHwneK2duxO9Hlp9vNVTIeWwjIffa10uLom5GPhvgNKihT+8xeyIjp46LHf/IS3WKnfgm
        YNrIwsl77w1457E1+iWR9uuLXtKuRjaeFNYyZnbMJf+RPGV0KUmal0+Wy7UV0Gf5/87JAx
        0ELXRuVuZg0MaYC0rxm7r1VSbyiWbuw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-GW0ssni0MZW2qm82iVe4uQ-1; Thu, 16 Mar 2023 00:02:52 -0400
X-MC-Unique: GW0ssni0MZW2qm82iVe4uQ-1
Received: by mail-oo1-f72.google.com with SMTP id y140-20020a4a4592000000b0052540059057so67059ooa.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 21:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678939371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NgIc+ak/M8tTVwg+nTzbx40rNW8uHJV2Ocv/hWrBM4=;
        b=ylQO4pP0U2W+Gur8ZgOh59nA/8Iag48EWg1lK0AAyufXCw9TiLc4FZNhDA8afrSzUW
         ZrDsDTZQod9wdtsfKUf7598s7lVsDIQlPOlJIBgfto+UKK+fRn8BuHkx8+Zz2VczlPUn
         a7d1AzQWeoNu6eOh5J+6jQPr/zjEfL2cLxrxUnf8vSvnMynAF7YoJBmyieoTZfH+ER52
         udLAmUtYTUwjZzOI8Mo9RZt+5hfT6jMCFxalYXhIRCKH/ixWzvksQ3F3xtSrLVBUlSkK
         BQP45HGlPizoHR2ytswvDBiDvRGF5OJs5IAi/nwpL72asTLgzNr4ikZ+V2aYckUQuJAO
         G2pA==
X-Gm-Message-State: AO0yUKU51lYTXzBI/jQj2g/Rzm+57pLGxxqEVNZUTargHortr1YiighM
        Uq9FONO8MXWukNOeMSQAWeg58axZbpGDP1ciK5SoZ1ni9fZv/oGxYEx5xlTkV7k4dJ1ykCTwJRf
        xiYb/w04KmWhTHTIbooBYc1UuX2lBn/O5GHNyWD7j16EMy6CHoek=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id cz31-20020a056870649f00b001779f9c0dc5mr6560165oab.9.1678939371351;
        Wed, 15 Mar 2023 21:02:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set8g3ja89JMUVExSezS1VgvMoNhMWwkgtn2lNsstuNCoJJsapbZptTph6GdpByMAKii8UzClR/RRava7uPu0d0k=
X-Received: by 2002:a05:6870:649f:b0:177:9f9c:dc5 with SMTP id
 cz31-20020a056870649f00b001779f9c0dc5mr6560159oab.9.1678939371089; Wed, 15
 Mar 2023 21:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230228094110.37-1-xieyongji@bytedance.com> <20230228094110.37-4-xieyongji@bytedance.com>
In-Reply-To: <20230228094110.37-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Mar 2023 12:02:40 +0800
Message-ID: <CACGkMEvmV7xKc7VnaZT+DGcN2hg64ksGHxRAihW2f=RpXydZoQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] vdpa: Add set_irq_affinity callback in vdpa_config_ops
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
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

On Tue, Feb 28, 2023 at 5:42=E2=80=AFPM Xie Yongji <xieyongji@bytedance.com=
> wrote:
>
> This introduces set_irq_affinity callback in
> vdpa_config_ops so that vdpa device driver can
> get the interrupt affinity hint from the virtio
> device driver. The interrupt affinity hint would
> be needed by the interrupt affinity spreading
> mechanism.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 4 ++++
>  include/linux/vdpa.h         | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f72696b4c1c2..9eee8afabda8 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -282,9 +282,13 @@ static int virtio_vdpa_find_vqs(struct virtio_device=
 *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev)=
;
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> +       struct irq_affinity default_affd =3D { 0 };
>         struct vdpa_callback cb;
>         int i, err, queue_idx =3D 0;
>
> +       if (ops->set_irq_affinity)
> +               ops->set_irq_affinity(vdpa, desc ? desc : &default_affd);
> +
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
>                         vqs[i] =3D NULL;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index d61f369f9cd6..10bd22387276 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -259,6 +259,13 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the irq affinity mask
> + * @set_irq_affinity:          Pass the irq affinity hint (best effort)

Note that this could easily confuse the users. I wonder if we can
unify it with set_irq_affinity. Looking at vduse's implementation, it
should be possible.

(E.g set_vq_affinity implemented by virtio-pci are using irq affinity actua=
lly).

Thanks

> + *                             from the virtio device driver to vdpa
> + *                             driver (optional).
> + *                             Needed by the interrupt affinity spreadin=
g
> + *                             mechanism.
> + *                             @vdev: vdpa device
> + *                             @desc: irq affinity hint
>   * @set_group_asid:            Set address space identifier for a
>   *                             virtqueue group (optional)
>   *                             @vdev: vdpa device
> @@ -353,6 +360,8 @@ struct vdpa_config_ops {
>                                const struct cpumask *cpu_mask);
>         const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev=
,
>                                                  u16 idx);
> +       void (*set_irq_affinity)(struct vdpa_device *vdev,
> +                                struct irq_affinity *desc);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
> --
> 2.20.1
>

