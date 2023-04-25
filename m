Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4036EDA72
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjDYDE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjDYDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:04:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68996BB9D;
        Mon, 24 Apr 2023 20:04:21 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q56Dg5P2gzSspV;
        Tue, 25 Apr 2023 11:00:03 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 11:04:18 +0800
Message-ID: <90d4aba4-d0a5-9868-583b-b3a4dd7ca6d6@huawei.com>
Date:   Tue, 25 Apr 2023 11:04:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>,
        <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thanks for your review. My reply is as follows.


在 2023/4/24 16:09, Arnd Bergmann 写道:
> On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:
>
>> diff --git a/drivers/soc/hisilicon/Kconfig
>> b/drivers/soc/hisilicon/Kconfig
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
> Is there a compile-time dependency on ARM64? If not, it would
Yes, no compile-time dependency on ARM64.
> be good to allow compile testing. At the same time, you
> can probably tighten this to ARCH_HISI instead of ARM64,
> since no other vendors are going to use it:
>
>         depends on ACPI
>         depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
What do you think of adjusting it as below?
menu "Hisilicon SoC drivers"
     depends on ARCH_HISI || COMPILE_TEST

config KUNPENG_HCCS
     depends on ACPI
     depends on ARM64 || COMPILE_TEST

>
>> +
>> +#include "kunpeng_hccs.h"
>> +
>> +/* PCC defines */
>> +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
>> +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
> Should these perhaps be in include/acpi/pcc.h? The 0x50434300
> number is just "PCC\0", so it appears to not be HCCS specific.
This is a PCC signature. As stated in the APCI,
"The signature of a subspace is computed by a bitwiseor of the value 
0x50434300
with the subspace ID. For example, subspace 3 has the signature 0x50434303."

I am not sure if all driver need to use this fixed signature mask.
As far as I know, cppc_acpi.c didn't use this signature and 
xgene-hwmon.c used another mask defined in its driver.
So I place it here.
>
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
>> +		return -EOPNOTSUPP;
>> +
> Where are the device properties documented? I'm never quite sure how
> to handle these for ACPI-only drivers, since we don't normally have the
> bindings in Documentation/devicetree/bindings/, but it feels like there
> should be some properly reviewed document somewhere else.
These are ACPI-only, instead of DT.
I will add a comment here as Krzysztof suggested.
>
> Adding ACPI and devicetree maintainers to Cc for clarification.
>
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
>> +	ret = readw_relaxed_poll_timeout(&comm_base->status, status,
>> +					 status & HCCS_PCC_STATUS_CMD_COMPLETE,
>> +					 HCCS_POLL_STATUS_TIME_INTERVAL_US,
>> +					 cl_info->deadline_us);
> Is it both safe and faster to use a relaxed readw here, compared
> to the normal one? If there is any access to shared memory
> involved, you need the implied barrier for serialization, and since this
> is already a sleeping operation, I would guess that you don't care
> about the last nanosecond of latency here.
Great comment. I will use the normal one.
>
>> +static ssize_t hccs_show(struct kobject *k, struct attribute *attr,
>> char *buf)
>> +{
>> +	struct kobj_attribute *kobj_attr;
>> +
>> +	kobj_attr = container_of(attr, struct kobj_attribute, attr);
>> +
>> +	return kobj_attr->show(k, kobj_attr, buf);
>> +}
>> +
>> +static const struct sysfs_ops hccs_comm_ops = {
>> +	.show = hccs_show,
>> +};
> Every sysfs interface needs to be documented in Documentation/ABI/
All right, I will add another patch to do this.
>
>> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.h
>> b/drivers/soc/hisilicon/kunpeng_hccs.h
>> new file mode 100644
>> index 000000000000..ca557ef115ea
>> --- /dev/null
>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.h
>> @@ -0,0 +1,204 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright (c) 2023 Hisilicon Limited. */
>> +
>> +#ifndef __KUNPENG_HCCS_H__
>> +#define __KUNPENG_HCCS_H__
> Are you planning to add more drivers that share this file? If not,
> just fold the contents into the driver itself.
Yes, we will add more drivers in this file.
