Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6043162949C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiKOJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237670AbiKOJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC671F602
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668505360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ttHEaBx/IeW3e6Bv3/BHbYEZFm14tUllVeBMnniWeY=;
        b=f4iqaDP8yIKSYMtlmg/Bod+oRPe3bG0N8uGKttE3z1b1zHvP0NSGQ2Go7/laq2kF1mANCJ
        WMxnfBp9Z82vMpnJltJX9tWIeumg/6dzF/ICEwoZBqCsJtmUDh2W0EuM8wB5SukTd0x2Qx
        zD5Dexjq3BingzrhXXRcwy9SDNR48bE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-531-dcCUcmJVNDqUVogrHzQPEg-1; Tue, 15 Nov 2022 04:42:36 -0500
X-MC-Unique: dcCUcmJVNDqUVogrHzQPEg-1
Received: by mail-pl1-f198.google.com with SMTP id b18-20020a170903229200b00186e357f3b9so10919551plh.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ttHEaBx/IeW3e6Bv3/BHbYEZFm14tUllVeBMnniWeY=;
        b=lxtDvVACoguH+0GAMcWpoFhadFeiuaiQuMnFytJ3kPBL5c/Wu8dSMWDXLzRhZ7w6oS
         kVSwgfGTaILdTKCWhr3hzI2RxsNuLdCPWXH+VKrK8PlG7w1lPY0vuo2crXlyr4hIQZaF
         bq48HAS27c5L+xsCjkiTrEtqQhfra1XauLk2C7/4Ny62Bsa2VBpncVuNp0BpD8q9kClP
         Seb2Xpv8SRJVb+t7gwNLSMAfVa2TzBDJ0gfwHkET1SWJcMDbYQIYRqIInmNg0Ma3Bb5V
         pdzSCfr+zIOqdE0UdthJ66Iv+l5nI/sBhhfPU8bejR3JX1RZcaKgfAeSUU08H2O2QNwL
         DunQ==
X-Gm-Message-State: ANoB5pnX5gt4NStcGSJ/4bOGnvPS1K18D3bOM3spkE8Bxscs1CpOvO+h
        do/dwAVenYfY4CM0aAyXEcd+QMXduTRJe5snY4ncfo6iaCj9tYp5whCvimqxFvwpI0s1Ar1f8TN
        Lp/6W80nxQGE3p/RdDpyxP3GFleUKil8Bvig/mBeX
X-Received: by 2002:a17:902:ccca:b0:188:aa84:14 with SMTP id z10-20020a170902ccca00b00188aa840014mr3269968ple.17.1668505355130;
        Tue, 15 Nov 2022 01:42:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6yhPrTg+Fg/YxEZM+Z0DzpphJj4xjNvg/PG2ZFR8L8FMs61BPnBAqbj935UL+bb2wnpQBgkZWpP9nVh6bmeA8=
X-Received: by 2002:a17:902:ccca:b0:188:aa84:14 with SMTP id
 z10-20020a170902ccca00b00188aa840014mr3269941ple.17.1668505354778; Tue, 15
 Nov 2022 01:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20221114131759.57883-1-elic@nvidia.com> <20221114131759.57883-6-elic@nvidia.com>
In-Reply-To: <20221114131759.57883-6-elic@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 15 Nov 2022 10:41:58 +0100
Message-ID: <CAJaqyWfw5gpF7qQwqoML2qjGGbZuMyDBLw1yuiWoAkLN2uocTg@mail.gmail.com>
Subject: Re: [PATH v2 5/8] vdpa/mlx5: Avoid overwriting CVQ iotlb
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        lulu@redhat.com
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

On Mon, Nov 14, 2022 at 2:18 PM Eli Cohen <elic@nvidia.com> wrote:
>
> When qemu uses different address spaces for data and control virtqueues,
> the current code would overwrite the control virtqueue iotlb through the
> dup_iotlb call. Fix this by referring to the address space identifier
> and the group to asid mapping to determine which mapping needs to be
> updated. We also move the address space logic from mlx5 net to core
> directory.
>
> Reported-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  5 +--
>  drivers/vdpa/mlx5/core/mr.c        | 44 ++++++++++++++++-----------
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 49 ++++++------------------------
>  3 files changed, 39 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 6af9fdbb86b7..058fbe28107e 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -116,8 +116,9 @@ int mlx5_vdpa_create_mkey(struct mlx5_vdpa_dev *mvdev=
, u32 *mkey, u32 *in,
>                           int inlen);
>  int mlx5_vdpa_destroy_mkey(struct mlx5_vdpa_dev *mvdev, u32 mkey);
>  int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_i=
otlb *iotlb,
> -                            bool *change_map);
> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb);
> +                            bool *change_map, unsigned int asid);
> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> +                       unsigned int asid);
>  void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
>
>  #define mlx5_vdpa_warn(__dev, format, ...)                              =
                           \
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index a639b9208d41..a4d7ee2339fa 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -511,7 +511,8 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev=
)
>         mutex_unlock(&mr->mkey_mtx);
>  }
>
> -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhos=
t_iotlb *iotlb)
> +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb, unsigned int a=
sid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         int err;
> @@ -519,42 +520,49 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_de=
v *mvdev, struct vhost_iotlb
>         if (mr->initialized)
>                 return 0;
>
> -       if (iotlb)
> -               err =3D create_user_mr(mvdev, iotlb);
> -       else
> -               err =3D create_dma_mr(mvdev, mr);
> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> +               if (iotlb)
> +                       err =3D create_user_mr(mvdev, iotlb);
> +               else
> +                       err =3D create_dma_mr(mvdev, mr);
>
> -       if (err)
> -               return err;
> +               if (err)
> +                       return err;
> +       }
>
> -       err =3D dup_iotlb(mvdev, iotlb);
> -       if (err)
> -               goto out_err;
> +       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid) {
> +               err =3D dup_iotlb(mvdev, iotlb);
> +               if (err)
> +                       goto out_err;
> +       }
>
>         mr->initialized =3D true;
>         return 0;
>
>  out_err:
> -       if (iotlb)
> -               destroy_user_mr(mvdev, mr);
> -       else
> -               destroy_dma_mr(mvdev, mr);
> +       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> +               if (iotlb)
> +                       destroy_user_mr(mvdev, mr);
> +               else
> +                       destroy_dma_mr(mvdev, mr);
> +       }
>
>         return err;
>  }
>
> -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb)
> +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> +                       unsigned int asid)
>  {
>         int err;
>
>         mutex_lock(&mvdev->mr.mkey_mtx);
> -       err =3D _mlx5_vdpa_create_mr(mvdev, iotlb);
> +       err =3D _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
>         mutex_unlock(&mvdev->mr.mkey_mtx);
>         return err;
>  }
>
>  int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mvdev, struct vhost_i=
otlb *iotlb,
> -                            bool *change_map)
> +                            bool *change_map, unsigned int asid)
>  {
>         struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
>         int err =3D 0;
> @@ -566,7 +574,7 @@ int mlx5_vdpa_handle_set_map(struct mlx5_vdpa_dev *mv=
dev, struct vhost_iotlb *io
>                 *change_map =3D true;
>         }
>         if (!*change_map)
> -               err =3D _mlx5_vdpa_create_mr(mvdev, iotlb);
> +               err =3D _mlx5_vdpa_create_mr(mvdev, iotlb, asid);
>         mutex_unlock(&mr->mkey_mtx);
>
>         return err;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 98dd8ce8af26..3a6dbbc6440d 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2394,7 +2394,8 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>         }
>  }
>
> -static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhos=
t_iotlb *iotlb)
> +static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
> +                               struct vhost_iotlb *iotlb, unsigned int a=
sid)
>  {
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         int err;
> @@ -2406,7 +2407,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_de=
v *mvdev, struct vhost_iotlb
>
>         teardown_driver(ndev);
>         mlx5_vdpa_destroy_mr(mvdev);
> -       err =3D mlx5_vdpa_create_mr(mvdev, iotlb);
> +       err =3D mlx5_vdpa_create_mr(mvdev, iotlb, asid);
>         if (err)
>                 goto err_mr;
>
> @@ -2587,7 +2588,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev=
)
>         ++mvdev->generation;
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> -               if (mlx5_vdpa_create_mr(mvdev, NULL))
> +               if (mlx5_vdpa_create_mr(mvdev, NULL, 0))
>                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
>         }
>         up_write(&ndev->reslock);
> @@ -2623,41 +2624,20 @@ static u32 mlx5_vdpa_get_generation(struct vdpa_d=
evice *vdev)
>         return mvdev->generation;
>  }
>
> -static int set_map_control(struct mlx5_vdpa_dev *mvdev, struct vhost_iot=
lb *iotlb)
> -{
> -       u64 start =3D 0ULL, last =3D 0ULL - 1;
> -       struct vhost_iotlb_map *map;
> -       int err =3D 0;
> -
> -       spin_lock(&mvdev->cvq.iommu_lock);
> -       vhost_iotlb_reset(mvdev->cvq.iotlb);
> -
> -       for (map =3D vhost_iotlb_itree_first(iotlb, start, last); map;
> -            map =3D vhost_iotlb_itree_next(map, start, last)) {
> -               err =3D vhost_iotlb_add_range(mvdev->cvq.iotlb, map->star=
t,
> -                                           map->last, map->addr, map->pe=
rm);
> -               if (err)
> -                       goto out;
> -       }
> -
> -out:
> -       spin_unlock(&mvdev->cvq.iommu_lock);
> -       return err;
> -}
> -
> -static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb)
> +static int set_map_data(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb =
*iotlb,
> +                       unsigned int asid)
>  {
>         bool change_map;
>         int err;
>
> -       err =3D mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
> +       err =3D mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map, asid)=
;
>         if (err) {
>                 mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
>                 return err;
>         }
>
>         if (change_map)
> -               err =3D mlx5_vdpa_change_map(mvdev, iotlb);
> +               err =3D mlx5_vdpa_change_map(mvdev, iotlb, asid);
>
>         return err;
>  }
> @@ -2670,16 +2650,7 @@ static int mlx5_vdpa_set_map(struct vdpa_device *v=
dev, unsigned int asid,
>         int err =3D -EINVAL;
>
>         down_write(&ndev->reslock);
> -       if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] =3D=3D asid) {
> -               err =3D set_map_data(mvdev, iotlb);
> -               if (err)
> -                       goto out;
> -       }
> -
> -       if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid)
> -               err =3D set_map_control(mvdev, iotlb);
> -
> -out:
> +       err =3D set_map_data(mvdev, iotlb, asid);
>         up_write(&ndev->reslock);
>         return err;
>  }
> @@ -3182,7 +3153,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>                 goto err_mpfs;
>
>         if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> -               err =3D mlx5_vdpa_create_mr(mvdev, NULL);
> +               err =3D mlx5_vdpa_create_mr(mvdev, NULL, 0);
>                 if (err)
>                         goto err_res;
>         }
> --
> 2.38.1
>

