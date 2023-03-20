Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971C6C23F1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCTVhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCTVg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0DE6585
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679348021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9G1RfVkKk4V5VifMLmdOsd1JK3JWUyZtoHHPyD3DZo=;
        b=NmDJquPwzGO0jNUJHfJ8TfwnOY+MeQSlmtQwnLZO6joIFck7lqXPtO6kcncGqP8rVeucOg
        Xj3QCQulwN862gd9B0MSHmd1cS+D3F2XndtjDn6wbNz7jNG3+p/WaC3iQ4i/zfwysDs3lZ
        BA1guFVxxdjCz2Sb45jVFuhigwWn3tE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-yDUyz4AMPNyW_eMT88HdGw-1; Mon, 20 Mar 2023 17:33:40 -0400
X-MC-Unique: yDUyz4AMPNyW_eMT88HdGw-1
Received: by mail-io1-f72.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso6782447ior.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679348019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9G1RfVkKk4V5VifMLmdOsd1JK3JWUyZtoHHPyD3DZo=;
        b=0eXr5o5IhtvydCL+2Kqe+zNH6as7TyUzGVR5AzNYRO7257xCTK4NW3IL+FKnvLGT2a
         bvaeAgDNnOHPqOJMyCAdOq7X49/8i2AxSAg07RF8IYxlnb6ZBi5O15YrSQSCw8AUgOl7
         B5mywpmcGDjA6q0fkrjz3CNgxZR3aEXDggxhhNIA065IontL6kTMXx8NH0KsY7fzXFCn
         U6ZSJR6lxLzGMeaWwRVYbNJQqVceC8AXUrZKpsyyNvptc/Px0nLy4RPqBb/dY6jCaFbt
         k/4kUTDDhYC/GwLztHQOem3lMM2v+fZC6Y+tPVwsvWQVJTNlGNykfmgk8+wxwvoKGULn
         EZeA==
X-Gm-Message-State: AO0yUKX+kJ5t9LgHyGeqivZC/q750NstWF+z7sJlQ9ERkR58E8llmAps
        Cy58fE2iXCByVfHWm3Wl4t/7kTmEPSx+xJTx0eif1vgBYSr4f4paU1yNVLJMaIKN6qYXQMedDKo
        tSjend3lO14vwmmuvQYhWnXOk
X-Received: by 2002:a92:d48f:0:b0:310:d294:1664 with SMTP id p15-20020a92d48f000000b00310d2941664mr85281ilg.7.1679348019423;
        Mon, 20 Mar 2023 14:33:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set/WuvDCe0syg/8go/mO/Es1El259KoG9kXQdZ30YRcERmsYsGfhbYx71PRI1AtFZNqS9/DGWw==
X-Received: by 2002:a92:d48f:0:b0:310:d294:1664 with SMTP id p15-20020a92d48f000000b00310d2941664mr85268ilg.7.1679348019115;
        Mon, 20 Mar 2023 14:33:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z38-20020a0293a9000000b003e43da36e1fsm3620846jah.12.2023.03.20.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 14:33:38 -0700 (PDT)
Date:   Mon, 20 Mar 2023 15:33:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     <jgg@nvidia.com>, <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v9 1/5] vfio/migration: Add debugfs to live migration
 driver
Message-ID: <20230320153336.74b853c7.alex.williamson@redhat.com>
In-Reply-To: <20230320092338.2889-2-liulongfang@huawei.com>
References: <20230320092338.2889-1-liulongfang@huawei.com>
        <20230320092338.2889-2-liulongfang@huawei.com>
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

On Mon, 20 Mar 2023 17:23:34 +0800
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
>     +-------------------------------------------+
>     |                                           |
>     |                                           |
>     |                  QEMU                     |
>     |                                           |
>     |                                           |
>     +---+----------------------------+----------+
>         |      ^                     |      ^
>         |      |                     |      |
>         |      |                     |      |
>         v      |                     v      |
>      +---------+--+               +---------+--+
>      |src vfio_dev|               |dst vfio_dev|
>      +--+---------+               +--+---------+
>         |      ^                     |      ^
>         |      |                     |      |
>         v      |                     |      |
>    +-----------+----+           +-----------+----+
>    |src dev debugfs |           |dst dev debugfs |
>    +----------------+           +----------------+
> 
> The entire debugfs directory will be based on the definition of
> the CONFIG_DEBUG_FS macro. If this macro is not enabled, the
> interfaces in vfio.h will be empty definitions, and the creation
> and initialization of the debugfs directory will not be executed.
> 
>    vfio
>     |
>     +---<dev_name1>
>     |    +---migration
>     |        +--state
>     |        +--hisi_acc
>     |            +--attr
>     |            +--data
>     |            +--debug
>     |
>     +---<dev_name2>
>          +---migration
>              +--state
>              +--hisi_acc
>                  +--attr
>                  +--data
>                  +--debug
> 
> debugfs will create a public root directory "vfio" file.
> then create a dev_name() file for each live migration device.
> First, create a unified state acquisition file of "migration"
> in this device directory.
> Then, create a public live migration state lookup file "state"
> Finally, create a directory file based on the device type,
> and then create the device's own debugging files under
> this directory file.
> 
> Here, HiSilicon accelerator creates three debug files:
> attr: used to obtain the attribute parameters of the
> current live migration device.
> data: used to get the live migration data of the current
> live migration device.
> debug: Used to debug the current live migration device
> through commands.
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
>  drivers/vfio/Makefile       |  2 +-
>  drivers/vfio/vfio.h         | 14 +++++++
>  drivers/vfio/vfio_debugfs.c | 80 +++++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_main.c    |  5 +++
>  include/linux/vfio.h        |  8 ++++
>  5 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vfio/vfio_debugfs.c
> 
> diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
> index 70e7dcb302ef..1debcff31d30 100644
> --- a/drivers/vfio/Makefile
> +++ b/drivers/vfio/Makefile
> @@ -7,7 +7,7 @@ vfio-y += vfio_main.o \
>  vfio-$(CONFIG_IOMMUFD) += iommufd.o
>  vfio-$(CONFIG_VFIO_CONTAINER) += container.o
>  vfio-$(CONFIG_VFIO_VIRQFD) += virqfd.o
> -
> +vfio-$(CONFIG_DEBUG_FS) += vfio_debugfs.o
>  obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
>  obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
>  obj-$(CONFIG_VFIO_PCI) += pci/
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index e9721d8424bc..8e5cafa6aa3a 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -258,4 +258,18 @@ static inline void vfio_device_put_kvm(struct vfio_device *device)
>  }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +void vfio_debugfs_create_root(void);
> +void vfio_debugfs_remove_root(void);
> +
> +void vfio_device_debugfs_init(struct vfio_device *vdev);
> +void vfio_device_debugfs_exit(struct vfio_device *vdev);
> +#else
> +static inline void vfio_debugfs_create_root(void) { }
> +static inline void vfio_debugfs_remove_root(void) { }
> +
> +static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
> +static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
> +#endif /* CONFIG_DEBUG_FS */
> +
>  #endif
> diff --git a/drivers/vfio/vfio_debugfs.c b/drivers/vfio/vfio_debugfs.c
> new file mode 100644
> index 000000000000..f5b6bf2a1d48
> --- /dev/null
> +++ b/drivers/vfio/vfio_debugfs.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, HiSilicon Ltd.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/seq_file.h>
> +#include <linux/vfio.h>
> +#include "vfio.h"
> +
> +static struct dentry *vfio_debugfs_root;
> +
> +static int vfio_device_state_read(struct seq_file *seq, void *data)
> +{
> +	struct device *vf_dev = seq->private;
> +	struct vfio_device *vdev = container_of(vf_dev, struct vfio_device, device);
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
> +void vfio_device_debugfs_init(struct vfio_device *vdev)
> +{
> +	struct dentry *vfio_dev_migration = NULL;
> +	struct device *dev = &vdev->device;
> +
> +	vdev->debug_root = debugfs_create_dir(dev_name(vdev->dev), vfio_debugfs_root);
> +	vfio_dev_migration = debugfs_create_dir("migration", vdev->debug_root);

Am I understanding correctly that there seems to be a standard with
debugfs helpers to accept and test for bad inputs such that typical
callers don't bother to test for ERR_PTRs from cases like above?

> +
> +	debugfs_create_devm_seqfile(dev, "state", vfio_dev_migration,
> +				  vfio_device_state_read);
> +}
> +EXPORT_SYMBOL_GPL(vfio_device_debugfs_init);

I think these should be more integrated into vfio core.  As it is, this
series doesn't enable the base migration/state entry support for
drivers other than hisi_acc, where this proposal requires explicit
setup and teardown by the driver probe and remove callbacks.

Instead the init and exit functions here should be called directly from
__vfio_register_dev() and vfio_unregister_group_dev() respectively.
The setup of the migration directory and state file should be
conditional on the device providing mig_ops, while the base dev_name
directory is setup for all devices for future use cases.

This would allow that mlx5 and future drivers automatically get this
with no driver code, and in fact all devices would get debugfs dev_name
directories for better test coverage.  hisi_acc would only need to add
driver specific entries after registering the device and free any
related data after unregistering the device.  In this way, none of the
entry points here would need to be exported for drivers, which is
perhaps the direction Jason was thinking with his prior comments.

> +
> +void vfio_device_debugfs_exit(struct vfio_device *vdev)
> +{
> +	debugfs_remove_recursive(vdev->debug_root);
> +}
> +EXPORT_SYMBOL_GPL(vfio_device_debugfs_exit);
> +
> +void vfio_debugfs_create_root(void)
> +{
> +	vfio_debugfs_root = debugfs_create_dir("vfio", NULL);
> +}
> +
> +void vfio_debugfs_remove_root(void)
> +{
> +	debugfs_remove_recursive(vfio_debugfs_root);
> +	vfio_debugfs_root = NULL;
> +}
> +
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 3a597e799918..09772fd3a396 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1408,6 +1408,9 @@ static int __init vfio_init(void)
>  	}
>  
>  	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
> +
> +	vfio_debugfs_create_root();
> +

The pr_info is intended to be the last call in the init path.

>  	return 0;
>  
>  err_dev_class:
> @@ -1425,6 +1428,8 @@ static void __exit vfio_cleanup(void)
>  	vfio_virqfd_exit();
>  	vfio_group_cleanup();
>  	xa_destroy(&vfio_device_set_xa);
> +
> +	vfio_debugfs_remove_root();

The added blank line is unnecessary, there's no conceptual reason to
split this from the remaining teardown.  I suspect this should also be
first in the teardown since it was setup last on init and I don't see
any other dependencies.

>  }
>  
>  module_init(vfio_init);
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 93134b023968..fa6b898ebb58 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -63,6 +63,14 @@ struct vfio_device {
>  	struct iommufd_ctx *iommufd_ictx;
>  	bool iommufd_attached;
>  #endif
> +
> +#ifdef CONFIG_DEBUG_FS
> +	/*
> +	 * debug_root is a static property of the vfio_device
> +	 * which must be set prior to registering the vfio_device.
> +	 */

What imposed this ordering requirement?  In fact the code flow here
makes the debugfs entries available event before the device is
registered with vfio core, which seems problematic.  This goes away if
it's setup as described above. Thanks,

Alex

> +	struct dentry *debug_root;
> +#endif
>  };
>  
>  /**

