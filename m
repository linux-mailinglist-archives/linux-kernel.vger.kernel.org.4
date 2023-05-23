Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8970DBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbjEWL6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjEWL55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:57:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185E8184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 04:57:46 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QQXpS2n9jzLmF4;
        Tue, 23 May 2023 19:56:16 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 19:57:43 +0800
Message-ID: <928a893b-6596-8d40-ce0e-80059a363d11@huawei.com>
Date:   Tue, 23 May 2023 19:57:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <andersson@kernel.org>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <krzk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <soc@kernel.org>, <wanghuiqiang@huawei.com>,
        <tanxiaofei@huawei.com>, <liuyonglong@huawei.com>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230523093922.f2y4wrz3vkzi7kmw@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/23 17:39, Sudeep Holla 写道:
> On Mon, May 22, 2023 at 03:22:10PM +0800, Huisong Li wrote:
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
>>   drivers/soc/hisilicon/Kconfig        |   19 +
>>   drivers/soc/hisilicon/Makefile       |    2 +
>>   drivers/soc/hisilicon/kunpeng_hccs.c | 1287 ++++++++++++++++++++++++++
>>   drivers/soc/hisilicon/kunpeng_hccs.h |  196 ++++
>>   7 files changed, 1512 insertions(+)
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
> s/HCCS/HCCS INFO or QUERY/ ?
 From the current features, what you suggest is suitable.
But this driver will support to the setting feature.
>
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
>> index 000000000000..87a1f15cbedb
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/Kconfig
>> @@ -0,0 +1,19 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +menu "Hisilicon SoC drivers"
>> +	depends on ARCH_HISI || COMPILE_TEST
>> +
>> +config KUNPENG_HCCS
> Ditto, add INFO or QUERY to the name as HCCS alone suggests it is some
> driver to manage the above bus protocol which is not correct.
Ditto, the setting feature will be added soon.
>
>> +	tristate "HCCS driver on Kunpeng SoC"
>> +	depends on ACPI
>> +	depends on ARM64 || COMPILE_TEST
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
>> index 000000000000..20a506a04bb7
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
>> @@ -0,0 +1,1287 @@
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
> Can we have something like:
> "Retrieve the following information about each port:"
Ok, it's better.
>
>> + *    - port type
>> + *    - lane mode
>> + *    - using status
> perhaps just status, "using status" doesn't sound correct to me.
Ack
>
>> + *    - current lane mode
>> + *    - link state machine
>> + *    - lane mask
>> + *    - CRC error count
>> + *
>> + * - Retrieve info as belows all ports on die or chip:
> Similarly:
> "Retrieve the following information about all the ports on the chip or the die:"
Ack
>
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
> I am not really sure if we keep duplicating this. I will try to cook up
> a patch consolidating these.
Yes, these info is better placed in a global header.
Do I need to do this in this series?
Or do not modify it, and then process all related code in your patch.
>
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
>> +struct hccs_register_ctx {
>> +	struct device *dev;
>> +	u8 chan_id;
>> +	int err;
>> +};
>> +
>> +static acpi_status hccs_get_register_cb(struct acpi_resource *ares,
>> +					void *context)
>> +{
>> +	struct acpi_resource_generic_register *reg;
>> +	struct hccs_register_ctx *ctx = context;
>> +
>> +	if (ares->type != ACPI_RESOURCE_TYPE_GENERIC_REGISTER)
>> +		return AE_OK;
>> +
>> +	reg = &ares->data.generic_reg;
>> +	if (reg->space_id != ACPI_ADR_SPACE_PLATFORM_COMM) {
>> +		dev_err(ctx->dev, "Bad register resource.\n");
>> +		ctx->err = -EINVAL;
>> +		return AE_ERROR;
>> +	}
>> +	ctx->chan_id = reg->access_size;
>> +
>> +	return AE_OK;
>> +}
>> +
>> +static int hccs_get_pcc_chan_id(struct hccs_dev *hdev)
>> +{
>> +	acpi_handle handle = ACPI_HANDLE(hdev->dev);
>> +	struct hccs_register_ctx ctx = {0};
>> +	acpi_status status;
>> +
>> +	if (!acpi_has_method(handle, METHOD_NAME__CRS))
>> +		return -ENODEV;
>> +
>> +	ctx.dev = hdev->dev;
>> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>> +				     hccs_get_register_cb, &ctx);
>> +	if (ACPI_FAILURE(status))
>> +		return ctx.err;
>> +	hdev->chan_id = ctx.chan_id;
>> +
>> +	return 0;
>> +}
>> +
>> +static void hccs_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
>> +{
>> +	if (ret < 0)
>> +		pr_debug("TX did not complete: CMD sent:0x%x, ret:%d\n",
>> +			 *(u8 *)msg, ret);
>> +	else
>> +		pr_debug("TX completed. CMD sent:0x%x, ret:%d\n",
>> +			 *(u8 *)msg, ret);
>> +}
>> +
>> +static void hccs_unregister_pcc_channel(struct hccs_dev *hdev)
>> +{
>> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> +
>> +	if (cl_info->pcc_comm_addr)
>> +		iounmap(cl_info->pcc_comm_addr);
>> +	pcc_mbox_free_channel(hdev->cl_info.pcc_chan);
>> +}
>> +
>> +static int hccs_register_pcc_channel(struct hccs_dev *hdev)
>> +{
>> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> +	struct mbox_client *cl = &cl_info->client;
>> +	struct pcc_mbox_chan *pcc_chan;
>> +	struct device *dev = hdev->dev;
>> +	int rc;
>> +
>> +	cl->dev = dev;
>> +	cl->tx_block = false;
>> +	cl->knows_txdone = true;
>> +	cl->tx_done = hccs_chan_tx_done;
>> +	pcc_chan = pcc_mbox_request_channel(cl, hdev->chan_id);
>> +	if (IS_ERR(pcc_chan)) {
>> +		dev_err(dev, "PPC channel request failed.\n");
>> +		rc = -ENODEV;
>> +		goto out;
>> +	}
>> +	cl_info->pcc_chan = pcc_chan;
>> +	cl_info->mbox_chan = pcc_chan->mchan;
>> +
>> +	/*
>> +	 * pcc_chan->latency is just a nominal value. In reality the remote
>> +	 * processor could be much slower to reply. So add an arbitrary amount
>> +	 * of wait on top of nominal.
>> +	 */
>> +	cl_info->deadline_us =
>> +			HCCS_PCC_CMD_WAIT_RETRIES_NUM * pcc_chan->latency;
>> +	if (cl_info->mbox_chan->mbox->txdone_irq) {
>> +		dev_err(dev, "PCC IRQ in PCCT is enabled.\n");
>> +		rc = -EINVAL;
>> +		goto err_mbx_channel_free;
>> +	}
>> +
>> +	if (pcc_chan->shmem_base_addr) {
>> +		cl_info->pcc_comm_addr = (void __force *)ioremap(
> I would prefer to use acpi_os_ioremap as it has addition checks to ensure
> it is not in any EFI mappings.
Agreed. will fix it.
>
>> +			pcc_chan->shmem_base_addr, pcc_chan->shmem_size);
>> +		if (!cl_info->pcc_comm_addr) {
>> +			dev_err(dev, "Failed to ioremap PCC communication region for channel-%d.\n",
>> +				hdev->chan_id);
>> +			rc = -ENOMEM;
>> +			goto err_mbx_channel_free;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_mbx_channel_free:
>> +	pcc_mbox_free_channel(cl_info->pcc_chan);
>> +out:
>> +	return rc;
>> +}
>> +
>> +static int hccs_check_chan_cmd_complete(struct hccs_dev *hdev)
>> +{
>> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> +	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
>> +	u16 status;
>> +	int ret;
>> +
>> +	/*
>> +	 * Poll PCC status register every 3us(delay_us) for maximum of
>> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond)
>> +	 */
>> +	ret = readw_poll_timeout(&comm_base->status, status,
>> +				 status & HCCS_PCC_STATUS_CMD_COMPLETE,
>> +				 HCCS_POLL_STATUS_TIME_INTERVAL_US,
>> +				 cl_info->deadline_us);
>> +	if (unlikely(ret))
>> +		dev_err(hdev->dev, "poll PCC status failed, ret = %d.\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int hccs_pcc_cmd_send(struct hccs_dev *hdev, u8 cmd,
>> +			     struct hccs_desc *desc)
>> +{
>> +	struct hccs_mbox_client_info *cl_info = &hdev->cl_info;
>> +	struct acpi_pcct_shared_memory *comm_base = cl_info->pcc_comm_addr;
>> +	void *comm_space = (void *)(comm_base + 1);
>> +	struct hccs_fw_inner_head *fw_inner_head;
>> +	struct acpi_pcct_shared_memory tmp = {0};
>> +	u16 comm_space_size;
>> +	int ret;
>> +
>> +	/* Write signature for this subspace */
>> +	tmp.signature = HCCS_PCC_SIGNATURE_MASK | hdev->chan_id;
> Why do we need to do this every single time ? This is never changed as
> it is fixed for a channel, so wondering if it can be done once in probe or
> so ?
 From the driver side, this will be ok.
But this initialization from driver will be cleared after firmware reseting.
And driver doesn't know about it.
IMO, there's no need to make driver and firmware complicated because of 
an assignment statement.
>
