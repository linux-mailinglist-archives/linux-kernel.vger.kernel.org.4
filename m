Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060C563D4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbiK3LpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiK3LpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:45:01 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE251C934;
        Wed, 30 Nov 2022 03:45:00 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMcmx3r1gzmWHg;
        Wed, 30 Nov 2022 19:44:17 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 19:44:58 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 19:44:57 +0800
Subject: Re: [PATCH] mmc: core: Fix error return code in sd_read_ext_regs()
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221130092847.2092-1-thunder.leizhen@huawei.com>
 <CAPDyKFphNdR-TorULpbsMtM6MzqsaK_UdSmG9Hin=wunUwJwJQ@mail.gmail.com>
 <d9d44a9c-e61e-2803-731b-cfa5f3d3d46c@huawei.com>
 <CAPDyKFrbRcEgtwbgBY8bsDW3YTtXJBS0zRhJq-Emf89hDWaUjg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fa77b721-387c-5de9-e8a8-7a55bd568372@huawei.com>
Date:   Wed, 30 Nov 2022 19:44:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrbRcEgtwbgBY8bsDW3YTtXJBS0zRhJq-Emf89hDWaUjg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/30 19:33, Ulf Hansson wrote:
> On Wed, 30 Nov 2022 at 12:18, Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>> On 2022/11/30 18:04, Ulf Hansson wrote:
>>> On Wed, 30 Nov 2022 at 10:29, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>
>>>> Fix to return a negative error code from the error handling
>>>> case instead of 0, as done elsewhere in this function.
>>>>
>>>> Fixes: c784f92769ae ("mmc: core: Read the SD function extension registers for power management")
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  drivers/mmc/core/sd.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>> index 3662bf5320ce56d..7b64f76f0179ca8 100644
>>>> --- a/drivers/mmc/core/sd.c
>>>> +++ b/drivers/mmc/core/sd.c
>>>> @@ -1277,6 +1277,7 @@ static int sd_read_ext_regs(struct mmc_card *card)
>>>>         if (rev != 0 || len > 512) {
>>>>                 pr_warn("%s: non-supported SD ext reg layout\n",
>>>>                         mmc_hostname(card->host));
>>>> +               err = -EOPNOTSUPP;
>>>
>>> The original intent was to not return an error code. Simply, because
>>> the card remains functional and all but the new features from the SD
>>> function extensions registers can still be used.
>>
>> OK, I got it.
>>
>>>
>>> Perhaps, we should update the comment a few lines above to better
>>> reflect that this is in-fact what we intend here.
>>
>> How about also add 'warning' to the output? The other two outputs
>> contain the 'error' keyword.
> 
> There is already a pr_warn(), or is there something you want to add to that?

No, I don't have anything else to add.

I just saw the other two error outputs are also use pr_warn(). Maybe they
need to be changed to pr_err().

> 
>>
>>>
>>>>                 goto out;
>>>>         }
>>>>
> 
> Kind regards
> Uffe
> .
> 

-- 
Regards,
  Zhen Lei
