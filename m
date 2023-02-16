Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFD5698B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBPFL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPFLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:11:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADDF35257
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676524237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEOw+fFXvT/l5l18gNoMMgT+IO3GvsNReydBsGDaXBw=;
        b=SoRZ00rcVHdcWGdc2bLObXgl9paQq9LqtY2hWeO7hX7McBZrBMFx8he0juQAAmVFqPhi7w
        prKgwFCtK/VAdVSXwCU04Qlfl+bl+6IQr8srOYAzJnQe9Sgiq37CZkhIPg1bR06TuprF68
        /wBS5ZjYwAA8qkCS5nfkv6J6I1Xd8UE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-449-UHiMyzDVN3m2Ms_TBNJAxQ-1; Thu, 16 Feb 2023 00:10:35 -0500
X-MC-Unique: UHiMyzDVN3m2Ms_TBNJAxQ-1
Received: by mail-ot1-f71.google.com with SMTP id b27-20020a9d60db000000b00690d541fde4so392742otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CEOw+fFXvT/l5l18gNoMMgT+IO3GvsNReydBsGDaXBw=;
        b=ect1+p4NWwMqOcdmuRL5OrDC9fZruiwwT8tOhY7YPlhP/wcYknXB6U7x2q4FEOhzjS
         AFEtGQzXuuCaMMmLC/PfzejNNqJsvLr2FsULcloFThBc+2FiIA2qKxiv0gU2m7UXVrfK
         iQDnvUJ6sv3vGQF3ljAVfTdFSS5aaFTF2JtGmHtcao1j8l3aKTEwbfZhcn7pX0uQJf6G
         VulQzFkYYv1doT7RvbjpZVcOODS7/3MBKnAituKlmU4DoV5QYSdj+JIrskLY6bhRmBaS
         cFOlNLn/2hCG5p1CaJsSvLDFeD3S7I7Kq+yLVsaFnPlnXSW1VTwfVJ4XvCXV3GPaWTNW
         /F1Q==
X-Gm-Message-State: AO0yUKVpXaYFiXL8NtwDosIuLi3a1uQuhY3QiaYwC6aM65mqrhd+gxdG
        ObE8SmiAI5XePIYH1Ux1pe34qYOynM//mPRzW0wFPqYAd05buxRsOpuNZVhyrGBFbM4OIhoP55c
        VqUK+lPTjAceve9c3INO8O5d1PFRJxc9cUkhVx6vF
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id sw10-20020a05687184ca00b0016a2c1ae416mr63871oab.35.1676524234415;
        Wed, 15 Feb 2023 21:10:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/KIXftRtboDYzsgFuohH6mdd4wAc8dK2MW76paQ88KbDnud3z3FIDB5p1pRuBJVDOzPWMr5/wdXAtMDdG88Xs=
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id
 sw10-20020a05687184ca00b0016a2c1ae416mr63865oab.35.1676524234152; Wed, 15 Feb
 2023 21:10:34 -0800 (PST)
MIME-Version: 1.0
References: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuckWowpA9q+ez0-U4FicamQ+5zXfumtQMA25jXpvL7uw@mail.gmail.com> <ea8bdfc7-46b9-8510-0a87-1fa6dd5759a1@oracle.com>
In-Reply-To: <ea8bdfc7-46b9-8510-0a87-1fa6dd5759a1@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 16 Feb 2023 13:10:23 +0800
Message-ID: <CACGkMEsnLfrGOa2gqT8n9W4pFxnpHWwsmjokx2kqojo=O37O-Q@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa/mlx5: should not activate virtq object when suspended
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, elic@nvidia.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
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

On Thu, Feb 16, 2023 at 1:03 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 2/15/2023 8:48 PM, Jason Wang wrote:
> > On Wed, Feb 15, 2023 at 9:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Otherwise the virtqueue object to instate could point to invalid address
> >> that was unmapped from the MTT:
> >>
> >>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
> >>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
> >>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
> >>
> >> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> >> Cc: Eli Cohen <elic@nvidia.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> Reviewed-by: Eli Cohen <elic@nvidia.com>
> >>
> >> ---
> >> v3: move suspended to struct mlx5_vdpa_dev
> >> v2: removed the change for improving warning message
> >> ---
> >>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 +++++-
> >>   2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> index 058fbe2..25fc412 100644
> >> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> @@ -96,6 +96,7 @@ struct mlx5_vdpa_dev {
> >>          struct mlx5_control_vq cvq;
> >>          struct workqueue_struct *wq;
> >>          unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> >> +       bool suspended;
> >>   };
> >>
> >>   int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index 3a6dbbc6..daac3ab 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -2411,7 +2411,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
> >>          if (err)
> >>                  goto err_mr;
> >>
> >> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
> > One more thought,
> >
> > Does this mean set_map() is forbidden during suspending?
> No, it will not. Instead it now allows set_map() to proceed even if
> mapping is shrinking while device is suspended. The "goto err_mr" below
> actually returns 0 when it leaves mlx5_vdpa_change_map().

You're right.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> -Siwei
>
> >   I'm not sure
> > this is correct or at least we need restrict in in the vDPA core.
> >
> > Thanks
> >
> >>                  goto err_mr;
> >>
> >>          restore_channels_info(ndev);
> >> @@ -2579,6 +2579,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >>          clear_vqs_ready(ndev);
> >>          mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>          ndev->mvdev.status = 0;
> >> +       ndev->mvdev.suspended = false;
> >>          ndev->cur_num_vqs = 0;
> >>          ndev->mvdev.cvq.received_desc = 0;
> >>          ndev->mvdev.cvq.completed_desc = 0;
> >> @@ -2815,6 +2816,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
> >>          struct mlx5_vdpa_virtqueue *mvq;
> >>          int i;
> >>
> >> +       mlx5_vdpa_info(mvdev, "suspending device\n");
> >> +
> >>          down_write(&ndev->reslock);
> >>          ndev->nb_registered = false;
> >>          mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> >> @@ -2824,6 +2827,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
> >>                  suspend_vq(ndev, mvq);
> >>          }
> >>          mlx5_vdpa_cvq_suspend(mvdev);
> >> +       mvdev->suspended = true;
> >>          up_write(&ndev->reslock);
> >>          return 0;
> >>   }
> >> --
> >> 1.8.3.1
> >>
>

