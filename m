Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510D167D55C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjAZT3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjAZT3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:29:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23F59B4D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674761299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sDk1RvEOJfMFRE3ap4g0ZV9bVsqkdFOMYB5Rjr8tXF0=;
        b=Vb7aVGPBZvwdGbPvdGvgc3GRZjAq73RaiELcWQXebFk4hrCG3TyA6HoINGe2sO3sCZW45B
        85XISc2wUAlWRFu43vFTXMIQ2IQQ8b/uAZQYfdytfFbbUp+fVr8Nswszq+tEbZJP1R+Bwn
        KGbroJ6uUcJ3SO3+uBLw0jw5fEXNkew=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-EKUDQs2TMPC6ek5s6GODJQ-1; Thu, 26 Jan 2023 14:28:17 -0500
X-MC-Unique: EKUDQs2TMPC6ek5s6GODJQ-1
Received: by mail-io1-f72.google.com with SMTP id y3-20020a5e8343000000b00704dc16167cso1495002iom.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDk1RvEOJfMFRE3ap4g0ZV9bVsqkdFOMYB5Rjr8tXF0=;
        b=AQfKrWdrGEMEICqFZw0PcG/xaiswQkS9rI9LXrSJzOB5ooGafV1uycCAfYKxwCDgnA
         W2H8zUTUT9ZfGac5cM/usNJ6e0bVBNvDk7eiY6f4ABMRlnE1WKmd4OpAFJaF657TPl0j
         qLs/nXoeShoUzYbXJuX63+16OkdJZxqV9VmL/vh8o1OywnS7WSwvYxwdYnxjVhZTgdix
         QRti3qLyjbEqX3L8LqqIz2XuIW2bRjrHe77Hk3BQEHeo1ORrNlvSxtYKw+oAtRyjTH5z
         Un8A+Mif2zjEZGIu5H67KyEi7ogitAIZ6WvHBKHDhmM0IHqjVSRm3jBppiV0jIGXhYZ8
         fVkg==
X-Gm-Message-State: AO0yUKX+CIsYBdBypBbGDLMJWN6qizR7NQOIqV1RPHCSpYkk98uex/JK
        kPMywD1hLWA5zeMRrj07d1pgj0oF8Q73BeOBPNz+UHhwzbMCqft+CZzNw6r3nmC2EaSSzRCI/Wh
        8Q2nGJX5NBsjK8ESk9ucpMOU4
X-Received: by 2002:a5e:c117:0:b0:6df:7841:4cf with SMTP id v23-20020a5ec117000000b006df784104cfmr2169134iol.6.1674761296978;
        Thu, 26 Jan 2023 11:28:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/QXdEu0s/1LiHc1TlGSj5teYePnngLOyIdKpe1fs0REuiIW2h7h2u3V10AL324tVB4gk3AdQ==
X-Received: by 2002:a5e:c117:0:b0:6df:7841:4cf with SMTP id v23-20020a5ec117000000b006df784104cfmr2169117iol.6.1674761296657;
        Thu, 26 Jan 2023 11:28:16 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id k9-20020a02ccc9000000b003a961e5d33fsm596210jaq.49.2023.01.26.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 11:28:15 -0800 (PST)
Date:   Thu, 26 Jan 2023 12:27:59 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v7 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <20230126122759.5aa4d84c.alex.williamson@redhat.com>
In-Reply-To: <20230120032930.43608-2-liulongfang@huawei.com>
References: <20230120032930.43608-1-liulongfang@huawei.com>
        <20230120032930.43608-2-liulongfang@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 11:29:26 +0800
Longfang Liu <liulongfang@huawei.com> wrote:

> There are multiple devices, software and operational steps involved
> in the process of live migration. An error occurred on any node may
> cause the live migration operation to fail.
> This complex process makes it very difficult to locate and analyze
> the cause when the function fails.
> 
> In order to quickly locate the cause of the problem when the
> live migration fails, I added a set of debugfs to the vfio
> live migration driver.
> 
>  +------------------------------------------+
>  |                                          |
>  |                                          |
>  |                 QEMU                     |
>  |                                          |
>  |                                          |
>  +-----+-------------------------+----------+
>        |   ^                     |   ^
>        v   |                     v   |
>      +-----+--+                +-----+--+
>      | src VF |                | dst VF |
>      +-+------+                +-+------+
>        |   ^                     |   ^
>        v   |                     v   |
>  +-------+-+------+        +-------+-+------+
>  |Debugfs|state   |        |Debugfs|state   |
>  +-------+--------+        +-------+--------+
>  |   debug_root   |        |   debug_root   |
>  +-------+--------+        +-------+--------+
> 
> The entire debugfs directory will be based on the definition of
> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> interfaces in vfio_pci_debugfs.h will be empty definitions,
> and the creation and initialization of the debugfs directory
> will not be executed.
> 
> debugfs will create a public root directory "vfio_mig" file.
> then create a "debug_root" file for each live migration VF device.

s/VF // In practice it may be VFs, but I don't think we want to
artificially imply that the device must be a VF.  In fact, I'm not sure
why any of this code lives in vfio/pci/ vs vfio/, there's nothing PCI
specific here.  Why isn't all of this done in vfio_main to be shared
with both pci and non-pci vfio drivers and devices?

> state file: used to get the status of the live migration device.
> debug_root: used to create your own custom debug files for live
> migration device drivers.
> 
> The live migration function of the current device can be tested by
> operating the debug files, and the functional status of the equipment
> and software at each stage can be tested step by step without
> performing the complete live migration function. And after the live
> migration is performed, the migration device data of the live migration
> can be obtained through the debug files.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/vfio/pci/Makefile           |  1 +
>  drivers/vfio/pci/vfio_pci_core.c    |  3 ++
>  drivers/vfio/pci/vfio_pci_debugfs.c | 80 +++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_debugfs.h | 28 ++++++++++
>  include/linux/vfio.h                |  8 +++
>  5 files changed, 120 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.c
>  create mode 100644 drivers/vfio/pci/vfio_pci_debugfs.h
> 
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 24c524224da5..75fe37e72e8d 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -2,6 +2,7 @@
>  
>  vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
> +vfio-pci-core-$(CONFIG_DEBUG_FS) += vfio_pci_debugfs.o
>  obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>  
>  vfio-pci-y := vfio_pci.o
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f9365a5bc961..e85df2deb8e6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -31,6 +31,7 @@
>  #include <asm/eeh.h>
>  #endif
>  
> +#include "vfio_pci_debugfs.h"
>  #include "vfio_pci_priv.h"
>  
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> @@ -2555,11 +2556,13 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
>  
>  static void vfio_pci_core_cleanup(void)
>  {
> +	vfio_pci_debugfs_remove_root();
>  	vfio_pci_uninit_perm_bits();
>  }
>  
>  static int __init vfio_pci_core_init(void)
>  {
> +	vfio_pci_debugfs_create_root();
>  	/* Allocate shared config space permission data used by all devices */
>  	return vfio_pci_init_perm_bits();
>  }
> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.c b/drivers/vfio/pci/vfio_pci_debugfs.c
> new file mode 100644
> index 000000000000..0bcf0bf034e5
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_debugfs.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, HiSilicon Ltd.
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/vfio_pci_core.h>
> +
> +#include "vfio_pci_debugfs.h"
> +
> +static struct dentry *vfio_pci_debugfs_root;
> +
> +static int vfio_pci_vf_state_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_pci_core_device *core_device = dev_get_drvdata(vf_dev);
> +	struct vfio_device *vdev = &core_device->vdev;
> +	enum vfio_device_mig_state state;
> +	int ret;
> +
> +	ret = vdev->mig_ops->migration_get_state(vdev, &state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	switch (state) {
> +	case VFIO_DEVICE_STATE_RUNNING:
> +		seq_printf(seq, "%s\n", "RUNNING");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP_COPY:
> +		seq_printf(seq, "%s\n", "STOP_COPY");
> +		break;
> +	case VFIO_DEVICE_STATE_STOP:
> +		seq_printf(seq, "%s\n", "STOP");
> +		break;
> +	case VFIO_DEVICE_STATE_RESUMING:
> +		seq_printf(seq, "%s\n", "RESUMING");
> +		break;
> +	case VFIO_DEVICE_STATE_RUNNING_P2P:
> +		seq_printf(seq, "%s\n", "RESUMING_P2P");
> +		break;
> +	case VFIO_DEVICE_STATE_ERROR:
> +		seq_printf(seq, "%s\n", "ERROR");
> +		break;
> +	default:
> +		seq_printf(seq, "%s\n", "Invalid");
> +	}
> +
> +	return 0;
> +}
> +
> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct device *dev = vdev->dev;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(dev), vfio_pci_debugfs_root);
> +
> +	debugfs_create_devm_seqfile(dev, "state", vdev->debug_root,
> +				  vfio_pci_vf_state_read);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_init);
> +
> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_vf_debugfs_exit);
> +
> +void  vfio_pci_debugfs_create_root(void)
> +{
> +	vfio_pci_debugfs_root = debugfs_create_dir("vfio_mig", NULL);

Is this hierarchical, ie. should we have "vfio/migration/" such that we
can introduce other debugfs entries w/o creating vfio_foo, vfio_bar,
vfio_baz, etc.  Otherwise the core or pci-core should only initialize a
"vfio" or "vfio-pci" root and the above init and exit interfaces should
be migration specific, creating "migrations_state" and only removing
the entries on exit that their companion init function created.

> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_create_root);
> +
> +void  vfio_pci_debugfs_remove_root(void)
> +{
> +	debugfs_remove_recursive(vfio_pci_debugfs_root);
> +	vfio_pci_debugfs_root = NULL;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_debugfs_remove_root);
> +
> diff --git a/drivers/vfio/pci/vfio_pci_debugfs.h b/drivers/vfio/pci/vfio_pci_debugfs.h
> new file mode 100644
> index 000000000000..beaaa709725e
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_debugfs.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * vfio_pci_debugfs.h - VFIO migration debugfs interface
> + *
> + * Copyright (c) 2023, HiSilicon Ltd.
> + *
> + * Author: Longfang Liu <liulongfang@huawei.com>
> + */
> +
> +#ifndef __VFIO_PCI_DEBUGFS_H
> +#define __VFIO_PCI_DEBUGFS_H
> +
> +#include <linux/debugfs.h>
> +#include <linux/vfio.h>
> +
> +#ifdef CONFIG_DEBUG_FS
> +void vfio_pci_debugfs_create_root(void);
> +void vfio_pci_debugfs_remove_root(void);
> +void vfio_pci_vf_debugfs_init(struct vfio_device *vdev);
> +void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev);
> +#else
> +static inline void vfio_pci_debugfs_create_root(void) {}
> +static inline void vfio_pci_debugfs_remove_root(void) {}
> +static inline void vfio_pci_vf_debugfs_init(struct vfio_device *vdev) {}
> +static inline void vfio_pci_vf_debugfs_exit(struct vfio_device *vdev) {}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#endif /* __VFIO_PCI_DEBUGFS_H */

With the above changes, declarations should probably just exist in
drivers/vfio/vfio.h.  Thanks,

Alex

> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index b4d5d4ca3d7d..b4bc8dfe8413 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -54,6 +54,14 @@ struct vfio_device {
>  	struct completion comp;
>  	struct list_head group_next;
>  	struct list_head iommu_entry;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	/*
> +	 * debug_root is a static property of the vfio_device
> +	 * which must be set prior to registering the vfio_device.
> +	 */
> +	struct dentry *debug_root;
> +#endif
>  };
>  
>  /**

