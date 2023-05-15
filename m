Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224F67020F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjEOBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEOBHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B610E9
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684112816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GShV9rQVPoiBC3aZLWHV81IRxeBh9KQe/grJK0OSZg=;
        b=ev9SzvEhpHTPrYn8c6TIUyk5DUV2unRoYwlGrYTK653O+04V93u9/G2nMVu2bezpBcNri0
        XRhBx6/nlP69MQcqb7B19Nx+5jr+e8fFdVbTU0wP7iZmsML5QVPLDAO7r+IwreUE8EO8tp
        9jFTljBzI9f92V6FwBD8K9fwKiu9OwQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-WIUMmTWPPtmGMhJVrUAkAw-1; Sun, 14 May 2023 21:06:55 -0400
X-MC-Unique: WIUMmTWPPtmGMhJVrUAkAw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f3789c4a3cso992628e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 18:06:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684112813; x=1686704813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GShV9rQVPoiBC3aZLWHV81IRxeBh9KQe/grJK0OSZg=;
        b=Oz77sO1CwCQ1qlslZC1R4+uZM2CnInXJKuuteZ773eJqwgPUG7OWr7jm+ProIh01EK
         ztQQmBwvy+Y41x5whxZt/gkN8/EktlPkzeyf8AZX6lkVAKmGXjBpfdLCkHffU/5XTqs3
         PJ+6O8dQmDKE/c4+Xp8qNUs6ftMlHXv8DRGoZEPE6itX5XGIBEZKtmSwdQ0Jzf0hzt9L
         CNh0r0TePjyQWtw24T+VUa0bKsPvI0pNI5nPq4+epdQAsKw50pbbBLXXoxedjcBzP8WF
         IEZAWY1GGoRufceKsVJ7xYEgaLzA/LUe0thQCM3ctmmTRVqNv7O3Ac2JWdLSL/YIEvRJ
         VA0A==
X-Gm-Message-State: AC+VfDzf5ybScd0X2h5CbzALnGEyd1qSmT5q07sND2MHsd3rStW5ErnL
        k3mSsloJ8swnSxC9a7BteH/eL+9jLDFlpvmIA45HqtgQ6FgznQB4mZwgZbR5Oyg3C3th5ayIAuf
        98z4zw5XyGNqpde7sUsahsekn9etpYW6D8fW1n0c0
X-Received: by 2002:ac2:55a6:0:b0:4ee:d8f3:1398 with SMTP id y6-20020ac255a6000000b004eed8f31398mr5934365lfg.68.1684112813234;
        Sun, 14 May 2023 18:06:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ45LxbE+gq1RPYwef6WE67FgUUzSqPe9cPjccRfp9vTAvE7LGqJ2vn8M657T3NlXAupmgs40Ezr6Ol6Lylly1U=
X-Received: by 2002:ac2:55a6:0:b0:4ee:d8f3:1398 with SMTP id
 y6-20020ac255a6000000b004eed8f31398mr5934353lfg.68.1684112813027; Sun, 14 May
 2023 18:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230512151812.1806-1-feliu@nvidia.com>
In-Reply-To: <20230512151812.1806-1-feliu@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 15 May 2023 09:06:41 +0800
Message-ID: <CACGkMEvMDWZg56TfMX0XV86ANet01WU1Mr+ZCQa_Xphem42ydw@mail.gmail.com>
Subject: Re: [PATCH net v6] virtio_net: Fix error unwinding of XDP initialization
To:     Feng Liu <feliu@nvidia.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Simon Horman <simon.horman@corigine.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 11:18=E2=80=AFPM Feng Liu <feliu@nvidia.com> wrote:
>
> When initializing XDP in virtnet_open(), some rq xdp initialization
> may hit an error causing net device open failed. However, previous
> rqs have already initialized XDP and enabled NAPI, which is not the
> expected behavior. Need to roll back the previous rq initialization
> to avoid leaks in error unwinding of init code.
>
> Also extract helper functions of disable and enable queue pairs.
> Use newly introduced disable helper function in error unwinding and
> virtnet_close. Use enable helper function in virtnet_open.
>
> Fixes: 754b8a21a96d ("virtio_net: setup xdp_rxq_info")
> Signed-off-by: Feng Liu <feliu@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Reviewed-by: William Tu <witu@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
> v5 -> v6
> feedbacks from Xuan Zhuo
> - add disable_delayed_refill and cancel_delayed_work_sync
>
> v4 -> v5
> feedbacks from Michael S. Tsirkin
> - rename helper as virtnet_disable_queue_pair
> - rename helper as virtnet_enable_queue_pair
>
> v3 -> v4
> feedbacks from Jiri Pirko
> - Add symmetric helper function virtnet_enable_qp to enable queues.
> - Error handle:  cleanup current queue pair in virtnet_enable_qp,
>   and complete the reset queue pairs cleanup in virtnet_open.
> - Fix coding style.
> feedbacks from Parav Pandit
> - Remove redundant debug message and white space.
>
> v2 -> v3
> feedbacks from Michael S. Tsirkin
> - Remove redundant comment.
>
> v1 -> v2
> feedbacks from Michael S. Tsirkin
> - squash two patches together.
>
> ---
>  drivers/net/virtio_net.c | 61 +++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index a12ae26db0e2..56ca1d270304 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1868,6 +1868,38 @@ static int virtnet_poll(struct napi_struct *napi, =
int budget)
>         return received;
>  }
>
> +static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_i=
ndex)
> +{
> +       virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> +       napi_disable(&vi->rq[qp_index].napi);
> +       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +}
> +
> +static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_ind=
ex)
> +{
> +       struct net_device *dev =3D vi->dev;
> +       int err;
> +
> +       err =3D xdp_rxq_info_reg(&vi->rq[qp_index].xdp_rxq, dev, qp_index=
,
> +                              vi->rq[qp_index].napi.napi_id);
> +       if (err < 0)
> +               return err;
> +
> +       err =3D xdp_rxq_info_reg_mem_model(&vi->rq[qp_index].xdp_rxq,
> +                                        MEM_TYPE_PAGE_SHARED, NULL);
> +       if (err < 0)
> +               goto err_xdp_reg_mem_model;
> +
> +       virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> +       virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index]=
.napi);
> +
> +       return 0;
> +
> +err_xdp_reg_mem_model:
> +       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> +       return err;
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> @@ -1881,22 +1913,20 @@ static int virtnet_open(struct net_device *dev)
>                         if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>                                 schedule_delayed_work(&vi->refill, 0);
>
> -               err =3D xdp_rxq_info_reg(&vi->rq[i].xdp_rxq, dev, i, vi->=
rq[i].napi.napi_id);
> +               err =3D virtnet_enable_queue_pair(vi, i);
>                 if (err < 0)
> -                       return err;
> -
> -               err =3D xdp_rxq_info_reg_mem_model(&vi->rq[i].xdp_rxq,
> -                                                MEM_TYPE_PAGE_SHARED, NU=
LL);
> -               if (err < 0) {
> -                       xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -                       return err;
> -               }
> -
> -               virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);
> -               virtnet_napi_tx_enable(vi, vi->sq[i].vq, &vi->sq[i].napi)=
;
> +                       goto err_enable_qp;
>         }
>
>         return 0;
> +
> +err_enable_qp:
> +       disable_delayed_refill(vi);
> +       cancel_delayed_work_sync(&vi->refill);
> +
> +       for (i--; i >=3D 0; i--)
> +               virtnet_disable_queue_pair(vi, i);
> +       return err;
>  }
>
>  static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> @@ -2305,11 +2335,8 @@ static int virtnet_close(struct net_device *dev)
>         /* Make sure refill_work doesn't re-enable napi! */
>         cancel_delayed_work_sync(&vi->refill);
>
> -       for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -               virtnet_napi_tx_disable(&vi->sq[i].napi);
> -               napi_disable(&vi->rq[i].napi);
> -               xdp_rxq_info_unreg(&vi->rq[i].xdp_rxq);
> -       }
> +       for (i =3D 0; i < vi->max_queue_pairs; i++)
> +               virtnet_disable_queue_pair(vi, i);
>
>         return 0;
>  }
> --
> 2.37.1 (Apple Git-137.1)
>

