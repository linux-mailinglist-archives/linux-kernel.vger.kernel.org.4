Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7969C50B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjBTFpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBTFo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:44:57 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33E14BDFA;
        Sun, 19 Feb 2023 21:44:54 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJPzUCPNjh68CAA--.34S3;
        Mon, 20 Feb 2023 13:44:52 +0800 (CST)
Received: from [10.20.42.35] (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxjb7TCPNj1_I2AA--.39054S3;
        Mon, 20 Feb 2023 13:44:51 +0800 (CST)
Subject: Re: [PATCH v10 2/4] clk: clk-loongson2: add clock controller driver
 support
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
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <01ee3dc6-a868-fd2b-93aa-11e6bdfcc9df@loongson.cn>
Date:   Mon, 20 Feb 2023 13:44:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8332a1cf44b01f06bdd5db9dc5d7f387.sboyd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxjb7TCPNj1_I2AA--.39054S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxArykCF15Xw18GFWkKrWktFb_yoW5Gr1Dpr
        y3Zay7KF4Dtr4qvrnF934UZ3ZIvr43tF17XF4fG3WDC34qk343Zr4UXFyrCas3Aw13J3y0
        vryvgF47CF98ZFDanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bDkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64
        kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28E
        F7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14
        v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_WwCFx2IqxVCFs4IE
        7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I
        0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
        cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
        CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8FAp5UUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/18 上午6:15, Stephen Boyd 写道:
> Quoting zhuyinbo (2023-02-14 23:35:22)
>> 在 2023/2/11 上午7:42, Stephen Boyd 写道:
>>> Quoting Yinbo Zhu (2022-11-28 19:41:55)
>>>
>>>> +
>>>> +       mult = (val >> LOONGSON2_USB_FREQSCALE_SHIFT) &
>>>> +                       clk_div_mask(LOONGSON2_USB_FREQSCALE_WIDTH);
>>>> +
>>>> +       rate = parent_rate * (mult + 1);
>>>> +       do_div(rate, 8);
>>> Why is do_div() being used?
>> no expecial reason, I only want to get a result that rate divide 8.
> Ok, you can use div_u64() here and simplify.
okay, I got it.
>
>> you meaning is to use clk_parent_data to rework
>> loongson2_clk_pll_register  and drop
>>
>> loongson2_obtain_fixed_clk_hw ?
> Yes
>
>>>> +}
>>>> +
>>>> +static void __init loongson2_clocks_init(struct device_node *np)
>>>> +{
>>>> +       struct clk_hw **hws;
>>>> +       struct clk_hw_onecell_data *clk_hw_data;
>>>> +       spinlock_t loongson2_clk_lock;
>>>> +
>>>> +       loongson2_pll_base = of_iomap(np, 0);
>>>> +
>>>> +       if (!loongson2_pll_base) {
>>>> +               pr_err("clk: unable to map loongson2 clk registers\n");
>>>> +               goto err;
>>> return?
>> sorry, I don't get it.  you meaning is that  remove "goto err". Instead,
>> add a "return".
> Yes.
>
>>>> +       }
>>>> +
>>>> +       clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, LOONGSON2_CLK_END),
>>>> +                                       GFP_KERNEL);
>>>> +       if (WARN_ON(!clk_hw_data))
>>>> +               goto err;
> [...]
>>>> +
>>>> +err:
>>>> +       iounmap(loongson2_pll_base);
>>>> +}
>>>> +
>>>> +CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_init);
>>> Any reason this can't be a platform driver?

Your question is that  why I don't use the platform_driver_register to 
register  clk and use CLK_OF_DECLARE ?

I was  consider other clock controllers of Loongson-2 series may be 
different with 2k1000 and I can add a line

CLK_OF_DECLARE() for compatible other platform in the future. eg.

CLK_OF_DECLARE(loongson2_clk, "loongson,ls2k-clk", loongson2_clocks_init);

+  CLK_OF_DECLARE(xxx1, xxx2,  xxx3);  // for other clock controllers of 
Loongson-2 series

>> For the compatible consideration of other clock controllers of
>> Loongson-2 series in the future, the way of using dts can be
>>
>> better compatible.
>>
> Sorry that sentence doesn't make sense to me. The use of dts doesn't
> require the use of CLK_OF_DECLARE.

yes, the use of dts doesn't require the use of CLK_OF_DECLARE and can 
use platform_driver_register

but my drvier not use platform_driver_register to register  clk and use 
CLK_OF_DECLARE to match of_clk_init.

