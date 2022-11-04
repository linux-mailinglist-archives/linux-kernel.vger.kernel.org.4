Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA39D618E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiKDC4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiKDC4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:56:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA50424F3B;
        Thu,  3 Nov 2022 19:56:15 -0700 (PDT)
Received: from loongson.cn (unknown [10.180.13.64])
        by gateway (Coremail) with SMTP id _____8AxTbdOf2Rj8mYEAA--.3363S3;
        Fri, 04 Nov 2022 10:56:14 +0800 (CST)
Received: from [10.180.13.64] (unknown [10.180.13.64])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxV1dMf2RjryoNAA--.19210S2;
        Fri, 04 Nov 2022 10:56:13 +0800 (CST)
Subject: Re: [PATCH v5 1/2] soc: loongson: add GUTS driver for loongson-2
 platforms
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Lubomir Rintel <lkundrak@v3.sk>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, loongarch@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuyinbo@loongson.cn
References: <20221103081942.3529-1-zhuyinbo@loongson.cn>
 <b82c5b2c-d8a3-4b6f-9aad-0a63d2f45f08@app.fastmail.com>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <8aea609a-8e3e-6191-abf3-577b06da5c74@loongson.cn>
Date:   Fri, 4 Nov 2022 10:56:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b82c5b2c-d8a3-4b6f-9aad-0a63d2f45f08@app.fastmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxV1dMf2RjryoNAA--.19210S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF17Ar48Jr4xAr4DWFyxAFb_yoW8WrWxpF
        WrCa13GF4DJr4Yya1293W0gF95uFn3Cws8XrsxKr9F9r98Ja4Sv39rAF13CFWkZrs7Zr12
        9aykW3y8ZF45CFJanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bq8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkE
        cVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F4
        0Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC
        6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7
        AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUalALDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2022/11/3 ÏÂÎç4:53, Arnd Bergmann Ð´µÀ:
> On Thu, Nov 3, 2022, at 09:19, Yinbo Zhu wrote:
>> The global utilities block controls PCIE device enabling, alternate
>> function selection for multiplexed signals, consistency of HDA, USB
>> and PCIE, configuration of memory controller, rtc controller, lio
>> controller, and clock control.
>>
>> This patch adds a driver to manage and access global utilities block
>> for loongarch architecture Loongson-2 SoCs. Initially only reading SVR
>> and registering soc device are supported. Other guts accesses, such
>> as reading PMON configuration by default, should eventually be added
>> into this driver as well.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> 
> Looks ok to me. I can take the new driver through the SoC tree,
> so please send it to soc@kernel.org once there are no more
> remaining review comments that need to be addressed.
> 
> One last thing from my side, with that addressed, please add my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
okay, I had added it in v6.
> 
>> +config LOONGSON2_GUTS
>> +	tristate "Loongson-2 GUTS"
>> +	depends on LOONGARCH || COMPILE_TEST
>> +	select SOC_BUS
> 
> In the one-line description, please spell out GUTS, since this
> is not a generic term but apparently is something that is only
> used on Loongarch and Layerscape.
okay, I had added it in v6.
> 
> Just for clarification: is this derived from the same IP block
> that NXP are using, or is this just coincidentally named
> similarly?
Not the same IP block, it was only use this GUTS name to description
the register blocks.

Thanks
Yinbo
> 
>        Arnd
> 

