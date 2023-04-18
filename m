Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A16E6F72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjDRWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjDRWjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1189744
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681857512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuW8bCnBtwfPEYcD/xLW4pmQaYGuW5H8om9ioj7wcK4=;
        b=d2FuWTYhGHkgUbh7UbykN2lkQ9cnIDzzL2QAMxEUwGwMgvFIYcLgnAR1DLd8HGeAVow7sS
        9bs4yvPxWS3/F5tm3FJJdf3m50Z0u5HwSjG6SZmp+NqRRYimHP0WjIwHm5H6lmVkK+OoIG
        smPCb8uypGu5EdxdTaD/8ezGwjtZFCc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-czYCA2e4N1ymeqvYwaBhRg-1; Tue, 18 Apr 2023 18:38:31 -0400
X-MC-Unique: czYCA2e4N1ymeqvYwaBhRg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b58d571a8so12526895ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857511; x=1684449511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuW8bCnBtwfPEYcD/xLW4pmQaYGuW5H8om9ioj7wcK4=;
        b=RPlxRJOW9CRnAlVZk3R15/RMeivMYWiHXy9U8sMwOGhLThGG8Bx5ZerJx3EchqI2CG
         tert6zGBo2mq054Qb2toia9dxEZDTXlZ+DgIXCZru+Sx9iIB4j521dLgWZtoR9gWV/Rt
         Ysi/6NHp8YuDeMzNJqCJWJVU5pZmLnYxIylrkYubZ7/reoC3hPDoNqEFKgGqPc+oQnis
         LhoL7K4nwu0xpHeHi5LUNQYXKXoGemMy0FCzohLVzVjsfncr14eX5anl6qSwRAiJ4YiH
         J9CZAORTutPnYOOGumuud362vdR8idQiJ1NMuRwhm2mY13pLYYwQqOOWDt+s2wGRTpqV
         0PSw==
X-Gm-Message-State: AAQBX9ejyuiZv++w04Rhdv5QKMnBPrr2W6IoRH0OWmGMTLJwL7Sr3GPH
        PL2y3AVWb7qMuyACj0MqTSjp9aNE4smm7MGpvKUKkQIoXZ2SVfWG+yCS3tgEbcPInzt0QzO/oHu
        ScF9RzGzjjOeCl0tWE1/2uk4V
X-Received: by 2002:a92:d64f:0:b0:328:18af:df0 with SMTP id x15-20020a92d64f000000b0032818af0df0mr16242574ilp.23.1681857510846;
        Tue, 18 Apr 2023 15:38:30 -0700 (PDT)
X-Google-Smtp-Source: AKy350aylA4H6hADYDO/G1wKu0cQ9FgFsSTQl1SyE79WrPgMY4mHi7eA2KYDNrDSKMOU1LsYRQLu2A==
X-Received: by 2002:a92:d64f:0:b0:328:18af:df0 with SMTP id x15-20020a92d64f000000b0032818af0df0mr16242553ilp.23.1681857510554;
        Tue, 18 Apr 2023 15:38:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q6-20020a056e02096600b003244d7f2292sm4142876ilt.32.2023.04.18.15.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 15:38:30 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:38:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 09/10] vfio/pci: Support dynamic MSI-X
Message-ID: <20230418163829.149e8881.alex.williamson@redhat.com>
In-Reply-To: <86cda5cf2742feff3b14954284fb509863355050.1681837892.git.reinette.chatre@intel.com>
References: <cover.1681837892.git.reinette.chatre@intel.com>
        <86cda5cf2742feff3b14954284fb509863355050.1681837892.git.reinette.chatre@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 10:29:20 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Recently introduced pci_msix_alloc_irq_at() and pci_msix_free_irq()
> enables an individual MSI-X interrupt to be allocated and freed after
> MSI-X enabling.
> 
> Use dynamic MSI-X (if supported by the device) to allocate an interrupt
> after MSI-X is enabled. An MSI-X interrupt is dynamically allocated at
> the time a valid eventfd is assigned. This is different behavior from
> a range provided during MSI-X enabling where interrupts are allocated
> for the entire range whether a valid eventfd is provided for each
> interrupt or not.
> 
> Do not dynamically free interrupts, leave that to when MSI-X is
> disabled.

But we do, sometimes, even if essentially only on the error path.  Is
that worthwhile?  It seems like we could entirely remove
vfio_msi_free_irq() and rely only on pci_free_irq_vectors() on MSI/X
teardown.

I'd probably also add a comment in the commit log about the theory
behind not dynamically freeing irqs, ie. latency, reliability, and
whatever else we used to justify it.  Thanks,

Alex

> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> Link: https://lore.kernel.org/lkml/20230403211841.0e206b67.alex.williamson@redhat.com/
> ---
> The get_cached_msi_msg()/pci_write_msi_msg() behavior is kept
> similar to the scenario when MSI-X is enabled with triggers
> provided for new interrupts. get_cached_msi_msg()/pci_write_msi_msg()
> follows for interrupts recently allocated with pci_msix_alloc_irq_at()
> just like get_cached_msi_msg()/pci_write_msi_msg() is done for
> interrupts recently allocated with pci_alloc_irq_vectors().
> 
> Changes since V2:
> - Move vfio_irq_ctx_free() to earlier in series to support
>   earlier usage. (Alex)
> - Use consistent terms in changelog: MSI-x changed to MSI-X.
> - Make dynamic interrupt context creation generic across all
>   MSI/MSI-X interrupts. This resulted in code moving to earlier
>   in series as part of xarray introduction patch. (Alex)
> - Remove the local allow_dyn_alloc and direct calling of
>   pci_msix_can_alloc_dyn(), use the new vdev->has_dyn_msix
>   introduced earlier instead. (Alex)
> - Stop tracking new allocations (remove "new_ctx"). (Alex)
> - Introduce new wrapper that returns Linux interrupt number or
>   dynamically allocate a new interrupt. Wrapper can be used for
>   all interrupt cases. (Alex)
> - Only free dynamic MSI-X interrupts on MSI-X teardown. (Alex)
> 
> Changes since RFC V1:
> - Add pointer to interrupt context as function parameter to
>   vfio_irq_ctx_free(). (Alex)
> - Initialize new_ctx to false. (Dan Carpenter)
> - Only support dynamic allocation if device supports it. (Alex)
> 
>  drivers/vfio/pci/vfio_pci_intrs.c | 73 +++++++++++++++++++++++++++----
>  1 file changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index bdda7f46c2be..c1a3e224c867 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -372,27 +372,74 @@ static int vfio_msi_enable(struct vfio_pci_core_device *vdev, int nvec, bool msi
>  	return 0;
>  }
>  
> +/*
> + * Return Linux IRQ number of an MSI or MSI-X device interrupt vector.
> + * If a Linux IRQ number is not available then a new interrupt will be
> + * allocated if dynamic MSI-X is supported.
> + */
> +static int vfio_msi_alloc_irq(struct vfio_pci_core_device *vdev,
> +			      unsigned int vector, bool msix)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct msi_map map;
> +	int irq;
> +	u16 cmd;
> +
> +	irq = pci_irq_vector(pdev, vector);
> +	if (irq > 0 || !msix || !vdev->has_dyn_msix)
> +		return irq;
> +
> +	cmd = vfio_pci_memory_lock_and_enable(vdev);
> +	map = pci_msix_alloc_irq_at(pdev, vector, NULL);
> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +
> +	return map.index < 0 ? map.index : map.virq;
> +}
> +
> +/*
> + * Free interrupt if it can be re-allocated dynamically (while MSI-X
> + * is enabled).
> + */
> +static void vfio_msi_free_irq(struct vfio_pci_core_device *vdev,
> +			      unsigned int vector, bool msix)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +	struct msi_map map;
> +	int irq;
> +	u16 cmd;
> +
> +	if (!msix || !vdev->has_dyn_msix)
> +		return;
> +
> +	irq = pci_irq_vector(pdev, vector);
> +	map = (struct msi_map) { .index = vector, .virq = irq };
> +
> +	if (WARN_ON(irq < 0))
> +		return;
> +
> +	cmd = vfio_pci_memory_lock_and_enable(vdev);
> +	pci_msix_free_irq(pdev, map);
> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +}
> +
>  static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  				      unsigned int vector, int fd, bool msix)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_irq_ctx *ctx;
>  	struct eventfd_ctx *trigger;
> -	int irq, ret;
> +	int irq = -EINVAL, ret;
>  	u16 cmd;
>  
> -	irq = pci_irq_vector(pdev, vector);
> -	if (irq < 0)
> -		return -EINVAL;
> -
>  	ctx = vfio_irq_ctx_get(vdev, vector);
>  
>  	if (ctx) {
>  		irq_bypass_unregister_producer(&ctx->producer);
> -
> +		irq = pci_irq_vector(pdev, vector);
>  		cmd = vfio_pci_memory_lock_and_enable(vdev);
>  		free_irq(irq, ctx->trigger);
>  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +		/* Interrupt stays allocated, will be freed at MSI-X disable. */
>  		kfree(ctx->name);
>  		eventfd_ctx_put(ctx->trigger);
>  		vfio_irq_ctx_free(vdev, ctx, vector);
> @@ -401,9 +448,17 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  	if (fd < 0)
>  		return 0;
>  
> +	if (irq == -EINVAL) {
> +		irq = vfio_msi_alloc_irq(vdev, vector, msix);
> +		if (irq < 0)
> +			return irq;
> +	}
> +
>  	ctx = vfio_irq_ctx_alloc(vdev, vector);
> -	if (!ctx)
> -		return -ENOMEM;
> +	if (!ctx) {
> +		ret = -ENOMEM;
> +		goto out_free_irq;
> +	}
>  
>  	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
>  			      msix ? "x" : "", vector, pci_name(pdev));
> @@ -456,6 +511,8 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  	kfree(ctx->name);
>  out_free_ctx:
>  	vfio_irq_ctx_free(vdev, ctx, vector);
> +out_free_irq:
> +	vfio_msi_free_irq(vdev, vector, msix);
>  	return ret;
>  }
>  

