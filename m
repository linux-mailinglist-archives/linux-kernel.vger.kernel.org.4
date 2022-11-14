Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1D6276CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiKNHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiKNHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:54:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918DB22A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668412403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i2TV4qSy21VU+sk5sjRM64dTZU7pZku1ImCIDTVwlIA=;
        b=AQYhDnvV73+Qd9zhbxgc9Yq07Q5NN11ZkwGWmhesxonYffdM9/OMU3LzQa/axz72XRvpAx
        UZG0hJXU5bmfnmoRDqMSiAYIA/aWTQqFlSPwul+kAEJujsKXWOb4/ArGp8YfVyJC9OyXR3
        e9VQM30HmJPT8YkMiNO/yWu1HneQcy4=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-bwpQYNb4OL6FGZQriGbmMw-1; Mon, 14 Nov 2022 02:53:21 -0500
X-MC-Unique: bwpQYNb4OL6FGZQriGbmMw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13bc77c87f6so5098758fac.19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2TV4qSy21VU+sk5sjRM64dTZU7pZku1ImCIDTVwlIA=;
        b=tzZXEwnMXFE+lsnRGXCufyvPBOcURjNZaL+W+u4iPJJ5YtFMrKrMhJvo72+nQrp6oF
         5C1ud0OHJwKbEypUezgjVxCQYOWDZL+XpZCc2xxB+TJ8gaP8HDSWhMoRrHSwG2aBeq9T
         jjbpvGOUfawzeJkSISP6plXyJ+VUulX4TB56X4BtvZiEyJQ0UgLi61ofkETbuxKEIAra
         bqYxqalOxO+Re0JgfFEV4XriGUUhRNdc1dy1Okfg2jU2Va0MWgvJ1fFpaMdr8SFUW5CY
         GFnkZXb5A6/ZfnCrsrEQeV8Oad6mRslGMvJ3qy+n7HNUQ2EOS8twGY/m++8QBVNOMuUv
         uo0A==
X-Gm-Message-State: ANoB5pnUmV3efPVsinpT7+UFdZ+3w8o6PYUj6OcxzTn6R3MN2tB+aTvg
        +ZwnB5Kvte1CTTevJWjFDrZr6CaiKhiTupwR3oWE68Nq+eaZ30KfxXoqZzsEN5K/ncl/YmSc7ya
        LN1xg5E8c4hkyZ1QpXS45Lvx/9TcmO4qK2xtN9rOV
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id p5-20020a544605000000b0035468aa9c59mr5210567oip.35.1668412400633;
        Sun, 13 Nov 2022 23:53:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Vkq31SLnZPS7YCw3N8XrceMuGkoMwan8QFQOt1NWvPgsD49puCtuMISsrbN/ojMoIW2ZKe4qVQNuSMrgJB2E=
X-Received: by 2002:a54:4605:0:b0:354:68aa:9c59 with SMTP id
 p5-20020a544605000000b0035468aa9c59mr5210557oip.35.1668412400397; Sun, 13 Nov
 2022 23:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20221113134442.152695-1-elic@nvidia.com> <20221113134442.152695-7-elic@nvidia.com>
In-Reply-To: <20221113134442.152695-7-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 14 Nov 2022 15:53:09 +0800
Message-ID: <CACGkMEt+7kKD8_q_OFKURbFR1W=YbJpcuwZq5bf5jC4qzE8PEA@mail.gmail.com>
Subject: Re: [PATCH 6/7] vdpa/mlx5: Avoid using reslock in event_handler
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
> event_handler runs under atomic context and may not acquire reslock. We
> can still guarantee that the handler won't be called after suspend by
> clearing nb_registered, unregistering the handler and flushing the
> workqueue.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6e6490c85be2..bebfba530247 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2872,8 +2872,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>         int i;
>
>         down_write(&ndev->reslock);
> -       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>         ndev->nb_registered = false;
> +       mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);

I wonder why this can help anything. And if it does, we have simliar
logic in mlx5_vdpa_dev_del() do we need to fix that as well?

Thanks

>         flush_workqueue(ndev->mvdev.wq);
>         for (i = 0; i < ndev->cur_num_vqs; i++) {
>                 mvq = &ndev->vqs[i];
> @@ -3051,7 +3051,7 @@ static void update_carrier(struct work_struct *work)
>         else
>                 ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
>
> -       if (ndev->config_cb.callback)
> +       if (ndev->nb_registered && ndev->config_cb.callback)
>                 ndev->config_cb.callback(ndev->config_cb.private);
>
>         kfree(wqent);
> @@ -3068,21 +3068,13 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>                 switch (eqe->sub_type) {
>                 case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>                 case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> -                       down_read(&ndev->reslock);
> -                       if (!ndev->nb_registered) {
> -                               up_read(&ndev->reslock);
> -                               return NOTIFY_DONE;
> -                       }
>                         wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -                       if (!wqent) {
> -                               up_read(&ndev->reslock);
> +                       if (!wqent)
>                                 return NOTIFY_DONE;
> -                       }
>
>                         wqent->mvdev = &ndev->mvdev;
>                         INIT_WORK(&wqent->work, update_carrier);
>                         queue_work(ndev->mvdev.wq, &wqent->work);
> -                       up_read(&ndev->reslock);
>                         ret = NOTIFY_OK;
>                         break;
>                 default:
> --
> 2.38.1
>

