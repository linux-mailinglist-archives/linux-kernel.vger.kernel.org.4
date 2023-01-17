Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C3166D6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjAQH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjAQH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E2AC140
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673940357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iizuc0HQbsrm6BiEPcueJvdkUUwR6glPVHvzA95lMhU=;
        b=bH6VDIJa9tmg4/XI/flN+Um9EVTZuSh/x911W7vFo3RbXdXMc0pfryYh/+/U9FJjXVG98m
        YUa1PTshyS+jdYCPHbFGEc4buXE6+4ZxUSiIbBjL7AxX+PCL99II12BG1+5GnF6Wt5QbPi
        h704BTL77p8W1nswcuE+56SQzDNjE04=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-JHuFw--APPKAtJ0gFrLlcw-1; Tue, 17 Jan 2023 02:25:56 -0500
X-MC-Unique: JHuFw--APPKAtJ0gFrLlcw-1
Received: by mail-yb1-f199.google.com with SMTP id k135-20020a25248d000000b007d689f92d6dso7182968ybk.22
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iizuc0HQbsrm6BiEPcueJvdkUUwR6glPVHvzA95lMhU=;
        b=hsZCAnrdUfu9gMTUS3tVb1cujwT/MrH67oKOo5nx64FYNL+07fKEiH5ArAWHfaTSJq
         LrunF+Y/R/QYlc1KadfQXNNp5IZcfFpTZd91fzH52klLaTk+VpAxwDDM1F5h+jAopSj/
         /fDhOueOGvrr+G9Pt/TdZm/z3+HmU4VDDzWXovaC6NfOmTlEG8zWXV0I+STfdLiE3UCa
         pLo7wz8jc071p4KW5PjGs0+m1P5JdNnN3Od6LMYfxYr6dRNHCCbZv3Rj8i4yqPVCkrvK
         lAeF+PRVEoTUb6VBAZWWoZI4GDb1BMxreGtl3omCpDyFqr9hX/EG2Ad2F4FYpQZCP7MX
         k8Mg==
X-Gm-Message-State: AFqh2kpPvfagkF5r+5KPKYhJLAWjSdpJGhVvfNzW/l5T46YAub7rrWZr
        bQU1r8dBHOb/5Qvzu1XTnIii/yyHynek9qi/A0GklpPpfRg7MkDqtcVnQ9Bc4vkknKzaVQax9+k
        hxcM0dAXsrhri7Vech6HoanvEDjN8iynpO2xYD7Ir
X-Received: by 2002:a81:1103:0:b0:41e:2266:9718 with SMTP id 3-20020a811103000000b0041e22669718mr323173ywr.294.1673940355521;
        Mon, 16 Jan 2023 23:25:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXstuo6LF90CJhyvHfiyx4S3DUpMqR5LxKbDWfkNRjMvlhwOuFX+qqyZlYODQ71Z5o/ohL+ywjyKm+hlr/g3C5M=
X-Received: by 2002:a81:1103:0:b0:41e:2266:9718 with SMTP id
 3-20020a811103000000b0041e22669718mr323163ywr.294.1673940355271; Mon, 16 Jan
 2023 23:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20230112142218.725622-1-eperezma@redhat.com> <20230112142218.725622-3-eperezma@redhat.com>
 <DM8PR12MB5400B2FF15EA6DB00AB840EBABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWeJOwcAj=mr5R4qHqWSjK1dQ-SxMNVF0HYkPtdoO2BaGQ@mail.gmail.com> <521e9601-b9b1-19f0-24cb-89fb2e7ed164@nvidia.com>
In-Reply-To: <521e9601-b9b1-19f0-24cb-89fb2e7ed164@nvidia.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Tue, 17 Jan 2023 08:25:18 +0100
Message-ID: <CAJaqyWfor5boWZBxMCSg8tQY==7WRQsHDY2Ce=jTtxEud6rPCA@mail.gmail.com>
Subject: Re: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr
To:     Eli Cohen <elic@nvidia.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
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

On Tue, Jan 17, 2023 at 8:08 AM Eli Cohen <elic@nvidia.com> wrote:
>
>
> On 16/01/2023 20:03, Eugenio Perez Martin wrote:
> > On Mon, Jan 16, 2023 at 8:03 AM Eli Cohen <elic@nvidia.com> wrote:
> >>> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>> Sent: Thursday, 12 January 2023 16:22
> >>> To: mst@redhat.com; Eli Cohen <elic@nvidia.com>
> >>> Cc: linux-kernel@vger.kernel.org; Parav Pandit <parav@nvidia.com>;
> >>> lulu@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
> >>> foundation.org; sgarzare@redhat.com; si-wei.liu@oracle.com
> >>> Subject: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destr=
oy_mr
> >>>
> >>> mlx5_vdpa_destroy_mr can be called by setting a map to data ASID afte=
r
> >>> populating control virtqueue ASID iotlb.  Control vq iotlb must not b=
e
> >>> cleared, since it will not be populated again.
> >>>
> >>> Adding a conditional in the function so the caller specifies if it is
> >>> resetting, cleaning, or just changing data memory.
> >>>
> >>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for
> >>> control and data")
> >>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >>> ---
> >>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
> >>>   drivers/vdpa/mlx5/core/mr.c        |  5 +++--
> >>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
> >>>   3 files changed, 10 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>> index 058fbe28107e..000b144019ec 100644
> >>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >>> @@ -119,7 +119,7 @@ int mlx5_vdpa_handle_set_map(struct
> >>> mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
> >>>                             bool *change_map, unsigned int asid);
> >>>   int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_i=
otlb
> >>> *iotlb,
> >>>                        unsigned int asid);
> >>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
> >>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool
> >>> delete_cvq_iotlb);
> >>>
> >>>   #define mlx5_vdpa_warn(__dev, format, ...)
> >>> \
> >>>        dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: "
> >>> format, __func__, __LINE__,     \
> >>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.=
c
> >>> index ae34dcac9a3f..878ee94efa78 100644
> >>> --- a/drivers/vdpa/mlx5/core/mr.c
> >>> +++ b/drivers/vdpa/mlx5/core/mr.c
> >>> @@ -491,7 +491,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev
> >>> *mvdev, struct mlx5_vdpa_mr *mr
> >>>        }
> >>>   }
> >>>
> >>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> >>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool
> >>> delete_cvq_iotlb)
> >>>   {
> >>>        struct mlx5_vdpa_mr *mr =3D &mvdev->mr;
> >>>
> >>> @@ -499,7 +499,8 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev
> >>> *mvdev)
> >>>        if (!mr->initialized)
> >>>                goto out;
> >>>
> >>> -     prune_iotlb(mvdev);
> >>> +     if (delete_cvq_iotlb)
> >>> +             prune_iotlb(mvdev);
> >>>        if (mr->user_mr)
> >>>                destroy_user_mr(mvdev, mr);
> >>>        else
> >>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> index 6632651b1e54..1f1f341f602b 100644
> >>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >>> @@ -2433,7 +2433,7 @@ static int mlx5_vdpa_change_map(struct
> >>> mlx5_vdpa_dev *mvdev,
> >>>                goto err_mr;
> >>>
> >>>        teardown_driver(ndev);
> >>> -     mlx5_vdpa_destroy_mr(mvdev);
> >>> +     mlx5_vdpa_destroy_mr(mvdev, mvdev-
> >>>> group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid);
> >> Looks to me we need to handle this in a more generic manner. The asid =
should be used conditionally for either CVQ or data VQ updates. You are pro=
tecting CVQ but same thing should hold also for data VQs iotlb.
> > I agree. Maybe the best option is to replace the boolean indicating
> > the ASID we want to destroy mr? Then, at cleanup, we can iterate by
> > all vq groups / ASID.
>
> I think mlx5_vdpa_destroy_mr() should get the asid as an argument and
> have a logic such as:
>
> if (asid =3D=3D data asid)
>
>      destroy_data_mr
>
>
> if (asid =3D=3D ctrl_vq_asid)
>
>      prune_iotlb()
>
>
> return
>

I agree.

> Since we have only two groups, one for data and for control, I don't
> think we need to iterate.
>

I mean to iterate on mlx5_vdpa_reset and mlx5_vdpa_free. Or, at least,
to call mlx5_vdpa_destroy_mr(asid=3Ddata) and
mlx5_vdpa_destroy_mr(asid=3Dcontrol) one after another.

Thanks!

> >
> >> Meaning, if qemu wants to update only CVQ than data VQ translation mus=
t not be affected.
> > _mlx5_vdpa_create_mr. is the one that checks it If I recall correctly.
> > It is not obvious in this change though.
> >
> > Thanks!
> >
> >>>        err =3D mlx5_vdpa_create_mr(mvdev, iotlb, asid);
> >>>        if (err)
> >>>                goto err_mr;
> >>> @@ -2449,7 +2449,7 @@ static int mlx5_vdpa_change_map(struct
> >>> mlx5_vdpa_dev *mvdev,
> >>>        return 0;
> >>>
> >>>   err_setup:
> >>> -     mlx5_vdpa_destroy_mr(mvdev);
> >>> +     mlx5_vdpa_destroy_mr(mvdev, mvdev-
> >>>> group2asid[MLX5_VDPA_CVQ_GROUP] =3D=3D asid);
> >>>   err_mr:
> >>>        return err;
> >>>   }
> >>> @@ -2578,7 +2578,7 @@ static void mlx5_vdpa_set_status(struct
> >>> vdpa_device *vdev, u8 status)
> >>>        return;
> >>>
> >>>   err_setup:
> >>> -     mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>> +     mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
> >>>        ndev->mvdev.status |=3D VIRTIO_CONFIG_S_FAILED;
> >>>   err_clear:
> >>>        up_write(&ndev->reslock);
> >>> @@ -2604,7 +2604,7 @@ static int mlx5_vdpa_reset(struct vdpa_device
> >>> *vdev)
> >>>        down_write(&ndev->reslock);
> >>>        teardown_driver(ndev);
> >>>        clear_vqs_ready(ndev);
> >>> -     mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>> +     mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
> >>>        ndev->mvdev.status =3D 0;
> >>>        ndev->cur_num_vqs =3D 0;
> >>>        ndev->mvdev.cvq.received_desc =3D 0;
> >>> @@ -2691,7 +2691,7 @@ static void mlx5_vdpa_free(struct vdpa_device
> >>> *vdev)
> >>>        ndev =3D to_mlx5_vdpa_ndev(mvdev);
> >>>
> >>>        free_resources(ndev);
> >>> -     mlx5_vdpa_destroy_mr(mvdev);
> >>> +     mlx5_vdpa_destroy_mr(mvdev, true);
> >>>        if (!is_zero_ether_addr(ndev->config.mac)) {
> >>>                pfmdev =3D pci_get_drvdata(pci_physfn(mvdev->mdev->pde=
v));
> >>>                mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
> >>> @@ -3214,7 +3214,7 @@ static int mlx5_vdpa_dev_add(struct
> >>> vdpa_mgmt_dev *v_mdev, const char *name,
> >>>   err_res2:
> >>>        free_resources(ndev);
> >>>   err_mr:
> >>> -     mlx5_vdpa_destroy_mr(mvdev);
> >>> +     mlx5_vdpa_destroy_mr(mvdev, true);
> >>>   err_res:
> >>>        mlx5_vdpa_free_resources(&ndev->mvdev);
> >>>   err_mpfs:
> >>> --
> >>> 2.31.1
>

