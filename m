Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD95961FE4E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiKGTLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiKGTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:10:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF914D25;
        Mon,  7 Nov 2022 11:10:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F58DB81670;
        Mon,  7 Nov 2022 19:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CA7C433D7;
        Mon,  7 Nov 2022 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848241;
        bh=sx18lClMexihvXvYPtPJeHIqpLhp8A2J1jWg0z5jVbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOyZI/DzlYTrvJq8IyKW9aN21QPXmyCHVsV2ItjZ8Y5xhYoHVWt3TMlgK/vHAK37e
         jrd8qrAhs6/GrH8dw1DX7ur8DuM5BFmgUFeedrmtnZBG+5FPTWQ7kDWKgdsQ8RyRMy
         rA/T5EwTx+FdSQ0QGkfqKLEUKIza3WMWgtQpn9mlGgLRV2yuySROYr3ves3RGkxcDO
         b9cWfG4MakMGjLDqxE6fZpFWSe6uR/Aa/L5mT97Y5Pw40wxyI9rZQ/9cig+Cp/yDnk
         T9lBTESD+FDxVvTfvapnBLFQftoiMU88yaTAxATJVMQ0h6T+UEcbwfQ820V8+VWcKW
         t8G8hrz97jTfA==
Date:   Mon, 7 Nov 2022 19:10:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     rafael@kernel.org, lenb@kernel.org, catalin.marinas@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT)
 initial support
Message-ID: <20221107191034.GB21991@willie-the-truck>
References: <20220929002834.32664-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929002834.32664-1-bwicaksono@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 07:28:34PM -0500, Besar Wicaksono wrote:
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
> +#define pr_fmt(fmt)	"ACPI: APMT: " fmt
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
> +					      struct acpi_apmt_node *node)
> +{
> +	int irq, trigger;
> +	int num_res = 0;
> +
> +	res[num_res].start = node->base_address0;
> +	res[num_res].end = node->base_address0 + SZ_4K - 1;
> +	res[num_res].flags = IORESOURCE_MEM;
> +
> +	num_res++;
> +
> +	res[num_res].start = node->base_address1;
> +	res[num_res].end = node->base_address1 + SZ_4K - 1;
> +	res[num_res].flags = IORESOURCE_MEM;
> +
> +	num_res++;
> +
> +	if (node->ovflw_irq != 0) {
> +		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
> +		trigger = (trigger == ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
> +			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +		irq = acpi_register_gsi(NULL, node->ovflw_irq, trigger,
> +						ACPI_ACTIVE_HIGH);
> +
> +		if (irq <= 0) {
> +			pr_warn("APMT could not register gsi hwirq %d\n", irq);
> +			return num_res;
> +		}
> +
> +		res[num_res].start = irq;
> +		res[num_res].end = irq;
> +		res[num_res].flags = IORESOURCE_IRQ;
> +
> +		num_res++;
> +	}
> +
> +	return num_res;
> +}
> +
> +/**
> + * apmt_add_platform_device() - Allocate a platform device for APMT node
> + * @node: Pointer to device ACPI APMT node
> + *
> + * Returns: 0 on success, <0 failure
> + */
> +static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
> +							struct fwnode_handle *fwnode)

I queued this already, but my testing kicked up a nit that 'fwnode' is not
described in the kerneldoc. Please can you send a follow-up fix for that,
based on for-next/acpi? The indentation is also pretty weird with extra
parameter.

Will
