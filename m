Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C92643D61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiLFHAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLFHAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:00:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCBC1AD83
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 22:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670309977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVXWtcezAuDTCzgOoeiquxdfJOiL8JgFiF/95l+Ohtk=;
        b=A490pkBD8dnDncbDFKCp3cs+3UA4P9b/jAPUA2NBFEFxDLLkPF4vfmjKEuRMXQbvn4dADq
        lyhaD2R45GKD+VMUzOHJgHJ9pNEEOnbWWmuxtgrJlWUNo/xa8zIwZgy+/E0RyAhxQbJspu
        N0biFPRtEsJqu1NEMo0SfIy9uzz+qWo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-O7fFSq6VOY-fNXM6LNvzlw-1; Tue, 06 Dec 2022 01:59:34 -0500
X-MC-Unique: O7fFSq6VOY-fNXM6LNvzlw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-143c7a3da8aso6169160fac.23
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 22:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVXWtcezAuDTCzgOoeiquxdfJOiL8JgFiF/95l+Ohtk=;
        b=v4783xk2gXlhCD5jhkDJyYsuY5j1XchDDRFVRjl4IwWcQQcWvqwckE8Ic6w2G51HAg
         fgYvxWtKCZ9RQ44zoqwVRRrIJyQ0ow6hbfdTx5HgvNPTL70sAWr5dokeUpDA3BVKJXye
         4QdAtS4WezE+BSMjm1ZSf/jYY3We9sWLwGC1e2642Z154YUCG0jPM/xlIJZ5WQSgbeRN
         FTwegx15LHZAzkD8Dam75xOXb/z5xM9EwKFXZFP9MauZAl8Fo/z1CS3g/mecHasi8NYl
         qpaPc0tBi9jwBz3uWr2jdTEHL7iO8sbR76bZjTvEZr/PS08NfN9dubrft0DvRE62TM03
         dpMQ==
X-Gm-Message-State: ANoB5pmq/okk20ORDmofagR22TWol7rWW9YOr7jmcT6DqQ0Ksl/Zq50A
        +GeSs81GPuZb5F9/zaCkjKDkSiFCvMibwbIV48EXAkysw3WvZLTj09dEGYdgDEYTE5KiZ28qHGD
        Jer7iwQIO8GK6SDwOXg9oYICFrTSiePBs28fPOLGu
X-Received: by 2002:a05:6808:2093:b0:35b:ded0:4164 with SMTP id s19-20020a056808209300b0035bded04164mr11181059oiw.280.1670309973782;
        Mon, 05 Dec 2022 22:59:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5rvyTmeQpVvgJBn/MecdYq8NqoQO4tQChNa9R/rwEI12bb6rTrX/QSxo7SuCGcodGO/sWWyJO0Lb6IboY80lc=
X-Received: by 2002:a05:6808:2093:b0:35b:ded0:4164 with SMTP id
 s19-20020a056808209300b0035bded04164mr11181054oiw.280.1670309973522; Mon, 05
 Dec 2022 22:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20221205135130.2336-1-longpeng2@huawei.com>
In-Reply-To: <20221205135130.2336-1-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 6 Dec 2022 14:59:22 +0800
Message-ID: <CACGkMEtdT5fG=ffbpQadkGmzHf6Ax-+L50LsriYqJaW++natMg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpasim: support doorbell mapping
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     stefanha@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        eperezma@redhat.com, cohuck@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
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

On Mon, Dec 5, 2022 at 9:52 PM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> Support doorbell mapping for vdpasim devices, then we can test the notify
> passthrough feature even if there's no real hardware on hand.
>
> Allocates a dummy page which is used to emulate the notify page of the device,
> all VQs share the same notify register  that initiated to 0xffff. A  periodic
> work will check whether there're requests need to process ( the value of the
> notify register is 0xffff or not ).
>
> This cap is disabled as default, users can enable it as follow:
>   modprobe vdpa_sim notify_passthrough=true
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> Changes v1->v2:
>   - support both kick mode and passthrough mode. [Jason]
>   - poll the notify register first. [Jason, Michael]
> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 77 ++++++++++++++++++++++++++++++++
>  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
>  2 files changed, 80 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 7438a89ce939..07096a04dabb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/dma-map-ops.h>
> +#include <asm/set_memory.h>
>  #include <linux/vringh.h>
>  #include <linux/vdpa.h>
>  #include <linux/vhost_iotlb.h>
> @@ -36,9 +37,16 @@ module_param(max_iotlb_entries, int, 0444);
>  MODULE_PARM_DESC(max_iotlb_entries,
>                  "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
>
> +static bool notify_passthrough;
> +module_param(notify_passthrough, bool, 0444);
> +MODULE_PARM_DESC(notify_passthrough,
> +                "Enable vq notify(doorbell) area mapping. (default: false)");

I'm not sure if it's worth doing this, I think we can afford the cost
of periodic work (especially considering it's a simulator).

> +
>  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>  #define VDPASIM_QUEUE_MAX 256
>  #define VDPASIM_VENDOR_ID 0
> +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> +#define VDPASIM_NOTIFY_DEFVAL 0xffff
>
>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>  {
> @@ -246,6 +254,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
>  static const struct vdpa_config_ops vdpasim_config_ops;
>  static const struct vdpa_config_ops vdpasim_batch_config_ops;
>
> +static void vdpasim_notify_work(struct work_struct *work)
> +{
> +       struct vdpasim *vdpasim;
> +       u16 *val;
> +
> +       vdpasim = container_of(work, struct vdpasim, notify_work.work);
> +
> +       if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               goto out;
> +
> +       if (!vdpasim->running)
> +               goto out;
> +
> +       val = (u16 *)vdpasim->notify;
> +       if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
> +               schedule_work(&vdpasim->work);
> +
> +out:
> +       schedule_delayed_work(&vdpasim->notify_work,
> +                             msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +}
> +
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>                                const struct vdpa_dev_set_config *config)
>  {
> @@ -287,6 +317,18 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>         set_dma_ops(dev, &vdpasim_dma_ops);
>         vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
>
> +       if (notify_passthrough) {
> +               INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
> +
> +               vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> +               if (!vdpasim->notify)
> +                       goto err_iommu;
> +#ifdef CONFIG_X86
> +               set_memory_uc(vdpasim->notify, 1);
> +#endif

I had the same question with version 1, any reason for having this
part uncacheable? It's a hint that we have bugs somewhere. Are we
missing ACCESS/ORDER_PLATFORM or other features?

> +               *(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;

WRITE_ONCE()?

> +       }
> +
>         vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
>         if (!vdpasim->config)
>                 goto err_iommu;
> @@ -495,6 +537,18 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
>         return status;
>  }
>
> +static void vdpasim_set_notify_work(struct vdpasim *vdpasim, bool start)
> +{
> +       if (!notify_passthrough)
> +               return;

Only two callers for this function: one is start another is stop. If
we decide to get rid of notify_passthrough, I'd rather opencode the
schedule/cancel_delayed().

Thanks

> +
> +       if (start)
> +               schedule_delayed_work(&vdpasim->notify_work,
> +                                     msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +       else
> +               cancel_delayed_work_sync(&vdpasim->notify_work);
> +}
> +
>  static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> @@ -502,12 +556,14 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>         spin_lock(&vdpasim->lock);
>         vdpasim->status = status;
>         spin_unlock(&vdpasim->lock);
> +       vdpasim_set_notify_work(vdpasim, status & VIRTIO_CONFIG_S_DRIVER_OK);
>  }
>
>  static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> +       vdpasim_set_notify_work(vdpasim, false);
>         spin_lock(&vdpasim->lock);
>         vdpasim->status = 0;
>         vdpasim_do_reset(vdpasim);
> @@ -672,11 +728,24 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
>         return 0;
>  }
>
> +static struct vdpa_notification_area
> +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +       struct vdpa_notification_area notify;
> +
> +       notify.addr = virt_to_phys((void *)vdpasim->notify);
> +       notify.size = PAGE_SIZE;
> +
> +       return notify;
> +}
> +
>  static void vdpasim_free(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>         int i;
>
> +       vdpasim_set_notify_work(vdpasim, false);
>         cancel_work_sync(&vdpasim->work);
>
>         for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> @@ -693,6 +762,12 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>         vhost_iotlb_free(vdpasim->iommu);
>         kfree(vdpasim->vqs);
>         kfree(vdpasim->config);
> +       if (vdpasim->notify) {
> +#ifdef CONFIG_X86
> +               set_memory_wb(vdpasim->notify, 1);
> +#endif
> +               free_page(vdpasim->notify);
> +       }
>  }
>
>  static const struct vdpa_config_ops vdpasim_config_ops = {
> @@ -704,6 +779,7 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .get_vq_ready           = vdpasim_get_vq_ready,
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
> +       .get_vq_notification    = vdpasim_get_vq_notification,
>         .get_vq_align           = vdpasim_get_vq_align,
>         .get_vq_group           = vdpasim_get_vq_group,
>         .get_device_features    = vdpasim_get_device_features,
> @@ -737,6 +813,7 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .get_vq_ready           = vdpasim_get_vq_ready,
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
> +       .get_vq_notification    = vdpasim_get_vq_notification,
>         .get_vq_align           = vdpasim_get_vq_align,
>         .get_vq_group           = vdpasim_get_vq_group,
>         .get_device_features    = vdpasim_get_device_features,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..0769ccbd3911 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -69,6 +69,9 @@ struct vdpasim {
>         bool running;
>         /* spinlock to synchronize iommu table */
>         spinlock_t iommu_lock;
> +       /* dummy notify page */
> +       unsigned long notify;
> +       struct delayed_work notify_work;
>  };
>
>  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> --
> 2.23.0
>

