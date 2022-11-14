Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AED627566
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 05:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiKNEnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 23:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbiKNEnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 23:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22C517043
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668400947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z5uwOVwFgI5IfGkeQ8z5UfE4vHlHFDxyEJXxCbesoTE=;
        b=UE0eIgoHfYJ6URTG3hSHemFNWyxcmUA2Yuc09kX0HmLdzmDnxLjDvTjSEaLz5k34XxkTEz
        UtTlFzarhia/wLWazTHiR0AyZ4EReFBsvmsTLinywMgKBd95Q1jxCkgeolKThddgpvXiGW
        PTJ7Nvt6lBO58UqOATTesRVRz0RN8nU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-rjKhQVCRNSm_1d9QkNPRjA-1; Sun, 13 Nov 2022 23:42:26 -0500
X-MC-Unique: rjKhQVCRNSm_1d9QkNPRjA-1
Received: by mail-ot1-f70.google.com with SMTP id ck9-20020a056830648900b0066c56ff7b33so5761908otb.20
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 20:42:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z5uwOVwFgI5IfGkeQ8z5UfE4vHlHFDxyEJXxCbesoTE=;
        b=HWj8vbOA20hWCFGwtnvt+H4GNGb76bK3DGODelGiqE6VZeky71tmc9M30hZgWWWrNn
         5ZJAJ2IQZD6KcfmkiGXwXtSQkQHtJCq8+V0KWbMlyW2aOnRzF5M1Q8kPw/oH9raPgsGt
         68LhMY61Hnobz51sGG6zq637jtc9bitogTeAKfefAr0KiyvlKHY2ulgFOzKQZ8EH5CDS
         ygp4C+EqhbcFBzJOUsaeEyDF8WGrpKjY5nLFjZ+d4fouxCIPJvwzgUkxrZfJnDvd9q7u
         I70RlK9sde/lYNwhxzHL8yN1tigK/Yhbd3Zfa2i+POabmua7WfKFOulGcP3nImDHybUu
         CinA==
X-Gm-Message-State: ANoB5pllUhzQkMIpPwOGd5W5T8koOpR2mEc1lbkDslO5C3gOArRZs9rK
        plYJ0QAec2kzbpLM1D/f3tdH01/wBdcvzdjvNzQEueYuUkGKmbZxn7dZebbbW5yJvs2F+n0SOoE
        AsnzFYtpeXYs/3PZgn5Y4pHHQYcXhvvK9BWbGUctf
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id s13-20020a056830124d00b0066c64d61bb4mr5719964otp.201.1668400940797;
        Sun, 13 Nov 2022 20:42:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6JtpSaHDpx92dpZPqyGUu0IEsp01m8fgC0wohlG48WvH6rUideVtK9G8V7RxyU6XXbp0f0HNIRD6AefHyMPgo=
X-Received: by 2002:a05:6830:124d:b0:66c:64d6:1bb4 with SMTP id
 s13-20020a056830124d00b0066c64d61bb4mr5719953otp.201.1668400940555; Sun, 13
 Nov 2022 20:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-5-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-5-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 12:42:09 +0800
Message-ID: <CACGkMEvV9FOHU6R8hjqeOH2wEaVBSbvojmRa77jbKfEkH+rKaw@mail.gmail.com>
Subject: Re: [PATCH 4/7] vdpa/mlx5: Add debugfs subtree
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
> Add debugfs subtree and expose flow table ID and TIR number. This
> information can be used by external tools to do extended
> troubleshooting.
>
> The information can be retrieved like so:
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/table_id
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/tirn
>
> Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/Makefile        |  2 +-
>  drivers/vdpa/mlx5/net/debug.c     | 66 +++++++++++++++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vdpa/mlx5/net/debug.c
>
> diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
> index f717978c83bf..e791394c33e3 100644
> --- a/drivers/vdpa/mlx5/Makefile
> +++ b/drivers/vdpa/mlx5/Makefile
> @@ -1,4 +1,4 @@
>  subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
>
>  obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
> -mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o
> +mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) += net/mlx5_vnet.o core/resources.o core/mr.o net/debug.o
> diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/debug.c
> new file mode 100644
> index 000000000000..95e4801df211
> --- /dev/null
> +++ b/drivers/vdpa/mlx5/net/debug.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
> +
> +#include <linux/debugfs.h>
> +#include <linux/mlx5/fs.h>
> +#include "mlx5_vnet.h"
> +
> +static int tirn_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_net *ndev = file->private;
> +
> +       seq_printf(file, "0x%x\n", ndev->res.tirn);
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tirn);
> +
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +       if (ndev->debugfs)
> +               debugfs_remove(ndev->res.tirn_dent);
> +}
> +
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +       ndev->res.tirn_dent = debugfs_create_file("tirn", 0444, ndev->rx_dent,
> +                                                 ndev, &tirn_fops);
> +}
> +
> +static int rx_flow_table_show(struct seq_file *file, void *priv)
> +{
> +       struct mlx5_vdpa_net *ndev = file->private;
> +
> +       seq_printf(file, "0x%x\n", mlx5_flow_table_id(ndev->rxft));
> +       return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(rx_flow_table);
> +
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +       if (ndev->debugfs)
> +               debugfs_remove(ndev->rx_table_dent);
> +}
> +
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +       ndev->rx_table_dent = debugfs_create_file("table_id", 0444, ndev->rx_dent,
> +                                                 ndev, &rx_flow_table_fops);
> +}
> +
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
> +{
> +       struct mlx5_core_dev *mdev;
> +
> +       mdev = ndev->mvdev.mdev;
> +       ndev->debugfs = debugfs_create_dir(dev_name(&ndev->mvdev.vdev.dev),
> +                                          mlx5_debugfs_get_dev_root(mdev));
> +       if (!IS_ERR(ndev->debugfs))
> +               ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
> +}
> +
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
> +{
> +       debugfs_remove_recursive(dbg);
> +}
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e45b83527b41..ce2f478a93f5 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1388,11 +1388,16 @@ static int create_tir(struct mlx5_vdpa_net *ndev)
>
>         err = mlx5_vdpa_create_tir(&ndev->mvdev, in, &ndev->res.tirn);
>         kfree(in);
> +       if (err)
> +               return err;
> +
> +       mlx5_vdpa_add_tirn(ndev);
>         return err;
>  }
>
>  static void destroy_tir(struct mlx5_vdpa_net *ndev)
>  {
> +       mlx5_vdpa_remove_tirn(ndev);
>         mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
>  }
>
> @@ -1578,6 +1583,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>                 mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
>                 return PTR_ERR(ndev->rxft);
>         }
> +       mlx5_vdpa_add_rx_flow_table(ndev);
>
>         err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
>         if (err)
> @@ -1586,6 +1592,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>         return 0;
>
>  err_add:
> +       mlx5_vdpa_remove_rx_flow_table(ndev);
>         mlx5_destroy_flow_table(ndev->rxft);
>         return err;
>  }
> @@ -1593,6 +1600,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>  static void teardown_steering(struct mlx5_vdpa_net *ndev)
>  {
>         clear_mac_vlan_table(ndev);
> +       mlx5_vdpa_remove_rx_flow_table(ndev);
>         mlx5_destroy_flow_table(ndev->rxft);
>  }
>
> @@ -3172,6 +3180,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         if (err)
>                 goto err_reg;
>
> +       mlx5_vdpa_add_debugfs(ndev);
>         mgtdev->ndev = ndev;
>         return 0;
>
> @@ -3198,6 +3207,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>         struct workqueue_struct *wq;
>
> +       mlx5_vdpa_remove_debugfs(ndev->debugfs);
> +       ndev->debugfs = NULL;
>         if (ndev->nb_registered) {
>                 mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>                 ndev->nb_registered = false;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index 6691c879a6ca..f2cef3925e5b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -16,6 +16,7 @@ struct mlx5_vdpa_net_resources {
>         u32 tirn;
>         u32 rqtn;
>         bool valid;
> +       struct dentry *tirn_dent;
>  };
>
>  #define MLX5V_MACVLAN_SIZE 256
> @@ -43,6 +44,7 @@ struct mlx5_vdpa_net {
>         struct vdpa_callback config_cb;
>         struct mlx5_vdpa_wq_ent cvq_ent;
>         struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +       struct dentry *debugfs;
>  };
>
>  struct macvlan_node {
> @@ -52,4 +54,11 @@ struct macvlan_node {
>         u64 macvlan;
>  };
>
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +
>  #endif /* __MLX5_VNET_H__ */
> --
> 2.38.1
>

