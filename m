Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4992763A5FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiK1KUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiK1KUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A51581E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669630759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0l5P9OxG4L16zXr0jD/ukLoEud1d6V20XwMekoiQR84=;
        b=BLYawBz7wzFqlLzVpQSrG/XdlfxMQXt6yGcByPjJFGd0gw2SMybYeHmJLovKKkMNViirHt
        NRzMIu2AZO5WJu8QnhThePiTgH+KYsmc0XywEfLjF1iJ6L7YyHhi6EgH45pLdgyjpa+cjN
        ZsIwavueaBRujSW4xR6s1itl0OU/qZ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-yRCV1rNpPXS7IZGplBIBFw-1; Mon, 28 Nov 2022 05:19:18 -0500
X-MC-Unique: yRCV1rNpPXS7IZGplBIBFw-1
Received: by mail-wm1-f69.google.com with SMTP id 206-20020a1c02d7000000b003d02dc20735so6126332wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:19:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l5P9OxG4L16zXr0jD/ukLoEud1d6V20XwMekoiQR84=;
        b=6dTIHq8v17ZR0SV+QMXeMSAbxIWIeprrXHdvEg61Btt9UDAhQkSbDR8JSO056KJjpJ
         6zG1tlD1Vejd9Hh+fBNsaTdLBUEfISkyGLsZ5TZS7n7GcIsGxjxXXWooB16UOjoQmwnh
         WPipgsUU5IJkOIDHmJyk40A2FAb8ZU0I0T4nzmBNmCR7tZe6cpjb/7q5fcmA4KwQTQBC
         dP8KcBFeexvp3UnMVn4YFvkdj9Mpj/AxbAT+CPvpCd9QSh8ZdPbOXgdJxuJ1ZtrnIDRx
         3D8Mqo+tsCzlz4Le0xd0ocA9mbM08ElPQRcsD09tPY1jSU+73Q40JQI+GCtFdhqqK4j4
         WQ8g==
X-Gm-Message-State: ANoB5pnWSEqzzeZVcewpQn4w+w5Jpn4PCk7OLWvuEAYjM60KtENAbL9p
        UpPqzjuEMJiBOXVYVg6H2qFCxsIk5ZJWUK0wE6e3ZfK7EXxpAQHU6YE8Wa+OYDPkCI60GdJXDaw
        r/ahttuQFbCrDbIJmxLQFFVDH
X-Received: by 2002:a05:600c:5408:b0:3d0:1c3f:e3ae with SMTP id he8-20020a05600c540800b003d01c3fe3aemr27698253wmb.27.1669630756296;
        Mon, 28 Nov 2022 02:19:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6jklsYMFz9rrbDvvZqTGEStAboHZKqsnJ98wxpOtA3Bvio+ytT7V8V1OSZasa+VPf+DzMqXw==
X-Received: by 2002:a05:600c:5408:b0:3d0:1c3f:e3ae with SMTP id he8-20020a05600c540800b003d01c3fe3aemr27698223wmb.27.1669630755997;
        Mon, 28 Nov 2022 02:19:15 -0800 (PST)
Received: from redhat.com ([2.52.149.178])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0560001c1100b00236695ff94fsm10756496wrb.34.2022.11.28.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 02:19:15 -0800 (PST)
Date:   Mon, 28 Nov 2022 05:19:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Jason Wang <jasowang@redhat.com>, stefanha@redhat.com,
        sgarzare@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
        arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpasim: support doorbell mapping
Message-ID: <20221128051555-mutt-send-email-mst@kernel.org>
References: <20221128025558.2152-1-longpeng2@huawei.com>
 <CACGkMEsWoM1LKkPWPgDALssjkk4UXxfhYm3_aCFktNnpXtWVjQ@mail.gmail.com>
 <53edc14a-74bb-f9c7-06bd-7ea1047fe613@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53edc14a-74bb-f9c7-06bd-7ea1047fe613@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 04:19:30PM +0800, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> 
> 
> 在 2022/11/28 12:05, Jason Wang 写道:
> > On Mon, Nov 28, 2022 at 10:56 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
> > > 
> > > From: Longpeng <longpeng2@huawei.com>
> > > 
> > > Support doorbell mapping for vdpasim devices, then we can test the notify
> > > passthrough feature even if there's no real hardware on hand.
> > 
> > You can use vp_vdpa in L1 plus page_ver_vq in L0 to test it in L2.
> > That is how I test it.
> > 
> Yes, using nested virtualization can work, but it's hard to deploy in my
> working environment for some reasons, so I decided to emulate this
> capability in vdpasim, it's much easier.
> 
> > > 
> > > Allocates a dummy page which used to emulate the notify page of the device.
> > > All values written to this page would be ignored,  a periodic work will
> > > check whether there're requests that need to process.
> > 
> > This seems tricky, it means the device is working even if there's no
> 
> Right. It just try to make the vdpasim device work properly, but the vdpasim
> device is only used for testing, so maybe the tricky emulation is
> acceptable?

Maybe. You can try enabling VIRTIO_F_NOTIFICATION_DATA and then
looking at the data written to figure out whether
you need to poll the vq.


> > kick. If we really want to do, we should try to use page fault handler
> > (probably by extending the config ops), but I'm not sure it's worth to
> > bother (or if we can find a use case for no simulator devices).
> > 
> This need to modify the framework, it seems unworthy.
> 
> > > 
> > > This cap is disabled as default, users can enable it as follow:
> > >    modprobe vdpa_sim notify_passthrough=true
> > > 
> > > Signed-off-by: Longpeng <longpeng2@huawei.com>
> > > ---
> > >   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 71 ++++++++++++++++++++++++++--
> > >   drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +-
> > >   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  5 +-
> > >   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  4 +-
> > >   4 files changed, 76 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > index 7438a89ce939..5c215b56b78b 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > > @@ -14,6 +14,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/sched.h>
> > >   #include <linux/dma-map-ops.h>
> > > +#include <asm/set_memory.h>
> > >   #include <linux/vringh.h>
> > >   #include <linux/vdpa.h>
> > >   #include <linux/vhost_iotlb.h>
> > > @@ -36,9 +37,15 @@ module_param(max_iotlb_entries, int, 0444);
> > >   MODULE_PARM_DESC(max_iotlb_entries,
> > >                   "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
> > > 
> > > +static bool notify_passthrough;
> > > +module_param(notify_passthrough, bool, 0444);
> > > +MODULE_PARM_DESC(notify_passthrough,
> > > +                "Enable vq notify(doorbell) area mapping. (default: false)");
> > > +
> > >   #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> > >   #define VDPASIM_QUEUE_MAX 256
> > >   #define VDPASIM_VENDOR_ID 0
> > > +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> > > 
> > >   static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> > >   {
> > > @@ -276,7 +283,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> > >          }
> > > 
> > >          vdpasim->dev_attr = *dev_attr;
> > > -       INIT_WORK(&vdpasim->work, dev_attr->work_fn);
> > > +       INIT_DELAYED_WORK(&vdpasim->vring_work, dev_attr->work_fn);
> > >          spin_lock_init(&vdpasim->lock);
> > >          spin_lock_init(&vdpasim->iommu_lock);
> > > 
> > > @@ -287,6 +294,15 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> > >          set_dma_ops(dev, &vdpasim_dma_ops);
> > >          vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
> > > 
> > > +       if (notify_passthrough) {
> > > +               vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> > > +               if (!vdpasim->notify)
> > > +                       goto err_iommu;
> > > +#ifdef CONFIG_X86
> > > +               set_memory_uc(vdpasim->notify, 1);
> > > +#endif
> > 
> > What's the reason for using uc memory?
> > 
> The vma->vm_page_prot of notify mapping is pgprot_noncached (see
> vhost_vdpa_fault) but the vdpasim->notify is WB, so we should set its
> memtype to UC here and set it back to WB when releasing the device.

You never look at this memory though. Why does it matter whether
it's UC or WB?

> > > +       }
> > > +
> > >          vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> > >          if (!vdpasim->config)
> > >                  goto err_iommu;
> > > @@ -357,8 +373,11 @@ static void vdpasim_kick_vq(struct vdpa_device *vdpa, u16 idx)
> > >          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > >          struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
> > > 
> > > +       if (notify_passthrough)
> > > +               return;
> > 
> > So we should keep the two paths to be used at the same time. Userspace
> > can choose to not map doorbells?
> > 
> It can work even if the userspace does not to map doorbells (e.g start
> without page-per-vq=on), because the device will periodic check its vqs.
> 
> > Thanks
> > 
> > > +
> > >          if (vq->ready)
> > > -               schedule_work(&vdpasim->work);
> > > +               schedule_work(&vdpasim->vring_work.work);
> > >   }
> > > 
> > >   static void vdpasim_set_vq_cb(struct vdpa_device *vdpa, u16 idx,
> > > @@ -495,6 +514,18 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
> > >          return status;
> > >   }
> > > 
> > > +static void vdpasim_set_vring_work(struct vdpasim *vdpasim, bool start)
> > > +{
> > > +       if (!notify_passthrough)
> > > +               return;
> > > +
> > > +       if (start)
> > > +               schedule_delayed_work(&vdpasim->vring_work,
> > > +                               msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> > > +       else
> > > +               cancel_delayed_work_sync(&vdpasim->vring_work);
> > > +}
> > > +
> > >   static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
> > >   {
> > >          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > @@ -502,12 +533,16 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
> > >          spin_lock(&vdpasim->lock);
> > >          vdpasim->status = status;
> > >          spin_unlock(&vdpasim->lock);
> > > +
> > > +       vdpasim_set_vring_work(vdpasim, status & VIRTIO_CONFIG_S_DRIVER_OK);
> > >   }
> > > 
> > >   static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
> > >   {
> > >          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > 
> > > +       vdpasim_set_vring_work(vdpasim, false);
> > > +
> > >          spin_lock(&vdpasim->lock);
> > >          vdpasim->status = 0;
> > >          vdpasim_do_reset(vdpasim);
> > > @@ -672,12 +707,24 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> > >          return 0;
> > >   }
> > > 
> > > +static struct vdpa_notification_area
> > > +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> > > +{
> > > +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > > +       struct vdpa_notification_area notify;
> > > +
> > > +       notify.addr = virt_to_phys((void *)vdpasim->notify);
> > > +       notify.size = PAGE_SIZE;
> > > +
> > > +       return notify;
> > > +}
> > > +
> > >   static void vdpasim_free(struct vdpa_device *vdpa)
> > >   {
> > >          struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > >          int i;
> > > 
> > > -       cancel_work_sync(&vdpasim->work);
> > > +       cancel_delayed_work_sync(&vdpasim->vring_work);
> > > 
> > >          for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> > >                  vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
> > > @@ -693,7 +740,23 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> > >          vhost_iotlb_free(vdpasim->iommu);
> > >          kfree(vdpasim->vqs);
> > >          kfree(vdpasim->config);
> > > +       if (vdpasim->notify) {
> > > +#ifdef CONFIG_X86
> > > +               set_memory_wb(vdpasim->notify, 1);
> > > +#endif
> > > +               free_page(vdpasim->notify);
> > > +       }
> > > +}
> > > +
> > > +void vdpasim_schedule_work(struct vdpasim *vdpasim, bool sched_now)
> > > +{
> > > +       if (sched_now)
> > > +               schedule_work(&vdpasim->vring_work.work);
> > > +       else if (notify_passthrough)
> > > +               schedule_delayed_work(&vdpasim->vring_work,
> > > +                                     msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> > >   }
> > > +EXPORT_SYMBOL_GPL(vdpasim_schedule_work);
> > > 
> > >   static const struct vdpa_config_ops vdpasim_config_ops = {
> > >          .set_vq_address         = vdpasim_set_vq_address,
> > > @@ -704,6 +767,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> > >          .get_vq_ready           = vdpasim_get_vq_ready,
> > >          .set_vq_state           = vdpasim_set_vq_state,
> > >          .get_vq_state           = vdpasim_get_vq_state,
> > > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > >          .get_vq_align           = vdpasim_get_vq_align,
> > >          .get_vq_group           = vdpasim_get_vq_group,
> > >          .get_device_features    = vdpasim_get_device_features,
> > > @@ -737,6 +801,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> > >          .get_vq_ready           = vdpasim_get_vq_ready,
> > >          .set_vq_state           = vdpasim_set_vq_state,
> > >          .get_vq_state           = vdpasim_get_vq_state,
> > > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > >          .get_vq_align           = vdpasim_get_vq_align,
> > >          .get_vq_group           = vdpasim_get_vq_group,
> > >          .get_device_features    = vdpasim_get_device_features,
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > > index 0e78737dcc16..da0866834918 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > > @@ -53,7 +53,7 @@ struct vdpasim_dev_attr {
> > >   struct vdpasim {
> > >          struct vdpa_device vdpa;
> > >          struct vdpasim_virtqueue *vqs;
> > > -       struct work_struct work;
> > > +       struct delayed_work vring_work;
> > >          struct vdpasim_dev_attr dev_attr;
> > >          /* spinlock to synchronize virtqueue state */
> > >          spinlock_t lock;
> > > @@ -69,10 +69,13 @@ struct vdpasim {
> > >          bool running;
> > >          /* spinlock to synchronize iommu table */
> > >          spinlock_t iommu_lock;
> > > +       /* dummy notify page */
> > > +       unsigned long notify;
> > >   };
> > > 
> > >   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> > >                                 const struct vdpa_dev_set_config *config);
> > > +void vdpasim_schedule_work(struct vdpasim *vdpasim, bool sched_now);
> > > 
> > >   /* TODO: cross-endian support */
> > >   static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > index c6db1a1baf76..8a640ea82284 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > > @@ -288,7 +288,7 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
> > > 
> > >   static void vdpasim_blk_work(struct work_struct *work)
> > >   {
> > > -       struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> > > +       struct vdpasim *vdpasim = container_of(work, struct vdpasim, vring_work.work);
> > >          bool reschedule = false;
> > >          int i;
> > > 
> > > @@ -325,8 +325,7 @@ static void vdpasim_blk_work(struct work_struct *work)
> > >   out:
> > >          spin_unlock(&vdpasim->lock);
> > > 
> > > -       if (reschedule)
> > > -               schedule_work(&vdpasim->work);
> > > +       vdpasim_schedule_work(vdpasim, reschedule);
> > >   }
> > > 
> > >   static void vdpasim_blk_get_config(struct vdpasim *vdpasim, void *config)
> > > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > index c3cb225ea469..8b998952384b 100644
> > > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > > @@ -145,7 +145,7 @@ static void vdpasim_handle_cvq(struct vdpasim *vdpasim)
> > > 
> > >   static void vdpasim_net_work(struct work_struct *work)
> > >   {
> > > -       struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> > > +       struct vdpasim *vdpasim = container_of(work, struct vdpasim, vring_work.work);
> > >          struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
> > >          struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
> > >          ssize_t read, write;
> > > @@ -196,7 +196,7 @@ static void vdpasim_net_work(struct work_struct *work)
> > >                  vdpasim_net_complete(rxq, write);
> > > 
> > >                  if (++pkts > 4) {
> > > -                       schedule_work(&vdpasim->work);
> > > +                       vdpasim_schedule_work(vdpasim, true);
> > >                          goto out;
> > >                  }
> > >          }
> > > --
> > > 2.23.0
> > > 
> > 
> > .

