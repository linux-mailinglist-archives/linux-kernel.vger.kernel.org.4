Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BF6D1252
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjC3WmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjC3Wlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255BD308
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680216065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeByB0eKBNcXPROEK7aMdWm1Jx9YU5X0cZrhx6IoDGw=;
        b=fh8/Tlq7d2UTVH77TRXUmFIEnBl3I3JwiWp4nzxqB2+NC2boq+n059eswXgB7pPWdQVnSE
        IlKKnvF+BHRBC06d8XqhY6554imqLwxnBpcZ2I1jY6GUbHWE5bY/fr5/XbnmZPKseSd1uR
        2YNtPBTmTsjF9TiMMUR29Hjjc0LLcaE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-ZnHQl0UYNWCMJ1TBmPYPZA-1; Thu, 30 Mar 2023 18:40:54 -0400
X-MC-Unique: ZnHQl0UYNWCMJ1TBmPYPZA-1
Received: by mail-il1-f197.google.com with SMTP id r14-20020a056e02108e00b00326334613f0so3341713ilj.20
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeByB0eKBNcXPROEK7aMdWm1Jx9YU5X0cZrhx6IoDGw=;
        b=a0vjquI/8uba1OK4e1Fe724iberyy4ZlVlUe41i+rDLHAxr9D/s6ONgfrR8t5BFMs0
         cVzRJ+JZa5gchFe47WfbydRbPKLgQauG2N8tugtrjUHcR4ql/uwUPOQ8ujcstjrBhSh9
         CzOQreJoTabid/vi0xJr4cW0MKFXQ3vYRf5GSm7qf5LdGtsbU/yUSlSW/CPwqaUk/S+j
         XaJ859yhXup+h4o5fVR+fyEVXIXKgkYY4VnXOo16RKdgntSFEsoapmg/9/P1yXxsGTZ3
         fYVoTPl3oWuVzhTQH56H1OBBk9y3KxoSvr7G2i66yzt4KLdu+/gAfXYhStyayMfPrEdx
         HqOw==
X-Gm-Message-State: AO0yUKW2H3urn8TGaYmIy8GB1BzUCjagbFyRATV2wcj4jNeU4huq5WWr
        /liQb4BMwEgWD5Zu9ufyxVgYdIQd6UIiM28o3Ih4sKLNMfbZBNQSWbCAsa57TKE026slDOlyIPa
        EQ+s6dVLepJDs8ST5RIP2CTKR
X-Received: by 2002:a5d:8142:0:b0:74c:e456:629d with SMTP id f2-20020a5d8142000000b0074ce456629dmr18059012ioo.7.1680216053993;
        Thu, 30 Mar 2023 15:40:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set/1kPHqiwvhxx3wBi8sxQDtUuPIj9jrIpNw4xwmLuFLfkP3nWjNXDU+RYZMAMY1XD34uQpXqg==
X-Received: by 2002:a5d:8142:0:b0:74c:e456:629d with SMTP id f2-20020a5d8142000000b0074ce456629dmr18058998ioo.7.1680216053688;
        Thu, 30 Mar 2023 15:40:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id az3-20020a056638418300b004063cfecdb8sm202340jab.113.2023.03.30.15.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:40:53 -0700 (PDT)
Date:   Thu, 30 Mar 2023 16:40:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     jgg@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        tglx@linutronix.de, darwi@linutronix.de, kvm@vger.kernel.org,
        dave.jiang@intel.com, jing2.liu@intel.com, ashok.raj@intel.com,
        fenghua.yu@intel.com, tom.zanussi@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/8] vfio/pci: Support dynamic MSI-x
Message-ID: <20230330164050.0069e2a5.alex.williamson@redhat.com>
In-Reply-To: <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
References: <cover.1680038771.git.reinette.chatre@intel.com>
        <419f3ba2f732154d8ae079b3deb02d0fdbe3e258.1680038771.git.reinette.chatre@intel.com>
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

On Tue, 28 Mar 2023 14:53:34 -0700
Reinette Chatre <reinette.chatre@intel.com> wrote:

> Recently introduced pci_msix_alloc_irq_at() and pci_msix_free_irq()
> enables an individual MSI-X index to be allocated and freed after
> MSI-X enabling.
> 
> Support dynamic MSI-X if supported by the device. Keep the association
> between allocated interrupt and vfio interrupt context. Allocate new
> context together with the new interrupt if no interrupt context exist
> for an MSI-X interrupt. Similarly, release an interrupt with its
> context.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since RFC V1:
> - Add pointer to interrupt context as function parameter to
>   vfio_irq_ctx_free(). (Alex)
> - Initialize new_ctx to false. (Dan Carpenter)
> - Only support dynamic allocation if device supports it. (Alex)
> 
>  drivers/vfio/pci/vfio_pci_intrs.c | 93 +++++++++++++++++++++++++------
>  1 file changed, 76 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index b3a258e58625..755b752ca17e 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -55,6 +55,13 @@ struct vfio_pci_irq_ctx *vfio_irq_ctx_get(struct vfio_pci_core_device *vdev,
>  	return xa_load(&vdev->ctx, index);
>  }
>  
> +static void vfio_irq_ctx_free(struct vfio_pci_core_device *vdev,
> +			      struct vfio_pci_irq_ctx *ctx, unsigned long index)
> +{
> +	xa_erase(&vdev->ctx, index);
> +	kfree(ctx);
> +}
> +
>  static void vfio_irq_ctx_free_all(struct vfio_pci_core_device *vdev)
>  {
>  	struct vfio_pci_irq_ctx *ctx;
> @@ -409,33 +416,62 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  {
>  	struct pci_dev *pdev = vdev->pdev;
>  	struct vfio_pci_irq_ctx *ctx;
> +	struct msi_map msix_map = {};
> +	bool allow_dyn_alloc = false;
>  	struct eventfd_ctx *trigger;
> +	bool new_ctx = false;
>  	int irq, ret;
>  	u16 cmd;
>  
> +	/* Only MSI-X allows dynamic allocation. */
> +	if (msix && pci_msix_can_alloc_dyn(vdev->pdev))
> +		allow_dyn_alloc = true;

Should vfio-pci-core probe this and store it in a field on
vfio_pci_core_device so that we can simply use something like
vdev->has_dyn_msix throughout?

> +
>  	ctx = vfio_irq_ctx_get(vdev, vector);
> -	if (!ctx)
> +	if (!ctx && !allow_dyn_alloc)
>  		return -EINVAL;
> +
>  	irq = pci_irq_vector(pdev, vector);
> +	/* Context and interrupt are always allocated together. */
> +	WARN_ON((ctx && irq == -EINVAL) || (!ctx && irq != -EINVAL));
>  
> -	if (ctx->trigger) {
> +	if (ctx && ctx->trigger) {
>  		irq_bypass_unregister_producer(&ctx->producer);
>  
>  		cmd = vfio_pci_memory_lock_and_enable(vdev);
>  		free_irq(irq, ctx->trigger);
> +		if (allow_dyn_alloc) {

It almost seems easier to define msix_map in each scope that it's used:

			struct msi_map map = { .index = vector,
					       .virq = irq };

> +			msix_map.index = vector;
> +			msix_map.virq = irq;
> +			pci_msix_free_irq(pdev, msix_map);
> +			irq = -EINVAL;
> +		}
>  		vfio_pci_memory_unlock_and_restore(vdev, cmd);
>  		kfree(ctx->name);
>  		eventfd_ctx_put(ctx->trigger);
>  		ctx->trigger = NULL;
> +		if (allow_dyn_alloc) {
> +			vfio_irq_ctx_free(vdev, ctx, vector);
> +			ctx = NULL;
> +		}
>  	}
>  
>  	if (fd < 0)
>  		return 0;
>  
> +	if (!ctx) {
> +		ctx = vfio_irq_ctx_alloc_single(vdev, vector);
> +		if (!ctx)
> +			return -ENOMEM;
> +		new_ctx = true;
> +	}
> +
>  	ctx->name = kasprintf(GFP_KERNEL_ACCOUNT, "vfio-msi%s[%d](%s)",
>  			      msix ? "x" : "", vector, pci_name(pdev));
> -	if (!ctx->name)
> -		return -ENOMEM;
> +	if (!ctx->name) {
> +		ret = -ENOMEM;
> +		goto out_free_ctx;
> +	}
>  
>  	trigger = eventfd_ctx_fdget(fd);
>  	if (IS_ERR(trigger)) {
> @@ -443,25 +479,38 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  		goto out_free_name;
>  	}
>  
> -	/*
> -	 * The MSIx vector table resides in device memory which may be cleared
> -	 * via backdoor resets. We don't allow direct access to the vector
> -	 * table so even if a userspace driver attempts to save/restore around
> -	 * such a reset it would be unsuccessful. To avoid this, restore the
> -	 * cached value of the message prior to enabling.
> -	 */
>  	cmd = vfio_pci_memory_lock_and_enable(vdev);
>  	if (msix) {
> -		struct msi_msg msg;
> -
> -		get_cached_msi_msg(irq, &msg);
> -		pci_write_msi_msg(irq, &msg);
> +		if (irq == -EINVAL) {
> +			msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);

			struct msi_map map = pci_msix_alloc_irq_at(pdev,
								vector, NULL);
> +			if (msix_map.index < 0) {
> +				vfio_pci_memory_unlock_and_restore(vdev, cmd);
> +				ret = msix_map.index;
> +				goto out_put_eventfd_ctx;
> +			}
> +			irq = msix_map.virq;
> +		} else {
> +			/*
> +			 * The MSIx vector table resides in device memory which
> +			 * may be cleared via backdoor resets. We don't allow
> +			 * direct access to the vector table so even if a
> +			 * userspace driver attempts to save/restore around
> +			 * such a reset it would be unsuccessful. To avoid
> +			 * this, restore the cached value of the message prior
> +			 * to enabling.
> +			 */

You've only just copied this comment down to here, but I think it's a
bit stale.  Maybe we should update it to something that helps explain
this split better, maybe:

			/*
			 * If the vector was previously allocated, refresh the
			 * on-device message data before enabling in case it had
			 * been cleared or corrupted since writing.
			 */

IIRC, that was the purpose of writing it back to the device and the
blocking of direct access is no longer accurate anyway.

> +			struct msi_msg msg;
> +
> +			get_cached_msi_msg(irq, &msg);
> +			pci_write_msi_msg(irq, &msg);
> +		}
>  	}
>  
>  	ret = request_irq(irq, vfio_msihandler, 0, ctx->name, trigger);
> -	vfio_pci_memory_unlock_and_restore(vdev, cmd);
>  	if (ret)
> -		goto out_put_eventfd_ctx;
> +		goto out_free_irq_locked;
> +
> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
>  
>  	ctx->producer.token = trigger;
>  	ctx->producer.irq = irq;
> @@ -477,11 +526,21 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_core_device *vdev,
>  
>  	return 0;
>  
> +out_free_irq_locked:
> +	if (allow_dyn_alloc && new_ctx) {

		struct msi_map map = { .index = vector,
				       .virq = irq };

> +		msix_map.index = vector;
> +		msix_map.virq = irq;
> +		pci_msix_free_irq(pdev, msix_map);
> +	}
> +	vfio_pci_memory_unlock_and_restore(vdev, cmd);
>  out_put_eventfd_ctx:
>  	eventfd_ctx_put(trigger);
>  out_free_name:
>  	kfree(ctx->name);
>  	ctx->name = NULL;
> +out_free_ctx:
> +	if (allow_dyn_alloc && new_ctx)
> +		vfio_irq_ctx_free(vdev, ctx, vector);
>  	return ret;
>  }
>  

Do we really need the new_ctx test in the above cases?  Thanks,

Alex

