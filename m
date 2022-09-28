Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD25ED469
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiI1F7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiI1F72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4686E115A40
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664344766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ux6ESxD86I07b6gSvTxqwQcjLCm9KKX7ZOKJu4UtAwY=;
        b=MGxNa2wnTNaVIQ9L7BoRtiBk+oD0CL22T5xXXxvNpNFNYNK+qbe+0A8suY3BERdmxF1jbg
        P6tW58nt5ZPG4aNgfQ5SGxFywxlfKBBwzuUP8zaJsKVkxPGa8YUHA8QRWs5bc9bJYORjHY
        /omsmgNvZV629lzyl5C9bI9B9KspPFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-8ElPoYgBN0qYPzzle9BvCA-1; Wed, 28 Sep 2022 01:59:24 -0400
X-MC-Unique: 8ElPoYgBN0qYPzzle9BvCA-1
Received: by mail-wm1-f72.google.com with SMTP id 62-20020a1c0241000000b003b4922046e5so6625420wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Ux6ESxD86I07b6gSvTxqwQcjLCm9KKX7ZOKJu4UtAwY=;
        b=2/244gzR61bkFBV5rPYQcygCXU4KIvd7I3RZw+LepykYG+ePw/zT64pNB5SU8g3PCn
         /Wvb/FnMKdTo2gg5rjnKAE698S6+KXqld+qKzpPjhbBLh0p2GJw7+bLaQlQ8Zmp5ih+6
         ofzF0pyp4acW6hhx59DungfLpM/hKIaePZjV1XP6FJO8gR1rzD7PkiMm23g/ld98bC1I
         Mk0b1cUv9v4Cfd1FO+SawXLGdh8PUlXai8EP6gEW3BXvi/aiErFIxozNdAPBF4l8Q6/g
         iCeU4hizzYIFvoxNGFefv/ctM/Wxj+LvinLbnq4bQnl8QdQMbjMaovvT/rgj8neP/B+s
         1DcA==
X-Gm-Message-State: ACrzQf2VnxgUTtmAe4sDZbNlPzfjqi7F6bGWC6/L3v1Guh5CdAYxaLzr
        V0bsYan87eDvZLUTkiW2Clqk80uL3u2Ny+3hK+NjNFiA+srpJX7iS8GvGgytK2Ru8j5bj/HNvc2
        ZFF6Jon+mQ4gNIsjRrKkUthu1
X-Received: by 2002:a05:600c:34c2:b0:3b4:7a98:5f5a with SMTP id d2-20020a05600c34c200b003b47a985f5amr5328655wmq.156.1664344763393;
        Tue, 27 Sep 2022 22:59:23 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7UKR3w+gPq4gH2R4DtnLpTJZ0Es1FfUnbDXa88Vy1h6XPhRWaiY7aMP3aKzQ6yL81cmT8gzg==
X-Received: by 2002:a05:600c:34c2:b0:3b4:7a98:5f5a with SMTP id d2-20020a05600c34c200b003b47a985f5amr5328644wmq.156.1664344763132;
        Tue, 27 Sep 2022 22:59:23 -0700 (PDT)
Received: from redhat.com ([2.55.17.78])
        by smtp.gmail.com with ESMTPSA id k15-20020adfd22f000000b0021badf3cb26sm3017353wrh.63.2022.09.27.22.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 22:59:22 -0700 (PDT)
Date:   Wed, 28 Sep 2022 01:59:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio_pci: avoid to request intx irq if pin is zero
Message-ID: <20220928015402-mutt-send-email-mst@kernel.org>
References: <20220928053522.440-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928053522.440-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! More minor issues to address

On Wed, Sep 28, 2022 at 01:35:22PM +0800, Angus Chen wrote:
> The background is that we use dpu in cloud computing,the arch is x86,80
> cores.We will have a lots of virtio devices,like 512 or more.
> When we probe about 200 virtio_blk devices,it will fail and
> the stack is print as follows:
> 
> [25338.485128] virtio-pci 0000:b3:00.0: virtio_pci: leaving for legacy driver
> [25338.496174] genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)
> [25338.503822] CPU: 20 PID: 5431 Comm: kworker/20:0 Kdump: loaded Tainted: G           OE    --------- -  - 4.18.0-305.30.1.el8.x86_64
> [25338.516403] Hardware name: Inspur NF5280M5/YZMB-00882-10E, BIOS 4.1.21 08/25/2021
> [25338.523881] Workqueue: events work_for_cpu_fn
> [25338.528235] Call Trace:
> [25338.530687]  dump_stack+0x5c/0x80
> [25338.534000]  __setup_irq.cold.53+0x7c/0xd3
> [25338.538098]  request_threaded_irq+0xf5/0x160
> [25338.542371]  vp_find_vqs+0xc7/0x190
> [25338.545866]  init_vq+0x17c/0x2e0 [virtio_blk]
> [25338.550223]  ? ncpus_cmp_func+0x10/0x10
> [25338.554061]  virtblk_probe+0xe6/0x8a0 [virtio_blk]
> [25338.558846]  virtio_dev_probe+0x158/0x1f0
> [25338.562861]  really_probe+0x255/0x4a0
> [25338.566524]  ? __driver_attach_async_helper+0x90/0x90
> [25338.571567]  driver_probe_device+0x49/0xc0
> [25338.575660]  bus_for_each_drv+0x79/0xc0
> [25338.579499]  __device_attach+0xdc/0x160
> [25338.583337]  bus_probe_device+0x9d/0xb0
> [25338.587167]  device_add+0x418/0x780
> [25338.590654]  register_virtio_device+0x9e/0xe0
> [25338.595011]  virtio_pci_probe+0xb3/0x140
> [25338.598941]  local_pci_probe+0x41/0x90
> [25338.602689]  work_for_cpu_fn+0x16/0x20
> [25338.606443]  process_one_work+0x1a7/0x360
> [25338.610456]  ? create_worker+0x1a0/0x1a0
> [25338.614381]  worker_thread+0x1cf/0x390
> [25338.618132]  ? create_worker+0x1a0/0x1a0
> [25338.622051]  kthread+0x116/0x130
> [25338.625283]  ? kthread_flush_work_fn+0x10/0x10
> [25338.629731]  ret_from_fork+0x1f/0x40
> [25338.633395] virtio_blk: probe of virtio418 failed with error -16
> 
> The log :
> "genirq: Flags mismatch irq 0. 00000080 (virtio418) vs. 00015a00 (timer)"
> was print because of the irq 0 is used by timer exclusive,and when
> vp_find_vqs call vp_find_vqs_msix and return false twice for
> whatever reason,then it will call vp_find_vqs_intx for the last try.
> Because vp_dev->pci_dev->irq is zero,so it will be request irq 0 with
> flag IRQF_SHARED,we will get a backtrace like above.
> 
> according to PCI spec , Devices (or device functions)
> that do not use an interrupt pin must put a 0 in this register.

Pls add quotes and add "Interrupt Pin:" to make it clear in which register.

> So if vp_dev->pci_dev->pin is zero, maybe we should not request legacy
> interrupt.

and drop "maybe" here pls. I guess it sounds impolite to you but
as the patch author you get to make the tough decisions :)

> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> v2:
> - Decide whether to request an intx interrupt by pin instead of irq
> - suggested by mst
> 
> v1:https://lore.kernel.org/virtualization/20220928000228-mutt-send-email-mst@kernel.org/T/#u
> 
>  drivers/virtio/virtio_pci_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..81225e503e69 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i, err, queue_idx = 0;
>  
> +	if (vp_dev->pci_dev->pin == 0)
> +		return -EINVAL;
> +

Pls use !pin for brevity.

>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;


So, this is mostly ok. The only issue is this:


int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
                struct virtqueue *vqs[], vq_callback_t *callbacks[],
                const char * const names[], const bool *ctx,
                struct irq_affinity *desc)
{
        int err;

        /* Try MSI-X with one vector per queue. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
        if (!err)
                return 0;
        /* Fallback: MSI-X with one vector for config, one shared for queues. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
        if (!err)
                return 0;
        /* Finally fall back to regular interrupts. */
        return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
}


So the real source of failure to use msix, will be overwritten in err by EINVAL.

How about moving the "if" to vp_find_vqs?
E.g.
	/* Is there an interrupt pin? If not give up. */
	if (!vdev->pci_dev->pin)
		return err;


> -- 
> 2.17.1

