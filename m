Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07ED6241F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiKJMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKJMIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:08:34 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A83A0;
        Thu, 10 Nov 2022 04:08:29 -0800 (PST)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7LFn4rY2z15MVx;
        Thu, 10 Nov 2022 20:08:13 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:08:27 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:08:26 +0800
Message-ID: <ff852f4a-7d37-c947-139d-8882a3ebb9a3@huawei.com>
Date:   Thu, 10 Nov 2022 20:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] ACPI: PCC: add check for platform interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-3-lihuisong@huawei.com>
 <20221110103618.3vuyfdhcebf7ewmo@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221110103618.3vuyfdhcebf7ewmo@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/10 18:36, Sudeep Holla 写道:
> On Thu, Nov 10, 2022 at 09:50:33AM +0800, Huisong Li wrote:
>> PCC Operation Region driver senses the completion of command by interrupt
>> way. If platform can not generate an interrupt when a command complete,
>> the caller never gets the desired result. So let's reject the setup of the
>> PCC address space on platform that do not support interrupt mode.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
>>   1 file changed, 29 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
>> index 3e252be047b8..8efd08e469aa 100644
>> --- a/drivers/acpi/acpi_pcc.c
>> +++ b/drivers/acpi/acpi_pcc.c
>> @@ -53,6 +53,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>>   	struct pcc_data *data;
>>   	struct acpi_pcc_info *ctx = handler_context;
>>   	struct pcc_mbox_chan *pcc_chan;
>> +	static acpi_status ret;
>>   
>>   	data = kzalloc(sizeof(*data), GFP_KERNEL);
>>   	if (!data)
>> @@ -69,23 +70,35 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>>   	if (IS_ERR(data->pcc_chan)) {
>>   		pr_err("Failed to find PCC channel for subspace %d\n",
>>   		       ctx->subspace_id);
>> -		kfree(data);
>> -		return AE_NOT_FOUND;
>> +		ret = AE_NOT_FOUND;
>> +		goto request_channel_fail;
>>   	}
>>
> Your patch seems to be not based on the upstream.
> Commit f890157e61b8 ("ACPI: PCC: Release resources on address space setup
> failure path") has addressed it already.
I make this patch based on the commit f890157e61b8.
Here is to unify the relese resources path.
>
>>   	pcc_chan = data->pcc_chan;
>> +	if (!pcc_chan->mchan->mbox->txdone_irq) {
>> +		pr_err("This channel-%d does not support interrupt.\n",
>> +		       ctx->subspace_id);
>> +		ret = AE_SUPPORT;
>> +		goto request_channel_fail;
>> +	}
> Indeed, I supported only interrupt case and this approach is better than
> checking it in handler atleast until we add support for polling based
> transfers in future(hope that never happens, but you never know)
Yes
>
