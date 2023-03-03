Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958776A8EF7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 02:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCCBuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 20:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCCBuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 20:50:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F21A18A93;
        Thu,  2 Mar 2023 17:50:03 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PSW7C4sn7znWTL;
        Fri,  3 Mar 2023 09:47:19 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 09:50:00 +0800
Message-ID: <8691e22d-78a0-3a79-4999-3201767f163e@huawei.com>
Date:   Fri, 3 Mar 2023 09:50:00 +0800
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
        <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-2-lihuisong@huawei.com>
 <20230301132413.p6ssnkp76pv2bz5y@bogus>
 <de87d0f6-572d-c7be-cf8e-f80914270a9f@huawei.com>
 <20230302135201.c2qbvtx6k5mgnobv@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230302135201.c2qbvtx6k5mgnobv@bogus>
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


在 2023/3/2 21:52, Sudeep Holla 写道:
> On Thu, Mar 02, 2023 at 09:57:35AM +0800, lihuisong (C) wrote:
>> 在 2023/3/1 21:24, Sudeep Holla 写道:
> [...]
>
>>> +static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
>>> +{
>>> +       u64 val;
>>> +       int ret;
>>> +
>>> +       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>> +       if (ret)
>>> +               return false;
>>> +
>> we indeed already check if cmd_complete register is exist.
>> IMO, it can simply the code logic and reduce the risk of problems if we
>> return true here for the type without this register.
>> what do you think?
>>
> IIUC, your concern is about returning true for type 4 when the register
> doesn't exist, right ?
Return true in advance for the type without the cmd_complete register.
If support the register, we judge if the channel should respond the 
interrupt based on the value of cmd_complete, like bellow.

-->8
+static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
+{
+       u64 val;
+       int ret;
+
+       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
+       if (ret)
+               return false;
+
+        if (!pchan->cmd_complete.gas)
+                return true;
+
+       /*
+         * Judge if the channel respond the interrupt based on the value of
+         * command complete.
+         */
+       val &= pchan->cmd_complete.status_mask;
+       /*
+        * If this is PCC slave subspace channel, then the command complete
+        * bit 0 indicates that Platform is sending a notification and OSPM
+        * needs to respond this interrupt to process this command.
+        */
+       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+               return !val;
+       else
+               return !!val;
+}
> I am saying it won't happen as we bail out if there is no GAS register
> from pcc_chan_reg_init(). Or am I missing something here ?
Yes, what you say is also ok. Just wondering if it is better to simply 
the logic.
>>> +       val &= pchan->cmd_complete.status_mask;
>>> +
>>> +       /*
>>> +        * If this is PCC slave subspace channel, then the command complete
>>> +        * bit 0 indicates that Platform is sending a notification and OSPM
>>> +        * needs to respond this interrupt to process this command.
>>> +        */
>>> +       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>>> +               return !val;
>>> +       else
>>> +               return !!val;
>> This else branch is not applicable to type 3. type 3 will cannot respond
>> interrupt.
> Sorry I don't understand what you mean by that.
Sorry for my mistake.
I meant that the type2 channel always return false in this function and
never respond the interrupt if no check for the GAS register.
Because the 'val' for the type without the register is zero.
>
