Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A7762F543
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbiKRMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiKRMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:46:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBABF5B8;
        Fri, 18 Nov 2022 04:46:01 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDGjD2TKgzRpNh;
        Fri, 18 Nov 2022 20:45:36 +0800 (CST)
Received: from dggpeml500002.china.huawei.com (7.185.36.158) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 20:45:59 +0800
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 18 Nov
 2022 20:45:58 +0800
Subject: Re: [PATCH v13 1/2] drivers/coresight: Add UltraSoc System Memory
 Buffer driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-2-hejunhao3@huawei.com>
 <92291cb2-859c-a994-b05d-806def431376@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <lpieralisi@kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <liuqi115@huawei.com>, <f.fangjian@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <c07e6417-7a37-3cf5-d3dd-b3ce7b3c20b1@huawei.com>
Date:   Fri, 18 Nov 2022 20:45:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <92291cb2-859c-a994-b05d-806def431376@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Hi Suzuki ,


On 2022/11/15 19:06, Suzuki K Poulose wrote:
> On 14/11/2022 09:03, Junhao He wrote:
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
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/hwtracing/coresight/Kconfig        |  11 +
>>   drivers/hwtracing/coresight/Makefile       |   1 +
>>   drivers/hwtracing/coresight/ultrasoc-smb.c | 656 +++++++++++++++++++++
>>   drivers/hwtracing/coresight/ultrasoc-smb.h | 120 ++++
>>   4 files changed, 788 insertions(+)
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.c
>>   create mode 100644 drivers/hwtracing/coresight/ultrasoc-smb.h
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig 
>> b/drivers/hwtracing/coresight/Kconfig
>> index 45c1eb5dfcb7..cb17c207a728 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -201,4 +201,15 @@ config CORESIGHT_TRBE
>>           To compile this driver as a module, choose M here: the 
>> module will be
>>         called coresight-trbe.
>> +
>> +config ULTRASOC_SMB
>> +    tristate "Ultrasoc system memory buffer drivers"
>> +    depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
>
> I still think it is not a good idea to leave the ACPI dependency out
> of this. THe driver is unusable on a system without ACPI and the only
> other reason to build this would when using COMPILE_TEST.
> So, we could add something like :
>
>     depends on ACPI || COMPILE_TEST
>     depends on ARM64 && CORESIGHT_LINKS_AND_SINKS
>
OK, I will do that.
Thanks.
>
>> +    help
>> +      This driver provides support for the Ultrasoc system memory 
>> buffer (SMB).
>> +      SMB is responsible for receiving the trace data from Coresight 
>> ETM devices
>> +      and storing them to a system buffer.
>> +
>> +      To compile this driver as a module, choose M here: the module 
>> will be
>> +      called ultrasoc-smb.
>>   endif
>> diff --git a/drivers/hwtracing/coresight/Makefile 
>> b/drivers/hwtracing/coresight/Makefile
>> index b6c4a48140ec..344dba8d6ff8 100644
>> --- a/drivers/hwtracing/coresight/Makefile
>> +++ b/drivers/hwtracing/coresight/Makefile
>> @@ -27,3 +27,4 @@ obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>>   coresight-cti-y := coresight-cti-core.o coresight-cti-platform.o \
>>              coresight-cti-sysfs.o
>> +obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
>> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c 
>> b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> new file mode 100644
>> index 000000000000..1957796cbab2
>> --- /dev/null
>> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
>> @@ -0,0 +1,656 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Siemens System Memory Buffer driver.
>> + * Copyright(c) 2022, HiSilicon Limited.
>> + */
>> +
>> +#include <linux/atomic.h>
>> +#include <linux/acpi.h>
>> +#include <linux/circ_buf.h>
>> +#include <linux/err.h>
>> +#include <linux/fs.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "coresight-etm-perf.h"
>> +#include "coresight-priv.h"
>> +#include "ultrasoc-smb.h"
>> +
>> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "ultra_smb");
>> +
>> +#define ULTRASOC_SMB_DSM_UUID "82ae1283-7f6a-4cbe-aa06-53e8fb24db18"
>> +
>> +static bool smb_buffer_is_empty(struct smb_drv_data *drvdata)
>> +{
>> +    u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS_REG);
>> +
>> +    return !FIELD_GET(SMB_LB_INT_STS_NOT_EMPTY_MSK, buf_status);
>> +}
>> +
>> +static void smb_buffer_sync_status(struct smb_drv_data *drvdata)
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +
>> +    sdb->wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR_REG) -
>> +             sdb->start_addr;
>> +    sdb->rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR_REG) -
>> +             sdb->start_addr;
>> +    sdb->full = sdb->wr_offset == sdb->rd_offset &&
>> +            !smb_buffer_is_empty(drvdata);
>> +}
>> +
>> +static void smb_reset_buffer_status(struct smb_drv_data *drvdata)
>> +{
>> +    /* All other bits are reserved and shall be 0 */
>> +    writel(SMB_LB_INT_STS_RESET, drvdata->base + SMB_LB_INT_STS_REG);
>> +}
>> +
>> +/* Purge data remaining in hardware path in case them influence next 
>> trace */
>
> minor nit:
>
>    /*
>     * Purge data remaining in hardware path to avoid corrupting the next
>     * session.
>     */
>
Ok, will fix it.
Thanks.

>> +static void smb_purge_data(struct smb_drv_data *drvdata)
>> +{
>> +    /* All other bits are reserved and shall be 0 */
>> +    writel(SMB_LB_PURGE_PURGED, drvdata->base + SMB_LB_PURGE_REG);
>> +}
>> +
>> +static void smb_update_data_size(struct smb_drv_data *drvdata)
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +
>> +    smb_purge_data(drvdata);
>> +    smb_buffer_sync_status(drvdata);
>> +    if (sdb->full) {
>> +        sdb->data_size = sdb->buf_size;
>> +        return;
>> +    }
>> +
>> +    sdb->data_size = CIRC_CNT(sdb->wr_offset, sdb->rd_offset,
>> +                  sdb->buf_size);
>> +}
>> +
>> +static int smb_open(struct inode *inode, struct file *file)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
>> +    int ret = 0;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    if (drvdata->reading) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    if (atomic_read(drvdata->csdev->refcnt)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    drvdata->reading = true;
>> +out:
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t smb_read(struct file *file, char __user *data, size_t 
>> len,
>> +            loff_t *ppos)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    struct device *dev = &drvdata->csdev->dev;
>> +    ssize_t to_copy = 0;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    if (!len)
>> +        goto out;
>> +
>> +    /*
>> +     * In sysfs mode, size need to be update in the following two 
>> cases:
>> +     * 1) Start dumping data.
>> +     * 2) End dump data, make sure there is no remaining data in
>> +     *    the hardware path. Because the remaining data cannot be 
>> purged
>> +     *    when the buffer is full.
>> +     */
>> +    if (!sdb->data_size) {
>> +        smb_update_data_size(drvdata);
>> +        if (!sdb->data_size)
>> +            goto out;
>> +    }
>> +
>> +    to_copy = min(sdb->data_size, len);
>> +
>> +    /* Copy parts of trace data when read pointer wrap around SMB 
>> buffer */
>> +    if (sdb->rd_offset + to_copy > sdb->buf_size)
>> +        to_copy = sdb->buf_size - sdb->rd_offset;
>> +
>> +    if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset,
>> +             to_copy)) {
>> +        dev_dbg(dev, "Failed to copy data to user\n");
>> +        to_copy = -EFAULT;
>> +        goto out;
>> +    }
>> +
>> +    *ppos += to_copy;
>> +    sdb->data_size -= to_copy;
>> +    sdb->rd_offset += to_copy;
>> +    sdb->rd_offset %= sdb->buf_size;
>> +    writel(sdb->start_addr + sdb->rd_offset,
>> +           drvdata->base + SMB_LB_RD_ADDR_REG);
>> +    dev_dbg(dev, "%zu bytes copied\n", to_copy);
>> +out:
>> +    if (!sdb->data_size)
>> +        smb_reset_buffer_status(drvdata);
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return to_copy;
>> +}
>> +
>> +static int smb_release(struct inode *inode, struct file *file)
>> +{
>> +    struct smb_drv_data *drvdata = container_of(file->private_data,
>> +                    struct smb_drv_data, miscdev);
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +    drvdata->reading = false;
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct file_operations smb_fops = {
>> +    .owner        = THIS_MODULE,
>> +    .open        = smb_open,
>> +    .read        = smb_read,
>> +    .release    = smb_release,
>> +    .llseek        = no_llseek,
>> +};
>> +
>> +static ssize_t buf_size_show(struct device *dev, struct 
>> device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "0x%lx\n", drvdata->sdb.buf_size);
>> +}
>> +static DEVICE_ATTR_RO(buf_size);
>> +
>> +static struct attribute *smb_sink_attrs[] = {
>> +    coresight_simple_reg32(read_pos, SMB_LB_RD_ADDR_REG),
>> +    coresight_simple_reg32(write_pos, SMB_LB_WR_ADDR_REG),
>> +    coresight_simple_reg32(buf_status, SMB_LB_INT_STS_REG),
>> +    &dev_attr_buf_size.attr,
>> +    NULL
>> +};
>> +
>> +static const struct attribute_group smb_sink_group = {
>> +    .attrs = smb_sink_attrs,
>> +    .name = "mgmt",
>> +};
>> +
>> +static const struct attribute_group *smb_sink_groups[] = {
>> +    &smb_sink_group,
>> +    NULL
>> +};
>> +
>> +static void smb_enable_hw(struct smb_drv_data *drvdata)
>> +{
>> +    writel(SMB_GLB_EN_HW_ENABLE, drvdata->base + SMB_GLB_EN_REG);
>
> What happens to the RD_ADDR_REG and WR_ADDR_REG at enable ? Do they
> reset to the base of the buf or do we need to program at enable ?
> Are there any other modes of operation ? Or is it always in circular
> buffer mode ?
The RD_ADDR_REG and WR_ADDR_REG register is filled in BIOS, and
WR_ADDR_REG is RO mode.
When the SMB is enabled, the values of RD_ADDR_REG and WR_ADDR_REG
remain unchanged.
UltraSoc SMB is always in circular buffer mode.
Thanks.

>> +}
>> +
>> +static void smb_disable_hw(struct smb_drv_data *drvdata)
>> +{
>> +    writel(0x0, drvdata->base + SMB_GLB_EN_REG);
>> +}
>> +
>> +static void smb_enable_sysfs(struct coresight_device *csdev)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    if (drvdata->mode != CS_MODE_DISABLED)
>> +        return;
>> +
>> +    smb_enable_hw(drvdata);
>> +    drvdata->mode = CS_MODE_SYSFS;
>> +}
>> +
>> +static int smb_enable_perf(struct coresight_device *csdev, void *data)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct perf_output_handle *handle = data;
>> +    struct cs_buffers *buf = etm_perf_sink_config(handle);
>> +    pid_t pid;
>> +
>> +    if (!buf)
>> +        return -EINVAL;
>> +
>> +    /* Get a handle on the pid of the target process */
>> +    pid = buf->pid;
>> +
>> +    /* Device is already in used by other session */
>> +    if (drvdata->pid != -1 && drvdata->pid != pid)
>> +        return -EBUSY;
>> +
>> +    if (drvdata->pid == -1) {
>> +        smb_enable_hw(drvdata);
>> +        drvdata->pid = pid;
>> +        drvdata->mode = CS_MODE_PERF;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int smb_enable(struct coresight_device *csdev, u32 mode, void 
>> *data)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret = 0;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    /* Do nothing, the trace data is reading by other interface now */
>> +    if (drvdata->reading) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    /* Do nothing, the SMB is already enabled as other mode */
>> +    if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    switch (mode) {
>> +    case CS_MODE_SYSFS:
>> +        smb_enable_sysfs(csdev);
>> +        break;
>> +    case CS_MODE_PERF:
>> +        ret = smb_enable_perf(csdev, data);
>> +        break;
>> +    default:
>> +        ret = -EINVAL;
>> +    }
>> +
>> +    if (ret)
>> +        goto out;
>> +
>> +    atomic_inc(csdev->refcnt);
>> +
>> +    dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
>> +out:
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return ret;
>> +}
>> +
>> +static int smb_disable(struct coresight_device *csdev)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret = 0;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    if (drvdata->reading) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    if (atomic_dec_return(csdev->refcnt)) {
>> +        ret = -EBUSY;
>> +        goto out;
>> +    }
>> +
>> +    /* Complain if we (somehow) got out of sync */
>> +    WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
>> +
>> +    smb_disable_hw(drvdata);
>> +    smb_purge_data(drvdata);
>> +
>> +    /* Dissociate from the target process. */
>> +    drvdata->pid = -1;
>> +    drvdata->mode = CS_MODE_DISABLED;
>> +
>> +    dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
>> +out:
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return ret;
>> +}
>> +
>> +static void *smb_alloc_buffer(struct coresight_device *csdev,
>> +                  struct perf_event *event, void **pages,
>> +                  int nr_pages, bool overwrite)
>> +{
>> +    struct cs_buffers *buf;
>> +    int node;
>> +
>> +    node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
>> +    buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
>> +    if (!buf)
>> +        return NULL;
>> +
>> +    buf->snapshot = overwrite;
>> +    buf->nr_pages = nr_pages;
>> +    buf->data_pages = pages;
>> +    buf->pid = task_pid_nr(event->owner);
>> +
>> +    return buf;
>> +}
>> +
>> +static void smb_free_buffer(void *config)
>> +{
>> +    struct cs_buffers *buf = config;
>> +
>> +    kfree(buf);
>> +}
>> +
>> +static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
>> +                 struct cs_buffers *buf,
>> +                 unsigned long head,
>> +                 unsigned long data_size)
>> +{
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    char **dst_pages = (char **)buf->data_pages;
>> +    unsigned long to_copy;
>> +    long pg_idx, pg_offset;
>> +
>> +    pg_idx = head >> PAGE_SHIFT;
>> +    pg_offset = head & (PAGE_SIZE - 1);
>> +
>> +    while (data_size) {
>> +        unsigned long pg_space = PAGE_SIZE - pg_offset;
>> +
>> +        /* Copy parts of trace data when read pointer wrap around */
>> +        if (sdb->rd_offset + pg_space > sdb->buf_size)
>> +            to_copy = sdb->buf_size - sdb->rd_offset;
>> +        else
>> +            to_copy = min(data_size, pg_space);
>> +
>> +        memcpy(dst_pages[pg_idx] + pg_offset,
>> +                  sdb->buf_base + sdb->rd_offset, to_copy);
>> +
>> +        pg_offset += to_copy;
>> +        if (pg_offset >= PAGE_SIZE) {
>> +            pg_offset = 0;
>> +            pg_idx++;
>> +            pg_idx %= buf->nr_pages;
>> +        }
>> +        data_size -= to_copy;
>> +        sdb->rd_offset += to_copy;
>> +        sdb->rd_offset %= sdb->buf_size;
>> +    }
>> +
>> +    sdb->data_size = 0;
>
>> +    writel(sdb->start_addr + sdb->rd_offset,
>> +        drvdata->base + SMB_LB_RD_ADDR_REG);
>
> Is this safe ? When the buffer was not full and the buffer
> was not copied in full (i.e., perf_buffer < buffer_size),
> the RD_ADDR_REG won't reach the WR_ADDR_REG. So can that affect
> the next session ? See more below :
>
Yes, In this case. "sdb->rd_offset" will add the offset of discarded data
(buffer_size - perf_buffer) in the smb_update_buffer() function. If the 
buffer
was not full, the values of RD_ADDR_REG and WR_ADDR_REG ​​will always
be the same.
When SMB is full, the data remained in link only can be written into buffer
after updated RD_ADDR_REG, and the value of WR_ADDR_REG will be advanced.
So in this case we need synchronize the WR_ADDR_REG to RD_ADDR_REG again.
Thanks.

>> +
>> +    /*
>> +     * Data remained in link cannot be purged when SMB is full, so
>> +     * synchronize the read pointer to write pointer, to make sure
>> +     * these remained data won't influence next trace.
>> +     */
>> +    if (sdb->full) {
>> +        smb_purge_data(drvdata);
>> +        writel(readl(drvdata->base + SMB_LB_WR_ADDR_REG),
>> +               drvdata->base + SMB_LB_RD_ADDR_REG);
>
> Or, in other words, shouldn't we do this irrespective of whether the
> buffer->full or not ? We set the TRUNCATED flag appropriately when
> there was data lost and thus we must not leave any trace from a previous
> "schedule" in for the "next" collection. So, we must reset the RD/WR
> registers to the base.
>
Yes,  You are right, but the WR_ADDR_REG register is RO mode.
Thanks.

>> +    }
>
>
>> +    smb_reset_buffer_status(drvdata);
>> +}
>> +
>> +static unsigned long smb_update_buffer(struct coresight_device *csdev,
>> +                       struct perf_output_handle *handle,
>> +                       void *sink_config)
>> +{
>> +    struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    struct smb_data_buffer *sdb = &drvdata->sdb;
>> +    struct cs_buffers *buf = sink_config;
>> +    unsigned long data_size = 0;
>> +    bool lost = false;
>> +
>> +    if (!buf)
>> +        return 0;
>> +
>> +    mutex_lock(&drvdata->mutex);
>> +
>> +    /* Don't do anything if another tracer is using this sink. */
>> +    if (atomic_read(csdev->refcnt) != 1)
>> +        goto out;
>> +
>> +    smb_disable_hw(drvdata);
>> +    smb_update_data_size(drvdata);
>> +    data_size = sdb->data_size;
>> +
>> +    /*
>> +     * The SMB buffer may be bigger than the space available in the
>> +     * perf ring buffer (handle->size). If so advance the offset so
>> +     * that we get the latest trace data.
>> +     */
>> +    if (data_size > handle->size) {
>> +        sdb->rd_offset += data_size - handle->size;
>> +        sdb->rd_offset %= sdb->buf_size;
>> +        data_size = handle->size;
>> +        lost = true;
>> +    } > +
>> +    smb_sync_perf_buffer(drvdata, buf, handle->head, data_size);
>> +    if (!buf->snapshot && lost)
>> +        perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
>> +
>
>> +    smb_enable_hw(drvdata);
>
> We do not need this and could leave this disabled at this stage. The
> perf session has stopped the "source" anyway.
>
Yes, I will do that.
Thanks.
>> +out:
>> +    mutex_unlock(&drvdata->mutex);
>> +
>> +    return data_size;
>> +}
>> +
>> +static const struct coresight_ops_sink smb_cs_ops = {
>> +    .enable        = smb_enable,
>> +    .disable    = smb_disable,
>> +    .alloc_buffer    = smb_alloc_buffer,
>> +    .free_buffer    = smb_free_buffer,
>> +    .update_buffer    = smb_update_buffer,
>> +};
>> +
>> +static const struct coresight_ops cs_ops = {
>> +    .sink_ops    = &smb_cs_ops,
>> +};
>> +
>> +static int smb_init_data_buffer(struct platform_device *pdev,
>> +                struct smb_data_buffer *sdb)
>> +{
>> +    struct resource *res;
>> +    void *base;
>> +
>> +    res = platform_get_resource(pdev, IORESOURCE_MEM, 
>> SMB_BUF_ADDR_RES);
>> +    if (IS_ERR(res)) {
>> +        dev_err(&pdev->dev, "SMB device failed to get resource\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    sdb->start_addr = FIELD_GET(SMB_BUF_ADDR_LO_MSK, res->start);
>> +    sdb->buf_size = resource_size(res);
>> +    if (sdb->buf_size == 0)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * This is a chunk of memory, use classic mapping with better
>> +     * performance.
>> +     */
>> +    base = devm_memremap(&pdev->dev, sdb->start_addr, sdb->buf_size,
>> +                MEMREMAP_WB);
>> +    if (IS_ERR(base))
>> +        return PTR_ERR(base);
>> +
>> +    sdb->buf_base = base;
>> +
>> +    return 0;
>> +}
>> +
>> +static void smb_init_hw(struct smb_drv_data *drvdata)
>> +{
>> +    /* First disable SMB and clear the status of SMB buffer */
>> +    smb_reset_buffer_status(drvdata);
>> +    smb_disable_hw(drvdata);
>> +    smb_purge_data(drvdata);
>> +
>> +    writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
>> +    writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
>> +    writel(SMB_GLB_CFG_DEFAULT, drvdata->base + SMB_GLB_CFG_REG);
>> +    writel(SMB_GLB_INT_CFG, drvdata->base + SMB_GLB_INT_REG);
>> +    writel(SMB_LB_INT_CTRL_CFG, drvdata->base + SMB_LB_INT_CTRL_REG);
>
> Does this come with interrupt on overflow ? Do we not use this ?
>
When the buffer overflow, no interrupt will come.
Interrupt will upgrade SMB_LB_INT_STS_REG register status if start trace.
Thanks.
> Rest looks fine to me.
>
>
> Suzuki
Best regards,
HeJunhao.
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
>
> .
>

