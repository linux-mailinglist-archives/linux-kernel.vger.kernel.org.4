Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF070FBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbjEXQq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjEXQqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EEE9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684946735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9BwvZyIZR4w30R2L9ROFHRO0PN6N9VTGaj3qK3Nz3kg=;
        b=XBnREt+v2TgPr9MvdbW3XEY2fs9bOjzLvl2p0CQ/5ZbTBxLqBgroljt8IaWygWoC4y9szW
        opPeiHGk8Mv5QwX28GHQJteHe+IMBf00ooO2yeWI9DbB1KXsUzhnXqmnkSJHnpLqqckte0
        iwbx35EUhjaDp89gGNs67Habc4CB2bo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-AEXNU4JNOEKWJ4rZZup9GQ-1; Wed, 24 May 2023 12:45:34 -0400
X-MC-Unique: AEXNU4JNOEKWJ4rZZup9GQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so180043639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946733; x=1687538733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BwvZyIZR4w30R2L9ROFHRO0PN6N9VTGaj3qK3Nz3kg=;
        b=H3Ro0Mgd8ElAz0+qII8z8NXnLA7jxsbVMzqiq+ZoOEvMwpRG81T1luKJLiV115Fx2D
         siMhgvwNv5RDmNML/pVI4QCBTkSosBoQSEI5Ciom1ZwKC56aReg5paJ00TxKh2UAl/ua
         NDo3780pDx7ILneM2dBQhZbJe1+7NQ7p9bsbT3TFQpJjGPa1BjBMpPCZJTgjJ6gLTLLd
         KoIL6obkh7W98hbgzp7sj1MRDuuanE1n2/P9VwyWDrM2jzOp5KFCOIMWmEawBBapZx5a
         KyLwUczEAl4+2qYQzjUtnGJW2b2O/67m0rHXQG0X+Pga1wE6COfFVccIp6l0FsY4e4zf
         r5IA==
X-Gm-Message-State: AC+VfDynuFrozURZ74pZSYkotnxaao0TalMNUOdrHTOsX9nxqOId5nqe
        /P9K5TaNoR7T3mBDdyd/K8Wt3vWKhnQD4i7Vh93bbI7EQO6x96LO4gO93u8X/oQGkCr7yUr7NiK
        PN6/5dA3695v5kgdpR+BVxKJR
X-Received: by 2002:a5d:928d:0:b0:763:5cf8:65eb with SMTP id s13-20020a5d928d000000b007635cf865ebmr13021250iom.9.1684946732972;
        Wed, 24 May 2023 09:45:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DEQxscr9QyidH5v0VuLOntOMVIjIJ9QuGHTZVD/m6pe7oA2pSH3fYIMg5l70Ijui2S4jMpw==
X-Received: by 2002:a5d:928d:0:b0:763:5cf8:65eb with SMTP id s13-20020a5d928d000000b007635cf865ebmr13021225iom.9.1684946732658;
        Wed, 24 May 2023 09:45:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g11-20020a056602248b00b00760ed8349e6sm3449046ioe.7.2023.05.24.09.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:45:32 -0700 (PDT)
Date:   Wed, 24 May 2023 10:45:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        <kvm@vger.kernel.org>, <masahiroy@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <nicolas@fjasle.eu>, <git@amd.com>,
        <harpreet.anand@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>
Subject: Re: [PATCH v6] vfio/cdx: add support for CDX bus
Message-ID: <20230524104529.28708ae8.alex.williamson@redhat.com>
In-Reply-To: <20230517095718.16117-1-nipun.gupta@amd.com>
References: <20230517095718.16117-1-nipun.gupta@amd.com>
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

On Wed, 17 May 2023 15:27:18 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> vfio-cdx driver enables IOCTLs for user space to query
> MMIO regions for CDX devices and mmap them. This change
> also adds support for reset of CDX devices. With VFIO
> enabled on CDX devices, user-space applications can also
> exercise DMA securely via IOMMU on these devices.
> 
> This change adds the VFIO CDX driver and enables the following
> ioctls for CDX devices:
>  - VFIO_DEVICE_GET_INFO:
>  - VFIO_DEVICE_GET_REGION_INFO
>  - VFIO_DEVICE_RESET
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
> 
> Changes v5->v6:
> - removed forward declaration of vfio_cdx_driver
> - removed un-necessary CDX_DRIVER_OVERRIDE_DEVICE_VFIO and
>   vfio_cdx_regions_cleanup.
> - removed unrequired dev_warn/dev_err
> - used module_driver instead of module_init/exit
> 
> Changes v4->v5:
> - renamed vfio_cdx.c to main.c and vfio_cdx_private.h
>   to private.h
> - have separate functions for get_info and get_region_info
> 
> Changes v3->v4:
> - fix vfio info flags
> 
> Changes v2->v3:
> - removed redundant init and release functions
> - removed redundant dev and cdx_dev from vfio_cdx_device
> - added support for iommufd
> - added VFIO_DEVICE_FLAGS_CDX
> - removed unrequried WARN_ON
> - removed unused ioaddr
> 
> Changes v1->v2:
> - Updated file2alias to support vfio_cdx
> - removed some un-necessary checks in mmap
> - removed vfio reset wrapper API
> - converted complex macros to static APIs
> - used pgprot_device and io_remap_pfn_range
> 
>  MAINTAINERS                       |   7 +
>  drivers/vfio/Kconfig              |   1 +
>  drivers/vfio/Makefile             |   1 +
>  drivers/vfio/cdx/Kconfig          |  17 +++
>  drivers/vfio/cdx/Makefile         |   8 +
>  drivers/vfio/cdx/main.c           | 234 ++++++++++++++++++++++++++++++
>  drivers/vfio/cdx/private.h        |  28 ++++
>  include/linux/cdx/cdx_bus.h       |   1 -
>  include/linux/mod_devicetable.h   |   6 +
>  include/uapi/linux/vfio.h         |   1 +
>  scripts/mod/devicetable-offsets.c |   1 +
>  scripts/mod/file2alias.c          |  17 ++-
>  12 files changed, 320 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/vfio/cdx/Kconfig
>  create mode 100644 drivers/vfio/cdx/Makefile
>  create mode 100644 drivers/vfio/cdx/main.c
>  create mode 100644 drivers/vfio/cdx/private.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a72b8fcea261..d6d1ddb854d7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22096,6 +22096,13 @@ F:	Documentation/filesystems/vfat.rst
>  F:	fs/fat/
>  F:	tools/testing/selftests/filesystems/fat/
>  
> +VFIO CDX DRIVER
> +M:	Nipun Gupta <nipun.gupta@amd.com>
> +M:	Nikhil Agarwal <nikhil.agarwal@amd.com>
> +L:	kvm@vger.kernel.org
> +S:	Maintained
> +F:	drivers/vfio/cdx/*
> +
>  VFIO DRIVER
>  M:	Alex Williamson <alex.williamson@redhat.com>
>  L:	kvm@vger.kernel.org
> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
> index 89e06c981e43..aba36f5be4ec 100644
> --- a/drivers/vfio/Kconfig
> +++ b/drivers/vfio/Kconfig
> @@ -57,6 +57,7 @@ source "drivers/vfio/pci/Kconfig"
>  source "drivers/vfio/platform/Kconfig"
>  source "drivers/vfio/mdev/Kconfig"
>  source "drivers/vfio/fsl-mc/Kconfig"
> +source "drivers/vfio/cdx/Kconfig"
>  endif
>  
>  source "virt/lib/Kconfig"
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 70e7dcb302ef..1a27b2516612 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -14,3 +14,4 @@ obj-$(CONFIG_VFIO_PCI) += pci/
>  obj-$(CONFIG_VFIO_PLATFORM) += platform/
>  obj-$(CONFIG_VFIO_MDEV) += mdev/
>  obj-$(CONFIG_VFIO_FSL_MC) += fsl-mc/
> +obj-$(CONFIG_VFIO_CDX) += cdx/
> diff --git a/drivers/vfio/cdx/Kconfig b/drivers/vfio/cdx/Kconfig
> new file mode 100644
> index 000000000000..e6de0a0caa32
> --- /dev/null
> +++ b/drivers/vfio/cdx/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# VFIO CDX configuration
> +#
> +# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> +#
> +
> +config VFIO_CDX
> +	tristate "VFIO support for CDX bus devices"
> +	depends on CDX_BUS
> +	select EVENTFD
> +	help
> +	  Driver to enable VFIO support for the devices on CDX bus.
> +	  This is required to make use of CDX devices present in
> +	  the system using the VFIO framework.
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/vfio/cdx/Makefile b/drivers/vfio/cdx/Makefile
> new file mode 100644
> index 000000000000..cd4a2e6fe609
> --- /dev/null
> +++ b/drivers/vfio/cdx/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> +#
> +
> +obj-$(CONFIG_VFIO_CDX) += vfio-cdx.o
> +
> +vfio-cdx-objs := main.o
> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> new file mode 100644
> index 000000000000..f03f491e0435
> --- /dev/null
> +++ b/drivers/vfio/cdx/main.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/vfio.h>
> +#include <linux/cdx/cdx_bus.h>
> +
> +#include "private.h"
> +
> +static int vfio_cdx_open_device(struct vfio_device *core_vdev)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> +	int count = cdx_dev->res_count;
> +	int i;
> +
> +	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
> +				GFP_KERNEL);

Nit, GFP_KERNEL_ACCOUNT since we're allocating long term storage on
behalf of a user operation.

> +	if (!vdev->regions)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < count; i++) {
> +		struct resource *res = &cdx_dev->res[i];
> +
> +		vdev->regions[i].addr = res->start;
> +		vdev->regions[i].size = resource_size(res);
> +		vdev->regions[i].type = res->flags;
> +		/*
> +		 * Only regions addressed with PAGE granularity may be
> +		 * MMAP'ed securely.
> +		 */
> +		if (!(vdev->regions[i].addr & ~PAGE_MASK) &&
> +		    !(vdev->regions[i].size & ~PAGE_MASK))
> +			vdev->regions[i].flags |=
> +					VFIO_REGION_INFO_FLAG_MMAP;
> +		vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_READ;
> +		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
> +			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vfio_cdx_close_device(struct vfio_device *core_vdev)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +
> +	kfree(vdev->regions);
> +	cdx_dev_reset(core_vdev->dev);
> +}
> +
> +static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
> +				   struct vfio_device_info __user *arg)
> +{
> +	unsigned long minsz = offsetofend(struct vfio_device_info, num_irqs);
> +	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
> +	struct vfio_device_info info;
> +
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	info.flags = VFIO_DEVICE_FLAGS_CDX;
> +	info.flags |= VFIO_DEVICE_FLAGS_RESET;
> +
> +	info.num_regions = cdx_dev->res_count;
> +	info.num_irqs = 0;
> +
> +	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> +}
> +
> +static int vfio_cdx_ioctl_get_region_info(struct vfio_cdx_device *vdev,
> +					  struct vfio_region_info __user *arg)
> +{
> +	unsigned long minsz = offsetofend(struct vfio_region_info, offset);
> +	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
> +	struct vfio_region_info info;
> +
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (info.index >= cdx_dev->res_count)
> +		return -EINVAL;
> +
> +	/* map offset to the physical address */
> +	info.offset = vfio_cdx_index_to_offset(info.index);
> +	info.size = vdev->regions[info.index].size;
> +	info.flags = vdev->regions[info.index].flags;
> +
> +	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
> +}
> +
> +static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
> +			   unsigned int cmd, unsigned long arg)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	void __user *uarg = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case VFIO_DEVICE_GET_INFO:
> +		return vfio_cdx_ioctl_get_info(vdev, uarg);
> +	case VFIO_DEVICE_GET_REGION_INFO:
> +		return vfio_cdx_ioctl_get_region_info(vdev, uarg);
> +	case VFIO_DEVICE_RESET:
> +		return cdx_dev_reset(core_vdev->dev);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static int vfio_cdx_mmap_mmio(struct vfio_cdx_region region,
> +			      struct vm_area_struct *vma)
> +{
> +	u64 size = vma->vm_end - vma->vm_start;
> +	u64 pgoff, base;
> +
> +	pgoff = vma->vm_pgoff &
> +		((1U << (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
> +	base = pgoff << PAGE_SHIFT;
> +
> +	if (region.size < PAGE_SIZE || base + size > region.size)

Nit, we've already enforced the first condition, a sub-page region
won't have the mmap flag set and we already verified this region does
have that flag set.

> +		return -EINVAL;
> +
> +	vma->vm_pgoff = (region.addr >> PAGE_SHIFT) + pgoff;
> +	vma->vm_page_prot = pgprot_device(vma->vm_page_prot);
> +
> +	return io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> +				  size, vma->vm_page_prot);
> +}
> +
> +static int vfio_cdx_mmap(struct vfio_device *core_vdev,
> +			 struct vm_area_struct *vma)
> +{
> +	struct vfio_cdx_device *vdev =
> +		container_of(core_vdev, struct vfio_cdx_device, vdev);
> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> +	unsigned int index;
> +
> +	index = vma->vm_pgoff >> (VFIO_CDX_OFFSET_SHIFT - PAGE_SHIFT);
> +
> +	if (index >= cdx_dev->res_count)
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_MMAP))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_READ) &&
> +	    (vma->vm_flags & VM_READ))
> +		return -EINVAL;
> +
> +	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE) &&
> +	    (vma->vm_flags & VM_WRITE))
> +		return -EINVAL;

It might be useful to distinguish these two cases with -EPERM.
Otherwise this looks ok to me.  Thanks,

Alex

> +
> +	return vfio_cdx_mmap_mmio(vdev->regions[index], vma);
> +}
> +
> +static const struct vfio_device_ops vfio_cdx_ops = {
> +	.name		= "vfio-cdx",
> +	.open_device	= vfio_cdx_open_device,
> +	.close_device	= vfio_cdx_close_device,
> +	.ioctl		= vfio_cdx_ioctl,
> +	.mmap		= vfio_cdx_mmap,
> +	.bind_iommufd	= vfio_iommufd_physical_bind,
> +	.unbind_iommufd	= vfio_iommufd_physical_unbind,
> +	.attach_ioas	= vfio_iommufd_physical_attach_ioas,
> +};
> +
> +static int vfio_cdx_probe(struct cdx_device *cdx_dev)
> +{
> +	struct vfio_cdx_device *vdev = NULL;
> +	struct device *dev = &cdx_dev->dev;
> +	int ret;
> +
> +	vdev = vfio_alloc_device(vfio_cdx_device, vdev, dev,
> +				 &vfio_cdx_ops);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	ret = vfio_register_group_dev(&vdev->vdev);
> +	if (ret)
> +		goto out_uninit;
> +
> +	dev_set_drvdata(dev, vdev);
> +	return 0;
> +
> +out_uninit:
> +	vfio_put_device(&vdev->vdev);
> +	return ret;
> +}
> +
> +static int vfio_cdx_remove(struct cdx_device *cdx_dev)
> +{
> +	struct device *dev = &cdx_dev->dev;
> +	struct vfio_cdx_device *vdev = dev_get_drvdata(dev);
> +
> +	vfio_unregister_group_dev(&vdev->vdev);
> +	vfio_put_device(&vdev->vdev);
> +
> +	return 0;
> +}
> +
> +static const struct cdx_device_id vfio_cdx_table[] = {
> +	{ CDX_DEVICE_DRIVER_OVERRIDE(CDX_ANY_ID, CDX_ANY_ID,
> +				     CDX_ID_F_VFIO_DRIVER_OVERRIDE) }, /* match all by default */
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(cdx, vfio_cdx_table);
> +
> +static struct cdx_driver vfio_cdx_driver = {
> +	.probe		= vfio_cdx_probe,
> +	.remove		= vfio_cdx_remove,
> +	.match_id_table	= vfio_cdx_table,
> +	.driver	= {
> +		.name	= "vfio-cdx",
> +		.owner	= THIS_MODULE,
> +	},
> +	.driver_managed_dma = true,
> +};
> +
> +module_driver(vfio_cdx_driver, cdx_driver_register, cdx_driver_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("VFIO for CDX devices - User Level meta-driver");
> diff --git a/drivers/vfio/cdx/private.h b/drivers/vfio/cdx/private.h
> new file mode 100644
> index 000000000000..8bdc117ea88e
> --- /dev/null
> +++ b/drivers/vfio/cdx/private.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef VFIO_CDX_PRIVATE_H
> +#define VFIO_CDX_PRIVATE_H
> +
> +#define VFIO_CDX_OFFSET_SHIFT    40
> +
> +static inline u64 vfio_cdx_index_to_offset(u32 index)
> +{
> +	return ((u64)(index) << VFIO_CDX_OFFSET_SHIFT);
> +}
> +
> +struct vfio_cdx_region {
> +	u32			flags;
> +	u32			type;
> +	u64			addr;
> +	resource_size_t		size;
> +};
> +
> +struct vfio_cdx_device {
> +	struct vfio_device	vdev;
> +	struct vfio_cdx_region	*regions;
> +};
> +
> +#endif /* VFIO_CDX_PRIVATE_H */
> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index 35ef41d8a61a..bead71b7bc73 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -14,7 +14,6 @@
>  #include <linux/mod_devicetable.h>
>  
>  #define MAX_CDX_DEV_RESOURCES	4
> -#define CDX_ANY_ID (0xFFFF)
>  #define CDX_CONTROLLER_ID_SHIFT 4
>  #define CDX_BUS_NUM_MASK 0xF
>  
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index ccaaeda792c0..ccf017353bb6 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -912,6 +912,12 @@ struct ishtp_device_id {
>  	kernel_ulong_t driver_data;
>  };
>  
> +#define CDX_ANY_ID (0xFFFF)
> +
> +enum {
> +	CDX_ID_F_VFIO_DRIVER_OVERRIDE = 1,
> +};
> +
>  /**
>   * struct cdx_device_id - CDX device identifier
>   * @vendor: Vendor ID
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 0552e8dcf0cb..8e91aaf973e7 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -213,6 +213,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_AP	(1 << 5)	/* vfio-ap device */
>  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
>  #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
> +#define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  	__u32   cap_offset;	/* Offset within info struct of first cap */
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 62dc988df84d..abe65f8968dd 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -265,6 +265,7 @@ int main(void)
>  	DEVID(cdx_device_id);
>  	DEVID_FIELD(cdx_device_id, vendor);
>  	DEVID_FIELD(cdx_device_id, device);
> +	DEVID_FIELD(cdx_device_id, override_only);
>  
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 28da34ba4359..38120f932b0d 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1458,8 +1458,23 @@ static int do_cdx_entry(const char *filename, void *symval,
>  {
>  	DEF_FIELD(symval, cdx_device_id, vendor);
>  	DEF_FIELD(symval, cdx_device_id, device);
> +	DEF_FIELD(symval, cdx_device_id, override_only);
>  
> -	sprintf(alias, "cdx:v%08Xd%08Xd", vendor, device);
> +	switch (override_only) {
> +	case 0:
> +		strcpy(alias, "cdx:");
> +		break;
> +	case CDX_ID_F_VFIO_DRIVER_OVERRIDE:
> +		strcpy(alias, "vfio_cdx:");
> +		break;
> +	default:
> +		warn("Unknown CDX driver_override alias %08X\n",
> +		     override_only);
> +		return 0;
> +	}
> +
> +	ADD(alias, "v", vendor != CDX_ANY_ID, vendor);
> +	ADD(alias, "d", device != CDX_ANY_ID, device);
>  	return 1;
>  }
>  

