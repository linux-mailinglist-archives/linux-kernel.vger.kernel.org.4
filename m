Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75B5F3ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJDIvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJDIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:51:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF66D2610D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:51:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A95612E7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B78C433C1;
        Tue,  4 Oct 2022 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664873464;
        bh=8F+ScJBAf72fHb3N/CcIWR1PsEfpwR6g5EoZx1kjJCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tKrXFKjtTf7C7l8RpcsfYoGk+1TcJuovIfR7WXsoDvyJph65GdSQXIzAumNCQVoCj
         P3BuE2hXNLdQ4pybQQr+7ZjyLNkKjfDcTk6UI7NauVj5jUXfznOfyzJNj1us6EuIH0
         m3aS4w5kjKgvH5j5bev2QZsdCZn+JKdeOUcGxZwM=
Date:   Tue, 4 Oct 2022 10:51:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Yzvz9hn1G8rU4VaO@kroah.com>
References: <20221004003811.4075765-1-jrosenth@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004003811.4075765-1-jrosenth@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 06:38:11PM -0600, Jack Rosenthal wrote:
> The CBMEM area is a downward-growing memory region used by coreboot to
> dynamically allocate tagged data structures ("CBMEM entries") that
> remain resident during boot.
> 
> This implements a driver which exports access to the CBMEM entries
> via sysfs under /sys/bus/coreboot/devices/cbmem-<id>.
> 
> This implementation is quite versatile.  Examples of how it could be
> used are given below:
> 
> * Tools like util/cbmem from the coreboot tree could use this driver
>   instead of finding CBMEM in /dev/mem directly.  Alternatively,
>   firmware developers debugging an issue may find the sysfs interface
>   more ergonomic than the cbmem tool and choose to use it directly.
> 
> * The crossystem tool, which exposes verified boot variables, can use
>   this driver to read the vboot work buffer.
> 
> * Tools which read the BIOS SPI flash (e.g., flashrom) can find the
>   flash layout in CBMEM directly, which is significantly faster than
>   searching the flash directly.
> 
> Write access is provided to all CBMEM regions via
> /sys/bus/coreboot/devices/cbmem-<id>/mem, as the existing cbmem
> tooling updates this memory region, and envisioned use cases with
> crossystem can benefit from updating memory regions.
> 
> Link: https://issuetracker.google.com/239604743
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Tested-by: Jack Rosenthal <jrosenth@chromium.org>
> Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
> ---
> Changes in v12:
> * Removed symlink from /sys/firmware/cbmem to the device.
> * Device is now named cbmem-<id>, allowing location of the device in
>   sysfs by the CBMEM id.
> * Documentation and Kconfig help text expanded.
> 
>  Documentation/ABI/testing/sysfs-bus-coreboot |  50 +++++++
>  drivers/firmware/google/Kconfig              |  14 ++
>  drivers/firmware/google/Makefile             |   3 +
>  drivers/firmware/google/cbmem.c              | 139 +++++++++++++++++++
>  drivers/firmware/google/coreboot_table.c     |  11 +-
>  drivers/firmware/google/coreboot_table.h     |  18 +++
>  6 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coreboot
>  create mode 100644 drivers/firmware/google/cbmem.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-coreboot b/Documentation/ABI/testing/sysfs-bus-coreboot
> new file mode 100644
> index 000000000000..886a39758896
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-coreboot
> @@ -0,0 +1,50 @@
> +What:		/sys/bus/coreboot
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		The coreboot bus provides a variety of virtual devices used to
> +		access data structures created by the Coreboot BIOS.
> +
> +What:		/sys/bus/coreboot/devices/cbmem-<id>
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		CBMEM is a downwards-growing memory region created by Coreboot,
> +		and contains tagged data structures to be shared with payloads
> +		in the boot process and the OS.  Each CBMEM entry is given a
> +		directory in /sys/bus/coreboot/devices based on its id.
> +		A list of ids known to Coreboot can be found in the coreboot
> +		source tree at
> +		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.

That will not age well, why not point to the reference in the kernel
tree instead?

> +
> +What:		/sys/bus/coreboot/devices/cbmem-<id>/address
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		This is the pyhsical memory address that the CBMEM entry's data
> +		begins at.

In hex?  Decimal?

> +
> +What:		/sys/bus/coreboot/devices/cbmem-<id>/size
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		This is the size of the CBMEM entry's data.

In hex?  Decimal?  Octal?  Binary?  Be specific please :)

> +
> +What:		/sys/bus/coreboot/devices/cbmem-<id>/id
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		This is the CBMEM id corresponding to the entry.

so "id" is the same as "<id>" here?  Why is that needed?

> +
> +What:		/sys/bus/coreboot/devices/cbmem-<id>/mem
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		A file exposing read/write access to the entry's data.  Note
> +		that this file does not support mmap(), as coreboot
> +		does not guarantee that the data will be page-aligned.
> +
> +		The mode of this file is 0600.  While there shouldn't be
> +		anything security-sensitive contained in CBMEM, read access
> +		requires root privileges given this is exposing a small subset
> +		of physical memory.
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 983e07dc022e..a9b246e67b23 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -19,6 +19,20 @@ config GOOGLE_SMI
>  	  driver provides an interface for reading and writing NVRAM
>  	  variables.
>  
> +config GOOGLE_CBMEM
> +	tristate "CBMEM entries in sysfs"
> +	depends on GOOGLE_COREBOOT_TABLE
> +	help
> +	  CBMEM is a downwards-growing memory region created by the
> +	  Coreboot BIOS containing tagged data structures from the
> +	  BIOS.  These data structures expose things like the verified
> +	  boot firmware variables, flash layout, firmware event log,
> +	  and more.
> +
> +	  Say Y here to enable the kernel to search for Coreboot CBMEM
> +	  entries, and expose the memory for each entry in sysfs under
> +	  /sys/bus/coreboot/devices/cbmem-<id>.

Module name?

> +
>  config GOOGLE_COREBOOT_TABLE
>  	tristate "Coreboot Table Access"
>  	depends on HAS_IOMEM && (ACPI || OF)
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> index d17caded5d88..8151e323cc43 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
>  
> +# Must come after coreboot_table.o, as this driver depends on that bus type.

Doesn't the linker handle this for us?

> +obj-$(CONFIG_GOOGLE_CBMEM)		+= cbmem.o
> +
>  vpd-sysfs-y := vpd.o vpd_decode.o
>  obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
> diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/google/cbmem.c
> new file mode 100644
> index 000000000000..e4bb20432854
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cbmem.c
> + *
> + * Driver for exporting cbmem entries in sysfs.
> + *
> + * Copyright 2022 Google LLC
> + */
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +#include "coreboot_table.h"
> +
> +struct cbmem_entry {
> +	char *mem_file_buf;
> +	u32 size;
> +};
> +
> +static struct cbmem_entry *to_cbmem_entry(struct kobject *kobj)
> +{
> +	return dev_get_drvdata(kobj_to_dev(kobj));
> +}
> +
> +static ssize_t mem_read(struct file *filp, struct kobject *kobj,
> +			struct bin_attribute *bin_attr, char *buf, loff_t pos,
> +			size_t count)
> +{
> +	struct cbmem_entry *entry = to_cbmem_entry(kobj);
> +
> +	return memory_read_from_buffer(buf, count, &pos, entry->mem_file_buf,
> +				       entry->size);
> +}
> +
> +static ssize_t mem_write(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf, loff_t pos,
> +			 size_t count)
> +{
> +	struct cbmem_entry *entry = to_cbmem_entry(kobj);
> +
> +	if (pos < 0 || pos >= entry->size)
> +		return -EINVAL;
> +	if (count > entry->size - pos)
> +		count = entry->size - pos;
> +
> +	memcpy(entry->mem_file_buf + pos, buf, count);
> +	return count;
> +}
> +static BIN_ATTR_ADMIN_RW(mem, 0);

Userspace can handle a size of 0 for this file ok?

> +
> +static ssize_t address_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
> +
> +	return sysfs_emit(buf, "0x%llx\n", cbdev->cbmem_entry.address);
> +}
> +static DEVICE_ATTR_RO(address);
> +
> +static ssize_t size_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
> +
> +	return sysfs_emit(buf, "0x%x\n", cbdev->cbmem_entry.entry_size);
> +}
> +static DEVICE_ATTR_RO(size);
> +
> +static ssize_t id_show(struct device *dev, struct device_attribute *attr,
> +		       char *buf)
> +{
> +	struct coreboot_device *cbdev = dev_to_coreboot_device(dev);
> +
> +	return sysfs_emit(buf, "0x%08x\n", cbdev->cbmem_entry.id);
> +}
> +static DEVICE_ATTR_RO(id);
> +
> +static struct attribute *attrs[] = {
> +	&dev_attr_address.attr,
> +	&dev_attr_size.attr,
> +	&dev_attr_id.attr,
> +	NULL,
> +};
> +
> +static struct bin_attribute *bin_attrs[] = {
> +	&bin_attr_mem,
> +	NULL,
> +};
> +
> +static const struct attribute_group cbmem_entry_group = {
> +	.attrs = attrs,
> +	.bin_attrs = bin_attrs,
> +};
> +
> +static const struct attribute_group *dev_groups[] = {
> +	&cbmem_entry_group,
> +	NULL,
> +};
> +
> +static int cbmem_entry_probe(struct coreboot_device *dev)
> +{
> +	struct cbmem_entry *entry;
> +
> +	entry = devm_kzalloc(&dev->dev, sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&dev->dev, entry);
> +	entry->mem_file_buf = devm_memremap(&dev->dev, dev->cbmem_entry.address,
> +					    dev->cbmem_entry.entry_size,
> +					    MEMREMAP_WB);
> +	if (!entry->mem_file_buf)
> +		return -ENOMEM;
> +
> +	entry->size = dev->cbmem_entry.entry_size;

Ah nevermind you set the size here.

> +
> +	return 0;
> +}
> +
> +static struct coreboot_driver cbmem_entry_driver = {
> +	.probe = cbmem_entry_probe,
> +	.drv = {
> +		.name = "cbmem",
> +		.owner = THIS_MODULE,
> +		.dev_groups = dev_groups,
> +	},
> +	.tag = LB_TAG_CBMEM_ENTRY,
> +};
> +module_coreboot_driver(cbmem_entry_driver);
> +
> +MODULE_AUTHOR("Jack Rosenthal <jrosenth@chromium.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
> index c52bcaa9def6..7748067eb9e6 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -97,12 +97,21 @@ static int coreboot_table_populate(struct device *dev, void *ptr)
>  		if (!device)
>  			return -ENOMEM;
>  
> -		dev_set_name(&device->dev, "coreboot%d", i);
>  		device->dev.parent = dev;
>  		device->dev.bus = &coreboot_bus_type;
>  		device->dev.release = coreboot_device_release;
>  		memcpy(&device->entry, ptr_entry, entry->size);
>  
> +		switch (device->entry.tag) {
> +		case LB_TAG_CBMEM_ENTRY:
> +			dev_set_name(&device->dev, "cbmem-%08x",
> +				     device->cbmem_entry.id);
> +			break;
> +		default:
> +			dev_set_name(&device->dev, "coreboot%d", i);
> +			break;
> +		}
> +
>  		ret = device_register(&device->dev);
>  		if (ret) {
>  			put_device(&device->dev);
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index beb778674acd..37f4d335a606 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -39,6 +39,18 @@ struct lb_cbmem_ref {
>  	u64 cbmem_addr;
>  };
>  
> +#define LB_TAG_CBMEM_ENTRY 0x31
> +
> +/* Corresponds to LB_TAG_CBMEM_ENTRY */
> +struct lb_cbmem_entry {
> +	u32 tag;
> +	u32 size;

little or big endian?

Overall looks much better than before, thanks for the changes.

greg k-h
