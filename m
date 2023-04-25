Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61A6EE258
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbjDYNBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjDYNBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:01:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C35D307;
        Tue, 25 Apr 2023 06:00:52 -0700 (PDT)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q5MSd1zVtzSv0l;
        Tue, 25 Apr 2023 20:56:17 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 21:00:32 +0800
Message-ID: <c7d9c3c5-e400-c60a-52e0-0f267ec8c517@huawei.com>
Date:   Tue, 25 Apr 2023 21:00:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
To:     Sudeep Holla <sudeep.holla@arm.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <wanghuiqiang@huawei.com>, <tanxiaofei@huawei.com>,
        <liuyonglong@huawei.com>, <huangdaode@huawei.com>,
        <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <e0c4f4b5-8b34-4542-b676-f98ddb8ef586@app.fastmail.com>
 <20230425103040.znv66k364ant6klq@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230425103040.znv66k364ant6klq@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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


在 2023/4/25 18:30, Sudeep Holla 写道:
> Thanks Arnd for cc-ing the ALKML.
>
> On Mon, Apr 24, 2023 at 10:09:47AM +0200, Arnd Bergmann wrote:
>> On Mon, Apr 24, 2023, at 09:30, Huisong Li wrote:
> [...]
>
>>> +
>>> +static int hccs_get_device_property(struct hccs_dev *hdev)
>>> +{
>>> +	struct device *dev = hdev->dev;
>>> +
>>> +	if (device_property_read_u32(dev, "device-flags", &hdev->flags)) {
>>> +		dev_err(hdev->dev, "no device-flags property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (device_property_read_u8(dev, "pcc-type", &hdev->type)) {
>>> +		dev_err(hdev->dev, "no pcc-type property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (device_property_read_u32(dev, "pcc-chan-id", &hdev->chan_id)) {
>>> +		dev_err(hdev->dev, "no pcc-channel property.\n");
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	hdev->intr_mode = hccs_get_bit(hdev->flags, HCCS_DEV_FLAGS_INTR_B);
>>> +	if (!hccs_dev_property_supported(hdev))
>>> +		return -EOPNOTSUPP;
>>> +
>> Where are the device properties documented? I'm never quite sure how
>> to handle these for ACPI-only drivers, since we don't normally have the
>> bindings in Documentation/devicetree/bindings/, but it feels like there
>> should be some properly reviewed document somewhere else.
>>
>> Adding ACPI and devicetree maintainers to Cc for clarification.
> Why are these DSD style properties added here ? Why can't we just make
> use of _CRS with Generic Address Structure(GAS) register entry for each
> of the PCC channel which eliminates the need of "pcc-chan-id". The type
> must be deduced from the order in the list of _CRS if needed. I don't
For firmware, DSD way is simpler and easier to manage these virtual 
platform devices,
and it's an usual way in kernel.
Driver only needs to get a fixed value, like pcc-id and type, here.

Any vantage if using _CRS with GAS compared with DSD?
> quite understand what magic the flags contain here to provide any info
> there.
This flag is used to report other properties, and every bit means a 
property.
For instance, driver doesn't need to request PCC channel during the 
probing phase if driver use PCC operation Region.
>
> .
