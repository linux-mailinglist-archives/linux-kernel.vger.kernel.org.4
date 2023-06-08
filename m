Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203387288EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjFHTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbjFHTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3362113
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 12:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686253504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JmF/x59Qx/JvKg/Xn0EqjpftmVd313DRoIAQfS/rxFs=;
        b=G4hJSKEL9AzdmzFSKKSae/kNbzCdqYCC6Nn4ZVlhsAFrq0mUVr/kefoXly+CBxPx5sAVVT
        zVXJREEVgisgb8MqZkwPei6R6hZ6iTYtOeXAQ+r7e62S5XCOvWyowfQvwNLPxivtmclY9B
        PZVZI2UTAKlVCeAZ6MEkHD75YExaE7I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-JvfFcnj1NmiQFdOQ8x0Xbg-1; Thu, 08 Jun 2023 15:45:02 -0400
X-MC-Unique: JvfFcnj1NmiQFdOQ8x0Xbg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-97463348446so118596766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253501; x=1688845501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmF/x59Qx/JvKg/Xn0EqjpftmVd313DRoIAQfS/rxFs=;
        b=bycyRB5SxaMb2v/0hrsEVwnyepPh/pDkBrQXQvcqRsK7RCd3ZpHxOMc4c0ABSrO7lA
         LXy3TX/NgLuGoxFb3DPSmjKVkXXS5h9vVqev54Ce+rBEhHNPOiL+UKLpetrQn253ZmCZ
         vU31jZzEWUqJTdsRXdlMcS4iCwa1m4AEbfC+9/83PFIi8jyTjo1VGetYLGOfBz3SZpJe
         s0YFhklHrgERgfPXBT55iemcGxqG/pqXkRSKWrPSB4xbvLPrONmExCpDLZopotCOZLYI
         qdsWCcbRxesoSqhrbHsEjnw8sz51UFuY9sbv35X628c4x7gYUCIEqPMcSVCtVfBpTriO
         W/zA==
X-Gm-Message-State: AC+VfDy4wnF5LuTIohKJjXYxyOnSWayqN5g8/LINswpsDMUTInJb7lfr
        +JnviaWa0HxUuLKjgYr7HIDjbv5B/lA7Rr4NqtZn2TPpToiMBAUbF1TFV4qMX5PnrenXJfuaqNC
        pFbotr02hJECX1QUTOf4CZ59iqgsmqaQ9
X-Received: by 2002:a17:907:6ea1:b0:969:bac4:8e22 with SMTP id sh33-20020a1709076ea100b00969bac48e22mr190956ejc.26.1686253501284;
        Thu, 08 Jun 2023 12:45:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ638uv4/Vr+tj9RPa/sHzhVcwrauzcttV3G6j2YKZTAjolaDA5VYvQTw6KbxvqJuZQOjZ3t1g==
X-Received: by 2002:a17:907:6ea1:b0:969:bac4:8e22 with SMTP id sh33-20020a1709076ea100b00969bac48e22mr190943ejc.26.1686253501017;
        Thu, 08 Jun 2023 12:45:01 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c235100b003f7f475c3c7sm534780wmq.8.2023.06.08.12.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:45:00 -0700 (PDT)
Date:   Thu, 8 Jun 2023 15:44:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vdpa/vp_vdpa: Check queue number of vdpa device from
 add_config
Message-ID: <20230608154400-mutt-send-email-mst@kernel.org>
References: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608090124.1807-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 05:01:24PM +0800, Angus Chen wrote:
> When add virtio_pci vdpa device,check the vqs number of device cap
> and max_vq_pairs from add_config.
> Simply starting from failing if the provisioned #qp is not
> equal to the one that hardware has.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

I am not sure about this one. How does userspace know
which values are legal?

If there's no way then maybe we should just cap the value
to what device can support but otherwise keep the device
working.

> ---
> v1: Use max_vqs from add_config
> v2: Just return fail if max_vqs from add_config is not same as device
> 	cap. Suggested by jason.
> 
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 35 ++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 281287fae89f..c1fb6963da12 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -480,32 +480,39 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	u64 device_features;
>  	int ret, i;
>  
> -	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> -				    dev, &vp_vdpa_ops, 1, 1, name, false);
> -
> -	if (IS_ERR(vp_vdpa)) {
> -		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> -		return PTR_ERR(vp_vdpa);
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP)) {
> +		if (add_config->net.max_vq_pairs != (v_mdev->max_supported_vqs / 2)) {
> +			dev_err(&pdev->dev, "max vqs 0x%x should be equal to 0x%x which device has\n",
> +				add_config->net.max_vq_pairs*2, v_mdev->max_supported_vqs);
> +			return -EINVAL;
> +		}
>  	}
>  
> -	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> -
> -	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> -	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
> -	vp_vdpa->mdev = mdev;
> -
>  	device_features = vp_modern_get_features(mdev);
>  	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
>  		if (add_config->device_features & ~device_features) {
> -			ret = -EINVAL;
>  			dev_err(&pdev->dev, "Try to provision features "
>  				"that are not supported by the device: "
>  				"device_features 0x%llx provisioned 0x%llx\n",
>  				device_features, add_config->device_features);
> -			goto err;
> +			return -EINVAL;
>  		}
>  		device_features = add_config->device_features;
>  	}
> +
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> +				    dev, &vp_vdpa_ops, 1, 1, name, false);
> +
> +	if (IS_ERR(vp_vdpa)) {
> +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> +		return PTR_ERR(vp_vdpa);
> +	}
> +
> +	vp_vdpa_mgtdev->vp_vdpa = vp_vdpa;
> +
> +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> +	vp_vdpa->queues = v_mdev->max_supported_vqs;
> +	vp_vdpa->mdev = mdev;
>  	vp_vdpa->device_features = device_features;
>  
>  	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
> -- 
> 2.25.1

