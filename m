Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAD743A04
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjF3KzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjF3Kyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:54:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81298358A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 03:54:52 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QssBC47pdzMpYn;
        Fri, 30 Jun 2023 18:34:11 +0800 (CST)
Received: from [10.174.185.210] (10.174.185.210) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 18:37:22 +0800
Subject: Re: [PATCH] irqchipi/gic-v4: Ensure accessing the correct RD when and
 writing INVLPIR
From:   Kunkun Jiang <jiangkunkun@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <chenxiang66@hisilicon.com>,
        <tangnianyao@huawei.com>
References: <20230412041510.497-1-jiangkunkun@huawei.com>
 <86y1mxl9m4.wl-maz@kernel.org>
 <f618c540-879c-ca5b-31af-e55472d8208c@huawei.com>
 <86bkikmvjk.wl-maz@kernel.org>
 <b073b1f7-0567-eb45-dec9-dcd2054e41c9@huawei.com>
 <87zg4ypmlq.wl-maz@kernel.org>
 <b0030bc5-7e00-60e1-5f0f-ce755ec50321@huawei.com>
Message-ID: <d9d4b2dc-364e-421d-7ebc-533ae9bef1b7@huawei.com>
Date:   Fri, 30 Jun 2023 18:37:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b0030bc5-7e00-60e1-5f0f-ce755ec50321@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2023/6/21 20:30, Kunkun Jiang wrote:
> Hi Mrac,
>
> On 2023/6/17 15:35, Marc Zyngier wrote:
>> On Tue, 16 May 2023 13:01:59 +0100,
>> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>>> Hi Marc,
>>>
>>> On 2023/5/16 18:15, Marc Zyngier wrote:
>>>> On Thu, 13 Apr 2023 04:57:17 +0100,
>>>> Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>>>>>> Wouldn't it be nice if irq_to_cpuid() could work out whether it is
>>>>>> dealing with a LPI or a VLPI like it does today, but also directly
>>>>>> with a VPE? We could then use the same code as derect_lpi_inv(). I
>>>>>> came up with this the hack below, which is totally untested as I 
>>>>>> don't
>>>>>> have access to GICv4.1 HW.
>>>>>>
>>>>>> Could you give it a spin?
>>>>> Nice, I will test it as soon as possible.
>>>> Did you ever managed to test this?
>>> Sorry,I've only been coordinating the GICv4.1 environment in the last
>>> few days. I have tested it with GICv4 many times, and it doesn't recur.
>>> However, another call trace occurs with GICv4.1 when the device driver
>>> is loaded in Guest. I haven't found out why. Maybe you can help 
>>> analyze it.
>> I also went back to my patch, and it is a bit bogus (it doesn't even
>> compile to start with). I've now posted new version[1] that should at
>> least fix the bug you initially reported.
>>
>> Can you please test it and reply to it?
> I haven't coordinated the environment well these days. I'll test it out
> after Dragon Boat Festival.
I coordinated the hardware environment and verified the new patch 20+ times.
It works fine. Thanks for the fix.

Thanks,
Kunkun Jiang
>
> Thanks,
> Kunkun Jiang
>> Thanks,
>>
>>     M.
>>
>> [1] https://lore.kernel.org/r/20230617073242.3199746-1-maz@kernel.org
>>
