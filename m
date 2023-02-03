Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE366893E3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjBCJeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjBCJeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:34:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3FC1CAF0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675416807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTuF1WykcCSNrFr4rtL95OxtxlYr91slBMxyY1t6p2A=;
        b=O+eU6mLD9KXBv7UXMDyJRTtwCo8Wtqgr5Ji3ikPSYdIvoSqFVdqcUiNzVjhyqmhnVSYqOF
        zg1+BhyRI15lIwHItg8kwX0fqNMN/3stnjwA8xuEw/4GeIzR76JopFP7+NXWLuFeXqRSUV
        g07OUn1aKyIlZppcvSNgL1Vd2/kB8pM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-1sDjX74GMvisWWySwJRZKQ-1; Fri, 03 Feb 2023 04:33:26 -0500
X-MC-Unique: 1sDjX74GMvisWWySwJRZKQ-1
Received: by mail-ed1-f71.google.com with SMTP id w3-20020a056402268300b00487e0d9b53fso3235801edd.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:33:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTuF1WykcCSNrFr4rtL95OxtxlYr91slBMxyY1t6p2A=;
        b=UjtlEbRWcaJlp1QpjvP5DwT17Hgs9+cPrhPYVj9ff26RoeQHNQFtpB3thq4IeMxj0L
         c7N64kDc3pTc30t3LXSHSHYr/cS0Hi/GdEcKWWMs3aToPev7vWGB0g31HuYD6k2wnOAi
         wsZbFilZBzcO1pfoEI4ovgmJkmyyxRfQPFETtZhR8alFbNT7NbRSlaF5qQlHNWHu+Ejc
         URkgjHH7h57dmZ3r19iibbSwZhYYLx+GbgHwdAe3ZbmHN/YAz/1cloFe376SQduut2aU
         hMtmHGPUOtPlIayIGBvHLnJ4I9puqM0cf4hL44aXReWZCdFiTcxzjF80l8mB+y4/brZV
         Dspg==
X-Gm-Message-State: AO0yUKWEWSLOfbktSJrnorUvyLwnsfvxo8a8IVLgp58buNC+tPeEDamy
        HTB88XqnRM9OQd6Od8ACUDxo2t66+qt3kX9q2eD3Ftu4j5EneKcbtDja8ev3D3PAiy6TxtSr+GI
        k+ms8+/Ha3KxJVjL1MfUkMrWF
X-Received: by 2002:a05:6402:1bc6:b0:499:bcd7:a968 with SMTP id ch6-20020a0564021bc600b00499bcd7a968mr9213901edb.22.1675416804882;
        Fri, 03 Feb 2023 01:33:24 -0800 (PST)
X-Google-Smtp-Source: AK7set8d34tbWWobIW5aS5AN6AQqasOyyBEp9/nVTeqh1Y44lnrSAJMaw7sr2zjw/V/WcE79dz7tIg==
X-Received: by 2002:a05:6402:1bc6:b0:499:bcd7:a968 with SMTP id ch6-20020a0564021bc600b00499bcd7a968mr9213886edb.22.1675416804672;
        Fri, 03 Feb 2023 01:33:24 -0800 (PST)
Received: from redhat.com ([2.52.156.122])
        by smtp.gmail.com with ESMTPSA id ev26-20020a056402541a00b00494dcc5047asm849138edb.22.2023.02.03.01.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 01:33:24 -0800 (PST)
Date:   Fri, 3 Feb 2023 04:33:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     elic@nvidia.com, gdawar@amd.com, tanuj.kamde@amd.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2 5/5] vdpa: mlx5: support per virtqueue dma device
Message-ID: <20230203043307-mutt-send-email-mst@kernel.org>
References: <20230119061525.75068-1-jasowang@redhat.com>
 <20230119061525.75068-6-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119061525.75068-6-jasowang@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:15:25PM +0800, Jason Wang wrote:
> This patch implements per virtqueue dma device for mlx5_vdpa. This is
> needed for virtio_vdpa to work for CVQ which is backed by vringh but
> not DMA. We simply advertise the vDPA device itself as the DMA device
> for CVQ then DMA API can simply use PA so the identical mapping for
> CVQ can still be used. Otherwise the identical (1:1) mapping won't
> work when platform IOMMU is enabled since the IOVA is allocated on
> demand which is not necessarily the PA.
> 
> This fixes the following crash when mlx5 vDPA device is bound to
> virtio-vdpa with platform IOMMU enabled but not in passthrough mode:
> 
> BUG: unable to handle page fault for address: ff2fb3063deb1002
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1393001067 P4D 1393002067 PUD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 55 PID: 8923 Comm: kworker/u112:3 Kdump: loaded Not tainted 6.1.0+ #7
> Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
> Workqueue: mlx5_vdpa_wq mlx5_cvq_kick_handler [mlx5_vdpa]
> RIP: 0010:vringh_getdesc_iotlb+0x93/0x1d0 [vringh]
> Code: 14 25 40 ef 01 00 83 82 c0 0a 00 00 01 48 2b 05 93 5a 1b ea 8b 4c 24 14 48 c1 f8 06 48 c1 e0 0c 48 03 05 90 5a 1b ea 48 01 c8 <0f> b7 00 83 aa c0 0a 00 00 01 65 ff 0d bc e4 41 3f 0f 84 05 01 00
> RSP: 0018:ff46821ba664fdf8 EFLAGS: 00010282
> RAX: ff2fb3063deb1002 RBX: 0000000000000a20 RCX: 0000000000000002
> RDX: ff2fb318d2f94380 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: ff2fb3065e832410 R08: ff46821ba664fe00 R09: 0000000000000001
> R10: 0000000000000000 R11: 000000000000000d R12: ff2fb3065e832488
> R13: ff2fb3065e8324a8 R14: ff2fb3065e8324c8 R15: ff2fb3065e8324a8
> FS:  0000000000000000(0000) GS:ff2fb3257fac0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ff2fb3063deb1002 CR3: 0000001392010006 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
>   mlx5_cvq_kick_handler+0x89/0x2b0 [mlx5_vdpa]
>   process_one_work+0x1e2/0x3b0
>   ? rescuer_thread+0x390/0x390
>   worker_thread+0x50/0x3a0
>   ? rescuer_thread+0x390/0x390
>   kthread+0xd6/0x100
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Jason how about a Fixes tag here?

> ---
> Changes since V1:
> - make mlx5_get_vq_dma_dev() static
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6632651b1e54..97d1ada7f4db 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
>  	return err;
>  }
>  
> +static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +	if (is_ctrl_vq_idx(mvdev, idx))
> +		return &vdev->dev;
> +
> +	return mvdev->vdev.dma_dev;
> +}
> +
>  static void mlx5_vdpa_free(struct vdpa_device *vdev)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2897,6 +2907,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>  	.get_generation = mlx5_vdpa_get_generation,
>  	.set_map = mlx5_vdpa_set_map,
>  	.set_group_asid = mlx5_set_group_asid,
> +	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
>  	.free = mlx5_vdpa_free,
>  	.suspend = mlx5_vdpa_suspend,
>  };
> -- 
> 2.25.1

