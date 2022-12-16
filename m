Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45A64E689
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 05:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLPEAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 23:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLPEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 23:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEB74B9AB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671163173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWnuzCbPG4uJ1dxev0ulzuRMdlEdDNxB2uAT7N/aH2A=;
        b=eqoIF9lw1b4alUMyxfnQ82Ifk52TLFReA7VY6wu6ATf59Z7ifBJHOP5X+MInaKr0T1YwzR
        0/nbMS50RL0CLOGSE/rQNOMoeosw8o9uesY2DRKCBFZpoCCCmmNaOsDIl5g9W+pwerFZhh
        Y4JnVfM79IwMWEjlTQr/FU3dhCnrwII=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-641-0zNnmQSyPD2JgxA8HDljTg-1; Thu, 15 Dec 2022 22:59:30 -0500
X-MC-Unique: 0zNnmQSyPD2JgxA8HDljTg-1
Received: by mail-ot1-f70.google.com with SMTP id v17-20020a9d7d11000000b0066c33c3e0easo686318otn.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 19:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWnuzCbPG4uJ1dxev0ulzuRMdlEdDNxB2uAT7N/aH2A=;
        b=P2Yflwzb7zgQNdIaUh0QN6+oGSU2Q9UzAkOoI/PEY97p6+xMq+Y4sCpWh0lJ6+9gJG
         vrlufSlQxagclwdo4GOH/Tx5/AQ7HZI0TAkiPWDWgP5aP0SaZUhhLyRYA/DQW/dSdclZ
         z/W1tuVMmuZjZHNaBomDl2yjYu4tMyM8EcNbEwtwKQmrhfqOFw2pjyphnmmpW3OtfO2e
         8NZTOV1L7pueBAE2P6PW8XVAVBIDufQWfpNzzIk2Z9eecyHJdBlDQ4j8gdac9uQqiTKB
         GOJUDX9mamBh50GoKxr7s/MDu4RlyimWI65qEIVauhoY2D7lvL6udG54/bCzibKQr8jr
         v4XA==
X-Gm-Message-State: AFqh2kpJvskEPcXwTn0BAYMOuloEXpn2z9May1S61PnpzGHDCCCIVpC7
        TOkRIZybiSmXpy5qsdlYPORBYZ+bbJjMflaFKqG+kBPIqEY0r6xXwpxxlU5XNZbPTAP6ZRsKuVb
        fBhs/w3N4W6U9n2E/FGmET6pZkLzPKIVZNNqZqBJ/
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id nw26-20020a056870bb1a00b00144b22a38d3mr834758oab.280.1671163170051;
        Thu, 15 Dec 2022 19:59:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuJhmlBeVhUrrBQ9gVMjQ0Kw5grrbESGD6xQnAEUSaxQgQjL8QLt8cHd0ivBYoaaaaJd4aIT6bS6U/KayXfxas=
X-Received: by 2002:a05:6870:bb1a:b0:144:b22a:38d3 with SMTP id
 nw26-20020a056870bb1a00b00144b22a38d3mr834756oab.280.1671163169810; Thu, 15
 Dec 2022 19:59:29 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com> <20221205084127.535-5-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-5-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 16 Dec 2022 11:59:18 +0800
Message-ID: <CACGkMEtpFUp_1KdEiPnp75wvvDw6Qyu7CGeuHu3L+O6yfU9-mw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] vduse: Refactor allocation for vduse virtqueues
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

On Mon, Dec 5, 2022 at 4:44 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> Allocate memory for vduse virtqueues one by one instead of
> doing one allocation for all of them.
>
> This is a preparation for adding sysfs interface for virtqueues.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 98 ++++++++++++++++++++----------
>  1 file changed, 66 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..37809bfcb7ef 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -76,7 +76,7 @@ struct vduse_umem {
>  struct vduse_dev {
>         struct vduse_vdpa *vdev;
>         struct device *dev;
> -       struct vduse_virtqueue *vqs;
> +       struct vduse_virtqueue **vqs;
>         struct vduse_iova_domain *domain;
>         char *name;
>         struct mutex lock;
> @@ -434,7 +434,7 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>         flush_work(&dev->inject);
>
>         for (i = 0; i < dev->vq_num; i++) {
> -               struct vduse_virtqueue *vq = &dev->vqs[i];
> +               struct vduse_virtqueue *vq = dev->vqs[i];
>
>                 vq->ready = false;
>                 vq->desc_addr = 0;
> @@ -466,7 +466,7 @@ static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>                                 u64 device_area)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         vq->desc_addr = desc_area;
>         vq->driver_addr = driver_area;
> @@ -500,7 +500,7 @@ static void vduse_vq_kick_work(struct work_struct *work)
>  static void vduse_vdpa_kick_vq(struct vdpa_device *vdpa, u16 idx)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         if (!eventfd_signal_allowed()) {
>                 schedule_work(&vq->kick);
> @@ -513,7 +513,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
>                               struct vdpa_callback *cb)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         spin_lock(&vq->irq_lock);
>         vq->cb.callback = cb->callback;
> @@ -524,7 +524,7 @@ static void vduse_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
>  static void vduse_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 idx, u32 num)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         vq->num = num;
>  }
> @@ -533,7 +533,7 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
>                                         u16 idx, bool ready)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         vq->ready = ready;
>  }
> @@ -541,7 +541,7 @@ static void vduse_vdpa_set_vq_ready(struct vdpa_device *vdpa,
>  static bool vduse_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         return vq->ready;
>  }
> @@ -550,7 +550,7 @@ static int vduse_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 const struct vdpa_vq_state *state)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED)) {
>                 vq->state.packed.last_avail_counter =
> @@ -569,7 +569,7 @@ static int vduse_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 idx,
>                                 struct vdpa_vq_state *state)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -       struct vduse_virtqueue *vq = &dev->vqs[idx];
> +       struct vduse_virtqueue *vq = dev->vqs[idx];
>
>         if (dev->driver_features & BIT_ULL(VIRTIO_F_RING_PACKED))
>                 return vduse_dev_get_vq_state_packed(dev, vq, &state->packed);
> @@ -624,8 +624,8 @@ static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
>         int i;
>
>         for (i = 0; i < dev->vq_num; i++)
> -               if (num_max < dev->vqs[i].num_max)
> -                       num_max = dev->vqs[i].num_max;
> +               if (num_max < dev->vqs[i]->num_max)
> +                       num_max = dev->vqs[i]->num_max;
>
>         return num_max;
>  }
> @@ -863,7 +863,7 @@ static int vduse_kickfd_setup(struct vduse_dev *dev,
>                 return -EINVAL;
>
>         index = array_index_nospec(eventfd->index, dev->vq_num);
> -       vq = &dev->vqs[index];
> +       vq = dev->vqs[index];
>         if (eventfd->fd >= 0) {
>                 ctx = eventfd_ctx_fdget(eventfd->fd);
>                 if (IS_ERR(ctx))
> @@ -889,7 +889,7 @@ static bool vduse_dev_is_ready(struct vduse_dev *dev)
>         int i;
>
>         for (i = 0; i < dev->vq_num; i++)
> -               if (!dev->vqs[i].num_max)
> +               if (!dev->vqs[i]->num_max)
>                         return false;
>
>         return true;
> @@ -1130,7 +1130,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 index = array_index_nospec(config.index, dev->vq_num);
> -               dev->vqs[index].num_max = config.max_size;
> +               dev->vqs[index]->num_max = config.max_size;
>                 ret = 0;
>                 break;
>         }
> @@ -1148,7 +1148,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 index = array_index_nospec(vq_info.index, dev->vq_num);
> -               vq = &dev->vqs[index];
> +               vq = dev->vqs[index];
>                 vq_info.desc_addr = vq->desc_addr;
>                 vq_info.driver_addr = vq->driver_addr;
>                 vq_info.device_addr = vq->device_addr;
> @@ -1198,7 +1198,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>                         break;
>
>                 index = array_index_nospec(index, dev->vq_num);
> -               ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
> +               ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index]->inject);
>                 break;
>         }
>         case VDUSE_IOTLB_REG_UMEM: {
> @@ -1339,6 +1339,49 @@ static const struct file_operations vduse_dev_fops = {
>         .llseek         = noop_llseek,
>  };
>
> +static void vduse_dev_deinit_vqs(struct vduse_dev *dev)
> +{
> +       int i;
> +
> +       if (!dev->vqs)
> +               return;
> +
> +       for (i = 0; i < dev->vq_num; i++)
> +               kfree(dev->vqs[i]);
> +       kfree(dev->vqs);
> +}
> +
> +static int vduse_dev_init_vqs(struct vduse_dev *dev, u32 vq_align, u32 vq_num)
> +{
> +       int i;
> +
> +       dev->vq_align = vq_align;
> +       dev->vq_num = vq_num;
> +       dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> +       if (!dev->vqs)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < vq_num; i++) {
> +               dev->vqs[i] = kzalloc(sizeof(*dev->vqs[i]), GFP_KERNEL);
> +               if (!dev->vqs[i])
> +                       goto err;
> +
> +               dev->vqs[i]->index = i;
> +               INIT_WORK(&dev->vqs[i]->inject, vduse_vq_irq_inject);
> +               INIT_WORK(&dev->vqs[i]->kick, vduse_vq_kick_work);
> +               spin_lock_init(&dev->vqs[i]->kick_lock);
> +               spin_lock_init(&dev->vqs[i]->irq_lock);
> +       }
> +
> +       return 0;
> +err:
> +       while (i--)
> +               kfree(dev->vqs[i]);
> +       kfree(dev->vqs);
> +       dev->vqs = NULL;
> +       return -ENOMEM;
> +}
> +
>  static struct vduse_dev *vduse_dev_create(void)
>  {
>         struct vduse_dev *dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> @@ -1396,7 +1439,7 @@ static int vduse_destroy_dev(char *name)
>         device_destroy(vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
>         idr_remove(&vduse_idr, dev->minor);
>         kvfree(dev->config);
> -       kfree(dev->vqs);
> +       vduse_dev_deinit_vqs(dev);
>         vduse_domain_destroy(dev->domain);
>         kfree(dev->name);
>         vduse_dev_destroy(dev);
> @@ -1483,7 +1526,7 @@ ATTRIBUTE_GROUPS(vduse_dev);
>  static int vduse_create_dev(struct vduse_dev_config *config,
>                             void *config_buf, u64 api_version)
>  {
> -       int i, ret;
> +       int ret;
>         struct vduse_dev *dev;
>
>         ret = -EEXIST;
> @@ -1510,19 +1553,10 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>
>         dev->config = config_buf;
>         dev->config_size = config->config_size;
> -       dev->vq_align = config->vq_align;
> -       dev->vq_num = config->vq_num;
> -       dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> -       if (!dev->vqs)
> -               goto err_vqs;
>
> -       for (i = 0; i < dev->vq_num; i++) {
> -               dev->vqs[i].index = i;
> -               INIT_WORK(&dev->vqs[i].inject, vduse_vq_irq_inject);
> -               INIT_WORK(&dev->vqs[i].kick, vduse_vq_kick_work);
> -               spin_lock_init(&dev->vqs[i].kick_lock);
> -               spin_lock_init(&dev->vqs[i].irq_lock);
> -       }
> +       ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
> +       if (ret)
> +               goto err_vqs;
>
>         ret = idr_alloc(&vduse_idr, dev, 1, VDUSE_DEV_MAX, GFP_KERNEL);
>         if (ret < 0)
> @@ -1543,7 +1577,7 @@ static int vduse_create_dev(struct vduse_dev_config *config,
>  err_dev:
>         idr_remove(&vduse_idr, dev->minor);
>  err_idr:
> -       kfree(dev->vqs);
> +       vduse_dev_deinit_vqs(dev);
>  err_vqs:
>         vduse_domain_destroy(dev->domain);
>  err_domain:
> --
> 2.20.1
>

