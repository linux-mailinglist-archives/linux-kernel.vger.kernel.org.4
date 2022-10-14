Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE15FE689
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiJNBXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiJNBXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:23:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D1D189C1C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:23:06 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MpT874kMBzpVrr;
        Fri, 14 Oct 2022 09:19:51 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:23:04 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 09:23:03 +0800
Subject: Re: [PATCH] platform/loongarch: laptop: fix possible UAF in
 generic_acpi_laptop_init()
To:     Huacai Chen <chenhuacai@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <lvjianmin@loongson.cn>,
        <chenhuacai@loongson.cn>
References: <20221013131209.775969-1-yangyingliang@huawei.com>
 <CAAhV-H48bH5VAYhsMvupUSWouAUR=s9b4hJYdJYdymCYbKQfjA@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <b2dcb989-4bda-8921-a5a0-7ea29d6382ad@huawei.com>
Date:   Fri, 14 Oct 2022 09:23:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H48bH5VAYhsMvupUSWouAUR=s9b4hJYdJYdymCYbKQfjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Huacai

On 2022/10/13 23:47, Huacai Chen wrote:
> Hi, Yingliang,
>
> Thank you for your patches, but could you please merge the two trivial
> patches to a single one?
It's OK to merge them into a single one in v2.
But the two patches solved different things, they are not relative.

Thanks,
Yang
>
> Huacai
>
> On Thu, Oct 13, 2022 at 9:12 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> Current the return value of 'sub_driver->init' is not checked,
>> if sparse_keymap_setup() called in the init function fails,
>> 'generic_inputdev' is freed, then it willl lead a UAF when
>> using it in generic_acpi_laptop_init(). Fix it by checking
>> return value. Set generic_inputdev to NULL after free to avoid
>> double free it.
>>
>> Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/platform/loongarch/loongson-laptop.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
>> index f0166ad5d2c2..a665fd1042ac 100644
>> --- a/drivers/platform/loongarch/loongson-laptop.c
>> +++ b/drivers/platform/loongarch/loongson-laptop.c
>> @@ -448,6 +448,7 @@ static int __init event_init(struct generic_sub_driver *sub_driver)
>>          if (ret < 0) {
>>                  pr_err("Failed to setup input device keymap\n");
>>                  input_free_device(generic_inputdev);
>> +               generic_inputdev = NULL;
>>
>>                  return ret;
>>          }
>> @@ -502,8 +503,11 @@ static int __init generic_subdriver_init(struct generic_sub_driver *sub_driver)
>>          if (ret)
>>                  return -EINVAL;
>>
>> -       if (sub_driver->init)
>> -               sub_driver->init(sub_driver);
>> +       if (sub_driver->init) {
>> +               ret = sub_driver->init(sub_driver);
>> +               if (ret)
>> +                       goto err_out;
>> +       }
>>
>>          if (sub_driver->notify) {
>>                  ret = setup_acpi_notify(sub_driver);
>> --
>> 2.25.1
>>
> .
