Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD906BCA49
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCPJEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjCPJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EBB0BB0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678957417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdJ8Y1XHTgO3uSrSuh+S9p0Fmd6LCjxdCQqaxSjozfE=;
        b=U63T1bBejwe4LzSi52djUaf9D8WZShghlHC9vJaOgayJy2GRd9lJfJjcYOTMFG5y1figA3
        gz0Jg1l6eRe+tUG2h80h46TAZJEvtegYWK0gFUqVaZZXviYiNy8i6ssX7D8GbTkrlpU1zZ
        gVXgzWrSFnc3S/B307aDpJ8Hd8R8D58=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-8A7oaU9VOayz1C2oVOvPRw-1; Thu, 16 Mar 2023 05:03:36 -0400
X-MC-Unique: 8A7oaU9VOayz1C2oVOvPRw-1
Received: by mail-pf1-f197.google.com with SMTP id n22-20020a62e516000000b0062262d6ed76so795677pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678957415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QdJ8Y1XHTgO3uSrSuh+S9p0Fmd6LCjxdCQqaxSjozfE=;
        b=BdwCvApqYA7PZhKanT41j633Z0bvmjJz2zn79zMfQdV6X5O40zd1uncFLasEx14MG8
         DIiBbQbpl/Je9+1mEvg0RjWQ4iuHvQTpbG23fjpQsb0lo/c56bVSKwBWz0OtNMEb+gI3
         CpLfvPKElzpLzM2U5xVABppiC/y1TseY632BZMcmYgT2GRlVpve17P/qkhLgLgVUZ5GP
         EHBYm1gfGT9UCS0nSMjiIHb7L2FyJ2DS5hcN7EwF0kJidvbhJ8gBoErCQ/f7DFBr7hhw
         9acWE/V+yIfwI50U9L8ouKo18D9rHK/Djb2NQY0lvcqwCg7JsoLg+fQDqs4s2UOKM/sP
         VNxg==
X-Gm-Message-State: AO0yUKUnb96eoLzQ9Uk32mAVT17C1ilElqeZrXFexm8X/onRY6Q3bTDY
        soYYUYHzbUqBan7FFEGuI2+f5yGCQN36+qgcD+TYqCl9PcdzdlHliYz1kPH00fm7YRt+1upoNpc
        58FmqJBTvy9oWdPxjLbTsDBA/
X-Received: by 2002:a17:903:5cd:b0:1a1:9536:c6cd with SMTP id kf13-20020a17090305cd00b001a19536c6cdmr707985plb.10.1678957415241;
        Thu, 16 Mar 2023 02:03:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set9Iw6mDMbKmVlfPGahx7BZgJ6prbpHj3HPQtVeMnYSn/MlFXzaO0C/kqHWpB8yhi41LBR7EWQ==
X-Received: by 2002:a17:903:5cd:b0:1a1:9536:c6cd with SMTP id kf13-20020a17090305cd00b001a19536c6cdmr707967plb.10.1678957414868;
        Thu, 16 Mar 2023 02:03:34 -0700 (PDT)
Received: from [10.72.13.123] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b00199023c688esm5091713plv.26.2023.03.16.02.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:03:34 -0700 (PDT)
Message-ID: <59bdd215-6465-a240-338c-04a3a67a061d@redhat.com>
Date:   Thu, 16 Mar 2023 17:03:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 05/11] vduse: Support automatic irq callback affinity
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230228094110.37-1-xieyongji@bytedance.com>
 <20230228094110.37-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230228094110.37-6-xieyongji@bytedance.com>
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
> This brings current interrupt affinity spreading mechanism
> to vduse device. We will make use of group_cpus_evenly()
> to create an irq callback affinity mask for each virtqueue of
> vduse device. Then we will spread IRQs between CPUs in the affinity
> mask, in a round-robin manner, to run the irq callback.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 130 +++++++++++++++++++++++++++--
>   1 file changed, 123 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 98359d87a06f..bde28a8692d5 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -23,6 +23,8 @@
>   #include <linux/nospec.h>
>   #include <linux/vmalloc.h>
>   #include <linux/sched/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/group_cpus.h>
>   #include <uapi/linux/vduse.h>
>   #include <uapi/linux/vdpa.h>
>   #include <uapi/linux/virtio_config.h>
> @@ -41,6 +43,8 @@
>   #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>   #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>   
> +#define IRQ_UNBOUND -1
> +
>   struct vduse_virtqueue {
>   	u16 index;
>   	u16 num_max;
> @@ -57,6 +61,8 @@ struct vduse_virtqueue {
>   	struct vdpa_callback cb;
>   	struct work_struct inject;
>   	struct work_struct kick;
> +	int irq_effective_cpu;
> +	struct cpumask irq_affinity;
>   };
>   
>   struct vduse_dev;
> @@ -128,6 +134,7 @@ static struct class *vduse_class;
>   static struct cdev vduse_ctrl_cdev;
>   static struct cdev vduse_cdev;
>   static struct workqueue_struct *vduse_irq_wq;
> +static struct workqueue_struct *vduse_irq_bound_wq;
>   
>   static u32 allowed_device_id[] = {
>   	VIRTIO_ID_BLOCK,
> @@ -708,6 +715,82 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>   	return dev->generation;
>   }
>   
> +static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
> +{
> +	affd->nr_sets = 1;
> +	affd->set_size[0] = affvecs;
> +}
> +
> +struct cpumask *
> +create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
> +{
> +	unsigned int affvecs = 0, curvec, usedvecs, i;
> +	struct cpumask *masks = NULL;
> +
> +	if (nvecs > affd->pre_vectors + affd->post_vectors)
> +		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
> +
> +	if (!affd->calc_sets)
> +		affd->calc_sets = default_calc_sets;
> +
> +	affd->calc_sets(affd, affvecs);
> +
> +	if (!affvecs)
> +		return NULL;
> +
> +	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		return NULL;
> +
> +	/* Fill out vectors at the beginning that don't need affinity */
> +	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
> +		cpumask_setall(&masks[curvec]);
> +
> +	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
> +		unsigned int this_vecs = affd->set_size[i];
> +		int j;
> +		struct cpumask *result = group_cpus_evenly(this_vecs);
> +
> +		if (!result) {
> +			kfree(masks);
> +			return NULL;
> +		}
> +
> +		for (j = 0; j < this_vecs; j++)
> +			cpumask_copy(&masks[curvec + j], &result[j]);
> +		kfree(result);
> +
> +		curvec += this_vecs;
> +		usedvecs += this_vecs;
> +	}
> +
> +	/* Fill out vectors at the end that don't need affinity */
> +	if (usedvecs >= affvecs)
> +		curvec = affd->pre_vectors + affvecs;
> +	else
> +		curvec = affd->pre_vectors + usedvecs;
> +	for (; curvec < nvecs; curvec++)
> +		cpumask_setall(&masks[curvec]);
> +
> +	return masks;
> +}
> +
> +static void vduse_vdpa_set_irq_affinity(struct vdpa_device *vdpa,
> +					struct irq_affinity *desc)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +	struct cpumask *masks;
> +	int i;
> +
> +	masks = create_affinity_masks(dev->vq_num, desc);
> +	if (!masks)
> +		return;
> +
> +	for (i = 0; i < dev->vq_num; i++)
> +		cpumask_copy(&dev->vqs[i]->irq_affinity, &masks[i]);
> +	kfree(masks);
> +}
> +
>   static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>   				unsigned int asid,
>   				struct vhost_iotlb *iotlb)
> @@ -758,6 +841,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>   	.get_config		= vduse_vdpa_get_config,
>   	.set_config		= vduse_vdpa_set_config,
>   	.get_generation		= vduse_vdpa_get_generation,
> +	.set_irq_affinity	= vduse_vdpa_set_irq_affinity,
>   	.reset			= vduse_vdpa_reset,
>   	.set_map		= vduse_vdpa_set_map,
>   	.free			= vduse_vdpa_free,
> @@ -917,7 +1001,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>   }
>   
>   static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> -				    struct work_struct *irq_work)
> +				    struct work_struct *irq_work,
> +				    int irq_effective_cpu)
>   {
>   	int ret = -EINVAL;
>   
> @@ -926,7 +1011,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>   		goto unlock;
>   
>   	ret = 0;
> -	queue_work(vduse_irq_wq, irq_work);
> +	if (irq_effective_cpu == IRQ_UNBOUND)
> +		queue_work(vduse_irq_wq, irq_work);
> +	else
> +		queue_work_on(irq_effective_cpu,
> +			      vduse_irq_bound_wq, irq_work);
>   unlock:
>   	up_read(&dev->rwsem);
>   
> @@ -1029,6 +1118,22 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>   	return ret;
>   }
>   
> +static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
> +{
> +	int curr_cpu = vq->irq_effective_cpu;
> +
> +	while (true) {
> +		curr_cpu = cpumask_next(curr_cpu, &vq->irq_affinity);
> +		if (cpu_online(curr_cpu))
> +			break;
> +
> +		if (curr_cpu >= nr_cpu_ids)
> +			curr_cpu = -1;


IRQ_UNBOUND?


> +	}
> +
> +	vq->irq_effective_cpu = curr_cpu;
> +}
> +
>   static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>   			    unsigned long arg)
>   {
> @@ -1111,7 +1216,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	}
>   	case VDUSE_DEV_INJECT_CONFIG_IRQ:
> -		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
> +		ret = vduse_dev_queue_irq_work(dev, &dev->inject, IRQ_UNBOUND);
>   		break;
>   	case VDUSE_VQ_SETUP: {
>   		struct vduse_vq_config config;
> @@ -1198,7 +1303,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>   			break;
>   
>   		index = array_index_nospec(index, dev->vq_num);
> -		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject);
> +
> +		vduse_vq_update_effective_cpu(dev->vqs[index]);
> +		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
> +					dev->vqs[index]->irq_effective_cpu);
>   		break;
>   	}
>   	case VDUSE_IOTLB_REG_UMEM: {
> @@ -1367,10 +1475,12 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>   			goto err;
>   
>   		dev->vqs[i]->index = i;
> +		dev->vqs[i]->irq_effective_cpu = -1;


IRQ_UNBOUND?

Other looks good.

Thanks


>   		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
>   		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>   		spin_lock_init(&dev->vqs[i]->kick_lock);
>   		spin_lock_init(&dev->vqs[i]->irq_lock);
> +		cpumask_setall(&dev->vqs[i]->irq_affinity);
>   	}
>   
>   	return 0;
> @@ -1858,12 +1968,15 @@ static int vduse_init(void)
>   	if (ret)
>   		goto err_cdev;
>   
> +	ret = -ENOMEM;
>   	vduse_irq_wq = alloc_workqueue("vduse-irq",
>   				WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
> -	if (!vduse_irq_wq) {
> -		ret = -ENOMEM;
> +	if (!vduse_irq_wq)
>   		goto err_wq;
> -	}
> +
> +	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound", WQ_HIGHPRI, 0);
> +	if (!vduse_irq_bound_wq)
> +		goto err_bound_wq;
>   
>   	ret = vduse_domain_init();
>   	if (ret)
> @@ -1877,6 +1990,8 @@ static int vduse_init(void)
>   err_mgmtdev:
>   	vduse_domain_exit();
>   err_domain:
> +	destroy_workqueue(vduse_irq_bound_wq);
> +err_bound_wq:
>   	destroy_workqueue(vduse_irq_wq);
>   err_wq:
>   	cdev_del(&vduse_cdev);
> @@ -1896,6 +2011,7 @@ static void vduse_exit(void)
>   {
>   	vduse_mgmtdev_exit();
>   	vduse_domain_exit();
> +	destroy_workqueue(vduse_irq_bound_wq);
>   	destroy_workqueue(vduse_irq_wq);
>   	cdev_del(&vduse_cdev);
>   	device_destroy(vduse_class, vduse_major);

