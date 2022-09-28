Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42C15ED3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 06:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiI1EDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 00:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI1EDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 00:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8917E27
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664337790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9NHV03tTrkp6hRe5QgHW9x/cWZQBABbNm3WP+xD5NE=;
        b=XiCXbqb69eRBAdaAjmwOihRoTL+Ps5xFyk5hskIhE1XZ/c0KhGWVVtO7KkiOtNMOQ2WSv0
        fKI7IWZzX8KSiHz9ucAlOZXIRDL+vpZST8VseQxJjSWUuwNRFZzsuy5yuaNvzEWo5EJERe
        rG9HUsf2NjwEVGtrQG0W+shIF5XrBYI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-67_EOUrbP3uwzPnLqxEAUA-1; Wed, 28 Sep 2022 00:03:09 -0400
X-MC-Unique: 67_EOUrbP3uwzPnLqxEAUA-1
Received: by mail-wm1-f71.google.com with SMTP id 62-20020a1c0241000000b003b4922046e5so6503958wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 21:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V9NHV03tTrkp6hRe5QgHW9x/cWZQBABbNm3WP+xD5NE=;
        b=sWLOqQO2n/uxVgi6frcqucHbUHdLI/BrZcOGArAfKWr7gg6tdSGGFsnTxIbk1bHP9W
         4Y9IOKV9pMfU0tCUcIlaWX44cnrIfXwJW/xb+yXUZZeGNQwL3Vp/svBa2U+fMcq4hFDf
         DbZf45WOZSIRae3zRfZzq+9g7ThEA8V/zOblJkp75DBqADhHy7g6Pv8i/WHmfdmsNMu/
         GTKajqaz34/gQCSxuHdnlhWGe0ce9P5cV/ywr+IF9V6bwVwW/6vPZYDdbX8UPeRVYTMs
         cR/Zpu0tNGpCL9gjdEq1hHdbppbHMJHPIK3mBi58PGfPGN/qaTufsTLqIUaUbkfvS1Wg
         HacA==
X-Gm-Message-State: ACrzQf2pEXmFfO5wSN0S20m4yDMm6TdtbazEeG7hRCUs3aMyww7W9mH+
        lcKNtB2BU/mpjStdIkB8WTTHVAGShA+W0z4ddBq7uYhYizqIlnX47KFXIukOLk2trUhnhSa6sXf
        cYrBd/USYxSrVnHL0ixcseDbc
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id iv16-20020a05600c549000b003b48db054d7mr5107004wmb.62.1664337787627;
        Tue, 27 Sep 2022 21:03:07 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5xZYexFcBsYk6b0JjWdOi5XDG1biUEXSCrUXgghEnfzeKX/Tfylth1hVUyJoaXXB+5D2JL2Q==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id iv16-20020a05600c549000b003b48db054d7mr5106986wmb.62.1664337787339;
        Tue, 27 Sep 2022 21:03:07 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b003b47e75b401sm507557wmq.37.2022.09.27.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:03:06 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:03:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_pci: avoid to request intx irq if irq is zero
Message-ID: <20220928000228-mutt-send-email-mst@kernel.org>
References: <20220928035706.419-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928035706.419-1-angus.chen@jaguarmicro.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:57:06AM +0800, Angus Chen wrote:
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
> When the pci device is vf,the intx
> is not allowed and it will be 0.Even if the pci device is a pf,
> we should remind that
> irq 0 is almost be reserved or used for some device fixed


Where does it say irq 0 is reserved on all platforms?
I am not sure this is right.


> like timer in x86 without IRQF_SHARED,so we can avoid call it.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index ad258a9d3b9f..3208a2b149b9 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -362,6 +362,9 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	int i, err, queue_idx = 0;
>  
> +	if (vp_dev->pci_dev->irq == 0)
> +		return -EINVAL;
> +


Pls read the PCI spec:

Interrupt Pin
The Interrupt Pin register tells which interrupt pin the device (or device function) uses. A
value of 1 corresponds to INTA#. A value of 2 corresponds to INTB#. A value of 3
corresponds to INTC#. A value of 4 corresponds to INTD#. Devices (or device functions)
that do not use an interrupt pin must put a 0 in this register.


Please check vp_dev->pci_dev->pin accordingly.




>  	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>  	if (!vp_dev->vqs)
>  		return -ENOMEM;
> -- 
> 2.17.1

