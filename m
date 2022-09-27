Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26745EB917
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 06:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiI0EEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 00:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiI0EED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 00:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FCFAB049
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664251441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pkfSN/TRKZmIDvmpkOE5MQSmymUdUH4cZBtMN20qr/4=;
        b=Fu5gSsc58mUMuYA/LdZMgVS8ez4amsfOb3zCOUlq4ZfpT9PieFOBUP4dmUWw1wW47cV6Kr
        WHoNFdFTjNsibfXqp5eXvVtDhTXtzlSXoR5kTaUA6qinIAKD7fKvvSGp549Uv7Cm/HcGKp
        gREh87R0TQ+wRgShzoWidC2r/Q605Mk=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-B0HkOtKXMzOB1iHirkMWbA-1; Tue, 27 Sep 2022 00:03:59 -0400
X-MC-Unique: B0HkOtKXMzOB1iHirkMWbA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1273e63cb61so3062037fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 21:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pkfSN/TRKZmIDvmpkOE5MQSmymUdUH4cZBtMN20qr/4=;
        b=j7AqU4o4wIDnWL9CyU1dvHzCnYgW76lsAPZ9hl5u1yjvs4T3EmB0cXkXBb9cESlg1t
         9bS5/f+HlrZnDISkcWtVw9m7qtBnnOkTo/25v27CoA9xquWOQOLh7kqhgjAWOdcVShar
         J0TkroV/u79kznRCSd9z1Hf4V9gsR5SeWSgJ5jbUCM7KTAH/VqGab53bOX69kGu86iRh
         UohNNvudE3TYYDFClThyOkUB9oClCPfLfgqK3Ee+aEhmVwR6U0Mw3S5JSNNy9q49p8gm
         kGuO1YZocrv0VeFWrGmZlZ8lFBryh1N78UKeYQQv2nIThL0s0/rvu8Bg36ISVLllmTvS
         JKcw==
X-Gm-Message-State: ACrzQf3au5h3GgTQksrVyBjoO5zjALE4adas1wks4gUKoPjw9yXGb6Ee
        sYt7ELFH7wQhl2vo+yPkA+nnCLy72BZ8nION3rw18zbaWfE9FB/V5P8GTPnAOIjR76ykgY9uj8q
        HxZNqWYqHPe8YbqhC+ZxnKpOvyenIfbe+klBW62dN
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id n9-20020a056870e40900b00127d330c941mr1052911oag.280.1664251438532;
        Mon, 26 Sep 2022 21:03:58 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lvrSywDHF9s9u0uxXwTb8OdqTgXDn/UfbtlbRiotkX1PHWPgCIdg5l270UTrYKrsHnSnY59lEaBlY0FJNOjE=
X-Received: by 2002:a05:6870:e409:b0:127:d330:c941 with SMTP id
 n9-20020a056870e40900b00127d330c941mr1052906oag.280.1664251438364; Mon, 26
 Sep 2022 21:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220926091130.9244-1-liubo03@inspur.com>
In-Reply-To: <20220926091130.9244-1-liubo03@inspur.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Sep 2022 12:03:47 +0800
Message-ID: <CACGkMEvLXFBjChrVQSXMoS9gSqi_dRwn70FdiH5dfi87H47q4Q@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: remove unnecessary to_vvq() call
To:     Bo Liu <liubo03@inspur.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 5:11 PM Bo Liu <liubo03@inspur.com> wrote:
>
> It passes '_vq' to vring_free(), which still calls to_vvq()
> to get 'vq', let's directly pass 'vq'. It can avoid
> unnecessary call of to_vvq() in hot path.
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 8974c34b40fd..d6d77bf58802 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -221,7 +221,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>                                                void (*callback)(struct virtqueue *),
>                                                const char *name);
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> -static void vring_free(struct virtqueue *_vq);
> +static void vring_free(struct vring_virtqueue *vq);
>
>  /*
>   * Helpers.
> @@ -1140,7 +1140,7 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
>         if (err)
>                 goto err_state_extra;
>
> -       vring_free(&vq->vq);
> +       vring_free(vq);
>
>         virtqueue_vring_init_split(&vring_split, vq);
>
> @@ -2059,7 +2059,7 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>         if (err)
>                 goto err_state_extra;
>
> -       vring_free(&vq->vq);
> +       vring_free(vq);
>
>         virtqueue_vring_init_packed(&vring_packed, !!vq->vq.callback);
>
> @@ -2649,10 +2649,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>
> -static void vring_free(struct virtqueue *_vq)
> +static void vring_free(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq = to_vvq(_vq);
> -
>         if (vq->we_own_ring) {
>                 if (vq->packed_ring) {
>                         vring_free_queue(vq->vq.vdev,
> @@ -2693,7 +2691,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>         list_del(&_vq->list);
>         spin_unlock(&vq->vq.vdev->vqs_list_lock);
>
> -       vring_free(_vq);
> +       vring_free(vq);
>
>         kfree(vq);
>  }
> --
> 2.27.0
>

