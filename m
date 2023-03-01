Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6412C6A6E90
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjCAOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAOiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E22242BD5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677681440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bXS+L4x/+aByNMGcZKYOJNfPEOpdzh59BNNtQCXHzj0=;
        b=RR9+s3IGVGZ0SF11DDPejX7gjV/FtDtMHHk+2VpAAPasU2SWd75OvTjkB3LbUyfHbahMeo
        CtWZJWEyoMz8OwDrkV1g1H3I8DmuD2b9EcXdMN3HJK7pXynKDstz2+hvTCrUsPC1hnEUh0
        28w/j4m77bsuUTcL3EIbanm+zZKJOIg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-HUEhJ9LgO9yZxpzpKlUXdQ-1; Wed, 01 Mar 2023 09:37:19 -0500
X-MC-Unique: HUEhJ9LgO9yZxpzpKlUXdQ-1
Received: by mail-ed1-f72.google.com with SMTP id fi8-20020a056402550800b004a26cc7f6cbso19434647edb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:37:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bXS+L4x/+aByNMGcZKYOJNfPEOpdzh59BNNtQCXHzj0=;
        b=7lu/fBNsc1BTxEeKYJmBmdm7ugwxX0X2pXMROPAzhGbRb8n17jT6P5V6ZVnz+zo8W5
         9zfmADOolpTDdj5SGv8qITtz6YFR4DHeJur/O9cAasQJS3K4HDCBgIBiYnGlN8+1ukU6
         0fappFpodx6H2LWmetJc/0t6JUNqJLI8EIa22xBW1FdrsiJSZk9SDnSU74Bn2BAyaer+
         LA/oZuTczUJVfKB2+PpR3VHvfEf3s1gL5t5IVzraiU6wo7ALjATr7q0UgCbWfAVPNAkC
         yoLNMRlGMNZbmCXtxYrRVc9RG0o7rI3sv7BiZEDC8HzdN5LHngjGXYF2D8SeCOv3Usv3
         hr3g==
X-Gm-Message-State: AO0yUKWyov4gUfsQGpvQk9rhqL0w8hgCTnsL2z+CtIL92NM3f9qKbt8w
        TeT9ybqq4sI7PXnUg4KNBFwCf363O89ifA1BLl7DjhE6YPu/akr+YcN9lbwrXJXE2x2IRb+8EgN
        HhKAYMlr21tGxMCt+lyd0AHKD
X-Received: by 2002:a17:906:dac3:b0:8dd:5710:a017 with SMTP id xi3-20020a170906dac300b008dd5710a017mr9282358ejb.4.1677681438057;
        Wed, 01 Mar 2023 06:37:18 -0800 (PST)
X-Google-Smtp-Source: AK7set/c/liv8yhlyXdOQO0w2d7yNB6swlhxziU9i8quvuYVlJE7edqulAmQ+8bkLUXaysy2ro2sXg==
X-Received: by 2002:a17:906:dac3:b0:8dd:5710:a017 with SMTP id xi3-20020a170906dac300b008dd5710a017mr9282339ejb.4.1677681437655;
        Wed, 01 Mar 2023 06:37:17 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090619ce00b008f14cc5f2e4sm5885887ejd.68.2023.03.01.06.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 06:37:17 -0800 (PST)
Message-ID: <22b443fd-b415-9550-76d3-a897dde9805e@redhat.com>
Date:   Wed, 1 Mar 2023 15:37:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 06/12] platform/x86: ISST: Enumerate TPMI SST and create
 framework
Content-Language: en-US, nl
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230211063257.311746-1-srinivas.pandruvada@linux.intel.com>
 <20230211063257.311746-7-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230211063257.311746-7-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/11/23 07:32, Srinivas Pandruvada wrote:
> Enumerate TPMI SST driver and create basic framework to add more
> features.
> 
> The basic user space interface is still same as the legacy using
> /dev/isst_interface. Users of "intel-speed-select" utility should
> be able to use same commands as prior gens without being aware
> of new underlying hardware interface.
> 
> TPMI SST driver enumerates on device "intel_vsec.tpmi-sst". Since there
> can be multiple instances and there is one common SST core, split
> implementation into two parts: A common core part and an enumeration
> part. The enumeration driver is loaded for each device instance and
> register with the TPMI SST core driver.
> 
> On very first enumeration the TPMI SST core driver register with SST
> core driver to get IOCTL callbacks. The api_version is incremented
> for IOCTL ISST_IF_GET_PLATFORM_INFO, so that user space can issue
> new IOCTLs.
> 
> Each TPMI package contains multiple power domains. Each power domain
> has its own set of SST controls. For each domain map the MMIO memory
> and update per domain struct tpmi_per_power_domain_info. This information
> will be used to implement other SST interfaces.
> 
> Implement first IOCTL commands to get number of TPMI SST instances
> and instance mask as some of the power domains may not have any
> SST controls.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

But this is a somewhat larger patch and IMHO it would be good
to get an extra pair of eyes on this, can you get someone else
from Intel to also review this patch ?

This (getting someone else to review the patches) especially
applies to patches 7-11, where I don't really feel myself
qualifeed to review them. I have given them a quick lookover
and nothing stood out, but they really need a Reviewed-by or
at minimum an Ack from someone else @Intel.

Regards,

Hans


> ---
>  .../x86/intel/speed_select_if/Kconfig         |   4 +
>  .../x86/intel/speed_select_if/Makefile        |   2 +
>  .../x86/intel/speed_select_if/isst_tpmi.c     |  53 ++++
>  .../intel/speed_select_if/isst_tpmi_core.c    | 274 ++++++++++++++++++
>  .../intel/speed_select_if/isst_tpmi_core.h    |  16 +
>  include/uapi/linux/isst_if.h                  |  18 ++
>  6 files changed, 367 insertions(+)
>  create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
>  create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
>  create mode 100644 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/Kconfig b/drivers/platform/x86/intel/speed_select_if/Kconfig
> index ce3e3dc076d2..4eb3ad299db0 100644
> --- a/drivers/platform/x86/intel/speed_select_if/Kconfig
> +++ b/drivers/platform/x86/intel/speed_select_if/Kconfig
> @@ -2,8 +2,12 @@ menu "Intel Speed Select Technology interface support"
>  	depends on PCI
>  	depends on X86_64 || COMPILE_TEST
>  
> +config INTEL_SPEED_SELECT_TPMI
> +	tristate
> +
>  config INTEL_SPEED_SELECT_INTERFACE
>  	tristate "Intel(R) Speed Select Technology interface drivers"
> +	select INTEL_SPEED_SELECT_TPMI if INTEL_TPMI
>  	help
>  	  This config enables the Intel(R) Speed Select Technology interface
>  	  drivers. The Intel(R) speed select technology features are non
> diff --git a/drivers/platform/x86/intel/speed_select_if/Makefile b/drivers/platform/x86/intel/speed_select_if/Makefile
> index 856076206f35..1d878a36d0ab 100644
> --- a/drivers/platform/x86/intel/speed_select_if/Makefile
> +++ b/drivers/platform/x86/intel/speed_select_if/Makefile
> @@ -8,3 +8,5 @@ obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_common.o
>  obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mmio.o
>  obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_pci.o
>  obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_msr.o
> +obj-$(CONFIG_INTEL_SPEED_SELECT_TPMI) += isst_tpmi_core.o
> +obj-$(CONFIG_INTEL_SPEED_SELECT_TPMI) += isst_tpmi.o
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> new file mode 100644
> index 000000000000..7b4bdeefb8bc
> --- /dev/null
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * isst_tpmi.c: SST TPMI interface
> + *
> + * Copyright (c) 2023, Intel Corporation.
> + * All Rights Reserved.
> + *
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/module.h>
> +#include <linux/intel_tpmi.h>
> +
> +#include "isst_tpmi_core.h"
> +
> +static int intel_sst_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
> +{
> +	int ret;
> +
> +	ret = tpmi_sst_init();
> +	if (ret)
> +		return ret;
> +
> +	ret = tpmi_sst_dev_add(auxdev);
> +	if (ret)
> +		tpmi_sst_exit();
> +
> +	return ret;
> +}
> +
> +static void intel_sst_remove(struct auxiliary_device *auxdev)
> +{
> +	tpmi_sst_dev_remove(auxdev);
> +	tpmi_sst_exit();
> +}
> +
> +static const struct auxiliary_device_id intel_sst_id_table[] = {
> +	{ .name = "intel_vsec.tpmi-sst" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, intel_sst_id_table);
> +
> +static struct auxiliary_driver intel_sst_aux_driver = {
> +	.id_table       = intel_sst_id_table,
> +	.remove         = intel_sst_remove,
> +	.probe          = intel_sst_probe,
> +};
> +
> +module_auxiliary_driver(intel_sst_aux_driver);
> +
> +MODULE_IMPORT_NS(INTEL_TPMI_SST);
> +MODULE_DESCRIPTION("Intel TPMI SST Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> new file mode 100644
> index 000000000000..6b37016c0417
> --- /dev/null
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * isst_tpmi.c: SST TPMI interface core
> + *
> + * Copyright (c) 2023, Intel Corporation.
> + * All Rights Reserved.
> + *
> + * This information will be useful to understand flows:
> + * In the current generation of platforms, TPMI is supported via OOB
> + * PCI device. This PCI device has one instance per CPU package.
> + * There is a unique TPMI ID for SST. Each TPMI ID also has multiple
> + * entries, representing per power domain information.
> + *
> + * There is one dev file for complete SST information and control same as the
> + * prior generation of hardware. User spaces don't need to know how the
> + * information is presented by the hardware. The TPMI core module implements
> + * the hardware mapping.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/intel_tpmi.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <uapi/linux/isst_if.h>
> +
> +#include "isst_tpmi_core.h"
> +#include "isst_if_common.h"
> +
> +/**
> + * struct tpmi_per_power_domain_info -	Store per power_domain SST info
> + * @package_id:		Package id for this power_domain
> + * @power_domain_id:	Power domain id, Each entry from the SST-TPMI instance is a power_domain.
> + * @sst_base:		Mapped SST base IO memory
> + * @auxdev:		Auxiliary device instance enumerated this instance
> + *
> + * This structure is used store complete SST information for a power_domain. This information
> + * is used to read/write request for any SST IOCTL. Each physical CPU package can have multiple
> + * power_domains. Each power domain describes its own SST information and has its own controls.
> + */
> +struct tpmi_per_power_domain_info {
> +	int package_id;
> +	int power_domain_id;
> +	void __iomem *sst_base;
> +	struct auxiliary_device *auxdev;
> +};
> +
> +/**
> + * struct tpmi_sst_struct -	Store sst info for a package
> + * @package_id:			Package id for this aux device instance
> + * @number_of_power_domains:	Number of power_domains pointed by power_domain_info pointer
> + * @power_domain_info:		Pointer to power domains information
> + *
> + * This structure is used store full SST information for a package.
> + * Each package has a unique OOB PCI device, which enumerates TPMI.
> + * Each Package will have multiple power_domains.
> + */
> +struct tpmi_sst_struct {
> +	int package_id;
> +	int number_of_power_domains;
> +	struct tpmi_per_power_domain_info *power_domain_info;
> +};
> +
> +/**
> + * struct tpmi_sst_common_struct -	Store all SST instances
> + * @max_index:		Maximum instances currently present
> + * @sst_inst:		Pointer to per package instance
> + *
> + * Stores every SST Package instance.
> + */
> +struct tpmi_sst_common_struct {
> +	int max_index;
> +	struct tpmi_sst_struct **sst_inst;
> +};
> +
> +/*
> + * Each IOCTL request is processed under this lock. Also used to protect
> + * registration functions and common data structures.
> + */
> +static DEFINE_MUTEX(isst_tpmi_dev_lock);
> +
> +/* Usage count to track, number of TPMI SST instances registered to this core. */
> +static int isst_core_usage_count;
> +
> +/* Stores complete SST information for every package and power_domain */
> +static struct tpmi_sst_common_struct isst_common;
> +
> +static int isst_if_get_tpmi_instance_count(void __user *argp)
> +{
> +	struct isst_tpmi_instance_count tpmi_inst;
> +	struct tpmi_sst_struct *sst_inst;
> +	int i;
> +
> +	if (copy_from_user(&tpmi_inst, argp, sizeof(tpmi_inst)))
> +		return -EFAULT;
> +
> +	if (tpmi_inst.socket_id >= topology_max_packages())
> +		return -EINVAL;
> +
> +	tpmi_inst.count = isst_common.sst_inst[tpmi_inst.socket_id]->number_of_power_domains;
> +
> +	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
> +	tpmi_inst.valid_mask = 0;
> +	for (i = 0; i < sst_inst->number_of_power_domains; ++i) {
> +		struct tpmi_per_power_domain_info *power_domain_info;
> +
> +		power_domain_info = &sst_inst->power_domain_info[i];
> +		if (power_domain_info->sst_base)
> +			tpmi_inst.valid_mask |= BIT(i);
> +	}
> +
> +	if (copy_to_user(argp, &tpmi_inst, sizeof(tpmi_inst)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
> +			      unsigned long arg)
> +{
> +	void __user *argp = (void __user *)arg;
> +	long ret = -ENOTTY;
> +
> +	mutex_lock(&isst_tpmi_dev_lock);
> +	switch (cmd) {
> +	case ISST_IF_COUNT_TPMI_INSTANCES:
> +		ret = isst_if_get_tpmi_instance_count(argp);
> +		break;
> +	default:
> +		break;
> +	}
> +	mutex_unlock(&isst_tpmi_dev_lock);
> +
> +	return ret;
> +}
> +
> +int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
> +{
> +	struct intel_tpmi_plat_info *plat_info;
> +	struct tpmi_sst_struct *tpmi_sst;
> +	int i, pkg = 0, inst = 0;
> +	int num_resources;
> +
> +	plat_info = tpmi_get_platform_data(auxdev);
> +	if (!plat_info) {
> +		dev_err(&auxdev->dev, "No platform info\n");
> +		return -EINVAL;
> +	}
> +
> +	pkg = plat_info->package_id;
> +	if (pkg >= topology_max_packages()) {
> +		dev_err(&auxdev->dev, "Invalid package id :%x\n", pkg);
> +		return -EINVAL;
> +	}
> +
> +	if (isst_common.sst_inst[pkg])
> +		return -EEXIST;
> +
> +	num_resources = tpmi_get_resource_count(auxdev);
> +
> +	if (!num_resources)
> +		return -EINVAL;
> +
> +	tpmi_sst = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_sst), GFP_KERNEL);
> +	if (!tpmi_sst)
> +		return -ENOMEM;
> +
> +	tpmi_sst->power_domain_info = devm_kcalloc(&auxdev->dev, num_resources,
> +						   sizeof(*tpmi_sst->power_domain_info),
> +						   GFP_KERNEL);
> +	if (!tpmi_sst->power_domain_info)
> +		return -ENOMEM;
> +
> +	tpmi_sst->number_of_power_domains = num_resources;
> +
> +	for (i = 0; i < num_resources; ++i) {
> +		struct resource *res;
> +
> +		res = tpmi_get_resource_at_index(auxdev, i);
> +		if (!res) {
> +			tpmi_sst->power_domain_info[i].sst_base = NULL;
> +			continue;
> +		}
> +
> +		tpmi_sst->power_domain_info[i].package_id = pkg;
> +		tpmi_sst->power_domain_info[i].power_domain_id = i;
> +		tpmi_sst->power_domain_info[i].auxdev = auxdev;
> +		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
> +		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
> +			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
> +
> +		++inst;
> +	}
> +
> +	if (!inst)
> +		return -ENODEV;
> +
> +	tpmi_sst->package_id = pkg;
> +	auxiliary_set_drvdata(auxdev, tpmi_sst);
> +
> +	mutex_lock(&isst_tpmi_dev_lock);
> +	if (isst_common.max_index < pkg)
> +		isst_common.max_index = pkg;
> +	isst_common.sst_inst[pkg] = tpmi_sst;
> +	mutex_unlock(&isst_tpmi_dev_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_add, INTEL_TPMI_SST);
> +
> +void tpmi_sst_dev_remove(struct auxiliary_device *auxdev)
> +{
> +	struct tpmi_sst_struct *tpmi_sst = auxiliary_get_drvdata(auxdev);
> +
> +	mutex_lock(&isst_tpmi_dev_lock);
> +	isst_common.sst_inst[tpmi_sst->package_id] = NULL;
> +	mutex_unlock(&isst_tpmi_dev_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove, INTEL_TPMI_SST);
> +
> +#define ISST_TPMI_API_VERSION	0x02
> +
> +int tpmi_sst_init(void)
> +{
> +	struct isst_if_cmd_cb cb;
> +	int ret = 0;
> +
> +	mutex_lock(&isst_tpmi_dev_lock);
> +
> +	if (isst_core_usage_count) {
> +		++isst_core_usage_count;
> +		goto init_done;
> +	}
> +
> +	isst_common.sst_inst = kcalloc(topology_max_packages(),
> +				       sizeof(*isst_common.sst_inst),
> +				       GFP_KERNEL);
> +	if (!isst_common.sst_inst)
> +		return -ENOMEM;
> +
> +	memset(&cb, 0, sizeof(cb));
> +	cb.cmd_size = sizeof(struct isst_if_io_reg);
> +	cb.offset = offsetof(struct isst_if_io_regs, io_reg);
> +	cb.cmd_callback = NULL;
> +	cb.api_version = ISST_TPMI_API_VERSION;
> +	cb.def_ioctl = isst_if_def_ioctl;
> +	cb.owner = THIS_MODULE;
> +	ret = isst_if_cdev_register(ISST_IF_DEV_TPMI, &cb);
> +	if (ret)
> +		kfree(isst_common.sst_inst);
> +init_done:
> +	mutex_unlock(&isst_tpmi_dev_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_init, INTEL_TPMI_SST);
> +
> +void tpmi_sst_exit(void)
> +{
> +	mutex_lock(&isst_tpmi_dev_lock);
> +	if (isst_core_usage_count)
> +		--isst_core_usage_count;
> +
> +	if (!isst_core_usage_count) {
> +		isst_if_cdev_unregister(ISST_IF_DEV_TPMI);
> +		kfree(isst_common.sst_inst);
> +	}
> +	mutex_unlock(&isst_tpmi_dev_lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(tpmi_sst_exit, INTEL_TPMI_SST);
> +
> +MODULE_IMPORT_NS(INTEL_TPMI);
> +MODULE_IMPORT_NS(INTEL_TPMI_POWER_DOMAIN);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> new file mode 100644
> index 000000000000..356cb02273b1
> --- /dev/null
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Intel Speed Select Interface: Drivers Internal defines
> + * Copyright (c) 2023, Intel Corporation.
> + * All rights reserved.
> + *
> + */
> +
> +#ifndef _ISST_TPMI_CORE_H
> +#define _ISST_TPMI_CORE_H
> +
> +int tpmi_sst_init(void);
> +void tpmi_sst_exit(void);
> +int tpmi_sst_dev_add(struct auxiliary_device *auxdev);
> +void tpmi_sst_dev_remove(struct auxiliary_device *auxdev);
> +#endif
> diff --git a/include/uapi/linux/isst_if.h b/include/uapi/linux/isst_if.h
> index ba078f8e9add..bf32d959f6e8 100644
> --- a/include/uapi/linux/isst_if.h
> +++ b/include/uapi/linux/isst_if.h
> @@ -163,10 +163,28 @@ struct isst_if_msr_cmds {
>  	struct isst_if_msr_cmd msr_cmd[1];
>  };
>  
> +/**
> + * struct isst_tpmi_instance_count - Get number of TPMI instances per socket
> + * @socket_id:	Socket/package id
> + * @count:	Number of instances
> + * @valid_mask: Mask of instances as there can be holes
> + *
> + * Structure used to get TPMI instances information using
> + * IOCTL ISST_IF_COUNT_TPMI_INSTANCES.
> + */
> +struct isst_tpmi_instance_count {
> +	__u8 socket_id;
> +	__u8 count;
> +	__u16 valid_mask;
> +};
> +
>  #define ISST_IF_MAGIC			0xFE
>  #define ISST_IF_GET_PLATFORM_INFO	_IOR(ISST_IF_MAGIC, 0, struct isst_if_platform_info *)
>  #define ISST_IF_GET_PHY_ID		_IOWR(ISST_IF_MAGIC, 1, struct isst_if_cpu_map *)
>  #define ISST_IF_IO_CMD		_IOW(ISST_IF_MAGIC, 2, struct isst_if_io_regs *)
>  #define ISST_IF_MBOX_COMMAND	_IOWR(ISST_IF_MAGIC, 3, struct isst_if_mbox_cmds *)
>  #define ISST_IF_MSR_COMMAND	_IOWR(ISST_IF_MAGIC, 4, struct isst_if_msr_cmds *)
> +
> +#define ISST_IF_COUNT_TPMI_INSTANCES	_IOR(ISST_IF_MAGIC, 5, struct isst_tpmi_instance_count *)
> +
>  #endif

