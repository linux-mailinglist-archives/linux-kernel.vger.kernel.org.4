Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805195F111D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiI3RqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbiI3RqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:46:21 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CC1739D3;
        Fri, 30 Sep 2022 10:46:20 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id b23so3090110qtr.13;
        Fri, 30 Sep 2022 10:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UWpIBj+/9sQw5QyigeVTqr3A6AC0TPRLfI1uqBcxDFQ=;
        b=VR2+2gNu3LTkl+BoDjmmOhbecJd4mtc75UZOiu0CgblrgQ05u3xTwba9LdO4skt2US
         3673nKuMg+fkQadH/fr1cw9ppuOLhU3L6DWYmGW++6in9BwJWd1zKWbk1URjCC34U9YI
         mvFtxYikWo28t4KWTm1Wbo8KIkXQKsNxArRf49X1YY3UwyyQiWSuylWaRXdtOySjAsun
         80LL/8wK7MnKJflI686VYoSDQkd3/AWDE2wEC1poTnV17DWX6oPwBYvCEu70Gsr1+fZ3
         rqyhSD6OYdAU+SOdlhY6jRGcUpSx+cD6W8JziaxKES7zDkwEIcZ6XH0eozrqHonBfA3u
         bRQA==
X-Gm-Message-State: ACrzQf0QY2BJ2jGL46oG8w9UIJ7+DY3kwUDb+kjSvoxYBX9/6jVgWJPX
        VsLCzxqj0kE9Bm6O3R1b3Big4yLy6BiUQJtE0/0=
X-Google-Smtp-Source: AMsMyM4m7jwXON/4b4YZv4l+r4LmRE0QFUsGIqap9s7oQh8aq/1X51OA+Ojtt77lDUokyhsUUE54UNjZsPEN39MaHno=
X-Received: by 2002:a05:622a:1a08:b0:35c:d9b5:144b with SMTP id
 f8-20020a05622a1a0800b0035cd9b5144bmr7795240qtb.27.1664559979468; Fri, 30 Sep
 2022 10:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
In-Reply-To: <20220929002834.32664-1-bwicaksono@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Sep 2022 19:46:08 +0200
Message-ID: <CAJZ5v0iBZRZmV_oU+VurqxnVMbFN_ttqrL=cLh0sUH+=u0PYsw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
To:     Besar Wicaksono <bwicaksono@nvidia.com>, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com
Cc:     lenb@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        guohanjun@huawei.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 2:29 AM Besar Wicaksono <bwicaksono@nvidia.com> wrote:
>
> ARM Performance Monitoring Unit Table describes the properties of PMU
> support in ARM-based system. The APMT table contains a list of nodes,
> each represents a PMU in the system that conforms to ARM CoreSight PMU
> architecture. The properties of each node include information required
> to access the PMU (e.g. MMIO base address, interrupt number) and also
> identification. For more detailed information, please refer to the
> specification below:
>  * APMT: https://developer.arm.com/documentation/den0117/latest
>  * ARM Coresight PMU:
>         https://developer.arm.com/documentation/ihi0091/latest
>
> The initial support adds the detection of APMT table and generic
> infrastructure to create platform devices for ARM CoreSight PMUs.
> Similar to IORT the root pointer of APMT is preserved during runtime
> and each PMU platform device is given a pointer to the corresponding
> APMT node.
>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the change in bus.c, but as a side note, it would be good to move
all of the ARM-specific initialization into one place, so it is not
necessary to touch bus.c every time a new piece of it is added.

> ---
>
> The patch applies on top of
>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   master next-20220524
>
> Changes from v1:
>  * Include acpi_apmt.h header file
>  * Update the device name. Related driver patch:
>    https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1-bwicaksono@nvidia.com/
> v1: https://lkml.org/lkml/2022/4/19/1395
>
>  arch/arm64/Kconfig          |   1 +
>  drivers/acpi/arm64/Kconfig  |   3 +
>  drivers/acpi/arm64/Makefile |   1 +
>  drivers/acpi/arm64/apmt.c   | 177 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c          |   2 +
>  include/linux/acpi_apmt.h   |  19 ++++
>  6 files changed, 203 insertions(+)
>  create mode 100644 drivers/acpi/arm64/apmt.c
>  create mode 100644 include/linux/acpi_apmt.h
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aaeb70358979..dbcb09ee29dd 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config ARM64
>         def_bool y
> +       select ACPI_APMT if ACPI
>         select ACPI_CCA_REQUIRED if ACPI
>         select ACPI_GENERIC_GSI if ACPI
>         select ACPI_GTDT if ACPI
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index d4a72835f328..b3ed6212244c 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -18,3 +18,6 @@ config ACPI_AGDI
>           reset command.
>
>           If set, the kernel parses AGDI table and listens for the command.
> +
> +config ACPI_APMT
> +       bool
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 7b9e4045659d..e21a9e84e394 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -2,4 +2,5 @@
>  obj-$(CONFIG_ACPI_AGDI)        += agdi.o
>  obj-$(CONFIG_ACPI_IORT)        += iort.o
>  obj-$(CONFIG_ACPI_GTDT)        += gtdt.o
> +obj-$(CONFIG_ACPI_APMT)        += apmt.o
>  obj-y                          += dma.o
> diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
> new file mode 100644
> index 000000000000..f55167ca51e7
> --- /dev/null
> +++ b/drivers/acpi/arm64/apmt.c
> @@ -0,0 +1,177 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ARM APMT table support.
> + * Design document number: ARM DEN0117.
> + *
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#define pr_fmt(fmt)    "ACPI: APMT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_apmt.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +
> +#define DEV_NAME "arm-cs-arch-pmu"
> +
> +/* There can be up to 3 resources: page 0 and 1 address, and interrupt. */
> +#define DEV_MAX_RESOURCE_COUNT 3
> +
> +/* Root pointer to the mapped APMT table */
> +static struct acpi_table_header *apmt_table;
> +
> +static int __init apmt_init_resources(struct resource *res,
> +                                             struct acpi_apmt_node *node)
> +{
> +       int irq, trigger;
> +       int num_res = 0;
> +
> +       res[num_res].start = node->base_address0;
> +       res[num_res].end = node->base_address0 + SZ_4K - 1;
> +       res[num_res].flags = IORESOURCE_MEM;
> +
> +       num_res++;
> +
> +       res[num_res].start = node->base_address1;
> +       res[num_res].end = node->base_address1 + SZ_4K - 1;
> +       res[num_res].flags = IORESOURCE_MEM;
> +
> +       num_res++;
> +
> +       if (node->ovflw_irq != 0) {
> +               trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
> +               trigger = (trigger == ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
> +                       ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +               irq = acpi_register_gsi(NULL, node->ovflw_irq, trigger,
> +                                               ACPI_ACTIVE_HIGH);
> +
> +               if (irq <= 0) {
> +                       pr_warn("APMT could not register gsi hwirq %d\n", irq);
> +                       return num_res;
> +               }
> +
> +               res[num_res].start = irq;
> +               res[num_res].end = irq;
> +               res[num_res].flags = IORESOURCE_IRQ;
> +
> +               num_res++;
> +       }
> +
> +       return num_res;
> +}
> +
> +/**
> + * apmt_add_platform_device() - Allocate a platform device for APMT node
> + * @node: Pointer to device ACPI APMT node
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
> +                                                       struct fwnode_handle *fwnode)
> +{
> +       struct platform_device *pdev;
> +       int ret, count;
> +       struct resource res[DEV_MAX_RESOURCE_COUNT];
> +
> +       pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
> +       if (!pdev)
> +               return -ENOMEM;
> +
> +       memset(res, 0, sizeof(res));
> +
> +       count = apmt_init_resources(res, node);
> +
> +       ret = platform_device_add_resources(pdev, res, count);
> +       if (ret)
> +               goto dev_put;
> +
> +       /*
> +        * Add a copy of APMT node pointer to platform_data to be used to
> +        * retrieve APMT data information.
> +        */
> +       ret = platform_device_add_data(pdev, &node, sizeof(node));
> +       if (ret)
> +               goto dev_put;
> +
> +       pdev->dev.fwnode = fwnode;
> +
> +       ret = platform_device_add(pdev);
> +
> +       if (ret)
> +               goto dev_put;
> +
> +       return 0;
> +
> +dev_put:
> +       platform_device_put(pdev);
> +
> +       return ret;
> +}
> +
> +static int __init apmt_init_platform_devices(void)
> +{
> +       struct acpi_apmt_node *apmt_node;
> +       struct acpi_table_apmt *apmt;
> +       struct fwnode_handle *fwnode;
> +       u64 offset, end;
> +       int ret;
> +
> +       /*
> +        * apmt_table and apmt both point to the start of APMT table, but
> +        * have different struct types
> +        */
> +       apmt = (struct acpi_table_apmt *)apmt_table;
> +       offset = sizeof(*apmt);
> +       end = apmt->header.length;
> +
> +       while (offset < end) {
> +               apmt_node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
> +                                offset);
> +
> +               fwnode = acpi_alloc_fwnode_static();
> +               if (!fwnode)
> +                       return -ENOMEM;
> +
> +               ret = apmt_add_platform_device(apmt_node, fwnode);
> +               if (ret) {
> +                       acpi_free_fwnode_static(fwnode);
> +                       return ret;
> +               }
> +
> +               offset += apmt_node->length;
> +       }
> +
> +       return 0;
> +}
> +
> +void __init acpi_apmt_init(void)
> +{
> +       acpi_status status;
> +       int ret;
> +
> +       /**
> +        * APMT table nodes will be used at runtime after the apmt init,
> +        * so we don't need to call acpi_put_table() to release
> +        * the APMT table mapping.
> +        */
> +       status = acpi_get_table(ACPI_SIG_APMT, 0, &apmt_table);
> +
> +       if (ACPI_FAILURE(status)) {
> +               if (status != AE_NOT_FOUND) {
> +                       const char *msg = acpi_format_exception(status);
> +
> +                       pr_err("Failed to get APMT table, %s\n", msg);
> +               }
> +
> +               return;
> +       }
> +
> +       ret = apmt_init_platform_devices();
> +       if (ret) {
> +               pr_err("Failed to initialize APMT platform devices, ret: %d\n", ret);
> +               acpi_put_table(apmt_table);
> +       }
> +}
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826..f9dc5b3d5c55 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -27,6 +27,7 @@
>  #include <linux/dmi.h>
>  #endif
>  #include <linux/acpi_agdi.h>
> +#include <linux/acpi_apmt.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
> @@ -1411,6 +1412,7 @@ static int __init acpi_init(void)
>         acpi_setup_sb_notify_handler();
>         acpi_viot_init();
>         acpi_agdi_init();
> +       acpi_apmt_init();
>         return 0;
>  }
>
> diff --git a/include/linux/acpi_apmt.h b/include/linux/acpi_apmt.h
> new file mode 100644
> index 000000000000..40bd634d082f
> --- /dev/null
> +++ b/include/linux/acpi_apmt.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ARM CoreSight PMU driver.
> + * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> + *
> + */
> +
> +#ifndef __ACPI_APMT_H__
> +#define __ACPI_APMT_H__
> +
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_ACPI_APMT
> +void acpi_apmt_init(void);
> +#else
> +static inline void acpi_apmt_init(void) { }
> +#endif /* CONFIG_ACPI_APMT */
> +
> +#endif /* __ACPI_APMT_H__ */
>
> base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
> --
> 2.17.1
>
