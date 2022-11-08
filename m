Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD63620C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiKHJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiKHJop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:44:45 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2A11000
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:44:43 -0800 (PST)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N634t4pRCzpWG9;
        Tue,  8 Nov 2022 17:41:02 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:44:42 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 17:44:41 +0800
Subject: Re: [PATCH v11 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20221107130624.59886-1-hejunhao3@huawei.com>
 <20221107130624.59886-2-hejunhao3@huawei.com>
 <20221107143048.00004da2@Huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.garry@huawei.com>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <rdunlap@infradead.org>, <liuqi115@huawei.com>,
        <f.fangjian@huawei.com>, <prime.zeng@hisilicon.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <1082ca68-a778-44b3-2082-3f712b689412@huawei.com>
Date:   Tue, 8 Nov 2022 17:44:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20221107143048.00004da2@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thanks for your comments.

On 2022/11/7 22:30, Jonathan Cameron wrote:
> On Mon, 7 Nov 2022 21:06:23 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
>> From: Qi Liu <liuqi115@huawei.com>
>>
>> This patch adds driver for UltraSoc SMB(System Memory Buffer)
>> device. SMB provides a way to buffer messages from ETM, and
>> store these "CPU instructions trace" in system memory.
>>
>> SMB is developed by UltraSoc technology, which is acquired by
>> Siemens, and we still use "UltraSoc" to name driver.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Tested-by: JunHao He <hejunhao3@huawei.com>
> Hi JunHao,
>
> It's been a while since I last looked at this driver, so I may have
> forgotten or missed previous discussions.
>
> All the comments inline are fairly superficial and mostly concerned
> with making the code easy to review / maintain rather than correctness.
>
> Jonathan
Yes, I will do that.
Junhao.
>> ---
>>   drivers/hwtracing/coresight/Kconfig        |  11 +
>>   drivers/hwtracing/coresight/Makefile       |   1 +
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 631 +++++++++++++++++++++
>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 113 ++++
>>   4 files changed, 756 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index 45c1eb5dfcb7..05d791cb05e3 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,15 @@ config CORESIGHT_TRBE
>>   
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called coresight-trbe.
>> +
>> +config ULTRASOC_SMB
>> +	tristate "Ultrasoc system memory buffer drivers"
>> +	depends on ACPI && ARM64 && CORESIGHT_LINKS_AND_SINKS
> Can you relax this at all in the interests of getting better CI build coverage
> from random configs etc.
>
> >From a quick look, I think you can safely drop the ACPI dependency on basis
> relevant functions are stubbed out in acpi.h
>
> However, it looks like coresight more generally uses such depends, so perhaps
> better to just leave them here for consistency.
Ok, Will check it.
Thanks.
>> +	help
>> +	  This driver provides support for the Ultrasoc system memory buffer (SMB).
>> +	  SMB is responsible for receiving the trace data from Coresight ETM devices
>> +	  and storing them to a system buffer.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called ultrasoc-smb.
>>   endif
>
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> new file mode 100644
>> index 000000000000..7fe8bf9623e8
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -0,0 +1,631 @@
> ...
>
>
>> +
>> +static void smb_buffer_sync_status(struct smb_drv_data *drvdata)
>> +{
>> +	struct smb_data_buffer *sdb = &drvdata->sdb;
>> +
>> +	sdb->wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - sdb->start_addr;
>> +	sdb->rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR) - sdb->start_addr;
>> +	if (sdb->wr_offset == sdb->rd_offset && !smb_buffer_is_empty(drvdata))
>> +		sdb->full = true;
>> +	else
>> +		sdb->full = false;
> Could do as
> 	sdb->full = sdb->wr_offset == sdb->rd_offset && !smb_buffer_is_empty(drvdata);
> up to you on which you think is more readable.
Ok, I will drop this "if else" block.
Thanks.
>
>> +}
>> +
>
>
>> +static struct attribute *smb_sink_attrs[] = {
>> +	coresight_simple_reg32(read_pos, SMB_LB_RD_ADDR),
>> +	coresight_simple_reg32(write_pos, SMB_LB_WR_ADDR),
>> +	coresight_simple_reg32(buf_status, SMB_LB_INT_STS),
>> +	&dev_attr_buf_size.attr,
>> +	NULL,
> As below.
Sure, Will fix in next version.
Thanks.
>
>> +};
>> +
>> +static const struct attribute_group smb_sink_group = {
>> +	.attrs = smb_sink_attrs,
>> +	.name = "mgmt",
>> +};
>> +
>> +static const struct attribute_group *smb_sink_groups[] = {
>> +	&smb_sink_group,
>> +	NULL,
> Generally no comma after a NULL terminator.  Having a comma
> implies it may make sense to put something after it, which is never
> the case for these.
Sure, Will fix in next version.
Thanks.
>> +};
>> +
>
> ...
>
>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>> +				 struct cs_buffers *buf,
>> +				 unsigned long head,
>> +				 unsigned long data_size)
>> +{
>> +	struct smb_data_buffer *sdb = &drvdata->sdb;
>> +	char **dst_pages = (char **)buf->data_pages;
> Do you need the cast?  It's void ** so implicit cast should work I think.
> 	char **dst_pages = buf->data_pages;
Ok, Will fix in next version.
Thanks.
>> +	unsigned long to_copy;
>> +	long pg_idx, pg_offset;
>> +
>> +	pg_idx = head >> PAGE_SHIFT;
>> +	pg_offset = head & (PAGE_SIZE - 1);
>> +
>> +	while (data_size) {
>> +		unsigned long pg_space = PAGE_SIZE - pg_offset;
>> +
>> +		/* Copy parts of trace data when read pointer wrap around */
>> +		if (sdb->rd_offset + pg_space > sdb->buf_size)
>> +			to_copy = sdb->buf_size - sdb->rd_offset;
>> +		else
>> +			to_copy = min(data_size, pg_space);
>> +
>> +		memcpy(dst_pages[pg_idx] + pg_offset,
>> +			      sdb->buf_base + sdb->rd_offset, to_copy);
>> +
>> +		pg_offset += to_copy;
>> +		if (pg_offset >= PAGE_SIZE) {
>> +			pg_offset = 0;
>> +			pg_idx++;
>> +			pg_idx %= buf->nr_pages;
>> +		}
>> +		data_size -= to_copy;
>> +		sdb->rd_offset += to_copy;
>> +		sdb->rd_offset %= sdb->buf_size;
>> +	}
>> +
>> +	sdb->data_size = 0;
>> +	writel(sdb->start_addr + sdb->rd_offset, drvdata->base + SMB_LB_RD_ADDR);
>> +
>> +	/*
>> +	 * Data remained in link cannot be purged when SMB is full, so
>> +	 * synchronize the read pointer to write pointer, to make sure
>> +	 * these remained data won't influence next trace.
>> +	 */
>> +	if (sdb->full) {
>> +		smb_purge_data(drvdata);
>> +		writel(readl(drvdata->base + SMB_LB_WR_ADDR),
>> +		       drvdata->base + SMB_LB_RD_ADDR);
>> +	}
>> +	smb_reset_buffer_status(drvdata);
>> +}
>
> ...
>
>> +
>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>> +{
>> +	/* First disable smb and clear the status of SMB buffer */
> Check for consistency in capitalization of SMB in all comments.
Sure, Will fix in next version.
Thanks.
>
>> +	smb_reset_buffer_status(drvdata);
>> +	smb_disable_hw(drvdata);
>> +	smb_purge_data(drvdata);
>> +
>> +	writel(SMB_BUF_CFG_STREAMING, drvdata->base + SMB_LB_CFG_LO);
>> +	writel(SMB_MSG_FILTER, drvdata->base + SMB_LB_CFG_HI);
>> +	writel(SMB_GLOBAL_CFG, drvdata->base + SMB_CFG_REG);
>> +	writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
>> +	writel(SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
>> +}
>> +
>
> ...
>
>> +static int smb_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct smb_drv_data *drvdata;
>> +	int ret;
>> +
>> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>> +	if (!drvdata)
>> +		return -ENOMEM;
>> +
>> +	drvdata->base = devm_platform_ioremap_resource(pdev, SMB_BASE_ADDR_RES);
>> +	if (IS_ERR(drvdata->base)) {
>> +		dev_err(dev, "Failed to ioremap resource\n");
>> +		return PTR_ERR(drvdata->base);
>> +	}
>> +
>> +	ret = smb_init_data_buffer(pdev, &drvdata->sdb);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to init buffer, ret = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	smb_init_hw(drvdata);
>> +	mutex_init(&drvdata->mutex);
>> +	drvdata->pid = -1;
>> +
>> +	ret = smb_register_sink(pdev, drvdata);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to register smb sink\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = smb_config_inport(dev, true);
>> +	if (ret) {
>> +		smb_unregister_sink(drvdata);
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, drvdata);
>> +	return 0;
>> +}
>> +
>> +static int smb_remove(struct platform_device *pdev)
>> +{
>> +	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
>> +	int ret;
>> +
>> +	ret = smb_config_inport(&pdev->dev, false);
>> +	if (ret)
>> +		return ret;
>> +
>> +	smb_unregister_sink(drvdata);
> Trivial: I find a blank line before plane returns like this helps
> a little with readability.  Up to you though!
Ok, Will fix it.
Thanks.
>
>> +	return 0;
>> +}
>> +
>> +static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
>> +	{"HISI03A1", 0},
>> +	{},
> Trivial, but little point in a trailing comma on a NULL terminator.
Sure, Will fix in next version.
Thanks.
>
> 	{}
> };
>
> is normally fine - note this is a bit subsystem specific so maintainer
> may say otherwise.
Ok, Thanks.
>
>> +};
>> +MODULE_DEVICE_TABLE(acpi, ultrasoc_smb_acpi_match);
>> +
>> +static struct platform_driver smb_driver = {
>> +	.driver = {
>> +		.name = "ultrasoc-smb",
>> +		.acpi_match_table = ACPI_PTR(ultrasoc_smb_acpi_match),
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = smb_probe,
>> +	.remove = smb_remove,
>> +};
>> +module_platform_driver(smb_driver);
>> +
>> +MODULE_DESCRIPTION("UltraSoc SMB CoreSight driver");
>> +MODULE_LICENSE("Dual MIT/GPL");
>> +MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
>> +MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> new file mode 100644
>> index 000000000000..56170e1a883d
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
>> @@ -0,0 +1,113 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2022, HiSilicon Limited.
>> + */
>> +
>> +#ifndef _ULTRASOC_SMB_H
>> +#define _ULTRASOC_SMB_H
>> +
>> +#include <linux/coresight.h>
> I think you could move this down into the c files and provide
> a forwards definition of struct coresight device
>
> Always good to keep scope of includes to minimum necessary.
Sure, Will fix in next version.
Thanks.
>
>> +#include <linux/miscdevice.h>
>> +#include <linux/mutex.h>
>> +
>> +/* Offset of SMB logical buffer registers */
>> +#define SMB_CFG_REG		0x00
> To avoid any naming confusion I would postfix all the register
> addresses with _REG
> Then rethink the naming so the field names make it clear which
> register they are in.
OK, I'll check all REG names.
Thanks.
>
>> +#define SMB_GLOBAL_EN		0x04
>> +#define SMB_GLOBAL_INT		0x08
>> +#define SMB_LB_CFG_LO		0x40
>> +#define SMB_LB_CFG_HI		0x44
>> +#define SMB_LB_INT_CTRL		0x48
>> +#define SMB_LB_INT_STS		0x4c
>> +#define SMB_LB_LIMIT		0x58
>> +#define SMB_LB_RD_ADDR		0x5c
>> +#define SMB_LB_WR_ADDR		0x60
>> +#define SMB_LB_PURGE		0x64
>> +
>> +/* Set SMB_CFG_REG register */
>> +#define SMB_BURST_LEN		GENMASK(7, 4)
>> +#define SMB_IDLE_PRD		GENMASK(15, 12)
>> +#define SMB_MEM_WR		GENMASK(17, 16)
>> +#define SMB_MEM_RD		(GENMASK(26, 25) | GENMASK(23, 22))
> Are these masks, or default values? Ideally express them as
> a field mask then the value via FIELD_PREP
>
> e.g.
> #define SMB_CFG_BURST_LEN_MSK GENMASK(7, 4)
> #define SMB_GLOBAL_CFG_DEFAULT    ... | FIELD_PREP(SMB_CFG_BURST_LEN_MSK, 0xf) | etc
Sure, I will do that.
Thanks.
>
>   
>> +#define SMB_GLOBAL_CFG		(SMB_IDLE_PRD |	SMB_MEM_WR | SMB_MEM_RD | \
>> +				 SMB_BURST_LEN)
>> +
>> +/* Set SMB_GLOBAL_INT register */
>> +#define SMB_INT_EN		BIT(0)
>> +#define SMB_INT_TYPE_PULSE	BIT(1)
>> +#define SMB_INT_POLARITY_HIGH	BIT(2)
>> +#define SMB_GLB_INT_CFG		(SMB_INT_EN | SMB_INT_TYPE_PULSE |	\
>> +				 SMB_INT_POLARITY_HIGH)
>> +
>> +/* Set SMB_LB_CFG_LO register */
>> +#define SMB_BUF_EN		BIT(0)
>> +#define SMB_BUF_SINGLE_END	BIT(1)
>> +#define SMB_BUF_INIT		BIT(8)
>> +#define SMB_BUF_CONTINUOUS	BIT(11)
>> +#define SMB_FILTER_FLOW		GENMASK(19, 16)
>> +#define SMB_BUF_CFG_STREAMING	(SMB_BUF_INIT | SMB_BUF_CONTINUOUS |	\
>> +				 SMB_FILTER_FLOW | SMB_BUF_SINGLE_END |	\
>> +				 SMB_BUF_EN)
>> +
>> +#define SMB_BASE_LOW_MASK	GENMASK(31, 0)
>> +
>> +/* Set SMB_LB_CFG_HI register */
>> +#define SMB_MSG_FILTER		GENMASK(15, 8)
>> +
>> +/* Set SMB_LB_INT_CTRL */
>> +#define SMB_BUF_INT_EN		BIT(0)
>> +#define SMB_BUF_NOTE_MASK	GENMASK(11, 8)
>> +#define SMB_BUF_INT_CFG		(SMB_BUF_INT_EN | SMB_BUF_NOTE_MASK)
>> +
>> +#define SMB_BUF_NOT_EMPTY       BIT(0)
>> +#define SMB_RESET_BUF_STS       GENMASK(3, 0)
>> +#define SMB_PURGED              BIT(0)
>> +#define SMB_HW_ENABLE           BIT(0)
> It is useful to give fields names that reflect which register they are in.
> Perhaps
> SMB_GLOBAL_EN_HW_ENABLE for this one.
Sure, I will do that.
Thanks.
>
>> +
>> +#define SMB_BASE_ADDR_RES       0
>> +#define SMB_BUF_INFO_RES        1
>> +
>> +/**
>> + * struct smb_data_buffer - Details of the buffer used by SMB
>> + * @buf_base:	Memory mapped base address of SMB.
>> + * @start_addr:	SMB buffer start Physical address.
>> + * @buf_size:	Size of the buffer.
>> + * @data_size:	Size of Trace data copy to userspace.
>> + * @rd_offset:	Offset of the read pointer in the buffer.
>> + * @wr_offset:	Offset of the write pointer in the buffer.
>> + * @status:	Status of SMB buffer.
> Naming wrong.
Sure, Will fix in next version.
Thanks.
>
>> + */
>> +struct smb_data_buffer {
>> +	void __iomem *buf_base;
>> +	u32 start_addr;
>> +	unsigned long buf_size;
>> +	unsigned long data_size;
>> +	unsigned long rd_offset;
>> +	unsigned long wr_offset;
>> +	bool full;
>> +};
>> +
>> +/**
>> + * struct smb_drv_data - specifics associated to an SMB component
>> + * @base:	Memory mapped base address for SMB component.
>> + * @csdev:	Component vitals needed by the framework.
>> + * @sdb:	Data buffer for SMB.
>> + * @miscdev:	Specifics to handle "/dev/xyz.smb" entry.
>> + * @mutex:	Control data access to one at a time.
>> + * @reading:	Synchronise user space access to SMB buffer.
>> + * @pid:	Process ID of the process being monitored by the
>> + * 		session that is using this component.
>> + * @mode:	how this SMB is being used, perf mode or sysfs mode.
>> + */
>> +struct smb_drv_data {
>> +	void __iomem *base;
>> +	struct coresight_device	*csdev;
>> +	struct smb_data_buffer sdb;
>> +	struct miscdevice miscdev;
>> +	struct mutex mutex;
>> +	local_t reading;
>> +	pid_t pid;
>> +	u32 mode;
>> +};
>> +
>> +#endif
> .
>
Best regards,
Junhao.
