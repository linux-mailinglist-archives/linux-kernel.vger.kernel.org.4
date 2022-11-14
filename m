Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B91627562
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235846AbiKNEmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiKNEmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA178167F4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668400886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKjDmIAt0prUKa9dsHOjZqBINBMFFGgMprh04cvIpSE=;
        b=EaGMNGM1/T8PpWYrQ93w2VPEKlUOY9N1jWVB1P3dfq5sa67IKQNP26ZqMkCrUbbQxxqOn5
        fXG7nh608dFcu1RVnIoz0fzjbHApIcm7ubt3qfwRZxyqSJNG2jH6zPCyECm1HLwAKWQrbJ
        HV3I9jqt5aRGqVSi5A0yBzKsFRyDw5g=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-528-2KzUbnmzPfeAQmHwA5tjMQ-1; Sun, 13 Nov 2022 23:41:22 -0500
X-MC-Unique: 2KzUbnmzPfeAQmHwA5tjMQ-1
Received: by mail-oo1-f69.google.com with SMTP id t9-20020a4a6049000000b00496bbda4343so3376960oof.22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKjDmIAt0prUKa9dsHOjZqBINBMFFGgMprh04cvIpSE=;
        b=jEiCocLsumwYZl514GIyESMdxZrsLA9+eM33vBM4kw7xHvL5I3jP+K9pppByBRFosF
         HQ28u0/4tIlo5WwYV5K5ntPEervGj3Lx2+2RjQme9sLcO+IxDuKF9dVmSCT22WuSmuRC
         eHwoQXVCOr012YFBu++iAdtZrarZl2ofEzFPSBmXOvzEl+UckzFQtlzykUFkk7YKDKiV
         xwqYoDDtjBAk7T/ZXGQ53hZ7UXSeuTKTHCYoAh72g99h+0D8PovSVVBn0+1uOtsCafD2
         +r/N/APQj1++6TpQRcNTM35MK6GE1ZAc1vPGEGr+NWzYcEnGqWireB3zSnZUlMZy8fmX
         PGmQ==
X-Gm-Message-State: ANoB5pmJC5CMkupFGsgqXTGhSABJPWJPWow7NdAvTaZIUhXeL97zRmfy
        eP+C5tIaDOxWNp9S4Qyi6GdrdvVLkG+VBfweDmDu9xAxuNTRoXqfpe6TOHj/cD1fPWCF0KWszqF
        Ev2NAg4mouatQOmD3kXRuUC/GVu1PmBnEDRJq1TWU
X-Received: by 2002:a4a:5704:0:b0:49f:449a:5f6c with SMTP id u4-20020a4a5704000000b0049f449a5f6cmr4541461ooa.93.1668400881569;
        Sun, 13 Nov 2022 20:41:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4157B6oXCXw3RByikzI77lJ0hjf54Is1etpUu0/uYC5dlkUqPYlH8kcl1nJLGCLNnaGKUBBQSU5CZcdPgp04k=
X-Received: by 2002:a4a:5704:0:b0:49f:449a:5f6c with SMTP id
 u4-20020a4a5704000000b0049f449a5f6cmr4541452ooa.93.1668400881317; Sun, 13 Nov
 2022 20:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-4-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-4-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 12:41:10 +0800
Message-ID: <CACGkMEupWx6YZToNqxyJ9sD5v41ouOeKe2=0_ASbWPFt8s1uGA@mail.gmail.com>
Subject: Re: [PATCH 3/7] vdpa/mlx5: Move some definitions to a new header file
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, si-wei.liu@oracle.com,
        eperezma@redhat.com, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 9:45 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Move some definitions from mlx5_vnet.c to newly added header file
> mlx5_vnet.h. We need these definitions for the following patches that
> add debugfs tree to expose information vital for debug.
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 45 +------------------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h | 55 +++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index c54d5088ed4f..e45b83527b41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -18,15 +18,12 @@
>  #include <linux/mlx5/mlx5_ifc_vdpa.h>
>  #include <linux/mlx5/mpfs.h>
>  #include "mlx5_vdpa.h"
> +#include "mlx5_vnet.h"
>
>  MODULE_AUTHOR("Eli Cohen <eli@mellanox.com>");
>  MODULE_DESCRIPTION("Mellanox VDPA driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>
> -#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> -       container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> -#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> -
>  #define VALID_FEATURES_MASK                                                                        \
>         (BIT_ULL(VIRTIO_NET_F_CSUM) | BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |                                   \
>          BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) | BIT_ULL(VIRTIO_NET_F_MTU) | BIT_ULL(VIRTIO_NET_F_MAC) |   \
> @@ -50,14 +47,6 @@ MODULE_LICENSE("Dual BSD/GPL");
>
>  #define MLX5V_UNTAGGED 0x1000
>
> -struct mlx5_vdpa_net_resources {
> -       u32 tisn;
> -       u32 tdn;
> -       u32 tirn;
> -       u32 rqtn;
> -       bool valid;
> -};
> -
>  struct mlx5_vdpa_cq_buf {
>         struct mlx5_frag_buf_ctrl fbc;
>         struct mlx5_frag_buf frag_buf;
> @@ -146,38 +135,6 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>         return idx <= mvdev->max_idx;
>  }
>
> -#define MLX5V_MACVLAN_SIZE 256
> -
> -struct mlx5_vdpa_net {
> -       struct mlx5_vdpa_dev mvdev;
> -       struct mlx5_vdpa_net_resources res;
> -       struct virtio_net_config config;
> -       struct mlx5_vdpa_virtqueue *vqs;
> -       struct vdpa_callback *event_cbs;
> -
> -       /* Serialize vq resources creation and destruction. This is required
> -        * since memory map might change and we need to destroy and create
> -        * resources while driver in operational.
> -        */
> -       struct rw_semaphore reslock;
> -       struct mlx5_flow_table *rxft;
> -       bool setup;
> -       u32 cur_num_vqs;
> -       u32 rqt_size;
> -       bool nb_registered;
> -       struct notifier_block nb;
> -       struct vdpa_callback config_cb;
> -       struct mlx5_vdpa_wq_ent cvq_ent;
> -       struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> -};
> -
> -struct macvlan_node {
> -       struct hlist_node hlist;
> -       struct mlx5_flow_handle *ucast_rule;
> -       struct mlx5_flow_handle *mcast_rule;
> -       u64 macvlan;
> -};
> -
>  static void free_resources(struct mlx5_vdpa_net *ndev);
>  static void init_mvqs(struct mlx5_vdpa_net *ndev);
>  static int setup_driver(struct mlx5_vdpa_dev *mvdev);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> new file mode 100644
> index 000000000000..6691c879a6ca
> --- /dev/null
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
> +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#ifndef __MLX5_VNET_H__
> +#define __MLX5_VNET_H__
> +
> +#include "mlx5_vdpa.h"
> +
> +#define to_mlx5_vdpa_ndev(__mvdev)                                             \
> +       container_of(__mvdev, struct mlx5_vdpa_net, mvdev)
> +#define to_mvdev(__vdev) container_of((__vdev), struct mlx5_vdpa_dev, vdev)
> +
> +struct mlx5_vdpa_net_resources {
> +       u32 tisn;
> +       u32 tdn;
> +       u32 tirn;
> +       u32 rqtn;
> +       bool valid;
> +};
> +
> +#define MLX5V_MACVLAN_SIZE 256
> +
> +struct mlx5_vdpa_net {
> +       struct mlx5_vdpa_dev mvdev;
> +       struct mlx5_vdpa_net_resources res;
> +       struct virtio_net_config config;
> +       struct mlx5_vdpa_virtqueue *vqs;
> +       struct vdpa_callback *event_cbs;
> +
> +       /* Serialize vq resources creation and destruction. This is required
> +        * since memory map might change and we need to destroy and create
> +        * resources while driver in operational.
> +        */
> +       struct rw_semaphore reslock;
> +       struct mlx5_flow_table *rxft;
> +       struct dentry *rx_dent;
> +       struct dentry *rx_table_dent;
> +       bool setup;
> +       u32 cur_num_vqs;
> +       u32 rqt_size;
> +       bool nb_registered;
> +       struct notifier_block nb;
> +       struct vdpa_callback config_cb;
> +       struct mlx5_vdpa_wq_ent cvq_ent;
> +       struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +};
> +
> +struct macvlan_node {
> +       struct hlist_node hlist;
> +       struct mlx5_flow_handle *ucast_rule;
> +       struct mlx5_flow_handle *mcast_rule;
> +       u64 macvlan;
> +};
> +
> +#endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

