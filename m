Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CD652BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 04:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiLUDYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 22:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiLUDYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 22:24:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B0D1AF25
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671593044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGspaHzQPxqTwdTzEM+6CxFY6yjXuHAKATnBqhR/cIw=;
        b=ItIf7A/kSmEM080v167pyAImRjonYafxaH8lttBz4NKhzR53v2T1HrS1KaNUWm/YMlFBfS
        oSNi0N55HR6pjh+It/i6xOWLmocd6R6mqCBF4To71/3G7UswBhlmm+somh9y470a1VPmdm
        aq2II+lWqmIBszNOy6mtiVP9dWDhdnQ=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-_v2AQ36kNtKqxCJcIuHrLA-1; Tue, 20 Dec 2022 22:24:03 -0500
X-MC-Unique: _v2AQ36kNtKqxCJcIuHrLA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-14496b502dfso6354379fac.17
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 19:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGspaHzQPxqTwdTzEM+6CxFY6yjXuHAKATnBqhR/cIw=;
        b=Doxx87GJV6OcIlVEd1QaFXe5JlCgyt401LxRQx0fvQGnQSo/8wTanouj1HCix1lx3k
         zC6rqnVSt27siq++81JYyAJ1+8DeWLqx6ZtzzdiKf9GIevZaoJBAvCkFe+oSmGUKgRFk
         cXt8JgOJGkDF8MC057KaPmRBJ8qH4gB2vWCV7cB/sGCtM9lkSpQMqB4sUAQmpXgv6tVP
         RF/D4nud68wndzqClZ9L2OOSZilVBbnHM7C//YSexobnO1jytwknydte8drl6fSl+UJr
         SyofuA8o+prOlSVLHQ2h7t1jPeO+aH+LxmimyK517+GKvzd+F21cCjbtEARgybxWVD+F
         N4KA==
X-Gm-Message-State: AFqh2kpy3Y4QlRzBcGu35qqxWhDoLCd9j1V7Vlz2cV9ZxN1cKCvsy0w3
        1S1M1O2O1y72I1o2L5xvFgd1idKknMP7uFInfznZVnRWPr9Kp61w/q2Cv4MURPzV4d4ncZGFYo7
        uPv7IIgm3Wqf6jaBVQi1ieAMKusUit34vtdP9kZMV
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id c3-20020a9d7843000000b006781eb43406mr24998otm.237.1671593042446;
        Tue, 20 Dec 2022 19:24:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu6qY57e2GgcRHWrfthleF4uh/gauFFEArM3SE5nEJmGcPQ8lmsJLiuqe4JznhtR/YQJA67yWVZFf3UWvSworo=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr24997otm.237.1671593042237; Tue, 20 Dec
 2022 19:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20221220112340.518841-1-mst@redhat.com>
In-Reply-To: <20221220112340.518841-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 21 Dec 2022 11:23:51 +0800
Message-ID: <CACGkMEvwwBSkeUaOJKYB2VTc0HT60sWfLFSNwcrEzyDWu9Aj2g@mail.gmail.com>
Subject: Re: [PATCH] virtio-blk: fix probe without CONFIG_BLK_DEV_ZONED
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 7:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> When building without CONFIG_BLK_DEV_ZONED, VIRTIO_BLK_F_ZONED
> is excluded from array of driver features.
> As a result virtio_has_feature panics in virtio_check_driver_offered_feature
> since that by design verifies that a feature we are checking for
> is listed in the feature array.
>
> To fix, replace the call to virtio_has_feature with a stub.
>
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/block/virtio_blk.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 88b3639f8536..5ea1dc882a80 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -760,6 +760,10 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>         return ret;
>  }
>
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +       return virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED);
> +}
>  #else
>
>  /*
> @@ -775,6 +779,11 @@ static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline bool virtblk_has_zoned_feature(struct virtio_device *vdev)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_BLK_DEV_ZONED */
>
>  /* return id (s/n) string for *disk to *id_str
> @@ -1480,7 +1489,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>         virtblk_update_capacity(vblk, false);
>         virtio_device_ready(vdev);
>
> -       if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +       if (virtblk_has_zoned_feature(vdev)) {
>                 err = virtblk_probe_zoned_device(vdev, vblk, q);
>                 if (err)
>                         goto out_cleanup_disk;
> --
> MST
>

