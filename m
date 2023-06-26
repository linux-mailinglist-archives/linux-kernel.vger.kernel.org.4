Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E973D5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFZCb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFZCbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29853B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687746637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyVJTlx31H4Is5RtNpqHEWThTelTV7dr4ksD2iywiNs=;
        b=HV0guCNvmBdnUu9igIgrRkOXc/RPH64m+oaQIRiuKS+GFVjZ9r4q9/PydPFqHtvzShFjfH
        kIaq/MnlAOEl+OTybJqNkSAiidAT3YmsQGqVLZA3YVp4GMC8CDMaYs75oB5YfAF+eLpZ9p
        bFVkVo7xjSviMfBUSUo/kgTWGpMufuo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-sMldV61UMrm6MNVzVTrGLw-1; Sun, 25 Jun 2023 22:30:36 -0400
X-MC-Unique: sMldV61UMrm6MNVzVTrGLw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b698377ed7so6652171fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 19:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687746634; x=1690338634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyVJTlx31H4Is5RtNpqHEWThTelTV7dr4ksD2iywiNs=;
        b=SrTwEvc7WfqHs5a9584fU8RP1qIC9skFI6hmRM1tKTz6yqdynzvI8USAH5AaqmS5/B
         v2vjLfbhVKwkGy2+tAmRoMJHWKAA/CYUeaR6HQM6WBU/6SNZVfigKuJzGn1ndlmE/E1P
         SmCXJO3QTthn4AP+lxYfFtYYG3VOIksNa3+slE2kykidt3bHoqy7vYLl7Q6w8c+qq3cs
         HEIEGegZNjXgcj71DYFmwGZG6ofygfmVu/x2QaQ4K0gvGXnlvixlN05QU5uGsuxPmR4s
         DRfr0q+EyH3d09SaVh+ZEMGK+AaAMJeuMHG7ou7av1WKMrxzaA0+2KC/B6Q63gy49VZE
         pR/g==
X-Gm-Message-State: AC+VfDzmB+m6Sih09rWYNhWcfG7OUAJmanitur2FMp6ARRtgxEn2Ai6j
        xxOf9x1AOM3MZWggXq0fLPX4IDllzXiAuHzViZqVxIdCJL0FkjaHli3CqS4YGhZyKOrGBqiUKSx
        oPimW02D25ld5PAT3NjQ5J+NLzbo3/un6/O/N0ZlULyeSrpYV1Xw=
X-Received: by 2002:a2e:9650:0:b0:2b6:9d4a:d67b with SMTP id z16-20020a2e9650000000b002b69d4ad67bmr1157083ljh.44.1687746634077;
        Sun, 25 Jun 2023 19:30:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4HE5Ezou0qdo0xZEVjTVRdjNGvL6VVNXXpvsoN0NxxZSiZjMETeAiuuywApgDMhKzz0YDmkwXa9PxEvFhwehE=
X-Received: by 2002:a2e:9650:0:b0:2b6:9d4a:d67b with SMTP id
 z16-20020a2e9650000000b002b69d4ad67bmr1157076ljh.44.1687746633791; Sun, 25
 Jun 2023 19:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
In-Reply-To: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 26 Jun 2023 10:30:22 +0800
Message-ID: <CACGkMEtp6H1x301CynwDfsXCMOVt_mrVh9G7dUxVdDLdLBB8yg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from add_config
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 5:02=E2=80=AFPM Angus Chen <angus.chen@jaguarmicro.c=
om> wrote:
>
> When add virtio_pci vdpa device,check the vqs number of device cap
> and max_vq_pairs from add_config.
> Simply starting from failing if the provisioned #qp is not
> equal to the one that hardware has.
>
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> ---
> v1: Use max_vqs from add_config
> v2: Just return fail if max_vqs from add_config is not same as device
>         cap. Suggested by jason.
>
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/=
vp_vdpa.c
> index 281287fae89f..c1fb6963da12 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_=
mdev, const char *name,
>         u64 device_features;
>         int ret, i;
>
> -       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> -                                   dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> -
> -       if (IS_ERR(vp_vdpa)) {
> -               dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> -               return PTR_ERR(vp_vdpa);
> +       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +               if (add_config->net.max_vq_pairs !=3D (v_mdev->max_suppor=
ted_vqs / 2)) {
> +                       dev_err(&pdev->dev, "max vqs 0x%x should be equal=
 to 0x%x which device has\n",
> +                               add_config->net.max_vq_pairs*2, v_mdev->m=
ax_supported_vqs);
> +                       return -EINVAL;
> +               }
>         }
>
> -       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> -
> -       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> -       vp_vdpa->queues =3D vp_modern_get_num_queues(mdev);
> -       vp_vdpa->mdev =3D mdev;
> -
>         device_features =3D vp_modern_get_features(mdev);
>         if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>                 if (add_config->device_features & ~device_features) {
> -                       ret =3D -EINVAL;
>                         dev_err(&pdev->dev, "Try to provision features "
>                                 "that are not supported by the device: "
>                                 "device_features 0x%llx provisioned 0x%ll=
x\n",
>                                 device_features, add_config->device_featu=
res);
> -                       goto err;
> +                       return -EINVAL;
>                 }
>                 device_features =3D add_config->device_features;
>         }
> +
> +       vp_vdpa =3D vdpa_alloc_device(struct vp_vdpa, vdpa,
> +                                   dev, &vp_vdpa_ops, 1, 1, name, false)=
;
> +
> +       if (IS_ERR(vp_vdpa)) {
> +               dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\=
n");
> +               return PTR_ERR(vp_vdpa);
> +       }
> +
> +       vp_vdpa_mgtdev->vp_vdpa =3D vp_vdpa;
> +
> +       vp_vdpa->vdpa.dma_dev =3D &pdev->dev;
> +       vp_vdpa->queues =3D v_mdev->max_supported_vqs;

Why bother with those changes?

        mgtdev->max_supported_vqs =3D vp_modern_get_num_queues(mdev);

Thanks


> +       vp_vdpa->mdev =3D mdev;
>         vp_vdpa->device_features =3D device_features;
>
>         ret =3D devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, p=
dev);
> --
> 2.25.1
>

