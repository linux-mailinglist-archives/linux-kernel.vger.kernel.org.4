Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D7C728751
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjFHSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbjFHSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F12695
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686249310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2bQcHG+zKEW1dxMHjPekLRCcGESsdy0BSM0jY0k8Cc=;
        b=hwQbDVor8XKgG0xx9aQDhZP8Df6yB4shQMbuQLYMpled/0iEBo6ijoCCrmB3evySB6GqTL
        w7QYs6YI3m/v8qsHLPzyJ/DBxPS2soBbTkKWWXMvdwXyTzLLlcqhApZd1kMBzpWTLldegc
        ciXYxS2oT/jtZH16MDKsUDSKqg9FkLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-oQeRYHy3MpGI5ykZ8ZPifw-1; Thu, 08 Jun 2023 14:35:09 -0400
X-MC-Unique: oQeRYHy3MpGI5ykZ8ZPifw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae4ed92eeso422300f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 11:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686249308; x=1688841308;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2bQcHG+zKEW1dxMHjPekLRCcGESsdy0BSM0jY0k8Cc=;
        b=hNzi2sWqdR8z3zEaomOODzfK49EPlbThiIUrQ/PbVbonTFTEL5Aov7l1CD3NZ4PEcb
         a7FQLUw3NuCMoSD+ur6Ya8Xv8JA/Lb4ERTFVn+UvLm6RIrDlsMg7Faxv5bqQJtau47/+
         +a0ewVuQtGpKCm1lkPMFjuPFge1Db+bOYLTn0l7k2mvCa7/UvVgaErWny8eVt0SU04nI
         kSanaQgZeVN9ghi36bHHs2EOjrrJXjCpxxpGzbRWwi6VYRk97PlcAGSYGWSlcwdcteUN
         96Qvcybiz6oc98sIywL3uCxgyHmv3bdwDVfrhgUvWvyXzgTWS2zuwpbah1fIkye4QLr8
         nWhw==
X-Gm-Message-State: AC+VfDyzNMIUqhYAGpoX3kmW6SLpUwKFEs5Ykxcnmue8L8u2qtx4xXF8
        HYRtMHA0x3qNN6jsCiRzzTKoWud8o+IAZOAE5mW1g3DVlZM6fFrd+2UyD0a7cwM7YejraX68B+X
        3yRbyDVEmYR0L2rJPZHnA5pkHRyqI2ih9
X-Received: by 2002:a5d:408b:0:b0:30a:e675:7e92 with SMTP id o11-20020a5d408b000000b0030ae6757e92mr6996783wrp.24.1686249307974;
        Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ebde3/2zvOHcahGfGkNtXLeveVr4UNWK45EvEkw55IL0kPC4bYFpc4NDrXh0K7WqjuxGaMQ==
X-Received: by 2002:a5d:408b:0:b0:30a:e675:7e92 with SMTP id o11-20020a5d408b000000b0030ae6757e92mr6996773wrp.24.1686249307738;
        Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id t18-20020adfeb92000000b003093a412310sm2249080wrn.92.2023.06.08.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:35:07 -0700 (PDT)
Date:   Thu, 8 Jun 2023 14:35:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Eli Cohen <elic@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Support interrupt bypassing
Message-ID: <20230608143457-mutt-send-email-mst@kernel.org>
References: <20230607190007.290505-1-dtatulea@nvidia.com>
 <118eac3c96665e3eac3397eef127606200f4aa50.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <118eac3c96665e3eac3397eef127606200f4aa50.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:25:55PM +0000, Dragos Tatulea wrote:
> On Wed, 2023-06-07 at 22:00 +0300, Dragos Tatulea via Virtualization wrote:
> > From: Eli Cohen <elic@nvidia.com>
> > 
> > Add support for generation of interrupts from the device directly to the
> > VM to the VCPU thus avoiding the overhead on the host CPU.
> > 
> > When supported, the driver will attempt to allocate vectors for each
> > data virtqueue. If a vector for a virtqueue cannot be provided it will
> > use the QP mode where notifications go through the driver.
> > 
> > In addition, we add a shutdown callback to make sure allocated
> > interrupts are released in case of shutdown to allow clean shutdown.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > 
> Just realized that this patch should have been marked as a v3. Let me know if I
> should resend it.

no need.

> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 165 ++++++++++++++++++++++++++++--
> >  drivers/vdpa/mlx5/net/mlx5_vnet.h |  15 +++
> >  2 files changed, 171 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 279ac6a558d2..9138ef2fb2c8 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -83,6 +83,7 @@ struct mlx5_vq_restore_info {
> >         u64 driver_addr;
> >         u16 avail_index;
> >         u16 used_index;
> > +       struct msi_map map;
> >         bool ready;
> >         bool restore;
> >  };
> > @@ -118,6 +119,7 @@ struct mlx5_vdpa_virtqueue {
> >         u16 avail_idx;
> >         u16 used_idx;
> >         int fw_state;
> > +       struct msi_map map;
> >  
> >         /* keep last in the struct */
> >         struct mlx5_vq_restore_info ri;
> > @@ -808,6 +810,13 @@ static bool counters_supported(const struct mlx5_vdpa_dev
> > *mvdev)
> >                BIT_ULL(MLX5_OBJ_TYPE_VIRTIO_Q_COUNTERS);
> >  }
> >  
> > +static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
> > +{
> > +       return MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, event_mode) &
> > +               (1 << MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE) &&
> > +               pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
> > +}
> > +
> >  static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct
> > mlx5_vdpa_virtqueue *mvq)
> >  {
> >         int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
> > @@ -849,9 +858,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev,
> > struct mlx5_vdpa_virtque
> >         if (vq_is_tx(mvq->index))
> >                 MLX5_SET(virtio_net_q_object, obj_context, tisn_or_qpn, ndev-
> > >res.tisn);
> >  
> > -       MLX5_SET(virtio_q, vq_ctx, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> > +       if (mvq->map.virq) {
> > +               MLX5_SET(virtio_q, vq_ctx, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_MSIX_MODE);
> > +               MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->map.index);
> > +       } else {
> > +               MLX5_SET(virtio_q, vq_ctx, event_mode,
> > MLX5_VIRTIO_Q_EVENT_MODE_QP_MODE);
> > +               MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq-
> > >fwqp.mqp.qpn);
> > +       }
> > +
> >         MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
> > -       MLX5_SET(virtio_q, vq_ctx, event_qpn_or_msix, mvq->fwqp.mqp.qpn);
> >         MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
> >         MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
> >                  !!(ndev->mvdev.actual_features &
> > BIT_ULL(VIRTIO_F_VERSION_1)));
> > @@ -1194,6 +1209,56 @@ static void counter_set_dealloc(struct mlx5_vdpa_net
> > *ndev, struct mlx5_vdpa_vir
> >                 mlx5_vdpa_warn(&ndev->mvdev, "dealloc counter set 0x%x\n",
> > mvq->counter_set_id);
> >  }
> >  
> > +static irqreturn_t mlx5_vdpa_int_handler(int irq, void *priv)
> > +{
> > +       struct vdpa_callback *cb = priv;
> > +
> > +       if (cb->callback)
> > +               return cb->callback(cb->private);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static void alloc_vector(struct mlx5_vdpa_net *ndev,
> > +                        struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +       struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> > +       struct mlx5_vdpa_irq_pool_entry *ent;
> > +       int err;
> > +       int i;
> > +
> > +       for (i = 0; i < irqp->num_ent; i++) {
> > +               ent = &irqp->entries[i];
> > +               if (!ent->used) {
> > +                       snprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-vq-
> > %d",
> > +                                dev_name(&ndev->mvdev.vdev.dev), mvq->index);
> > +                       ent->dev_id = &ndev->event_cbs[mvq->index];
> > +                       err = request_irq(ent->map.virq,
> > mlx5_vdpa_int_handler, 0,
> > +                                         ent->name, ent->dev_id);
> > +                       if (err)
> > +                               return;
> > +
> > +                       ent->used = true;
> > +                       mvq->map = ent->map;
> > +                       return;
> > +               }
> > +       }
> > +}
> > +
> > +static void dealloc_vector(struct mlx5_vdpa_net *ndev,
> > +                          struct mlx5_vdpa_virtqueue *mvq)
> > +{
> > +       struct mlx5_vdpa_irq_pool *irqp = &ndev->irqp;
> > +       int i;
> > +
> > +       for (i = 0; i < irqp->num_ent; i++)
> > +               if (mvq->map.virq == irqp->entries[i].map.virq) {
> > +                       free_irq(mvq->map.virq, irqp->entries[i].dev_id);
> > +                       irqp->entries[i].used = false;
> > +                       return;
> > +               }
> > +}
> > +
> >  static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue
> > *mvq)
> >  {
> >         u16 idx = mvq->index;
> > @@ -1223,27 +1288,31 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct
> > mlx5_vdpa_virtqueue *mvq)
> >  
> >         err = counter_set_alloc(ndev, mvq);
> >         if (err)
> > -               goto err_counter;
> > +               goto err_connect;
> >  
> > +       alloc_vector(ndev, mvq);
> >         err = create_virtqueue(ndev, mvq);
> >         if (err)
> > -               goto err_connect;
> > +               goto err_vq;
> >  
> >         if (mvq->ready) {
> >                 err = modify_virtqueue(ndev, mvq,
> > MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >                 if (err) {
> >                         mlx5_vdpa_warn(&ndev->mvdev, "failed to modify to
> > ready vq idx %d(%d)\n",
> >                                        idx, err);
> > -                       goto err_connect;
> > +                       goto err_modify;
> >                 }
> >         }
> >  
> >         mvq->initialized = true;
> >         return 0;
> >  
> > -err_connect:
> > +err_modify:
> > +       destroy_virtqueue(ndev, mvq);
> > +err_vq:
> > +       dealloc_vector(ndev, mvq);
> >         counter_set_dealloc(ndev, mvq);
> > -err_counter:
> > +err_connect:
> >         qp_destroy(ndev, &mvq->vqqp);
> >  err_vqqp:
> >         qp_destroy(ndev, &mvq->fwqp);
> > @@ -1288,6 +1357,7 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev,
> > struct mlx5_vdpa_virtqueue *
> >  
> >         suspend_vq(ndev, mvq);
> >         destroy_virtqueue(ndev, mvq);
> > +       dealloc_vector(ndev, mvq);
> >         counter_set_dealloc(ndev, mvq);
> >         qp_destroy(ndev, &mvq->vqqp);
> >         qp_destroy(ndev, &mvq->fwqp);
> > @@ -2505,6 +2575,7 @@ static int save_channel_info(struct mlx5_vdpa_net *ndev,
> > struct mlx5_vdpa_virtqu
> >         ri->desc_addr = mvq->desc_addr;
> >         ri->device_addr = mvq->device_addr;
> >         ri->driver_addr = mvq->driver_addr;
> > +       ri->map = mvq->map;
> >         ri->restore = true;
> >         return 0;
> >  }
> > @@ -2549,6 +2620,7 @@ static void restore_channels_info(struct mlx5_vdpa_net
> > *ndev)
> >                 mvq->desc_addr = ri->desc_addr;
> >                 mvq->device_addr = ri->device_addr;
> >                 mvq->driver_addr = ri->driver_addr;
> > +               mvq->map = ri->map;
> >         }
> >  }
> >  
> > @@ -2833,6 +2905,25 @@ static struct device *mlx5_get_vq_dma_dev(struct
> > vdpa_device *vdev, u16 idx)
> >         return mvdev->vdev.dma_dev;
> >  }
> >  
> > +static void free_irqs(struct mlx5_vdpa_net *ndev)
> > +{
> > +       struct mlx5_vdpa_irq_pool_entry *ent;
> > +       int i;
> > +
> > +       if (!msix_mode_supported(&ndev->mvdev))
> > +               return;
> > +
> > +       if (!ndev->irqp.entries)
> > +               return;
> > +
> > +       for (i = ndev->irqp.num_ent - 1; i >= 0; i--) {
> > +               ent = ndev->irqp.entries + i;
> > +               if (ent->map.virq)
> > +                       pci_msix_free_irq(ndev->mvdev.mdev->pdev, ent->map);
> > +       }
> > +       kfree(ndev->irqp.entries);
> > +}
> > +
> >  static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >  {
> >         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > @@ -2848,6 +2939,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >                 mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> >         }
> >         mlx5_vdpa_free_resources(&ndev->mvdev);
> > +       free_irqs(ndev);
> >         kfree(ndev->event_cbs);
> >         kfree(ndev->vqs);
> >  }
> > @@ -2876,9 +2968,23 @@ static struct vdpa_notification_area
> > mlx5_get_vq_notification(struct vdpa_device
> >         return ret;
> >  }
> >  
> > -static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
> > +static int mlx5_get_vq_irq(struct vdpa_device *vdev, u16 idx)
> >  {
> > -       return -EOPNOTSUPP;
> > +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > +       struct mlx5_vdpa_virtqueue *mvq;
> > +
> > +       if (!is_index_valid(mvdev, idx))
> > +               return -EINVAL;
> > +
> > +       if (is_ctrl_vq_idx(mvdev, idx))
> > +               return -EOPNOTSUPP;
> > +
> > +       mvq = &ndev->vqs[idx];
> > +       if (!mvq->map.virq)
> > +               return -EOPNOTSUPP;
> > +
> > +       return mvq->map.virq;
> >  }
> >  
> >  static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> > @@ -3155,6 +3261,34 @@ static int config_func_mtu(struct mlx5_core_dev *mdev,
> > u16 mtu)
> >         return err;
> >  }
> >  
> > +static void allocate_irqs(struct mlx5_vdpa_net *ndev)
> > +{
> > +       struct mlx5_vdpa_irq_pool_entry *ent;
> > +       int i;
> > +
> > +       if (!msix_mode_supported(&ndev->mvdev))
> > +               return;
> > +
> > +       if (!ndev->mvdev.mdev->pdev)
> > +               return;
> > +
> > +       ndev->irqp.entries = kcalloc(ndev->mvdev.max_vqs, sizeof(*ndev-
> > >irqp.entries), GFP_KERNEL);
> > +       if (!ndev->irqp.entries)
> > +               return;
> > +
> > +
> > +       for (i = 0; i < ndev->mvdev.max_vqs; i++) {
> > +               ent = ndev->irqp.entries + i;
> > +               snprintf(ent->name, MLX5_VDPA_IRQ_NAME_LEN, "%s-vq-%d",
> > +                        dev_name(&ndev->mvdev.vdev.dev), i);
> > +               ent->map = pci_msix_alloc_irq_at(ndev->mvdev.mdev->pdev,
> > MSI_ANY_INDEX, NULL);
> > +               if (!ent->map.virq)
> > +                       return;
> > +
> > +               ndev->irqp.num_ent++;
> > +       }
> > +}
> > +
> >  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >                              const struct vdpa_dev_set_config *add_config)
> >  {
> > @@ -3233,6 +3367,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev
> > *v_mdev, const char *name,
> >         }
> >  
> >         init_mvqs(ndev);
> > +       allocate_irqs(ndev);
> >         init_rwsem(&ndev->reslock);
> >         config = &ndev->config;
> >  
> > @@ -3413,6 +3548,17 @@ static void mlx5v_remove(struct auxiliary_device *adev)
> >         kfree(mgtdev);
> >  }
> >  
> > +static void mlx5v_shutdown(struct auxiliary_device *auxdev)
> > +{
> > +       struct mlx5_vdpa_mgmtdev *mgtdev;
> > +       struct mlx5_vdpa_net *ndev;
> > +
> > +       mgtdev = auxiliary_get_drvdata(auxdev);
> > +       ndev = mgtdev->ndev;
> > +
> > +       free_irqs(ndev);
> > +}
> > +
> >  static const struct auxiliary_device_id mlx5v_id_table[] = {
> >         { .name = MLX5_ADEV_NAME ".vnet", },
> >         {},
> > @@ -3424,6 +3570,7 @@ static struct auxiliary_driver mlx5v_driver = {
> >         .name = "vnet",
> >         .probe = mlx5v_probe,
> >         .remove = mlx5v_remove,
> > +       .shutdown = mlx5v_shutdown,
> >         .id_table = mlx5v_id_table,
> >  };
> >  
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > index c90a89e1de4d..36c44d9fdd16 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > @@ -26,6 +26,20 @@ static inline u16 key2vid(u64 key)
> >         return (u16)(key >> 48) & 0xfff;
> >  }
> >  
> > +#define MLX5_VDPA_IRQ_NAME_LEN 32
> > +
> > +struct mlx5_vdpa_irq_pool_entry {
> > +       struct msi_map map;
> > +       bool used;
> > +       char name[MLX5_VDPA_IRQ_NAME_LEN];
> > +       void *dev_id;
> > +};
> > +
> > +struct mlx5_vdpa_irq_pool {
> > +       int num_ent;
> > +       struct mlx5_vdpa_irq_pool_entry *entries;
> > +};
> > +
> >  struct mlx5_vdpa_net {
> >         struct mlx5_vdpa_dev mvdev;
> >         struct mlx5_vdpa_net_resources res;
> > @@ -49,6 +63,7 @@ struct mlx5_vdpa_net {
> >         struct vdpa_callback config_cb;
> >         struct mlx5_vdpa_wq_ent cvq_ent;
> >         struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> > +       struct mlx5_vdpa_irq_pool irqp;
> >         struct dentry *debugfs;
> >  };
> >  
> 
> 

