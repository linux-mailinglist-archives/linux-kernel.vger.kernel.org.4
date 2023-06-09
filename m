Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0712728E2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 04:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjFICue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 22:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbjFICub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 22:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED7A173A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 19:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686278983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xv1Baw44wt8SGx0FR9DHIh3iVJTHiOiXHBPe+fW4Hy0=;
        b=byyXQuzzF+n15EfWNgpXCMNTbqmXb2VYo+cvSiuaM0rn7CgjakTccI6T+kamvP/OJqFmNK
        BfGDAs+Uzd4/jLtzTyyOTuBsulfnpzCNjezvOgySyTHUmvmP18yZk9dj53OOM9W4DUeFcv
        lMGzWdKl58MpTaqHy9MCOHw1rSOielQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-2hS0rQIZPz-SWuFdrmiWGg-1; Thu, 08 Jun 2023 22:49:42 -0400
X-MC-Unique: 2hS0rQIZPz-SWuFdrmiWGg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f614890d21so728683e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 19:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686278980; x=1688870980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xv1Baw44wt8SGx0FR9DHIh3iVJTHiOiXHBPe+fW4Hy0=;
        b=TrrK7w6IQo883JSgiEMHl4AWtPaQY1uJxLPMEDUxu5B5hjjp4emTFp1pC5T6/mhsS8
         BIcV4NYA/v4k6Ypn7Lz3mo2ScHEUiARmi+8EUdqq1ofJshZVUrAGqNXYmDQIlMgObUfh
         3stpFJVvLC8d3QX7gGQt1Mt0jE3W7dJowh2K9EWEk2ZH32YkY7B1PThipkokauWy9R/0
         lk1wdn2fijsFWX6JicfovCWbWVsPpdCLfxipGUnY0voXjocj8+c2ICs2u84c7El6dMJl
         CzRPTgZV/bA7eDeDMsWw1iKzGW45uofSHIgMMHqHlWHZUaLgHCueiGiE1O9WpC2mFSuf
         +AQg==
X-Gm-Message-State: AC+VfDzGLXDu9FJWQ0Jtqd6/pASnsXPyQUykcBn3o1P+e8T+/hnQV3ZV
        7SVd7Zv54a20/9o57C/6/Dd8ne/od64CrjPsVUlBsRDYDjpqxT8gjkZX6iXY7ltI8KsYNnmZWQ1
        MwNb431nEnICzcTBPOh9YEwDgYDIFhkWVZ2Fygu+T
X-Received: by 2002:a19:e349:0:b0:4f5:bc19:68e8 with SMTP id c9-20020a19e349000000b004f5bc1968e8mr31111lfk.54.1686278980642;
        Thu, 08 Jun 2023 19:49:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OFv9WeKmanGM8TiDhfyI2h64WrMkQNxRk3z/9dI+SWt402GL9M9lv2duWKxqPuh651Eb3mxI8sa6jrJVVYM8=
X-Received: by 2002:a19:e349:0:b0:4f5:bc19:68e8 with SMTP id
 c9-20020a19e349000000b004f5bc1968e8mr31104lfk.54.1686278980251; Thu, 08 Jun
 2023 19:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230607190007.290505-1-dtatulea@nvidia.com>
In-Reply-To: <20230607190007.290505-1-dtatulea@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 9 Jun 2023 10:49:29 +0800
Message-ID: <CACGkMEvciNtBX2J9B7TzPTPnNx=NLxqfuUc7rLnv=pswGjjEHg@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Support interrupt bypassing
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, saeedm@nvidia.com,
        Eli Cohen <elic@nvidia.com>,
        virtualization@lists.linux-foundation.org,
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

On Thu, Jun 8, 2023 at 3:01=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> From: Eli Cohen <elic@nvidia.com>
>
> Add support for generation of interrupts from the device directly to the
> VM to the VCPU thus avoiding the overhead on the host CPU.
>
> When supported, the driver will attempt to allocate vectors for each
> data virtqueue. If a vector for a virtqueue cannot be provided it will
> use the QP mode where notifications go through the driver.
>
> In addition, we add a shutdown callback to make sure allocated
> interrupts are released in case of shutdown to allow clean shutdown.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 165 ++++++++++++++++++++++++++++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  15 +++
>  2 files changed, 171 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 279ac6a558d2..9138ef2fb2c8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -83,6 +83,7 @@ struct mlx5_vq_restore_info {
>         u64 driver_addr;
>         u16 avail_index;
>         u16 used_index;
> +       struct msi_map map;
>         bool ready;
>         bool restore;
>  };
> @@ -118,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
>         u16 avail_idx;
>         u16 used_idx;
>         int fw_state;
> +       struct msi_map map;
>
>         /* keep last in the struct */
>         struct mlx5_vq_restore_info ri;
> @@ -808,6 +810,13 @@ static bool counters_supported(const struct mlx5_vdp=
a_dev *mvdev)
>                BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
>  }
>
> +static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
> +{
> +       return MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, event_mode) &
> +               (1 << MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE) &&
> +               pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
> +}
> +
>  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa=
_virtqueue *mvq)
>  {
>         int inlen =3D MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> @@ -849,9 +858,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *nd=
ev, struct mlx5_vdpa_virtque
>         if (vq_is_tx(mvq->index))
>                 MLX5_SET(virtio_net_q_object, obj_context, tisn_or_qpn, n=
dev->res.tisn);
>
> -       MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVENT_MODE_Q=
P_MODE);
> +       if (mvq->map.virq) {
> +               MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVEN=
T_MODE_MSIX_MODE);
> +               MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->map.in=
dex);
> +       } else {
> +               MLX5_SET(virtio_q, vq_ctx, event_mode, MLX5_VIRTIO_Q_EVEN=
T_MODE_QP_MODE);
> +               MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.m=
qp.qpn);
> +       }
> +
>         MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
> -       MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
>         MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
>         MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
>                  !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSIO=
N_1)));
> @@ -1194,6 +1209,56 @@ static void counter_set_dealloc(struct mlx5_vdpa_n=
et *ndev, struct mlx5_vdpa_vir
>                 mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n"=
, mvq->counter_set_id);
>  }
>
> +static irqreturn_t mlx5_vdpa_int_handler(int irq, void *priv)
> +{
> +       struct vdpa_callback *cb =3D priv;
> +
> +       if (cb->callback)
> +               return cb->callback(cb->private);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void alloc_vector(struct mlx5_vdpa_net *ndev,
> +                        struct mlx5_vdpa_virtqueue *mvq)
> +{
> +       struct mlx5_vdpa_irq_pool *irqp =3D &ndev->irqp;
> +       struct mlx5_vdpa_irq_pool_entry *ent;
> +       int err;
> +       int i;
> +
> +       for (i =3D 0; i < irqp->num_ent; i++) {
> +               ent =3D &irqp->entries[i];
> +               if (!ent->used) {
> +                       snprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-v=
q-%d",
> +                                dev_name(&ndev->mvdev.vdev.dev), mvq->in=
dex);
> +                       ent->dev_id =3D &ndev->event_cbs[mvq->index];
> +                       err =3D request_irq(ent->map.virq, mlx5_vdpa_int_=
handler, 0,
> +                                         ent->name, ent->dev_id);
> +                       if (err)
> +                               return;
> +
> +                       ent->used =3D true;
> +                       mvq->map =3D ent->map;
> +                       return;
> +               }
> +       }
> +}
> +
> +static void dealloc_vector(struct mlx5_vdpa_net *ndev,
> +                          struct mlx5_vdpa_virtqueue *mvq)
> +{
> +       struct mlx5_vdpa_irq_pool *irqp =3D &ndev->irqp;
> +       int i;
> +
> +       for (i =3D 0; i < irqp->num_ent; i++)
> +               if (mvq->map.virq =3D=3D irqp->entries[i].map.virq) {
> +                       free_irq(mvq->map.virq, irqp->entries[i].dev_id);
> +                       irqp->entries[i].used =3D false;
> +                       return;
> +               }
> +}
> +
>  static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque=
ue *mvq)
>  {
>         u16 idx =3D mvq->index;
> @@ -1223,27 +1288,31 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, s=
truct mlx5_vdpa_virtqueue *mvq)
>
>         err =3D counter_set_alloc(ndev, mvq);
>         if (err)
> -               goto err_counter;
> +               goto err_connect;
>
> +       alloc_vector(ndev, mvq);
>         err =3D create_virtqueue(ndev, mvq);
>         if (err)
> -               goto err_connect;
> +               goto err_vq;
>
>         if (mvq->ready) {
>                 err =3D modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJ=
ECT_STATE_RDY);
>                 if (err) {
>                         mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to=
 ready vq idx %d(%d)\n",
>                                        idx, err);
> -                       goto err_connect;
> +                       goto err_modify;
>                 }
>         }
>
>         mvq->initialized =3D true;
>         return 0;
>
> -err_connect:
> +err_modify:
> +       destroy_virtqueue(ndev, mvq);
> +err_vq:
> +       dealloc_vector(ndev, mvq);
>         counter_set_dealloc(ndev, mvq);
> -err_counter:
> +err_connect:
>         qp_destroy(ndev, &mvq->vqqp);
>  err_vqqp:
>         qp_destroy(ndev, &mvq->fwqp);
> @@ -1288,6 +1357,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev,=
 struct mlx5_vdpa_virtqueue *
>
>         suspend_vq(ndev, mvq);
>         destroy_virtqueue(ndev, mvq);
> +       dealloc_vector(ndev, mvq);
>         counter_set_dealloc(ndev, mvq);
>         qp_destroy(ndev, &mvq->vqqp);
>         qp_destroy(ndev, &mvq->fwqp);
> @@ -2505,6 +2575,7 @@ static int save_channel_info(struct mlx5_vdpa_net *=
ndev, struct mlx5_vdpa_virtqu
>         ri->desc_addr =3D mvq->desc_addr;
>         ri->device_addr =3D mvq->device_addr;
>         ri->driver_addr =3D mvq->driver_addr;
> +       ri->map =3D mvq->map;
>         ri->restore =3D true;
>         return 0;
>  }
> @@ -2549,6 +2620,7 @@ static void restore_channels_info(struct mlx5_vdpa_=
net *ndev)
>                 mvq->desc_addr =3D ri->desc_addr;
>                 mvq->device_addr =3D ri->device_addr;
>                 mvq->driver_addr =3D ri->driver_addr;
> +               mvq->map =3D ri->map;
>         }
>  }
>
> @@ -2833,6 +2905,25 @@ static struct device *mlx5_get_vq_dma_dev(struct v=
dpa_device *vdev, u16 idx)
>         return mvdev->vdev.dma_dev;
>  }
>
> +static void free_irqs(struct mlx5_vdpa_net *ndev)
> +{
> +       struct mlx5_vdpa_irq_pool_entry *ent;
> +       int i;
> +
> +       if (!msix_mode_supported(&ndev->mvdev))
> +               return;
> +
> +       if (!ndev->irqp.entries)
> +               return;
> +
> +       for (i =3D ndev->irqp.num_ent - 1; i >=3D 0; i--) {
> +               ent =3D ndev->irqp.entries + i;
> +               if (ent->map.virq)
> +                       pci_msix_free_irq(ndev->mvdev.mdev->pdev, ent->ma=
p);
> +       }
> +       kfree(ndev->irqp.entries);
> +}
> +
>  static void mlx5_vdpa_free(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> @@ -2848,6 +2939,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev=
)
>                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>         }
>         mlx5_vdpa_free_resources(&ndev->mvdev);
> +       free_irqs(ndev);
>         kfree(ndev->event_cbs);
>         kfree(ndev->vqs);
>  }
> @@ -2876,9 +2968,23 @@ static struct vdpa_notification_area mlx5_get_vq_n=
otification(struct vdpa_device
>         return ret;
>  }
>
> -static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
> +static int mlx5_get_vq_irq(struct vdpa_device *vdev, u16 idx)
>  {
> -       return -EOPNOTSUPP;
> +       struct mlx5_vdpa_dev *mvdev =3D to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq;
> +
> +       if (!is_index_valid(mvdev, idx))
> +               return -EINVAL;
> +
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               return -EOPNOTSUPP;
> +
> +       mvq =3D &ndev->vqs[idx];
> +       if (!mvq->map.virq)
> +               return -EOPNOTSUPP;
> +
> +       return mvq->map.virq;
>  }
>
>  static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> @@ -3155,6 +3261,34 @@ static int config_func_mtu(struct mlx5_core_dev *m=
dev, u16 mtu)
>         return err;
>  }
>
> +static void allocate_irqs(struct mlx5_vdpa_net *ndev)
> +{
> +       struct mlx5_vdpa_irq_pool_entry *ent;
> +       int i;
> +
> +       if (!msix_mode_supported(&ndev->mvdev))
> +               return;
> +
> +       if (!ndev->mvdev.mdev->pdev)
> +               return;
> +
> +       ndev->irqp.entries =3D kcalloc(ndev->mvdev.max_vqs, sizeof(*ndev-=
>irqp.entries), GFP_KERNEL);
> +       if (!ndev->irqp.entries)
> +               return;
> +
> +
> +       for (i =3D 0; i < ndev->mvdev.max_vqs; i++) {
> +               ent =3D ndev->irqp.entries + i;
> +               snprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-vq-%d",
> +                        dev_name(&ndev->mvdev.vdev.dev), i);
> +               ent->map =3D pci_msix_alloc_irq_at(ndev->mvdev.mdev->pdev=
, MSI_ANY_INDEX, NULL);
> +               if (!ent->map.virq)
> +                       return;
> +
> +               ndev->irqp.num_ent++;
> +       }
> +}
> +
>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *n=
ame,
>                              const struct vdpa_dev_set_config *add_config=
)
>  {
> @@ -3233,6 +3367,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *=
v_mdev, const char *name,
>         }
>
>         init_mvqs(ndev);
> +       allocate_irqs(ndev);
>         init_rwsem(&ndev->reslock);
>         config =3D &ndev->config;
>
> @@ -3413,6 +3548,17 @@ static void mlx5v_remove(struct auxiliary_device *=
adev)
>         kfree(mgtdev);
>  }
>
> +static void mlx5v_shutdown(struct auxiliary_device *auxdev)
> +{
> +       struct mlx5_vdpa_mgmtdev *mgtdev;
> +       struct mlx5_vdpa_net *ndev;
> +
> +       mgtdev =3D auxiliary_get_drvdata(auxdev);
> +       ndev =3D mgtdev->ndev;
> +
> +       free_irqs(ndev);
> +}
> +
>  static const struct auxiliary_device_id mlx5v_id_table[] =3D {
>         { .name =3D MLX5_ADEV_NAME ".vnet", },
>         {},
> @@ -3424,6 +3570,7 @@ static struct auxiliary_driver mlx5v_driver =3D {
>         .name =3D "vnet",
>         .probe =3D mlx5v_probe,
>         .remove =3D mlx5v_remove,
> +       .shutdown =3D mlx5v_shutdown,
>         .id_table =3D mlx5v_id_table,
>  };
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/ml=
x5_vnet.h
> index c90a89e1de4d..36c44d9fdd16 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -26,6 +26,20 @@ static inline u16 key2vid(u64 key)
>         return (u16)(key >> 48) & 0xfff;
>  }
>
> +#define MLX5_VDPA_IRQ_NAME_LEN 32
> +
> +struct mlx5_vdpa_irq_pool_entry {
> +       struct msi_map map;
> +       bool used;
> +       char name[MLX5_VDPA_IRQ_NAME_LEN];
> +       void *dev_id;
> +};
> +
> +struct mlx5_vdpa_irq_pool {
> +       int num_ent;
> +       struct mlx5_vdpa_irq_pool_entry *entries;
> +};
> +
>  struct mlx5_vdpa_net {
>         struct mlx5_vdpa_dev mvdev;
>         struct mlx5_vdpa_net_resources res;
> @@ -49,6 +63,7 @@ struct mlx5_vdpa_net {
>         struct vdpa_callback config_cb;
>         struct mlx5_vdpa_wq_ent cvq_ent;
>         struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +       struct mlx5_vdpa_irq_pool irqp;
>         struct dentry *debugfs;
>  };
>
> --
> 2.40.1
>

