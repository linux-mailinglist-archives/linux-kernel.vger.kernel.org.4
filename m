Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8996D2B4A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 00:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjCaWZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 18:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCaWZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:25:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455091E730
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680301502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDdrrNxwM+s0nFy5rUwrbB3IohLxH3YmRrXC0CF+NoY=;
        b=MJbj/FcdfSJtex7UJB2tzc8MQe5os37YmmG1D89+ldZGyhgjMqmzKaktyPXcKMviEirtMD
        ytiaUAXWhdO4hpAQOspX8gsn7hVs4Owy4Aq46GX6C2X0zi3KkcWDa1ZstevKF/uhyOwK3F
        y1PJ2nkI0OuIy1kao/EarW5goWvgoxo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-1I5GzL6aPmi5jSzlDy_luw-1; Fri, 31 Mar 2023 18:25:01 -0400
X-MC-Unique: 1I5GzL6aPmi5jSzlDy_luw-1
Received: by mail-il1-f199.google.com with SMTP id z19-20020a056e02089300b00326098d01d9so10825073ils.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 15:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680301500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDdrrNxwM+s0nFy5rUwrbB3IohLxH3YmRrXC0CF+NoY=;
        b=ffw40W1LMVKLLs6v+ouwp2OrqJ4ZBtvGfQCRHoib7SsoFNhO6UxD1GM3UfKuXJa3IJ
         NrSDwrlv3zSHwv5ULg3S+fyD5SU0oDwHwT+a+e99Ub/HMaEB6sDMT5XDEX59dWDyAEc4
         tvhSCI81VD3z02dkyw8nDDKoASpgXZo7fSNmF5wix0s3xCAFDmZIqo0ytEYlbIrwr28h
         emom8kP6sgImQhYZ2bIZNIsf6hSjVc0dnXk89WVkDSKO9ZMCBylNRG/nxpHWuglkWI+D
         KaOTk0ZBa1wqk5QjJhCIj7xB+sRFM2tLbN/tojE8JbhD5t1hR5OQ9rtPHOEJSGGFTROp
         ErKw==
X-Gm-Message-State: AAQBX9cDsJ2w7msBSSnw8MINV2JJBetQjkiDwLCROJxEdG+98rF+U2NE
        OOvUl4JhyyO0v+2/w/zufctmYTUs7RzTsE8yPVOG3YWwo69Uv1amNwq+jAh85ulsTFiEi2vvNI9
        DGB92zXJS6KABcKZ5nX+ai9Hp
X-Received: by 2002:a5d:8b54:0:b0:75c:5a15:9679 with SMTP id c20-20020a5d8b54000000b0075c5a159679mr11792624iot.6.1680301500204;
        Fri, 31 Mar 2023 15:25:00 -0700 (PDT)
X-Google-Smtp-Source: AKy350b0kRxxoDyQfhng8j/aaOpOx9rPWyoXQ0BDCFVr9y0J9kQbUsWFfpdpqi/Uiu0y0nldaC0zIw==
X-Received: by 2002:a5d:8b54:0:b0:75c:5a15:9679 with SMTP id c20-20020a5d8b54000000b0075c5a159679mr11792611iot.6.1680301499848;
        Fri, 31 Mar 2023 15:24:59 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d914e000000b0075d1fcab203sm858648ioq.8.2023.03.31.15.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 15:24:59 -0700 (PDT)
Date:   Fri, 31 Mar 2023 16:24:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     <jgg@nvidia.com>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <tglx@linutronix.de>, <darwi@linutronix.de>, <kvm@vger.kernel.org>,
        <dave.jiang@intel.com>, <jing2.liu@intel.com>,
        <ashok.raj@intel.com>, <fenghua.yu@intel.com>,
        <tom.zanussi@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
Message-ID: <20230331162456.3f52b9e3.alex.williamson@redhat.com>
In-Reply-To: <688393bf-445c-15c5-e84d-1c16261a4197@intel.com>
References: <cover.1680038771.git.reinette.chatre@intel.com>
        <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
        <20230330164050.0069e2a5.alex.williamson@redhat.com>
        <20230330164214.67ccbdfa.alex.williamson@redhat.com>
        <688393bf-445c-15c5-e84d-1c16261a4197@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 10:49:16 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Alex,
> 
> On 3/30/2023 3:42 PM, Alex Williamson wrote:
> > On Thu, 30 Mar 2023 16:40:50 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> >> On Tue, 28 Mar 2023 14:53:34 -0700
> >> Reinette Chatre <reinette.chatre@intel.com> wrote:
> >>  
> 
> ...
> 
> >>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> >>> index b3a258e58625..755b752ca17e 100644
> >>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> >>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> >>> @@ -55,6 +55,13 @@ struct vfio_pci_irq_ctx *vfio_irq_ctx_get(struct vfio_pci_core_device *vdev,
> >>>  	return xa_load(&vdev->ctx, index);
> >>>  }
> >>>  
> >>> +static void vfio_irq_ctx_free(struct vfio_pci_core_device *vdev,
> >>> +			      struct vfio_pci_irq_ctx *ctx, unsigned long index)
> >>> +{
> >>> +	xa_erase(&vdev->ctx, index);
> >>> +	kfree(ctx);
> >>> +}  
> > 
> > Also, the function below should use this rather than open coding the
> > same now.  Thanks,  
> 
> It should, yes. Thank you. Will do.
> 
> 
> >>>  static void vfio_irq_ctx_free_all(struct vfio_pci_core_device *vdev)
> >>>  {
> >>>  	struct vfio_pci_irq_ctx *ctx;
> >>> @@ -409,33 +416,62 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>>  {
> >>>  	struct pci_dev *pdev = vdev->pdev;
> >>>  	struct vfio_pci_irq_ctx *ctx;
> >>> +	struct msi_map msix_map = {};
> >>> +	bool allow_dyn_alloc = false;
> >>>  	struct eventfd_ctx *trigger;
> >>> +	bool new_ctx = false;
> >>>  	int irq, ret;
> >>>  	u16 cmd;
> >>>  
> >>> +	/* Only MSI-X allows dynamic allocation. */
> >>> +	if (msix && pci_msix_can_alloc_dyn(vdev->pdev))
> >>> +		allow_dyn_alloc = true;    
> >>
> >> Should vfio-pci-core probe this and store it in a field on
> >> vfio_pci_core_device so that we can simply use something like
> >> vdev->has_dyn_msix throughout?  
> 
> It is not obvious to me if you mean this with vfio-pci-core probe,
> but it looks like a change to vfio_pci_core_enable() may be
> appropriate with a snippet like below:
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a743b98ba29a..a474ce80a555 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -533,6 +533,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	} else
>  		vdev->msix_bar = 0xFF;
>  
> +	vdev->has_dyn_msix = pci_msix_can_alloc_dyn(pdev);
> +
>  	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>  		vdev->has_vga = true;
>  
> Please do note that I placed it outside of the earlier "if (msix_pos)" since
> pci_msix_can_alloc_dyn() has its own "if (!dev->msix_cap)". If you prefer
> to keep all the vdev->*msix* together I can move it into the if statement.

Sure, just for common grouping I'd probably put it within the existing
msix_cap branch.
 
> With vdev->has_dyn_msix available "allow_dyn_alloc" can be dropped as you
> stated.
> 
> >>  
> >>> +
> >>>  	ctx = vfio_irq_ctx_get(vdev, vector);
> >>> -	if (!ctx)
> >>> +	if (!ctx && !allow_dyn_alloc)
> >>>  		return -EINVAL;
> >>> +
> >>>  	irq = pci_irq_vector(pdev, vector);
> >>> +	/* Context and interrupt are always allocated together. */
> >>> +	WARN_ON((ctx && irq == -EINVAL) || (!ctx && irq != -EINVAL));
> >>>  
> >>> -	if (ctx->trigger) {
> >>> +	if (ctx && ctx->trigger) {
> >>>  		irq_bypass_unregister_producer(&ctx->producer);
> >>>  
> >>>  		cmd = vfio_pci_memory_lock_and_enable(vdev);
> >>>  		free_irq(irq, ctx->trigger);
> >>> +		if (allow_dyn_alloc) {    
> >>
> >> It almost seems easier to define msix_map in each scope that it's used:
> >>
> >> 			struct msi_map map = { .index = vector,
> >> 					       .virq = irq };
> >>  
> 
> Sure. Will do.
> 
> >>> +			msix_map.index = vector;
> >>> +			msix_map.virq = irq;
> >>> +			pci_msix_free_irq(pdev, msix_map);
> >>> +			irq = -EINVAL;
> >>> +		}
> >>>  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>>  		kfree(ctx->name);
> >>>  		eventfd_ctx_put(ctx->trigger);
> >>>  		ctx->trigger = NULL;
> >>> +		if (allow_dyn_alloc) {
> >>> +			vfio_irq_ctx_free(vdev, ctx, vector);
> >>> +			ctx = NULL;
> >>> +		}
> >>>  	}
> >>>  
> >>>  	if (fd < 0)
> >>>  		return 0;
> >>>  
> >>> +	if (!ctx) {
> >>> +		ctx = vfio_irq_ctx_alloc_single(vdev, vector);
> >>> +		if (!ctx)
> >>> +			return -ENOMEM;
> >>> +		new_ctx = true;
> >>> +	}
> >>> +
> >>>  	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
> >>>  			      msix ? "x" : "", vector, pci_name(pdev));
> >>> -	if (!ctx->name)
> >>> -		return -ENOMEM;
> >>> +	if (!ctx->name) {
> >>> +		ret = -ENOMEM;
> >>> +		goto out_free_ctx;
> >>> +	}
> >>>  
> >>>  	trigger = eventfd_ctx_fdget(fd);
> >>>  	if (IS_ERR(trigger)) {
> >>> @@ -443,25 +479,38 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>>  		goto out_free_name;
> >>>  	}
> >>>  
> >>> -	/*
> >>> -	 * The MSIx vector table resides in device memory which may be cleared
> >>> -	 * via backdoor resets. We don't allow direct access to the vector
> >>> -	 * table so even if a userspace driver attempts to save/restore around
> >>> -	 * such a reset it would be unsuccessful. To avoid this, restore the
> >>> -	 * cached value of the message prior to enabling.
> >>> -	 */
> >>>  	cmd = vfio_pci_memory_lock_and_enable(vdev);
> >>>  	if (msix) {
> >>> -		struct msi_msg msg;
> >>> -
> >>> -		get_cached_msi_msg(irq, &msg);
> >>> -		pci_write_msi_msg(irq, &msg);
> >>> +		if (irq == -EINVAL) {
> >>> +			msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);    
> >>
> >> 			struct msi_map map = pci_msix_alloc_irq_at(pdev,
> >> 								vector, NULL);  
> 
> Will do.
> 
> >>> +			if (msix_map.index < 0) {
> >>> +				vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>> +				ret = msix_map.index;
> >>> +				goto out_put_eventfd_ctx;
> >>> +			}
> >>> +			irq = msix_map.virq;
> >>> +		} else {
> >>> +			/*
> >>> +			 * The MSIx vector table resides in device memory which
> >>> +			 * may be cleared via backdoor resets. We don't allow
> >>> +			 * direct access to the vector table so even if a
> >>> +			 * userspace driver attempts to save/restore around
> >>> +			 * such a reset it would be unsuccessful. To avoid
> >>> +			 * this, restore the cached value of the message prior
> >>> +			 * to enabling.
> >>> +			 */    
> >>
> >> You've only just copied this comment down to here, but I think it's a
> >> bit stale.  Maybe we should update it to something that helps explain
> >> this split better, maybe:
> >>
> >> 			/*
> >> 			 * If the vector was previously allocated, refresh the
> >> 			 * on-device message data before enabling in case it had
> >> 			 * been cleared or corrupted since writing.
> >> 			 */
> >>
> >> IIRC, that was the purpose of writing it back to the device and the
> >> blocking of direct access is no longer accurate anyway.  
> 
> Thank you. Will do. To keep this patch focused I plan to separate
> this change into a new prep patch that will be placed earlier in
> this series.

Ok.

> >>  
> >>> +			struct msi_msg msg;
> >>> +
> >>> +			get_cached_msi_msg(irq, &msg);
> >>> +			pci_write_msi_msg(irq, &msg);
> >>> +		}
> >>>  	}
> >>>  
> >>>  	ret = request_irq(irq, vfio_msihandler, 0, ctx->name, trigger);
> >>> -	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>>  	if (ret)
> >>> -		goto out_put_eventfd_ctx;
> >>> +		goto out_free_irq_locked;
> >>> +
> >>> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>>  
> >>>  	ctx->producer.token = trigger;
> >>>  	ctx->producer.irq = irq;
> >>> @@ -477,11 +526,21 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
> >>>  
> >>>  	return 0;
> >>>  
> >>> +out_free_irq_locked:
> >>> +	if (allow_dyn_alloc && new_ctx) {    
> >>
> >> 		struct msi_map map = { .index = vector,
> >> 				       .virq = irq };
> >>  
> 
> Will do.
> 
> >>> +		msix_map.index = vector;
> >>> +		msix_map.virq = irq;
> >>> +		pci_msix_free_irq(pdev, msix_map);
> >>> +	}
> >>> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
> >>>  out_put_eventfd_ctx:
> >>>  	eventfd_ctx_put(trigger);
> >>>  out_free_name:
> >>>  	kfree(ctx->name);
> >>>  	ctx->name = NULL;
> >>> +out_free_ctx:
> >>> +	if (allow_dyn_alloc && new_ctx)
> >>> +		vfio_irq_ctx_free(vdev, ctx, vector);
> >>>  	return ret;
> >>>  }
> >>>      
> >>
> >> Do we really need the new_ctx test in the above cases?  Thanks,  
> 
> new_ctx is not required for correctness but instead is used to keep
> the code symmetric. 
> Specifically, if the user enables MSI-X without providing triggers and
> then later assign triggers then an error path without new_ctx would unwind
> more than done in this function, it would free the context that
> was allocated within vfio_msi_enable(). 

Seems like we already have that asymmetry, if a trigger is unset we'll
free the ctx allocated by vfio_msi_enable().  Tracking which are
allocated where is unnecessarily complex, how about a policy that
devices supporting vdev->has_dyn_msix only ever have active contexts
allocated?  Thanks,

Alex

