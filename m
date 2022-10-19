Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CDD603919
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJSFOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJSFOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570A95B8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666156468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elWLeuJKIZ4oJu/GVv8j/7xLvrjS+NMtbQ72eCBOoSw=;
        b=jUpscYdczdWmtKZn85NyMYHvFhhRlTZuWZYjqUcT/1HYujy93PW7phd63y7H5uLaKpxDwu
        TrpVNYU++bjFmRnw2klUBqoLcipDuBu1nWE1tcc6i5H9ecvbG8bKaZBhTveT9pFzR/1MW4
        Xs7+QAPxp42Q61/t3uPPpIKRbfTcdDg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-183-kEDLbcL7P_CoZUmB95_M3w-1; Wed, 19 Oct 2022 01:14:27 -0400
X-MC-Unique: kEDLbcL7P_CoZUmB95_M3w-1
Received: by mail-pf1-f198.google.com with SMTP id o14-20020a056a00214e00b0056238ef46ebso8842249pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elWLeuJKIZ4oJu/GVv8j/7xLvrjS+NMtbQ72eCBOoSw=;
        b=VWa9aBnIOgUy1uXBuXCP6LKCl8+uYTwDQdwrLaYvJv7tgPpdgJdPlXo5/ZjhKFmqvF
         5QhWwWA3EA+LHOa3ZeW7GMYIv3fv3uNf+I7vXCSHqunRWD0xIQA6Stx5PMpfeJ9Pmirh
         UpG1jJ7EvA8MPB2+yHBcxsj3pol2PaQuAOYts8+Pq9WVraKCB8pbHGur9LrauvCMIUUF
         8gGQJ4w5VM+dlKfOX00CLMavpooN6kcXspXr2/u4unKLCcy8yr7m8z8GyYGQ4ipyqArX
         U7h3KKAB7EkZLxfT8bVASZT/NsF7XtI+CnOMNb3Qmm5kWLo3/S2GT6u6xMaLCGu+oS4x
         ELhA==
X-Gm-Message-State: ACrzQf1kPN1D1CvXwe+xoUDhYZjrgOJ6CLdFrJgqTx6poYb8lY8vAWdy
        W1lAhk70PIS7qpi5v9VRJOpjklqtJ2jqHIMkCip4ffpyO252mez8uXz2/2hDn5t9W2K5mWJ8x4f
        Gum5JQEnhQOZGLwgXuJkGDJTC
X-Received: by 2002:a05:6a00:168e:b0:53b:3f2c:3213 with SMTP id k14-20020a056a00168e00b0053b3f2c3213mr6616144pfc.56.1666156464636;
        Tue, 18 Oct 2022 22:14:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Hvcr/I9EH7SdGoInjE6Qebm/YSK0Gmhj8yliMC/8ZMVpkTInJy4XKE5CCKWujd1Hid7apSg==
X-Received: by 2002:a17:902:ce91:b0:183:610c:1df3 with SMTP id f17-20020a170902ce9100b00183610c1df3mr6401359plg.51.1666156453588;
        Tue, 18 Oct 2022 22:14:13 -0700 (PDT)
Received: from [10.72.12.164] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n19-20020a170902d0d300b0018658badef3sm45961pln.232.2022.10.18.22.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 22:14:12 -0700 (PDT)
Message-ID: <33449319-b984-a60b-50e2-a0080a62f1c1@redhat.com>
Date:   Wed, 19 Oct 2022 13:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 3/4] vdpa/mlx5: Add debugfs subtree
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     si-wei.liu@oracle.com, eperezma@redhat.com, lulu@redhat.com
References: <20221018111232.4021-1-elic@nvidia.com>
 <20221018111232.4021-4-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221018111232.4021-4-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/18 19:12, Eli Cohen 写道:
> Add debugfs subtree and expose flow table ID and TIR number. This
> information can be used by external tools to do extended
> troubleshooting.
>
> The information can be retrieved like so:
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/table_id
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/tirn


I wonder if we need a config option for this.

And if it's better to use vendor stats.

Thanks


>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/Makefile        |  2 +-
>   drivers/vdpa/mlx5/net/debug.c     | 66 +++++++++++++++++++++++++++++++
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++
>   drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
>   4 files changed, 87 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/vdpa/mlx5/net/debug.c
>
> diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
> index f717978c83bf..e791394c33e3 100644
> --- a/drivers/vdpa/mlx5/Makefile
> +++ b/drivers/vdpa/mlx5/Makefile
> @@ -1,4 +1,4 @@
>   subdir-ccflags-y += -I$(srctree)/drivers/vdpa/mlx5/core
>   
>   obj-$(CONFIG_MLX5_VDPA_NET) += mlx5_vdpa.o
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
> +	struct mlx5_vdpa_net *ndev = file->private;
> +
> +	seq_printf(file, "0x%x\n", ndev->res.tirn);
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(tirn);
> +
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +	if (ndev->debugfs)
> +		debugfs_remove(ndev->res.tirn_dent);
> +}
> +
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev)
> +{
> +	ndev->res.tirn_dent = debugfs_create_file("tirn", 0444, ndev->rx_dent,
> +						  ndev, &tirn_fops);
> +}
> +
> +static int rx_flow_table_show(struct seq_file *file, void *priv)
> +{
> +	struct mlx5_vdpa_net *ndev = file->private;
> +
> +	seq_printf(file, "0x%x\n", mlx5_flow_table_id(ndev->rxft));
> +	return 0;
> +}
> +
> +DEFINE_SHOW_ATTRIBUTE(rx_flow_table);
> +
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +	if (ndev->debugfs)
> +		debugfs_remove(ndev->rx_table_dent);
> +}
> +
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
> +{
> +	ndev->rx_table_dent = debugfs_create_file("table_id", 0444, ndev->rx_dent,
> +						  ndev, &rx_flow_table_fops);
> +}
> +
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_core_dev *mdev;
> +
> +	mdev = ndev->mvdev.mdev;
> +	ndev->debugfs = debugfs_create_dir(dev_name(&ndev->mvdev.vdev.dev),
> +					   mlx5_debugfs_get_dev_root(mdev));
> +	if (!IS_ERR(ndev->debugfs))
> +		ndev->rx_dent = debugfs_create_dir("rx", ndev->debugfs);
> +}
> +
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
> +{
> +	debugfs_remove_recursive(dbg);
> +}
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 64fdb940380f..ee50da33e25b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1388,11 +1388,16 @@ static int create_tir(struct mlx5_vdpa_net *ndev)
>   
>   	err = mlx5_vdpa_create_tir(&ndev->mvdev, in, &ndev->res.tirn);
>   	kfree(in);
> +	if (err)
> +		return err;
> +
> +	mlx5_vdpa_add_tirn(ndev);
>   	return err;
>   }
>   
>   static void destroy_tir(struct mlx5_vdpa_net *ndev)
>   {
> +	mlx5_vdpa_remove_tirn(ndev);
>   	mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
>   }
>   
> @@ -1576,6 +1581,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>   		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
>   		return PTR_ERR(ndev->rxft);
>   	}
> +	mlx5_vdpa_add_rx_flow_table(ndev);
>   
>   	err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
>   	if (err)
> @@ -1584,6 +1590,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>   	return 0;
>   
>   err_add:
> +	mlx5_vdpa_remove_rx_flow_table(ndev);
>   	mlx5_destroy_flow_table(ndev->rxft);
>   	return err;
>   }
> @@ -1591,6 +1598,7 @@ static int setup_steering(struct mlx5_vdpa_net *ndev)
>   static void teardown_steering(struct mlx5_vdpa_net *ndev)
>   {
>   	clear_mac_vlan_table(ndev);
> +	mlx5_vdpa_remove_rx_flow_table(ndev);
>   	mlx5_destroy_flow_table(ndev->rxft);
>   }
>   
> @@ -3167,6 +3175,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	if (err)
>   		goto err_reg;
>   
> +	mlx5_vdpa_add_debugfs(ndev);
>   	mgtdev->ndev = ndev;
>   	return 0;
>   
> @@ -3193,6 +3202,8 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>   	struct workqueue_struct *wq;
>   
> +	mlx5_vdpa_remove_debugfs(ndev->debugfs);
> +	ndev->debugfs = NULL;
>   	if (ndev->nb_registered) {
>   		mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>   		ndev->nb_registered = false;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> index 6691c879a6ca..f2cef3925e5b 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> @@ -16,6 +16,7 @@ struct mlx5_vdpa_net_resources {
>   	u32 tirn;
>   	u32 rqtn;
>   	bool valid;
> +	struct dentry *tirn_dent;
>   };
>   
>   #define MLX5V_MACVLAN_SIZE 256
> @@ -43,6 +44,7 @@ struct mlx5_vdpa_net {
>   	struct vdpa_callback config_cb;
>   	struct mlx5_vdpa_wq_ent cvq_ent;
>   	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +	struct dentry *debugfs;
>   };
>   
>   struct macvlan_node {
> @@ -52,4 +54,11 @@ struct macvlan_node {
>   	u64 macvlan;
>   };
>   
> +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
> +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
> +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> +
>   #endif /* __MLX5_VNET_H__ */

