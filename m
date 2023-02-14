Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F91C69591A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 07:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBNGVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 01:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjBNGVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 01:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AB4118
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676355620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xI69jZKg9dx+a1MKdDsqtA7LTjuUH3e/j2qfMu27oPA=;
        b=Rpi8o7F4T2UN3LbC27vmiB0u5/cv8OXvvR/pcpexts/usmmJB7wz9FhABplEEC/ycQo1jk
        golWN5O8oerkX42DNIzTO6Qir5T+e2gsKVk6/IQidmel2WN+QXGODYK5FsA7vNROy3+RZE
        pN0STXOPdYXhSCMwuFMXUcMXhKsO1ss=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-60-c-Vd-xltPr2CLB1xX6WZLA-1; Tue, 14 Feb 2023 01:20:18 -0500
X-MC-Unique: c-Vd-xltPr2CLB1xX6WZLA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-163af100c41so7494712fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 22:20:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xI69jZKg9dx+a1MKdDsqtA7LTjuUH3e/j2qfMu27oPA=;
        b=wruNTkBMSSwtv0FEN+MgtnDjjFLWzyo9cMtEYpR5J2pgXYls4JytWASbgEEF5OjNKd
         jarrkA4cMHPJxXWlyGHxenymfViP46uiAHqdOROT1z/MhBW/WBpmVhj1Ix2QRtOk0DNI
         jkgsLHIOzAOqPXD+SdEc827lAzDyjOod/PnBWcugBlEEUJiQ7FZpXjQRERLox28VhCh7
         WKsoUzFXPGZ+TbQbCHB2xCdsF/laLjjvZ+MpRqvTFCWHAh+sswUYf8cOvyoi+3gpnO/1
         iwQdiE1K7OnJLH+vutpHdLIHxgQXGIuSl0YDzLM6jxTE7gFJZQm9cV9gmXzcBj1U8t9n
         1rQQ==
X-Gm-Message-State: AO0yUKUVkRgtMzZ4XP8Gv0ZJGA6QBhroVJW6an5o4x08NPm4kJio7VpM
        L6sFrUkykSyYHhG1GBSMndIHVvKf9JwgdmBmbTg5CeYSmji/iHugVrqs49Hxsyl7unPvE5CZx27
        2fDenXPuVADHZ9pdghnmfA5bhKYDrghVh7pBWCCUU
X-Received: by 2002:a05:6808:1a20:b0:37d:5d77:e444 with SMTP id bk32-20020a0568081a2000b0037d5d77e444mr1004275oib.35.1676355618103;
        Mon, 13 Feb 2023 22:20:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+Hne4gWfLZE6vZsWr4yg1VxQbKJzulcCAu2WQ15H5hDw43jxoLUsVLw6tYdC4+do43imCLtVkw3F46ic0Zc1w=
X-Received: by 2002:a05:6808:1a20:b0:37d:5d77:e444 with SMTP id
 bk32-20020a0568081a2000b0037d5d77e444mr1004270oib.35.1676355617888; Mon, 13
 Feb 2023 22:20:17 -0800 (PST)
MIME-Version: 1.0
References: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Feb 2023 14:20:06 +0800
Message-ID: <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: should not activate virtq object when suspended
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

On Tue, Feb 14, 2023 at 6:48 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Otherwise the virtqueue object to instate could point to invalid address
> that was unmapped from the MTT:
>
>   mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>   CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>   bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>
> ---
> v2: removed the change for improving warning message
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..d7e8ca0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>         u32 cur_num_vqs;
>         u32 rqt_size;
>         bool nb_registered;
> +       bool suspended;

Any reason we make this net specific? (or is it better to use
mlx5_vdpa_dev structure?)


>         struct notifier_block nb;
>         struct vdpa_callback config_cb;
>         struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -2411,7 +2412,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>         if (err)
>                 goto err_mr;
>
> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
>                 goto err_mr;
>
>         restore_channels_info(ndev);
> @@ -2580,6 +2581,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
>         ndev->cur_num_vqs = 0;
> +       ndev->suspended = false;
>         ndev->mvdev.cvq.received_desc = 0;
>         ndev->mvdev.cvq.completed_desc = 0;
>         memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> @@ -2815,6 +2817,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> +       mlx5_vdpa_info(mvdev, "suspending device\n");
> +

Is this better to show the info after the device has been suspended?

Thanks

>         down_write(&ndev->reslock);
>         ndev->nb_registered = false;
>         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> @@ -2824,6 +2828,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>                 suspend_vq(ndev, mvq);
>         }
>         mlx5_vdpa_cvq_suspend(mvdev);
> +       ndev->suspended = true;
>         up_write(&ndev->reslock);
>         return 0;
>  }
> --
> 1.8.3.1
>

