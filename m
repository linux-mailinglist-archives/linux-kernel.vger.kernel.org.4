Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7163B9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiK2GSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiK2GR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:17:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337666575;
        Mon, 28 Nov 2022 22:17:57 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NLsZ13fKvzHw7M;
        Tue, 29 Nov 2022 14:17:13 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 14:17:54 +0800
Message-ID: <da3dec73-e089-44ef-9167-b5fd990cc4fc@huawei.com>
Date:   Tue, 29 Nov 2022 14:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] USB: FHCI: fix error return code in of_fhci_probe()
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
CC:     <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1669692810-26744-1-git-send-email-wangyufen@huawei.com>
 <CAMZ6Rq+Y=7Cr8n68UMQ9FyfcZdNnHwaW5dabVf4CnaMadW90DQ@mail.gmail.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <CAMZ6Rq+Y=7Cr8n68UMQ9FyfcZdNnHwaW5dabVf4CnaMadW90DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/29 12:11, Vincent MAILHOL 写道:
> On Tue. 29 nov. 2022 à 12:33, Wang Yufen <wangyufen@huawei.com> wrote:
>> Fix to return a negative error code of PTR_ERR(fhci->gpiods[i])
>> instead of 0.
>>
>> Fixes: a4efdb8a423b ("USB: FHCI: Switch to GPIO descriptors")
>> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
>> ---
>>   drivers/usb/host/fhci-hcd.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
>> index 95a4446..afef72a 100644
>> --- a/drivers/usb/host/fhci-hcd.c
>> +++ b/drivers/usb/host/fhci-hcd.c
>> @@ -639,6 +639,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
>>                                          NULL, i, GPIOD_OUT_LOW);
>>
>>                  if (IS_ERR(fhci->gpiods[i])) {
>> +                       ret = PTR_ERR(fhci->gpiods[i])
>>                          dev_err(dev, "incorrect GPIO%d: %ld\n",
>>                                  i, PTR_ERR(fhci->gpiods[i]));
> 
> Can you add some extra clean-up and reuse ret in the dev_err()?
> 
>                           dev_err(dev, "incorrect GPIO%d: %ld\n", i, ret);

I prefer to reuse ret, just like other fhci->*** checks. This also keeps 
the code style consistent with the context. Will change in v2.
Thanks.

> 
> Alternatively you can also consider %pe to print the mnemotechnic
> instead of the value:
> 
>                           dev_err(dev, "incorrect GPIO%d: %pe\n",
>                                   i, fhci->gpiods[i]);
> 
> 
> Yours sincerely,
> Vincent Mailhol
> 
