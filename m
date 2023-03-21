Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D96C282C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCUCaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUCaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:30:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE66D113E5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679365765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yc3yltBy2/7l60SsAiXXcTmVvUT1/yTscKCbTOemK2Y=;
        b=h7VZG4pIxgg3Jdjw4FV4FqGqLj2tEEX8SOGHaiQKjKEOik/zr3mq55D3F3lQVJ/TmxkWeD
        SmvYMeGMWUn2N5ihG52odwgHNZSNcxM1pnMMX2qviYENMHsSTV9Fcpiej2ijBtxvrMR2Vs
        lSkHyI+lvT3xwQ5gV5R8LmUCzAHXICk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-0fo-ZT2UPmaLvS3yHQL4yg-1; Mon, 20 Mar 2023 22:29:23 -0400
X-MC-Unique: 0fo-ZT2UPmaLvS3yHQL4yg-1
Received: by mail-ot1-f70.google.com with SMTP id f5-20020a9d7b45000000b0069de62bd459so5733579oto.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679365763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yc3yltBy2/7l60SsAiXXcTmVvUT1/yTscKCbTOemK2Y=;
        b=C2lUbecFVRSYWt67HKW1rbuOkr1REDaY+kIJHokL8JUzhp3TozwsyLmk0kYbf6tp71
         CB661HNRbCIkI4UewV10gHdwYTl+QJvzulme+8wLPvFaBISgGsFGpzmPK+Y7fZFExR5L
         7JhCaGYlDZVP7URHcf1kO3wD30djZPx+YSsLecqfet7AfVyT4SODL0kwZEQjj7YWwDTZ
         FbAp9Gi36BeKKjb6ko0lhy3dJd4YKmUllS6ImXHp/iLvbgI7hCibszoBNsl9hNGClmrC
         choaNjZ68DxP7n3cw/irykGCYac4kY1YpveNuk9tJEPi4azZYiQmm4sg3h+UNnr9o3Ly
         nBoA==
X-Gm-Message-State: AO0yUKWzbw8wjiULmafYe0VSUHHqg5ueoCmYXLdOhJb5tn56XCv8CZbS
        Q0748d+GukF2YR1FS1cAmQwymwIP5Mpj2qXC/5FuDzsXbdtEPAyw6uo5YbVnI7d8r2trJTrXPz/
        wJPGZ9mVCh9M59uwbfat3gLCr2ngEZrZEnQV5P9fn90bf9f/KPag=
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id m14-20020a9d7e8e000000b0069b01bd7f9emr286844otp.2.1679365762893;
        Mon, 20 Mar 2023 19:29:22 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Il4/4FmteuZUKRVe4PVeRfV79koHDupfEDjFaaWhYBG5Ym845M15YX1cZWogrHAqfr33+4r1eTZKw5gCfwoQ=
X-Received: by 2002:a9d:7e8e:0:b0:69b:1bd:7f9e with SMTP id
 m14-20020a9d7e8e000000b0069b01bd7f9emr286836otp.2.1679365762635; Mon, 20 Mar
 2023 19:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320232115.1940587-1-viktor@daynix.com>
In-Reply-To: <20230320232115.1940587-1-viktor@daynix.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 21 Mar 2023 10:29:11 +0800
Message-ID: <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
To:     Viktor Prutyanov <viktor@daynix.com>
Cc:     mst@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
        farman@linux.ibm.com, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 7:21=E2=80=AFAM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> indicates that the driver passes extra data along with the queue
> notifications.
>
> In a split queue case, the extra data is 16-bit available index. In a
> packed queue case, the extra data is 1-bit wrap counter and 15-bit
> available index.
>
> Add support for this feature for MMIO and PCI transports. Channel I/O
> transport will not accept this feature.
>
> Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> ---
>
>  v2: reject the feature in virtio_ccw, replace __le32 with u32
>
>  drivers/s390/virtio/virtio_ccw.c   |  4 +---
>  drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
>  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
>  drivers/virtio/virtio_pci_common.h |  4 ++++
>  drivers/virtio/virtio_pci_legacy.c |  2 +-
>  drivers/virtio/virtio_pci_modern.c |  2 +-
>  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
>  include/linux/virtio_ring.h        |  2 ++
>  include/uapi/linux/virtio_config.h |  6 ++++++
>  9 files changed, 56 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> index a10dbe632ef9..d72a59415527 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -789,9 +789,7 @@ static u64 virtio_ccw_get_features(struct virtio_devi=
ce *vdev)
>
>  static void ccw_transport_features(struct virtio_device *vdev)
>  {
> -       /*
> -        * Currently nothing to do here.
> -        */
> +       __virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);

Is there any restriction that prevents us from implementing
VIRTIO_F_NOTIFICATION_DATA? (Spec seems doesn't limit us from this)

>  }
>
>  static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 3ff746e3f24a..0e13da17fe0a 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
>         return true;
>  }
>
> +static bool vm_notify_with_data(struct virtqueue *vq)
> +{
> +       struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vq->v=
dev);
> +       u32 data =3D vring_fill_notification_data(vq);

Can we move this to the initialization?

Thanks

