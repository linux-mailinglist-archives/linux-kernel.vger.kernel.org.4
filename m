Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53406BE5BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjCQJgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQJgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:36:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BCF91A48A;
        Fri, 17 Mar 2023 02:36:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DCC1FB;
        Fri, 17 Mar 2023 02:37:22 -0700 (PDT)
Received: from [10.57.53.217] (unknown [10.57.53.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D68D3F64C;
        Fri, 17 Mar 2023 02:36:36 -0700 (PDT)
Message-ID: <9b6102e4-66ef-8d60-869b-da8bbd2dfc72@arm.com>
Date:   Fri, 17 Mar 2023 09:36:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 5/7] coresight: etm4x: Add ACPI support in platform driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <20230317030501.1811905-6-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230317030501.1811905-6-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 03:04, Anshuman Khandual wrote:
> From: Suzuki Poulose <suzuki.poulose@arm.com>
> 
> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just move it
> inside the new ACPI devices list detected and used via platform driver.

It may be a good idea to add a short summary of why we are doing this ?
Though it is part of the cover letter, it would benefit people looking
at the commit (e.g., maintainers or even in the future).

Suzuki


> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Suzuki Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   drivers/acpi/acpi_amba.c                           |  1 -
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
> index f5b443ab01c2..099966cbac5a 100644
> --- a/drivers/acpi/acpi_amba.c
> +++ b/drivers/acpi/acpi_amba.c
> @@ -22,7 +22,6 @@
>   static const struct acpi_device_id amba_id_list[] = {
>   	{"ARMH0061", 0}, /* PL061 GPIO Device */
>   	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
> -	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
>   	{"ARMHC501", 0}, /* ARM CoreSight ETR */
>   	{"ARMHC502", 0}, /* ARM CoreSight STM */
>   	{"ARMHC503", 0}, /* ARM CoreSight Debug */
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 60f027e33aa0..fe494c9c6bad 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -3,6 +3,7 @@
>    * Copyright (c) 2014, The Linux Foundation. All rights reserved.
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/bitops.h>
>   #include <linux/kernel.h>
>   #include <linux/moduleparam.h>
> @@ -2344,12 +2345,21 @@ static const struct of_device_id etm4_match[] = {
>   	{}
>   };
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id etm4x_acpi_ids[] = {
> +	{"ARMHC500", 0}, /* ARM CoreSight ETM4x */
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, etm4x_acpi_ids);
> +#endif
> +
>   static struct platform_driver etm4_platform_driver = {
>   	.probe		= etm4_probe_platform_dev,
>   	.remove		= etm4_remove_platform_dev,
>   	.driver			= {
>   		.name			= "coresight-etm4x",
>   		.of_match_table		= etm4_match,
> +		.acpi_match_table	= ACPI_PTR(etm4x_acpi_ids),
>   		.suppress_bind_attrs	= true,
>   	},
>   };

