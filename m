Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51A6E4210
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjDQIGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDQIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BDC3C10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681718768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYRGijwUbUuPrxX2F6FH2O9hIK+/AiPnJjKAfwN//Kk=;
        b=GhmD8e7bXQFVN+Q7DzIdCzvJdcGWaNCnt69V9uZ87LLTJbkvjC25D6OlnU1Oz9foG7Fqmc
        d0X55eOZFYB1IHjWMZ+7zpfp/NvN1NUunbIY1xrjGIowD1H/9vle1xHYSwtjSnawBdfoAn
        QI2ztxeFW5zbmt1K9be3xliuNvFxiKk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Jo-DeduiPhaFeMDw-Usmow-1; Mon, 17 Apr 2023 04:06:06 -0400
X-MC-Unique: Jo-DeduiPhaFeMDw-Usmow-1
Received: by mail-oo1-f72.google.com with SMTP id v7-20020a4aaec7000000b005425a32c64cso1605092oon.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718766; x=1684310766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYRGijwUbUuPrxX2F6FH2O9hIK+/AiPnJjKAfwN//Kk=;
        b=Wim24fWvMAAFSyoz+PQnk6gafG12he+yT74uQat9gXgadiKL94j29vgr0YfcEdKEGk
         TWDeorG7ffE00FPyk2yger5DZV72j1/qgDLEgUZOa/Y7NuA5JHK3oQXSmvOXx+AuZUHh
         rD17+dAZbqOIhNGjJcH+c6h5RRJmbFDgJKj7/XA8L7j4egEO2/rT5/NoCPvayOV2Fq2h
         OHfE3PWYKHUl7xM0TX9tJOrsjnXGsziWtqb5oax87oQGB37h4BGdYte9xdj1Zhz8K8AL
         Q+2nkmelLdqmAvMjnVB8zyt+1+WPcP7VBZfg1cfB+yhvjmrX4r8b8haKw/aRIHXxDKUE
         9i8A==
X-Gm-Message-State: AAQBX9dIL3roJrFqy25SbvzyDlswuYnvuP7rvxmRmDZS7YwabdXQbOIH
        Ai9oGoEnY0nq5pdIKDcEpj57wEjK28M9oLA4X/dlHxSf146H8lFD5ccshiBgCLxfBVHDm76ymMQ
        MWzqKv5u6i4sNQ06bw+ebgGrhZXucdH+NnyDysvrW
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id m39-20020a056870562700b0017d12871b5cmr6663647oao.9.1681718765908;
        Mon, 17 Apr 2023 01:06:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YjLKQuchwO+hUXUuPxbOO7XX7RZRgN+R5sS6pfxfslGmqlnQwuYF3z03TsVBQdhR5lRHk/kgHDMKGbe2ZMtBc=
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr6663636oao.9.1681718765687; Mon, 17 Apr
 2023 01:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230413081855.36643-1-alvaro.karsz@solid-run.com> <20230413081855.36643-3-alvaro.karsz@solid-run.com>
In-Reply-To: <20230413081855.36643-3-alvaro.karsz@solid-run.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 17 Apr 2023 16:05:54 +0800
Message-ID: <CACGkMEvAWs2bvFT=rZBHUeGmP-yELaF_-ynZ6yLT97UuKdQktw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, yan@daynix.com, viktor@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 4:19=E2=80=AFPM Alvaro Karsz <alvaro.karsz@solid-ru=
n.com> wrote:
>
> Add VIRTIO_F_NOTIFICATION_DATA support for vDPA transport.
> If this feature is negotiated, the driver passes extra data when kicking
> a virtqueue.
>
> A device that offers this feature needs to implement the
> kick_vq_with_data callback.
>
> kick_vq_with_data receives the vDPA device and data.
> data includes:
> 16 bits vqn and 16 bits next available index for split virtqueues.
> 16 bits vqs, 15 least significant bits of next available index
> and 1 bit next_wrap for packed virtqueues.
>
> This patch follows a patch [1] by Viktor Prutyanov which adds support
> for the MMIO, channel I/O and modern PCI transports.
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_vdpa.c | 23 +++++++++++++++++++++--
>  include/linux/vdpa.h         |  9 +++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index d7f5af62dda..737c1f36d32 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -112,6 +112,17 @@ static bool virtio_vdpa_notify(struct virtqueue *vq)
>         return true;
>  }
>
> +static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
> +{
> +       struct vdpa_device *vdpa =3D vd_get_vdpa(vq->vdev);
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       u32 data =3D vring_notification_data(vq);
> +
> +       ops->kick_vq_with_data(vdpa, data);
> +
> +       return true;
> +}
> +
>  static irqreturn_t virtio_vdpa_config_cb(void *private)
>  {
>         struct virtio_vdpa_device *vd_dev =3D private;
> @@ -138,6 +149,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         struct device *dma_dev;
>         const struct vdpa_config_ops *ops =3D vdpa->config;
>         struct virtio_vdpa_vq_info *info;
> +       bool (*notify)(struct virtqueue *vq) =3D virtio_vdpa_notify;
>         struct vdpa_callback cb;
>         struct virtqueue *vq;
>         u64 desc_addr, driver_addr, device_addr;
> @@ -154,6 +166,14 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, uns=
igned int index,
>         if (index >=3D vdpa->nvqs)
>                 return ERR_PTR(-ENOENT);
>
> +       /* We cannot accept VIRTIO_F_NOTIFICATION_DATA without kick_vq_wi=
th_data */
> +       if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA)) {
> +               if (ops->kick_vq_with_data)
> +                       notify =3D virtio_vdpa_notify_with_data;
> +               else
> +                       __virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DA=
TA);
> +       }
> +
>         /* Queue shouldn't already be set up. */
>         if (ops->get_vq_ready(vdpa, index))
>                 return ERR_PTR(-ENOENT);
> @@ -183,8 +203,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>                 dma_dev =3D vdpa_get_dma_dev(vdpa);
>         vq =3D vring_create_virtqueue_dma(index, max_num, align, vdev,
>                                         true, may_reduce_num, ctx,
> -                                       virtio_vdpa_notify, callback,
> -                                       name, dma_dev);
> +                                       notify, callback, name, dma_dev);
>         if (!vq) {
>                 err =3D -ENOMEM;
>                 goto error_new_virtqueue;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 43f59ef10cc..04cdaad77dd 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -143,6 +143,14 @@ struct vdpa_map_file {
>   * @kick_vq:                   Kick the virtqueue
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
> + * @kick_vq_with_data:         Kick the virtqueue and supply extra data
> + *                             (only if VIRTIO_F_NOTIFICATION_DATA is ne=
gotiated)
> + *                             @vdev: vdpa device
> + *                             @data for split virtqueue:
> + *                             16 bits vqn and 16 bits next available in=
dex.
> + *                             @data for packed virtqueue:
> + *                             16 bits vqn, 15 least significant bits of
> + *                             next available index and 1 bit next_wrap.
>   * @set_vq_cb:                 Set the interrupt callback function for
>   *                             a virtqueue
>   *                             @vdev: vdpa device
> @@ -300,6 +308,7 @@ struct vdpa_config_ops {
>                               u64 device_area);
>         void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
>         void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
> +       void (*kick_vq_with_data)(struct vdpa_device *vdev, u32 data);
>         void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
>                           struct vdpa_callback *cb);
>         void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool read=
y);
> --
> 2.34.1
>

