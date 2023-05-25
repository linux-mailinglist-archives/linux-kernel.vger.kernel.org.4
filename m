Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952F7108DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbjEYJ2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbjEYJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:28:41 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18026A9;
        Thu, 25 May 2023 02:28:38 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8BxlPBFKm9ka+4AAA--.2298S3;
        Thu, 25 May 2023 17:28:37 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx97VEKm9kFBJ3AA--.194S3;
        Thu, 25 May 2023 17:28:37 +0800 (CST)
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-3-zhuyinbo@loongson.cn> <ZGy3b7ZfNwWoGDTu@surfacebook>
 <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
 <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com>
 <2a72a2c2-6fda-1ea8-3b27-5623cc1132aa@loongson.cn>
 <CAHp75VdMSM7VMFn8BDJpx2PJOR8DJtP0GF=sTECnMhz+MoSJ=Q@mail.gmail.com>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <889235d3-a5a2-417d-dc47-dbcf543c8549@loongson.cn>
Date:   Thu, 25 May 2023 17:28:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdMSM7VMFn8BDJpx2PJOR8DJtP0GF=sTECnMhz+MoSJ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx97VEKm9kFBJ3AA--.194S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7GFy8Xw43tryrZrWkurWDtwb_yoW8JF4UpF
        W3JFWjkr4UKw4kCrWjq3Z8ArnY9F97Jr1Yqr95Gr97Aryqyr9xJr1UtrZF9rZ3CF12kr12
        qa1UXFW3CFZ8XrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bx8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAq
        jxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz4
        8v1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8pnQUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/25 下午5:16, Andy Shevchenko 写道:
> On Thu, May 25, 2023 at 6:34 AM zhuyinbo <zhuyinbo@loongson.cn> wrote:
>> 在 2023/5/24 下午4:42, Andy Shevchenko 写道:
>>> On Wed, May 24, 2023 at 10:52 AM zhuyinbo <zhuyinbo@loongson.cn> wrote:
>>>> 在 2023/5/23 下午8:54, andy.shevchenko@gmail.com 写道:
>>>>> Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:
> 
> ...
> 
>>>>>> +    ret = loongson_spi_init_master(dev, reg_base);
>>>>>> +    if (ret)
>>>>>> +            return dev_err_probe(dev, ret, "failed to initialize master\n");
>>>>>> +
>>>>>> +    return ret;
>>>>>
>>>>>         return 0;
>>>>
>>>> It seems was more appropriate that initialize ret then return ret.
>>>> Do you think so ?
>>>
>>> What do you mean and how does it help here?
>>
>> I'm sorry, I was wrong before and the ret varible seems not to be
>> initialized and it always record the return value for
>> loongson_spi_init_master.
>>
>> It seems was appropriate that use "return ret" and I don't got your
>> point that in probe for use "return 0"
> 
> In the above excerpt you will return anything except 0 with return
> dev_err_probe(); line. Why do you still need to return ret; at the end
> of the function?


I'm sorry, I misread it and you are right and I will "return 0".

Thanks,
Yinbo.

