Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5BD36658BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbjAKKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238661AbjAKKM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:12:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF814CE2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673431825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ab2T4X7uK9fotwvUe5iK/l1jUo4Z6arsl3GYiaGQgIA=;
        b=Jnb75s8Npf1H+cNSdJUIQX3zXWgO66AQIP+fZBK7SLiIFC1gV1cqVSxM8q9w+MhM9IHuYl
        r+KYkZ0h9mhrf/Rv085fEL6e8LHRiFt7Q6N7n/Jtsbapb8gfqmkcGotcFuUtdqNB7OwlmL
        Uf8Qx78/c3YwFQJfQtXAKSsENvc5/fg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-BHSB84VBPAyS9nwFHzADsw-1; Wed, 11 Jan 2023 05:10:22 -0500
X-MC-Unique: BHSB84VBPAyS9nwFHzADsw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-4d5097a95f5so23418977b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 02:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ab2T4X7uK9fotwvUe5iK/l1jUo4Z6arsl3GYiaGQgIA=;
        b=HB0UpqFDHRxHtrluqFrQbxjdVEs9ZGuVNBtMS8t6o6yd5fD4WDgBJQkiEEgAq/nOID
         tLfRmnSmGmGXYjuYSkelboI4BSGgr0NEsQ2vUH7XMany3znHtn6iVhRhLzuNfoDAbdZT
         6AjtgIqTrjvnYWXzM5WQSyUR7oDGX/3agcg7vRu3V6pDo5BQdNbidEmYqFbKphZOubEr
         zzPxXGGM325gQS62J3r7VnIuPbYFsAdpPmgd3AxO9lNpiTm0pLDabicYnyqDELJn7Rb8
         v86Nb1806/uvw8/61JNoRI/XVZEouAnvOEr5SGz/5+NSkdeC3IF3u9VcfFThVqYIDWZh
         N+kw==
X-Gm-Message-State: AFqh2kqimNlmg9sKcm8x/Q2Q1B7eR5+EPSBQKSg2BfbMsE9QicLvXf44
        9J1oWOxUa8jGhSMd9WrmEkLbLpY6UdLdocM+IhME35Z0ilmBHerpJnNxzOb5v2zW05Hhs7nSnmM
        ekvTzhS21XxcM1gvgus/qF6zdmR0I8Bo+PMtRArk1
X-Received: by 2002:a81:5292:0:b0:483:813:c70f with SMTP id g140-20020a815292000000b004830813c70fmr272924ywb.266.1673431821538;
        Wed, 11 Jan 2023 02:10:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXut4p3VM0yD8/5Y4e83a1nRa6qrlSf+k+n4EPYQisWAsKUOCyCccCCErr1GqDDIKIaj6eC/6aeEH21xladYy/s=
X-Received: by 2002:a81:5292:0:b0:483:813:c70f with SMTP id
 g140-20020a815292000000b004830813c70fmr272918ywb.266.1673431821306; Wed, 11
 Jan 2023 02:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20230110024445.303-1-liming.wu@jaguarmicro.com>
In-Reply-To: <20230110024445.303-1-liming.wu@jaguarmicro.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Wed, 11 Jan 2023 11:09:45 +0100
Message-ID: <CAJaqyWeuZtx8mUB+jTPVcuiryXpjo09sbvv2QQA2C1-ASMWE1g@mail.gmail.com>
Subject: Re: [PATCH] vhost: remove unused paramete
To:     liming.wu@jaguarmicro.com
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, 398776277@qq.com
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

On Tue, Jan 10, 2023 at 3:46 AM <liming.wu@jaguarmicro.com> wrote:
>
> From: Liming Wu <liming.wu@jaguarmicro.com>
>
> "enabled" is defined in vhost_init_device_iotlb,
> but it is never used. Let's remove it.
>
> Signed-off-by: Liming Wu <liming.wu@jaguarmicro.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vhost/net.c   | 2 +-
>  drivers/vhost/vhost.c | 2 +-
>  drivers/vhost/vhost.h | 2 +-
>  drivers/vhost/vsock.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 9af19b0cf3b7..135e23254a26 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1642,7 +1642,7 @@ static int vhost_net_set_features(struct vhost_net =
*n, u64 features)
>                 goto out_unlock;
>
>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> -               if (vhost_init_device_iotlb(&n->dev, true))
> +               if (vhost_init_device_iotlb(&n->dev))
>                         goto out_unlock;
>         }
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index cbe72bfd2f1f..34458e203716 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1729,7 +1729,7 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *arg
>  }
>  EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
>
> -int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
> +int vhost_init_device_iotlb(struct vhost_dev *d)
>  {
>         struct vhost_iotlb *niotlb, *oiotlb;
>         int i;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index d9109107af08..4bfa10e52297 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -221,7 +221,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, st=
ruct iov_iter *to,
>                             int noblock);
>  ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>                              struct iov_iter *from);
> -int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled);
> +int vhost_init_device_iotlb(struct vhost_dev *d);
>
>  void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
>                           struct vhost_iotlb_map *map);
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index a2b374372363..1ffa36eb3efb 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -829,7 +829,7 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
>         }
>
>         if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> -               if (vhost_init_device_iotlb(&vsock->dev, true))
> +               if (vhost_init_device_iotlb(&vsock->dev))
>                         goto err;
>         }
>
> --
> 2.25.1
>

