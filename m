Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AFC6A0770
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbjBWLbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjBWLbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:31:44 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF94366BB;
        Thu, 23 Feb 2023 03:31:42 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 51D1340007;
        Thu, 23 Feb 2023 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677151901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PKYqixAspN9nOykbcEx8Q4SCeGzlDxFRkc8HIRLfYk=;
        b=KVHr6z0/Tr81EtVOiQ2e74UtUhq9eQSC98rBqKiNpE22BI19oQHXzBMp9MAGEXWMPXCCrF
        uHNhskIhdxrkQCvXWPDQkJvH9cOjrGOSoInQvSQVcFRAPgqatabkdCrtH04Af5/qkGCmTq
        bQQW0/hQ78sprKjhsz6xQMoMtE4L3Ks0W4qnVTHHEM1yzKHf7RNuGmz0YNjCEoNSIEUqTY
        ZCJGth2lFHemErV4GbhcXOoFwHSsx5E9jeyxdn3HFDIXe/BJMxmCIVy+NNo4LUDHsLyDDs
        ehAC4ManpXotSuY2ysE4RantLwDgF8lGHO2v6br0jDoxtwxR98JRtrVZUu3KkQ==
Date:   Thu, 23 Feb 2023 12:34:15 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/2] of: create of_root if no dtb provided
Message-ID: <20230223123415.6dade5ec@fixe.home>
In-Reply-To: <20230222221051.809091-2-frowand.list@gmail.com>
References: <20230222221051.809091-1-frowand.list@gmail.com>
        <20230222221051.809091-2-frowand.list@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, 22 Feb 2023 16:10:50 -0600,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb.
>=20
> If firmware provides a flattened device tree (FDT) then the FDT is
> unflattened via setup_arch().  Otherwise, setup_of() which is called
> immediately after setup_arch(), and will create the default root node
> if it does not exist.
>=20
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> ---
>=20
> There are checkpatch warnings.  I have reviewed them and feel
> they can be ignored.
>=20
> Changes since version 1:
>   - refresh for 6.2-rc1
>   - update Signed-off-by
>   - fix typo in of_fdt.h: s/of_setup/setup_of
>   - unflatten_device_tree(): validate size in header field dtb_empty_root
>     that will be used to copy dtb_empty_root
>   - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE
>=20
>  drivers/of/Kconfig        |  7 ++++++-
>  drivers/of/Makefile       |  2 +-
>  drivers/of/empty_root.dts |  6 ++++++
>  drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
>  include/linux/of_fdt.h    |  2 ++
>  init/main.c               |  2 ++
>  6 files changed, 43 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
>=20
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..591cfe386727 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -42,9 +42,14 @@ config OF_FLATTREE
>  	select CRC32
> =20
>  config OF_EARLY_FLATTREE
> -	bool
> +	bool "Functions for accessing Flat Devicetree (FDT) early in boot"
>  	select DMA_DECLARE_COHERENT if HAS_DMA
>  	select OF_FLATTREE
> +	help
> +	  Normally selected by platforms that process an FDT that has been
> +	  passed to the kernel by the bootloader.  If the bootloader does not
> +	  pass an FDT to the kernel and you need an empty devicetree that
> +	  contains only a root node to exist, then say Y here.
> =20
>  config OF_PROMTREE
>  	bool
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..cbae92c5ed02 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -2,7 +2,7 @@
>  obj-y =3D base.o device.o platform.o property.o
>  obj-$(CONFIG_OF_KOBJ) +=3D kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) +=3D dynamic.o
> -obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o
> +obj-$(CONFIG_OF_FLATTREE) +=3D fdt.o empty_root.dtb.o
>  obj-$(CONFIG_OF_EARLY_FLATTREE) +=3D fdt_address.o
>  obj-$(CONFIG_OF_PROMTREE) +=3D pdt.o
>  obj-$(CONFIG_OF_ADDRESS)  +=3D address.o
> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> new file mode 100644
> index 000000000000..cf9e97a60f48
> --- /dev/null
> +++ b/drivers/of/empty_root.dts
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +/ {
> +
> +};
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index b2272bccf85c..0d2f6d016b7e 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -33,6 +33,13 @@
> =20
>  #include "of_private.h"
> =20
> +/*
> + * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created=
 by
> + * cmd_dt_S_dtb in scripts/Makefile.lib
> + */
> +extern void *__dtb_empty_root_begin;
> +extern void *__dtb_empty_root_end;
> +
>  /*
>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>   * @limit: maximum entries
> @@ -1326,8 +1333,19 @@ bool __init early_init_dt_scan(void *params)
>   */
>  void __init unflatten_device_tree(void)
>  {
> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
> +	if (!initial_boot_params) {
> +		initial_boot_params =3D (void *) __dtb_empty_root_begin;

The crash I encountered was actually not due to memblock alloc but to
this usage/declaration of the embedded dtb pointers which is wrong.

Either declare it as:

 extern char __dtb_empty_root_begin[];
 extern char __dtb_empty_root_end[];

and keep the existing usage in this function or keep the existing
declaration but modify this function to use &__dtb_empty_root_begin

With this modification, I finally have an empty device-tree present on
my system:

$ dtc -I fs -O dts  /sys/firmware/devicetree/
/dts-v1/;

/ {
};

Thanks,

Cl=C3=A9ment

> +		/* fdt_totalsize() will be used for copy size */
> +		if (fdt_totalsize(initial_boot_params) >
> +		    __dtb_empty_root_end - __dtb_empty_root_begin) {
> +			pr_err("invalid size in dtb_empty_root\n");
> +			return;
> +		}
> +		unflatten_and_copy_device_tree();
> +	} else {
> +		__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch, false);
> +	}
> =20
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>  	of_alias_scan(early_init_dt_alloc_memory_arch);
> @@ -1367,6 +1385,13 @@ void __init unflatten_and_copy_device_tree(void)
>  	unflatten_device_tree();
>  }
> =20
> +void __init setup_of(void)
> +{
> +	/* if architecture did not unflatten devicetree, do it now */
> +	if (!of_root)
> +		unflatten_device_tree();
> +}
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t of_fdt_raw_read(struct file *filp, struct kobject *kobj,
>  			       struct bin_attribute *bin_attr,
> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
> index d69ad5bb1eb1..f0dc46d576da 100644
> --- a/include/linux/of_fdt.h
> +++ b/include/linux/of_fdt.h
> @@ -81,6 +81,7 @@ extern const void *of_flat_dt_match_machine(const void =
*default_match,
>  /* Other Prototypes */
>  extern void unflatten_device_tree(void);
>  extern void unflatten_and_copy_device_tree(void);
> +extern void setup_of(void);
>  extern void early_init_devtree(void *);
>  extern void early_get_first_memblock_info(void *, phys_addr_t *);
>  #else /* CONFIG_OF_EARLY_FLATTREE */
> @@ -91,6 +92,7 @@ static inline void early_init_fdt_reserve_self(void) {}
>  static inline const char *of_flat_dt_get_machine_name(void) { return NUL=
L; }
>  static inline void unflatten_device_tree(void) {}
>  static inline void unflatten_and_copy_device_tree(void) {}
> +static inline void setup_of(void) {}
>  #endif /* CONFIG_OF_EARLY_FLATTREE */
> =20
>  #endif /* __ASSEMBLY__ */
> diff --git a/init/main.c b/init/main.c
> index e1c3911d7c70..31e0931b5134 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -101,6 +101,7 @@
>  #include <linux/init_syscalls.h>
>  #include <linux/stackdepot.h>
>  #include <linux/randomize_kstack.h>
> +#include <linux/of_fdt.h>
>  #include <net/net_namespace.h>
> =20
>  #include <asm/io.h>
> @@ -961,6 +962,7 @@ asmlinkage __visible void __init __no_sanitize_addres=
s start_kernel(void)
>  	pr_notice("%s", linux_banner);
>  	early_security_init();
>  	setup_arch(&command_line);
> +	setup_of();
>  	setup_boot_config();
>  	setup_command_line(command_line);
>  	setup_nr_cpu_ids();



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
