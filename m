Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61F56C47CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCVKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCVKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:38:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEE658495
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:38:22 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PhPxX1xlLznhwj;
        Wed, 22 Mar 2023 18:35:12 +0800 (CST)
Received: from [10.67.111.115] (10.67.111.115) by
 dggpemm500016.china.huawei.com (7.185.36.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 18:38:19 +0800
Message-ID: <ef8051f2-056f-9ea1-e5ba-51339fdb7877@huawei.com>
Date:   Wed, 22 Mar 2023 18:38:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
From:   Yipeng Zou <zouyipeng@huawei.com>
Subject: Re: [PATCH] irq: fasteoi handler re-runs on concurrent invoke
To:     "Gowans, James" <jgowans@amazon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "maz@kernel.org" <maz@kernel.org>,
        "Raslan, KarimAllah" <karahmed@amazon.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230317095300.4076497-1-jgowans@amazon.com>
 <f0879a30-6f88-30e0-ce30-e230df8f2936@huawei.com>
 <001d516c1bb6f0b6d2344f1ae160e796d003c24c.camel@amazon.com>
 <6d1859b0-20f3-05a8-d8d6-dfb0c9985985@huawei.com>
 <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
Content-Language: en-US
In-Reply-To: <fd5588e5b0b1b5d21b1c0df7290844907ebcf367.camel@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.115]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/22 15:48, Gowans, James 写道:
> On Wed, 2023-03-22 at 14:26 +0800, Yipeng Zou wrote:
>>> 在 2023/3/17 19:49, Gowans, James 写道:
>>> What are your thoughts on this approach compared to your proposal?
>> Hi,
>>
>> I also agree with you, enhance the existing generic handlers is a good
>> way to go.
>>
>> Too many generic handlers really confuse developers.
> Thomas, would you be open to taking the patch to tweak the handle_fasteoi_irq
> handler? Or is there a different solution to this problem which you prefer?

Our workaround is generally similar, but the implementation details are 
somewhat different.

Maybe let us look for some comments from maintainer and other people.

>> About CONFIG_GENERIC_PENDING_IRQ is actually some attempts we made
>> before under the suggestion of Thomas.
>>
>> This patch is valid for our problem. However, the current config is only
>> supported on x86, and some code modifications are required on arm.
> Thanks for the patch! I have been trying out CONFIG_GENERIC_PENDING_IRQ too, but
> couldn't get it to work; it seems the IRQ never actually moved. I see from your
> patch that we would need to tweak the callbacks and explicitly do the affinity
> move in the EOI handler of the chip; the generic code won't do it for us.
>
>> This has led to some changes in the original behavior of modifying
>> interrupting affinity, from the next interrupt taking effect to the next
>> to the next interrupt taking effect.
> So this means that even if it's safe to change the affinity right now, the
> change will actually be delayed until the *next* interrupt? Specifically because
> interrupt doesn't have the IRQD_MOVE_PCNTXT state flag isn't set hence
> irq_set_affinity_locked won't call irq_try_set_affinity?

Yes, modify of the interrupt affinity will be delayed until the *next* 
interrupt eoi handler(in hard_irq context).

This is the difference from x86, which do irq_move_irq in ack handler, 
and then transfer the current interrupt to the new CPU without other affect.

> JG

-- 
Regards,
Yipeng Zou

