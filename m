Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9FD746989
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGDGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGDGWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED22B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688451691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t2SmXZgFnQoS+yb8OXdLl/MHZWbEhLAa6pjpmlK+v+w=;
        b=KIbcH1ytBcLRCoBJoTE+d1Ws9TPaHd+B5yt3dvYvJGNX9EBT1TkHURSnTZD/UzB8TnxVKK
        h9y+towNeBjOeQWAxdvURSrIZ6FCKHjAMMX2a5tk1AWwHeIk/+HGAzjklWqBTR1JcPhsYb
        CPq+MciP7h8oJbUC2Q+DZIyvCuHFS9U=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-3Ix_jajEONi7lCs-Q1OPIw-1; Tue, 04 Jul 2023 02:21:30 -0400
X-MC-Unique: 3Ix_jajEONi7lCs-Q1OPIw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d6cso4831279e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688451688; x=1691043688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2SmXZgFnQoS+yb8OXdLl/MHZWbEhLAa6pjpmlK+v+w=;
        b=dMLqaiMkCY8ygs+UWl3DbnKvdgvazA3WRzZimKYJhCslo2nDZ7wffPwWX2VLVyWv++
         Gx2FNydGqd0aKkjsTtWURIL3udTqAz0yejSFic1Whbmyf+JxqKkeeapnNR9VikKWBAFR
         sG0HmzuIVivm1uubzm0T3Qaa045CT6buRa5iSrxLk/41LASHtx76nXDhznjZ7fe8QrIw
         J2iapwejEl00gRwDMZ4mmTREU6SsX1CXnXj6FVn7htyOVYUp7jlHlJj8fhgtgQD3PmS9
         VezotJ2yZpthrFlvStyHIi7ntu24Zx8zCuu/n2jfQVAHRO1FLd7l8AzVBcjzIV9uDiSE
         zkUg==
X-Gm-Message-State: ABy/qLZXkD5dJvChitUSyjSBgH/EDvu3ohEyN7lPk6WGgpmspHa/9riN
        wg/Y6WBv6oAQcNy7q3qh3xpjG1emzlbfOdUG2wS2J1K4xvE8/A37s6tbSERRnKSo/FR0RgJCyY2
        vT8FuMRPVsOerjPaXlVoDl4y01eNpXZiv
X-Received: by 2002:a05:6512:33cc:b0:4fb:b615:db86 with SMTP id d12-20020a05651233cc00b004fbb615db86mr3240703lfg.7.1688451687935;
        Mon, 03 Jul 2023 23:21:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZbp4Q7VCGaFmAbp91XFT3IMGNINf29kUoORnN3loVxMj1PI0PC3Zl+hj4x6WbClnPSWkp9Q==
X-Received: by 2002:a05:6512:33cc:b0:4fb:b615:db86 with SMTP id d12-20020a05651233cc00b004fbb615db86mr3240681lfg.7.1688451687544;
        Mon, 03 Jul 2023 23:21:27 -0700 (PDT)
Received: from redhat.com ([2.52.13.33])
        by smtp.gmail.com with ESMTPSA id k16-20020a7bc410000000b003fbc9b9699dsm10663856wmi.45.2023.07.03.23.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:21:26 -0700 (PDT)
Date:   Tue, 4 Jul 2023 02:21:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230704020935-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:54:37AM +0800, zhenwei pi wrote:
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

Took a while for me to get this, it's confusing.  I think the issue is
really in virtio blk, so I would just change max_size there to size_t
and be done with it.




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

