Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9A4624201
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiKJMK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKJMKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:10:15 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B87F71F2D;
        Thu, 10 Nov 2022 04:10:08 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N7LHj1v5yz15MNp;
        Thu, 10 Nov 2022 20:09:53 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:10:06 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 20:10:06 +0800
Message-ID: <4c4cb2a5-c029-1815-e06a-f6d055ed5912@huawei.com>
Date:   Thu, 10 Nov 2022 20:10:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] mailbox: pcc: fix 'pcc_chan_count' when fail to
 initialize PCC
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-4-lihuisong@huawei.com>
 <20221110104415.gk3asb5yc26slcs7@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221110104415.gk3asb5yc26slcs7@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


在 2022/11/10 18:44, Sudeep Holla 写道:
> On Thu, Nov 10, 2022 at 09:50:34AM +0800, Huisong Li wrote:
>> Currently, 'pcc_chan_count' is a non-zero value if PCC subspaces are parsed
>> successfully and subsequent processes is failure during initializing PCC
>> process. This may cause that pcc_mbox_request_channel() can still be
>> executed successfully , which will misleads the caller that this channel is
>> available.
>>
>> Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/mailbox/pcc.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 7cee37dd3b73..47d70c5884e3 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -294,6 +294,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>>   		pr_err("Channel not found for idx: %d\n", subspace_id);
>>   		return ERR_PTR(-EBUSY);
>>   	}
>> +
> Spurious/not needed change ?
Ack
>
>>   	dev = chan->mbox->dev;
>>   
>>   	spin_lock_irqsave(&chan->lock, flags);
>> @@ -735,7 +736,8 @@ static int __init pcc_init(void)
>>   
>>   	if (ret) {
>>   		pr_debug("ACPI PCC probe failed.\n");
>> -		return -ENODEV;
>> +		ret = -ENODEV;
>> +		goto out;
> Not needed, we don't set pcc_chan_count if the probe failed.
You are right. will fix it in v2, thanks.
>
>>   	}
>>   
>>   	pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
>> @@ -743,10 +745,13 @@ static int __init pcc_init(void)
>>   
>>   	if (IS_ERR(pcc_pdev)) {
>>   		pr_debug("Err creating PCC platform bundle\n");
>> -		return PTR_ERR(pcc_pdev);
>> +		ret = PTR_ERR(pcc_pdev);
> You just need to set pcc_chan_count to 0 here, so no need for goto.
Ack
>
