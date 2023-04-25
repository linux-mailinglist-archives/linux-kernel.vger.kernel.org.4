Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5366EDF78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjDYJmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjDYJms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:42:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920BC5BB2;
        Tue, 25 Apr 2023 02:42:46 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q5H4r126tzpTvm;
        Tue, 25 Apr 2023 17:38:52 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 17:42:43 +0800
Message-ID: <336cbe52-b449-7f7e-dae9-fbbc18f8d97b@huawei.com>
Date:   Tue, 25 Apr 2023 17:42:42 +0800
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
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <90d4aba4-d0a5-9868-583b-b3a4dd7ca6d6@huawei.com>
 <16ba11f1-5aa2-48c9-81cf-e3d98f547657@app.fastmail.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <16ba11f1-5aa2-48c9-81cf-e3d98f547657@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/25 14:08, Arnd Bergmann 写道:
> On Tue, Apr 25, 2023, at 05:04, lihuisong (C) wrote:
>> 在 2023/4/24 16:09, Arnd Bergmann 写道:
>>> On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:
>>>          depends on ACPI
>>>          depends on (ARM64 && ARCH_HISI) || COMPILE_TEST
>> What do you think of adjusting it as below?
>> menu "Hisilicon SoC drivers"
>>       depends on ARCH_HISI || COMPILE_TEST
>>
>> config KUNPENG_HCCS
>>       depends on ACPI
>>       depends on ARM64 || COMPILE_TEST
> Yes, that's perfect.
>
>>>> +
>>>> +#include "kunpeng_hccs.h"
>>>> +
>>>> +/* PCC defines */
>>>> +#define HCCS_PCC_SIGNATURE_MASK		0x50434300
>>>> +#define HCCS_PCC_STATUS_CMD_COMPLETE	BIT(0)
>>> Should these perhaps be in include/acpi/pcc.h? The 0x50434300
>>> number is just "PCC\0", so it appears to not be HCCS specific.
>> This is a PCC signature. As stated in the APCI,
>> "The signature of a subspace is computed by a bitwiseor of the value
>> 0x50434300
>> with the subspace ID. For example, subspace 3 has the signature 0x50434303."
>>
>> I am not sure if all driver need to use this fixed signature mask.
>> As far as I know, cppc_acpi.c didn't use this signature and
>> xgene-hwmon.c used another mask defined in its driver.
>> So I place it here.
> I would still put it into the generic header, but it doesn't
> really matter much, so do it whichever way you prefer. No need
> for a separate patch if you decide to use the global header,
> it can just be part of your normal patch.
ok, keep it the way it is now.
>
>>>> +
>>>> +static int hccs_get_device_property(struct hccs_dev *hdev)
>>>> +{
>>>> +	struct device *dev = hdev->dev;
>>>> +
>>>> +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
>>>> +		dev_err(hdev->dev, "no device-flags property.\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
>>>> +		dev_err(hdev->dev, "no pcc-type property.\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
>>>> +		dev_err(hdev->dev, "no pcc-channel property.\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	hdev->intr_mode = hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_B);
>>>> +	if (!hccs_dev_property_supported(hdev))
>>>> +		return -EOPNOTSUPP;
>>>> +
>>> Where are the device properties documented? I'm never quite sure how
>>> to handle these for ACPI-only drivers, since we don't normally have the
>>> bindings in Documentation/devicetree/bindings/, but it feels like there
>>> should be some properly reviewed document somewhere else.
>> These are ACPI-only, instead of DT.
>> I will add a comment here as Krzysztof suggested.
> I understand that they are ACPI-only, what I'm more interested here is
> the general question of how we should document them, to ensure these
> are handled consistently across drivers.
These device properties are reported by ACPI table in firmware.
They are fixed in platform firmware. The user cannot modify them.
Do we need to document them?
>
>>>> --- /dev/null
>>>> +++ b/drivers/soc/hisilicon/kunpeng_hccs.h
>>>> @@ -0,0 +1,204 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>>> +/* Copyright (c) 2023 Hisilicon Limited. */
>>>> +
>>>> +#ifndef __KUNPENG_HCCS_H__
>>>> +#define __KUNPENG_HCCS_H__
>>> Are you planning to add more drivers that share this file? If not,
>>> just fold the contents into the driver itself.
>> Yes, we will add more drivers in this file.
> Ok.
>
>
>         Arnd
> .
