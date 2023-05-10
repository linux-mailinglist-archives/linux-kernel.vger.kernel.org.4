Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40896FD446
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEJDaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjEJD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:29:59 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B0391
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:29:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ViDxAvy_1683689393;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0ViDxAvy_1683689393)
          by smtp.aliyun-inc.com;
          Wed, 10 May 2023 11:29:54 +0800
Message-ID: <1683689214.9647853-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Date:   Wed, 10 May 2023 11:26:54 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>,
        Joerg Roedel <jroedel@suse.de>, mst@redhat.com,
        jasowang@redhat.com
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
In-Reply-To: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 10:54:37 +0800, zhenwei pi <pizhenwei@bytedance.com> wrote:
> Both split ring and packed ring use 32bits to describe the length of
> a descriptor: see struct vring_desc and struct vring_packed_desc.
> This means the max segment size supported by virtio is U32_MAX.
>
> An example of virtio_max_dma_size in virtio_blk.c:
>   u32 v, max_size;
>
>   max_size = virtio_max_dma_size(vdev);  -> implicit convert
>   err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>                              struct virtio_blk_config, size_max, &v);
>   max_size = min(max_size, v);
>
> There is a risk during implicit convert here, once virtio_max_dma_size
> returns 4G, max_size becomes 0.
>
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++++----
>  include/linux/virtio.h       |  2 +-
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..55cfecf030a1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>  	return false;
>  }
>
> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> +u32 virtio_max_dma_size(const struct virtio_device *vdev)


LGTM

But, should we change the parameter to vq, then use the dma_dev?

@Jason

Thanks.


>  {
> -	size_t max_segment_size = SIZE_MAX;
> +	u32 max_segment_size = U32_MAX;
>
> -	if (vring_use_dma_api(vdev))
> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> +	if (vring_use_dma_api(vdev)) {
> +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
> +
> +		if (max_dma_size < max_segment_size)
> +			max_segment_size = max_dma_size;
> +	}
>
>  	return max_segment_size;
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..1a605f408329 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>  #endif
>  void virtio_reset_device(struct virtio_device *dev);
>
> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>
>  #define virtio_device_for_each_vq(vdev, vq) \
>  	list_for_each_entry(vq, &vdev->vqs, list)
> --
> 2.20.1
>
