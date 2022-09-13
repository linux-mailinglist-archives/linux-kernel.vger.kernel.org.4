Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617E5B6586
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 04:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIMCXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 22:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIMCXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:23:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44A52DC9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 19:23:35 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MRRxP5xR6z14QZL;
        Tue, 13 Sep 2022 10:19:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 10:23:33 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 10:23:33 +0800
Subject: Re: [PATCH -next] habanalabs/gaudi2: fix free irq in error path in
 gaudi2_enable_msix()
To:     Oded Gabbay <ogabbay@kernel.org>
CC:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20220825133123.1874337-1-yangyingliang@huawei.com>
 <CAFCwf13WoDk6y435zmG5VQa1kRqDo1TA26ZhT5=bTp6qtQr8XQ@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <6fef3c68-fea2-b5ee-5110-35648b32fe8b@huawei.com>
Date:   Tue, 13 Sep 2022 10:23:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFCwf13WoDk6y435zmG5VQa1kRqDo1TA26ZhT5=bTp6qtQr8XQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/29 18:14, Oded Gabbay wrote:
> On Thu, Aug 25, 2022 at 4:23 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Add two variables to store completion irq and event queue irq. And add
>> a new lable to free event queue irq in error path in gaudi2_enable_msix().
>>
>> Fixes: d7bb1ac89b2f ("habanalabs: add gaudi2 asic-specific code")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/misc/habanalabs/gaudi2/gaudi2.c | 21 +++++++++++++--------
>>   1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
>> index 98336a1a84b0..54eca19b270b 100644
>> --- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
>> +++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
>> @@ -3518,6 +3518,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>>          struct asic_fixed_properties *prop = &hdev->asic_prop;
>>          struct gaudi2_device *gaudi2 = hdev->asic_specific;
>>          int rc, irq, i, j, user_irq_init_cnt;
>> +       int completion_irq, event_queue_irq;
>>          irq_handler_t irq_handler;
>>          struct hl_cq *cq;
>>
>> @@ -3532,17 +3533,19 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
>>                  return rc;
>>          }
>>
>> -       irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
>> +       completion_irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_COMPLETION);
>>          cq = &hdev->completion_queue[GAUDI2_RESERVED_CQ_CS_COMPLETION];
>> -       rc = request_irq(irq, hl_irq_handler_cq, 0, gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
>> +       rc = request_irq(completion_irq, hl_irq_handler_cq, 0,
>> +                        gaudi2_irq_name(GAUDI2_IRQ_NUM_COMPLETION), cq);
>>          if (rc) {
>>                  dev_err(hdev->dev, "Failed to request IRQ %d", irq);
> Please fix the error prints to print the correct irq.
OK.
> And I think you should remove the "irq" local variable completely.
'irq' will be used later, it can not be removed.

Thanks,
Yang
>
> Oded
>
