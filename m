Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB9A7180FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEaNHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjEaNGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532081BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685538246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PSBduxGtsm2MEmSpcOZQSh7OwRHd+hUlMMKZIR9jjYY=;
        b=VSoP3H2hH772hnjDTG5HYXO3prCPMZquQAffxV932BtabqPqQqi7pOTHhu5vzOctMKcNXU
        HzeINmXSyVbC2tq1H8k0CCHq2ETKQFnNhqM7qQpJ2Ulfybm76FMBDrghQvR/sPUZIBPoo6
        KCvbqZ/5vcdLGPai6JDFZmKOCRN5kAw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-WitTnVzqO0Kb_3mVfFcWTQ-1; Wed, 31 May 2023 09:00:57 -0400
X-MC-Unique: WitTnVzqO0Kb_3mVfFcWTQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f4b2a2040bso3245624e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 06:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685538055; x=1688130055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSBduxGtsm2MEmSpcOZQSh7OwRHd+hUlMMKZIR9jjYY=;
        b=Ejh8Yg14fcuTz6zldcaAoheDbyh1sAX3Zis8gWfgHEWgau0GYOfr2E3rzBmtdWrJd3
         BFTE4Kn4ulCaicesgzi5f633ISX7X65pJuDDHJDjSy8sUIMCjTcEbDskUIEwBR6VEfwU
         pNpW4JSkGQpgn8QEqxIQI1tArde3gKCeo/3oLeV54e9j7wKUSb0dhUGZT7lZMJoVHE4i
         pwLfg1XSC7eAq59rprA9b4xyvHOvexGsfRFQBjfKKE8A0/7eEM13zJR6sw+1/bMUFklO
         6fVAKl81zgdnFSuZBXiRfJp6r/gSzKXUFGzMMUevM8k9Xusr4x12CnxQU9rMVTrVjoeJ
         8tRw==
X-Gm-Message-State: AC+VfDzJo/ajrYxZP5yEFvbAqWUB3wvZz2al+0cQ2pR7N69+IcSGs0pY
        1DAfEtEDSgyQ0DUE2gb9OxTKNSufQVnGqkR20b2WIqghcSmfA92Mro/xEshFG79pozN2i/jPXRO
        4zRfPnYqa3HD96mE7OudUNQnG
X-Received: by 2002:a19:f706:0:b0:4f3:afcc:e1bb with SMTP id z6-20020a19f706000000b004f3afcce1bbmr2506638lfe.1.1685538055583;
        Wed, 31 May 2023 06:00:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4X5heEzDVAgDXESc8S00jql9lpk8+il95sYPpeYIQ7zDqLSUQdHoOzFNrSLcA+8TneaIs3dg==
X-Received: by 2002:a19:f706:0:b0:4f3:afcc:e1bb with SMTP id z6-20020a19f706000000b004f3afcce1bbmr2506613lfe.1.1685538055212;
        Wed, 31 May 2023 06:00:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0? ([2a01:e0a:280:24f0:eb4a:c9d8:c8bb:c0b0])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c27ca00b003f50d6ee334sm20733324wmb.47.2023.05.31.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 06:00:54 -0700 (PDT)
Message-ID: <ea82efce-8dc4-9633-ce3b-51ec2c26efce@redhat.com>
Date:   Wed, 31 May 2023 15:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] vfio: ap: realize the VFIO_DEVICE_SET_IRQS ioctl
Content-Language: en-US
To:     Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
        mjrosato@linux.ibm.com, alex.williamson@redhat.com,
        borntraeger@linux.ibm.com
References: <20230530223538.279198-1-akrowiak@linux.ibm.com>
 <20230530223538.279198-3-akrowiak@linux.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230530223538.279198-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 00:35, Tony Krowiak wrote:
> Realize the VFIO_DEVICE_SET_IRQS ioctl to set an eventfd file descriptor
> to be used by the vfio_ap device driver to signal a device request to
> userspace.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 83 +++++++++++++++++++++++++++
>   drivers/s390/crypto/vfio_ap_private.h |  3 +
>   2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 35cd90eee937..44f159136891 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -716,6 +716,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
>   	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
>   	if (ret)
>   		goto err_put_vdev;
> +	matrix_mdev->req_trigger = NULL;
>   	dev_set_drvdata(&mdev->dev, matrix_mdev);
>   	mutex_lock(&matrix_dev->mdevs_lock);
>   	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> @@ -1780,6 +1781,85 @@ static ssize_t vfio_ap_get_irq_info(unsigned long arg)
>   	return copy_to_user((void __user *)arg, &info, minsz) ? -EFAULT : 0;
>   }
>   
> +static int vfio_ap_irq_set_init(struct vfio_irq_set *irq_set, unsigned long arg)
> +{
> +	int ret;
> +	size_t data_size;
> +	unsigned long minsz;
> +
> +	minsz = offsetofend(struct vfio_irq_set, count);
> +
> +	if (copy_from_user(irq_set, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	ret = vfio_set_irqs_validate_and_prepare(irq_set, 1, VFIO_AP_NUM_IRQS,
> +						 &data_size);
> +	if (ret)
> +		return ret;
> +
> +	if (!(irq_set->flags & VFIO_IRQ_SET_ACTION_TRIGGER))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_set_request_irq(struct ap_matrix_mdev *matrix_mdev,
> +				   unsigned long arg)
> +{
> +	s32 fd;
> +	void __user *data;
> +	unsigned long minsz;
> +	struct eventfd_ctx *req_trigger;
> +
> +	minsz = offsetofend(struct vfio_irq_set, count);
> +	data = (void __user *)(arg + minsz);
> +
> +	if (get_user(fd, (s32 __user *)data))
> +		return -EFAULT;
> +
> +	if (fd == -1) {
> +		if (matrix_mdev->req_trigger)
> +			eventfd_ctx_put(matrix_mdev->req_trigger);
> +		matrix_mdev->req_trigger = NULL;
> +	} else if (fd >= 0) {
> +		req_trigger = eventfd_ctx_fdget(fd);
> +		if (IS_ERR(req_trigger))
> +			return PTR_ERR(req_trigger);
> +
> +		if (matrix_mdev->req_trigger)
> +			eventfd_ctx_put(matrix_mdev->req_trigger);
> +
> +		matrix_mdev->req_trigger = req_trigger;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vfio_ap_set_irqs(struct ap_matrix_mdev *matrix_mdev,
> +			    unsigned long arg)
> +{
> +	int ret;
> +	struct vfio_irq_set irq_set;
> +
> +	ret = vfio_ap_irq_set_init(&irq_set, arg);
> +	if (ret)
> +		return ret;
> +
> +	switch (irq_set.flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
> +	case VFIO_IRQ_SET_DATA_EVENTFD:
> +		switch (irq_set.index) {
> +		case VFIO_AP_REQ_IRQ_INDEX:
> +			return vfio_ap_set_request_irq(matrix_mdev, arg);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   				    unsigned int cmd, unsigned long arg)
>   {
> @@ -1798,6 +1878,9 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   	case VFIO_DEVICE_GET_IRQ_INFO:
>   			ret = vfio_ap_get_irq_info(arg);
>   			break;
> +	case VFIO_DEVICE_SET_IRQS:
> +		ret = vfio_ap_set_irqs(matrix_mdev, arg);
> +		break;
>   	default:
>   		ret = -EOPNOTSUPP;
>   		break;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 976a65f32e7d..4642bbdbd1b2 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -15,6 +15,7 @@
>   #include <linux/types.h>
>   #include <linux/mdev.h>
>   #include <linux/delay.h>
> +#include <linux/eventfd.h>
>   #include <linux/mutex.h>
>   #include <linux/kvm_host.h>
>   #include <linux/vfio.h>
> @@ -103,6 +104,7 @@ struct ap_queue_table {
>    *		PQAP(AQIC) instruction.
>    * @mdev:	the mediated device
>    * @qtable:	table of queues (struct vfio_ap_queue) assigned to the mdev
> + * @req_trigger eventfd ctx for signaling userspace to return a device
>    * @apm_add:	bitmap of APIDs added to the host's AP configuration
>    * @aqm_add:	bitmap of APQIs added to the host's AP configuration
>    * @adm_add:	bitmap of control domain numbers added to the host's AP
> @@ -117,6 +119,7 @@ struct ap_matrix_mdev {
>   	crypto_hook pqap_hook;
>   	struct mdev_device *mdev;
>   	struct ap_queue_table qtable;
> +	struct eventfd_ctx *req_trigger;
>   	DECLARE_BITMAP(apm_add, AP_DEVICES);
>   	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
>   	DECLARE_BITMAP(adm_add, AP_DOMAINS);

