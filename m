Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7994D6FD481
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEJDl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEJDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0F45588
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683690001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ilszrs00TODsaAhkjjmVgACd8lBO14dcaz8No+ER70=;
        b=EVoevbxceq6Qz3rGYBYF6tcJypjrAkCWJwpTFy6Sf27SiNbVrg0ofd8cQGXm9WhSiGZOte
        okF0R9hNP25r+bna7hy8DdTA9MLm2tYgbOK03HHEhe3oRguDZCCnCXLWdIarAzwDtw/ge1
        3ADD0yPTPOPSRt9KLneKQS15gZvmwx4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-LbEBN-BLNc6xUrm83k7zOQ-1; Tue, 09 May 2023 23:39:59 -0400
X-MC-Unique: LbEBN-BLNc6xUrm83k7zOQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50be1a285dcso6303684a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683689998; x=1686281998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ilszrs00TODsaAhkjjmVgACd8lBO14dcaz8No+ER70=;
        b=UgQLtNzTjor0WfhMnYN4Y8k9+zkAvx/Jqiak8nS7kH3lb0uCj7vF3ElqCNL/5dwCfb
         F/gAgpdm8kRpc9tWsHrhl0gvAr8VWaXQi+pclj9XABv8zshDp8JpIAsC7wIZVS7snuE7
         01JDGVmLaCy2fy36qCpCupJ2EV+hpEcpmPc7QAWftyDFPcD84SpL3ShaPQ3OJ7SdQp6z
         +0lwrCW4p6duYNQxTas3BVGmQYZjhODpNZC27/g96RTjNT2GB5nDtH2ofTg57FSPF8VY
         vYj3RYKd8o7miec2t6S2MRmNAImMQ37ws6LfgGp1CQfYGbafFaA+iilAk3Abrb6YcF5L
         NNmw==
X-Gm-Message-State: AC+VfDxj2O0yMy61agBFh+VX5t+g+LYTEy51cgHjnTjbYEh4HsGP3S1V
        rdoGH7LUr8fC6xyEN4gPfDV8hFJCx2AzUYm4XlZ7re86s6DVW3oTe3Svnd93H/k6YNSvU66mL0X
        1eoegkAOmspJ0lFFFlxLJkcu/
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id gs31-20020a1709072d1f00b00968db2f0383mr7058384ejc.53.1683689998606;
        Tue, 09 May 2023 20:39:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6e4C3/BG6wV/XTr+xIJQUwTiA+N8VWNnD508NvKQeOAB5vhL+ur2ZiXI2EQ+4DxWmFekJGWw==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id gs31-20020a1709072d1f00b00968db2f0383mr7058374ejc.53.1683689998334;
        Tue, 09 May 2023 20:39:58 -0700 (PDT)
Received: from redhat.com ([176.119.195.36])
        by smtp.gmail.com with ESMTPSA id jx27-20020a170907761b00b0094a82a236cbsm2090991ejc.129.2023.05.09.20.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:39:57 -0700 (PDT)
Date:   Tue, 9 May 2023 23:39:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230509233929-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


is this a theoretical concern or do you manage to trigger this
somehow?

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

