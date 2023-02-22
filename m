Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CD669EE30
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBVFKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBVFKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:10:23 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21F8D30E8D;
        Tue, 21 Feb 2023 21:10:19 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8Cxf9u3o_VjSHcDAA--.1523S3;
        Wed, 22 Feb 2023 13:10:15 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxWL22o_VjmHY4AA--.37752S3;
        Wed, 22 Feb 2023 13:10:14 +0800 (CST)
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver
 support
From:   zhuyinbo <zhuyinbo@loongson.cn>
To:     Stephen Boyd <sboyd@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yang Li <yang.lee@linux.alibaba.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, liupeibao@loongson.cn,
        loongarch@lists.linux.dev, wanghongliang@loongson.cn
References: <20221129034157.15036-1-zhuyinbo@loongson.cn>
 <20221129034157.15036-2-zhuyinbo@loongson.cn>
 <31c690a347f858a477bbba9c838984ed.sboyd@kernel.org>
 <4b5fd886-57ce-01ef-8224-432898b7fb1c@loongson.cn>
 <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org>
 <01ee3dc6-a868-fd2b-93aa-11e6bdfcc9df@loongson.cn>
 <9e8952c9415973dc7276185e3cdf5ae7.sboyd@kernel.org>
 <d92223a0-6d4c-33ea-1473-3d40bdd0ad9e@loongson.cn>
Message-ID: <834da7dc-bb5d-3427-43e5-938e40a2d180@loongson.cn>
Date:   Wed, 22 Feb 2023 13:10:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d92223a0-6d4c-33ea-1473-3d40bdd0ad9e@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxWL22o_VjmHY4AA--.37752S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zr4UJrW7tr4kAF1fJF4xWFg_yoW8uF1Upr
        ZxCay7KF4Dtr40vr1qgw4UZas0ya1ftF17Xw4ftw1DCa4qk345ur4UXFn5CF93Jr45G3y0
        qr18tw47CFyq9rJanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYnmiUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/22 上午10:02, zhuyinbo 写道:
>
> 在 2023/2/22 上午7:07, Stephen Boyd 写道:
>> Quoting zhuyinbo (2023-02-19 21:44:51)
>>> 在 2023/2/18 上午6:15, Stephen Boyd 写道:
>>>> Quoting zhuyinbo (2023-02-14 23:35:22)
>>>>> 在 2023/2/11 上午7:42, Stephen Boyd 写道:
>>>>>>> +
>>>>>>> +err:
>>>>>>> +       iounmap(loongson2_pll_base);
>>>>>>> +}
>>>>>>> +
>>>>>>> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", 
>>>>>>> loongson2_clocks_init);
>>>>>> Any reason this can't be a platform driver?
>>> Your question is that  why I don't use the platform_driver_register to
>>> register  clk and use CLK_OF_DECLARE ?
>> Yes.
>>
>>> I was  consider other clock controllers of Loongson-2 series may be
>>> different with 2k1000 and I can add a line
>>>
>>> CLK_OF_DECLARE() for compatible other platform in the future. eg.
>>>
>>> CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", 
>>> loongson2_clocks_init);
>>>
>>> +  CLK_OF_DECLARE(xxx1, xxx2,  xxx3);  // for other clock 
>>> controllers of
>>> Loongson-2 series
>>>
>>>>> For the compatible consideration of other clock controllers of
>>>>> Loongson-2 series in the future, the way of using dts can be
>>>>>
>>>>> better compatible.
>>>>>
>>>> Sorry that sentence doesn't make sense to me. The use of dts doesn't
>>>> require the use of CLK_OF_DECLARE.
>>> yes, the use of dts doesn't require the use of CLK_OF_DECLARE and can
>>> use platform_driver_register
>>>
>>> but my drvier not use platform_driver_register to register clk and use
>>> CLK_OF_DECLARE to match of_clk_init.
>> of_clk_init() is there to register clks that are needed for early init,
>> i.e. the clockevent/clocksource or the root interrupt controller
>> (irqchip). Otherwise, it isn't necessary to register clks via
>> of_clk_init().
> okay, I got it.

and,  the time driver  get clock by CCF that ask loongson2 clock driver 
use CLK_OF_DECLARE

to match of_clk_init.   because  the timer_probe  is very early and the 
timer driver was use TIMER_OF_DECLARE

to match time_probe.

