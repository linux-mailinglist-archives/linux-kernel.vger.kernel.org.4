Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1C6BC4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCPDaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCPD3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:29:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEF7A8834
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678937232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DMb/pvY0ifAYDi1mDsSYQA0P+lv6YS8p6Jz5ap0BMTc=;
        b=IJhjE60XtiMNFQ09e9tVaX4EwfgwPB1/ZbaTtnGn6YzeVvbbpOfnGCDKMQlKgOBfJUiFyK
        IL178otD8J7S6N5jkfhOYyzTNoAhlbFivOtC1bOjPMhLTMFZFN0/b24QgWQxYM6mGIB5Re
        ijduXsL8JY/FAeN8LvWBXo3+Gb+XwYI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-gTipI1MnOPKa25o5y_51jg-1; Wed, 15 Mar 2023 23:27:10 -0400
X-MC-Unique: gTipI1MnOPKa25o5y_51jg-1
Received: by mail-pl1-f200.google.com with SMTP id k17-20020a170902d59100b0019abcf45d75so236471plh.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678937229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMb/pvY0ifAYDi1mDsSYQA0P+lv6YS8p6Jz5ap0BMTc=;
        b=hWEyVEyyEZltr0bvUFQPRwoiGMfwNOASAYDPQ3k8SbP1YmVLU91NZLiizSwB9hsl4L
         9YEofXwIZbuFMG4UnayGFlSw7Vhuf4VS7B+7HukhKYPK2nhnkuuQJzBEFNQ9W658yxW2
         Um8Bel9evPIb5MFDZcknC6Pb2geWooNYOQfH8GyrgCRjX751VfagbctiAZ6HrfneEn8r
         qbu9Tc87hq0qMarJN2AJMQoyyC0094ejg8eWdaUTya3Slybwut/gCAknatKsdhg4ZKLX
         MhEiH7dic1Mcwbdzbgh2xtAe4Vz/nJDTr7zOj8KL5yyB6LnvyAR/5SMwFmp1PAU+LCE5
         gRJg==
X-Gm-Message-State: AO0yUKVxLoHUU32uZRq3DYrSk9P/zRLxp/tpjA2YpQTMLOElJ0AflArl
        sr3KkmJZHxd40HSUli1EgzWqNdLNHTkHCbNtgOnfqcwKmOhHlHXozzvOMMfwnSYa0NbwDwG1FQm
        DdvFL+p7Cm2JHUcKk0IMiq6KW
X-Received: by 2002:aa7:9559:0:b0:5a8:cbcc:4b58 with SMTP id w25-20020aa79559000000b005a8cbcc4b58mr1669511pfq.12.1678937229686;
        Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+0MYBlNOJ1EjWFYI+3aCAZeGH+7StNpyaP/qL6fDx88yyfXpqfJL+lUPl3URKvRsQhhHnZ1Q==
X-Received: by 2002:aa7:9559:0:b0:5a8:cbcc:4b58 with SMTP id w25-20020aa79559000000b005a8cbcc4b58mr1669500pfq.12.1678937229315;
        Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
Received: from [10.72.12.40] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b00625c6ca32b0sm1743519pfo.213.2023.03.15.20.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 20:27:09 -0700 (PDT)
Message-ID: <319ece63-ac4f-db05-8a55-65ecad75e437@redhat.com>
Date:   Thu, 16 Mar 2023 11:27:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 02/11] vdpa: Add set/get_vq_affinity callbacks in
 vdpa_config_ops
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230228094110.37-3-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/28 17:41, Xie Yongji 写道:
> This introduces set/get_vq_affinity callbacks in
> vdpa_config_ops to support interrupt affinity
> management for vdpa device drivers.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
>   include/linux/vdpa.h         | 13 +++++++++++++
>   2 files changed, 41 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index d7f5af62ddaa..f72696b4c1c2 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -337,6 +337,32 @@ static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
>   	return dev_name(&vdpa->dev);
>   }
>   
> +static int virtio_vdpa_set_vq_affinity(struct virtqueue *vq,
> +				       const struct cpumask *cpu_mask)
> +{
> +	struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
> +	struct vdpa_device *vdpa = vd_dev->vdpa;
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	unsigned int index = vq->index;
> +
> +	if (ops->set_vq_affinity)
> +		return ops->set_vq_affinity(vdpa, index, cpu_mask);
> +
> +	return 0;
> +}
> +
> +static const struct cpumask *
> +virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
> +{
> +	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +
> +	if (ops->get_vq_affinity)
> +		return ops->get_vq_affinity(vdpa, index);
> +
> +	return NULL;
> +}
> +
>   static const struct virtio_config_ops virtio_vdpa_config_ops = {
>   	.get		= virtio_vdpa_get,
>   	.set		= virtio_vdpa_set,
> @@ -349,6 +375,8 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
>   	.get_features	= virtio_vdpa_get_features,
>   	.finalize_features = virtio_vdpa_finalize_features,
>   	.bus_name	= virtio_vdpa_bus_name,
> +	.set_vq_affinity = virtio_vdpa_set_vq_affinity,
> +	.get_vq_affinity = virtio_vdpa_get_vq_affinity,
>   };
>   
>   static void virtio_vdpa_release_dev(struct device *_d)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 43f59ef10cc9..d61f369f9cd6 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -250,6 +250,15 @@ struct vdpa_map_file {
>    *				@vdev: vdpa device
>    *				Returns the iova range supported by
>    *				the device.
> + * @set_vq_affinity:		Set the irq affinity of virtqueue (optional)


Nit: it's better not mention IRQ here because the virtqueue notification 
is not necessarily backed on IRQ.

Thanks


> + *				@vdev: vdpa device
> + *				@idx: virtqueue index
> + *				@cpu_mask: irq affinity mask
> + *				Returns integer: success (0) or error (< 0)
> + * @get_vq_affinity:		Get the irq affinity of virtqueue (optional)
> + *				@vdev: vdpa device
> + *				@idx: virtqueue index
> + *				Returns the irq affinity mask
>    * @set_group_asid:		Set address space identifier for a
>    *				virtqueue group (optional)
>    *				@vdev: vdpa device
> @@ -340,6 +349,10 @@ struct vdpa_config_ops {
>   			   const void *buf, unsigned int len);
>   	u32 (*get_generation)(struct vdpa_device *vdev);
>   	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +	int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
> +			       const struct cpumask *cpu_mask);
> +	const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
> +						 u16 idx);
>   
>   	/* DMA ops */
>   	int (*set_map)(struct vdpa_device *vdev, unsigned int asid,

