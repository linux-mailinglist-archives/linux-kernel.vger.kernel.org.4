Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B96AA902
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 10:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjCDJtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 04:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 04:49:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C046B65A4;
        Sat,  4 Mar 2023 01:49:47 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PTKnL3tS4z1dy2L;
        Sat,  4 Mar 2023 17:49:42 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 4 Mar 2023 17:49:44 +0800
Message-ID: <1a7affec-a1df-a8d8-d5a4-68e19519bee8@huawei.com>
Date:   Sat, 4 Mar 2023 17:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>, <lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-2-lihuisong@huawei.com>
 <20230301132413.p6ssnkp76pv2bz5y@bogus>
 <de87d0f6-572d-c7be-cf8e-f80914270a9f@huawei.com>
 <20230302135201.c2qbvtx6k5mgnobv@bogus>
 <8691e22d-78a0-3a79-4999-3201767f163e@huawei.com>
 <20230303110745.3c6kihwxkd2i7iwh@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230303110745.3c6kihwxkd2i7iwh@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/3 19:07, Sudeep Holla 写道:
> On Fri, Mar 03, 2023 at 09:50:00AM +0800, lihuisong (C) wrote:
>> 在 2023/3/2 21:52, Sudeep Holla 写道:
>>> On Thu, Mar 02, 2023 at 09:57:35AM +0800, lihuisong (C) wrote:
>>>> 在 2023/3/1 21:24, Sudeep Holla 写道:
>>> [...]
>>>
>>>>> +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>>>>> +{
>>>>> +       u64 val;
>>>>> +       int ret;
>>>>> +
>>>>> +       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>>>> +       if (ret)
>>>>> +               return false;
>>>>> +
>>>> we indeed already check if cmd_complete register is exist.
>>>> IMO, it can simply the code logic and reduce the risk of problems if we
>>>> return true here for the type without this register.
>>>> what do you think?
>>>>
>>> IIUC, your concern is about returning true for type 4 when the register
>>> doesn't exist, right ?
>> Return true in advance for the type without the cmd_complete register.
>> If support the register, we judge if the channel should respond the
>> interrupt based on the value of cmd_complete, like bellow.
> Right, sorry for missing that.
>
>> -->8
>> +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>> +{
>> +       u64 val;
>> +       int ret;
>> +
>> +       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>> +       if (ret)
>> +               return false;
>> +
>> +        if (!pchan->cmd_complete.gas)
>> +                return true;
>> +
> Yes we need the above check.
>
>> +       /*
>> +         * Judge if the channel respond the interrupt based on the value of
>> +         * command complete.
>> +         */
>> +       val &= pchan->cmd_complete.status_mask;
>> +       /*
>> +        * If this is PCC slave subspace channel, then the command complete
>> +        * bit 0 indicates that Platform is sending a notification and OSPM
>> +        * needs to respond this interrupt to process this command.
>> +        */
>> +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>> +               return !val;
>> +       else
>> +               return !!val;
>> +}
>>> I am saying it won't happen as we bail out if there is no GAS register
>>> from pcc_chan_reg_init(). Or am I missing something here ?
>> Yes, what you say is also ok. Just wondering if it is better to simply the
>> logic.
> Understood now.
>
>>>>> +       val &= pchan->cmd_complete.status_mask;
>>>>> +
>>>>> +       /*
>>>>> +        * If this is PCC slave subspace channel, then the command complete
>>>>> +        * bit 0 indicates that Platform is sending a notification and OSPM
>>>>> +        * needs to respond this interrupt to process this command.
>>>>> +        */
>>>>> +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>>>>> +               return !val;
>>>>> +       else
>>>>> +               return !!val;
>>>> This else branch is not applicable to type 3. type 3 will cannot respond
>>>> interrupt.
>>> Sorry I don't understand what you mean by that.
>> Sorry for my mistake.
>> I meant that the type2 channel always return false in this function and
>> never respond the interrupt if no check for the GAS register.
>> Because the 'val' for the type without the register is zero.
> Agreed as mentioned above, we need to bail out with true return if no GAS is
> found.
>
Ok, I will fix it as mentioned above.
>
> .
