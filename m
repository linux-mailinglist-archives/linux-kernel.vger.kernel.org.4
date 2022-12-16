Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A764E706
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLPFgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLPFg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D99532D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671168938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=15kneUv6xIwsc7YmiaK1y3hzzsO9x/bfH79/junA/Zk=;
        b=a7UHEW0JZx2JgQqBiUIcddcO5FbB3Pe6vK0sg/piF881qZbqyJph0advkTROSv8VbJ4fjP
        5xFBFYWGLken7FeMLvPLPIe+IYt6CY92r9ATiC7JbcenijsGRINZ0Jyipf5kzpEvFaKDjn
        dhvuTEZE0s+ERw654wJMVSbBKLSVoGM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-gg4dQG3XPv6dQQU226_GsQ-1; Fri, 16 Dec 2022 00:35:37 -0500
X-MC-Unique: gg4dQG3XPv6dQQU226_GsQ-1
Received: by mail-oo1-f70.google.com with SMTP id j2-20020a4a7502000000b0049bdd099de9so768422ooc.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15kneUv6xIwsc7YmiaK1y3hzzsO9x/bfH79/junA/Zk=;
        b=vbzNqABy8mIhvvniuDti1mrRl1QMErt2zAoejRg/2o0K1hwNceovqZK4jrU/BEOZbY
         BUCW/W/jn5MFOGk5htwaiJ+iKY9hZf6/lpXWlb5xagK4d9zTA41gOU0EtZF2ZRzeyTi/
         x6JQ+EWpJO7zuawarrXDq6FPWq28U4aZpJPZQHibjAB5kQqgjQFjycIAgbBoWWlqWs+y
         6y6+aLXayKuObneWgCi+eb9WQ7k0cqdyuN9F9fsZ0oKlv2+DXYGxEwKHpJI6ApbXZDZH
         cvOGbnxYxSpBcrNjQYA3FgntRB2G3p5BXnf8D9Gxytop4x+4EbksxetUg3PwqBP8nh/x
         HkFQ==
X-Gm-Message-State: ANoB5plL6UlN7IaQ9o3IPGlZzAGrdCNH9h9EjjMcn+lzzCvN/IeDpVqy
        KhIf+XCyoCy29NlofXIcwUpRG1QyiJ13dEJsw+dJGAlPCkTvsbWWufhn91c7b2aXr8hNhYshqKL
        TmjQBo8yCsBlbsh9hgJBE6mh+yUoDFHOCBiZ3XSzV
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id pu15-20020a0568709e8f00b00144a97b1ae2mr333517oab.35.1671168936518;
        Thu, 15 Dec 2022 21:35:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6vAcuuDYaqibZH4I1Z22WkAii2wf8+1cShP52aqKRcbNLv1gQJ2SoMjC6INmiqsmfRZ4BBxnMALM837rgIiWY=
X-Received: by 2002:a05:6870:9e8f:b0:144:a97b:1ae2 with SMTP id
 pu15-20020a0568709e8f00b00144a97b1ae2mr333515oab.35.1671168936300; Thu, 15
 Dec 2022 21:35:36 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-2-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 13:35:25 +0800
Message-ID: <CACGkMEsX1RjU_ncNTY-KbeUY8bxm7X62V_SNO=hMehZRuGQ+CQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] vduse: Add sysfs interface for irq callback affinity
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, tglx@linutronix.de, hch@lst.de,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 5:03 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Add sysfs interface for each vduse virtqueue to
> show the affinity and effective affinity for irq
> callback.
>
> And we can also use this interface to change the
> effective affinity which must be a subset of the
> irq callback affinity mask for the virtqueue. This
> might be useful for performance tuning when the irq
> callback affinity mask contains more than one CPU.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 148 ++++++++++++++++++++++++++---
>  1 file changed, 137 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 6507a78abc9d..c65f84100e30 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -61,6 +61,7 @@ struct vduse_virtqueue {
>         int irq_effective_cpu;
>         struct cpumask irq_affinity;
>         spinlock_t irq_affinity_lock;
> +       struct kobject kobj;
>  };
>
>  struct vduse_dev;
> @@ -1419,6 +1420,120 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +       return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> +}
> +
> +static ssize_t irq_cb_effective_affinity_show(struct vduse_virtqueue *vq,
> +                                             char *buf)
> +{
> +       struct cpumask all_mask = CPU_MASK_ALL;
> +       const struct cpumask *mask = &all_mask;
> +
> +       if (vq->irq_effective_cpu != -1)
> +               mask = get_cpu_mask(vq->irq_effective_cpu);

Shouldn't this be vq->irq_affinity?

> +
> +       return sprintf(buf, "%*pb\n", cpumask_pr_args(mask));
> +}
> +
> +static ssize_t irq_cb_effective_affinity_store(struct vduse_virtqueue *vq,
> +                                              const char *buf, size_t count)
> +{
> +       cpumask_var_t new_value;
> +       int ret;
> +
> +       if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
> +               return -ENOMEM;
> +
> +       ret = cpumask_parse(buf, new_value);
> +       if (ret)
> +               goto free_mask;
> +
> +       ret = -EINVAL;
> +       if (!cpumask_intersects(new_value, &vq->irq_affinity))
> +               goto free_mask;
> +
> +       spin_lock(&vq->irq_affinity_lock);
> +
> +       if (vq->irq_effective_cpu != -1)
> +               per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) -= 1;
> +
> +       vq->irq_effective_cpu = cpumask_first(new_value);

Does this mean except for the first cpu, the rest of the mask is unused?

Thanks

> +       per_cpu(vduse_allocated_irq, vq->irq_effective_cpu) += 1;
> +
> +       spin_unlock(&vq->irq_affinity_lock);
> +       ret = count;
> +
> +free_mask:
> +       free_cpumask_var(new_value);
> +       return ret;
> +}
> +
> +struct vq_sysfs_entry {
> +       struct attribute attr;
> +       ssize_t (*show)(struct vduse_virtqueue *vq, char *buf);
> +       ssize_t (*store)(struct vduse_virtqueue *vq, const char *buf,
> +                        size_t count);
> +};
> +
> +static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
> +static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
> +                                       __ATTR_RW(irq_cb_effective_affinity);
> +
> +static struct attribute *vq_attrs[] = {
> +       &irq_cb_affinity_attr.attr,
> +       &irq_cb_effective_affinity_attr.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(vq);
> +
> +static ssize_t vq_attr_show(struct kobject *kobj, struct attribute *attr,
> +                           char *buf)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       struct vq_sysfs_entry *entry = container_of(attr,
> +                                       struct vq_sysfs_entry, attr);
> +
> +       if (!entry->show)
> +               return -EIO;
> +
> +       return entry->show(vq, buf);
> +}
> +
> +static ssize_t vq_attr_store(struct kobject *kobj, struct attribute *attr,
> +                            const char *buf, size_t count)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       struct vq_sysfs_entry *entry = container_of(attr,
> +                                       struct vq_sysfs_entry, attr);
> +
> +       if (!entry->store)
> +               return -EIO;
> +
> +       return entry->store(vq, buf, count);
> +}
> +
> +static const struct sysfs_ops vq_sysfs_ops = {
> +       .show = vq_attr_show,
> +       .store = vq_attr_store,
> +};
> +
> +static void vq_release(struct kobject *kobj)
> +{
> +       struct vduse_virtqueue *vq = container_of(kobj,
> +                                       struct vduse_virtqueue, kobj);
> +       kfree(vq);
> +}
> +
> +static struct kobj_type vq_type = {
> +       .release        = vq_release,
> +       .sysfs_ops      = &vq_sysfs_ops,
> +       .default_groups = vq_groups,
> +};
> +
>  static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>  {
>         int i;
> @@ -1427,13 +1542,13 @@ static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
>                 return;
>
>         for (i = 0; i < dev->vq_num; i++)
> -               kfree(dev->vqs[i]);
> +               kobject_put(&dev->vqs[i]->kobj);
>         kfree(dev->vqs);
>  }
>
>  static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>  {
> -       int i;
> +       int ret, i;
>
>         dev->vq_align = vq_align;
>         dev->vq_num = vq_num;
> @@ -1443,8 +1558,10 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>
>         for (i = 0; i < vq_num; i++) {
>                 dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
> -               if (!dev->vqs[i])
> +               if (!dev->vqs[i]) {
> +                       ret = -ENOMEM;
>                         goto err;
> +               }
>
>                 dev->vqs[i]->index = i;
>                 dev->vqs[i]->irq_effective_cpu = -1;
> @@ -1454,15 +1571,23 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>                 spin_lock_init(&dev->vqs[i]->irq_lock);
>                 spin_lock_init(&dev->vqs[i]->irq_affinity_lock);
>                 cpumask_setall(&dev->vqs[i]->irq_affinity);
> +
> +               kobject_init(&dev->vqs[i]->kobj, &vq_type);
> +               ret = kobject_add(&dev->vqs[i]->kobj,
> +                                 &dev->dev->kobj, "vq%d", i);
> +               if (ret) {
> +                       kfree(dev->vqs[i]);
> +                       goto err;
> +               }
>         }
>
>         return 0;
>  err:
>         while (i--)
> -               kfree(dev->vqs[i]);
> +               kobject_put(&dev->vqs[i]->kobj);
>         kfree(dev->vqs);
>         dev->vqs = NULL;
> -       return -ENOMEM;
> +       return ret;
>  }
>
>  static struct vduse_dev *vduse_dev_create(void)
> @@ -1637,10 +1762,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>         dev->config = config_buf;
>         dev->config_size = config->config_size;
>
> -       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> -       if (ret)
> -               goto err_vqs;
> -
>         ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
>         if (ret < 0)
>                 goto err_idr;
> @@ -1654,14 +1775,19 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>                 ret = PTR_ERR(dev->dev);
>                 goto err_dev;
>         }
> +
> +       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> +       if (ret)
> +               goto err_vqs;
> +
>         __module_get(THIS_MODULE);
>
>         return 0;
> +err_vqs:
> +       device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -       vduse_dev_deinit_vqs(dev);
> -err_vqs:
>         vduse_domain_destroy(dev->domain);
>  err_domain:
>         kfree(dev->name);
> --
> 2.20.1
>

