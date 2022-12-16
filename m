Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1894264E71A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 06:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiLPFuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLPFuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 00:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3FC2F661
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671169770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aIxBk+Msm4O13sjTb1QciX+1tHIiARlRWZY6qhgTpxM=;
        b=NcPjp5g8+wYRBRj/1EBtG+ZZD/iLcpUFJsXkefcfcvDp1A5Dtg96TQKzLV1OSVJDMNcX/m
        vJfbhvZlYCcxm95OpHB8Y1zhqLmjTt8GHWBphE8fsYkTb02Q8NNyhvlWdG5amiHZ9zRuHe
        TBAM3BZ551Nhjgd31QHPYeiwBoqBkzU=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-p8Z7_YzjNxqGOaA0dKmb9A-1; Fri, 16 Dec 2022 00:49:28 -0500
X-MC-Unique: p8Z7_YzjNxqGOaA0dKmb9A-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-14bb44ca7d1so824066fac.14
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 21:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIxBk+Msm4O13sjTb1QciX+1tHIiARlRWZY6qhgTpxM=;
        b=nFldhIjaMTmmIFLvVK7PsixJHeEKN/hUJxdqNoqnCjnGAUMAG5REcUeAAZITy+APy0
         lPWiz9V1WF4tOhUNL0wcGSUdK8UYXo8xHXTwc8al72YJTemen9RmScUnZNL2dL8Vw0US
         jLqgi4Bn0++QmCLIxuLT369iwmPKinlR1kGqNhDaq/FnChErNUtnxwCfyn2SBMXUqmlQ
         gXBkPWWdn4ErVczvABIilUM8U5MWJCuzJ3IYvWgblHJSGbVFUwgLW7/jupr7ej8Z0ToY
         csbacXXxiX4+OtQth86c9h3QZrcBblCPBBbUkCzwC9osFVg2hSUYoIJa3bQPO4F46EdJ
         uFyQ==
X-Gm-Message-State: ANoB5pmgO7xa9s1WVpp7zFLqYUCeqE0nKvrrXrdVwZmOzzoDEW9prf1V
        LkNBS79xQB+qIsKtAhRvQhEHxn8kDrH84YKlwSS6XhI6lzBkBIGembm7PY4XLCPLfiziqfgcTyH
        ypVB/tk+1O5tpwoa4EI/3eYKf86KgmoifT6tPQozW
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id e5-20020a4ab145000000b0049f449a5f6cmr32532765ooo.93.1671169768087;
        Thu, 15 Dec 2022 21:49:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7iVK4I0QZcV+xcZthATyPM9UgivZsjcVVMMo/iGffHKjvMHCvCJbHlwV7vNPss8IAsBwI4mYfnX3KBfB6bpFM=
X-Received: by 2002:a4a:b145:0:b0:49f:449a:5f6c with SMTP id
 e5-20020a4ab145000000b0049f449a5f6cmr32532762ooo.93.1671169767681; Thu, 15
 Dec 2022 21:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205090243.791-1-xieyongji@bytedance.com>
 <20221205090243.791-4-xieyongji@bytedance.com>
In-Reply-To: <20221205090243.791-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 13:49:16 +0800
Message-ID: <CACGkMEtsk0R=NXNHaOzHgG+t9g8w5zmqt+J1KdXRGZQcFXWEkA@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] vduse: Delay iova domain creation
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
> Delay creating iova domain until the vduse device is binded
> to vdpa bus.

s/binded/registered/

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> This is a preparation for adding sysfs interface to support
> specifying bounce buffer size for the iova domain.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 75 +++++++++++++++++++++---------
>  1 file changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index ed06c7afd484..bd1ba6c33e09 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -112,6 +112,8 @@ struct vduse_dev {
>         u32 vq_align;
>         struct vduse_umem *umem;
>         struct mutex mem_lock;
> +       unsigned int bounce_size;
> +       struct mutex domain_lock;
>  };
>
>  struct vduse_dev_msg {
> @@ -427,7 +429,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         struct vduse_iova_domain *domain = dev->domain;
>
>         /* The coherent mappings are handled in vduse_dev_free_coherent() */
> -       if (domain->bounce_map)
> +       if (domain && domain->bounce_map)
>                 vduse_domain_reset_bounce_map(domain);
>
>         down_write(&dev->rwsem);
> @@ -1045,6 +1047,9 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
>                 goto unlock;
>
>         ret = -EINVAL;
> +       if (!dev->domain)
> +               goto unlock;
> +
>         if (dev->umem->iova != iova || size != dev->domain->bounce_size)
>                 goto unlock;
>
> @@ -1071,7 +1076,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
>         unsigned long npages, lock_limit;
>         int ret;
>
> -       if (!dev->domain->bounce_map ||
> +       if (!dev->domain || !dev->domain->bounce_map ||
>             size != dev->domain->bounce_size ||
>             iova != 0 || uaddr & ~PAGE_MASK)
>                 return -EINVAL;
> @@ -1145,7 +1150,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 struct vduse_iotlb_entry entry;
>                 struct vhost_iotlb_map *map;
>                 struct vdpa_map_file *map_file;
> -               struct vduse_iova_domain *domain = dev->domain;
>                 struct file *f = NULL;
>
>                 ret = -EFAULT;
> @@ -1156,8 +1160,13 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (entry.start > entry.last)
>                         break;
>
> -               spin_lock(&domain->iotlb_lock);
> -               map = vhost_iotlb_itree_first(domain->iotlb,
> +               mutex_lock(&dev->domain_lock);
> +               if (!dev->domain) {
> +                       mutex_unlock(&dev->domain_lock);
> +                       break;
> +               }
> +               spin_lock(&dev->domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(dev->domain->iotlb,
>                                               entry.start, entry.last);
>                 if (map) {
>                         map_file = (struct vdpa_map_file *)map->opaque;
> @@ -1167,7 +1176,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         entry.last = map->last;
>                         entry.perm = map->perm;
>                 }
> -               spin_unlock(&domain->iotlb_lock);
> +               spin_unlock(&dev->domain->iotlb_lock);
> +               mutex_unlock(&dev->domain_lock);
>                 ret = -EINVAL;
>                 if (!f)
>                         break;
> @@ -1319,8 +1329,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                  sizeof(umem.reserved)))
>                         break;
>
> +               mutex_lock(&dev->domain_lock);
>                 ret = vduse_dev_reg_umem(dev, umem.iova,
>                                          umem.uaddr, umem.size);
> +               mutex_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_DEREG_UMEM: {
> @@ -1334,15 +1346,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                 if (!is_mem_zero((const char *)umem.reserved,
>                                  sizeof(umem.reserved)))
>                         break;
> -
> +               mutex_lock(&dev->domain_lock);
>                 ret = vduse_dev_dereg_umem(dev, umem.iova,
>                                            umem.size);
> +               mutex_unlock(&dev->domain_lock);
>                 break;
>         }
>         case VDUSE_IOTLB_GET_INFO: {
>                 struct vduse_iova_info info;
>                 struct vhost_iotlb_map *map;
> -               struct vduse_iova_domain *domain = dev->domain;
>
>                 ret = -EFAULT;
>                 if (copy_from_user(&info, argp, sizeof(info)))
> @@ -1356,18 +1368,24 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                                  sizeof(info.reserved)))
>                         break;
>
> -               spin_lock(&domain->iotlb_lock);
> -               map = vhost_iotlb_itree_first(domain->iotlb,
> +               mutex_lock(&dev->domain_lock);
> +               if (!dev->domain) {
> +                       mutex_unlock(&dev->domain_lock);
> +                       break;
> +               }
> +               spin_lock(&dev->domain->iotlb_lock);
> +               map = vhost_iotlb_itree_first(dev->domain->iotlb,
>                                               info.start, info.last);
>                 if (map) {
>                         info.start = map->start;
>                         info.last = map->last;
>                         info.capability = 0;
> -                       if (domain->bounce_map && map->start == 0 &&
> -                           map->last == domain->bounce_size - 1)
> +                       if (dev->domain->bounce_map && map->start == 0 &&
> +                           map->last == dev->domain->bounce_size - 1)
>                                 info.capability |= VDUSE_IOVA_CAP_UMEM;
>                 }
> -               spin_unlock(&domain->iotlb_lock);
> +               spin_unlock(&dev->domain->iotlb_lock);
> +               mutex_unlock(&dev->domain_lock);
>                 if (!map)
>                         break;
>
> @@ -1390,7 +1408,10 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
>  {
>         struct vduse_dev *dev = file->private_data;
>
> -       vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       mutex_lock(&dev->domain_lock);
> +       if (dev->domain)
> +               vduse_dev_dereg_umem(dev, 0, dev->domain->bounce_size);
> +       mutex_unlock(&dev->domain_lock);
>         spin_lock(&dev->msg_lock);
>         /* Make sure the inflight messages can processed after reconncection */
>         list_splice_init(&dev->recv_list, &dev->send_list);
> @@ -1647,6 +1668,7 @@ static struct vduse_dev *vduse_dev_create(void)
>
>         mutex_init(&dev->lock);
>         mutex_init(&dev->mem_lock);
> +       mutex_init(&dev->domain_lock);
>         spin_lock_init(&dev->msg_lock);
>         INIT_LIST_HEAD(&dev->send_list);
>         INIT_LIST_HEAD(&dev->recv_list);
> @@ -1696,7 +1718,8 @@ static int vduse_destroy_dev(char *name)
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
>         vduse_dev_deinit_vqs(dev);
> -       vduse_domain_destroy(dev->domain);
> +       if (dev->domain)
> +               vduse_domain_destroy(dev->domain);
>         kfree(dev->name);
>         vduse_dev_destroy(dev);
>         module_put(THIS_MODULE);
> @@ -1802,11 +1825,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>         if (!dev->name)
>                 goto err_str;
>
> -       dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> -                                         VDUSE_BOUNCE_SIZE);
> -       if (!dev->domain)
> -               goto err_domain;
> -
> +       dev->bounce_size = VDUSE_BOUNCE_SIZE;
>         dev->config = config_buf;
>         dev->config_size = config->config_size;
>
> @@ -1836,8 +1855,6 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -       vduse_domain_destroy(dev->domain);
> -err_domain:
>         kfree(dev->name);
>  err_str:
>         vduse_dev_destroy(dev);
> @@ -2004,9 +2021,23 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         if (ret)
>                 return ret;
>
> +       mutex_lock(&dev->domain_lock);
> +       if (!dev->domain)
> +               dev->domain = vduse_domain_create(VDUSE_IOVA_SIZE - 1,
> +                                                 dev->bounce_size);
> +       mutex_unlock(&dev->domain_lock);
> +       if (!dev->domain) {
> +               put_device(&dev->vdev->vdpa.dev);
> +               return -ENOMEM;
> +       }
> +
>         ret = _vdpa_register_device(&dev->vdev->vdpa, dev->vq_num);
>         if (ret) {
>                 put_device(&dev->vdev->vdpa.dev);
> +               mutex_lock(&dev->domain_lock);
> +               vduse_domain_destroy(dev->domain);
> +               dev->domain = NULL;
> +               mutex_unlock(&dev->domain_lock);
>                 return ret;
>         }
>
> --
> 2.20.1
>

