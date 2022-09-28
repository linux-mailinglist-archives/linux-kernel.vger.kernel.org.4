Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689C15ED6E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiI1Hzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbiI1HzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:55:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7BD2DF0;
        Wed, 28 Sep 2022 00:54:47 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mcp6p0N5SzHqPY;
        Wed, 28 Sep 2022 15:30:10 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 15:32:26 +0800
Subject: Re: [PATCH v2 1/3] genirq/irq_sim: Allow both one and two cell
 bindings
To:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Wei Yongjun <weiyongjun@huaweicloud.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220926084428.1792815-1-weiyongjun@huaweicloud.com>
 <20220926084428.1792815-2-weiyongjun@huaweicloud.com>
 <CAMRc=MfjB4QTf_zp5Rk3T_ndqDjCCjAW2HmGpJ9EF-i1epSLcw@mail.gmail.com>
 <865yha8fcs.wl-maz@kernel.org>
From:   Wei Yongjun <weiyongjun1@huawei.com>
Message-ID: <e9dc5d57-6978-c491-1851-9ea6d4ecfcf5@huawei.com>
Date:   Wed, 28 Sep 2022 15:32:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <865yha8fcs.wl-maz@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 20:55, Marc Zyngier wrote:
> On Mon, 26 Sep 2022 07:24:48 -0400,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Mon, Sep 26, 2022 at 10:27 AM Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>>>
>>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>>
>>> The IRQ simulator only support one cell binding now, this patch make it
>>> works with either one or two cell bindings, where the cell values map
>>> directly to the irq number and irq flags.
>>>
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>> ---
>>>  kernel/irq/irq_sim.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
>>> index dd76323ea3fd..73a90b7b6022 100644
>>> --- a/kernel/irq/irq_sim.c
>>> +++ b/kernel/irq/irq_sim.c
>>> @@ -149,6 +149,7 @@ static void irq_sim_domain_unmap(struct irq_domain *domain, unsigned int virq)
>>>  static const struct irq_domain_ops irq_sim_domain_ops = {
>>>         .map            = irq_sim_domain_map,
>>>         .unmap          = irq_sim_domain_unmap,
>>> +       .xlate          = irq_domain_xlate_onetwocell,
>>>  };
>>>
>>>  /**
>>> --
>>> 2.34.1
>>>
>>
>> You'll need Marc's (Cc'ed) Ack here.

Hi Marc,

> 
> The question is what will the simulator code do with this information.
> Throw it away? What of 3/4/5 cell bindings? I'd rather see the

The 3/4/5 cell bindings is selience ignored currently.

> simulator being extended to deal with arbitrary bindings instead of
> trading a harcoded limit for another one. And also give some
> semantics to the extra cells.

Would you means we should allow the users to overwrite the xlate callback
or overwrite the domain_ops?

Regards,
Wei Yongjun
