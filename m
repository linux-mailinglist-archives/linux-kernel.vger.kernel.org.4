Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E66603990
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJSGHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiJSGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674DD65665
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666159648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVZNiu4shQTMUEEqH/TQbQS4Xk5/BKmp3rV2S+zvNBQ=;
        b=Uir4dPHQdkea8PMIInMniR31gCUwmUpXNQC41rNVInDvizVSGYBPA06X5fJWhT4ubwaDGY
        kDyxcqVcJGNlXbxLhhWFKtfTpqc6u298d8QUipI3kDBuEJtARXjOE3fFLEMF4lZgWBQx1S
        VC07Eqgd8sGac2lY6qFABVwg8DDlux0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-45-Yw8_htZeMx-6gYHggqFoUQ-1; Wed, 19 Oct 2022 02:07:27 -0400
X-MC-Unique: Yw8_htZeMx-6gYHggqFoUQ-1
Received: by mail-ot1-f71.google.com with SMTP id 3-20020a9d0b83000000b00660d7acf0dfso7451545oth.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVZNiu4shQTMUEEqH/TQbQS4Xk5/BKmp3rV2S+zvNBQ=;
        b=p5V3yWYglionlS1HmrC7BXjGCcCWrsSX62TcvQzFlYxrCHacHfnum4hVgoPHu3QMol
         fizPpiqbMMkBEWXqeaG1DhpAZlN7S9iH4O04q3wllmPYeBbk1726ePhM5ukG8V2kIlbR
         cZtzcAiHZMa3Qz40nq6sOkXTkBaX+9ZODIdQJjjHezt7VE3OYAkB7733SIbCZWHvHFuO
         IUslZQxcjjyT1KbfFeZEIhmzLtjWJVmJPI+8Ta2dTFSEI1DZAyRNL/PqZhGzLaw9Qr1c
         Q/aWBqFmYunCKX4+nFZMSCIRO2o60aeiIrcNsJarBA49CeXp4wmOjQ6Q+9+mnIIxU0HB
         sHhQ==
X-Gm-Message-State: ACrzQf2n+X/Kgily9fzpKX+smLDCGJFGJ7MSnpvj6hCcVbOmPN/kfTxc
        lTN1ztPKPZR5Q5tLNiYN04eNPScIfwaLs41Hd8ff1xfZZGjU5BVQBXdTEhQxB/X9geQ8H2DTFXr
        mvOrTAAs97emRuDeUwGS6LdgaOe0jpSDRIybKsZt+
X-Received: by 2002:a05:6808:1985:b0:354:d7cf:9acb with SMTP id bj5-20020a056808198500b00354d7cf9acbmr3375026oib.280.1666159646538;
        Tue, 18 Oct 2022 23:07:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4kOgPud9ECmwamWiuKwdDH7fyuprwPQ0lI9PYy0morhmwZQN0evBk3BKV69WMoRYJ3Z+0EJ9Mz69aDGPb1jvY=
X-Received: by 2002:a05:6808:1985:b0:354:d7cf:9acb with SMTP id
 bj5-20020a056808198500b00354d7cf9acbmr3375015oib.280.1666159646340; Tue, 18
 Oct 2022 23:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221018111232.4021-1-elic@nvidia.com> <20221018111232.4021-4-elic@nvidia.com>
 <33449319-b984-a60b-50e2-a0080a62f1c1@redhat.com> <DM8PR12MB5400EB772271179974BBB6C5AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400EB772271179974BBB6C5AB2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 19 Oct 2022 14:07:14 +0800
Message-ID: <CACGkMEv+UQVv4B1-n_4tXYTemOQOrpa+zg9-xe-i6nfrVWycog@mail.gmail.com>
Subject: Re: [PATCH 3/4] vdpa/mlx5: Add debugfs subtree
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 1:38 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 19 October 2022 8:14
> > To: Eli Cohen <elic@nvidia.com>; mst@redhat.com; linux-
> > kernel@vger.kernel.org; virtualization@lists.linux-foundation.org
> > Cc: si-wei.liu@oracle.com; eperezma@redhat.com; lulu@redhat.com
> > Subject: Re: [PATCH 3/4] vdpa/mlx5: Add debugfs subtree
> >
> >
> > =E5=9C=A8 2022/10/18 19:12, Eli Cohen =E5=86=99=E9=81=93:
> > > Add debugfs subtree and expose flow table ID and TIR number. This
> > > information can be used by external tools to do extended
> > > troubleshooting.
> > >
> > > The information can be retrieved like so:
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/table_id
> > > $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/tirn
> >
> >
> > I wonder if we need a config option for this.
> >
> > And if it's better to use vendor stats.
> >
>
> I am not sure. TIRs and flow tables has loose association VDPA. I would k=
eep it in
> debugfs which for mlx5 there's lots of other information there.

That's fine.

Thanks

>
> > Thanks
> >
> >
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/mlx5/Makefile        |  2 +-
> > >   drivers/vdpa/mlx5/net/debug.c     | 66
> > +++++++++++++++++++++++++++++++
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 ++++++
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.h |  9 +++++
> > >   4 files changed, 87 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/vdpa/mlx5/net/debug.c
> > >
> > > diff --git a/drivers/vdpa/mlx5/Makefile b/drivers/vdpa/mlx5/Makefile
> > > index f717978c83bf..e791394c33e3 100644
> > > --- a/drivers/vdpa/mlx5/Makefile
> > > +++ b/drivers/vdpa/mlx5/Makefile
> > > @@ -1,4 +1,4 @@
> > >   subdir-ccflags-y +=3D -I$(srctree)/drivers/vdpa/mlx5/core
> > >
> > >   obj-$(CONFIG_MLX5_VDPA_NET) +=3D mlx5_vdpa.o
> > > -mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) +=3D net/mlx5_vnet.o
> > core/resources.o core/mr.o
> > > +mlx5_vdpa-$(CONFIG_MLX5_VDPA_NET) +=3D net/mlx5_vnet.o
> > core/resources.o core/mr.o net/debug.o
> > > diff --git a/drivers/vdpa/mlx5/net/debug.c b/drivers/vdpa/mlx5/net/de=
bug.c
> > > new file mode 100644
> > > index 000000000000..95e4801df211
> > > --- /dev/null
> > > +++ b/drivers/vdpa/mlx5/net/debug.c
> > > @@ -0,0 +1,66 @@
> > > +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> > > +/* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
> > reserved. */
> > > +
> > > +#include <linux/debugfs.h>
> > > +#include <linux/mlx5/fs.h>
> > > +#include "mlx5_vnet.h"
> > > +
> > > +static int tirn_show(struct seq_file *file, void *priv)
> > > +{
> > > +   struct mlx5_vdpa_net *ndev =3D file->private;
> > > +
> > > +   seq_printf(file, "0x%x\n", ndev->res.tirn);
> > > +   return 0;
> > > +}
> > > +
> > > +DEFINE_SHOW_ATTRIBUTE(tirn);
> > > +
> > > +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev)
> > > +{
> > > +   if (ndev->debugfs)
> > > +           debugfs_remove(ndev->res.tirn_dent);
> > > +}
> > > +
> > > +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev)
> > > +{
> > > +   ndev->res.tirn_dent =3D debugfs_create_file("tirn", 0444, ndev-
> > >rx_dent,
> > > +                                             ndev, &tirn_fops);
> > > +}
> > > +
> > > +static int rx_flow_table_show(struct seq_file *file, void *priv)
> > > +{
> > > +   struct mlx5_vdpa_net *ndev =3D file->private;
> > > +
> > > +   seq_printf(file, "0x%x\n", mlx5_flow_table_id(ndev->rxft));
> > > +   return 0;
> > > +}
> > > +
> > > +DEFINE_SHOW_ATTRIBUTE(rx_flow_table);
> > > +
> > > +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev)
> > > +{
> > > +   if (ndev->debugfs)
> > > +           debugfs_remove(ndev->rx_table_dent);
> > > +}
> > > +
> > > +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev)
> > > +{
> > > +   ndev->rx_table_dent =3D debugfs_create_file("table_id", 0444, nde=
v-
> > >rx_dent,
> > > +                                             ndev, &rx_flow_table_fo=
ps);
> > > +}
> > > +
> > > +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev)
> > > +{
> > > +   struct mlx5_core_dev *mdev;
> > > +
> > > +   mdev =3D ndev->mvdev.mdev;
> > > +   ndev->debugfs =3D debugfs_create_dir(dev_name(&ndev-
> > >mvdev.vdev.dev),
> > > +
> > mlx5_debugfs_get_dev_root(mdev));
> > > +   if (!IS_ERR(ndev->debugfs))
> > > +           ndev->rx_dent =3D debugfs_create_dir("rx", ndev->debugfs)=
;
> > > +}
> > > +
> > > +void mlx5_vdpa_remove_debugfs(struct dentry *dbg)
> > > +{
> > > +   debugfs_remove_recursive(dbg);
> > > +}
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 64fdb940380f..ee50da33e25b 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1388,11 +1388,16 @@ static int create_tir(struct mlx5_vdpa_net
> > *ndev)
> > >
> > >     err =3D mlx5_vdpa_create_tir(&ndev->mvdev, in, &ndev->res.tirn);
> > >     kfree(in);
> > > +   if (err)
> > > +           return err;
> > > +
> > > +   mlx5_vdpa_add_tirn(ndev);
> > >     return err;
> > >   }
> > >
> > >   static void destroy_tir(struct mlx5_vdpa_net *ndev)
> > >   {
> > > +   mlx5_vdpa_remove_tirn(ndev);
> > >     mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
> > >   }
> > >
> > > @@ -1576,6 +1581,7 @@ static int setup_steering(struct mlx5_vdpa_net
> > *ndev)
> > >             mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow
> > table\n");
> > >             return PTR_ERR(ndev->rxft);
> > >     }
> > > +   mlx5_vdpa_add_rx_flow_table(ndev);
> > >
> > >     err =3D mac_vlan_add(ndev, ndev->config.mac, 0, false);
> > >     if (err)
> > > @@ -1584,6 +1590,7 @@ static int setup_steering(struct mlx5_vdpa_net
> > *ndev)
> > >     return 0;
> > >
> > >   err_add:
> > > +   mlx5_vdpa_remove_rx_flow_table(ndev);
> > >     mlx5_destroy_flow_table(ndev->rxft);
> > >     return err;
> > >   }
> > > @@ -1591,6 +1598,7 @@ static int setup_steering(struct mlx5_vdpa_net
> > *ndev)
> > >   static void teardown_steering(struct mlx5_vdpa_net *ndev)
> > >   {
> > >     clear_mac_vlan_table(ndev);
> > > +   mlx5_vdpa_remove_rx_flow_table(ndev);
> > >     mlx5_destroy_flow_table(ndev->rxft);
> > >   }
> > >
> > > @@ -3167,6 +3175,7 @@ static int mlx5_vdpa_dev_add(struct
> > vdpa_mgmt_dev *v_mdev, const char *name,
> > >     if (err)
> > >             goto err_reg;
> > >
> > > +   mlx5_vdpa_add_debugfs(ndev);
> > >     mgtdev->ndev =3D ndev;
> > >     return 0;
> > >
> > > @@ -3193,6 +3202,8 @@ static void mlx5_vdpa_dev_del(struct
> > vdpa_mgmt_dev *v_mdev, struct vdpa_device *
> > >     struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
> > >     struct workqueue_struct *wq;
> > >
> > > +   mlx5_vdpa_remove_debugfs(ndev->debugfs);
> > > +   ndev->debugfs =3D NULL;
> > >     if (ndev->nb_registered) {
> > >             mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> > >             ndev->nb_registered =3D false;
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > index 6691c879a6ca..f2cef3925e5b 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.h
> > > @@ -16,6 +16,7 @@ struct mlx5_vdpa_net_resources {
> > >     u32 tirn;
> > >     u32 rqtn;
> > >     bool valid;
> > > +   struct dentry *tirn_dent;
> > >   };
> > >
> > >   #define MLX5V_MACVLAN_SIZE 256
> > > @@ -43,6 +44,7 @@ struct mlx5_vdpa_net {
> > >     struct vdpa_callback config_cb;
> > >     struct mlx5_vdpa_wq_ent cvq_ent;
> > >     struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> > > +   struct dentry *debugfs;
> > >   };
> > >
> > >   struct macvlan_node {
> > > @@ -52,4 +54,11 @@ struct macvlan_node {
> > >     u64 macvlan;
> > >   };
> > >
> > > +void mlx5_vdpa_add_debugfs(struct mlx5_vdpa_net *ndev);
> > > +void mlx5_vdpa_remove_debugfs(struct dentry *dbg);
> > > +void mlx5_vdpa_add_rx_flow_table(struct mlx5_vdpa_net *ndev);
> > > +void mlx5_vdpa_remove_rx_flow_table(struct mlx5_vdpa_net *ndev);
> > > +void mlx5_vdpa_add_tirn(struct mlx5_vdpa_net *ndev);
> > > +void mlx5_vdpa_remove_tirn(struct mlx5_vdpa_net *ndev);
> > > +
> > >   #endif /* __MLX5_VNET_H__ */
>

