Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D55ED483
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiI1GNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1GN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974111F12C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBDC460B84
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DAFC433C1;
        Wed, 28 Sep 2022 06:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664345606;
        bh=J5azeZVy4SrNtc0SdxoXRWiPsqLEveBxuiu/6eyVn1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfbjRVZ9UvuGnGVIJL3YFk0GDXKPRC71kOlY8Ylm/oX/it7iS6DEEylXnCSZq98+U
         f4C+9Rdx35eH/ddIJFxyMOelFiSjHm55oIyQymawkeigsewmUL8x/sPEZ0AY7VWOhF
         TOB5yOiu0n45NLttmw5ejmKYg27j0m/qrLeqmD+k=
Date:   Wed, 28 Sep 2022 08:14:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [RESEND PATCH v10] firmware: google: Implement cbmem in sysfs
 driver
Message-ID: <YzPmKF6LRwXVua3X@kroah.com>
References: <20220927205551.2017473-1-jrosenth@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927205551.2017473-1-jrosenth@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 02:55:51PM -0600, Jack Rosenthal wrote:
> The CBMEM area is a downward-growing memory region used by coreboot to
> dynamically allocate tagged data structures ("CBMEM entries") that
> remain resident during boot.
> 
> This implements a driver which exports access to the CBMEM entries
> via sysfs under /sys/firmware/coreboot/cbmem/<id>.
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
> /sys/firmware/coreboot/cbmem/<id>/mem, as the existing cbmem tooling
> updates this memory region, and envisioned use cases with crossystem
> can benefit from updating memory regions.
> 
> Link: https://issuetracker.google.com/239604743
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Tested-by: Jack Rosenthal <jrosenth@chromium.org>
> Signed-off-by: Jack Rosenthal <jrosenth@chromium.org>
> ---

Why is this a RESEND?

I don't remember seeing any of the 10 previous versions, but hey, I
can't remember much...

>  .../ABI/testing/sysfs-firmware-coreboot       |  49 ++++
>  drivers/firmware/google/Kconfig               |   8 +
>  drivers/firmware/google/Makefile              |   3 +
>  drivers/firmware/google/cbmem.c               | 225 ++++++++++++++++++
>  drivers/firmware/google/coreboot_table.c      |  10 +
>  drivers/firmware/google/coreboot_table.h      |  16 ++
>  6 files changed, 311 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-coreboot
>  create mode 100644 drivers/firmware/google/cbmem.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-firmware-coreboot b/Documentation/ABI/testing/sysfs-firmware-coreboot
> new file mode 100644
> index 000000000000..c003eb515d0c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-firmware-coreboot
> @@ -0,0 +1,49 @@
> +What:		/sys/firmware/coreboot/
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		Kernel objects associated with the Coreboot-based BIOS firmware.

Why is "coreboot" needed here?  Will this work for all coreboot
implementations?

Why is coreboot files being in a 

> +What:		/sys/firmware/coreboot/cbmem/<id>/address
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		The memory address that the CBMEM entry's data begins at.

Raw memory addresses?  Why?

> +What:		/sys/firmware/coreboot/cbmem/<id>/size
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		The size of the data being stored.

Nothing is being "stored" here, it is being read.

> +What:		/sys/firmware/coreboot/cbmem/<id>/mem
> +Date:		August 2022
> +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> +Description:
> +		A file exposing read/write access to the entry's data.  Note
> +		that this file does not support mmap(), and should be used for
> +		basic data access only.  Users requiring mmap() should read the
> +		address and size files, and mmap() /dev/mem.

Why doesn't mmap work?



> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index 983e07dc022e..b0f7a24fd90a 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -19,6 +19,14 @@ config GOOGLE_SMI
>  	  driver provides an interface for reading and writing NVRAM
>  	  variables.
>  
> +config GOOGLE_CBMEM
> +	tristate "CBMEM entries in sysfs"
> +	depends on GOOGLE_COREBOOT_TABLE
> +	help
> +	  This option enables the kernel to search for Coreboot CBMEM
> +	  entries, and expose the memory for each entry in sysfs under
> +	  /sys/firmware/coreboot/cbmem.

What's the security implications of exposing all of this information?

> +	sysfs_bin_attr_init(&entry->mem_file);
> +	entry->mem_file.attr.name = "mem";
> +	entry->mem_file.attr.mode = 0600;
> +	entry->mem_file.size = entry->dev->cbmem_entry.entry_size;
> +	entry->mem_file.read = cbmem_entry_mem_read;
> +	entry->mem_file.write = cbmem_entry_mem_write;
> +	entry->mem_file.private = entry;
> +	ret = sysfs_create_bin_file(entry->kobj, &entry->mem_file);
> +	if (ret)
> +		goto free_kobj;
> +
> +	sysfs_attr_init(&entry->address_file.kobj_attr.attr);
> +	entry->address_file.kobj_attr.attr.name = "address";
> +	entry->address_file.kobj_attr.attr.mode = 0444;
> +	entry->address_file.kobj_attr.show = cbmem_entry_address_show;
> +	entry->address_file.entry = entry;
> +	ret = sysfs_create_file(entry->kobj,
> +				&entry->address_file.kobj_attr.attr);
> +	if (ret)
> +		goto free_mem_file;
> +
> +	sysfs_attr_init(&entry->size_file.kobj_attr.attr);
> +	entry->size_file.kobj_attr.attr.name = "size";
> +	entry->size_file.kobj_attr.attr.mode = 0444;
> +	entry->size_file.kobj_attr.show = cbmem_entry_size_show;
> +	entry->size_file.entry = entry;
> +	ret = sysfs_create_file(entry->kobj, &entry->size_file.kobj_attr.attr);
> +	if (ret)
> +		goto free_address_file;
> +
> +	sysfs_attr_init(&entry->id_file.kobj_attr.attr);
> +	entry->id_file.kobj_attr.attr.name = "id";
> +	entry->id_file.kobj_attr.attr.mode = 0444;
> +	entry->id_file.kobj_attr.show = cbmem_entry_id_show;
> +	entry->id_file.entry = entry;
> +	ret = sysfs_create_file(entry->kobj, &entry->id_file.kobj_attr.attr);
> +	if (ret)
> +		goto free_size_file;

Please use an attribute group so that this all happens automatically and
you do not have to hand add and remove files.

That will make this logic much simpler and cleaner.

> +struct kobject *coreboot_kobj;
> +EXPORT_SYMBOL(coreboot_kobj);

EXPORT_SYMBOL_GPL() for kobjects please.

> +
>  static int coreboot_bus_match(struct device *dev, struct device_driver *drv)
>  {
>  	struct coreboot_device *device = CB_DEV(dev);
> @@ -157,6 +162,10 @@ static int coreboot_table_probe(struct platform_device *pdev)
>  	}
>  	memunmap(ptr);
>  
> +	coreboot_kobj = kobject_create_and_add("coreboot", firmware_kobj);
> +	if (!coreboot_kobj)
> +		return -ENOMEM;
> +
>  	return ret;
>  }
>  
> @@ -170,6 +179,7 @@ static int coreboot_table_remove(struct platform_device *pdev)
>  {
>  	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
>  	bus_unregister(&coreboot_bus_type);
> +	kobject_put(coreboot_kobj);
>  	return 0;
>  }
>  
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index beb778674acd..76c31e6e5376 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -14,6 +14,11 @@
>  
>  #include <linux/device.h>
>  
> +struct kobject;
> +
> +/* This is /sys/firmware/coreboot */
> +extern struct kobject *coreboot_kobj;
> +
>  /* Coreboot table header structure */
>  struct coreboot_table_header {
>  	char signature[4];
> @@ -39,6 +44,16 @@ struct lb_cbmem_ref {
>  	u64 cbmem_addr;
>  };
>  
> +/* Corresponds to LB_TAG_CBMEM_ENTRY */
> +struct lb_cbmem_entry {
> +	u32 tag;
> +	u32 size;
> +
> +	u64 address;
> +	u32 entry_size;
> +	u32 id;

As these cross the user/kernel boundry shouldn't they be __u32 and
__u64?  Or is that not how coreboot works?

thanks,

greg k-h
