Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C2721E95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjFEGzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjFEGzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F629F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685948051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v1eByadmqvsX2J2miV72HS9egA3wTa1Y2KNjCsvenxw=;
        b=b9m6ZSsaI7sSWrBqV4cu6d95NOc+STB2Yu9iMVw0bwO22s7wZ7sLSkf7LHp1fmUTusXfKS
        loRE4SwZTXVBATpRIXq2RU7J0gxxfuT9lwxE473ejgGJ+jwLqEf3DdDb0MjBHuE9QtDPAu
        QQZ5DZ+mBZlT8+yPUun9vFwqmgIo8kg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-BkwaKnn1Nka3ePCc0doxZg-1; Mon, 05 Jun 2023 02:54:09 -0400
X-MC-Unique: BkwaKnn1Nka3ePCc0doxZg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1bbe83720so8755831fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 23:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685948048; x=1688540048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1eByadmqvsX2J2miV72HS9egA3wTa1Y2KNjCsvenxw=;
        b=RP7/G98ybPnkn8yAqDSMhJ1TaX+5NMPFizSlR2x5XHKkkZYWfV0aYuO+1U/J1j/iEG
         ENvPewnI6nOMppSKqJDvIxn3SMeUOqYEWueLj1RUk/OjrQqQDWCzJMV97atidjjmk4ZN
         m0CS5PImZjRuY0k71j3fEkq23s1HRC2IJA7B3OMxF/OuWRGsjaod6eoXaZTigZ2nDNZ2
         tavaSlo6mX2ERaZMGew8ECv6WHDlgudbWobxp2HoO4IJKmCY4UT0m2+dfbatZ6PE/vj2
         upkQmUgXAjKy/u04BD+8W7gLWUr2jYBYx3lxgqSRw+s8RDD/NY87gm1K6pFeG7wPzzry
         mLVg==
X-Gm-Message-State: AC+VfDynQGDgPb0BSMKK94Bk7cmADzdM2YMfER/C5O3W2s4jqYcTXzfd
        0YKacl1CxyFk7jx0uZrIbaWkduf0qiEkkuW9rLNcEjEn1st6OMfzSlDDr0KqejLYsjrIuMKRUly
        pIrhU3QcmTqHo85eB3r4POqxLrCpwaEFoU52uOBb/
X-Received: by 2002:a2e:905a:0:b0:2ac:e6d4:2c02 with SMTP id n26-20020a2e905a000000b002ace6d42c02mr3499648ljg.27.1685948048424;
        Sun, 04 Jun 2023 23:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48B68vKH+UhC6uQbr9ssQ3tolVqqyHzXPOSXBU/O7tK34p9Ijx3KRGRbj7qB3LR40jH1nWx4TQQyeKgoLevKA=
X-Received: by 2002:a2e:905a:0:b0:2ac:e6d4:2c02 with SMTP id
 n26-20020a2e905a000000b002ace6d42c02mr3499639ljg.27.1685948048113; Sun, 04
 Jun 2023 23:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 5 Jun 2023 14:53:56 +0800
Message-ID: <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com>
Subject: Re: [PATCH] vp_vdpa: Check queue number of vdpa device from add_config
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:35=E2=80=AFPM Angus Chen <angus.chen@jaguarmicro.c=
om> wrote:
>
> When add virtio_pci vdpa device,check the vqs number of device cap
> and max_vq_pairs from add_config.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..4bf1ab637d32 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -478,7 +478,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_md=
ev, const char *name,
>         struct device *dev =3D &pdev->dev;
>         struct vp_vdpa *vp_vdpa =3D NULL;
>         u64 device_features;
> -       int ret, i;
> +       int ret, i, queues;
>
>         vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
>                                     dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> @@ -491,7 +491,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_m=
dev, const char *name,
>         vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
>
>         vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> -       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> +       queues =3D vp_modern_get_num_queues(mdev);
> +       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +               if (add_config->net.max_vq_pairs > queues / 2)
> +                       return -EINVAL;
> +               queues =3D min_t(u32, queues, 2 * add_config->net.max_vq_=
pairs);

Looks like you want to mediate the max_vqp here, but what happens:

1) harware have 4 queue paris
2) vp_vdpa cap it into 2 queue pairs
3) guest may still try to enable 4 queue paris

For 3), the kernel needs to mediate the control virtqueue which seems not e=
asy.

How about simply starting from failing if the provisioned #qp is not
equal to the one that hardware has?

Thanks

> +       }
> +
> +       vp_vdpa->queues =3D queues;
>         vp_vdpa->mdev =3D mdev;
>
>         device_features =3D vp_modern_get_features(mdev);
> --
> 2.25.1
>

