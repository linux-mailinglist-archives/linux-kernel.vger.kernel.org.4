Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF426CB6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjC1GSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjC1GSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394063A9C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679984212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VV9uJu2KI3hD8CYjUN/MQ/Xwbu81pu1qL65QXCWepDU=;
        b=BygEY2MyUsXJlBH/1IgYN8ZZxF48dMvSOK2QFIIakxz0UUeIvpGUsqHO/KIs8WxWX7u1Ui
        qNakR052A0E9EHxHiApDMwqBKkA2XO84dv5aeDg2rpucDLZCrBiADRK7FaC90KpprKD6QQ
        kOlsRypbTcxSrynVWADE8pl5uy0wz4o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-J6mmVGheOVu_67yMbmj5xw-1; Tue, 28 Mar 2023 02:16:43 -0400
X-MC-Unique: J6mmVGheOVu_67yMbmj5xw-1
Received: by mail-pj1-f69.google.com with SMTP id n18-20020a17090ac69200b002401201f1f9so5683652pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679984202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VV9uJu2KI3hD8CYjUN/MQ/Xwbu81pu1qL65QXCWepDU=;
        b=JBI2+2tEpUU2WvDUiw18syuhZ3d7ES/oWW3XPreWDbnqtjyYsiy9TozSuv6Dood1CM
         nivhz3XdLHD8CFjY2RxSxYsXhgXwRbD7qqjaqH9PmkqekMKSbOs/PcFvU9ZVa8LeZyvI
         DCpCNb4apSTXG5ILdkx8hNizRspzBu0RDWlvTH9TNFkabOyZeuviUMjWYfVF0d7xAPo7
         btqUJqJvswFYIcTM0aY3RZk1zq0Kcgko+8qVhHTQpRLVF79rkswLYU47zkH2hMyGYe8U
         HT9efxC5oXIUjmsa1qaCckClBuS8wp/u0ua9O88LJ5pPrupEh5kjGwEdmuFSIbNQYPNV
         KGYQ==
X-Gm-Message-State: AO0yUKXNN5SnlGccvNaF4FTvmXmt/m4N2A6gS2RGSo9Z1cK2wwjwYh3F
        ubqmnk/dKMdqXDF1dDnwcCiV+bTkPjcukNyAp81kmVhqNcO7ghRFAIpiP5fVa4uA2abeLd/qj5W
        /BKmea1vXuWLizOkkzwi3+47j
X-Received: by 2002:a05:6a20:1e4d:b0:da:f525:e629 with SMTP id cy13-20020a056a201e4d00b000daf525e629mr12863217pzb.53.1679984202046;
        Mon, 27 Mar 2023 23:16:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set/efblHnzPk4S+gdRl49tiuIAxoct8gxx5y8dUbFOdmQzmBPiWT7BlXrrzv0YYYKFpZSQHLpg==
X-Received: by 2002:a05:6a20:1e4d:b0:da:f525:e629 with SMTP id cy13-20020a056a201e4d00b000daf525e629mr12863199pzb.53.1679984201770;
        Mon, 27 Mar 2023 23:16:41 -0700 (PDT)
Received: from [10.72.13.204] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78146000000b0062d945e416esm1369900pfn.160.2023.03.27.23.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:16:41 -0700 (PDT)
Message-ID: <d3ad99a2-1e0a-5953-5303-37be0f2f02b6@redhat.com>
Date:   Tue, 28 Mar 2023 14:16:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v4 07/11] vduse: Add sysfs interface for irq callback
 affinity
Content-Language: en-US
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        tglx@linutronix.de, hch@lst.de
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230323053043.35-1-xieyongji@bytedance.com>
 <20230323053043.35-8-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230323053043.35-8-xieyongji@bytedance.com>
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
> Add sysfs interface for each vduse virtqueue to
> get/set the affinity for irq callback. This might
> be useful for performance tuning when the irq callback
> affinity mask contains more than one CPU.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 124 ++++++++++++++++++++++++++---
>   1 file changed, 113 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index cefabd0dab9c..77da3685568a 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -61,6 +61,7 @@ struct vduse_virtqueue {
>   	struct work_struct kick;
>   	int irq_effective_cpu;
>   	struct cpumask irq_affinity;
> +	struct kobject kobj;
>   };
>   
>   struct vduse_dev;
> @@ -1387,6 +1388,96 @@ static const struct file_operations vduse_dev_fops = {
>   	.llseek		= noop_llseek,
>   };
>   
> +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +	return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> +}
> +
> +static ssize_t irq_cb_affinity_store(struct vduse_virtqueue *vq,
> +				     const char *buf, size_t count)
> +{
> +	cpumask_var_t new_value;
> +	int ret;
> +
> +	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	ret = cpumask_parse(buf, new_value);
> +	if (ret)
> +		goto free_mask;
> +
> +	ret = -EINVAL;
> +	if (!cpumask_intersects(new_value, cpu_online_mask))
> +		goto free_mask;
> +
> +	cpumask_copy(&vq->irq_affinity, new_value);
> +	ret = count;
> +free_mask:
> +	free_cpumask_var(new_value);
> +	return ret;
> +}
> +
> +struct vq_sysfs_entry {
> +	struct attribute attr;
> +	ssize_t (*show)(struct vduse_virtqueue *vq, char *buf);
> +	ssize_t (*store)(struct vduse_virtqueue *vq, const char *buf,
> +			 size_t count);
> +};
> +
> +static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RW(irq_cb_affinity);
> +
> +static struct attribute *vq_attrs[] = {
> +	&irq_cb_affinity_attr.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(vq);
> +
> +static ssize_t vq_attr_show(struct kobject *kobj, struct attribute *attr,
> +			    char *buf)
> +{
> +	struct vduse_virtqueue *vq = container_of(kobj,
> +					struct vduse_virtqueue, kobj);
> +	struct vq_sysfs_entry *entry = container_of(attr,
> +					struct vq_sysfs_entry, attr);
> +
> +	if (!entry->show)
> +		return -EIO;
> +
> +	return entry->show(vq, buf);
> +}
> +
> +static ssize_t vq_attr_store(struct kobject *kobj, struct attribute *attr,
> +			     const char *buf, size_t count)
> +{
> +	struct vduse_virtqueue *vq = container_of(kobj,
> +					struct vduse_virtqueue, kobj);
> +	struct vq_sysfs_entry *entry = container_of(attr,
> +					struct vq_sysfs_entry, attr);
> +
> +	if (!entry->store)
> +		return -EIO;
> +
> +	return entry->store(vq, buf, count);
> +}
> +
> +static const struct sysfs_ops vq_sysfs_ops = {
> +	.show = vq_attr_show,
> +	.store = vq_attr_store,
> +};
> +
> +static void vq_release(struct kobject *kobj)
> +{
> +	struct vduse_virtqueue *vq = container_of(kobj,
> +					struct vduse_virtqueue, kobj);
> +	kfree(vq);
> +}
> +
> +static const struct kobj_type vq_type = {
> +	.release	= vq_release,
> +	.sysfs_ops	= &vq_sysfs_ops,
> +	.default_groups	= vq_groups,
> +};
> +
>   static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>   {
>   	int i;
> @@ -1395,13 +1486,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>   		return;
>   
>   	for (i = 0; i < dev->vq_num; i++)
> -		kfree(dev->vqs[i]);
> +		kobject_put(&dev->vqs[i]->kobj);
>   	kfree(dev->vqs);
>   }
>   
>   static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>   {
> -	int i;
> +	int ret, i;
>   
>   	dev->vq_align = vq_align;
>   	dev->vq_num = vq_num;
> @@ -1411,8 +1502,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>   
>   	for (i = 0; i < vq_num; i++) {
>   		dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
> -		if (!dev->vqs[i])
> +		if (!dev->vqs[i]) {
> +			ret = -ENOMEM;
>   			goto err;
> +		}
>   
>   		dev->vqs[i]->index = i;
>   		dev->vqs[i]->irq_effective_cpu = IRQ_UNBOUND;
> @@ -1421,15 +1514,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>   		spin_lock_init(&dev->vqs[i]->kick_lock);
>   		spin_lock_init(&dev->vqs[i]->irq_lock);
>   		cpumask_setall(&dev->vqs[i]->irq_affinity);
> +
> +		kobject_init(&dev->vqs[i]->kobj, &vq_type);
> +		ret = kobject_add(&dev->vqs[i]->kobj,
> +				  &dev->dev->kobj, "vq%d", i);
> +		if (ret) {
> +			kfree(dev->vqs[i]);
> +			goto err;
> +		}
>   	}
>   
>   	return 0;
>   err:
>   	while (i--)
> -		kfree(dev->vqs[i]);
> +		kobject_put(&dev->vqs[i]->kobj);
>   	kfree(dev->vqs);
>   	dev->vqs = NULL;
> -	return -ENOMEM;
> +	return ret;
>   }
>   
>   static struct vduse_dev *vduse_dev_create(void)
> @@ -1607,10 +1708,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>   	dev->config = config_buf;
>   	dev->config_size = config->config_size;
>   
> -	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> -	if (ret)
> -		goto err_vqs;
> -
>   	ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
>   	if (ret < 0)
>   		goto err_idr;
> @@ -1624,14 +1721,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>   		ret = PTR_ERR(dev->dev);
>   		goto err_dev;
>   	}
> +
> +	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> +	if (ret)
> +		goto err_vqs;
> +
>   	__module_get(THIS_MODULE);
>   
>   	return 0;
> +err_vqs:
> +	device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>   err_dev:
>   	idr_remove(&vduse_idr, dev->minor);
>   err_idr:
> -	vduse_dev_deinit_vqs(dev);
> -err_vqs:
>   	vduse_domain_destroy(dev->domain);
>   err_domain:
>   	kfree(dev->name);

