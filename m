Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1CE6A664C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCADIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjCADH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A283527D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677640029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+vAPtXXMjEgI8QMMfzd18RHzDoZyhEmlj8SjpkMiKQ=;
        b=IT6n4tKVt3k4D5pdz4e9qffdHLBa9lyK06nav8tLRoR0Le4//3oX+dYf49T3z2fVgDLH1W
        1XJ8hDrpEB1fN9CzLdGRgtXeRtisQRPoXfjKIrJ91GPcvcD6CDHUmySJuWLiqnbV1wLAsZ
        9MxR5IxkKwcAQeLxbRO6DM50bDnRJGs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-URTJAy4dMyebHcmjttB-7g-1; Tue, 28 Feb 2023 22:07:08 -0500
X-MC-Unique: URTJAy4dMyebHcmjttB-7g-1
Received: by mail-pf1-f200.google.com with SMTP id cj27-20020a056a00299b00b005f1ef2e4e1aso4733522pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+vAPtXXMjEgI8QMMfzd18RHzDoZyhEmlj8SjpkMiKQ=;
        b=ofhblD6bisnG04BddCn4Id8uwfRIFxHLGtQXq+YeyNEwKmYfAZqEI1axjL34ga8ek5
         Wnm6LvLUViH89W/CdHcWZboOgZwOEm+ClRvCten0tO9qfg7k22f8AWfm97Fx7RMZWasT
         5C7+nkLjqfIAvZkGHL8LU9Y+PZj6P4tvj1kzreqN30EizxCbg9C1U0dBBY/00AVgMuzE
         nZz8PWKNgQBJSG5pW+vwF6ghyy+D8Q2xGnRn0IoaupCb9GTKPDHe8jzELbTlzRV8dor7
         H7ju2DQHM7cF4zV472CVcTSuR3HDoHQHM7+gyFzVjulX3ulrkj1GFQkF3eqM+t4YLXXK
         fmjA==
X-Gm-Message-State: AO0yUKVOprYNOz6T8ljZiHd3VZ6b6bOXa5NWi3UyUjwX0/iUow0o3aSK
        AHqk7EoJ21GM6rdvMs4JzmqrUQ//BY6PSgM/cYB8GXTmU3cZAkMBMAkPTSPDe4Ry4coIxw0xB3t
        IvR1uxYpeP0BMQgmp6lWxCm5W
X-Received: by 2002:a62:30c1:0:b0:5e5:e066:2304 with SMTP id w184-20020a6230c1000000b005e5e0662304mr3909224pfw.31.1677640027420;
        Tue, 28 Feb 2023 19:07:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/6cwgsr0hpoW1bLHJ5QpvR2yfmgT61MQvq6b3YIvuRMo2Nt47kFh6KZMpcwXFqW6bZG3iQaA==
X-Received: by 2002:a62:30c1:0:b0:5e5:e066:2304 with SMTP id w184-20020a6230c1000000b005e5e0662304mr3909206pfw.31.1677640027056;
        Tue, 28 Feb 2023 19:07:07 -0800 (PST)
Received: from [10.72.13.209] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b0059416691b64sm6917990pff.19.2023.02.28.19.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 19:07:06 -0800 (PST)
Message-ID: <f69f7614-5450-bcce-83c7-c5ec5d3a6149@redhat.com>
Date:   Wed, 1 Mar 2023 11:06:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 2/2] vdpasim: support doorbell mapping
Content-Language: en-US
To:     "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com
Cc:     stefanha@redhat.com, sgarzare@redhat.com, arei.gonglei@huawei.com,
        yechuan@huawei.com, huangzhichao@huawei.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
References: <20230227091857.2406-1-longpeng2@huawei.com>
 <20230227091857.2406-3-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230227091857.2406-3-longpeng2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/27 17:18, Longpeng(Mike) 写道:
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
> We can test on QEMU with:
>   -device vhost-vdpa-device-pci,vhostdev=/dev/vhost-vdpa-0,page-per-vq=on
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 67 ++++++++++++++++++++++++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim.h |  3 ++
>   2 files changed, 70 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index cb88891b44a8..5a8c820b179f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -39,6 +39,8 @@ MODULE_PARM_DESC(max_iotlb_entries,
>   #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
>   #define VDPASIM_QUEUE_MAX 256
>   #define VDPASIM_VENDOR_ID 0
> +#define VDPASIM_VRING_POLL_PERIOD 100 /* ms */
> +#define VDPASIM_NOTIFY_DEFVAL 0xffff
>   
>   static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>   {
> @@ -245,6 +247,28 @@ static const struct dma_map_ops vdpasim_dma_ops = {
>   static const struct vdpa_config_ops vdpasim_config_ops;
>   static const struct vdpa_config_ops vdpasim_batch_config_ops;
>   
> +static void vdpasim_notify_work(struct work_struct *work)
> +{
> +	struct vdpasim *vdpasim;
> +	u16 *val;
> +
> +	vdpasim = container_of(work, struct vdpasim, notify_work.work);
> +
> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto out;
> +
> +	if (!vdpasim->running)
> +		goto out;
> +
> +	val = (u16 *)vdpasim->notify;
> +	if (xchg(val, VDPASIM_NOTIFY_DEFVAL) != VDPASIM_NOTIFY_DEFVAL)
> +		schedule_work(&vdpasim->work);
> +
> +out:
> +	schedule_delayed_work(&vdpasim->notify_work,
> +			      msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +}
> +
>   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>   			       const struct vdpa_dev_set_config *config)
>   {
> @@ -286,6 +310,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>   	set_dma_ops(dev, &vdpasim_dma_ops);
>   	vdpasim->vdpa.mdev = dev_attr->mgmt_dev;
>   
> +	INIT_DELAYED_WORK(&vdpasim->notify_work, vdpasim_notify_work);
> +
> +	vdpasim->notify = (u16 *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!vdpasim->notify)
> +		goto err_iommu;
> +	WRITE_ONCE(*vdpasim->notify, VDPASIM_NOTIFY_DEFVAL);
> +
>   	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
>   	if (!vdpasim->config)
>   		goto err_iommu;
> @@ -320,6 +351,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
>   
>   	vdpasim->vdpa.dma_dev = dev;
>   
> +	/*
> + 	 * Start periodic (every 100ms) notify work, it won't introduce
> + 	 * any overhead if the device is not started.
> +	 */
> +	schedule_delayed_work(&vdpasim->notify_work,
> +			      msecs_to_jiffies(VDPASIM_VRING_POLL_PERIOD));
> +
>   	return vdpasim;
>   
>   err_iommu:
> @@ -671,11 +709,34 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, unsigned int asid,
>   	return 0;
>   }
>   
> +static pgprot_t vdpasim_get_vq_notification_pgprot(struct vdpa_device *vdpa,
> +						   u16 qid, pgprot_t prot)
> +{
> +	/*
> +	 * We use normal RAM pages to emulate the vq notification area, so
> +	 * just keep the pgprot as it mmaped.
> +	 */
> +	return prot;
> +}
> +
> +static struct vdpa_notification_area
> +vdpasim_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +	struct vdpa_notification_area notify;
> +
> +	notify.addr = virt_to_phys((void *)vdpasim->notify);
> +	notify.size = PAGE_SIZE;
> +
> +	return notify;
> +}
> +
>   static void vdpasim_free(struct vdpa_device *vdpa)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   	int i;
>   
> +	cancel_delayed_work_sync(&vdpasim->notify_work);
>   	cancel_work_sync(&vdpasim->work);
>   
>   	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> @@ -694,6 +755,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	kfree(vdpasim->iommu);
>   	kfree(vdpasim->vqs);
>   	kfree(vdpasim->config);
> +	if (vdpasim->notify)
> +		free_page((unsigned long)vdpasim->notify);
>   }
>   
>   static const struct vdpa_config_ops vdpasim_config_ops = {
> @@ -705,6 +768,8 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>   	.get_vq_ready           = vdpasim_get_vq_ready,
>   	.set_vq_state           = vdpasim_set_vq_state,
>   	.get_vq_state           = vdpasim_get_vq_state,
> +	.get_vq_notification    = vdpasim_get_vq_notification,
> +	.get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
>   	.get_vq_align           = vdpasim_get_vq_align,
>   	.get_vq_group           = vdpasim_get_vq_group,
>   	.get_device_features    = vdpasim_get_device_features,
> @@ -738,6 +803,8 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>   	.get_vq_ready           = vdpasim_get_vq_ready,
>   	.set_vq_state           = vdpasim_set_vq_state,
>   	.get_vq_state           = vdpasim_get_vq_state,
> +	.get_vq_notification    = vdpasim_get_vq_notification,
> +	.get_vq_notification_pgprot = vdpasim_get_vq_notification_pgprot,
>   	.get_vq_align           = vdpasim_get_vq_align,
>   	.get_vq_group           = vdpasim_get_vq_group,
>   	.get_device_features    = vdpasim_get_device_features,
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 0e78737dcc16..786e902de0b2 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -69,6 +69,9 @@ struct vdpasim {
>   	bool running;
>   	/* spinlock to synchronize iommu table */
>   	spinlock_t iommu_lock;
> +	/* dummy notify page */
> +	u16 *notify;
> +	struct delayed_work notify_work;
>   };
>   
>   struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr,

