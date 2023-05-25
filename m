Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75764710352
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEYDeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEYDeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:34:12 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16C9FE2;
        Wed, 24 May 2023 20:34:09 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxiPEv125kUrwAAA--.1775S3;
        Thu, 25 May 2023 11:34:07 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOQu125kVzh2AA--.64313S3;
        Thu, 25 May 2023 11:34:06 +0800 (CST)
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
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <2a72a2c2-6fda-1ea8-3b27-5623cc1132aa@loongson.cn>
Date:   Thu, 25 May 2023 11:34:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOQu125kVzh2AA--.64313S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGw17Cw48WFyktrW5tw1UZFb_yoW5Cw1xpF
        WUJa1jyr4UJrWkCw1Iqwn5Xrn2yryfJF1UWwn8tFy8Gr1qvF13Xr1UKrWa9rZ3uFs5uF48
        Za1UXFs3CF90y3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bxkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487
        Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l42xK82IY6x
        8ErcxFaVAv8VWrMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8c_-PUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/5/24 下午4:42, Andy Shevchenko 写道:
> On Wed, May 24, 2023 at 10:52 AM zhuyinbo <zhuyinbo@loongson.cn> wrote:
>> 在 2023/5/23 下午8:54, andy.shevchenko@gmail.com 写道:
>>> Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:
> 
> ...
> 
>>>> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
>>>> +                            struct spi_device *spi, struct spi_transfer *t)
>>>> +{
>>>> +    unsigned int hz;
>>>> +
>>>> +    if (t)
>>>> +            hz = t->speed_hz;
>>>
>>> And if t is NULL? hz will be uninitialized. Don't you get a compiler warning?
>>> (Always test your code with `make W=1 ...`)
>>
>> I always use `make W=1` and I don't find any warning, but that what you
>> said was right and I will initial hz.
> 
> Note, if hz == 0 when t == NULL, you can unify that check with the below.
> 
>>>> +    if (hz && loongson_spi->hz != hz)
> 
> Something like
> 
>    if (t && _spi->hz != t->speed_hz)
>      ...(..., t->speed_hz);
> 
> In such a case you won't need a temporary variable.

okay, I got it.

> 
>>>> +            loongson_spi_set_clk(loongson_spi, hz);
>>>> +
>>>> +    if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
>>>> +            loongson_spi_set_mode(loongson_spi, spi);
>>>> +
>>>> +    return 0;
>>>> +}
> 
> ...
> 
>>> Why do you use deprecated naming? Can you use spi_controller* instead of
>>> spi_master* in all cases?
>>
>> It seems was a personal code style issue and I don't find the
>> differences between spi_controller and spi_master, Using spi_controller*
>> is also acceptable to me and I will use spi_controller* instead of
>> spi_master* in all cases.
> 
> Read this section (#4) in full
> https://kernel.org/doc/html/latest/process/coding-style.html#naming

okay, I got it.

> 
> ...
> 
>>>> +    clk = devm_clk_get_optional(dev, NULL);
>>>> +    if (!IS_ERR(clk))
>>>> +            spi->clk_rate = clk_get_rate(clk);
>>>
>>>> +    else
>>>
>>> Redundant. Just check for the error first as it's very usual pattern in the
>>> Linux kernel.
>>
>> Like below ?
>>
>>           clk = devm_clk_get_optional(dev, NULL);
>> -       if (!IS_ERR(clk))
>> -               spi->clk_rate = clk_get_rate(clk);
>> -       else
>> +       if (IS_ERR(clk))
>>                   return dev_err_probe(dev, PTR_ERR(clk), "unable to get
>> clock\n");
>>
>> +       spi->clk_rate = clk_get_rate(clk);
> 
> Yes.

okay, I got it.
> 
>>           loongson_spi_reginit(spi);
> 
>>>> +            return dev_err_probe(dev, PTR_ERR(clk), "unable to get clock\n");
> 
> ...
> 
>>>> +    ret = loongson_spi_init_master(dev, reg_base);
>>>> +    if (ret)
>>>> +            return dev_err_probe(dev, ret, "failed to initialize master\n");
>>>> +
>>>> +    return ret;
>>>
>>>        return 0;
>>
>> It seems was more appropriate that initialize ret then return ret.
>> Do you think so ?
> 
> What do you mean and how does it help here?

I'm sorry, I was wrong before and the ret varible seems not to be
initialized and it always record the return value for
loongson_spi_init_master.

It seems was appropriate that use "return ret" and I don't got your
point that in probe for use "return 0"

> 
> 
> ...
> 
>>>> +#include <linux/spi/spi.h>
>>>
>>> This neither.
>>
>> That other .c file seems to need it and I will move it to other .c
>> code file.
> 
> Yes, please do.

okay, I got it.

Thanks,
Yinbo

