Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112C2644263
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLFLrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiLFLqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:46:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 912441A836;
        Tue,  6 Dec 2022 03:46:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF63A23A;
        Tue,  6 Dec 2022 03:46:54 -0800 (PST)
Received: from [10.57.38.80] (unknown [10.57.38.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F423F73D;
        Tue,  6 Dec 2022 03:46:46 -0800 (PST)
Message-ID: <47d600f0-e62e-e3b5-7fbe-68adce92af4f@arm.com>
Date:   Tue, 6 Dec 2022 11:46:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] hwtracing: hisi_ptt: Only add the supported devices
 to the filters list
To:     Yicong Yang <yangyicong@huawei.com>, mathieu.poirier@linaro.org
Cc:     yangyicong@hisilicon.com, alexander.shishkin@linux.intel.com,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221122120209.25682-1-yangyicong@huawei.com>
 <fb2441ce-fe4c-3733-5cd3-93a7d949d9f0@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <fb2441ce-fe4c-3733-5cd3-93a7d949d9f0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong Yang

On 06/12/2022 11:34, Yicong Yang wrote:
> Hi Mathieu,
> 
> Do we still have a chance to catch this cycle for these 2 patches?

Sorry, I have been handling the coresight tree this cycle (and will be
going forward). I have already sent the pull request to Greg. I am
afraid it is late for this cycle.

I can queue it for the next cycle.

Suzuki


> 
> Thanks!
> 
> On 2022/11/22 20:02, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The PTT device can only support the devices on the same PCIe core,
>> within BDF range [lower_bdf, upper_bdf]. It's not correct to assume
>> the devices on the root bus are from the same PCIe core, there are
>> cases that root ports from different PCIe core are sharing the same
>> bus. So add the checking when initialize the filters list.
>>
>> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/hwtracing/ptt/hisi_ptt.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 5d5526aa60c4..30f1525639b5 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -356,8 +356,18 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>>   
>>   static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
>>   {
>> +	struct pci_dev *root_port = pcie_find_root_port(pdev);
>>   	struct hisi_ptt_filter_desc *filter;
>>   	struct hisi_ptt *hisi_ptt = data;
>> +	u32 port_devid;
>> +
>> +	if (!root_port)
>> +		return 0;
>> +
>> +	port_devid = PCI_DEVID(root_port->bus->number, root_port->devfn);
>> +	if (port_devid < hisi_ptt->lower_bdf ||
>> +	    port_devid > hisi_ptt->upper_bdf)
>> +		return 0;
>>   
>>   	/*
>>   	 * We won't fail the probe if filter allocation failed here. The filters
>>

