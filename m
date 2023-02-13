Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C4694536
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjBMMHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBMMH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67B1A941
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676289927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UaQt4tD4vN8vEYX8llmTWE5DxpRIBPo44MMhOl7gUpg=;
        b=imJWKjju1CEZMeAwKx4I1H0BFKJWy4Rgh/74jiYC15ZWXwW2i8jTpqNuh0zjAoYyPwOQSO
        doO16mF3mSHylXpLjJgHfjz8BmdCWsqVPPajMHAu0krsTuZ39nL1LkaXnJDDB65FJb9TQ9
        pqqYxclexV2pkxLd0hn7ayaK5UhMnWM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-112-LZ9PUgRwOmCVx3gFh4h_UA-1; Mon, 13 Feb 2023 07:05:26 -0500
X-MC-Unique: LZ9PUgRwOmCVx3gFh4h_UA-1
Received: by mail-ej1-f69.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so7442444ejc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UaQt4tD4vN8vEYX8llmTWE5DxpRIBPo44MMhOl7gUpg=;
        b=kSvDJs10s1I0U7QDlbh/MkiliyGgu5KpMvkiT+J9r7fpFQdZzjEcY/GLeyG1lzJ3yx
         70cGFw0WWMXNyoorJ8a4WB5ni32GxZciOqDdoB4Q5/AgBalfQ6FfCzsU/gK4zjsVFS4S
         i1V5oi9er+rUZduwxTLnp6oNVBxJXt0eTeSaNW58hnyeE+929tf4M3VZqeIrF62U+XTq
         bXH1SCA24jhPyWSlDrvTiZV/mUDUHtJc+PSp081FhXtVU3602v6rT8o6cBD0TAQ91Knt
         AJkvgrNRFvErP0I3JcCsoiHb8JHA/bagh5jAU/HzV/pSJskRxj/zF/hP0ofYIwMxjrze
         T0dw==
X-Gm-Message-State: AO0yUKVFu+VDgjPQecR0WK7GoAp+FoRWbaVAASSBC6xTszKhLATU+I41
        VrfKjYg7p1UKAzW6OuWcz3BHtenQrdl/R7q9Zq2Wi2fuO4bAMC7VNdAjyjh8thpfY24H7drLuyx
        VgaAxtEgSWIhXnbQwXxQbcRNb
X-Received: by 2002:a50:cc8f:0:b0:4aa:a9c7:4224 with SMTP id q15-20020a50cc8f000000b004aaa9c74224mr25967284edi.30.1676289925622;
        Mon, 13 Feb 2023 04:05:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8C1H8SL3svwiLGRb2G1yS7hB3/rkA0BDJCFoYEwc0XZzusUMp7unwZ5t+nSHnK6QZN4dA0ag==
X-Received: by 2002:a50:cc8f:0:b0:4aa:a9c7:4224 with SMTP id q15-20020a50cc8f000000b004aaa9c74224mr25967266edi.30.1676289925379;
        Mon, 13 Feb 2023 04:05:25 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id t16-20020a508d50000000b004acbe66e653sm2661308edt.84.2023.02.13.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 04:05:24 -0800 (PST)
Date:   Mon, 13 Feb 2023 07:05:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Longpeng(Mike)" <longpeng2@huawei.com>, stefanha@redhat.com,
        sgarzare@redhat.com, arei.gonglei@huawei.com, yechuan@huawei.com,
        huangzhichao@huawei.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
Subject: Re: [PATCH v3 2/2] vdpasim: support doorbell mapping
Message-ID: <20230213070446-mutt-send-email-mst@kernel.org>
References: <20230129025034.2000-1-longpeng2@huawei.com>
 <20230129025034.2000-3-longpeng2@huawei.com>
 <CACGkMEvZsfxQW0fVdy0CpqxoWQzz6z=dYK__xFisncuSRms67A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvZsfxQW0fVdy0CpqxoWQzz6z=dYK__xFisncuSRms67A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 02:19:51PM +0800, Jason Wang wrote:
> On Sun, Jan 29, 2023 at 10:51 AM Longpeng(Mike) <longpeng2@huawei.com> wrote:
> >
> > From: Longpeng <longpeng2@huawei.com>
> >
> > Support doorbell mapping for vdpasim devices, then we can test the notify
> > passthrough feature even if there's no real hardware on hand.
> >
> > Allocates a dummy page which is used to emulate the notify page of the device,
> > all VQs share the same notify register  that initiated to 0xffff. A  periodic
> > work will check whether there're requests need to process ( the value of the
> > notify register is 0xffff or not ).
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c | 65 ++++++++++++++++++++++++++++++++
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index b071f0d842fb..4fcfeb6e2fb8 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -39,6 +39,8 @@ MODULE_PARM_DESC(max_iotlb_entries,
> >  #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
> >  #define VDPASIM_QUEUE_MAX 256
> >  #define VDPASIM_VENDOR_ID 0
> > +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> > +#define VDPASIM_NOTIFY_DEFVAL 0xffff
> >
> >  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
> >  {
> > @@ -246,6 +248,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
> >  static const struct vdpa_config_ops vdpasim_config_ops;
> >  static const struct vdpa_config_ops vdpasim_batch_config_ops;
> >
> > +static void vdpasim_notify_work(struct work_struct *work)
> > +{
> > +       struct vdpasim *vdpasim;
> > +       u16 *val;
> > +
> > +       vdpasim = container_of(work, struct vdpasim, notify_work.work);
> > +
> > +       if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +               goto out;
> > +
> > +       if (!vdpasim->running)
> > +               goto out;
> > +
> > +       val = (u16 *)vdpasim->notify;
> > +       if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
> > +               schedule_work(&vdpasim->work);
> > +
> > +out:
> > +       schedule_delayed_work(&vdpasim->notify_work,
> > +                             msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> > +}
> > +
> >  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >                                const struct vdpa_dev_set_config *config)
> >  {
> > @@ -287,6 +311,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         set_dma_ops(dev, &vdpasim_dma_ops);
> >         vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
> >
> > +       INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
> > +
> > +       vdpasim->notify = __get_free_page(GFP_KERNEL | __GFP_ZERO);
> > +       if (!vdpasim->notify)
> > +               goto err_iommu;
> 
> We can simply avoid the advertising notification area in this case.
> 
> > +       *(u16 *)vdpasim->notify = VDPASIM_NOTIFY_DEFVAL;
> 
> WRITE_ONCE()?

it is just initialization so it should not matter.

> > +
> >         vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> >         if (!vdpasim->config)
> >                 goto err_iommu;
> > @@ -498,16 +529,21 @@ static u8 vdpasim_get_status(struct vdpa_device *vdpa)
> >  static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       bool started = vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK;
> 
> Do we need to do the check under the vdpasim->lock?
> 
> >
> >         spin_lock(&vdpasim->lock);
> >         vdpasim->status = status;
> >         spin_unlock(&vdpasim->lock);
> > +       if (!started && (status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +               schedule_delayed_work(&vdpasim->notify_work,
> > +                                     msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> >  }
> >
> >  static int vdpasim_reset(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >
> > +       cancel_delayed_work_sync(&vdpasim->notify_work);
> 
> Do we need to do this after setting running to zero? Otherwise it's racy.
> 
> Thanks
> 
> >         spin_lock(&vdpasim->lock);
> >         vdpasim->status = 0;
> >         vdpasim_do_reset(vdpasim);
> > @@ -672,11 +708,34 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
> >         return 0;
> >  }
> >
> > +static pgprot_t vdpasim_get_vq_notification_pgprot(struct vdpa_device *vdpa,
> > +                                                  u16 qid, pgprot_t prot)
> > +{
> > +       /*
> > +        * We use normal RAM pages to emulate the vq notification area, so
> > +        * just keep the pgprot as it mmaped.
> > +        */
> > +       return prot;
> > +}
> > +
> > +static struct vdpa_notification_area
> > +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> > +{
> > +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> > +       struct vdpa_notification_area notify;
> > +
> > +       notify.addr = virt_to_phys((void *)vdpasim->notify);
> > +       notify.size = PAGE_SIZE;
> > +
> > +       return notify;
> > +}
> > +
> >  static void vdpasim_free(struct vdpa_device *vdpa)
> >  {
> >         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> >         int i;
> >
> > +       cancel_delayed_work_sync(&vdpasim->notify_work);
> >         cancel_work_sync(&vdpasim->work);
> >
> >         for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> > @@ -693,6 +752,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> >         vhost_iotlb_free(vdpasim->iommu);
> >         kfree(vdpasim->vqs);
> >         kfree(vdpasim->config);
> > +       if (vdpasim->notify)
> > +               free_page(vdpasim->notify);
> >  }
> >
> >  static const struct vdpa_config_ops vdpasim_config_ops = {
> > @@ -704,6 +765,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
> >         .get_vq_ready           = vdpasim_get_vq_ready,
> >         .set_vq_state           = vdpasim_set_vq_state,
> >         .get_vq_state           = vdpasim_get_vq_state,
> > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > +       .get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
> >         .get_vq_align           = vdpasim_get_vq_align,
> >         .get_vq_group           = vdpasim_get_vq_group,
> >         .get_device_features    = vdpasim_get_device_features,
> > @@ -737,6 +800,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
> >         .get_vq_ready           = vdpasim_get_vq_ready,
> >         .set_vq_state           = vdpasim_set_vq_state,
> >         .get_vq_state           = vdpasim_get_vq_state,
> > +       .get_vq_notification    = vdpasim_get_vq_notification,
> > +       .get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
> >         .get_vq_align           = vdpasim_get_vq_align,
> >         .get_vq_group           = vdpasim_get_vq_group,
> >         .get_device_features    = vdpasim_get_device_features,
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..0769ccbd3911 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -69,6 +69,9 @@ struct vdpasim {
> >         bool running;
> >         /* spinlock to synchronize iommu table */
> >         spinlock_t iommu_lock;
> > +       /* dummy notify page */
> > +       unsigned long notify;
> > +       struct delayed_work notify_work;
> >  };
> >
> >  struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,
> > --
> > 2.23.0
> >

