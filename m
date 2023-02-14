Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AFD6955E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBNBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBNBYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:24:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C1C13525;
        Mon, 13 Feb 2023 17:24:19 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PG3MY6RmwzRrr5;
        Tue, 14 Feb 2023 09:21:45 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 09:24:16 +0800
Message-ID: <7876ff17-3e16-600e-8ed7-3fcab173618c@huawei.com>
Date:   Tue, 14 Feb 2023 09:24:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC-V3 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
To:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <zhangzekun11@huawei.com>,
        <wangxiongfeng2@huawei.com>, <tanxiaofei@huawei.com>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <wangkefeng.wang@huawei.com>, <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
 <20221203095150.45422-2-lihuisong@huawei.com>
 <20230206153940.gcddy3b3znk72yqd@bogus>
 <926bf147-5e93-0104-1bf4-171efcd15c5c@huawei.com>
 <e96474e8-6427-9a80-0e97-de97684b8e40@xsightlabs.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <e96474e8-6427-9a80-0e97-de97684b8e40@xsightlabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/14 5:18, Robbie King 写道:
> On 2/6/2023 9:27 PM, lihuisong (C) wrote:
>> 在 2023/2/6 23:39, Sudeep Holla 写道:
>>> Hi Huisong,
>>>
>>> Apologies for such a long delay.
>>>
>>> Also I would like to hear from Robbie King who I know is playing around
>>> with this these days 😄. At minimum if this logic works for him as well.
>> @Robbie King,
>> Do you use this patchset to test your requirements?
>> Any other problems? Can you tell us your result?
>>
> Sorry for the delay.  I have verified the two patches continue to pass the
> limited stress testing I have done with earlier change sets.
Thanks Robbie King.
I will send a formal patch as soon as possible.
>
>>> On Sat, Dec 03, 2022 at 05:51:49PM +0800, Huisong Li wrote:
>>>> Currently, PCC driver doesn't support the processing of platform
>>>> notification for slave PCC subspaces because of the incomplete
>>>> communication flow.
>>>>
>>>> According to ACPI specification, if platform sends a notification
>>>> to OSPM, it must clear the command complete bit and trigger platform
>>>> interrupt. OSPM needs to check whether the command complete bit is
>>>> cleared, clear platform interrupt, process command, and then set the
>>>> command complete and ring doorbell to Platform. But the current judgment
>>>> on the command complete is not applicable to type4 in pcc_mbox_irq().
>>>>
>>>> This patch introduces a communication flow direction field to detect
>>>> whether the interrupt belongs to the master or slave subspace channel.
>>>> And PCC driver needs to add the phase of setting the command complete
>>>> and ring doorbell in pcc_mbox_irq() to complete type4 communication
>>>> flow after processing command from Platform.
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/mailbox/pcc.c | 77 +++++++++++++++++++++++++++++++++++++++----
>>>>    1 file changed, 71 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 105d46c9801b..ad6d0b7d50fc 100644
>>>> --- a/drivers/mailbox/pcc.c
>>>> +++ b/drivers/mailbox/pcc.c
>>>> @@ -80,6 +80,13 @@ struct pcc_chan_reg {
>>>>        u64 status_mask;
>>>>    };
>>>>    +enum pcc_chan_comm_flow_dir_type {
>>>> +    PCC_ONLY_OSPM_TO_PLATFORM,
>>>> +    PCC_ONLY_PLATFORM_TO_OSPM,
>>>> +    PCC_BIDIRECTIONAL,
>>>> +    PCC_DIR_UNKNOWN,
>>>> +};
>>>> +
>>>>    /**
>>>>     * struct pcc_chan_info - PCC channel specific information
>>>>     *
>>>> @@ -91,6 +98,7 @@ struct pcc_chan_reg {
>>>>     * @cmd_update: PCC register bundle for the command complete update register
>>>>     * @error: PCC register bundle for the error status register
>>>>     * @plat_irq: platform interrupt
>>>> + * @comm_flow_dir: direction of communication flow supported by the channel
>>>>     */
>>>>    struct pcc_chan_info {
>>>>        struct pcc_mbox_chan chan;
>>>> @@ -100,12 +108,15 @@ struct pcc_chan_info {
>>>>        struct pcc_chan_reg cmd_update;
>>>>        struct pcc_chan_reg error;
>>>>        int plat_irq;
>>>> +    u8 comm_flow_dir;
>>> I would rather just save the 'type' as read from the PCCT. We don't know
>>> what future types might be and just identifying them by the direction of
>>> flow of the data, it restricts the usage of this.
>> Ack.
>>>>    };
>>>>      #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>>>>    static struct pcc_chan_info *chan_info;
>>>>    static int pcc_chan_count;
>>>>    +static int pcc_send_data(struct mbox_chan *chan, void *data);
>>>> +
>>>>    /*
>>>>     * PCC can be used with perf critical drivers such as CPPC
>>>>     * So it makes sense to locally cache the virtual address and
>>>> @@ -221,6 +232,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>>>        return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>>>    }
>>>>    +static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
>>>> +                  u64 cmd_complete_reg_val)
>>> Probably rename this as pcc_chan_command_complete or something similar.
>> Ack
>>>> +{
>>>> +    bool need_rsp;
>>>> +
>>>> +    if (!pchan->cmd_complete.gas)
>>>> +        return true;
>>>> +
>>>> +    cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
>>>> +
>>>> +    switch (pchan->comm_flow_dir) {
>>> Use the channel type instead here.
>> Ack
> .
