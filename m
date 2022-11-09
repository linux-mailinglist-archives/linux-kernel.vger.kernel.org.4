Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73A6230DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiKIQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiKIQ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:59:41 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB72FC27
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:56:24 -0800 (PST)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N6rfG0Y3zz67ynR;
        Thu, 10 Nov 2022 00:54:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 17:56:18 +0100
Received: from localhost (10.45.145.27) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 16:56:16 +0000
Date:   Wed, 9 Nov 2022 16:56:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.garry@huawei.com>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH v12 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
Message-ID: <20221109165615.00006060@Huawei.com>
In-Reply-To: <20221109135008.9485-2-hejunhao3@huawei.com>
References: <20221109135008.9485-1-hejunhao3@huawei.com>
        <20221109135008.9485-2-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.145.27]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 21:50:07 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> From: Qi Liu <liuqi115@huawei.com>
> 
> This patch adds driver for UltraSoc SMB(System Memory Buffer)
> device. SMB provides a way to buffer messages from ETM, and
> store these "CPU instructions trace" in system memory.
> 
> SMB is developed by UltraSoc technology, which is acquired by
> Siemens, and we still use "UltraSoc" to name driver.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Tested-by: JunHao He <hejunhao3@huawei.com>
Hi JunHao,

One trivial side effect of dropping the ACPI dependency.

Also, I think (at the cost of a slightly lengthening of lines)
you can rename the register fields to avoid any potential
confusion between GLB and LB registers.

With those fixed feel free to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



...

> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> new file mode 100644
> index 000000000000..ea2552a98d28
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c

...

> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
> +	{"HISI03A1", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
> +
> +static struct platform_driver smb_driver = {
> +	.driver = {
> +		.name = "ultrasoc-smb",
> +		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
Now the driver build isn't dependent on CONFIG_ACPI
if !CONFIG_ACPI ACPI_PTR() doesn't reference the parameter.
As such you'll get unused warnings.

1 options to fix this
a) Drop ACPI_PTR() and just have .acpi_match_data = ultrasoc_smb_acpi_match
b) ifdef magic around the acpi_match table.

In theory the first option results in bloat, but in this case I doubt we care.

> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = smb_probe,
> +	.remove = smb_remove,
> +};
> +module_platform_driver(smb_driver);
> +
> +MODULE_DESCRIPTION("UltraSoc SMB CoreSight driver");
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
> new file mode 100644
> index 000000000000..2e2f9f8fe54b
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Siemens System Memory Buffer driver.
> + * Copyright(c) 2022, HiSilicon Limited.
> + */
> +
> +#ifndef _ULTRASOC_SMB_H
> +#define _ULTRASOC_SMB_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
> +
> +/* Offset of SMB global registers */
> +#define SMB_GLB_CFG_REG		0x00
> +#define SMB_GLB_EN_REG		0x04
> +#define SMB_GLB_INT_REG		0x08
> +
> +/* Offset of SMB logical buffer registers */
> +#define SMB_LB_CFG_LO_REG	0x40
> +#define SMB_LB_CFG_HI_REG	0x44
> +#define SMB_LB_INT_CTRL_REG	0x48
> +#define SMB_LB_INT_STS_REG	0x4c
> +#define SMB_LB_RD_ADDR_REG	0x5c
> +#define SMB_LB_WR_ADDR_REG	0x60
> +#define SMB_LB_PURGE_REG	0x64
> +
> +/* Set global config register */
> +#define SMB_CFG_BURST_LEN_MSK	GENMASK(11, 4)

Given there are several CFG registers, possibly worth
prefix of SMB_GLB_CFG_ ...

> +#define SMB_CFG_IDLE_PRD_MSK	GENMASK(15, 12)
> +#define SMB_CFG_MEM_WR_MSK	GENMASK(21, 16)
> +#define SMB_CFG_MEM_RD_MSK	GENMASK(27, 22)
> +#define SMB_GLB_CFG_DEFAULT	(FIELD_PREP(SMB_CFG_BURST_LEN_MSK, 0xf) | \
> +				 FIELD_PREP(SMB_CFG_IDLE_PRD_MSK, 0xf) | \
> +				 FIELD_PREP(SMB_CFG_MEM_WR_MSK, 0x3) | \
> +				 FIELD_PREP(SMB_CFG_MEM_RD_MSK, 0x1b))
> +
> +/* Set global interrupt control register */
> +#define SMB_INT_EN		BIT(0)

Again, multiple INT registers, so SMB_INT_GLB_* perhaps?

> +#define SMB_INT_PULSE		BIT(1) /* Interrupt type: 1 - Pulse */
> +#define SMB_INT_ACT_H		BIT(2) /* Interrupt polarity: 1 - Active high */
> +#define SMB_GLB_INT_CFG		(SMB_INT_EN | SMB_INT_PULSE | SMB_INT_ACT_H)
> +
> +/* Set logical buffer config register lower 32 bits */
> +#define SMB_CFG_LO_EN		BIT(0)

SMB_LB_CFG_...

etc for other cases.

> +#define SMB_CFG_LO_SINGLE_END	BIT(1)
> +#define SMB_CFG_LO_INIT		BIT(8)
> +#define SMB_CFG_LO_CONT		BIT(11)
> +#define SMB_CFG_LO_FLOW_MSK	GENMASK(19, 16)
> +#define SMB_LB_CFG_LO_DEFAULT	(SMB_CFG_LO_EN | SMB_CFG_LO_SINGLE_END | \
> +				 SMB_CFG_LO_INIT | SMB_CFG_LO_CONT | \
> +				 FIELD_PREP(SMB_CFG_LO_FLOW_MSK, 0xf))
> +
> +/* Set logical buffer config register upper 32 bits */
> +#define SMB_CFG_HI_RANGE_UP_MSK	GENMASK(15, 8)
> +#define SMB_LB_CFG_HI_DEFAULT	FIELD_PREP(SMB_CFG_HI_RANGE_UP_MSK, 0xff)
> +
> +/* Set logical buffer interrupt control register */
> +#define SMB_INT_CTRL_EN			BIT(0)
> +#define SMB_INT_CTRL_BUF_NOTE_MSK	GENMASK(11, 8)
> +#define SMB_LB_INT_CTRL_CFG	(SMB_INT_CTRL_EN | \
> +				 FIELD_PREP(SMB_INT_CTRL_BUF_NOTE_MSK, 0xf))
> +
> +#define SMB_LB_INT_STS_NOT_EMPTY_MSK	BIT(0)
> +#define SMB_LB_STS_RESET_MSK		GENMASK(3, 0)
> +#define SMB_LB_INT_BUF_STS_RESET	FIELD_PREP(SMB_LB_STS_RESET_MSK, 0xf)
> +#define SMB_LB_PURGE_PURGED	BIT(0)
> +#define SMB_GLB_EN_HW_ENABLE	BIT(0)
> +
> +#define SMB_REG_ADDR_RES	0
> +#define SMB_BUF_ADDR_RES	1
> +#define SMB_BUF_ADDR_LO_MSK	GENMASK(31, 0)

...

> +
> +/**
> + * struct smb_drv_data - specifics associated to an SMB component
> + * @base:	Memory mapped base address for SMB component.
> + * @csdev:	Component vitals needed by the framework.
> + * @sdb:	Data buffer for SMB.
> + * @miscdev:	Specifics to handle "/dev/xyz.smb" entry.
> + * @mutex:	Control data access to one at a time.
> + * @reading:	Synchronise user space access to SMB buffer.
> + * @pid:	Process ID of the process being monitored by the
> + *		session that is using this component.
> + * @mode:	how this SMB is being used, perf mode or sysfs mode.
Trivial, but for consistency should be: How this...

> + */
> +struct smb_drv_data {
> +	void __iomem *base;
> +	struct coresight_device	*csdev;
> +	struct smb_data_buffer sdb;
> +	struct miscdevice miscdev;
> +	struct mutex mutex;
> +	local_t reading;
> +	pid_t pid;
> +	u32 mode;
> +};
> +
> +#endif

