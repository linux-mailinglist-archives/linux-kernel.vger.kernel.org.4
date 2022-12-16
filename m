Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A964E70F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLPFoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPFoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C365D6BB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671169393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lR7WnqvDc+rTDFoKYRWuh6MMYqCYo5ZyrUKVWQtJrjg=;
        b=XGIbqKrS7Z/VZG7W+k/Swl9AVnVx4QkyAFIH2y0cfOqOwXQOCq7a/Bg/42klLOmjfyZ5PZ
        isFFhxMmoRldT4WMT20ZjvJvjNmq2qHH1oLxDNtxiDLgBdWElgNhvIgUPZbQN18gRcOJWy
        /PQSTkC5/V41aydmeXQP88MkU8Olbi8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-4vOkpTXoNv2npgsWFK-6ig-1; Fri, 16 Dec 2022 00:43:12 -0500
X-MC-Unique: 4vOkpTXoNv2npgsWFK-6ig-1
Received: by mail-ot1-f70.google.com with SMTP id bx9-20020a056830600900b0066debed5e7dso792748otb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR7WnqvDc+rTDFoKYRWuh6MMYqCYo5ZyrUKVWQtJrjg=;
        b=r02KDmGGHhOcd1XUsh8ENb8P6eNNK5iavK3bNVq/EsVqVpfOOApod2kwPjYdGGIjws
         83sk4EyD2m+Hes1DNtX1FrmHVUWnhtYRryzKRZHiG5bWSho5Zf9xBGwh9A8YR/6AtQF3
         NxVmnlwC2ZSVM0Q1sIaDeFJoTcZxP99JyC3xWW3ybW2jq12y1dh4aHckrtvvYppVBbYC
         QLSautV/MsnF8CgWgUosGVXC3qHMZ2uZ86yBeE+Kjs5uo9aXmo2gYaPWKAfjwomROFtq
         Lv6L1Szu37GCygBFAxxzjyivyn3BPExpUI4wJ0voB2UR/h7OFln38qjZI476U7nQgt8X
         CaEw==
X-Gm-Message-State: ANoB5plISnWM4NAxwsvWM/w6X3rI2KIlSFgHA0cD++7LIKV2GQ1nfNG1
        +mpLZXTMnIcmxCvqugMdSBD73uGbr0ikSXqSt+SciZ3+Si14t20NI0bUH3F3Vy8SRtORuJPvkT9
        NZWajc4sBGuPgW2YZwWr2jH05qptilCrxV8IZWCq2
X-Received: by 2002:a4a:94a9:0:b0:480:8f4a:7062 with SMTP id k38-20020a4a94a9000000b004808f4a7062mr31914715ooi.57.1671169391286;
        Thu, 15 Dec 2022 21:43:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6ZMswovlmpw7FdDe9VO/33eW2UDQTUjORPwH4EGDIAX/TuiwI9YZfjjWcizpDDlCiCCEf+P97Fy2zif8OL2So=
X-Received: by 2002:a4a:94a9:0:b0:480:8f4a:7062 with SMTP id
 k38-20020a4a94a9000000b004808f4a7062mr31914710ooi.57.1671169391057; Thu, 15
 Dec 2022 21:43:11 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-3-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-3-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 13:43:00 +0800
Message-ID: <CACGkMEuAxEEvShwN8Q_k-FKZODesORn4zJG7UFHD-KS8sQXYjg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] vduse: Add enable_irq_wq sysfs interface for virtqueues
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
> Add enable_irq_wq sysfs interface to control whether
> use workqueue to inject irq or not. The vhost-vdpa case
> can benefit from it.

Do we have a benchmark result for this?

Or I wonder if we can extend set_vq_cb() by associating an eventfd
then VDUSE can signal that eventfd directly?

Thanks

>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 50 +++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index c65f84100e30..ed06c7afd484 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -62,6 +62,7 @@ struct vduse_virtqueue {
>         struct cpumask irq_affinity;
>         spinlock_t irq_affinity_lock;
>         struct kobject kobj;
> +       bool enable_irq_wq;
>  };
>
>  struct vduse_dev;
> @@ -1013,6 +1014,26 @@ static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
>         return ret;
>  }
>
> +static int vduse_dev_inject_vq_irq(struct vduse_dev *dev,
> +                                  struct vduse_virtqueue *vq)
> +{
> +       int ret = -EINVAL;
> +
> +       down_read(&dev->rwsem);
> +       if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               goto unlock;
> +
> +       ret = 0;
> +       spin_lock_irq(&vq->irq_lock);
> +       if (vq->ready && vq->cb.callback)
> +               vq->cb.callback(vq->cb.private);
> +       spin_unlock_irq(&vq->irq_lock);
> +unlock:
> +       up_read(&dev->rwsem);
> +
> +       return ret;
> +}
> +
>  static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                                 u64 iova, u64 size)
>  {
> @@ -1278,8 +1299,12 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 index = array_index_nospec(index, dev->vq_num);
> -               ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject,
> +               if (dev->vqs[index]->enable_irq_wq)
> +                       ret = vduse_dev_queue_irq_work(dev,
> +                                       &dev->vqs[index]->inject,
>                                         dev->vqs[index]->irq_effective_cpu);
> +               else
> +                       ret = vduse_dev_inject_vq_irq(dev, dev->vqs[index]);
>                 break;
>         }
>         case VDUSE_IOTLB_REG_UMEM: {
> @@ -1420,6 +1445,26 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static ssize_t enable_irq_wq_show(struct vduse_virtqueue *vq, char *buf)
> +{
> +       return sprintf(buf, "%d\n", vq->enable_irq_wq);
> +}
> +
> +static ssize_t enable_irq_wq_store(struct vduse_virtqueue *vq,
> +                                  const char *buf, size_t count)
> +{
> +       bool enabled;
> +       int ret;
> +
> +       ret = kstrtobool(buf, &enabled);
> +       if (ret)
> +               return ret;
> +
> +       vq->enable_irq_wq = enabled;
> +
> +       return count;
> +}
> +
>  static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
>  {
>         return sprintf(buf, "%*pb\n", cpumask_pr_args(&vq->irq_affinity));
> @@ -1480,10 +1525,12 @@ struct vq_sysfs_entry {
>  static struct vq_sysfs_entry irq_cb_affinity_attr = __ATTR_RO(irq_cb_affinity);
>  static struct vq_sysfs_entry irq_cb_effective_affinity_attr =
>                                         __ATTR_RW(irq_cb_effective_affinity);
> +static struct vq_sysfs_entry enable_irq_wq_attr = __ATTR_RW(enable_irq_wq);
>
>  static struct attribute *vq_attrs[] = {
>         &irq_cb_affinity_attr.attr,
>         &irq_cb_effective_affinity_attr.attr,
> +       &enable_irq_wq_attr.attr,
>         NULL,
>  };
>  ATTRIBUTE_GROUPS(vq);
> @@ -1565,6 +1612,7 @@ static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
>
>                 dev->vqs[i]->index = i;
>                 dev->vqs[i]->irq_effective_cpu = -1;
> +               dev->vqs[i]->enable_irq_wq = true;
>                 INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
>                 INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
>                 spin_lock_init(&dev->vqs[i]->kick_lock);
> --
> 2.20.1
>

