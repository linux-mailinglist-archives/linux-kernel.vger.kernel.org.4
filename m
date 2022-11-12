Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9017762662E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 02:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKLB1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 20:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKLB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 20:27:30 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D671D2F67C;
        Fri, 11 Nov 2022 17:27:28 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N8HxB0LJVzmVhF;
        Sat, 12 Nov 2022 09:27:10 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 09:27:26 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 09:27:25 +0800
Message-ID: <64303ec8-8f6b-df51-5257-25aeeb02e727@huawei.com>
Date:   Sat, 12 Nov 2022 09:27:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH V2 1/2] ACPI: PCC: add check for platform interrupt
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221111024448.25012-1-lihuisong@huawei.com>
 <20221111024448.25012-2-lihuisong@huawei.com>
 <20221111142604.qrk7bf2qf6ibfln3@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221111142604.qrk7bf2qf6ibfln3@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


在 2022/11/11 22:26, Sudeep Holla 写道:
> Change $subject to:
> "ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available"
>
> On Fri, Nov 11, 2022 at 10:44:47AM +0800, Huisong Li wrote:
>> Currently, PCC Operation Region driver senses the completion of command by
>> interrupt way. If platform can not generate an interrupt when a command
>> complete, the caller never gets the desired result. So let's reject the
>> setup of the PCC address space on platform that do not support interrupt
>> mode.
>>
> Please reword something like below:
>
> "Currently, PCC OpRegion handler depends on the availability of platform
> interrupt to be functional currently. If it is not available, the OpRegion
> can't be executed successfully or the desired outcome won't be possible.
> So let's reject setting up the PCC OpRegion handler on the platform if
> it doesn't support or have platform interrupt available"
>
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
> The labels are confusing IMO. I would do 's/request_channel_fail/err_free_data/'
> to indicate what is exactly done there rather than just describing what
> failed.
Good idea. Ack.
>
>>   	}
>>   
>>   	pcc_chan = data->pcc_chan;
>> +	if (!pcc_chan->mchan->mbox->txdone_irq) {
>> +		pr_err("This channel-%d does not support interrupt.\n",
>> +		       ctx->subspace_id);
>> +		ret = AE_SUPPORT;
>> +		goto request_channel_fail;
> This is wrong, you must goto "ioremap_fail" as you have been successful in
> opening the channel and now need to free the same.
Sorry, I will fix it in v3.
>
>> +	}
>>   	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
>>   					      pcc_chan->shmem_size);
>>   	if (!data->pcc_comm_addr) {
>>   		pr_err("Failed to ioremap PCC comm region mem for %d\n",
>>   		       ctx->subspace_id);
>> -		pcc_mbox_free_channel(data->pcc_chan);
>> -		kfree(data);
>> -		return AE_NO_MEMORY;
>> +		ret = AE_NO_MEMORY;
>> +		goto ioremap_fail;
> Again I prefer 's/ioremap_fail/err_free_channel/' or something similar.
>
> With all the above comments incorporated, you can add:
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
