Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0157120A9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjEZHHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbjEZHHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3662910A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685084804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wBejMg+s8pn89tl0WoGSR+vknKwo5Dacmjq+sP5U8E0=;
        b=EpFSkjRlX6FmDjJ6ynaLrsSIA9NHMJTAh7hbJgsnqGUpMmL8MbmoYgcVkWen7BwB48bSj3
        MRzSm3tPAFJjXbR6fxmIXLrgEpvSVvRtVWUbHSfMjmBQgEd9hpjrjXOASIJDMvY7IZSFo3
        wRnFQL2fmxKoPogcWcLWxZveUoo+ZLo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-w-d3tkG9Noa7iENz06GXSA-1; Fri, 26 May 2023 03:06:42 -0400
X-MC-Unique: w-d3tkG9Noa7iENz06GXSA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af25454033so1647041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685084801; x=1687676801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBejMg+s8pn89tl0WoGSR+vknKwo5Dacmjq+sP5U8E0=;
        b=H/lrtfQDgIOozY9tWrrZjsQ30zCv9IlvBVffrxnCxDWdm/fPjTuDQJRohMAgJYNXip
         EQOKgJe9g8ld8Gunw4DDtxfnEKCdXKFVu+VgSXA8GJ+7Y2SLpAOF9nA4aXwZf9Wy225M
         DQRAyNbQeugJTWjJx4AMYffp32FiXbaiKsHJeT30+ddeCh7DmZULDKFdFM46ng0goLNh
         EO1OsFE/1Wge5UfCNkIhwvBQu7kEozAIIO2+ATAEqujHDpa6pwaxjtcQEqNcvk4W0imh
         7bSp85k8z7zUFzLRyIdJAIRRcgrF4APwQ9LTnmTIN3ywS9fLjv0qf6PRbt6s9TVshXPv
         zFRQ==
X-Gm-Message-State: AC+VfDxAthzr/zKq3Gz5dh8VYOunqEzHLsTYQt9jqkL0cRDeIwSfaZTw
        mo+axrLqf+5qYsVM00P4mPluUNTYGmMhSWEsLW/jDgIKIc2T22NmOJJTm6IsEaZprOVmOaIyku5
        Qwptmo3iYFUxjI/1HeptM39IrBqNtBClafKnt1qN0
X-Received: by 2002:a2e:7817:0:b0:2ac:8c5e:e151 with SMTP id t23-20020a2e7817000000b002ac8c5ee151mr451668ljc.31.1685084801112;
        Fri, 26 May 2023 00:06:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6sHDrHvdUXjE/f4RLyIFJiZ9+BIhhYVMPihHPnwvEGGl1gTbFH1d/Kkjl1jRuizOa84yxiFWZP2XxBPAfuKMg=
X-Received: by 2002:a2e:7817:0:b0:2ac:8c5e:e151 with SMTP id
 t23-20020a2e7817000000b002ac8c5ee151mr451649ljc.31.1685084800799; Fri, 26 May
 2023 00:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230526054621.18371-1-liangchen.linux@gmail.com> <20230526054621.18371-5-liangchen.linux@gmail.com>
In-Reply-To: <20230526054621.18371-5-liangchen.linux@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 26 May 2023 15:06:29 +0800
Message-ID: <CACGkMEsrr-3ArBgCksq=c60+5fZ-Xc-i653ix_vdr2f7c7wYfg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/5] virtio_net: Implement DMA pre-handler
To:     Liang Chen <liangchen.linux@gmail.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, kuba@kernel.org, edumazet@google.com,
        davem@davemloft.net, pabeni@redhat.com, alexander.duyck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 1:47=E2=80=AFPM Liang Chen <liangchen.linux@gmail.c=
om> wrote:
>
> Adding a DMA pre-handler that utilizes page pool for managing DMA mapping=
s.
> When IOMMU is enabled, turning on the page_pool_dma_map module parameter =
to
> select page pool for DMA mapping management gives a significant reduction
> in the overhead caused by DMA mappings.
>
> In testing environments with a single core vm and qemu emulated IOMMU,
> significant performance improvements can be observed:
>   Upstream codebase: 1.76 Gbits/sec
>   Upstream codebase with page pool fragmentation support: 1.81 Gbits/sec
>   Upstream codebase with page pool fragmentation and DMA support: 19.3
>   Gbits/sec
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---
>  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index ac40b8c66c59..73cc4f9fe4fa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -22,6 +22,7 @@
>  #include <net/route.h>
>  #include <net/xdp.h>
>  #include <net/net_failover.h>
> +#include <linux/iommu.h>
>
>  static int napi_weight =3D NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -33,8 +34,10 @@ module_param(napi_tx, bool, 0644);
>
>  static bool page_pool_enabled;
>  static bool page_pool_frag;
> +static bool page_pool_dma_map;
>  module_param(page_pool_enabled, bool, 0400);
>  module_param(page_pool_frag, bool, 0400);
> +module_param(page_pool_dma_map, bool, 0400);
>
>  /* FIXME: MTU in config. */
>  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> @@ -3830,6 +3833,49 @@ static void virtnet_del_vqs(struct virtnet_info *v=
i)
>         virtnet_free_queues(vi);
>  }
>
> +static dma_addr_t virtnet_pp_dma_map_page(struct device *dev, struct pag=
e *page,
> +                                         unsigned long offset, size_t si=
ze,
> +                                         enum dma_data_direction dir, un=
signed long attrs)
> +{
> +       struct page *head_page;
> +
> +       if (dir !=3D DMA_FROM_DEVICE)
> +               return 0;
> +
> +       head_page =3D compound_head(page);
> +       return page_pool_get_dma_addr(head_page)
> +               + (page - head_page) * PAGE_SIZE
> +               + offset;

So it's not a map, it is just a query from the dma address from the pool.

> +}
> +
> +static bool virtnet_pp_dma_unmap_page(struct device *dev, dma_addr_t dma=
_handle,
> +                                     size_t size, enum dma_data_directio=
n dir,
> +                                     unsigned long attrs)
> +{
> +       phys_addr_t phys;
> +
> +       /* Handle only the RX direction, and sync the DMA memory only if =
it's not
> +        * a DMA coherent architecture.
> +        */
> +       if (dir !=3D DMA_FROM_DEVICE)
> +               return false;
> +
> +       if (dev_is_dma_coherent(dev))
> +               return true;
> +
> +       phys =3D iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle=
);

This would be somehow slow. If we track the mapping by driver, it
would be much faster.

More could be seen here:

https://lists.linuxfoundation.org/pipermail/virtualization/2023-May/066778.=
html

Thanks

> +       if (WARN_ON(!phys))
> +               return false;
> +
> +       arch_sync_dma_for_cpu(phys, size, dir);
> +       return true;
> +}
> +
> +static struct virtqueue_pre_dma_ops virtnet_pp_pre_dma_ops =3D {
> +       .map_page =3D virtnet_pp_dma_map_page,
> +       .unmap_page =3D virtnet_pp_dma_unmap_page,
> +};
> +
>  static void virtnet_alloc_page_pool(struct receive_queue *rq)
>  {
>         struct virtio_device *vdev =3D rq->vq->vdev;
> @@ -3845,6 +3891,15 @@ static void virtnet_alloc_page_pool(struct receive=
_queue *rq)
>         if (page_pool_frag)
>                 pp_params.flags |=3D PP_FLAG_PAGE_FRAG;
>
> +       /* Consider using page pool DMA support only when DMA API is used=
. */
> +       if (virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM) &&
> +           page_pool_dma_map) {
> +               pp_params.flags |=3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_D=
EV;
> +               pp_params.dma_dir =3D DMA_FROM_DEVICE;
> +               pp_params.max_len =3D PAGE_SIZE << pp_params.order;
> +               virtqueue_register_pre_dma_ops(rq->vq, &virtnet_pp_pre_dm=
a_ops);
> +       }
> +
>         rq->page_pool =3D page_pool_create(&pp_params);
>         if (IS_ERR(rq->page_pool)) {
>                 dev_warn(&vdev->dev, "page pool creation failed: %ld\n",
> --
> 2.31.1
>

