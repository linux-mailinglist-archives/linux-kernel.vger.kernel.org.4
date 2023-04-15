Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6764A6E2E4A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 03:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDOBil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 21:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDOBik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 21:38:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884322720
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 18:38:33 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pywpy4xppznbWn;
        Sat, 15 Apr 2023 09:34:50 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 15 Apr 2023 09:38:28 +0800
Message-ID: <847e4b85-f081-e214-dc24-75a7b3c2c885@huawei.com>
Date:   Sat, 15 Apr 2023 09:38:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH] genirq: introduce handle_fasteoi_edge_irq flow
 handler
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <samuel@sholland.org>,
        <oleksandr_tyshchenko@epam.com>, <andy.shevchenko@gmail.com>,
        <apatel@ventanamicro.com>, <lvjianmin@loongson.cn>,
        <linux-kernel@vger.kernel.org>, <chris.zjh@huawei.com>,
        <liaochang1@huawei.com>, James Gowans <jgowans@amazon.com>
References: <20230310101417.1081434-1-zouyipeng@huawei.com>
 <86edomln7k.wl-maz@kernel.org>
From:   Yipeng Zou <zouyipeng@huawei.com>
In-Reply-To: <86edomln7k.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/14 19:25, Marc Zyngier 写道:
> On Fri, 10 Mar 2023 10:14:17 +0000,
> Yipeng Zou <zouyipeng@huawei.com> wrote:
>> Recently, We have a LPI migration issue on the ARM SMP platform.
>>
>> For example, NIC device generates MSI and sends LPI to CPU0 via ITS,
>> meanwhile irqbalance running on CPU1 set irq affinity of NIC to CPU1,
>> the next interrupt will be sent to CPU2, due to the state of irq is
>> still in progress, kernel does not end up performing irq handler on
>> CPU2, which results in some userland service timeouts, the sequence
>> of events is shown as follows:
>>
>> NIC                     CPU0                    CPU1
>>
>> Generate IRQ#1          READ_IAR
>>                          Lock irq_desc
>>                          Set IRQD_IN_PROGRESS
>>                          Unlock irq_desc
>>                                                  Lock irq_desc
>>                                                  Change LPI Affinity
>>                                                  Unlock irq_desc
>>                          Call irq_handler
>> Generate IRQ#2
>>                                                  READ_IAR
>>                                                  Lock irq_desc
>>                                                  Check IRQD_IN_PROGRESS
>>                                                  Unlock irq_desc
>>                                                  Return from interrupt#2
>>                          Lock irq_desc
>>                          Clear IRQD_IN_PROGRESS
>>                          Unlock irq_desc
>>                          return from interrupt#1
>>
>> For this scenario, The IRQ#2 will be lost. This does cause some exceptions.
> Please see my reply to James at [1]. I'd appreciate if you could give
> that patch a go, which I expect to be a better avenue to fix what is
> effectively a GIC architecture defect.
>
> Thanks,
>
> 	M.
>
> [1] https://lore.kernel.org/all/86pm89kyyt.wl-maz@kernel.org/

Hi Marc:

     Thanks for your time about this issue.

     I have seen your latest patch, and I am preparing the environment 
for testing, I will sent the testing status of this patch later.

-- 
Regards,
Yipeng Zou

