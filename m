Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC46056B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJTFVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJTFVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1974A15CB38
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666243271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMRnDVkkHrRATkyUUGvXO7i/mb4rsqNqRwJLsH3u3Y0=;
        b=Fh8zJ1x9KhE8gTy7IwuJwJc536qvupgvWy9MPDrpGauNTgPsUe3DsulSXFWcZ/6z5qytxp
        tDbaRcOe8mQGRLbC7TsY7JlEHImULdNjM9NJspFRjZ6txnPzk48dVRwd1Is4XV5k0Akva9
        r6ZCJkbdnjUYGsEZG/StTsi528Uv6OU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-D3daHcu1MsuRsQlM_4laxQ-1; Thu, 20 Oct 2022 01:21:10 -0400
X-MC-Unique: D3daHcu1MsuRsQlM_4laxQ-1
Received: by mail-ot1-f72.google.com with SMTP id l5-20020a9d7345000000b00661c76ded95so9384963otk.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMRnDVkkHrRATkyUUGvXO7i/mb4rsqNqRwJLsH3u3Y0=;
        b=HTI5XoqV/yBfn02yib3gWa6ZwWKB/G+5TsnJ9kfUrkjxVUkvu1ZQA4NYqrLdLBBiNr
         7Xg6BhNQ80IH0gtLdlRLoI+FDdMf9/IA06uQJQ+9WvP4HkMz8mJb7iVPWapaxECx9ZwT
         CfbWimARhVgYtJLfMpwMQysIYam2+FkJ664N8SVww9vVquEUBoabi3y67Tpr+MRM5e5a
         dEIagOaH4djZbQHvF71kMwZFHszLf8UVDUTZ/YEiwCmEnZgNvq8m5alLNIYA6XYvY/Ht
         7g2J18SVxCVrVNxjiPoB8LcZFFEUbZivdn0xsRqdJCRX6shC7HqdNj31MLiaKeWKsZZ7
         jnTA==
X-Gm-Message-State: ACrzQf0zHdkY0d9oSa5qSiU878oZmsnIoAN4oQ8VYE3BAzOQ7n1+mBJe
        J9p3m8TWbARdS3T1T1TqB8ZmjFDDzuXrXTmMlQU7vPkU9Y2UrJuvJtzbmeErO+gABKFPsQqd/Jo
        u+BUtwv97djCusn4ZxQslFKJuNasyeYLK123x+HK2
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id i19-20020a056870c1d300b00136c4f653afmr23554988oad.35.1666243268866;
        Wed, 19 Oct 2022 22:21:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5WFeAg8gtVjAHKHu2BXh++BG3P1CkS/fEqwi4vYMcKgIdXA3/UkcZKvM4yHhp0p0fkJYgaA9UvDjkLaRclsHA=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr23554975oad.35.1666243268627; Wed, 19
 Oct 2022 22:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com> <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 20 Oct 2022 13:20:57 +0800
Message-ID: <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to _vdpa_register_device()
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Just as _vdpa_register_device taking @nvqs as the number of queues

I wonder if it's better to embed nvqs in the config structure.

> to feed userspace inquery via vdpa_dev_fill(), we can follow the
> same to stash config attributes in struct vdpa_device at the time
> of vdpa registration.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>  drivers/vdpa/vdpa.c                  | 15 +++++++++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
>  include/linux/vdpa.h                 |  3 ++-
>  8 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044..c54ab2c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         else
>                 ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
>
> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
>         if (ret) {
>                 put_device(&adapter->vdpa.dev);
>                 IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9091336..376082e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         mlx5_notifier_register(mdev, &ndev->nb);
>         ndev->nb_registered = true;
>         mvdev->vdev.mdev = &mgtdev->mgtdev;
> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
>         if (err)
>                 goto err_reg;
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index febdc99..566c1c6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
>         return (strcmp(dev_name(&vdev->dev), data) == 0);
>  }
>
> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
> +                                 const struct vdpa_dev_set_config *cfg)
>  {
>         struct device *dev;
>
>         vdev->nvqs = nvqs;
> +       if (cfg)
> +               vdev->vdev_cfg = *cfg;
> +       else
> +               vdev->vdev_cfg.mask = 0ULL;

I think it would be nice if we can convert eni to use netlink then we
don't need any workaround like this.

Thanks

