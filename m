Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A816EDA8E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjDYDQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjDYDQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:16:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C346A8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:16:35 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q56XZ1CYYzL0W4;
        Tue, 25 Apr 2023 11:13:50 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 11:16:33 +0800
Message-ID: <edef5e7f-2d5c-d79a-1ac6-286299fb0f8c@huawei.com>
Date:   Tue, 25 Apr 2023 11:16:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <faa32ce0-00cd-d24c-f505-beb637904af1@kernel.org>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <faa32ce0-00cd-d24c-f505-beb637904af1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
Thanks for your review. My reply is as follows.

在 2023/4/24 16:42, Krzysztof Kozlowski 写道:
> On 24/04/2023 09:30, Huisong Li wrote:
>> The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
>> for ensuring cache coherent on HiSilicon SoC. The performance of
>> the application may be affected if some hccs ports are in non-full
>> lane status, have a large number of CRC errors and so on.
>>
>> This driver provides the query interface of the health status and
>> port information of HCCS on Kunpeng SoC.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   MAINTAINERS                          |    6 +
>>   drivers/soc/Kconfig                  |    1 +
>>   drivers/soc/Makefile                 |    1 +
>>   drivers/soc/hisilicon/Kconfig        |   18 +
>>   drivers/soc/hisilicon/Makefile       |    2 +
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 1296 ++++++++++++++++++++++++++
>>   drivers/soc/hisilicon/kunpeng_hccs.h |  204 ++++
>>   7 files changed, 1528 insertions(+)
>>   create mode 100644 drivers/soc/hisilicon/Kconfig
>>   create mode 100644 drivers/soc/hisilicon/Makefile
>>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.c
>>   create mode 100644 drivers/soc/hisilicon/kunpeng_hccs.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index eddbc48c61e9..fe0e796e8445 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9399,6 +9399,12 @@ S:	Maintained
>>   W:	http://www.hisilicon.com
>>   F:	drivers/spi/spi-hisi-sfc-v3xx.c
>>   
>> +HISILICON KUNPENG SOC HCCS DRIVER
>> +M:	Huisong Li <lihuisong@huawei.com>
>> +S:	Maintained
>> +F:	drivers/soc/hisilicon/kunpeng_hccs.c
>> +F:	drivers/soc/hisilicon/kunpeng_hccs.h
>> +
>>   HMM - Heterogeneous Memory Management
>>   M:	Jérôme Glisse <jglisse@redhat.com>
>>   L:	linux-mm@kvack.org
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 4e176280113a..d21e75d69294 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
>>   source "drivers/soc/canaan/Kconfig"
>>   source "drivers/soc/fsl/Kconfig"
>>   source "drivers/soc/fujitsu/Kconfig"
>> +source "drivers/soc/hisilicon/Kconfig"
>>   source "drivers/soc/imx/Kconfig"
>>   source "drivers/soc/ixp4xx/Kconfig"
>>   source "drivers/soc/litex/Kconfig"
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 3b0f9fb3b5c8..531f46f3ad98 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
>>   obj-y				+= fsl/
>>   obj-y				+= fujitsu/
>>   obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>> +obj-y				+= hisilicon/
>>   obj-y				+= imx/
>>   obj-y				+= ixp4xx/
>>   obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>> diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
>> new file mode 100644
>> index 000000000000..81768d47f572
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Kconfig
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +menu "Hisilicon SoC drivers"
>> +	depends on ARCH_HISI
>> +
>> +config KUNPENG_HCCS
>> +	tristate "HCCS driver on Kunpeng SoC"
>> +	depends on ARM64 && ACPI
>> +	help
>> +	  The Huawei Cache-Coherent System (HCCS) is a bus protocol standard
>> +	  for ensuring cache coherent on HiSilicon SoC. The performance of
>> +	  the application may be affected if some hccs ports are in non-full
>> +	  lane status, have a large number of CRC errors and so on.
>> +
>> +	  Say M here if you want to include support for querying the health
>> +	  status and port information of HCCS on Kunpeng SoC.
>> +
>> +endmenu
>> diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
>> new file mode 100644
>> index 000000000000..226e747e70d6
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +obj-$(CONFIG_KUNPENG_HCCS)	+= kunpeng_hccs.o
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
>> new file mode 100644
>> index 000000000000..2b52f7dedc78
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -0,0 +1,1296 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * The Huawei Cache-Coherent System (HCCS) is a bus protocol standard for
>> + * ensuring cache coherent on HiSilicon SoC.
>> + *
>> + * Copyright (c) 2023 Hisilicon Limited.
>> + * Author: Huisong Li <lihuisong@huawei.com>
>> + *
>> + * HCCS driver for Kunpeng SoC provides the following features:
>> + * - Retrieve info as belows each port:
>> + *    - port type
>> + *    - lane mode
>> + *    - using status
>> + *    - current lane mode
>> + *    - link state machine
>> + *    - lane mask
>> + *    - CRC error count
>> + *
>> + * - Retrieve info as belows all ports on die or chip:
>> + *    - if all used ports are in linked
>> + *    - if all linked ports are in full lane
>> + *    - CRC error count sum
>> + */
>> +#include <linux/sysfs.h>
>> +#include <linux/acpi.h>
>> +#include <linux/io.h>
>> +#include <linux/kobject.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/platform_device.h>
>> +#include <acpi/pcc.h>
>> +
>> +#include "kunpeng_hccs.h"
>> +
>> +/* PCC defines */
>> +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
>> +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
>> +
>> +/*
>> + * Arbitrary retries in case the remote processor is slow to respond
>> + * to PCC commands
>> + */
>> +#define HCCS_PCC_CMD_WAIT_RETRIES_NUM		500ULL
>> +#define HCCS_POLL_STATUS_TIME_INTERVAL_US	3
>> +
>> +static struct hccs_port_info *kobj_to_port_info(struct kobject *k)
>> +{
>> +	return container_of(k, struct hccs_port_info, kobj);
>> +}
>> +
>> +static struct hccs_die_info *kobj_to_die_info(struct kobject *k)
>> +{
>> +	return container_of(k, struct hccs_die_info, kobj);
>> +}
>> +
>> +static struct hccs_chip_info *kobj_to_chip_info(struct kobject *k)
>> +{
>> +	return container_of(k, struct hccs_chip_info, kobj);
>> +}
>> +
>> +static bool hccs_dev_property_supported(struct hccs_dev *hdev)
>> +{
>> +	struct device *dev = hdev->dev;
>> +
>> +	if (hdev->intr_mode) {
>> +		dev_err(dev, "interrupt mode is unsupported.\n");
>> +		return false;
>> +	}
>> +
>> +	if (hdev->type >= ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE) {
>> +		dev_err(dev, "PCC type-%u is unsupported.\n", hdev->type);
>> +		return false;
>> +	}
>> +
>> +	return true;
>> +}
>> +
>> +static int hccs_get_device_property(struct hccs_dev *hdev)
>> +{
>> +	struct device *dev = hdev->dev;
>> +
>> +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
>> +		dev_err(hdev->dev, "no device-flags property.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
>> +		dev_err(hdev->dev, "no pcc-type property.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
>> +		dev_err(hdev->dev, "no pcc-channel property.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	hdev->intr_mode = hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_B);
>> +	if (!hccs_dev_property_supported(hdev))
> Maybe leave a comment that all these are ACPI-only and are not allowed
> in DT usage. Without bindings we are not going to review them. OTOH, I
> think we don't have a process for such cases in general.
Thanks for your suggestion. will add it.
>
>> +		return -EOPNOTSUPP;
>> +
>> +	return 0;
>> +}
>> +
> (...)
>
>> +static struct attribute *hccs_chip_default_attrs[] = {
>> +	&all_linked_on_chip_attr.attr,
>> +	&linked_full_lane_on_chip_attr.attr,
>> +	&crc_err_cnt_sum_on_chip_attr.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(hccs_chip_default);
>> +
>> +static const struct kobj_type hccs_chip_type = {
>> +	.sysfs_ops = &hccs_comm_ops,
>> +	.default_groups = hccs_chip_default_groups,
> Missing sysfs documentation.
I will add another patch to do this.
>
> This also looks like:
> 1. Duplicating parts of socinfo.
Where is the duplicating part. Sorry, I cannot get it.
> 2. Open-coding coding sysfs API.
I cannot understand it. Can you be more specific?
>
> Anyway, after describing this API it might turn out it is not valid for
> upstream usage...
>
>> +};
>> +
>> +static void hccs_remove_die_dir(struct hccs_die_info *die)
>> +{
>> +	struct hccs_port_info *port;
>> +	u8 i;
>> +
>> +	for (i = 0; i < die->port_num; i++) {
>> +		port = &die->ports[i];
>> +		if (port->dir_created)
>> +			kobject_put(&port->kobj);
>> +	}
>> +
>> +	kobject_put(&die->kobj);
>> +}
>> +
>> +static void hccs_remove_chip_dir(struct hccs_chip_info *chip)
>> +{
>> +	struct hccs_die_info *die;
>> +	u8 i;
>> +
>> +	for (i = 0; i < chip->die_num; i++) {
>> +		die = &chip->dies[i];
>> +		if (die->dir_created)
>> +			hccs_remove_die_dir(die);
>> +	}
>> +
>> +	kobject_put(&chip->kobj);
>> +}
>> +
>> +static void hccs_remove_topo_dirs(struct hccs_dev *hdev)
>> +{
>> +	u8 i;
>> +
>> +	for (i = 0; i < hdev->chip_num; i++)
>> +		hccs_remove_chip_dir(&hdev->chips[i]);
>> +}
>> +
>> +static int hccs_create_hccs_dir(struct hccs_dev *hdev,
>> +				struct hccs_die_info *die,
>> +				struct hccs_port_info *port)
>> +{
>> +	int ret;
>> +
>> +	ret = kobject_init_and_add(&port->kobj, &hccs_port_type,
>> +				   &die->kobj, "hccs%d", port->port_id);
>> +	if (ret) {
>> +		kobject_put(&port->kobj);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hccs_create_die_dir(struct hccs_dev *hdev,
>> +			       struct hccs_chip_info *chip,
>> +			       struct hccs_die_info *die)
>> +{
>> +	struct hccs_port_info *port;
>> +	int ret;
>> +	u16 i;
>> +
>> +	ret = kobject_init_and_add(&die->kobj, &hccs_die_type,
>> +				   &chip->kobj, "die%d", die->die_id);
>> +	if (ret) {
>> +		kobject_put(&die->kobj);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < die->port_num; i++) {
>> +		port = &die->ports[i];
>> +		ret = hccs_create_hccs_dir(hdev, die, port);
>> +		if (ret) {
>> +			dev_err(hdev->dev, "create hccs%d dir failed.\n",
>> +				port->port_id);
>> +			goto err;
>> +		}
>> +		port->dir_created = true;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	hccs_remove_die_dir(die);
>> +
>> +	return ret;
>> +}
>> +
>> +static int hccs_create_chip_dir(struct hccs_dev *hdev,
>> +				struct hccs_chip_info *chip)
>> +{
>> +	struct hccs_die_info *die;
>> +	int ret;
>> +	u16 id;
>> +
>> +	ret = kobject_init_and_add(&chip->kobj, &hccs_chip_type,
>> +				   &hdev->dev->kobj, "chip%d", chip->chip_id);
>> +	if (ret) {
>> +		kobject_put(&chip->kobj);
>> +		return ret;
>> +	}
>> +
>> +	for (id = 0; id < chip->die_num; id++) {
>> +		die = &chip->dies[id];
>> +		ret = hccs_create_die_dir(hdev, chip, die);
>> +		if (ret)
>> +			goto err;
>> +		die->dir_created = true;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	hccs_remove_chip_dir(chip);
>> +
>> +	return ret;
>> +}
>> +
>> +static int hccs_create_topo_dirs(struct hccs_dev *hdev)
>> +{
>> +	struct hccs_chip_info *chip;
>> +	u8 id, k;
>> +	int ret;
>> +
>> +	for (id = 0; id < hdev->chip_num; id++) {
>> +		chip = &hdev->chips[id];
>> +		ret = hccs_create_chip_dir(hdev, chip);
>> +		if (ret) {
>> +			dev_err(hdev->dev, "init chip%d dir failed!\n", id);
>> +			goto err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	for (k = 0; k < id; k++)
>> +		hccs_remove_chip_dir(&hdev->chips[k]);
>> +
>> +	return ret;
>> +}
>> +
>> +static int hccs_probe(struct platform_device *pdev)
>> +{
>> +	struct acpi_device *acpi_dev;
>> +	struct hccs_dev *hdev;
>> +	int rc;
>> +
>> +	pr_info("kunpeng_hccs is initializing.\n");
> Drop.
Ack.
>
>> +
>> +	if (acpi_disabled) {
>> +		dev_err(&pdev->dev, "acpi is disabled.\n");
> Is it possible for your ACPI-only driver?
Yes
>
>
>> +		return -ENODEV;
>> +	}
>> +	acpi_dev = ACPI_COMPANION(&pdev->dev);
>> +	if (!acpi_dev)
>> +		return -ENODEV;
>> +
>> +	hdev = devm_kzalloc(&pdev->dev, sizeof(*hdev), GFP_KERNEL);
>> +	if (!hdev)
>> +		return -ENOMEM;
>> +	hdev->acpi_dev = acpi_dev;
>> +	hdev->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, hdev);
>> +
>> +	rc = hccs_get_device_property(hdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	mutex_init(&hdev->lock);
>> +
>> +	rc = hccs_register_pcc_channel(hdev);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = hccs_get_dev_caps(hdev);
>> +	if (rc)
>> +		goto err_uninit_mbox_client;
>> +
>> +	rc = hccs_get_hw_info(hdev);
>> +	if (rc)
>> +		goto err_uninit_mbox_client;
>> +
>> +	rc = hccs_create_topo_dirs(hdev);
>> +	if (rc)
>> +		goto err_uninit_mbox_client;
>> +
>> +	dev_info(&pdev->dev, "HISI HCCS driver registered!\n");
> Drop simple probe success msgs. There's already kernel infrastructure
> giving you this information.
All right, drop it.
>
>> +
>> +	return 0;
>> +
>> +err_uninit_mbox_client:
>> +	hccs_unregister_pcc_channel(hdev);
>> +
>> +	return rc;
>> +}
>> +
>> +static int hccs_remove(struct platform_device *pdev)
>> +{
>> +	struct hccs_dev *hdev = platform_get_drvdata(pdev);
>> +
>> +	hccs_remove_topo_dirs(hdev);
>> +	hccs_unregister_pcc_channel(hdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id hccs_acpi_match[] = {
>> +	{ "HISI04B1", },
>> +};
>> +
>> +static struct platform_driver hccs_driver = {
>> +	.probe = hccs_probe,
>> +	.remove = hccs_remove,
>> +	.driver = {
>> +		.name = "kunpeng_hccs",
>> +		.acpi_match_table = ACPI_PTR(hccs_acpi_match),
> Drop ACPI_PTR as it is not balanced with __maybe_unused.
ok, will drop it in v2.
