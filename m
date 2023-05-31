Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361EE718090
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbjEaM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbjEaM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE19192
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685537696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ygumGN7X55a4YT6OXk5KW6eBqJUAFJLGuz5I8swlOKo=;
        b=CnV8glpbU74MnqEso3qjjBbkMaTwLA4SjEFKmwA9lEoW2ozY5y0DCv5NuueXucpx790KvK
        Ag4p3z2mI3kti741p9/EbgPmT/s5oegHqjdI5MwjjHQCyPXZtnDMevaUBkR6TXijh3cCwN
        uzD6AsO5JPmOVMTEeTYDbgIRGVRS6Ak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-uL-J-k3SN4eJADROjXuaEA-1; Wed, 31 May 2023 08:54:54 -0400
X-MC-Unique: uL-J-k3SN4eJADROjXuaEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f6fa88a86bso25764305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685537693; x=1688129693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygumGN7X55a4YT6OXk5KW6eBqJUAFJLGuz5I8swlOKo=;
        b=O7ebd8MN2Xjqd8vbfBsFfHwS9HOm9nFuaQxcMlOs1d1JclGYiFTB7/BxhTf76GVqWK
         ZKdNQjSd89uPJ+zAfNgOe0juDiiCb8O0nruUZsLbO59ndRJcZ8LYf81hVenvPwFjYrBx
         gOQdlAU07NSEQADm2bYYUGwbX5aKrVYfLKOiXtDIJ//PFfNSjqwsM14vDka9Ec7WyoIe
         ypBBlqS9PfKnevumyQnM0FWUaL82+k6wI5yzSediGx6IkOj+gwV9PkGro8UnY3HjhbjV
         +GC62xcLGntK6E0sUKmfIKMbwqjMQlTqACRCSUgdre6aom11WUjcu63QonNV6bBiUCWJ
         AMCg==
X-Gm-Message-State: AC+VfDzIdV4m2M2DLuZvj0Z2kzCUT0DbHewOOD9NH1DABpOZQskIGQVk
        vljFDQd4rRpE1CsECl9Iikxw5JmlqL0+7XJw4uxtl8zTLXyS3FoAPUrJpZA/6fF3Mbckvb3Vy/d
        6xvMKSSTIo9YPFdVWnFasT6Av
X-Received: by 2002:a7b:c443:0:b0:3f6:d2c:13f2 with SMTP id l3-20020a7bc443000000b003f60d2c13f2mr3633049wmi.41.1685537693631;
        Wed, 31 May 2023 05:54:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53y3nHkEIs9gDQuKrVRGMfK7+9RTjlLyqmreSuJWMiVwoz/K5Dscg26XcfN5rtozVUWxREew==
X-Received: by 2002:a7b:c443:0:b0:3f6:d2c:13f2 with SMTP id l3-20020a7bc443000000b003f60d2c13f2mr3633034wmi.41.1685537693348;
        Wed, 31 May 2023 05:54:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id n26-20020a7bcbda000000b003f60482024fsm20807853wmi.30.2023.05.31.05.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:54:52 -0700 (PDT)
Message-ID: <ee46966a-920a-37f6-9554-b2b10565cd58@redhat.com>
Date:   Wed, 31 May 2023 14:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] vfio: ap: realize the VFIO_DEVICE_GET_IRQ_INFO ioctl
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, alex.williamson@redhat.com,
        borntraeger@linux.ibm.com
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
 <20230530223538.279198-2-akrowiak@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230530223538.279198-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 00:35, Tony Krowiak wrote:
> Realize the VFIO_DEVICE_GET_IRQ_INFO ioctl to retrieve the information for
> the VFIO device request IRQ.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 30 +++++++++++++++++++++++++++++-
>   include/uapi/linux/vfio.h         |  9 +++++++++
>   2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index cfbcb864ab63..35cd90eee937 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -1750,7 +1750,32 @@ static int vfio_ap_mdev_get_device_info(unsigned long arg)
>   
>   	info.flags = VFIO_DEVICE_FLAGS_AP | VFIO_DEVICE_FLAGS_RESET;
>   	info.num_regions = 0;
> -	info.num_irqs = 0;
> +	info.num_irqs = VFIO_AP_NUM_IRQS;
> +
> +	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
> +}
> +
> +static ssize_t vfio_ap_get_irq_info(unsigned long arg)
> +{
> +	unsigned long minsz;
> +	struct vfio_irq_info info;
> +
> +	minsz = offsetofend(struct vfio_irq_info, count);
> +
> +	if (copy_from_user(&info, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz || info.index >= VFIO_AP_NUM_IRQS)
> +		return -EINVAL;
> +
> +	switch (info.index) {
> +	case VFIO_AP_REQ_IRQ_INDEX:
> +		info.count = 1;
> +		info.flags = VFIO_IRQ_INFO_EVENTFD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>   
>   	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
>   }
> @@ -1770,6 +1795,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   	case VFIO_DEVICE_RESET:
>   		ret = vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
>   		break;
> +	case VFIO_DEVICE_GET_IRQ_INFO:
> +			ret = vfio_ap_get_irq_info(arg);
> +			break;
>   	default:
>   		ret = -EOPNOTSUPP;
>   		break;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 0552e8dcf0cb..b71276bd7f91 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -646,6 +646,15 @@ enum {
>   	VFIO_CCW_NUM_IRQS
>   };
>   
> +/*
> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
> + * Unimplemented IRQ types return a count of zero.
> + */
> +enum {
> +	VFIO_AP_REQ_IRQ_INDEX,
> +	VFIO_AP_NUM_IRQS
> +};
> +
>   /**
>    * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>    *					      struct vfio_pci_hot_reset_info)

