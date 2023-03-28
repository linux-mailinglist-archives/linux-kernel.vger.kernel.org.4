Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF16CB6B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC1GPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjC1GPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6947730ED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679984055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UDqF1GrbzQq1+HPSvJYRs4W/bqOwDA7041P8KA7sUJw=;
        b=hQb2tdObMHzFsjULAbtOlZV976wgEgjW1srp7kHgyTZb1lgfzSz0Tsoa7hjmHZs2Xf3qUT
        VcAHmjUqJNf3YlbpvkTh3ofHUoxIWvO7WZJKV7vwORC62FK0DHBHjRe4hvML7LpXIwbMfw
        aPTSizRyWtjkINqTFIQkNhZz8JKP2Lw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-28IayVukNRGb4TOGT01ppw-1; Tue, 28 Mar 2023 02:14:13 -0400
X-MC-Unique: 28IayVukNRGb4TOGT01ppw-1
Received: by mail-pf1-f200.google.com with SMTP id i26-20020aa796fa000000b006261da7aeceso5310336pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDqF1GrbzQq1+HPSvJYRs4W/bqOwDA7041P8KA7sUJw=;
        b=R9+q8ivykZjfN9u8MxWNKpVlHJovGALxoB/thGnm8v9hufF3creS+7MGCu+9OY8jyO
         TkyvIK8m4QZGWuxEx4upRIiXoR/4DS67iw0UowveTXsJ7fo3QU0JrAKJ+56VYnieNe36
         aFyKrA9rJ+POQpdTpHM564CGGAIY1zs8ZA3llYtRG66zRUCwadAcFfO4XOuj0U9PesW6
         o4q0R+40M7aEYFo50qcwlUpBjvZqeECOYQaeXU8NH52exQ6yf8auERvgUJ8o3JYIWmZW
         NR9yhy68y/mqnJqGV5fo0g9SBnVDhT+GkbKnMGYMF5DNWwDEXf91h4tYcB6yHeNFuUYg
         8N4A==
X-Gm-Message-State: AAQBX9dQfZJ2s6P4un9zWQhc/lFp8NXv66owahZGvXvQlqciAymJawcx
        W7l5sxK2EjUsUl+6vmAD+BXfW1vo6BbPD6LiIdN1eMdnGKWCRobFsF9A6bBx4V10iPCcXtWyX4P
        kq1Eo7VOk/RMaiEKO/jKAn19A
X-Received: by 2002:a17:903:410c:b0:1a2:62d7:8c2a with SMTP id r12-20020a170903410c00b001a262d78c2amr998865pld.11.1679984052498;
        Mon, 27 Mar 2023 23:14:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350YCxm+v8tsCs7SvvbxdQdgSa17TenhAG4E2V0AMUT3eHfgR8foPhJ00O1N7zmi2Sqbt6+LHxQ==
X-Received: by 2002:a17:903:410c:b0:1a2:62d7:8c2a with SMTP id r12-20020a170903410c00b001a262d78c2amr998855pld.11.1679984052141;
        Mon, 27 Mar 2023 23:14:12 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709026b8800b0019ab151eb90sm2552767plk.139.2023.03.27.23.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:14:11 -0700 (PDT)
Message-ID: <54ac21bb-4a11-13c3-c341-73744138f386@redhat.com>
Date:   Tue, 28 Mar 2023 14:14:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 05/11] vduse: Support set_vq_affinity callback
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-6-xieyongji@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/23 13:30, Xie Yongji 写道:
> Since virtio-vdpa bus driver already support interrupt
> affinity spreading mechanism, let's implement the
> set_vq_affinity callback to bring it to vduse device.
> After we get the virtqueue's affinity, we can spread
> IRQs between CPUs in the affinity mask, in a round-robin
> manner, to run the irq callback.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 61 ++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 98359d87a06f..45aa8703c4b5 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -41,6 +41,8 @@
>   #define VDUSE_IOVA_SIZE (128 * 1024 * 1024)
>   #define VDUSE_MSG_DEFAULT_TIMEOUT 30
>   
> +#define IRQ_UNBOUND -1
> +
>   struct vduse_virtqueue {
>   	u16 index;
>   	u16 num_max;
> @@ -57,6 +59,8 @@ struct vduse_virtqueue {
>   	struct vdpa_callback cb;
>   	struct work_struct inject;
>   	struct work_struct kick;
> +	int irq_effective_cpu;
> +	struct cpumask irq_affinity;
>   };
>   
>   struct vduse_dev;
> @@ -128,6 +132,7 @@ static struct class *vduse_class;
>   static struct cdev vduse_ctrl_cdev;
>   static struct cdev vduse_cdev;
>   static struct workqueue_struct *vduse_irq_wq;
> +static struct workqueue_struct *vduse_irq_bound_wq;
>   
>   static u32 allowed_device_id[] = {
>   	VIRTIO_ID_BLOCK,
> @@ -708,6 +713,15 @@ static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
>   	return dev->generation;
>   }
>   
> +static int vduse_vdpa_set_vq_affinity(struct vdpa_device *vdpa, u16 idx,
> +				      const struct cpumask *cpu_mask)
> +{
> +	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +	cpumask_copy(&dev->vqs[idx]->irq_affinity, cpu_mask);
> +	return 0;
> +}
> +
>   static int vduse_vdpa_set_map(struct vdpa_device *vdpa,
>   				unsigned int asid,
>   				struct vhost_iotlb *iotlb)
> @@ -758,6 +772,7 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>   	.get_config		= vduse_vdpa_get_config,
>   	.set_config		= vduse_vdpa_set_config,
>   	.get_generation		= vduse_vdpa_get_generation,
> +	.set_vq_affinity	= vduse_vdpa_set_vq_affinity,
>   	.reset			= vduse_vdpa_reset,
>   	.set_map		= vduse_vdpa_set_map,
>   	.free			= vduse_vdpa_free,
> @@ -917,7 +932,8 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>   }
>   
>   static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> -				    struct work_struct *irq_work)
> +				    struct work_struct *irq_work,
> +				    int irq_effective_cpu)
>   {
>   	int ret = -EINVAL;
>   
> @@ -926,7 +942,11 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
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
> @@ -1029,6 +1049,22 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
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
> +			curr_cpu = IRQ_UNBOUND;
> +	}
> +
> +	vq->irq_effective_cpu = curr_cpu;
> +}
> +
>   static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>   			    unsigned long arg)
>   {
> @@ -1111,7 +1147,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>   		break;
>   	}
>   	case VDUSE_DEV_INJECT_CONFIG_IRQ:
> -		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
> +		ret = vduse_dev_queue_irq_work(dev, &dev->inject, IRQ_UNBOUND);
>   		break;
>   	case VDUSE_VQ_SETUP: {
>   		struct vduse_vq_config config;
> @@ -1198,7 +1234,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
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
> @@ -1367,10 +1406,12 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>   			goto err;
>   
>   		dev->vqs[i]->index = i;
> +		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
>   		INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
>   		INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>   		spin_lock_init(&dev->vqs[i]->kick_lock);
>   		spin_lock_init(&dev->vqs[i]->irq_lock);
> +		cpumask_setall(&dev->vqs[i]->irq_affinity);
>   	}
>   
>   	return 0;
> @@ -1858,12 +1899,15 @@ static int vduse_init(void)
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
> @@ -1877,6 +1921,8 @@ static int vduse_init(void)
>   err_mgmtdev:
>   	vduse_domain_exit();
>   err_domain:
> +	destroy_workqueue(vduse_irq_bound_wq);
> +err_bound_wq:
>   	destroy_workqueue(vduse_irq_wq);
>   err_wq:
>   	cdev_del(&vduse_cdev);
> @@ -1896,6 +1942,7 @@ static void vduse_exit(void)
>   {
>   	vduse_mgmtdev_exit();
>   	vduse_domain_exit();
> +	destroy_workqueue(vduse_irq_bound_wq);
>   	destroy_workqueue(vduse_irq_wq);
>   	cdev_del(&vduse_cdev);
>   	device_destroy(vduse_class, vduse_major);

